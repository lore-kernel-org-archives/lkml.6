Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5F160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7345E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7345E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nomi.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeG3Qfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:35:41 -0400
Received: from ackle.nomi.cz ([81.31.33.35]:54700 "EHLO ackle.nomi.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbeG3Qfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:35:41 -0400
Received: from localhost (notes.lisk.in [IPv6:2a01:430:1::115:4])
        by ackle.nomi.cz (Postfix) with ESMTPSA id F194B9F10A;
        Mon, 30 Jul 2018 17:00:15 +0200 (CEST)
Date:   Mon, 30 Jul 2018 17:00:15 +0200
From:   Tomas Janousek <tomi@nomi.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Ming Lei <tom.leiming@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180730150015.bpgckk73e3jyz4zc@nomi.cz>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
 <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
 <20180730075949.GA1755@xps.pks.im>
 <20180730115002.GA6972@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730115002.GA6972@ming.t460p>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Mon, Jul 30, 2018 at 07:50:03PM +0800, Ming Lei wrote:
> Now runtime PM is still enabled for sd/sr, and I believe the following
> patch is needed until we figure out one perfect way for supporting it
> well:
> [...]
> +		pm_runtime_disable(dev);

Awesome, thanks for the quick reaction! :-)

(I don't happen to have a .config for the hardware I'm experincing the problem
on, so don't expect a Tested-By from me, but I don't see why it wouldn't fix
the issue, and it did for Patrick.)

-- 
Tomáš Janoušek, a.k.a. Pivník, a.k.a. Liskni_si, http://work.lisk.in/
