Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E712EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25EC218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbeLVCaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 21:30:07 -0500
Received: from baldur.buserror.net ([165.227.176.147]:38708 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLVCaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 21:30:07 -0500
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1gaX37-0000Oj-C3; Fri, 21 Dec 2018 20:29:57 -0600
Message-ID: <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Nicholas Mc Guire <hofrat@osadl.org>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 21 Dec 2018 20:29:56 -0600
In-Reply-To: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: hofrat@osadl.org, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> devm_kstrdup() may return NULL if internal allocation failed, but
> as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> can be used here, which will only copy the reference.

Is it really going to only copy the reference?  That would require that
is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
of the kernel image.

-Scott


