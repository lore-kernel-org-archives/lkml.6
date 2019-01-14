Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D437C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5C220656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547464722;
	bh=J1OPYW8CzSJtz4m6ki7tQYC6XDoJPGBHFuimYg4Ogdc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=KGO1Tw8ZGb4Pzn46bcLlXEqr7Q/kQArlRTV/lFOyY5AG1jUFrH3P/FW2ojfJDpsaa
	 qJQFgHzv/RHXcgsmUgGYstw9K5ljV3Euw7qa+fSiTh/3AgM8NNMGthxz0qEPBc1mz6
	 nFs4NJ+YTR7m5H39iZFjN7nBRdv9gqH6IeqhNqiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfANLSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:18:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:50062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfANLSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:18:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 537C0ADDD;
        Mon, 14 Jan 2019 11:18:38 +0000 (UTC)
Date:   Mon, 14 Jan 2019 12:18:37 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
In-Reply-To: <20190114084734.3362-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, Kai-Heng Feng wrote:

> A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
> but there's no input event from HID subsystem.
> 
> Turns out it reports some invalid data:
> [   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00
> 
> After some trial and error, it's another device that doesn't work well
> with ON/SLEEP commands. Disable runtime PM to fix the issue.

Thanks, I've now applied the patch to for-5.0/upstream-fixes. I am 
wondering though we are we seeing these at all - do other OSes not do the 
runtime PM on i2c at all?

-- 
Jiri Kosina
SUSE Labs

