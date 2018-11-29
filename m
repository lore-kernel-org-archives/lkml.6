Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50474C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062BA2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062BA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeK3K43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:56:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:22847 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbeK3K43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:56:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 15:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,296,1539673200"; 
   d="scan'208";a="98513840"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2018 15:49:12 -0800
Date:   Thu, 29 Nov 2018 15:49:12 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Helge Deller <deller@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 09/14] fs/pstore: Use %pS printk format for direct
 addresses
Message-ID: <20181129234912.GA7787@agluck-desk>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
 <1504729681-3504-10-git-send-email-deller@gmx.de>
 <CAGXu5jL3qs=YrXWesOueaZYZ8k1qjJ=1HYb9Rmfry8tzvaGY8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL3qs=YrXWesOueaZYZ8k1qjJ=1HYb9Rmfry8tzvaGY8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:26:51PM -0800, Kees Cook wrote:
> On Wed, Sep 6, 2017 at 1:28 PM Helge Deller <deller@gmx.de> wrote:
> >
> > Use the %pS instead of the %pF printk format specifier for printing symbols
> > from direct addresses. This is needed for the ia64, ppc64 and parisc64
> > architectures.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> 
> I missed this email from some time ago. I've now applied it, thanks!

Though it isn't really needed any more. See

04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()")

which is part of the plan to deprecate %pF

-Tony
