Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34404C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DC9214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DC9214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJJUXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:23:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbeJJUXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:23:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99608B09C;
        Wed, 10 Oct 2018 13:01:35 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        hch@infradead.org
Subject: Re: [RFC 4/4] gpio: sifive: Add GPIO driver for SiFive SoCs
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
        <1539111085-25502-5-git-send-email-atish.patra@wdc.com>
X-Yow:  Are we THERE yet?
Date:   Wed, 10 Oct 2018 15:01:29 +0200
In-Reply-To: <1539111085-25502-5-git-send-email-atish.patra@wdc.com> (Atish
        Patra's message of "Tue, 9 Oct 2018 11:51:25 -0700")
Message-ID: <mvmo9c22bx2.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 09 2018, Atish Patra <atish.patra@wdc.com> wrote:

> +static void sifive_set_ie(struct sifive_gpio *chip, unsigned int offset)
> +{
> +	unsigned long flags;
> +	unsigned int trigger;
> +
> +	raw_spin_lock_irqsave(&chip->lock, flags);
> +	trigger = (chip->enabled & BIT(offset)) ? chip->trigger[offset] : 0;

This should use test_bit instead.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
