Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B6C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B892320878
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SzCqxSad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B892320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbeGLPyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:54:13 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:59602 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeGLPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:54:13 -0400
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com [209.85.217.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6CFhtPe028164;
        Fri, 13 Jul 2018 00:43:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6CFhtPe028164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531410236;
        bh=ALwqeGJP7N8gjtwq0REIcrg168l0WQnKsNqg/Ivm6cM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=SzCqxSadI5yC45Kdm3FN1hveLtNf1lDvF9jFQc6Nzw65sKxts6evoZbQRny73nAAh
         XKyYapLjY5JR+1nZQamy52FHsxxQx3uxOaz3VKh6t/eCifIH6QRz1GxW8zvebIVwWB
         jwZQjWSgG0n+IGb/SpAe3NCDlMKRl++zarhyBQl9uyyEQK/wWk0s9FbLPheJrsqpI/
         6bKfNzioCIIusltpT5bzl+qhJy7Cn6ldE5RoEMVLBKyNee7bBbzjcbTh0uarR8KWLY
         UL8VytQfbh0MgVIrQa0gJ/QWJRCTlOoUnHahWf7yWgUXRoYyczS6n3yojrNLd2O2l4
         j6AD0OIXMlXsQ==
X-Nifty-SrcIP: [209.85.217.169]
Received: by mail-ua0-f169.google.com with SMTP id i4-v6so11833044uak.0;
        Thu, 12 Jul 2018 08:43:56 -0700 (PDT)
X-Gm-Message-State: AOUpUlFllkTVAbvCI3M8vMvbzskfwL5qp7BRAV11U1vBgf7IVmkrQGG4
        gb1J3tt7rE8hwwt+lb2QDAH2XxRraCRspvFUvhI=
X-Google-Smtp-Source: AAOMgpdsgsymCAodwXpcdUXT4f3tp4X5shgCfStIKOVH6j2qyWeAD8GO+GIxUWNPAsUHyejCv0oIXDbGUTrPc0U8AqA=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr1760299uad.82.1531410235066;
 Thu, 12 Jul 2018 08:43:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 08:43:14
 -0700 (PDT)
In-Reply-To: <20180710073854.GB7671@krava>
References: <20180710004602.21599-1-labbott@redhat.com> <20180710004602.21599-3-labbott@redhat.com>
 <20180710073854.GB7671@krava>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 13 Jul 2018 00:43:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4R=__KLaoEWnuYe2CGuB3DDivJq2AUCLLD+Xgggy5PQ@mail.gmail.com>
Message-ID: <CAK7LNAT4R=__KLaoEWnuYe2CGuB3DDivJq2AUCLLD+Xgggy5PQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] tools: build: Use HOSTLDFLAGS with fixdep
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-10 16:38 GMT+09:00 Jiri Olsa <jolsa@redhat.com>:
> On Mon, Jul 09, 2018 at 05:45:57PM -0700, Laura Abbott wrote:
>> The final link of fixdep uses LDFLAGS but not the existing HOSTLDFLAGS.
>> Fix this.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>


Applied to linux-kbuild/fixes. Thanks!

> thanks,
> jirka
>
>> ---
>> v2: Switch to just using HOSTLDFLAGS instead of both LDFLAGS and
>> HOSTLDFLAGS.
>> ---
>>  tools/build/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/build/Makefile b/tools/build/Makefile
>> index 5eb4b5ad79cb..5edf65e684ab 100644
>> --- a/tools/build/Makefile
>> +++ b/tools/build/Makefile
>> @@ -43,7 +43,7 @@ $(OUTPUT)fixdep-in.o: FORCE
>>       $(Q)$(MAKE) $(build)=fixdep
>>
>>  $(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
>> -     $(QUIET_LINK)$(HOSTCC) $(LDFLAGS) -o $@ $<
>> +     $(QUIET_LINK)$(HOSTCC) $(HOSTLDFLAGS) -o $@ $<
>>
>>  FORCE:
>>
>> --
>> 2.17.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
