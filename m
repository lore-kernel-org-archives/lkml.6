Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AECC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CF520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZIyTv4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CF520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeGSNT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:19:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44268 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeGSNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:19:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so7210482ljq.11;
        Thu, 19 Jul 2018 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zz5FBWZM7c5/Rp37TfmfELQ+U8kN1pTTzwEaujQh5E=;
        b=AZIyTv4QNdPoUH7U1JMZKS+jKCXFrWApFh76rDsICHtigDSdY8iU7YVmerM6a2LFz2
         phKplIPDDCipO89uElxtu68B6nvNos2fHaTBnnn7UeMKC0UeNVMgIYlNSw16Jpu2xNF6
         MZHQczb1iz8pTvFNZViGb4lycSUIjdIdu0HZWO8NU6H3UMI5JiL2gHJf7Lso7b6Gpd5l
         PTboVT69APY5jD3cnCmIb34oQWmNFE1HLDLnCbGZinSaNZ6f7QnQgEg4SYRsTNr34Qoz
         EiYawb7kJLa/PCKUvGKrFjCj0tjJoyjDgE/yFrV94gyWl2WWakxq4TNNZN9TZ4yJV3LM
         S/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zz5FBWZM7c5/Rp37TfmfELQ+U8kN1pTTzwEaujQh5E=;
        b=NkAhHqlGODOUTYm70lj13zj1TUxKUbBqNQu48DNS+2ziiFjWt6IZQq+7s7R7WrFgLq
         0t26jlnP3lnImuyWYenYn5JeTJSmkimA6smzUFudCzgKBro+GlCOMT3qJxZxjAx9pzwn
         j4eLATFS5iiz3FBwAJoOjS6u1LFxs6NYmMKtG4/gPnHp8WbTY3MPdoUVY99LeLOHOTpf
         Y+syy+6o967CkalnG2jhepNC0Pwk48KJUhhF/gzQkuH6iqPpFH0VRDiw54ybWuc9pxdW
         kJalTVIUUTLiGs6OnFTkv/0dQjd1PKuXCmKVWQ0WQEXRuYP8J89pr25BSAKyDeeTEy32
         9x7g==
X-Gm-Message-State: AOUpUlEqyFfrHP7ZnF+A4bjVRby/BkyoLBv9tr79xEkMMSiu2CBRciu1
        Q/eBiz5UpmqOSXBf0KJQK1g=
X-Google-Smtp-Source: AAOMgpeid8thTR2mJc6gM4KmbtpTvCpwv2Pi8+cn2f3QPIwn40cNsMHNfCAF5YNuDMyyius25rzjKg==
X-Received: by 2002:a19:1888:: with SMTP id 8-v6mr6342967lfy.121.1532003789250;
        Thu, 19 Jul 2018 05:36:29 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id j9-v6sm1095530ljh.40.2018.07.19.05.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 05:36:28 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fg8AL-0006IG-7Z; Thu, 19 Jul 2018 14:36:17 +0200
Date:   Thu, 19 Jul 2018 14:36:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Johan Hovold <johan@kernel.org>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, t-kristo@ti.com,
        linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180719123617.GV10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
 <20180719100229.GQ10204@localhost>
 <ed335c7a-f079-082d-d572-93632087fd8f@ti.com>
 <a6930aca-f475-5b53-ce9d-d45fbc75d69c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6930aca-f475-5b53-ce9d-d45fbc75d69c@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:52:17PM +0530, Keerthy wrote:
> On Thursday 19 July 2018 05:23 PM, Keerthy wrote:
> > On Thursday 19 July 2018 03:32 PM, Johan Hovold wrote:
> >> On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:

> >>> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
> >>>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> >>>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
> >>>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);

> >>> +	/* Our calculations started right before the rollover, try again */

> >>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> >>> +		goto again;
> >>
> >> Here the alarm may have gone off as part of the roll over, in which case
> >> you shouldn't retry.
> > 
> > Ex: We programmed at Sec = 2 and we expect ALARM2 to fire at sec = 3.
> > 
> > In the event of Roll over before setting the
> > OMAP_RTC_INTERRUPTS_IT_ALARM2 bit in the OMAP_RTC_INTERRUPTS_REG will we
> > not miss the ALARM2 event? Then poweroff would fail right?

Right, that would fail.

> > Hence the attempt to retry the next second. This sequence would begin
> > right at the beginning of a new second and we expect the full sequence
> > to get over without having to retry again.
> > 
> > Hope i am clear.

Yes, sure, but my point is that could end up retrying also after the
alarm has fired correctly (e.g. due to latencies in turning of the
power).

It may be enough to check OMAP_RTC_STATUS_REG before retrying.

> I tried to program the interrupt for the same second on the hardware and
> it does not fire. So to take care of roll over corner case one attempt
> to retry is needed.

Yes, that's expected.

Thanks,
Johan
