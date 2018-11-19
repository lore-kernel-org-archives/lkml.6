Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443A6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1094A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1094A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbeKTGnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:43:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44635 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbeKTGnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:43:06 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAJKHeVa2706260
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 19 Nov 2018 12:17:40 -0800
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
To:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>
References: <20181119184556.11479-1-bp@alien8.de>
 <CALCETrV34q-BP2w8A1s82-a8Hg062=RYzk+SCOa31W7ftsznPA@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <a1b79c06-ab34-e774-df6b-c98323b13bae@zytor.com>
Date:   Mon, 19 Nov 2018 12:17:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CALCETrV34q-BP2w8A1s82-a8Hg062=RYzk+SCOa31W7ftsznPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 11:52 AM, Andy Lutomirski wrote:
> 
> I thought I benchmarked this on Intel at some point and found the
> LFENCE;RDTSC variant to be slightly faster.  But I believe you, so:
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 

As long as the difference isn't significant, the simplicity would seem to be a
win.

	-hpa
