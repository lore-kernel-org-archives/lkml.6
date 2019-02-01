Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B7FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3C421726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfBASUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:20:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:33294 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfBASUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:20:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 10:20:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="271812090"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.14])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2019 10:20:40 -0800
Date:   Fri, 1 Feb 2019 10:20:40 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/2] KVM: SVM: move the SEV command handling into a
 separate file
Message-ID: <20190201182040.GD12454@linux.intel.com>
References: <20190201164654.3888-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190201164654.3888-1-brijesh.singh@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 04:47:12PM +0000, Singh, Brijesh wrote:
> svm.c is pretty huge, before we add more SEV specific commands (e.g SEV-ES,
> SEV-Migration etc) lets move the SEV command handling into a separate file.
> There is no logical changes in this series.

Any reason not to create arch/x86/kvm/svm/ before introducing sev.c? 

> The patch is based on motivation from this thread:
> https://marc.info/?l=linux-kernel&m=153910240507399&w=2
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> 
> Brijesh Singh (2):
>   KVM: SVM: move common struct definitions to header file
>   KVM: SVM: move the SEV specific function in a separate file
> 
>  arch/x86/include/asm/svm.h |  155 +++++
>  arch/x86/kvm/Makefile      |    2 +
>  arch/x86/kvm/sev.c         | 1076 +++++++++++++++++++++++++++++++
>  arch/x86/kvm/sev.h         |   40 ++
>  arch/x86/kvm/svm.c         | 1234 +-----------------------------------
>  5 files changed, 1296 insertions(+), 1211 deletions(-)
>  create mode 100644 arch/x86/kvm/sev.c
>  create mode 100644 arch/x86/kvm/sev.h
> 
> -- 
> 2.17.1
> 
