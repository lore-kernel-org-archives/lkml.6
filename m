Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64EEC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F52085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkI01UZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9F52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbeKFBCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:02:01 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37653 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbeKFBCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:02:01 -0500
Received: by mail-wr1-f52.google.com with SMTP id o15-v6so6394586wrv.4;
        Mon, 05 Nov 2018 07:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02bOhCHBesihwLnC3tAdkTJYjhPWZSYIZbVWOEh/Hu0=;
        b=nkI01UZs6gz+lkzTQUlg+7gJrpxLbR7iL8iZAHCw9JA1DI0HOt34hgfe0wSiXpPN0L
         JoaWTGogwCxvAuRhyslzfhlVt037lwui/TpgytpEBknpri5QElwf3o2pzYBqj3/zajI8
         +90mCB2wOqsZkLU7pAqDZaqkJwPjbY1PeY838KALifbrjUZmyrBeNCEv04UnHcz+hX6J
         RjQDYL2IwqJvTIzH414rWVI1EOhFDwbgkXospDe0OauatGtaGazw/dV2KaJ99w1U1NmP
         HinSe7i7vxCntZseWK/Iphv99Jxjw2qx01GBVFYXOGHjbu+Tfp0DG4AjuZOsByQEN5cK
         Y7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=02bOhCHBesihwLnC3tAdkTJYjhPWZSYIZbVWOEh/Hu0=;
        b=HQJcK1yjQhbeqosxt2RhiuMnMMEI5vQhCiJc44ipMeQQNHfKA2m6G3k0Q1YL0pmTT1
         wdsaYBAbXggbgtqc6rgRtJf96HP4+C9wFWZyCXcpHX1RBF4GPD8LjdOQqesOdNcmQJrn
         3BrWo+UJWcHxO7g60OXGnXFmQtoodm1Ky2iEXmYee39XZqtARDvkdjx6usHOjrogbP3K
         alb++jobo4TjikU15dy6s3REQOF0vXNcl8dBRboPpHpbfnI7J8uXNANYYHnkhM9LEe87
         EVQnN7r8nqI+N/ybfO7jfNXAWCZyPPrIrkU1mcg5rjy0X1FGhdeRhUzgMf0ZeiWN+2rM
         e6AQ==
X-Gm-Message-State: AGRZ1gI8OgVT1RZkyyJZKVyr5kNT6c2HKpMRctTB0RRoaAANxxPVU347
        egZ9E0BS7eVs3YoHc1yz8CsVujaz
X-Google-Smtp-Source: AJdET5f+l8tZtiRNuj9nLFR6E8UXeklWKSAmn7JJv1IyRWYMX6IC8IQ04rQklmgpKdn8tJIIFzBh4Q==
X-Received: by 2002:adf:dc87:: with SMTP id r7-v6mr21658132wrj.143.1541432502871;
        Mon, 05 Nov 2018 07:41:42 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a7sm7429687wrx.26.2018.11.05.07.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 07:41:42 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:41:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org, shai@scalemp.com, jgross@suse.com,
        eial@scalemp.com, hpa@zytor.com, tglx@linutronix.de
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/vsmp: Remove dependency on pv_irq_ops
Message-ID: <20181105154139.GA124398@gmail.com>
References: <1541404864-31603-1-git-send-email-eial@scalemp.com>
 <tip-7f2d7f8190d856949d8aaab55d3902cd10ea1048@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-7f2d7f8190d856949d8aaab55d3902cd10ea1048@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for Eial Czerwacki <tipbot@zytor.com> wrote:

> Commit-ID:  7f2d7f8190d856949d8aaab55d3902cd10ea1048
> Gitweb:     https://git.kernel.org/tip/7f2d7f8190d856949d8aaab55d3902cd10ea1048
> Author:     Eial Czerwacki <eial@scalemp.com>
> AuthorDate: Mon, 5 Nov 2018 10:01:04 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Mon, 5 Nov 2018 12:33:47 +0100
> 
> x86/vsmp: Remove dependency on pv_irq_ops
> 
> vsmp dependency on pv_irq_ops has been removed some years ago, but the code
> still deals with pv_irq_ops.

s/vsmp
 /vSMP

> +#if defined CONFIG_PCI

I don't think code was ever tested with PCI disabled?

The above typoed sequence of code accidentally evaluates to 'true' 
regardless of CONFIG_PCI.

Thanks,

	Ingo
