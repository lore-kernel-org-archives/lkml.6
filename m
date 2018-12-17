Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17013217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545074766;
	bh=P1xUfZc9TtT1RfxBrBvA9rx94XTVxDT3E4hXNRMQ+Ww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HA49vzrAqg8EEl/k8ZpqZqTUP+O3HcWYmv3FdHvtaTbtG1I/7D4O+xa0khgw9oUJ1
	 +LJnJZgxmi98K3XfDXT/JNJr8MkR5fTgbCxawmncHV7BC1gFdGBWRyfFAZFvnG/Ka/
	 E9tsCtop2uy04sSOK2SQ2vy1dOxTae0eGIzlQlzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbeLQT0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeLQT0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:26:04 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5226321783
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545074763;
        bh=P1xUfZc9TtT1RfxBrBvA9rx94XTVxDT3E4hXNRMQ+Ww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W8nlSLz/FdBoMrvH7QGAsVBuKDapmwzv52P0BVbfXVyErEviP5S+cMAUXsrMKHLcc
         K3Bc3qRD4G3WaHQKo5MhRUVG8xRpiyDOu94sFxpHlDL46Xi/2VPlco1NzGEoDwm9ZM
         CdPK6XqWWqJ8vLSAQEG721qoOFKc4ZehkHi2LYN4=
Received: by mail-wr1-f49.google.com with SMTP id l9so13454925wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:26:03 -0800 (PST)
X-Gm-Message-State: AA+aEWb0xWt2ttyk2CXKAZ5pHqLAYwvftGaTxsPVp53nyQeUdCLL/d6q
        3TBNfaHUBfJjOtE+RqKEb875y3hu84Leym6SS4YW1A==
X-Google-Smtp-Source: AFSGD/Wnewd85cwyB96or4l73Ml+ao/C1SexCT5MgeKbKffx6x7+p6JCbFQtSaBoXNFwrrFbpW7A6OlebokEX/cidCM=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr12470572wrv.330.1545074759934;
 Mon, 17 Dec 2018 11:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20181116010412.23967-1-jarkko.sakkinen@linux.intel.com>
 <20181116010412.23967-19-jarkko.sakkinen@linux.intel.com> <7d5cde02-4649-546b-0f03-2d6414bb80b5@intel.com>
 <20181217180102.GA12560@linux.intel.com> <20181217183613.GD12491@linux.intel.com>
 <20181217184333.GA26920@linux.intel.com> <ccfb67a0-fd8d-82c8-8018-fd68e901f287@intel.com>
 <CALCETrX0W4dhFJBHEbDbKed_QZxmw6ZNMajfsoVgqGqhMB0nDg@mail.gmail.com> <beea8ad3-a607-5478-ad87-b8dd33e86146@intel.com>
In-Reply-To: <beea8ad3-a607-5478-ad87-b8dd33e86146@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 17 Dec 2018 11:25:47 -0800
X-Gmail-Original-Message-ID: <CALCETrUCAvsaO71422gbaJtuZTbx8Y7pUm7yF3zQkktOvRedzw@mail.gmail.com>
Message-ID: <CALCETrUCAvsaO71422gbaJtuZTbx8Y7pUm7yF3zQkktOvRedzw@mail.gmail.com>
Subject: Re: [PATCH v17 18/23] platform/x86: Intel SGX driver
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-sgx@vger.kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>,
        shay.katz-zamir@intel.com,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Svahn, Kai" <kai.svahn@intel.com>, mark.shanahan@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:17 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/17/18 11:12 AM, Andy Lutomirski wrote:
> > So I'm not saying that you shouldn't do it the way you are now, but I
> > do think that the changelog or at least some emails should explain
> > *why* the enclave needs to keep a pointer to the creating process's
> > mm.  And, if you do keep the current model, it would be nice to
> > understand what happens if you do something awful like mremap()ing an
> > enclave, or calling madvise on it, or otherwise abusing the vma.  Or
> > doing fork(), for that matter.
>
> Yeah, the code is built to have one VMA and only one VMA per enclave.
> You need to go over the origin of this restriction and what enforces this.

There is a sad historical reason that you may regret keeping this
restriction.  There are plenty of pieces of code out there that think
it's reasonable to spawn a subprocess by calling fork() and then
execve().  (This is *not* a sensible thing to do.  One should use
posix_spawn() or some CLONE_VM variant.  But even fairly recent
posix_spawn() implementations will fork().  So the driver has to do
*something* sensible on fork() or a bunch of things that use SGX
unsuspectingly via, for example, PKCS #11, are going to be very sad.
I suppose you could make enclaves just not show up in the fork()ed
children, but then you have a different problem: creating an enclave
and then doing daemon() won't work.

Yes, POSIX traditions are rather silly.
