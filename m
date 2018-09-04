Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA972C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7076420867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7076420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeIDTRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:17:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:41307 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDTRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:17:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 07:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="77873416"
Received: from unknown (HELO [143.183.136.146]) ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2018 07:52:21 -0700
Message-ID: <1536072478.12366.2.camel@intel.com>
Subject: Re: [RFC PATCH v3 00/24] Control Flow Enforcement: Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Tue, 04 Sep 2018 07:47:58 -0700
In-Reply-To: <20180902081350.GF28695@350D>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
         <20180902081350.GF28695@350D>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-02 at 18:13 +1000, Balbir Singh wrote:
> On Thu, Aug 30, 2018 at 07:38:40AM -0700, Yu-cheng Yu wrote:
> > 
> > The previous version of CET patches can be found in the following
> > link.
> > 
> >   https://lkml.org/lkml/2018/7/10/1031
> > 
> > Summary of changes from v2:
> > 
> >   Move Shadow Stack page fault handling logic to arch/x86.
> >   Update can_follow_write_pte/pmd; move logic to arch/x86.
> >   Fix problems in WRUSS in-line assembly.
> >   Fix issues in ELF parser.
> >   Split out IBT/PTRACE patches to a second set.
> >   Other small fixes.
> > 
> Quick question -- is there a simulator or some other way you've
> been testing this? Just curious, if it's possible to run these
> patches or just a review and internal hardware/simulator where
> they are run and posted
> 
> Balbir Singh.

Currently only for review.

Yu-cheng
