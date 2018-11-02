Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D54C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70D22081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="6ShgvJ4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70D22081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeKCArW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:47:22 -0400
Received: from cmta16.telus.net ([209.171.16.89]:39774 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeKCArV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:47:21 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id IbY0gI2nZPTKIIbY2gL8ak; Fri, 02 Nov 2018 09:39:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1541173190; bh=U4u4fhoNm5cFsPoiKAp44MgE1GSXG7vgmhJZR73RmEg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=6ShgvJ4w7FXqhrRXOCZ+nAmCCaPdOIHsCmz4OqjbhAGrrAU1dSlsrs4Qyc27PPd/+
         o9NotrSd3+LV2HhisVNCYvUe42aq9TebV2IGUwoKgBvYB9MRTKCAPVgnZLg4Zc0zL/
         biPnN+1EY+qDUtWxnGUf3UkabdVQGUFpQ6QD1C01GhWIXThZ4ZassAThRfLPf+gE6P
         oPs7joYGC1mdl5L+nU/x7C8u4CkrjXwgSExzFgmAUpYm9RhXh0OMfsU8ILJPiDfUEX
         27lf+UFeN+WJCuLfR/brwW/2lOMbDcezMnmyJnVsKz7k6e75Y1j87eOUmsqU5Twb47
         ta3x1kZiwhSbQ==
X-Authority-Analysis: v=2.3 cv=ScEmicZu c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=t8X8vvMUJD-cDFKV--8A:9 a=CjuIK1q_8ugA:10 a=CJuBXZXvIbAA:10
 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "Doug Smythies" <dsmythies@telus.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: FyDag8LEB6DhgFyDfglTus
In-Reply-To: FyDag8LEB6DhgFyDfglTus
Subject: RE: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date:   Fri, 2 Nov 2018 08:39:42 -0700
Message-ID: <000301d472c2$49f28740$ddd795c0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdRtDH+ycSZtxUPCQHyrG49eN1+negFrjHXA
X-CMAE-Envelope: MS4wfO7twEdC+5MwfCOKivO4kc1dxfKGK1uTZJOPE8GqExgTOaFxuD4hOVTI9QhpBe9wHWHVHVaUnjjluPPVsUqqo+0qqm17wydhPTZgNc3eBOehvFhAs6Dy
 mkMc3exMyQpbOBPeei6cFtII9NuPax9Wxl32yYWqAhZUiune57ikyW8CUdhSgDks+8mYdk2Yiwhdw6ZiAn8CRzVnlkVWjcydeZqItT4MwQ3piKDMX+Yz9VFU
 Tu9c5lYFSga/cQLK8JR96GVwazhBsP44NF+quFM/dfL5U8ooVV0aNlNHq2jYJIciyfPW7ZhuCEx7F17BXLqeY5fsk5q8/LyE+LrN4ysTJGJOOc/ve7pyTimx
 DZlMoZT1oxNgvSBUPCH8+337CLFZfyXu2igitNzwoPl9Py+Jwgv7ReiSU91aSwg9KMdWrqesyW0lUViR0bgh4yMnc63byPdUOyhkMRd/8pGAyHhhbJwE013d
 psU6LiWGOebyq7qX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.10.26 02:12 Rafael J. Wysocki wrote:

...[snip]...

> The v2 is a re-write of major parts of the original patch.
>
> The approach the same in general, but the details have changed significantly
> with respect to the previous version.  In particular:
> * The decay of the idle state metrics is implemented differently.
> * There is a more "clever" pattern detection (sort of along the lines
>   of what the menu does, but simplified quite a bit and trying to avoid
>   including timer wakeups).
> * The "promotion" from the "polling" state is gone.
> * The "safety net" wakeups are treated as the CPU might have been idle
>   until the closest timer.

...[snip]...

I have been testing this V2 against a baseline that includes all
of the pending menu patches. My baseline kernel is somewhere
after 4.19, at 345671e.

A side note:
Recall that with the menu patch set tests, I found that the baseline
reference performance for the pipe test on one core had changed
significantly (worse - Kernel 4.19-rc1). Well, now it has changed
significantly again (better, and even significantly better than it
was for 4.18). 4.18 ~4.8 uSec/loop; 4.19 ~5.2 uSec/loop; 4.19+
(345671e) 4.2 uSec/loop.

This V2 is pretty good. All of the tests that I run gave similar
performance and power use between the baseline reference and V2.
I couldn't find any issues with the decay stuff, and I tried.
(sorry, I didn't do pretty graphs.)

After reading Giovanni's reply the other day, I tried the
Phoronix dbench test: 12 clients resulted in similar performance,
But TEOv2 used a little less processor package power; 256 clients
had about -7% performance using TEOv2, but (my numbers are not
exact) also used less processor package power.

On 2018.10.31 11:36 Giovanni Gherdovich wrote:

> Something I'd like to do now is verify that "teo"'s predictions
> are better than "menu"'s; I'll probably use systemtap to make
> some histograms of idle times versus what idle state was chosen
> -- that'd be enough to compare the two.

I don't know what a "systemtap" is, but I have (crude) tools to
post process trace data into histograms data. I did 5 minute
traces during the 12 client Phoronix dbench test and plotted
the results, [1]. Sometimes, to the right of the autoscaled
graph is another with fixed scaling. Better grouping of idle
durations with TEOv2 are clearly visible.

... Doug

[1] http://fast.smythies.com/linux-pm/k419p/histo_compare.htm


