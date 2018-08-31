Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BEEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C96205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N4uzRMmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C96205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeHaNti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:49:38 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:61607 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeHaNti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:49:38 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7V9ggNQ010588;
        Fri, 31 Aug 2018 18:42:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7V9ggNQ010588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535708563;
        bh=kwnqRBs+OZKfqJ00gpwaNHG9W3str+toDOJR3V65k4E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=N4uzRMmETPtlSRO6gmbpH+VosHvWdwlGPJCEFpCxPFhRAvHuc+cNwE6+d37E4hgN3
         JJXkOQhFy60/D7RQgFx5pN+emXF9yPqDarQiHoPq9Ud28Ik72g84SiUYOvRpwIRiIj
         cW+38GXkeu+FawunieB9wE/X9mzP+ywAAjATxZFKZsq3axazGKcRsOGik/9xmBGkGa
         Q7OT+l1wnBdeS9IoxjG920RpHYo5hPnw6Oj9LI+84ql4OcIKHD21NNFQA2Q+/mn9DW
         1ka8Zw7CZrMJNFzW2nleZbpW3B3CC6uyJ6+qB5n0c2xtAqRIFx6zoEr00t/7IKKRoV
         3LinAQ4CnHwuA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id w7-v6so7715363uan.9;
        Fri, 31 Aug 2018 02:42:42 -0700 (PDT)
X-Gm-Message-State: APzg51BEt0UjjfM//nLkxkpkKWh2DI4aqBRJdNxp+ZdKGE64y2SXIZI7
        CBqfyTfJW2j3XXLBD0MaxwpcF5C6La5bccFHdGE=
X-Google-Smtp-Source: ANB0VdbgHhstuQWtTArXHr+Jqx/9u/CWtvUn0WLH6sGOiJzSa+mpwlhE+9kHUe95WVa+6rz7bhbMM23RQSFoQ3BP9ow=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr9208695uah.135.1535708561786;
 Fri, 31 Aug 2018 02:42:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5155:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 02:42:01
 -0700 (PDT)
In-Reply-To: <177f25ad-de40-ce3f-987f-ac34c2559be4@infradead.org>
References: <alpine.LRH.2.21.1808191406030.12334@math.ut.ee> <177f25ad-de40-ce3f-987f-ac34c2559be4@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 31 Aug 2018 18:42:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATOTW2mSHB_D3BcgtXPuiLGpLz_rbjgPQzCq4hCLhTfYw@mail.gmail.com>
Message-ID: <CAK7LNATOTW2mSHB_D3BcgtXPuiLGpLz_rbjgPQzCq4hCLhTfYw@mail.gmail.com>
Subject: Re: make *config regression: pkg-build
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Meelis Roos <mroos@linux.ee>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-08-20 0:37 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 08/19/2018 04:15 AM, Meelis Roos wrote:
>> Just tried to run 'make menuconfig' on v4.18-10568-g08b5fa819970 and
>> found a bad surprise:
>>
>> 'make *config' requires 'pkg-config'. Please install it.
>> make[1]: *** [scripts/kconfig/Makefile:219: scripts/kconfig/.mconf-cfg] Error 1
>>
>> This is clearly a regression - I have libncurses devele pakcage
>> installed in the default system location (as do 99%+ on actuall
>> develeopers proobably) and in this case, pkg-config is useless.
>> pkg-config is needed only when libraries and headers are installed in
>> non-default locations but it is bad to require installation of
>> pkg-config on all the machines where make menuconfig would be possibly
>> run (for example, I have a aboult 100 machine kernel testbed with
>> self-hosted kernel compilation and machine-specific kernel
>> configurations that ocassionally need tweaking).
>>
>> I notice 4.18 complained it can not find pkg-config but still worked.
>> This is clearly better than now.
>>
>> If we want to support developers with libraries in non-default
>> locations, why not - but the common case of system include path should
>> work without any trouble or warnings. For exaple, test if compilation
>> against ncurses works, and if not retry it with pkg-config (and error
>> out if it does not give working result).
>>
>
> Hi,
> This is due to my patch: 4ab3b80159d4db63b902ef635d4b5e882911b2da.
>
> Yamada-san, any ideas?  Feel free to just revert it.
>

Sorry for delay, I chose a partial revert
because I want to keep checking pkg-config for {g,x}config.

I posted a patch.


-- 
Best Regards
Masahiro Yamada
