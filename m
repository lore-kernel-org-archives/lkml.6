Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4DFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E73D20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/FcGvDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E73D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbeGKPos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:44:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36087 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732913AbeGKPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:44:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so18654016pfh.3;
        Wed, 11 Jul 2018 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3SXRgY1UlJ8EE62er2bZv+8jR1nc+ThiHEobV/1zD0=;
        b=V/FcGvDDg8dAUKci9VKt7LBVBZ/6unbzL6Reu/ccuikxfndvriyI/FKBbyhc2yk8EO
         4BcJes0Ai+3a1q6x/TFxPAz4pO5KQ/idBKxOBQGDScCS5ZC9BKIXZeMqVCjZg/83Q6G+
         UM5ul09HVE/87K1NR2m3FfAnHoxfP1EeLy3dQMvTk/7j+NUirX0JFEW4LPyZVAsC/WtE
         Xl+0bVatH/yoVDXK6IfYxiNcaILvt4c7ooHMT2sTLRU3KeiyUqBeHXkHM1dMz96vFwMJ
         uuNIf3Ga3C+8/V1t0fv4Xu0owIh0ZUotcyxgk1IvR3FP/0CwEQO0UTeSmSvbsvKXy+5T
         JMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3SXRgY1UlJ8EE62er2bZv+8jR1nc+ThiHEobV/1zD0=;
        b=MEGmKMDYzFm8jDSerD5FNoMPqJK+gFm2567abaliYCLWCgKPr6Cmnr75xeXIO9rxCD
         NUeVvhWcWXYkjyo5n7Z65jYvFqqYYP/PQprhyC4f2TgEVqICvdE+/TxLB1W8YWkZHYkW
         rsKtyuwqyaozNBdG1eYNkOrMs6AryxrUk3hNGTCQIqMVNR9aBkNoV+DbCXfV2fGPMHcV
         CtpYAYCsFazEW+sgmVMB6JSLCfCRHZWgnpDjuX/UUZLpmV1kCXI7UnUycpktN20tmKln
         3gLkRi3qeouuWWHuLNshAu4aVxDdDj0Fz3NkrKYlflo/qsLzOwMcuwKIuoj3Uy2wM0ZR
         2HqQ==
X-Gm-Message-State: APt69E2KOp8eRa1ACqSiZ8VIXg2GItMyBW9EgWBsRujq30le/2gJTYWP
        dkP1W6fem6fs2S+vwWjAxlM9ww==
X-Google-Smtp-Source: AAOMgpc5D/+PIzuipX+lkGv1urSS9LPKSnyN3cc82JWjy9VM6EYueBsblbuuW/BGmTqoceTSaLEL0A==
X-Received: by 2002:a62:d693:: with SMTP id a19-v6mr30342725pfl.248.1531323594152;
        Wed, 11 Jul 2018 08:39:54 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z123-v6sm32342700pfz.16.2018.07.11.08.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 08:39:52 -0700 (PDT)
Date:   Wed, 11 Jul 2018 08:39:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
Message-ID: <20180711153950.GA19932@roeck-us.net>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
 <20180710213557.GC27827@roeck-us.net>
 <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
 <3868f0c7-e45e-d3b4-5365-12a6a0646f6f@roeck-us.net>
 <20180711153015.GA10578@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711153015.GA10578@e107155-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:30:16PM +0100, Sudeep Holla wrote:
> On Wed, Jul 11, 2018 at 06:47:49AM -0700, Guenter Roeck wrote:
> > On 07/11/2018 06:22 AM, Srinath Mannam wrote:
> > >Hi Guenter,
> > >
> > >Thank you very much for all the help with your feedback and review
> > >comments to complete the changes very fast.
> > >
> > >About the documentation..
> > >I have gone through few similar patches available in the kernel are
> > >listed in the mail of previous version.
> > >No documentation available in Linux for the properties used in those
> > >patches also.
> >
> > " No documentation available _in Linux_"
> >
> > Emphasis mine. Yes, I noticed this as well. I was asking for a reference
> > to documentation _outside_ Linux. Sorry for not being more specific.
> 
> Typically new properties needs to registered or discussed in dsd@acpica.org
> Though there's almost no activity on that list for more than a year now.
> IIRC, the thread[1] gives kind of agreement that was reached after
> elaborate discussion on _DSD properties.
> 

I think you are saying that there are no real rules or governing body
for _DSD properties, that _DSD properties are free for all, subject to no
scrutiny, that a database with assigned _DSD properties does not exist,
and that therefore there is no means for me to determine if this is an
approved property.

What prevents someone else to use a different property name for the same
driver and property next week, on a different product using the same
hardware ?

Guenter
