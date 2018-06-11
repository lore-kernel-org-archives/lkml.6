Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XrZZEs0FHltueQAAmS7hNA
	; Mon, 11 Jun 2018 05:17:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DD67360792; Mon, 11 Jun 2018 05:17:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ4pn4U+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 44445601D2;
	Mon, 11 Jun 2018 05:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44445601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754033AbeFKFR3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753901AbeFKFR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:17:27 -0400
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792FE208B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 05:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528694246;
        bh=Px+z5Pz5jkf3REYyRxS1ukk61cs7eI7Wi9HZ22hF1RI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OZ4pn4U+vROT2QmkXjjy4ZBR8TLcK7rH4K3a5Z9GOkgoxMNU8oby2zb5+1Jv6bbVf
         aa+KQEBBoAxIQgZ6Xlwwa+EBsSN0DkzD7ZD5FXODnq0LxdfgiWDQgJNwyaxNtPwjnR
         gEAJWeBvyoZpN8fRRqGh8II+Ex5Pec9LT3fTL3O8=
Received: by mail-wm0-f48.google.com with SMTP id l15-v6so9504189wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 22:17:26 -0700 (PDT)
X-Gm-Message-State: APt69E0ezc8G8t7uKDiPHJ88dnL9kD8nMoIe+A04QMwyptsl1+QLHaZX
        F35hnKe7dADrNsPUnJDoBjCAd2TpT9g2ph07B6dCGg==
X-Google-Smtp-Source: ADUXVKKFlt0yKBUGwFVwSkEZ6p5Ewp3omUW5bmnXbaqRW01F8dIie480jC3rr28LJiqCtZbmk/7y3X2fHnlI9CVVU9o=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr6553327wmi.46.1528694244840;
 Sun, 10 Jun 2018 22:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com> <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
In-Reply-To: <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 10 Jun 2018 22:17:13 -0700
X-Gmail-Original-Message-ID: <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
Message-ID: <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To: Andrew Lutomirski <luto@kernel.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
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

> On Jun 9, 2018, at 10:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Jun 8, 2018 at 10:32 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
>>
>> The Launch Enclave (LE) generates cryptographic launch tokens for user
>> enclaves. A launch token is used by EINIT to check whether the enclave
>> is authorized to launch or not. By having its own launch enclave, Linux
>> has full control of the enclave launch process.
>>
>> LE is wrapped into a user space proxy program that reads enclave
>> signatures outputs launch tokens. The kernel-side glue code is
>> implemented by using the user space helper framework.  The IPC between
>> the LE proxy program and kernel is handled with an anonymous inode.
>>
>> The commit also adds enclave signing tool that is used by kbuild to
>> measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
>> to a PEM-file for the 3072-bit RSA key that is used as the LE public key
>> pair. The default location is:
>>
>>  drivers/platform/x86/intel_sgx/sgx_signing_key.pem
>>
>> If the default key does not exist kbuild will generate a random key and
>> place it to this location. KBUILD_SGX_SIGN_PIN can be used to specify
>> the passphrase for the LE public key.
>
> It seems to me that it might be more useful to just commit a key pair
> into the kernel.  As far as I know, there is no security whatsoever
> gained by keeping the private key private, so why not make
> reproducible builds easier by simply fixing the key?

Having thought about this some more, I think that you should
completely remove support for specifying a key. Provide a fixed key
pair, hard code the cache, and call it a day. If you make the key
configurable, every vendor that has any vendor keys (Debian, Ubuntu,
Fedora, Red Hat, SuSE, Clear Linux, etc) will see that config option
and set up their own key pair for no gain whatsoever.  Instead, it'll
give some illusion of security and it'll slow down operations in a VM
guest due to swapping out the values of the MSRs.  And, if the code to
support a locked MSR that just happens to have the right value stays
in the kernel, then we'll risk having vendors actually ship one
distro's public key hash, and that will seriously suck.

I'm going to try to get this code working tomorrow.  I'll keep you
posted on how that goes.  Can you point me to the userspace bits (i.e.
something buildable that will run on a kernel with your patches
applied)?

>
> Also, this email is so long that gmail won't let me quote the relevant
> code, but: what is the intended use case for supporting the mode where
> the MSRs are locked but happen to contain the right value?  I could
> see the case for bundling a key with the kernel and literally
> hard-coding the acceptable MSR values (as in literal values in the
> code, not even autogenerated hashes).  The only use case I've thought
> of for the code as it stands is that $VENDOR could publish their LE
> public key and some daft firmware vendor could get it into their head
> that it would be a good idea to lock the MSRs to that value.  This
> would add no security at all, but it would add a considerable about of
> annoyance and loss of value, so I still tend to think that we
> shouldn't support it.
