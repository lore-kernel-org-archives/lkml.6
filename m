Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0232DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BE1208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cG6Qqx+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BE1208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbeHWMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:33:00 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:45604 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeHWMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:32:59 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7N940Cx029694;
        Thu, 23 Aug 2018 18:04:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7N940Cx029694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535015041;
        bh=FeQSIbNiDZqBY3Zeo4RoUbPMtc42oPWta3o3qLUBog4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cG6Qqx+i2tIz3YXT7hfy3+XD3/+0kyeiI2CAcBPqRSLq7g67yS7N0IgICN5U34LN1
         EQLpbborARuQxYAPUi4jLtH1dudn7v8z72f4y5MZWozRrw+hNC7AVoIN6SeEN3gF0Z
         oAciTVhA4ybPN3hM4fBW2gE+/0l8lGYFhDZnVw/0AVegTlPSWkO9qz8A0hpWN49oUP
         m7WhalDM8oCsvnAqnEkWSMC5T26HH7HwoPP8AnFkm+mZDWz5g2lvccbXu3s/OXd3w1
         NFgtJ7VAL51X3IXOYaICC+DOHPLsAt/bJa4eRLoW/FeN5VK+RwAK+3jUWOExMvW9Pt
         u6VMf+kmSIFlg==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id f4-v6so2774143uao.10;
        Thu, 23 Aug 2018 02:04:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlEjeOLu1ybttLH6lWwv2VWZs4/bnw/2hdU/0MBf/wNbUmLIpf9Y
        V/FhImjok8phgL+LEzscbCTR6I5jOODwpiiL3Kw=
X-Google-Smtp-Source: AA+uWPzvRlgIcEF56Mnuv6Qj6gatJPKNQ5YPCfzLt7EaWh73tA1ehH6jkmANXGmJQKS6mi5OF4ABosSc+UJVYE5Vb3g=
X-Received: by 2002:ab0:14b3:: with SMTP id d48-v6mr40004964uae.88.1535015040449;
 Thu, 23 Aug 2018 02:04:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 02:03:19
 -0700 (PDT)
In-Reply-To: <20180823083552.6fd372af@canb.auug.org.au>
References: <20180823083552.6fd372af@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 23 Aug 2018 18:03:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAShQCMvwo-s2hDy4AkJs4=gvpa7hR22s2hC969dRkaV-w@mail.gmail.com>
Message-ID: <CAK7LNAShQCMvwo-s2hDy4AkJs4=gvpa7hR22s2hC969dRkaV-w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

2018-08-23 7:35 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Masahiro,
>
> After merging the kbuild tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> ld: failed to merge target specific data of file drivers/input/mouse/alps.o
> ld: drivers/input/mouse/byd.o: compiled for a big endian system and target is little endian
> ld: failed to merge target specific data of file drivers/input/mouse/byd.o
>
> and many, many more like this.
>
> Sorry, I can't easily tell what caused this.
>
> I have used the kbuild tree from next-20180822 for today.



Sorry, will fix.

I missed to change link-vmlinux.sh




diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 4bf811c..c8cf453 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -75,7 +75,7 @@ modpost_link()
                ${KBUILD_VMLINUX_LIBS}                          \
                --end-group"

-       ${LD} ${LDFLAGS} -r -o ${1} ${objects}
+       ${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${objects}
 }

 # Link of vmlinux
@@ -95,7 +95,7 @@ vmlinux_link()
                        --end-group                             \
                        ${1}"

-               ${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}     \
+               ${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}      \
                        -T ${lds} ${objects}
        else
                objects="-Wl,--whole-archive                    \



-- 
Best Regards
Masahiro Yamada
