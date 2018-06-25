Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511F7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BBE26149
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BBE26149
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeFYVG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:06:27 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42018 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeFYVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:06:25 -0400
Received: by mail-ot0-f194.google.com with SMTP id 92-v6so16650042otw.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fq7Qvko4bO77TBaoA3jFD93Lj7FAGEYEB+dfyb+A75g=;
        b=Ew9VhovEDW/fgAG9H89xeoLbnEePicYgXq2f6QIFHc0RbguAAczMmkZEtupcaTQz49
         LwTJpEtDiNLtdqUnWvgNjzA0bhwaluCGtA5Re/vPFL0YycxUWkdUXYO6wNZleYZjXOhd
         vRgof1X1/THBTulJrBv2Z2pcv6xD57Q/BZPUsLS59nNO1rfUkpox6graNf8giS31JQUI
         NjRNo8dooF4qJmmopf1FPxZnrVhb0FzlymM91HnfPLB82dJlYWW8LUAp2tAfHTmSfrIa
         lk6mU/mvF0oAIAUs8reVHjvbttrHa8q4Tn8/O0ilETybPQ+YA+TTLzULZlDjQhmFkLPq
         eITg==
X-Gm-Message-State: APt69E3b5dxY3JDp/kSz7NdYOkRMdkoDUNTcJgG4VlSttmhZwDsEf9Rb
        Uin31L9EcALq+KJgaFoADQhgMhtIMr22n63NmaoOVw==
X-Google-Smtp-Source: AAOMgpdribohFMDhECRxjtAfZpK8NGR9+L4RGRdUSm2R1Eez1TXTMvW795lwesp2/PwEBvk/mKbtJkKMYg1N3eoczDE=
X-Received: by 2002:a9d:132e:: with SMTP id f43-v6mr3225535ote.340.1529960784440;
 Mon, 25 Jun 2018 14:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com> <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com> <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
 <20180621152903.GB1324@hmswarspite.think-freely.org> <CAOASepOPxte6aDHQB2dsd+VMPqWOuZZH4j8OKoqaHZ2cBsc38g@mail.gmail.com>
 <CALCETrVCVeen+foJbW-yXgg2ivkPNmUx31tPT8rV4cYOAqcSfQ@mail.gmail.com>
In-Reply-To: <CALCETrVCVeen+foJbW-yXgg2ivkPNmUx31tPT8rV4cYOAqcSfQ@mail.gmail.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Mon, 25 Jun 2018 17:06:12 -0400
Message-ID: <CAOASepPb5zKz_HDyM+s8wLmaN3oN7+OtuDLmocP_9w5Hdq3c6A@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     luto@kernel.org
Cc:     Neil Horman <nhorman@redhat.com>, sean.j.christopherson@intel.com,
        jethro@fortanix.com, jarkko.sakkinen@linux.intel.com,
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

On Thu, Jun 21, 2018 at 6:49 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Jun 21, 2018 at 12:11 PM Nathaniel McCallum
> <npmccallum@redhat.com> wrote:
> >
> > If this is acceptable for everyone, my hope is the following:
> >
> > 1. Intel would split the existing code into one of the following
> > schemas (I don't care which):
> >   A. three parts: UEFI module, FLC-only kernel driver and user-space
> > launch enclave
> >   B. two parts: UEFI module (including launch enclave) and FLC-only
> > kernel driver
> >
> > 2. Intel would release a reproducible build of the GPL UEFI module
> > sources signed with a SecureBoot trusted key and provide an
> > acceptable[0] binary redistribution license.
> >
> > 3. The kernel community would agree to merge the kernel driver given
> > the above criteria (and, obviously, acceptable kernel code).
> >
> > The question of how to distribute the UEFI module and possible launch
> > enclave remains open. I see two options: independent distribution and
> > bundling it in linux-firmware. The former may be a better
> > technological fit since the UEFI module will likely need to be run
> > before the kernel (and the boot loader; and shim). However, the latter
> > has the benefit of already being a well-known entity to our downstream
> > distributors. I could go either way on this.
>
> This is a lot of complication and effort for a gain that is not
> entirely clear.

Root kits and evil maid attacks are two worth considering.

> I really really really do *not* want to see Intel or
> anyone else start enforcing policy on which programs can and cannot
> run using this mechanism.

We already do this. It is called SecureBoot.

> (This is exactly why non-FLC systems aren't
> about to be supported upstream.)  So my preference is to not merge
> anything that supports this type of use case unless there is
> compelling evidence that it is (a) genuinely useful, (b) will be used
> to improve security and (c) won't be abused for, say, revenue
> purposes.

I think there are benefits for (a) and (b). I agree with you about
(c). But, again, we already have SecureBoot.
