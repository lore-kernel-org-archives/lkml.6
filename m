Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4ADC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FE72082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CbQaJOA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FE72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeKDINm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:13:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeKDINm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9EM5J2HHa2KYXzkEC8W9Yhcnrf2tEL4N0V+xdMn8jD8=; b=CbQaJOA1toudAU5J2Li9jjZMUB
        icXznVd9O9RSeUGDvffjdrkVvIwShvo+/9aKBuOLqiUqrVHy51YLZJBlbRKfXIIbx/M45CYmgx7AJ
        oCazEtTX4YdWljNzIl0jZ76kPCrHIKv5kE+jUURt1CD3DsFFF9+TEIyXgiAQ2UYrZ9RzXqXmW/sEx
        EJ4VVnztDGQjbkwPbeT+KbU0dlFtFWDKkDdZdW8PQpLLXg58dHYoZiA34TBfZx/Vz9jxusGow+Spp
        0HYL3VKLuU9XPccQkxD1rrWwBFfdA8Yt9BWLSlIestgOkpoyPP4UfGRdvlhmRgkM9zUWiamOI1gtS
        uxpxRSeQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJ4uW-0001yN-Ae; Sat, 03 Nov 2018 23:00:56 +0000
Subject: Re: linux-next: Tree for Nov 2 (compiler-gcc.h)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wolfgang Rohdewald <wolfgang@rohdewald.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <20181102143018.09feb051@canb.auug.org.au>
 <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
 <20181103002218.3bd015b3@canb.auug.org.au>
 <CANiq72=kHErmujzMgM4akXeoWkSR0Q3VLd-6Mwiaj5mGan8yZw@mail.gmail.com>
 <20227164-2ef3-d684-bf4e-fb69ac828789@infradead.org>
 <CANiq72kBx4+R4SVFZ_iTfk61=oHMLwvhHdmBDe=cBFP5Lp7bSQ@mail.gmail.com>
 <6ecaed34-eb66-24ed-e6c7-e33f9583be5e@infradead.org>
 <CANiq72mqO36FotJ6pHQpAB18DLEYV+kSL64Sc+A6yoqDu47bAg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <36ee26a8-af2a-823a-1aa0-f5531c612ff7@infradead.org>
Date:   Sat, 3 Nov 2018 16:00:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANiq72mqO36FotJ6pHQpAB18DLEYV+kSL64Sc+A6yoqDu47bAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/18 3:58 PM, Miguel Ojeda wrote:
> On Sat, Nov 3, 2018 at 5:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> No plugins are enabled.
>> The failing randconfig file (for x86_64) is attached.
> 
> Confirmed with a built-from-sources 4.8.5 on current master
> (d2ff0ff2c23f). The ICE also happens with 4.6.4. With 8.1.0, however,
> we get an error instead:
> 
> In file included from drivers/media/usb/dvb-usb/pctv452e.c:20:
> drivers/media/usb/dvb-usb/pctv452e.c: In function 'pctv452e_frontend_attach':
> ./drivers/media/dvb-frontends/stb0899_drv.h:151:36: error: weak
> declaration of 'stb0899_attach' being applied to a already existing,
> static definition
>  static inline struct dvb_frontend *stb0899_attach(struct
> stb0899_config *config,
>                                     ^~~~~~~~~~~~~~
> 
> Which seems to have been spotted by kbuild months ago:
> 
>   https://lkml.org/lkml/2018/3/10/358
> 
> The problem is in pctv452e_frontend_attach():
> 
> /*
> * dvb_frontend will call dvb_detach for both stb0899_detach
> * and stb0899_release but we only do dvb_attach(stb0899_attach).
> * Increment the module refcount instead.
> */
> symbol_get(stb0899_attach);
> 
> Here symbol_get() is declaring a weak function (due to
> !CONFIG_MODULES) while this definition in stb0899_drv.h occurs (due to
> !CONFIG_DVB_STB0899):
> 
> static inline struct dvb_frontend *stb0899_attach(struct stb0899_config *config,
>   struct i2c_adapter *i2c)
> {
> printk(KERN_WARNING "%s: Driver disabled by Kconfig\n", __func__);
> return NULL;
> }
> 
> I guess pctv452e should require CONFIG_DVB_STB0899, or similar. CC'ing
> Mauro, Wolfgang, linux-media.
> 
> Hope that helps!

Thanks for digging into this.  :)

cheers.
-- 
~Randy
