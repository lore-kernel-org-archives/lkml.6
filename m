Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2047C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D9F20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RXg2/eCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfAOR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:27:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50004 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfAOR1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:27:08 -0500
Received: from zn.tnic (p200300EC2BCBB40040287EAE02E8DE81.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b400:4028:7eae:2e8:de81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BF0D1EC0B83;
        Tue, 15 Jan 2019 18:27:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547573226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EFd20pgx9mtTvZzUi2nk5ogUWU08gx2D3kOqurxsfKU=;
        b=RXg2/eCZg6c/v/AGo6/VkQDl8k3b9dVBmhdcfS9K3ccXmiP2dqDcFE00oMM4leanEbAQBl
        qVcC3s8rXpN6SCoUAzgmqubQXdeCZ/U+XoOUmV296zsiHczq8MCddhudEVhsrfeoqz77yc
        lSoaNUL8bQlsMRGNbGmZG/Zqs3j7A98=
Date:   Tue, 15 Jan 2019 18:26:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Message-ID: <20190115172659.GE6596@zn.tnic>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
 <20190109220843.GK15665@zn.tnic>
 <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
 <20190114103312.GG2773@zn.tnic>
 <2ad4bb63-2b70-3652-3261-009cdbfc15a9@amd.com>
 <20190114153256.GM2773@zn.tnic>
 <4f8b532b-8613-feb5-7474-4bb0462cf1c7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f8b532b-8613-feb5-7474-4bb0462cf1c7@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:30:42AM +0000, S wrote:
> Please talk to your colleagues how to fix that. Adding some of them to
> CC.

Your mailer is still broken. How do you manage to have an empty From:?
Is your exchange client misconfigured?

> Let me know if you want me to fix this and re-send the 3 patches.

Well, please redo them by moving the quirk function to

  arch/x86/kernel/cpu/mce/amd.c

and call it from mce_amd_feature_init(). This will concentrate the code
more and won't need the globally visible function.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
