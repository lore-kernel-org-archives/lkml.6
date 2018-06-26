Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA25CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679C1219E7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHp7qaY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679C1219E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeFZHRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:17:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44002 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeFZHRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:17:09 -0400
Received: by mail-wr0-f194.google.com with SMTP id c5-v6so4885804wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0gMSjV+NKILsP+I551i/YZUQOki/c2LrqnzxYGoR1hA=;
        b=fHp7qaY9fxCZX4PT1VPfFTSKl6TxL2IFfwcyQkSlF9Z9wdOT7wFsZRynd9nFcseokG
         FdzSRtdLKdqThRZEQwyrFZmeQp0SXg4gMc7OrTKXhxIgVn97mJdZiiyV/HThuczCC6J0
         FM9Ve4dXiSyieAMykZpR8SCMvmIwDyOmafOJPfAXEhUYYuNvuA9QMTucBlQO8V5iiFis
         UgTwYipHuDIgIEBQoU7TYhKaiFcGEqpAyOmj//YTUoRjrRY25YQO4NOkyXODlpcyli9s
         1FOB2HsYkNDShKKu7BiXNtHl+JN5dbYKLSLlo4Ribx3q3M5ozmUTXVGmN5EYZHKLgZik
         Vqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0gMSjV+NKILsP+I551i/YZUQOki/c2LrqnzxYGoR1hA=;
        b=IWsGlCUAbmJ3XH2Mu6rzdM7H5jok5ELXBup/uapLvbRHhp5Y/K5WCsXMvaLIvYPZ+W
         omSoNuZHcvSetOp8TiJsmDcmNb5OlgWtPMYI9gNArXTmrzl4vFIcGO5Wzx+doZrQU7ki
         J0umyAVSQkZOEp8jRzBMZs9YBGMKdDketnc2Bqm0Qvtl2xthDmpbXeDv0xlijTncZ1tZ
         Q1kB8g6Yxe8+5K1g4L5hVkQrhldnH51Vov8qdamrYTy8wqLovtpUAEGxoaKsFCMnWwBJ
         TW2+J4+zIZIwaMrK96jebNJYYWydk9KrgN4bqyNk7a0sJ4nv9SYoQhR/vGYzGDxKyusb
         Pdxw==
X-Gm-Message-State: APt69E2MuOS7R/nzD3rALjvbhHtpiuXv7YU6ijnWKEsZvyH1Mrv2JJ7t
        fJvOqcDvOcH65RqvbExvBEj01Q==
X-Google-Smtp-Source: AAOMgpf2xtZkQzObpA4IXGaRdXC3PfhwEWROBGHT1JtOG72NvpebXAh1l2qxOBXmDNimc2HTRV8r5A==
X-Received: by 2002:adf:9736:: with SMTP id r51-v6mr342366wrb.5.1529997428415;
        Tue, 26 Jun 2018 00:17:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c201-v6sm1230791wmh.18.2018.06.26.00.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 00:17:07 -0700 (PDT)
Date:   Tue, 26 Jun 2018 09:17:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jan Beulich <JBeulich@suse.com>
Cc:     mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: use 32-bit XOR to zero registers
Message-ID: <20180626071705.GB26761@gmail.com>
References: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms

Please write out the consequence of that in the changelog.

Thanks,

	Ingo
