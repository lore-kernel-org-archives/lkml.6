Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B36C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587D626061
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="KFjtN8kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587D626061
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965961AbeF0Smi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:42:38 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:55516 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934387AbeF0Smg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KbRdafgCt1v3qmJKS4JgXInW1YiMoGZrRhi7UjGfPN0=; b=KFjtN8kfoc6Xis/YCm5QSHIi8e
        ukc4AODnVh2HQtz49aG1lvVa6usP6JOkAqZbjTwo2whV5V0l/74FzoHobkUy2BQOjD6yguG0waU+I
        P5rrVdzF6I1OpErXKIouVaa9p9ULxUVYot8xdZJ24ODMJb/oErKYPGwEVgF6Z3YB07kK5QN5RnvaN
        Fk4C99J8RXlQulwHkQ4XJ4gqAoF4Xyn4RLUQW/qfipdXMef9U5rXxiQbnyYiMfAHOC1bRID/MoN/a
        t97gGLEraE09xQTPVY4Fk0Q4J5ISZCB7h9AcKTD/SKO/tafBmWBhmzRThrAy63dR6ssoteNZMVnw9
        DTjh9BGg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38762 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fYFOl-00Fett-EC; Wed, 27 Jun 2018 18:42:35 +0000
Date:   Wed, 27 Jun 2018 11:42:34 -0700
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
Message-ID: <20180627184234.GA19538@roeck-us.net>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
 <20180627183327.GD16753@roeck-us.net>
 <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
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

On Wed, Jun 27, 2018 at 11:38:48AM -0700, Ray Jui wrote:
> 
> 
> On 6/27/2018 11:33 AM, Guenter Roeck wrote:
> >On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
> >>Hi Guenter/Rob,
> >>
> >>Kindly let me know how you want to proceed with this?
> >>
> >
> >If I recall correctly, the patch series does not add a new problem
> >but merely exposes one. Is my recollection correct ? If so, maybe
> >we should just add a note somewhere indicating what might be wrong
> >and otherwise apply the series.
> >
> >Does this make sense ?
> 
> Yes this makes a lot of sense to me. This patch series exposes potential
> problems in some SoCs that they might not be feeding the correct clock into
> WDT, at least based on clock names from their DT entries.
> 
> This patch series does not change/affect how SP805 works on those systems.
> 
> Where should the note be added?
> 

I would suggest to add a note into the driver where the clock is used,
with the details discussed here.

Does this make sense ?

Thanks,
Guenter
