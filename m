Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5869C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E4426CBE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E4426CBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeFZPBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:01:48 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33076 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeFZPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:01:46 -0400
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so16312922oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IeRJqtCb6u37ZiRjnoecCIdORLnSm5nvg4cyKtipbg=;
        b=nXjZ/T4dO8D3Ej0oVHoFP0kL2OZIJHtmFuaunxX1HGqlxzrtxMB/8/8NA/yEyeGAv2
         jiE7WmT00GIfyFv5ec0b2CQgubhxbFa70Feg0nuJw9JfNKxs0JiskmgQzGcdeZYni8V+
         8tASnMuU/lJ3fH6UHmB9snYkdPD0nWzQrl42nbnY25Gy/wWlsU/OC+Ov2cuSgteEB30C
         NJ9A2sXuvzOM2NQqfW5BTj4CKKbk8liv+a32mE4Kpq/qk5VfpkzxH6oOI+3th+OLcy+5
         4lgzFcQRy67eiIE4kyIDKQy10fEJP0dxqETLLfR6SOK9BKHGmT4fb0Xz59MFNnce+wox
         WVIw==
X-Gm-Message-State: APt69E3S5S7y949AT/tjiYFiUZj2GkuI6VZ93lSBUsXdxFdY368rIdfa
        gE8P6UjktnL3AcShHQoFPboLS5+H7LJDClJwGXqoRQ==
X-Google-Smtp-Source: AAOMgpez4DWM+kfiJAGa++mmFi2qRduZlmSuIhvdbc6g/rWG91+GZ1/ycgFehlpCwNTxOVbeTchOcQrsSQPkrqlyJh0=
X-Received: by 2002:aca:5585:: with SMTP id j127-v6mr1034285oib.202.1530025305429;
 Tue, 26 Jun 2018 08:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com> <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com> <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
 <73b7e4e3712074b73f4ac8211699d24dfdced6bf.camel@linux.intel.com>
 <CALCETrXos3b-VJxLCb1nwP1x2s5jiDmuQDWVahTVdXGxhqqsDw@mail.gmail.com> <689641dc26a91f7b4b6bfdb763fec90bf7c3e984.camel@linux.intel.com>
In-Reply-To: <689641dc26a91f7b4b6bfdb763fec90bf7c3e984.camel@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Tue, 26 Jun 2018 11:01:34 -0400
Message-ID: <CAOASepOq52tmDx5ycd6hDhKg9_+beZ0Y8zoVeOBbJu=LX8_2mA@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     jarkko.sakkinen@linux.intel.com
Cc:     luto@kernel.org, sean.j.christopherson@intel.com,
        jethro@fortanix.com, Neil Horman <nhorman@redhat.com>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:44 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, 2018-06-25 at 08:45 -0700, Andy Lutomirski wrote:
> > I'm personally rather strongly in favor of the vastly simpler model in
> > which we first merge SGX without LE support at all.  Instead we use
> > the approach where we just twiddle the MSRs to launch normal enclaves
> > without an init token at all, which is probably considerably faster
> > and will remove several thousand lines of code.  If and when a bona
> > fide use case for LE support shows up, we can work out the details and
> > merge it.
>
> Andy, I was going to propose exactly the same :-)
>
> We can upstream SGX that supports only unlocked MSRs and that does
> not preventing to upstream support for locked MSRs later. Even if
> we had a consensus for locked MSRs, making two milestones for the
> mainline would make perfect sense.
>
> I came into this conclusion last night because all the other review
> comments not concerning the launch control are easily sorted out.

+1. Let's do this and get it merged without launch enclave support
lockdown now. We can revisit this once we have hands on experience
with the technology.
