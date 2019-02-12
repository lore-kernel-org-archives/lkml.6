Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477FCC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="k1ow3CGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfBLLFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:05:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36738 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfBLLFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:05:08 -0500
Received: from zn.tnic (p200300EC2BCF3C006825EAC4F825127B.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3c00:6825:eac4:f825:127b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EACC41EC01AF;
        Tue, 12 Feb 2019 12:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549969507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W11vQV0PIDv23vH8bSot59vkxXfYTOk8QO7jANZfpTU=;
        b=k1ow3CGJV8of6EnekGMJUUYYQkpuuSGxBoTTVBwyhlTauLu71UBIjZRTV3fZnmHQqfuIwG
        m+g1OogOtVG5pYuCsLQjTClevwYzkbMO+Qs5OOivb2r2Gzod2mAV1Ej8nJJix0DNelXXAk
        7dIFtlCs+kPaky7VhqGFVaabJVu9yGI=
Date:   Tue, 12 Feb 2019 12:05:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190212110501.GB30028@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz>
 <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:27:19AM +0100, Jiri Slaby wrote:
> Yes, they do not end up in the symbol table. But the macros make clear
> where is the start of the function and especially where is the end
> (something like closing bracket '}' in C). If you prefer not annotating
> local symbols, I can of course drop it from everywhere. But to me it
> looks more readable to see "here it starts" and "here it ends", still
> without generating anything to the symbol table.

Agreed. Boundary annotation makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
