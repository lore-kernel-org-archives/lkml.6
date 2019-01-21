Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E4DC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A5C21721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548110916;
	bh=vGnPOHyjS750d/ETn3s2GDv+4q+bFnQK1HQr4K5n/ag=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=D8zPydkSDmgylsGcnrLKRUiVh+chaToqNjYMH/NStJjUYs10PYWvXtXIQvzEm0sm6
	 v7UGMwszid5oU8a/LRojcNmrUrgw5HsZx2aGxBADgC0AQFPqWAJeMhjJfLo9j/URVl
	 UURc8P77r/VesKLw6fyaLeolQERcVw2HfeHp6HCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfAUWsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfAUWsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:48:35 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D292089F;
        Mon, 21 Jan 2019 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548110914;
        bh=vGnPOHyjS750d/ETn3s2GDv+4q+bFnQK1HQr4K5n/ag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UG+2KVFrIw6f064pP47m0odQekO2MEhCJUaaGMj+sFViDhwqIEZ2Jjhbgnb6p3rB+
         fLAwgeEX2JABwx7MwsYGSQDnge+CB4+LohbtpZCKNYow0XLMrhSRaz0Cfc+HWRyXQA
         ln/QNlYN8d/NhV8Ckafz3p1jUc48zWnbj+UndppM=
Subject: Re: [for next][PATCH 1/2] platform/x86: Fix unmet dependency warning
 for ACPI_CMPC
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190121224644.26903-1-okaya@kernel.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <23b1526a-b664-c4e3-2075-dd9cebe8c28c@kernel.org>
Date:   Mon, 21 Jan 2019 17:48:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121224644.26903-1-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/2019 5:46 PM, Sinan Kaya wrote:
> ACPI_CMPC selects BACKLIGHT_LCD_SUPPORT but BACKLIGHT_LCD_SUPPORT
> depends on BACKLIGHT_LCD_SUPPORT.

This should have been:

ACPI_CMPC selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
depends on BACKLIGHT_LCD_SUPPORT.
