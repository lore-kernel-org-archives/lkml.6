Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC48C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0EC21722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K6JuVchG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WMllu5D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0EC21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeHHMFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:05:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeHHMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:05:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8045160AD8; Wed,  8 Aug 2018 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533721619;
        bh=t0AkzAaMeaJ38N+qS9VvnU12hMFo1EB5+3NbnNCcv/Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=K6JuVchGPi+Ex4xOPkR5Ki4bhI0qYaDR4MzQ2uZSJpYQ3BJ0IqaA0QQ1nZWaOPCzr
         5H94DsycqvPCrsbd6uI4y+NhPKF0iXmCSTQCPTEjBFyRHjqYMFxeOKJX5CCwcfxfU7
         YP7BGAFBmwrCsfvqqHU6Mr8yWwmjjReGC6mt17Lc=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 530FC606CF;
        Wed,  8 Aug 2018 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533721618;
        bh=t0AkzAaMeaJ38N+qS9VvnU12hMFo1EB5+3NbnNCcv/Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WMllu5D3upUZ8wuUqhEUkX6d3R6EVlAC70f2r5fdYqDnFM4olyy+jnZVaH+qqos4g
         EAqdAbaVNTBWPcmmBsFYGK/vrz06Dnbck8EW4PZ8kEWZlb2hCvlTxS/NvCrGj5vXF0
         gD+Cru9vIa+dyIWrMzbOLihinPrJMtrTKx43A/lw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 530FC606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-drivers] mt76x0: Remove VLA usage
References: <20180807225040.GA2164@beast> <20180808092450.GA25772@redhat.com>
Date:   Wed, 08 Aug 2018 12:46:54 +0300
In-Reply-To: <20180808092450.GA25772@redhat.com> (Stanislaw Gruszka's message
        of "Wed, 8 Aug 2018 11:24:52 +0200")
Message-ID: <871sb942cx.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> On Tue, Aug 07, 2018 at 03:50:40PM -0700, Kees Cook wrote:
>> Even with "const" variables, the compiler will generate warnings about
>> VLA usage. In the quest to remove all VLAs from the kernel[1], this uses
>> a #define instead of a const to do the array sizing.
>> 
>> [1]
>> https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>> 
>> Fixes: e87b5039511a ("mt76x0: eeprom files")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> Please include this for the v4.19 merge window. The VLA was introduced
>> with the new source file (which I also note is missing a SPDX line), so
>
> I thought SPDX line is needed only if file has no license and eeprom.c
> file and other mt76x0 files have specified the license. Is SPDX still
> needed in that case ?
>  
>> +#define MT_MAP_READS	DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16)
>>  static int
>>  mt76x0_efuse_physical_size_check(struct mt76x0_dev *dev)
>>  {
>> -	const int map_reads = DIV_ROUND_UP(MT_EFUSE_USAGE_MAP_SIZE, 16);
>> -	u8 data[map_reads * 16];
>
> Why this is variable length array? DIV_ROUND_UP can not be calculated
> at compile time? But if so, macro do not change the situation either.

The commit log mentioned:

  "Even with "const" variables, the compiler will generate warnings about
   VLA usage."

So I guess the compiler (gcc?) is just not smart enough in this case?

-- 
Kalle Valo
