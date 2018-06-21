Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2631C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C13120837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdJfUHgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C13120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933095AbeFUNuT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:50:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43682 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeFUNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:50:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so3274427wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSO0HRDh27lKhYNPW3XoEdh56bJ4D1szLLRwTXoEfLM=;
        b=jdJfUHgL4uYwncsmTnXHmXCVQCW+fxv1SlG+/qA3T3Eo3Zm6bZ4dZ/lRhM0c/FhKFV
         W3uHCM7SxW+QKNUN3TFqsT5LJdSw/vORcGz1kV0NyPEBtYTdVVLlJuC7R/BDXVXwIQz8
         wbpKnfUlI4Mn1f+Uqs1/afK/YD24R1u2Pyau2hLM866vxX/azydZwvwq/lgTNI1VE021
         P0MuuoXRhBC62qayO9JdmDklUPiEPHlh/oFtcSjf9l3xlXicafcS78CUHIHr5FqYgdZz
         Bs4AGAPV4AA93H8WahpGYGDsbfxC7ZgD+vNAkWaIKPHW5gluFXm3fJ2n5t6yZZ+jWohq
         jdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSO0HRDh27lKhYNPW3XoEdh56bJ4D1szLLRwTXoEfLM=;
        b=IQv+9VCJzdFO4HKRXo8MLGhrDhunUpLSylBm0tH3e0VrwLaHzPnkeTOavPt86eve93
         n3i8Fnt63Yfhj/yQBQajomjIXbqxH8C1A6YxU7nAk0zaNHOaWyEFpvp91n0Y6XPs8hI8
         AdVVRji0oXfxmjze8mfoQAhJAb1i1elIBOh4t7tw20gaJwuQ2rkEuk9g33MOMYrLKu7V
         UjeM32xh5y2HcWYe8Gdpv/U81p/+TgMXwrisZLh6jBZ6KQijmAJm4J2qRFOc/vEXouiI
         1E29bPlmoDZkPvhHROLYkVjEgZiIYaWU5yfsL4ztqaJl20iYcKCg8vXPXU9qQbayHosk
         ojEA==
X-Gm-Message-State: APt69E0lDtpjzYtUDB5AubF83b8kyla8hBpS1J9Ppn5YCCAwYIl8AZiO
        h6o2bHsRiz+u+scdBenxBCRC2Q==
X-Google-Smtp-Source: ADUXVKJ/gskjpBKreARJwT8K2nj8S8gcE1fV4LnzeXNjtCTSAH41xMBAXG8fkvd7hxPzk6LTHjxj/w==
X-Received: by 2002:adf:afe3:: with SMTP id y35-v6mr23809353wrd.176.1529589017046;
        Thu, 21 Jun 2018 06:50:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r11-v6sm5632303wrn.34.2018.06.21.06.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 06:50:16 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:50:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] semaphore: use raw_spin_lock_irq instead of
 raw_spin_lock_irqsave
Message-ID: <20180621135014.GA31371@gmail.com>
References: <alpine.LRH.2.02.1805301120180.3104@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1805301120180.3104@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mikulas Patocka <mpatocka@redhat.com> wrote:

> The sleeping functions down, down_interruptible, down_killable and
> down_timeout can't be called with interrupts disabled, so we don't have to
> save and restore interrupt flag.
> 
> This patch avoids the costly pushf and popf instructions on the semaphore
> path.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  kernel/locking/semaphore.c |   21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)

I've applied this to the locking tree, I suspect we can do this on the condition 
that it doesn't explode in early boot code (which has irqs disabled) and doesn't 
generate early boot lockdep splats either.

Thanks,

	Ingo
