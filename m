Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB85C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E5E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E5E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeIYTex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:34:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:51992 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbeIYTew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:34:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 942D62D5;
        Tue, 25 Sep 2018 13:27:18 +0000 (UTC)
Date:   Tue, 25 Sep 2018 07:27:17 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v14 19/19] x86/sgx: Driver documentation
Message-ID: <20180925072717.3a41af75@lwn.net>
In-Reply-To: <20180925130845.9962-20-jarkko.sakkinen@linux.intel.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
        <20180925130845.9962-20-jarkko.sakkinen@linux.intel.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 16:06:56 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Documentation of the features of the Software Guard eXtensions used
> by the Linux kernel and basic design choices for the core and driver
> and functionality.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  Documentation/index.rst         |   1 +
>  Documentation/x86/intel_sgx.rst | 185 ++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+)
>  create mode 100644 Documentation/x86/intel_sgx.rst
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 5db7e87c7cb1..1cdc139adb40 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -104,6 +104,7 @@ implementation.
>     :maxdepth: 2
>  
>     sh/index
> +   x86/index

So you're adding this reference to x86/index, but the actual file
(Documentation/x86/index.rst) doesn't exist; that will break the docs
build.  I do appreciate your doing your document in RST, though!

Who is the intended audience for this document?  I see a bit of UAPI
stuff that might be better placed in the userspace-api manual, mixed with
stuff that user-space developers are unlikely to take much interest in.
Might it be worth splitting this into two pieces?

Thanks,

jon
