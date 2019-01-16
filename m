Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A5DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE2F20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393530AbfAPO3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:29:52 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:11743 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbfAPO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:29:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,486,1539648000"; 
   d="scan'208";a="84673597"
Date:   Wed, 16 Jan 2019 15:29:43 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] xen-blkback: do not wake up shutdown_wq after
 xen_blkif_schedule() is stopped
Message-ID: <20190116142943.b4nlpoaeitn6esb2@mac>
References: <1547646461-29803-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547646461-29803-1-git-send-email-dongli.zhang@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:47:41PM +0800, Dongli Zhang wrote:
> There is no need to wake up xen_blkif_schedule() as kthread_stop() is able
> to already wake up the kernel thread.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

kthread_stop waits for the thread to exit, so it must obviously wake
it up.

Thanks, Roger.
