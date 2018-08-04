Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE8C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 02:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AF02178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 02:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q/TPAQyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AF02178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeHDEXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 00:23:08 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:37454 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeHDEXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 00:23:08 -0400
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w742O7hT022974;
        Sat, 4 Aug 2018 11:24:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w742O7hT022974
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533349448;
        bh=Awp3oRv4RHqw10H8NcIDu6w89yTmgpxKTzY/5hXNmwQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=q/TPAQyRKpRQeOJvybNSxZnwRxcboz1spk3LJCVP2jqsEWWrFZoA9OOuZTbfsMkS9
         rzFVDqkDGReQszAeTT7aHRAbFNGlCm5nO0z/7vhVEriY0UGZvELcTG6XvZojH9PHCC
         uC05LxLnnHnGhnrgbOEH3O8X147iaJuQOOTv0icocNa3o6LlqdMkjE8lgUUfitbT3q
         8vw41kdWYNvkNOL34s5O9bSVXtMVJpw23DyiioIMkAwyIuIW4ZGevZc7k1J6gGzK+4
         Xwch11mk689AjierWHdd0SoGqkpisrDIDBKTf/s2G3zJi5fE7yyEiEfUrP6bgqrFq2
         jnqYyPYxO36gQ==
X-Nifty-SrcIP: [209.85.217.176]
Received: by mail-ua0-f176.google.com with SMTP id u11-v6so6433665uan.13;
        Fri, 03 Aug 2018 19:24:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlGnK/wdGIv2+Keg/SWpbPWSe0Vkr66OnlK9WfZH+dlg+vR4dw7m
        18HUFEeNpfNRs1hqM+hfL7W7mIF5mNswdaHQMmE=
X-Google-Smtp-Source: AAOMgpfCVO6lJ4z0oLAgOc33ssXhboPdaCZP918q+5tlyTfkH3DE3Y+jSPT92SxpbGUOdUQ9mbrRUjEWwX3oHc+eFFs=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr4439317ual.141.1533349446773;
 Fri, 03 Aug 2018 19:24:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 19:23:26 -0700 (PDT)
In-Reply-To: <861c26a6-294c-755d-2396-e5d18b9bbcbf@infradead.org>
References: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org> <861c26a6-294c-755d-2396-e5d18b9bbcbf@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 4 Aug 2018 11:23:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARdoeKCNYV7Kp6YLNsJ4rjrjXRWMsf4op58-JzRYUNVtg@mail.gmail.com>
Message-ID: <CAK7LNARdoeKCNYV7Kp6YLNsJ4rjrjXRWMsf4op58-JzRYUNVtg@mail.gmail.com>
Subject: Re: kbuild: ARCH=um archheaders failed
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-04 0:41 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 08/02/2018 05:13 PM, Randy Dunlap wrote:
>> Hi Yamada-san,
>>
>> I see this every few weeks.  It's not reproducible (it depends
>> on the moon, Mars, etc.).
>>
>> I'm using O=builddir.  The build log is short (below).
>>
>> Do you see a makefile problem here?  (nothing to do with mmotm;
>> I see it more frequently with linux-next since I do many daily
>> builds with it)
>
> BTW, this is just um defconfig with -j4.
>
> --
> ~Randy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



I will send a patch with commit description later
after more testing,
but the following patch should fix the issue.


diff --git a/arch/um/Makefile b/arch/um/Makefile
index d3975e7..1cec053 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -120,7 +120,7 @@ archheaders:
        $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
                    kbuild-file=$(HOST_DIR)/include/uapi/asm/Kbuild \
                    obj=$(HOST_DIR)/include/generated/uapi/asm
-       $(Q)$(MAKE) KBUILD_SRC= ARCH=$(HEADER_ARCH) archheaders
+       $(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) archheaders


 archprepare: include/generated/user_constants.h



-- 
Best Regards
Masahiro Yamada
