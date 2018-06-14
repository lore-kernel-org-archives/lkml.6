Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 86F3FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43564208E8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43564208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936164AbeFNO7d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:59:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:58592 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754907AbeFNO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:59:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 07:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="57362096"
Received: from 2b52.sc.intel.com (HELO [143.183.136.147]) ([143.183.136.147])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2018 07:59:27 -0700
Message-ID: <1528988176.13101.15.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Thu, 14 Jun 2018 07:56:16 -0700
In-Reply-To: <814fc15e80908d8630ff665be690ccbe6e69be88.camel@gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
         <1528815820.8271.16.camel@2b52.sc.intel.com>
         <814fc15e80908d8630ff665be690ccbe6e69be88.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-14 at 11:07 +1000, Balbir Singh wrote:
> On Tue, 2018-06-12 at 08:03 -0700, Yu-cheng Yu wrote:
> > On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> > > 
> > > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > > This series introduces CET - Shadow stack
> > > > 
> > > > At the high level, shadow stack is:
> > > > 
> > > > 	Allocated from a task's address space with vm_flags VM_SHSTK;
> > > > 	Its PTEs must be read-only and dirty;
> > > > 	Fixed sized, but the default size can be changed by sys admin.
> > > > 
> > > > For a forked child, the shadow stack is duplicated when the next
> > > > shadow stack access takes place.
> > > > 
> > > > For a pthread child, a new shadow stack is allocated.
> > > > 
> > > > The signal handler uses the same shadow stack as the main program.
> > > > 
> > > 
> > > Even with sigaltstack()?
> > > 
> > Yes.
> 
> I am not convinced that it would work, as we switch stacks, oveflow might
> be an issue. I also forgot to bring up setcontext(2), I presume those
> will get new shadow stacks

Do you mean signal stack/sigaltstack overflow or swapcontext in a signal
handler?

Yu-cheng

