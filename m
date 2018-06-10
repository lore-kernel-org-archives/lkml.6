Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Km5bDaO5HFviTwAAmS7hNA
	; Sun, 10 Jun 2018 05:40:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B8F0607BB; Sun, 10 Jun 2018 05:40:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb5IrQ6o"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 98738602FC;
	Sun, 10 Jun 2018 05:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98738602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753739AbeFJFkG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753675AbeFJFkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:40:04 -0400
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609CE208B5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 05:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528609203;
        bh=7Kxr8xHZUMxV/9FgwnVdmEctGP4Xb1Jc9EDn+IgbP8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nb5IrQ6oz0R/sOG5q6Cko4teT8UWmYl5IGtatPXXx1SShqm+SYWd9MRP9Itm1AhfX
         69+vL2R5b1Hl8Hu9woVF1zHsyfkAc6FOAxTHwvK+NsOEZlHMJk8j5JG8ohnRE06JWH
         98+yolIsfz2KV1YF8ibnJfdZy4GUxD4ZnypZW6XQ=
Received: by mail-wr0-f176.google.com with SMTP id d8-v6so17057943wro.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 22:40:03 -0700 (PDT)
X-Gm-Message-State: APt69E0T1gWDpQcI0/gaqoHReKGMuN89QwHrtTF1TXtDZiwaHX24mXr2
        NyqS80eo5CrkG9FqhRFF050nEb9aQkg/Yif5+Lyxgw==
X-Google-Smtp-Source: ADUXVKLLQgn6RbUIwWEHd374M6sysUJEJPeK6Ka7gc3he8dgpqX4uP/bLg/VuXcoOWgPK8ZHUc5sZbs9qopE92oB37A=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr8979371wrd.67.1528609201663;
 Sat, 09 Jun 2018 22:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com> <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 9 Jun 2018 22:39:50 -0700
X-Gmail-Original-Message-ID: <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
Message-ID: <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
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
>
>   drivers/platform/x86/intel_sgx/sgx_signing_key.pem
>
> If the default key does not exist kbuild will generate a random key and
> place it to this location. KBUILD_SGX_SIGN_PIN can be used to specify
> the passphrase for the LE public key.

It seems to me that it might be more useful to just commit a key pair
into the kernel.  As far as I know, there is no security whatsoever
gained by keeping the private key private, so why not make
reproducible builds easier by simply fixing the key?

Also, this email is so long that gmail won't let me quote the relevant
code, but: what is the intended use case for supporting the mode where
the MSRs are locked but happen to contain the right value?  I could
see the case for bundling a key with the kernel and literally
hard-coding the acceptable MSR values (as in literal values in the
code, not even autogenerated hashes).  The only use case I've thought
of for the code as it stands is that $VENDOR could publish their LE
public key and some daft firmware vendor could get it into their head
that it would be a good idea to lock the MSRs to that value.  This
would add no security at all, but it would add a considerable about of
annoyance and loss of value, so I still tend to think that we
shouldn't support it.
