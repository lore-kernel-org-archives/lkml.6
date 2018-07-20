Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF488206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJuaTZyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF488206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeGTLvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:51:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36791 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeGTLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:51:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so10806352lji.3;
        Fri, 20 Jul 2018 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5h3utGIUO4yTj5Gf8nctT7YB3sjsemfWSm51sX6CnVo=;
        b=XJuaTZyEMFYnTkvz0cqWHfEoMYLeJTW4PTPKfKWkm0zUEEul4uoQ4BL2KQBhfQC+RY
         YitO1Gd+V1YwgULxQvqtghltHGxE/8dsl4gcR9L1j6NbC95e4diaGzEIOO3Dcc2cnE2P
         vQ9DLUYRPLMaabopzFlToDtZLk2bUedItmoO2t55sL4L3GSFapRhz2dw29j1rYZzmAkP
         gSnoVIw90lTONrncMx8LhNvcQ9E6fKCj1Ds9WNJvF1sgJbZAoJwGyEKd5uvxKRjTJ39u
         TNcZuBJECrfW6t93eyIzmg7cLVRFc2YcpCaIuIzVqw0BST/UbAGoikeH0BQN4lHlM0fR
         yoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5h3utGIUO4yTj5Gf8nctT7YB3sjsemfWSm51sX6CnVo=;
        b=ppvjfMcimO70o0INZ+XsRfyeu29atd/nD4w1tLDQbdeCzlVLkLKyU86WbNtkwCCHvl
         yRE1uPbgU+MFd/OMUtdoRPx5l/q5niRzpZdz4kzQY5x78NQh5WKdEFRJQ6l5rXnhZ6Ma
         i3r0cXiWQbhCd5sAApExluquLlg3wByfgKgCuskzDztE4h29EL2FvbH84AP2M6UrdefO
         3w5YAcg06BOffP5SDK+TCBQHWzWMBBrY/StN1UzjaXpL5tW5qa9C4lw55racI3mLZ6s5
         a7OB3ctA5SB+uaZ2GeTR7AW3JfBFPireNTmwO14zjDe5Bs96q76k/nsWkhSVf9pRl8xw
         MENg==
X-Gm-Message-State: AOUpUlE6Wmy4uoyIQkzlNa76MSdOstohDL49PUa3Q/ysIVwHCQ8BvopZ
        Eh3YLleTe5ryCtBVBJ01G7g=
X-Google-Smtp-Source: AAOMgpdt5vOe3n2U1i/LSfbJ1X+SSCarC6FynqqdlpgmsA/GbBE1cmPzBhcf2MsmykIQB3Y84DRu6Q==
X-Received: by 2002:a2e:144f:: with SMTP id 15-v6mr1394052lju.122.1532084625992;
        Fri, 20 Jul 2018 04:03:45 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id e20-v6sm253577lff.41.2018.07.20.04.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 04:03:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fgTC7-0006VO-Cc; Fri, 20 Jul 2018 13:03:31 +0200
Date:   Fri, 20 Jul 2018 13:03:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Johan Hovold <johan@kernel.org>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, t-kristo@ti.com,
        linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180720110331.GE19245@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
 <20180719100229.GQ10204@localhost>
 <ed335c7a-f079-082d-d572-93632087fd8f@ti.com>
 <a6930aca-f475-5b53-ce9d-d45fbc75d69c@ti.com>
 <20180719123617.GV10204@localhost>
 <e3841afa-fe18-84c0-e5b6-520365c5e4a1@ti.com>
 <28f0d002-f05e-b4dc-f0dd-d0bc0fc5616d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f0d002-f05e-b4dc-f0dd-d0bc0fc5616d@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 04:03:20PM +0530, Keerthy wrote:
> 
> 
> On Thursday 19 July 2018 06:16 PM, Keerthy wrote:
> > 
> > 
> > On Thursday 19 July 2018 06:06 PM, Johan Hovold wrote:
> >> On Thu, Jul 19, 2018 at 05:52:17PM +0530, Keerthy wrote:
> >>> On Thursday 19 July 2018 05:23 PM, Keerthy wrote:
> >>>> On Thursday 19 July 2018 03:32 PM, Johan Hovold wrote:
> >>>>> On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:
> >>
> >>>>>> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
> >>>>>>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> >>>>>>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
> >>>>>>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> >>
> >>>>>> +	/* Our calculations started right before the rollover, try again */
> >>
> >>>>>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> >>>>>> +		goto again;
> >>>>>
> >>>>> Here the alarm may have gone off as part of the roll over, in which case
> >>>>> you shouldn't retry.
> >>>>
> >>>> Ex: We programmed at Sec = 2 and we expect ALARM2 to fire at sec = 3.
> >>>>
> >>>> In the event of Roll over before setting the
> >>>> OMAP_RTC_INTERRUPTS_IT_ALARM2 bit in the OMAP_RTC_INTERRUPTS_REG will we
> >>>> not miss the ALARM2 event? Then poweroff would fail right?
> >>
> >> Right, that would fail.
> >>
> >>>> Hence the attempt to retry the next second. This sequence would begin
> >>>> right at the beginning of a new second and we expect the full sequence
> >>>> to get over without having to retry again.
> >>>>
> >>>> Hope i am clear.
> >>
> >> Yes, sure, but my point is that could end up retrying also after the
> >> alarm has fired correctly (e.g. due to latencies in turning of the
> >> power)>
> >> It may be enough to check OMAP_RTC_STATUS_REG before retrying.
> 
> On a second thought. Status gets set only after the next second.
> 
> if ALARM2 status bit is set that surely means interrupt has fired but if
> it is not set then there are 2 possibilities
> 
> 1) ALARM2 is missed as the roll over happened
> 2) ALARM2 yet to fire as we are yet to get to the next second.
> 
> On the other hand Seconds gives me clear indication if we missed the
> interrupt or we are about to get one.

Yes, you still have to check seconds *before* retrying based on status.

That should do, right?

Johan
