Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D2420880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IyzvnFcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D2420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIZBxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:53:13 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:33879 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbeIZBxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:53:13 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a4c743fe;
        Tue, 25 Sep 2018 19:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=vAOoPO72O2HCnAf10jdy8vLrWQ8=; b=IyzvnF
        cyz/3zymXgQMGqPps5nM6YotWCrQJ9s//0WDoAsrZ1dV4pqeO3KoZNpeobVfXf4C
        atbxILjWwmudk6YO/L6HuFv6CejaCggv1ieHBOpne4ROm7TGnC3uMob+0Wv5IQYj
        mx64veSfhnPqvPcBeyyRURHE9akB+Kb20dSQ6C0yRw0pNhvYZbksyb2hSofXS9cS
        jpKt+qNlalWFavTGpNpGYLOmK7pua+YWPjM5l33xQRii9vi95gaqH/TD6Hkqs2vD
        czZQHJ1Qzs6eFI9TkyXTV9Ba0ytC8IK4CPeD+wHBczM4qMyvU+sUMPdJL2KS213h
        bemSBiBSFR1FuMyA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5d93db00 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 25 Sep 2018 19:25:36 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id i12-v6so25755644otl.1;
        Tue, 25 Sep 2018 12:44:03 -0700 (PDT)
X-Gm-Message-State: ABuFfoh1UDuKKV1b+QLAOJxbUQ9u5gTgIh1fGaKoiJEFF3MOEi0ZkGgm
        oW4pUjYtQkuhlYU8LHHK6lB2i29NwxryumsUs+E=
X-Google-Smtp-Source: ACcGV635Ij08MxYN1dfx7BcYpAgKr5VFR6MioDtneQHkNBy+ClgB7HMEdrW1zPlPTNtRFRGYRy3kSCQEbp1Nhtywtgc=
X-Received: by 2002:a9d:48a8:: with SMTP id d37-v6mr1928430otf.384.1537904642404;
 Tue, 25 Sep 2018 12:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-3-Jason@zx2c4.com>
 <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
In-Reply-To: <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Sep 2018 21:43:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
Message-ID: <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/23] zinc: introduce minimal cryptography library
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 8:33 PM Joe Perches <joe@perches.com> wrote:
> I think the -Dpr_fmt is especially odd and not
> really acceptable as it not used anywhere else
> in the kernel.

There are about 2000 cases in the kernel of the same '#define
pr_fmt...' being pasted into the top of the file, which seems a bit
cumbersome. Rather than having to paste that into each and every file
that I pr_err from, why can't I just do this from the makefile, since
I want that same pr_fmt to copy the whole directory?
