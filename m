Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD5C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0F4213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="THRXyBqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0F4213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389291AbeGKVTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:19:17 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45489 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732761AbeGKVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:19:17 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so25699195ioh.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QqsBKA492WZbnLzTtBFVcG1z3LD3mNtjsx28cqG9s1Y=;
        b=THRXyBqu5RvyIHJHVGc4ioeL4evM8Bn+UioEjbNBJcaQ1KlZJvbZo+IBvIL/EeI+ml
         0bhDOUJo7y45MybqAwuLw0EFTzjR7UpT5GM9/8y1IgHgfVL4PDWQt/96cgeY09VeTzI/
         E/kTII1+kcmm28KcGQlQ+eaNqDLP/BiXX3a8kapB8Aj6Q9JEwmeu9rluzF8qmFVYlYBo
         pY3nDu/PjZDmiMU9dPva7IM5lIFzc+VEOHmbgsdagCw/jaf8lMQ4HsYSMAX8AkKlBKtn
         Fpxa3GIRofEeuyq4bALSiITAWxVA/UasBrR1X05BMfzI9At+9bnpwUEOgC0Uz4VYBpeS
         phLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QqsBKA492WZbnLzTtBFVcG1z3LD3mNtjsx28cqG9s1Y=;
        b=E6x2CFTn86LirO4iUDLmnvdd5y7xnqDRS4ft4kWotSJRDJbSk8kD19mvbdHA/3ccbL
         TvjGHOqUljH1vzjIUsOTFM1CHqe4xHw5IcZ+TZFjghkt2KVmJhcBjwoS8HPU0+aWvEEd
         goC8P0xOaG23yPGsSHIUO1zAgLz7jNvjlksQHCz2yQnT5aGLe++l4eXU5vFeYrUHnn2v
         v+DrKU12c2hh9aSxUqegpM2/tnL5BU2lferPqodXfkgY7NgB3D/bx9scnuDChDFNeHPz
         FAH6kL8Y0Nrfcb3moQ0Bz+qsFS3XdCwUmp9ELTJOh50Q/IU2/dPAya6w3kcdu/7uTHSy
         i/hQ==
X-Gm-Message-State: AOUpUlGy6+4MrHS6tDK+rPcCQB1fuhe2Yxn1Rg9COH162JhBzj2UO865
        KcqSRp0zIKNsUErFuEvjGOgS9g==
X-Google-Smtp-Source: AAOMgpf6+ePDHycBAQbqH511/AzGxJKI+lAXYhpPRmiDN31dEs7T/ke/1YPRZ2ZhV0xpE1LAa1NZ0A==
X-Received: by 2002:a6b:16c7:: with SMTP id 190-v6mr19912374iow.281.1531343583547;
        Wed, 11 Jul 2018 14:13:03 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id v199-v6sm1700228itb.18.2018.07.11.14.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 14:13:02 -0700 (PDT)
Subject: Re: [PATCH 02/12] blk: use for_each_if
To:     Daniel Vetter <daniel.vetter@ffwll.ch>, Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
 <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com>
 <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
 <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
 <85df8c40-dac9-5f97-f81a-6de061cfdfa8@kernel.dk>
 <20180711200641.GJ72677@devbig577.frc2.facebook.com>
 <CAKMK7uGBWwbuSr7k83w0JAQ9bUKYvreYCJpBwpEqcUe3DZVrrQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5bacce40-d29d-8eaf-f3bb-2ac2889bbeb0@kernel.dk>
Date:   Wed, 11 Jul 2018 15:13:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGBWwbuSr7k83w0JAQ9bUKYvreYCJpBwpEqcUe3DZVrrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/18 3:08 PM, Daniel Vetter wrote:
> On Wed, Jul 11, 2018 at 10:06 PM, Tejun Heo <tj@kernel.org> wrote:
>> On Wed, Jul 11, 2018 at 01:31:51PM -0600, Jens Axboe wrote:
>>> I don't think there's a git easy way of sending it out outside of
>>> just ensuring that everybody is CC'ed on everything. I don't mind
>>> that at all. I don't subscribe to lkml, and the patches weren't
>>> sent to linux-block. Hence all I see is this stand-alone patch,
>>> and logic would dictate that it's stand-alone (but it isn't).
> 
> Hm yeah I forgot to add linux-block. But others where there's no
> dedicated list (or get_maintainers.pl didn't have one) also complained
> about not getting Cc'ed, and I can't Cc everyone for sweeping changes.

I don't personally see a problem with just CC'ing everyone.

>> What I sometimes do is including a short blurb on each patch giving
>> the overview and action hints (e.g. this is part of patchset doing XYZ
>> and should be routed such and such).  It's a bit redundant but has
>> worked pretty well for patchsets with dependenat & sweeping changes.
> 
> Yeah I guess I can just copypaste/summarize patch 1 to all the
> subsequent patches, sounds like the best option.

Another approach might be to submit the first independent patch
separately. Once that's in the kernel, you can send out the rest
as independent patches instead of doing a cross-kernel series that
all depend on one single patch. Seems to me that's where you run
into issues, and it can be avoided quite easily.

-- 
Jens Axboe

