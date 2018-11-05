Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F051C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A8E2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A8E2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbeKFBFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:05:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbeKFBFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:05:01 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJh37-0000JQ-5k; Mon, 05 Nov 2018 16:44:21 +0100
Date:   Mon, 5 Nov 2018 16:44:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     linux-kernel@vger.kernel.org, shai@scalemp.com, jgross@suse.com,
        eial@scalemp.com, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/vsmp: Remove dependency on pv_irq_ops
In-Reply-To: <20181105154139.GA124398@gmail.com>
Message-ID: <alpine.DEB.2.21.1811051644040.1566@nanos.tec.linutronix.de>
References: <1541404864-31603-1-git-send-email-eial@scalemp.com> <tip-7f2d7f8190d856949d8aaab55d3902cd10ea1048@git.kernel.org> <20181105154139.GA124398@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018, Ingo Molnar wrote:

> 
> * tip-bot for Eial Czerwacki <tipbot@zytor.com> wrote:
> 
> > Commit-ID:  7f2d7f8190d856949d8aaab55d3902cd10ea1048
> > Gitweb:     https://git.kernel.org/tip/7f2d7f8190d856949d8aaab55d3902cd10ea1048
> > Author:     Eial Czerwacki <eial@scalemp.com>
> > AuthorDate: Mon, 5 Nov 2018 10:01:04 +0200
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Mon, 5 Nov 2018 12:33:47 +0100
> > 
> > x86/vsmp: Remove dependency on pv_irq_ops
> > 
> > vsmp dependency on pv_irq_ops has been removed some years ago, but the code
> > still deals with pv_irq_ops.
> 
> s/vsmp
>  /vSMP
> 
> > +#if defined CONFIG_PCI
> 
> I don't think code was ever tested with PCI disabled?
> 
> The above typoed sequence of code accidentally evaluates to 'true' 
> regardless of CONFIG_PCI.

Grr. Indeed, missed that

