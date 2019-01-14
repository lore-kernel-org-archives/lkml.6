Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B79BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587232086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AxIjhBHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfANJKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:10:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41554 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfANJKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:10:17 -0500
Received: from zn.tnic (p200300EC2BC4CA00116FEC2D9C4463FB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:116f:ec2d:9c44:63fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 073A01EC058B;
        Mon, 14 Jan 2019 10:10:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547457016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jYgJ9rippeE05eN++d74VuemFMkxvzV21Ngj7PSw0/c=;
        b=AxIjhBHcPoaTkJz9f1/QIwq+To5GaFjZhP4wgVJ2cjoPc1WUzWuAm7KIo64eqn85htlyZ9
        PERGfBETJul2e+qwZPpmX0eBUg5tVQFUWqiDbS3GipZeG6jOdAKpyOmOxNNvK/s/Jg6duM
        7SgbX9Q1rkwuGyHbbPVeHr/hRsNWS/g=
Date:   Mon, 14 Jan 2019 10:10:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        k-hagio@ab.jp.nec.com, anderson@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190114091014.GB2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
 <20190111123300.GE4729@zn.tnic>
 <93c1969f-dcc7-4e34-75ff-b14f2ec15269@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93c1969f-dcc7-4e34-75ff-b14f2ec15269@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:52:14AM +0800, lijiang wrote:
> I would like to remove this variable and post again.

No, you should remove the vmcoreinfo export too:

kernel/crash_core.c:398:        VMCOREINFO_OSRELEASE(init_uts_ns.name.release);

after making sure userspace is not using it and *then* remove the
documentation.

But you can do that in a separate patch, so that it can be reverted if
trouble.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
