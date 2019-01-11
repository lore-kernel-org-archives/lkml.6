Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B4CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C902321841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbfAKNuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:50:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfAKNub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:50:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6F388BD27;
        Fri, 11 Jan 2019 13:50:31 +0000 (UTC)
Received: from flask (unknown [10.40.205.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B5F260BF6;
        Fri, 11 Jan 2019 13:50:27 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 11 Jan 2019 14:50:26 +0100
Date:   Fri, 11 Jan 2019 14:50:26 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kvm: sev: Fail KVM_SEV_INIT if already initialized
Message-ID: <20190111135025.GF14852@flask>
References: <alpine.DEB.2.21.1901021255410.62182@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901021255410.62182@chino.kir.corp.google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 11 Jan 2019 13:50:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-01-02 12:56-0800, David Rientjes:
> By code inspection, it was found that multiple calls to KVM_SEV_INIT
> could deplete asid bits and overwrite kvm_sev_info's regions_list.
> 
> Multiple calls to KVM_SVM_INIT is not likely to occur with QEMU, but this
> should likely be fixed anyway.
> 
> This code is serialized by kvm->lock.
> 
> Fixes: 1654efcbc431 ("KVM: SVM: Add KVM_SEV_INIT command")
> Reported-by: Cfir Cohen <cfir@google.com>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---

Applied, thanks.
