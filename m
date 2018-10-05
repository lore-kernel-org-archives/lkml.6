Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B620C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CE9208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CE9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeJFCcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:32:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58983 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbeJFCcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:32:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 706E320731; Fri,  5 Oct 2018 21:32:04 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 31C2220701;
        Fri,  5 Oct 2018 21:32:04 +0200 (CEST)
Date:   Fri, 5 Oct 2018 21:32:03 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
Message-ID: <20181005213203.247c369f@bbrezillon>
In-Reply-To: <CAPybu_01Bn5qmv91Pc-DExCAMheJyGYxiSvmGDUGiSxBA+S0DQ@mail.gmail.com>
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
        <20181004142942.11887-2-ricardo.ribalda@gmail.com>
        <20181005002125.12fd229f@bbrezillon>
        <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
        <20181005090811.6b7e9957@bbrezillon>
        <CAPybu_38xH2Cv+eONQmEJ1i6k=oiQM=WrcwOFR29LbtRvWfKXA@mail.gmail.com>
        <20181005103730.57d52e3c@bbrezillon>
        <CAPybu_1RMcro3xLNW5mbybYdObCTq=QwXgk+RT6hcmRGTh6s7A@mail.gmail.com>
        <20181005121235.7e64b64a@bbrezillon>
        <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
        <20181005141057.0f1b0a9b@bbrezillon>
        <CAPybu_0OZR==4k5nxVRZ-1NjPEXLQsun7QhnYds8dPndreUjcQ@mail.gmail.com>
        <20181005165234.468d2397@bbrezillon>
        <CAPybu_1cd9aJN9mC9m36Gd_fhU5UnfLH9EtU0h8BvJCZchOV_A@mail.gmail.com>
        <20181005182931.172b8f1c@bbrezillon>
        <CAPybu_01Bn5qmv91Pc-DExCAMheJyGYxiSvmGDUGiSxBA+S0DQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 20:12:43 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> 
> I think I know what might be the issue. on cfi_cmdset_002.c
> cfi_amdstd_reset can be called in parrallel to cfi_amdstd_destroy.
> 
> maybe we should call
> unregister_reboot_notifier(&mtd->reboot_notifier);
> before
> cfi_amdstd_reset(mtd)
> 
> need to try that on real hw with some strategical printfs :P. But that
> will ahve to wait til Monday

No problem, nothing urgent here. Have a nice weekend.
