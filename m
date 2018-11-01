Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26AAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ED320821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qN+vIOxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46ED320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeKAJEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:04:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKAJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:04:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id n5-v6so18320007wrw.12;
        Wed, 31 Oct 2018 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Wv+MO9Spf3wRZJ+bqfZEPx2065LxAc4GhgxiCLZ5pE=;
        b=qN+vIOxBl2AqfiImVtLNQ39ti9Li4fPr3sXlN6Z0QgBNpwbJdMSHmYPC4gSWky75ij
         fUqA45TsbOukdsJ9OIXUpEU2jNtr4b0W7J3Kkqc2cUkGX+7i6k2fn/KidfAdTujv3gYP
         BF6QpBL8XinY/SXGkdzSHKCiyMSWyLeBG/U1QMs7O++Ez1hvnKfYIKHJw2iKhngaVD3q
         rz/rwCSX60dq7CfXVAa51pjfthzmI6IRvYY22xLATA/Ucz/dFttZYFyv+64SwQoQmoDi
         eHKx0eHL4F0mN8S7pzDR2yldQHKGnD3PkykpME50Ge+lX0lzCXuvNyrODCYohuFQaKII
         Hnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Wv+MO9Spf3wRZJ+bqfZEPx2065LxAc4GhgxiCLZ5pE=;
        b=Rbq67bfGUmWGQfqAu0fXljgIxN/oGH6Js58G3LRgYPE2Qgn+ZQy4uwT7fLRBPAZ/U8
         2wcsCCSdN31zdc8c3KMPcwEiVeG4s1y8r1fW6G2ecqyMUgO4yYv8e1/IMA3v7qJrTdvp
         w56jwj9zezOlKg1eu/R24IHZ7XQa9S8rsvL2s4k9eZG8d3ULlg6sfMTGxStO8qGNiwWR
         qLsQTHTIvoOa1wgddAQ3nS0fiUxRbNnHyUKIwoHzLnwxsIAG1jjVPJTfKRK80T91Ncw5
         2yAFr4ogPPdhJMxZl5Bcb/8Z50jVEWudKRKik+o95o8TgAVd3bEsZEONr43kicLLYPBF
         eumA==
X-Gm-Message-State: AGRZ1gK60PWQ3NQwqNQvjl3/jXAOWnHGZho6lFBP1GaP1gtVUuDslXJv
        anpEjRUsNofVGxJFSbSDiQFuYXXm+rE=
X-Google-Smtp-Source: AJdET5eQySjn6PeN0ClWLYiPmgHR6N9rNSyrRnbsRcENA2dkDrKyX4nTY81wNkUA2d3cf0Pn66hTjQ==
X-Received: by 2002:adf:8909:: with SMTP id s9-v6mr4583715wrs.309.1541030620791;
        Wed, 31 Oct 2018 17:03:40 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c184-v6sm14515876wma.15.2018.10.31.17.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 17:03:40 -0700 (PDT)
Date:   Wed, 31 Oct 2018 17:03:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
Message-ID: <20181101000338.GA32577@flashbox>
References: <20180925061855.19557-1-natechancellor@gmail.com>
 <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
 <20180925161459.GA15840@flashbox>
 <CAKwvOdkh0rqWcw4r7Y=Ki_MNJPoJNnvm3uGp4Q726PaESxZAnQ@mail.gmail.com>
 <20181025210456.GA14792@flashbox>
 <CACRpkda9LhdQybgci8gYs13L5pHWvDx43_Ftn5s+ERLLFPvLjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda9LhdQybgci8gYs13L5pHWvDx43_Ftn5s+ERLLFPvLjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:33:24PM +0100, Linus Walleij wrote:
> On Thu, Oct 25, 2018 at 11:04 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> 
> > In my opinion, there are enough of these warnings to warrant changing
> > the type of param globally (arm64 allyesconfig):
> 
> Yeah as it is from the compiler, sure we need to get rid of it.
> 
> > Linus, did you have any other objections to this patch given my
> > reasoning in these past couple of emails or would you like me to try
> > adding explicit casts to all of these call sites?
> 
> I would favor the model to:
> 
> 1. Replace all occurences of enum pin_config_param with unsigned
>    int.
> 

Given that there are 57 files with this definition and some include it
multiple time, this doesn't seem super reasonable in my opinion.

> 2. Replace the whole definition of enum pin_config_param with
>    #define PIN_CONFIG_BIAS_BUS_HOLD 0
>    #define PIN_CONFIG_BIAS_DISABLE 1
>    etc etc.
> 
> I think it is not a good idea to try to do both at the same time.
> 
> A slightly lesser evil variant is to add a few PIN_CONFIG_CUSTOM_1
> PIN_CONFIG_CUSTOM_2 etc at the end of the enum and just
> #define MY_CONFIG PIN_CONFIG_CUSTOM_1
> in all drivers that use these.
> 

Some drivers actually just define their pin config params like:

#define VAR (PIN_CONFIG_END + 1)

In fact, more drivers do that than not. I will go ahead and draft some
patches tonight and send them out tonight to see what driver authors
think.

Example with drivers/pinctrl/sprd/pinctrl-sprd.c

================================================

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 4537b5453996..7d9a44bd0047 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -159,10 +159,8 @@ struct sprd_pinctrl {
        struct sprd_pinctrl_soc_info *info;
 };
 
-enum sprd_pinconf_params {
-       SPRD_PIN_CONFIG_CONTROL = PIN_CONFIG_END + 1,
-       SPRD_PIN_CONFIG_SLEEP_MODE = PIN_CONFIG_END + 2,
-};
+#define SPRD_PIN_CONFIG_CONTROL                (PIN_CONFIG_END + 1)
+#define SPRD_PIN_CONFIG_SLEEP_MODE     (PIN_CONFIG_END + 2)
 
 static int sprd_pinctrl_get_id_by_name(struct sprd_pinctrl *sprd_pctl,
                                       const char *name)

> Yours,
> Linus Walleij

Thank you for the reply and advice!
Nathan
