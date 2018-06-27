Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F94DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECAE25BDA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="fnYj6l5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECAE25BDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966086AbeF0Szd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:55:33 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:41772 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeF0Sza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0Hdeki8TknuEC3FwoT9Ryo16XFb/BEOK33jhv2EIRwY=; b=fnYj6l5ZBzGUNQq7e5HJ4ImL5o
        szrAdATFtSNkiYXSm2fiRdIEw0Zy9c2yglK+N0qKSE61d0VM9+QjTKIKWtIn7EFUZ0gIZA7yB+SwR
        If/M98nbwO1S7MgFzGhtQST/mOrVjDl47Yx/3I9WjK5C1NCqOEFl0XTrkxwI2u1pZsr/N0R9g5cr6
        BpwecWRDe9WrY7dZl3rKIAyXaApTu7iWyOm8PBWB7AzifxdnV15qprR0kZ24Ki5VVEp9SRBnVHJbA
        XaX8I2lenmDGDyqgtaaZwJ6OnSzZIlDAyYbgBS7lf0b1A2aSrAXw4w6JyqMWj1bc3UP9E0gWZ9YqC
        R2vpEtdw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38834 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fYFbG-00G7iK-3s; Wed, 27 Jun 2018 18:55:30 +0000
Date:   Wed, 27 Jun 2018 11:55:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
Message-ID: <20180627185529.GB19743@roeck-us.net>
References: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
 <20180627183327.GD16753@roeck-us.net>
 <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
 <20180627184234.GA19538@roeck-us.net>
 <8483f675-0c7d-4b0f-25fd-a5eff4bc7937@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8483f675-0c7d-4b0f-25fd-a5eff4bc7937@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:47:21AM -0700, Ray Jui wrote:
> 
> 
> On 6/27/2018 11:42 AM, Guenter Roeck wrote:
> >On Wed, Jun 27, 2018 at 11:38:48AM -0700, Ray Jui wrote:
> >>
> >>
> >>On 6/27/2018 11:33 AM, Guenter Roeck wrote:
> >>>On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
> >>>>Hi Guenter/Rob,
> >>>>
> >>>>Kindly let me know how you want to proceed with this?
> >>>>
> >>>
> >>>If I recall correctly, the patch series does not add a new problem
> >>>but merely exposes one. Is my recollection correct ? If so, maybe
> >>>we should just add a note somewhere indicating what might be wrong
> >>>and otherwise apply the series.
> >>>
> >>>Does this make sense ?
> >>
> >>Yes this makes a lot of sense to me. This patch series exposes potential
> >>problems in some SoCs that they might not be feeding the correct clock into
> >>WDT, at least based on clock names from their DT entries.
> >>
> >>This patch series does not change/affect how SP805 works on those systems.
> >>
> >>Where should the note be added?
> >>
> >
> >I would suggest to add a note into the driver where the clock is used,
> >with the details discussed here.
> 
> I assume you meant adding the notes to the SP805 driver where the clock is
> used.
> 
> If so, I think that makes sense. That notes deserves its own patch because
> it really has nothing to do with any of the change in this patch series.
> 
> Do you want me to 1) embed that patch into this patch series and send out
> v5; or 2) leave the patch series as it is and send out a separate patch to
> add the notes to the driver?
> 
2) is fine. I don't have the series here right now; if I recall correctly
all patches in the series are all marked as Reviewed-by: and/or Acked-by:.
If so, I'll apply them to my tree tonight, or at least the ones that will
go in through the watchdog tree.

Guenter
