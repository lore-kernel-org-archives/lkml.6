Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B6C636A2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 14:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C51C20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 14:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxQVUZfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfATO72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 09:59:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38014 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbfATO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 09:59:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so13713897lfk.5;
        Sun, 20 Jan 2019 06:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MSnMarkPyzYm+KRZcqH8H/zMlAWD70xsURpzqvvnwwk=;
        b=sxQVUZfIYLl8S1bOYDe10MRxH4nMlCPwtYnEyJVgzAKK9C8vTdnEwDAl26DRLbljTo
         7a01Rt3mxaqXFGenJjvR4wYGm7L22613VJ4204O2zwOdUZhyHVrzSX8md3J5x9lR/2p8
         e2iBulOGqyA4lPmOyPj21Dmbk8Ioe9oBI17iOq3fvlU4R+zX1j2c2RoNWWwz/EzebgoL
         mVVSlD0Dx3aIdn+Z8ZGSbJoOuXuDUuQsZiiNnx8Uv2Wwroz1F9NVS452rBz2uXEhceKO
         bO1lbfk7ES0fqn2L+QLNCHlGPs7JqxHofvz1L0Kk+Z1hGqfyUjBWwmSIWVyf24GpMjCh
         ZoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MSnMarkPyzYm+KRZcqH8H/zMlAWD70xsURpzqvvnwwk=;
        b=tx5JmcezE9BqIVPZeDjAm5nBEkoEdwXrhPMABFOLi6Affge7xXNkWT5K1D72lPhm8e
         TX0cB0nxVkVSoNvD3O867qUSam59tR1c+b+nXNyILSIpvCZ7qtKPu8JfcL//K/zKVucE
         j+FLn+rbYO+bwP5qCg9RYaE6ZA0Gp4onVw6HKSkoZM0kAKjvhlMxGIYuScED0j7NipfH
         FgjvBfSobmv4jsl9PrvE7sTr7ImEgxjw0t3OlyRL6GGyzxuYzBgkL4tvn7awaFsWQbTb
         eGlBx/l/oiTWNN/ph2VH5yNDm6ZPXB6bhadHsgPzed2VzQOiIG4lrfYx4+EZNpjDTi0J
         Q+Jw==
X-Gm-Message-State: AJcUukcPDF1ocvhmpxdmjFTw2DxBX+MXMkK6AOIcx997sz+5WYgduvtL
        rSw9DqC9uzBvt4g5LDPxAv1RcKfXJoZTwicK
X-Google-Smtp-Source: ALg8bN6Cwl8ROIkweJm2FsP1YoVixj9W+N7e5J2Nf/JTTUJGzUjmi39DK0UExdm9j9dAbsz4BvfZCQ==
X-Received: by 2002:a19:54d7:: with SMTP id b84mr15558353lfl.131.1547996364994;
        Sun, 20 Jan 2019 06:59:24 -0800 (PST)
Received: from [192.168.1.36] ([31.134.130.226])
        by smtp.gmail.com with ESMTPSA id 12-v6sm1729459ljf.96.2019.01.20.06.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 06:59:24 -0800 (PST)
Subject: Re: [PATCH 1/1] rtc: add AB-RTCMC-32.768kHz-EOZ9-S3 RTC support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Artem Panfilov <panfilovartyom@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20190115110146.21180-1-panfilov.artyom@gmail.com>
 <20190115205545.GB2627@piout.net>
From:   tema <panfilov.artyom@gmail.com>
Message-ID: <c7b2eff7-4a7d-255b-a13c-86d9d79dd214@gmail.com>
Date:   Sun, 20 Jan 2019 17:59:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115205545.GB2627@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

I resubmitted my patches with a new subject and corrected FROM field including all fixes based on your remarks.

Thank you!
