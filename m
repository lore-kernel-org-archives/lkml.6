Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E4C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6D220830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JPrBnR4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6D220830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbeKGJNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:13:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33081 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeKGJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:13:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so3264937pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PvRdCeUv9lrfO5bDLD5hQ9E8Bby0+CLYXIqfRz+Gd1Q=;
        b=JPrBnR4dxGgxy4YHURFqa2BPfEtflcDS6ERTNr4bfA3/LpP8ATsZ/i3LjT0sq6tB2P
         7+m5IjA+PygK6W0jFPFI/KKekvcVCSXa6v2c+5Uu5G0iSBVWbbic+Qvi793OvqV7FJ7n
         qdFKVIhOg9hL9xhhr0t8eSYWUPKdZbUDpg8E5QIa4pG0u2tWqAHOhSVi0wEy1iRNB/J7
         0dkVRKr3j8aT6CNQE16L87DWdqxSfO6Kz1dXM6K07APmsbzXYHFuT10KbC9uGBy3buME
         xFXcO8MrXGlUSWD5D9KQz2CIG2j3itrYy64Lspaq1m1ODnUsa/K6sOhMxBgI6nJpxxQj
         pjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PvRdCeUv9lrfO5bDLD5hQ9E8Bby0+CLYXIqfRz+Gd1Q=;
        b=W3jw4+bQRiIOdoEIhOiobapgPHdHHh6a3s1RQEb5L5TB4pjlWVr/qQIlYzroDH5G7z
         k31LBPmtNwwe0ftI2BsAIO6cgZlnwLRXiGOtioVI5IzhfbHcd2I33078ws91bAh0CzKY
         HfaqQm3t9E8QNC8MLPU/v8WKaBr2nPy1pzzNtyN7xrmCfAn8VHG5fXn6aD/yXiuvUBYc
         K86A1Z4mV/97F1g4css5ZDjGWBkGu9hWGMnCNS4OgtgxCbvEO6c4aBHMOKvtx/F8Swz5
         iUaqXUDO1A2sDfwpMU2mbHImXXlh/nBeBBIXR2j3b2MqOBlHGNY7m3mnO7ewQW0JNhfr
         RLqg==
X-Gm-Message-State: AGRZ1gKnaxdeHz1oQuNpxuS5KJwbOo23m2AlXTeGWwcBo+QQVnNi1fUR
        8rPednRrRVym1YX1s18AKJnvFg==
X-Google-Smtp-Source: AJdET5f8pZdDNW2PflTzHiI+CBFFla7acp298E/06PjRQ/Hdk/EaVw8tQKjUw8svXfJqEUWwDcpcXA==
X-Received: by 2002:a62:9316:: with SMTP id b22-v6mr29063595pfe.193.1541547954745;
        Tue, 06 Nov 2018 15:45:54 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 22-v6sm14757457pfs.108.2018.11.06.15.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 15:45:54 -0800 (PST)
Date:   Tue, 06 Nov 2018 15:45:54 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 15:44:21 PST (-0800)
Subject:     Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
In-Reply-To: <CAK8P3a2c98VVPArCkdAR=-nnDBq1gYRCLDDgQB71eGiTSRdb4A@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>, vincentc@andestech.com,
        aou@eecs.berkeley.edu, alankao@andestech.com,
        greentime@andestech.com, linux-kernel@vger.kernel.org,
        zong@andestech.com, kito@andestech.com,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-19511b81-9f89-4a15-8b2f-d63779074fb4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov 2018 00:52:52 PST (-0800), Arnd Bergmann wrote:
> On 11/5/18, Christoph Hellwig <hch@infradead.org> wrote:
>> On Mon, Nov 05, 2018 at 02:58:07PM +0800, Vincent Chen wrote:
>>> Many thanks for kinds of comments. I quickly synthesize the comments and
>>> list them as below.
>>> 1. The kernel image shall include all vendor-specific code.
>>
>> I fundamentally disagree with this… and think it should be the contrary.
>>
>> 1. The kernel shall support no vendor specific instructions whatsoever,
>> period.
>
> I think what was meant above is
>
> 1. If a vendor extension requires kernel support, that support
> must be able to be built into a kernel image without breaking support
> for CPUs that do not have that extension, to allow building a single
> kernel image that works on all CPUs.

Yes.  I don't want anything that won't compile with upstream GCC, but I also 
don't want to have a Kconfig that says "make the kernel only work on $VENDOR's 
implementation".  I think this can be achieved, at least for the cases I've 
seen so far.
