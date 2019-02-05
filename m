Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BA920844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lHmUoXPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfBEJSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:18:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbfBEJSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:18:53 -0500
Received: from zn.tnic (p200300EC2BCB6B0041C3B5D5EB4D55D2.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:41c3:b5d5:eb4d:55d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4CA01EC02AE;
        Tue,  5 Feb 2019 10:18:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549358330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=27z0ZYNcv37KAn9EWdpLBTvefC4+qLAJthht315+v24=;
        b=lHmUoXPYkWLZS/JSO0PVbQzoLRAdR0EjlaGqBzoguPTBfePCmw46XVjYaic1MT6q92G6I6
        JRB/OdTUe32hWMX2ytZm5EDzC9y4VLLamRgY2c333m92lAfUlzBCTXfy1SDy+YCiil6x9G
        6ps4QH+9C5H1UYRDZu1yx+DDOiyUr+M=
Date:   Tue, 5 Feb 2019 10:18:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 05/20] x86/alternative: initializing temporary mm for
 patching
Message-ID: <20190205091841.GI21801@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-6-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129003422.9328-6-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just nitpicks:

Subject: [PATCH v2 05/20] x86/alternative: initializing temporary mm for patching

s/initailizing/Initialize/

On Mon, Jan 28, 2019 at 04:34:07PM -0800, Rick Edgecombe wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> To prevent improper use of the PTEs that are used for text patching, we
> want to use a temporary mm struct. We initailize it by copying the init

Please remove the "we" from commit messages and use impartial, passive
formulations.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
