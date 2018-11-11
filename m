Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5BAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0695F20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FnNozWaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0695F20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeKLIEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:04:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39429 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeKLIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:04:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so3329753pla.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LqvdH7aWIUli3FTLPBfFtEufjMreDC9Q1EDWd0tjc9k=;
        b=FnNozWaMAPUNqnC649UESqVM97kb6TGA8VwmGxdYAVVd8jtOO7cnHF8gCdx8BEsVu+
         c40PYw4mWkkVjGVZ8CRM32kSL4l3cCKDxXAlieFe2kEJ4Pn7Rt4vJUvRA1/IUlmEPyHb
         iIUMhLx6c/QRflDMgzzcUk8vJ1HwQgZ/+try5WcTqYgg9Ud4ldyTPlTMmomAJAPrcoFr
         nAMNpqgu5i5kJ1qrK9LR6dm31C9qZDuzTxReHhyKpogLYDcPWlLvwf7YgiE6Q2MHrqVr
         KDowszebGWUBzeXxugTqwmW460d+TZBKEhoyXr34ivmuoZ8JNbAR36+8C+S0oNgpclRI
         B28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LqvdH7aWIUli3FTLPBfFtEufjMreDC9Q1EDWd0tjc9k=;
        b=sRO1qi1tOcYyM6YNthsaCcAUefYTP/YA4GOARFjeiuz8Y7GBVFWnbZRDkcNVOvueas
         AvJUmvmM1GO7mrMr4b083zAXx/s9WHQiWybz2MVB2o/vfjn1Tn08ByGOVa79vzHCk7Iw
         cFXuDtx8nXFfRWlMo/TT2JGBFt9adWqBpXZQpT3sC69OVaJHI+44rpZUSyND+0xH0pzG
         Jniq6ElGHrrtMSmnqcxKoS7DAnbmcy5uI1Dc0JVtvZ/G5M3/+Tq0VfzsgSY9UBnFdlCM
         cTcA9Yaq3vJa/pRvFPOr7ifqJ9cPKwPS2Xy+fc/6tfl/1q/Oz705Xt8LWFHQ118qLZMt
         jxrg==
X-Gm-Message-State: AGRZ1gI3mwk2u1eNiTUA4IkF27L12vbU8fpA20auP6bk1M/eh4zxLjMt
        QWCN9Tbiw55DAzwnfuIim0KHTA==
X-Google-Smtp-Source: AJdET5fS+f9PM+FljWJYtLfv0u2pZwTRzSKKWVmjECkBk2gXVxJ/noRYzjG/j1F048c+3skehr7AhQ==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7-v6mr17879403plk.282.1541974453584;
        Sun, 11 Nov 2018 14:14:13 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g8-v6sm15138725pfh.57.2018.11.11.14.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 14:14:12 -0800 (PST)
Date:   Sun, 11 Nov 2018 14:14:12 -0800 (PST)
X-Google-Original-Date: Sun, 11 Nov 2018 14:13:43 PST (-0800)
Subject:     Re: [PATCH] riscv: add S and U modes to ISA string
In-Reply-To: <7958aa50-8808-e909-753c-e232b3d1f84e@packi.ch>
CC:     david.abdurachmanov@gmail.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     me@packi.ch
Message-ID: <mhng-58f419dd-47a6-4540-91b6-08be173d4216@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2018 00:35:15 PST (-0800), me@packi.ch wrote:
> On 10.11.18 07:45, David Abdurachmanov wrote:
>>
>> The patch adds the missing S and U modes.
>
> This is the same patch I submitted earlier (see v2 here [1], based on
> Palmer's feedback). Palmer stated that the "S" extension should not be
> exposed to usermode.
>
> Since two people arrived at the same solution, I wonder if the
> supervisor mode should really be hidden from userspace, as it's about
> the CPU information, not about the environment the calling code is
> running as.
>
> [1] https://lkml.org/lkml/2018/11/10/96

I still think S should be hidden from applications.  This patch was fairly 
mechanical, so it probably just wasn't though about twice -- that's the problem 
with user ABI stuff, lots of times the obvious answer isn't the correct one :).

I'll take your second patch, I just haven't gotten around to actually fully 
reviewing patches yet as I'm still in my email triage phase.

Thanks!
