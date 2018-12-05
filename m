Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A3720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="Ixrm4fAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A3720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeLEXH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:07:59 -0500
Received: from cmta17.telus.net ([209.171.16.90]:54232 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbeLEXH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:07:59 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id UgGpgyTLMP96wUgGqgUMum; Wed, 05 Dec 2018 16:07:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1544051277; bh=16wvuldLn/HqQsgWpoEWod0QYyN9fSua/uB09H8QZeg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Ixrm4fAMPHZhlbw+KbgVLYE2fV9PpzMbfekfg8Twfg696fMOVBsAGnOT47jCO6cn3
         i1oqhIaUmmcio9YATSoT+ryCf9F9sdYfE7XWnuqvkIzYN40RmCFQn0KulQw8QC5CYe
         AWFwaCKkQe2MHbCAUbYwSTxK4WDnsB97F7baSeVxaL5OEwBPNm+F23+K/nq4Ul9xSB
         RVux6GOJx/lHvtPosvkiM5HIp5ROYj0igQnoopL87albbdUgrE9oytbWvRnfsEPJHC
         a2TWmf53lPa6dz5xUYYqQvdXLSH41Kc1hJIRjGprN4+Ozk69CYd1n5XTL0wi+cYYFx
         MGH0GqOCZdzvQ==
X-Authority-Analysis: v=2.3 cv=G5vN7Os5 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=jpbZs5yXI5kjarsWqy4A:9
 a=xj_gZadtinr1vAgT:21 a=fUl3DSob3bFrHl83:21 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: TnO3gBgeGpqCWTnO8gldCG
In-Reply-To: TnO3gBgeGpqCWTnO8gldCG
Subject: RE: [PATCH] cpuidle: Add 'high' and 'low' idle state metrics
Date:   Wed, 5 Dec 2018 15:07:54 -0800
Message-ID: <006901d48cef$5bb88a00$13299e00$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdSLBCu1OtjiTaHmT7WIyCahJReY1QB6N6Qg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfCwM4h6RU1EZMsyr00ZI/veEoIPUzkZohFpAGgzHtovZUNownDbH8fTBGkF4H70KkYfFyXWa7G15AEJZ8is0uN/tBh1ZNOesnYnNjRWgZK31NrqsFBnd
 EjcU5xwPM7k5Sf9GIj6srhSCWyS4FtLfP6q510NT+Tsaxd5iOeQFrymYJAERTBuFbnEyqfMNad8IikUIeSSqlIZobP+XlC5r02KRFFz5V2u6NwbChGPFYn/h
 T/gke/LufHoh+veVaZnXPFHh6kEnroyQp59ISMAd8rScOlqV/YJtMcHkPTHFVTSEO+KTrVrTcQjUGaBiFGEZB+jNftKcuegYF4CLtzQdvgQwrw2Ih02udJTG
 hsP11xw65TM3R9W/4Ym0qo6VrDlm6uDQLsIv7izeP/I58MPo6xk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2018.12.03 04:32 Rafael J. Wysocki wrote:

> Add two new metrics for CPU idle states, "high" and "low", to count
> the number of times the given state had been asked for (or entered
> from the kernel's perspective), but the observed idle duration turned
> out to be too high or too low for it (respectively).

I wonder about the "high" "low" terminology here.

> These mertics help to estimat the quality of the CPU idle governor
> in use.

Yes, very useful. Thanks.

Here the terms are mixed with "deep" and "shallow"

> +	unsigned long long	high; /* Number of times it's been too deep */
> +	unsigned long long	low;  /* Number of times it's been too shallow */

> +``high``
> +	Total number of times this idle state had been asked for, but the
> +	observed idle duration was too short to match its target residency.
> +

O.K. To avoid ambiguity, how about naming them "too_short" and "too_long"?

> +``low``
> +	Total number of times this idle state had been asked for, but a deeper
> +	idle state would have been a better match for the observed idle duration.

Even though I read the patch, by the time I actually looked at the numbers I had
forgotten the meaning. I had look at idle state 0 and 4 (the deepest for my computer)
to figure it out:

doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state0/low
259871
doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state0/high
0
doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state4/low
0
doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state4/high
5584

Because state 0 can not be too short and state 4 can not be too long.

... Doug


