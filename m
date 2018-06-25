Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74582C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301DC26182
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301DC26182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeFYV1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:27:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46924 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752588AbeFYV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:27:10 -0400
Received: by mail-oi0-f66.google.com with SMTP id h79-v6so13919243oig.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HOOONzm2mhW/GfZeh8QD3eIRUcRYoEN6jI1PUZnAKg=;
        b=ppeuV39guGDcteJnhMEjjg/Yl+rDniIz3x+N/AHKeOWUdZ4dP26CNbQf3sxs9IMU/+
         8zP1St41+56Eq+jOkfbTw9viMkbPyRq2DK6Y8C+M4fV9On5M6eTfFQytWpILJsjnweZ/
         nR/lACVGMGalyaxv324E1iNctFMRxum/t6aiooGTWNtXg376RlRgavf7tr+jtlC2Ijpm
         U3wr13xgkoX2MX/QIes0se8ReO//OHb7oL91OCgkWsmoMM1DZ03vHxHa/L+F58rqAu5V
         WErK/11v0JEwVMP2eLZXpSdDSTSL74XfnXqt/suyYDzbeWPQTNb8gs8P4Pw51qCVxVdN
         9DoQ==
X-Gm-Message-State: APt69E1RkdDsDVp/QelvZpTPKalUU720HbIYfnlRSnsvaULtIa0su6IU
        5ReN2I+L5sIfdYzywdqw9LteL0tQNV9TuCD6zkny3w==
X-Google-Smtp-Source: ADUXVKLdiDj0ZO7YU4UkQtHDFU0yVsKTiXpqXtwhcpeD6fdMlYAYjLzQixaDHarTH74Z9adsC0pCE/uLtuliwlFW8Jg=
X-Received: by 2002:aca:be86:: with SMTP id o128-v6mr8182161oif.301.1529962030058;
 Mon, 25 Jun 2018 14:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com> <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com> <bbffd5f975a4054850e1885b7fc5013ef9a3e7f3.camel@linux.intel.com>
In-Reply-To: <bbffd5f975a4054850e1885b7fc5013ef9a3e7f3.camel@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Mon, 25 Jun 2018 17:26:58 -0400
Message-ID: <CAOASepOrKApnxXZhiz4usPAeJux8i2zP0tEs1B6FyoYvtiPn4A@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     jarkko.sakkinen@linux.intel.com
Cc:     luto@kernel.org, Neil Horman <nhorman@redhat.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 5:28 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, 2018-06-20 at 12:28 -0400, Nathaniel McCallum wrote:
> > As I understand it, the current policy models under discussion look like this:
> >
> > 1. SGX w/o FLC (not being merged) looks like this:
> >   Intel CPU => (Intel signed) launch enclave => enclaves
> >
> > 2. SGX w/ FLC, looks like this:
> >   Intel CPU => kernel => launch enclave => enclaves
> >
> > 3. Andy is proposing this:
> >   Intel CPU => kernel => enclaves
>
> What if MSRs are not writable after hand over to the OS? It is a legit
> configuration at least according to the SDM.

It seems to me that "set the MSRs in the BIOS" and "set the MSRs in a
UEFI module" are functionally equivalent.
