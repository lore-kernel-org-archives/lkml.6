Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4B6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855D620693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hansmi-ch.20150623.gappssmtp.com header.i=@hansmi-ch.20150623.gappssmtp.com header.b="r5vHSIRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855D620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hansmi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbeGRSDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:03:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41888 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbeGRSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:03:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id v22-v6so4017539lfe.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hansmi-ch.20150623.gappssmtp.com; s=20150623;
        h=sender:subject:to:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=k6n5Q95wx2yTgFT4eG8xqBpmNBRJDMDuZY3dB2tR1nc=;
        b=r5vHSIRP7CFMrKZ0cebjMETmsqEWl6Agh4lYV5RZkYm0VRw3H/eA2H+3ivMkZ0er3z
         Ob67pxIf3T5nX4p85sayevHnsp4Epr2j/o/TkYVwXEj4sVZmzhsmjvqIk6SWOfqcZFO+
         oKKcsU6WrZyMUcsFWeyNownOC8aTzdM6hPOmbvYelMEf0J0wwxBTWmqUxyGL9Jq/f5BQ
         8pOpxclrlwYj5wjXCoyiZWVGo/N7HE31qvDARgj0W9o3Sa998eKVJF2vperqYkUes4nE
         6U9sMRtWjPStYDEAit//Hr2EnFL25SptE+f9CwA7gabCndMpPwYgegTQOtjBAcSyvkRL
         3y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k6n5Q95wx2yTgFT4eG8xqBpmNBRJDMDuZY3dB2tR1nc=;
        b=rsh1KD1rIsQ7nB+nokvBcZoU59wpY6h2lHRH52Il+TRBQQljN32cEqUPmF3Ltsf23B
         /6U9p5qtZ1U/AV9aHZt/qKDmLEWx3f5wuEkTaWOim4gPS0YilwKTysaEk7d6qfxNV8Bu
         scNncc/7Ja3PV1CZcDccOxxd5No39E5501FuIwVKgYo0SkbVej2vN7y8Fb786ddeG0Dg
         2hsMyFs2RjNo7i16r7gtpUTTUWMy8HR6g2obHzSNY7HG58Kio1L19CIS0gTAt5A+OY5a
         TYBKwQ/A7MnFJR31zWSPPJ2ymH389K9hxM3ZOyKyXS0nmZP3XCqVr3PsON354/YjAX2M
         GRLQ==
X-Gm-Message-State: AOUpUlFpS8l0AFQSKUeGAoPp6bcHgyKyJpO0xlRnRWzFojS2Ky7TAmKq
        /BjneGzq2UlQnBojexSgZzQbN2g19/8=
X-Google-Smtp-Source: AAOMgpdC8hG+fehFqu6QsSUgPRTV4rVlHUS/RtutK7Yx1dztmNLTYJ/mj6cLkj/7kK8t/hCwJGsbTg==
X-Received: by 2002:a19:a5c5:: with SMTP id o188-v6mr4777223lfe.149.1531934690962;
        Wed, 18 Jul 2018 10:24:50 -0700 (PDT)
Received: from [10.93.18.212] ([80.232.78.190])
        by smtp.gmail.com with ESMTPSA id h24-v6sm710274ljg.55.2018.07.18.10.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 10:24:49 -0700 (PDT)
Subject: Re: [PATCH] Mark ams driver as orphaned in MAINTAINERS
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <8fe08e4d44c56ee0b70517fc8609ab5a116bc407.1517265227.git.linux-kernel@hansmi.ch>
 <877elsq2xh.fsf@concordia.ellerman.id.au>
From:   Michael Hanselmann <linux-kernel@hansmi.ch>
Message-ID: <04170342-6779-5e17-69c9-f0d87a3cc5a1@hansmi.ch>
Date:   Wed, 18 Jul 2018 19:24:48 +0200
MIME-Version: 1.0
In-Reply-To: <877elsq2xh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2018 12:00, Michael Ellerman wrote:
> Michael Hanselmann <linux-kernel@hansmi.ch> writes:
>> I no longer have any hardware with the Apple motion sensor and thus
>> relinquish maintainership of the driver.
> 
> Thanks. I think I'll just remove the whole entry, meaning it will be
> caught under the "LINUX FOR POWER MACINTOSH" entry.
> 
> Unless you object. Full patch below.

Sounds good to me.

Reviewed-by: Michael Hanselmann <linux-kernel@hansmi.ch>

