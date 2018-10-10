Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7075921528
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="wro9h2v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7075921528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJJHWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:22:07 -0400
Received: from cmta20.telus.net ([209.171.16.93]:42178 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbeJJHWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:22:07 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id A1xVgyDXZVltLA1xXgsP5X; Tue, 09 Oct 2018 18:02:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1539129762; bh=pc4F6Ri6V4Wx++1yvB+sBlOqlFOmxJFavlgOytE6Rb4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=wro9h2v2EUuvqw7EeuElQTbuDM1DaxzTrp9FS3YCEjjLq1zJyYYr8CHuy++eTRkd2
         E1C2jwYHFE+m7QxJKxPORvpPfj4xrEbYtx9Hgcwj3OhJnHmedfLnmZb+/Hgm02dHbL
         zFemrqnRweyiMAwmJ0eZsJW1ed96H2t+EwWejCEQTwHsFiWNIJQiu138ZJxNnrAQ9b
         MeMS85gdcU3Pa4uCHdvR9e3LEZnpKrEI1GCEhZD4flBJ6j+0D5fcIk7bALRLJALxNT
         1HLEHtgYp3xWMllaA2eO480Sui6RbsqmOL2m+SHOhg0X9lopq7+iuPsmJ3cBsc93l6
         37PRkGjQ/42Tw==
X-Authority-Analysis: v=2.3 cv=d60kNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=2mpuXmpUO2dryPSGsbQA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <000301d45ecb$4f002a90$ed007fb0$@net> <003801d45f54$3d9b0c50$b8d124f0$@net> <CAJZ5v0h4sVoen++nF1cYvqQeY3qN0B1aP42e8A4SZwxzBV3NVA@mail.gmail.com> 9pWMgRJJQ3psd9pWRgA8E4
In-Reply-To: 9pWMgRJJQ3psd9pWRgA8E4
Subject: RE: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Date:   Tue, 9 Oct 2018 17:02:36 -0700
Message-ID: <003d01d4602c$905b5840$b11208c0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdRfvUHrdGrOl1YIROeaUQFDKa5cOQAbmNTg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfNwoAERTFRcg3EBgkeQ9Jg+3HxB5VxpL5dxkKqXGRIzU2wTeYdfbnErJLk3SVwm2WuOGC/6VWiq+o16080kiPE1ZieyCBGfvErFz+c86OYX2WH9evARa
 jYuVYnVJtF1HNwUxChgt2BRfX5eg20riC0QNAcPoX/WqFrJ2tfm79WQmOr7qlDtUS/cEp5ZbQDPmh5HtrANI5df08Kct65F7egLPvLgyjguEkNHhpDZlOA3R
 DBW02bmJK+vdEK49tSdrw5xW/l1oJqM/u3Qpti60b6jgGk1P5cxs389phJfZ/xekKH11WAjgFjsTa2h6CpHi1a/lmvDVR2eMwX1V3OwYIO0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.10.09 03:43 Rafael J. Wysocki wrote:

...[snip]...

> While at it, could you test the appended patch
> (on top of the previous 8) for me please?
>
> I think that this code can be simplified now.
>
> ---
> drivers/cpuidle/governors/menu.c |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -371,12 +371,12 @@ static int menu_select(struct cpuidle_dr
> 		if (s->target_residency > predicted_us) {
> 			/*
> 			 * Use a physical idle state, not busy polling, unless
> -			 * a timer is going to trigger really really soon.
> +			 * a timer is going to trigger soon enough.
> 			 */
> 			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -			    i == idx + 1 && latency_req > s->exit_latency &&
> -			    data->next_timer_us > max_t(unsigned int, 20,
> -							s->target_residency)) {
> +			    s->exit_latency <= latency_req &&
> +			    s->target_residency <= data->next_timer_us) {
> +				predicted_us = s->target_residency;
> 				idx = i;
> 				break;
> 			}

It seems to work fine.
I was unable to detect any difference between the 8 patch set and with
this additional patch for any of the tests that I ran. (at least beyond
noise and/or experimental error.)

Note: I didn't publish any of the pretty graphs.

... Doug


