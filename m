Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402DAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9BE204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9BE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757259AbeFSNax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:30:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:43299 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbeFSNav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:30:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 06:30:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48237076"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2018 06:30:44 -0700
Date:   Tue, 19 Jun 2018 16:30:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 12/13] intel_sgx: driver documentation
Message-ID: <20180619133043.GG5609@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-13-jarkko.sakkinen@linux.intel.com>
 <6200618e-bcc8-23ba-afe8-4c6be8b364f0@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6200618e-bcc8-23ba-afe8-4c6be8b364f0@fortanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 11:32:17AM -0700, Jethro Beekman wrote:
> On 2018-06-08 10:09, Jarkko Sakkinen wrote:
> > +Launching enclaves
> > +------------------
> > +
> > +For privileged enclaves the launch is performed simply by submitting the
> > +SIGSTRUCT for that enclave to ENCLS(EINIT). For unprivileged enclaves the
> > +driver hosts a process in ring-3 that hosts a launch enclave signed with a key
> > +supplied for kbuild.
> > +
> > +The current implementation of the launch enclave generates a token for any
> > +enclave. In the future it could be potentially extended to have ways to
> > +configure policy what can be lauched.
> > +
> > +The driver will fail to initialize if it cannot start its own launch enclave.
> > +A user space application can submit a SIGSTRUCT instance through the ioctl API.
> > +The kernel will take care of the rest.
> > +
> > +This design assures that the Linux kernel has always full control, which
> > +enclaves get to launch and which do not, even if the public key MSRs are
> 
> As discussed previously at length, since the kernel needs to execute
> ENCLS[EINIT], it has full control to deny the launching of enclaves
> regardless of any launch enclave implementation. Please change this
> misleading statement.

Remember the discussion, forgot to change it. I'll fix this for the next
version.

/Jarkko
