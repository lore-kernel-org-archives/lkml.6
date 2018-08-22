Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6A02083A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK9CSpXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6A02083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeHVIVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 04:21:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46745 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeHVIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 04:21:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id a4-v6so333405plm.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 21:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvVlNjjev7e1a2EkKES9kW8PruHvnQCFRaLKzejH+rs=;
        b=XK9CSpXJp0gdfRmKyDnFI687LOYq/famqdzxlZHG4J97RjEDj31DtJ+XQjBcJ8D6YR
         zKOl028/PZe0iz6+3lUfcFdpwbUttF/RIjifD+ECS6dGmXjigtHMuN/gLFR32vdBP1f3
         6meavVCbaPjL7UZ1mS+6CymybDuThk+wJCBb8VQOc0CvsqJhYq6AaOZjT5f85ZBUStou
         inTa/r33U7smcKXDJ2qs2vBp0cXj/8QowU/n0JQfGpFLhirAI9qgcEH84316b9+tyPtc
         RmepGZ0tGrPHfyN0G7y+9veveT+8neXWQQRY0WS48KThyOzeuCgJX5XaRRGW9XTetH9B
         jRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvVlNjjev7e1a2EkKES9kW8PruHvnQCFRaLKzejH+rs=;
        b=be0KWlVfNCFPt6TTmeEWNGh2H36e9zWQ+6Ipe4bBRCIKPlM0mUrNxtEjiMVCAZfShF
         65W2JSdBcBJnaWK4TU9y2nakJZ59NP9Fgz+Dd80QuVbfPFtaCMHj8c4mUVz2kA9tPqe/
         uCwWrJQLBbt1dvc/EAYGOfs8AxZubu+KxNoPTApSIM9QOvQxNt5v9oCUkWKa2y+3dpT3
         7/HH1bTcsPWitkeTIkFiIAdFSEIQESdXigc1EQC+zfh/LBONv0amvxC1tUjrKW4PE7vN
         pzjjTkctz0HesGRCQJoTgRd8JUM46CKd7q5HX29bnyRcOD4pkztyMhg6ypvCnf45y4Ag
         ggBA==
X-Gm-Message-State: AOUpUlGcTs4NOuf9ZDhlrqm4rvKquIyGRRrGQWVxMWA8SRpZiuvOA6G/
        SUPpD7SWj0N1LnieRTX/3BXfZPeN
X-Google-Smtp-Source: AA+uWPzDlLp94p2H4/VGH5JjnD3dmUMryEjjKAO0Lq3HnbQGy3gW2I+KesTATX6bkDCnN+xj2DJngg==
X-Received: by 2002:a17:902:e3:: with SMTP id a90-v6mr28821758pla.227.1534913907799;
        Tue, 21 Aug 2018 21:58:27 -0700 (PDT)
Received: from localhost ([175.223.33.48])
        by smtp.gmail.com with ESMTPSA id j16-v6sm1047036pfk.125.2018.08.21.21.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 21:58:26 -0700 (PDT)
Date:   Wed, 22 Aug 2018 13:58:23 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
Message-ID: <20180822045823.GA6876@jagdpanzerIV>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
 <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
 <20180821095055.GA400@jagdpanzerIV>
 <20180821135734.GA19916@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821135734.GA19916@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On (08/21/18 15:57), Greg Kroah-Hartman wrote:
> > I think that sysfs input is always properly NULL-terminated. It may or
> > may not contain \n, but \0 is expected to be there. Am I wrong?
> 
> sysfs data is always null terminated.
> 
> What exactly are you trying to do here?  If a user sends you crappy data
> in a sysfs file (like leading or trailing whitespace), well, you can
> always just error out, no problem.

So what we are thinking about is sort of clean up / unification of the
way ->store() callbacks handle sysfs input. They all have to do the
same things for "corner case" handling and many of them forget to handle
some specific cases; or have to come up with extra code; or are not aware
of the existing API; etc.

For instance, let's look at 325c4b3b81027068 [well, a small part of]

---

@@ -245,7 +239,7 @@ static ssize_t pm_qos_resume_latency_store(struct device *dev,
 
                if (value == 0)
                        value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
-       } else if (!strcmp(buf, "n/a") || !strcmp(buf, "n/a\n")) {
+       } else if (sysfs_streq(buf, "n/a")) {
                value = 0;
        } else {
                return -EINVAL;
@@ -285,9 +279,9 @@ static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
                if (value < 0)
                        return -EINVAL;
        } else {
-               if (!strcmp(buf, "auto") || !strcmp(buf, "auto\n"))
+               if (sysfs_streq(buf, "auto"))
                        value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
-               else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))
+               else if (sysfs_streq(buf, "any"))
                        value = PM_QOS_LATENCY_ANY;
                else
                        return -EINVAL;
@@ -342,20 +336,12 @@ static ssize_t
 wake_store(struct device * dev, struct device_attribute *attr,
        const char * buf, size_t n)
 {
-       char *cp;
-       int len = n;
-
        if (!device_can_wakeup(dev))
                return -EINVAL;
 
-       cp = memchr(buf, '\n', n);
-       if (cp)
-               len = cp - buf;
-       if (len == sizeof _enabled - 1
-                       && strncmp(buf, _enabled, sizeof _enabled - 1) == 0)
+       if (sysfs_streq(buf, _enabled))
                device_set_wakeup_enable(dev, 1);
-       else if (len == sizeof _disabled - 1
-                       && strncmp(buf, _disabled, sizeof _disabled - 1) == 0)
+       else if (sysfs_streq(buf, _disabled))
                device_set_wakeup_enable(dev, 0);
        else
                return -EINVAL;
---

There was quite a bit of code. But these things still can and do happen;
Andy tweaked the existing code only.

So what we are looking at is a way which would let us to make that part
of drivers to be simpler and less fragile, perhaps.

> Please always post a user of your new api when you make stuff like this
> otherwise we do not know how it is used, or even why you are adding it.

Sure, I agree. There is no API proposal yet; so I gave a simple example
in the commit message and didn't bother to convert any of the existing
users.

I'm not even sure yet if we want to have a new API. The sort of a
root cause [it seems so] here is that sysfs input data has irregular
format. That's why we have irregular handling of

Either in a form of

		if (!strcmp(buf, "auto") || !strcmp(buf, "auto\n"))
			...
or in a form of

		if (sz > 0 && value[sz - 1] == '\n')
			value[sz - 1] = 0x00;
		if (!strcmp(value, "auto"))

and so on.

So may be, instead of new API which was meant to help make sysfs data
look uniform, we can do tweaks to sysfs and pass to ->store() callbacks
data which already has no trailing newline and whitespaces. IOW, make it
uniform within sysfs. Then we can remove a bunch of code from the existing
drivers and make it easier for future drivers.
So sysfs could do strim-ing, etc. and ->store() would always receive data
which can be directly used as strcmp/strcpy/etc input. Because this is what
people want to do after all; but they learn at some point that they can't
and there are newline symbols, etc. to take care of.

What do you think? A new API is probably safer option here; but then,
again, people can forget to use it, or be unaware of it.

	-ss
