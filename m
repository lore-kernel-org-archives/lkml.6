Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8239222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbfBMNTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:19:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53482 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390491AbfBMNTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:19:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C669A1596;
        Wed, 13 Feb 2019 05:19:30 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B3D13F557;
        Wed, 13 Feb 2019 05:19:28 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:19:25 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/1] arm64: Use _rcuidle for smp_cross_call() tracepoints
Message-ID: <20190213131924.GD5875@brain-police>
References: <1549969765-3707-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549969765-3707-1-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 07:09:25PM +0800, Mars Cheng wrote:
> fix similar issue for aarch64 as the commit 7c64cc0531fa
> ("arm: Use _rcuidle for smp_cross_call() tracepoints") fixed
> in aarch32

I'm not convinced about this justification. As far as I can tell, the commit
mentioned above fixed a cross-call from the idle path as a result of
ARCH_NEEDS_CPU_IDLE_COUPLED, but this never appears to be selected on arm64
afaict.

Are you actually seeing a problem on arm64 in practice?

Will
