Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F35C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0BB20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0BB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757226AbeFSPF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:05:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:49800 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756712AbeFSPF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:05:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 08:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="58515059"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2018 08:05:51 -0700
Date:   Tue, 19 Jun 2018 18:05:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andy@infradead.org
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
Message-ID: <20180619150550.GD8034@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrWSDVdrrVbvEbOH06OQcBkGF-M9R5WQkQ0r4qK2oAL3vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWSDVdrrVbvEbOH06OQcBkGF-M9R5WQkQ0r4qK2oAL3vQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 11:50:14AM -0700, Andy Lutomirski wrote:
> On Fri, Jun 8, 2018 at 10:32 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > The Launch Enclave (LE) generates cryptographic launch tokens for user
> > enclaves. A launch token is used by EINIT to check whether the enclave
> > is authorized to launch or not. By having its own launch enclave, Linux
> > has full control of the enclave launch process.
> >
> > LE is wrapped into a user space proxy program that reads enclave
> > signatures outputs launch tokens. The kernel-side glue code is
> > implemented by using the user space helper framework.  The IPC between
> > the LE proxy program and kernel is handled with an anonymous inode.
> >
> > The commit also adds enclave signing tool that is used by kbuild to
> > measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
> > to a PEM-file for the 3072-bit RSA key that is used as the LE public key
> > pair. The default location is:
> 
> It might be nice to use the infrastructure that Alexei added for
> bpfilter (the umh_blob stuff) here, which is slated for merging in
> this merge window.
> 
> --Andy

Thanks, not familiar with this work. Is there any documentation for
it available?

/Jarkko
