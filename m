Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1432EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FC6216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FC6216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeI1DBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:01:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:01:48 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5d6P-0002ve-0S; Thu, 27 Sep 2018 22:41:37 +0200
Date:   Thu, 27 Sep 2018 22:41:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
cc:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 0/3] mm: Fix for movable_node boot option
In-Reply-To: <20180925153532.6206-1-msys.mizuma@gmail.com>
Message-ID: <alpine.DEB.2.21.1809272241130.8118@nanos.tec.linutronix.de>
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Masayoshi Mizuma wrote:

> This patch series are the fix for movable_node boot option
> issue which was introduced by commit 124049decbb1 ("x86/e820:
> put !E820_TYPE_RAM regions into memblock.reserved").
> 
> First patch, revert the commit. Second and third patch fix the
> original issue.

Can the mm folks please comment on this?

Thanks,

	tglx
