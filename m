Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC96EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B7121475
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhFNGF5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B7121475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbeHPEni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:43:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44711 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbeHPEnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:43:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so1256539pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 18:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oy21jdKTHgYwG8b4Tiow2lU1qxpxGK1N2y20CSBhSuw=;
        b=VhFNGF5yNorazlLv/mO4bb2LD/ybulScFN3F3R+PiT9/CwrLQTbh6szUqKv5DCsB/7
         Wi61ViilHqScJ0lMsdGY9PIpqdb1W+eCW01EuePKHtelWOy2/rVX85w3UkegGmy9ve2k
         fB1pFAbiTiC+c/3BgsAbQPov7UiXWzJHGeOlC2BMLXodtalvamTEYAkh3rnsgUoNp0yY
         3/MRpZdJ62afrrZauDswEY9V30WCqJc4x+nccf+bdGD83ginyXNa5MRgV8GkfjtLBz8G
         jqai8n3khm+UYZ5MFxLpF4YIHaAG0S60c+dXsgt1OPvaCa9X0K5A+WpftkoEFrkfmr3p
         K9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oy21jdKTHgYwG8b4Tiow2lU1qxpxGK1N2y20CSBhSuw=;
        b=lV9pSeEPo53Nca6TeyHqyosScNRSkXBDouZi4w+nAt7avB6u+4UgOafMm2ZoWNvQOp
         nAwXqm3pUe99mAJJxtp6Vy6efI8gDEzODf2B4kBQUIrBvjMYjfcIQK4DACTNrWZD4E6c
         Pquw2csx28dxQw1rjj9F5uhbNjEdEb3+/xZj3pxn9Mlf0Cd2TouazXOIChCs9yYXd6jr
         q+XpDekaJFqEzz3gJzIXyL/QiijS2xYUxfFV3YkwSE20fIhx/lVjm+tqFcK7bMzdmJCI
         y4HAzXnKZOC/Tc2CwMZTk6u4k1KTZOgY9dwcBeznwLeREsl+X7tmMYCiCYecgG/EsFR5
         LRYA==
X-Gm-Message-State: AOUpUlF4a2ufX8rRkZKZQIJ/ZEo159CBcApJNw50Ga9sTBGoF08AxNJi
        fWdWL9TeVrHghm6DAHaJV/8=
X-Google-Smtp-Source: AA+uWPxu2V6cAF2FhaLXM8gN1pHx9FZAGhAeEMiV+oNXtkQIr3J9N9rNiXRlgvztxChHJfnLY4KK6w==
X-Received: by 2002:a63:1a49:: with SMTP id a9-v6mr27891460pgm.423.1534384120071;
        Wed, 15 Aug 2018 18:48:40 -0700 (PDT)
Received: from localhost ([39.7.50.150])
        by smtp.gmail.com with ESMTPSA id a17-v6sm35721905pfg.106.2018.08.15.18.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 18:48:38 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:48:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Kalauskas <peskal@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zram: fix bug storing backing_dev
Message-ID: <20180816014835.GA2793@jagdpanzerIV>
References: <20180808223100.225086-1-peskal@google.com>
 <20180813061623.GC64836@rodete-desktop-imager.corp.google.com>
 <20180813073825.GA1062@jagdpanzerIV>
 <20180814164523.e0fdeed962917e23062ef958@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814164523.e0fdeed962917e23062ef958@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/14/18 16:45), Andrew Morton wrote:
> > 
> > > > -	strlcpy(file_name, buf, len);
> > 
> > This is quite interesting. The reason it worked before was the fact that
> > strlcpy() copies 'len - 1' bytes, which is strlen(buf) - 1 in our case,
> > so it accidentally didn't copy the trailing new line symbol. Which also
> > means that "echo -n /dev/sdX" most likely was broken.
> > 
> 
> I can't find the original email on lkml for some reason, but I
> recreated the patch.

Neither can I.

> The changelog doesn't describe the end-user impact of the bug, which is
> very desirable when tagging a patch for -stable backporting.  Can we
> have that paragraph please?

The problem is that strlcpy() copies as many bytes as the source string
has, not as many bytes as destination string can fit.

IOW:

	char dst[100];
	char src[1000];
	...
	strlcpy(dst, src, strlen(src));

where it should do

	strlcpy(dst, src, strlen(dst));


> The implementation might be able to use strim() somehow.

strim() trims white-spaces. What we have here is a trailing new line symbol,
which echo appends to the string it writes to the kernel [echo -n switch
disables it]. So we receive a "/dev/name\n" device name from sysfs, which we
unsuccessfully try to open(). To make it all work we need to remove that
trailing new line.

A side note,
There is sysfs_strcmp(), which takes care of that "user space may append
a new line to the string" case, I wonder if we should finally have
sysfs_strcpy(), which would not copy the trailing new line. I think this
"if string[sz - 1] == '\n' then string[sz - 1] == 0x00" is quite common.

	-ss
