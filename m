Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1OeUM96SGVvePQAAmS7hNA
	; Thu, 07 Jun 2018 20:18:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C33EE6074D; Thu,  7 Jun 2018 20:18:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 63267605A2;
	Thu,  7 Jun 2018 20:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63267605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeFGUSP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:18:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:5897 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbeFGUSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:18:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 13:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="55592618"
Received: from 2b52.sc.intel.com (HELO [143.183.136.51]) ([143.183.136.51])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2018 13:18:12 -0700
Message-ID: <1528402501.5265.23.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 10/10] mm: Prevent munmap and remap_file_pages of shadow
 stack
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
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
Date: Thu, 07 Jun 2018 13:15:01 -0700
In-Reply-To: <CALCETrXTyXYCDJxbCA+cbzZirmMKRQq8XSS4+Lyeo_QMywdxFw@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-11-yu-cheng.yu@intel.com>
         <CALCETrXTyXYCDJxbCA+cbzZirmMKRQq8XSS4+Lyeo_QMywdxFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 11:50 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
> blocking remap_file_pages() seems reasonable.  I'm not sure what's
> wrong with munmap().

Yes, maybe we don't need to block munmap().  If the shadow stack is
unmapped, the application gets a fault.  I will remove the patch.
