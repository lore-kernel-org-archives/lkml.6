Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yVqPJBzLGlvdXgAAmS7hNA
	; Fri, 08 Jun 2018 18:50:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 716DC607E4; Fri,  8 Jun 2018 18:50:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVXSB4/6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CDC9C6074D;
	Fri,  8 Jun 2018 18:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDC9C6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeFHSuc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752653AbeFHSu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:29 -0400
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com [209.85.128.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC7D4208AF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528483829;
        bh=l6Rri0Zj7MpUVqwPnqMfWr256Ssc6j6ehlN5TZdVNZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UVXSB4/6WoNB5318eUuOVPDmgepehmzuffVBESNP39QRwwkI3AD5yxewku5u7oIFI
         SzBnGLFabyAi1nhL8jE5Sfea9gpnYS1Wx9Cc/pVMRD4CrXsr/X2GCLOpRwRFNgm1fH
         OTLGwbFOeRCuaVOCdh3ciadACgc31gyU5JqHleRc=
Received: by mail-wr0-f171.google.com with SMTP id e18-v6so6085503wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 11:50:28 -0700 (PDT)
X-Gm-Message-State: APt69E0If3ovECxh29xapo1B1BTbAso4e6m75K0h4lHl7nZWF1XH93Ty
        Ficc5RfzmGBtpkQb/+JinJTKnKOxeT5VnIsIr9jUQg==
X-Google-Smtp-Source: ADUXVKLv7bTeSjWPG0bKqoVtNMQkQ8AN1LAt6nBp8LyIoV97friE4f/mItk7RvCZFaJq/EtvxaZZABJaqeD6pjl5P8w=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr5732327wrd.67.1528483827349;
 Fri, 08 Jun 2018 11:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com> <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 8 Jun 2018 11:50:14 -0700
X-Gmail-Original-Message-ID: <CALCETrWSDVdrrVbvEbOH06OQcBkGF-M9R5WQkQ0r4qK2oAL3vQ@mail.gmail.com>
Message-ID: <CALCETrWSDVdrrVbvEbOH06OQcBkGF-M9R5WQkQ0r4qK2oAL3vQ@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 10:32 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> The Launch Enclave (LE) generates cryptographic launch tokens for user
> enclaves. A launch token is used by EINIT to check whether the enclave
> is authorized to launch or not. By having its own launch enclave, Linux
> has full control of the enclave launch process.
>
> LE is wrapped into a user space proxy program that reads enclave
> signatures outputs launch tokens. The kernel-side glue code is
> implemented by using the user space helper framework.  The IPC between
> the LE proxy program and kernel is handled with an anonymous inode.
>
> The commit also adds enclave signing tool that is used by kbuild to
> measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
> to a PEM-file for the 3072-bit RSA key that is used as the LE public key
> pair. The default location is:

It might be nice to use the infrastructure that Alexei added for
bpfilter (the umh_blob stuff) here, which is slated for merging in
this merge window.

--Andy
