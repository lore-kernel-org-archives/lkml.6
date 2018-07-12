Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9E4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814CA2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AFXPYMsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814CA2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeGLOOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:14:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50268 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732482AbeGLOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:14:45 -0400
Received: by mail-it0-f65.google.com with SMTP id w16-v6so6990389ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TpD6zbFA7ZwjcJKwlUvpps1eFPEMqpf7d7h1cJ89TuA=;
        b=AFXPYMsTaLLYEwsTB1CRMSO6j7ROH/5n3yYnGUkCnKXMhsOpLJ7xpU35UwymRTXoMy
         oVcTMApaTQnyaLAOPY+ROfjDvAY+8+inTFBeoR4JvExQT9CLCns9y9eg0IMVj3Clq9AT
         CMWBwFN5ozSgsBzfYfBg82rYwFJVI+KXNfemlSmgGqLIcWOLbdywp9G4vD1H/5cNwSIk
         G838pVy4MkknsgAz8o1gLp1bAcujVaKzVKEksRP7yHEIGFr3td/AMHsiJ0+94ikoQ/bc
         wcKJ61+OZWGmoff2z+OdzcmG76Ko4OhMRsceAqfLsL1qEqVzqpDTLHiym3nQINjK2CNt
         ZZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpD6zbFA7ZwjcJKwlUvpps1eFPEMqpf7d7h1cJ89TuA=;
        b=SUftHMrH00yYz8BIO6jdrmhlmrp6J2PAlamKXbbdz/CiLv8IzIwAAZ0ex1L2avG6s8
         KNKoEvfQIQtEoHznJaixd/Wh+OS6wzDlIjEAIkVy3fwad+dw637wp5ih9icr2NaSpy4u
         AQtgMcT2mnUo0JMjMZDrt/y6lgJicadMeuRYleSOG+c9i7maPIUP/E692vzYnPshYJ24
         2wrZ17rlTvbFgF9hJvY+QZtgQaemJkRsFM6ujFvPCuQDhfx728d1rXSlGtaeRQORdoAD
         bvTgAIUdlnhP3FLbxg44oqm0I/5gr7pRkmXW40zKNBb/Oay0FRDPdIy/mxPLk3+Qzb8Q
         mbVQ==
X-Gm-Message-State: AOUpUlEcLtz2HwJJVLbtjCwlyDWgtV/NVQmhQtobhog4rwTQbvUAqMBe
        5Um+Lloc2391scv4zeKa67WTj/Z6MPE=
X-Google-Smtp-Source: AAOMgpfHWUfjKlK5530Jws1zrmTCuY4Y4/tnhAmcDTxVNg/ATSXMSa/xXoR8VWf5QJ7e6xIj3YXNLA==
X-Received: by 2002:a24:cc07:: with SMTP id x7-v6mr1373758itf.3.1531404301197;
        Thu, 12 Jul 2018 07:05:01 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2257679ioj.22.2018.07.12.07.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 07:04:31 -0700 (PDT)
Subject: Re: [PATCH] bsg: remove read/write support
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linux-foundation.org, tonyb@cybernetics.com,
        jannh@google.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180712080959.21180-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7882dce2-4dca-3af6-7aea-7acd9997f3e9@kernel.dk>
Date:   Thu, 12 Jul 2018 08:04:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180712080959.21180-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/18 2:09 AM, Christoph Hellwig wrote:
> The code poses a security risk due to user memory access in ->release
> and had an API that can't be used reliably.  As far as we know it was
> never used for real, but if that turns out wrong we'll have to revert
> this commit and come up with a band aid.
> 
> Jann Horn did look software archives for users of this interface,
> and the only users found were example code in sg3_utils, and optional
> support in an optional module of the tgt user space iscsi target,
> which looks like a proof of concept extension of the /dev/sg
> read/write support.
> 
> Tony Battersby chimes in that the code is basically unsafe to use in
> general:
> 
>   The read/write interface on /dev/bsg is impossible to use safely
>   because the list of completed commands is per-device (bd->done_list)
>   rather than per-fd like it is with /dev/sg.  So if program A and
>   program B are both using the write/read interface on the same bsg
>   device, then their command responses will get mixed up, and program
>   A will read() some command results from program B and vice versa.
>   So no, I don't use read/write on /dev/bsg.  From a security standpoint,
>   it should definitely be fixed or removed.

Applied for 4.19.

-- 
Jens Axboe

