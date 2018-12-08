Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4895C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D322082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="om4RXed6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D322082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLHQgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:36:15 -0500
Received: from cmta18.telus.net ([209.171.16.91]:33565 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbeLHQgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:36:14 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id VfaKgNn7tiBO5VfaLg8UiT; Sat, 08 Dec 2018 09:36:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1544286973; bh=uQqfi2OU/Qr6YT/5nOZom/LOrlefAybYtQHtkrKyad8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=om4RXed60yvZNyHG6DQx1Kyrk/PW3spCgyP+aqBdvzDj0PSLjX8gC4y5s8xNn0Ylo
         P1PEn27/TMKkg+0FXGpPBBCTzSbgd1X+NFdcdN7xEcEzaK6fWAtR1EXvqsA3MYaTUX
         zpI07zEE9C/n9+WkANHztUCz8V2tyq2Qj7xZhuER5AdsE7g0CYJp+dS122eFxAJgmD
         U+BEa1gVPwdWSnoMogb9qA1n/r/dOB9Lm2Iuek93Cj69zQe6qxqNvJTwbyn91ND9d0
         DFPcfEfY1n+FitFL60sQwIqR6qHYsw6AyWEnFPCoqZ8kAU90mpm2mcmqQ/QDJY59Vs
         vH41B5BkkRPZg==
X-Authority-Analysis: v=2.3 cv=d5AkNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=Fn2qRtD51wxDL-y3EyEA:9 a=QEXdDO2ut3YA:10 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'open list:DOCUMENTATION'" <linux-doc@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <006901d48cef$5bb88a00$13299e00$@net> UpeTgvCH1QLjuUpeUg0j37
In-Reply-To: UpeTgvCH1QLjuUpeUg0j37
Subject: RE: [PATCH] cpuidle: Add 'high' and 'low' idle state metrics
Date:   Sat, 8 Dec 2018 08:36:07 -0800
Message-ID: <000e01d48f14$21ca7020$655f5060$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdSNQ1IU6pCDyS4/RhWeVVbkXDkEQwBz4ojA
Content-Language: en-ca
X-CMAE-Envelope: MS4wfKowa8NbZMPQybuZayMyJMYeHYTZTEitfAPEAuZ+j2sPp1r7EQ22hfHPir4HDPaY4BgJdbs+peZZpLUGqhqwkR5M+lvmryMqGdoeF5nFjzelepaZgwDB
 0mBuptqzq+5YwxjeXf6TC1hFTnhYj0L8KLw4tv8d8r+wuNwxXmhjPmJz9KTL64Gj/m7IHuQbpR/FTQVgqo0XSnmRB9rTavyfOLjPairzFmvxtp5wweRXwXRM
 wVcRP3LjrTJOExar4/spzC9QXkFfj91CkfgBld+gIFkQt6ndJSLoxNIE/c4iVtbunmebI3P3YTCVQ6mIygVp4UvEWvbfVnE16i33f+HuhMkImWglhUjuQoiz
 UV0Xq2cYUa1h0+v04Jhi8n/tiQeNEtcLnSXPHn+g5EXpy04jiZg2FU/u4R44dTndyZtwE9/u37aImImX6cQUBNI9nqjmeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.12.06 01:09 Rafael J. Wysocki wrote:
> On Thu, Dec 6, 2018 at 12:08 AM Doug Smythies <dsmythies@telus.net> wrote:
>> On 2018.12.03 04:32 Rafael J. Wysocki wrote:
>>
>>> Add two new metrics for CPU idle states, "high" and "low", to count
>>> the number of times the given state had been asked for (or entered
>>> from the kernel's perspective), but the observed idle duration turned
>>> out to be too high or too low for it (respectively).
>>
>> I wonder about the "high" "low" terminology here.
>
> I took these names, because they are concise and simple.  I could use
> "below" and "above" respectively I guess.  What about these?

I see you already sent a new patch with these names. Yes, myself I like
them better.

I am going to try to add these counts to my next sets of graphs.

... Doug


