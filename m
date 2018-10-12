Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6730CC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0BC2064E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0BC2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJMBKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:10:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:51210 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeJMBKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:10:32 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 07CD997E;
        Fri, 12 Oct 2018 17:36:57 +0000 (UTC)
Date:   Fri, 12 Oct 2018 11:36:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Robert Love <rml@tech9.net>, kpreempt-tech@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: preempt-locking: Use better example
Message-ID: <20181012113656.771e8dd1@lwn.net>
In-Reply-To: <1539004515-8152-1-git-send-email-andrew.murray@arm.com>
References: <1539004515-8152-1-git-send-email-andrew.murray@arm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Oct 2018 14:15:15 +0100
Andrew Murray <andrew.murray@arm.com> wrote:

> The existing wording implies that the use of spin_unlock whilst irqs are
> disabled might trigger a reschedule. However the preemptible() test in
> preempt_schedule will prevent a reschedule if irqs are disabled.
> 
> Lets improve the clarity of this wording to change the example from
> spin_unlock to cond_resched() and cond_resched_lock() as these are
> functions that will trigger a reschedule if the preempt count is 0 without
> testing that irqs are disabled.
> 
> Also remove the 'Last Updated' line as this is not up to date and better
> tracked via GIT.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

I've applied this, but that document is ... old.  It sure would be nice if
somebody found the energy to write a proper locking document for current
kernels...:)

Thanks,

jon
