Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FACC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F299226CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F299226CB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeFZPAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:00:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:38081 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbeFZPA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:00:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 08:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="60298635"
Received: from 2b52.sc.intel.com ([143.183.136.147])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2018 08:00:28 -0700
Message-ID: <1530025017.27091.1.camel@intel.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Date:   Tue, 26 Jun 2018 07:56:57 -0700
In-Reply-To: <CALCETrWYx5nCtwGAqTZBWOB+aw+eEcnQhe6Sn1o+O356g7Km9A@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <CALCETrWYx5nCtwGAqTZBWOB+aw+eEcnQhe6Sn1o+O356g7Km9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 22:26 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com>
> wrote:
> > 
> > 
> > This series introduces CET - Shadow stack
> I think you should add some mitigation against sigreturn-oriented
> programming.  How about creating some special token on the shadow
> stack that indicates the presence of a signal frame at a particular
> address when delivering a signal and verifying and popping that token
> in sigreturn?  The token could be literally the address of the signal
> frame, and you could make this unambiguous by failing sigreturn if
> CET
> is on and the signal frame is in executable memory.
> 
> IOW, it would be a shame if sigreturn() itself became a convenient
> CET-bypassing gadget.
> 
> --Andy

I will look into that.

Thanks,
Yu-cheng

