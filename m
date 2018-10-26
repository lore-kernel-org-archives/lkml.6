Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCADC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372F72082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372F72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJZXIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:08:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:25653 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeJZXIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:08:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 07:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,428,1534834800"; 
   d="scan'208";a="81138198"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.193])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2018 07:30:53 -0700
Date:   Fri, 26 Oct 2018 07:30:53 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Stecklina, Julian" <jsteckli@amazon.de>
Cc:     "digitaleric@google.com" <digitaleric@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "js@alien8.de" <js@alien8.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 4/4] kvm, vmx: remove manually coded vmx instructions
Message-ID: <20181026143052.GA20425@linux.intel.com>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
 <ba8f4a02e90f1dc95a900f6a34caddce40a358d4.1540369608.git.jsteckli@amazon.de>
 <CAG7+5M39QBY1dkBjkJ9N4_9f1b1B6Hfqzg1Oh1mMp8N=dk7ZgQ@mail.gmail.com>
 <1540550786.30273.55.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540550786.30273.55.camel@amazon.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:46:27AM +0000, Stecklina, Julian wrote:
> On Wed, 2018-10-24 at 10:44 -0700, Eric Northup wrote:
> > This loses the exception handling from __ex* ->
> > ____kvm_handle_fault_on_reboot.
> > 
> > If deliberate, this should be called out in changelog.  Has the race
> > which commit 4ecac3fd fixed been mitigated otherwise?
> 
> No, this was not deliberate. Will fix.

This is already in kvm/next as commit 4b1e54786e48 ("KVM/x86: Use
assembly instruction mnemonics instead of .byte streams"), this patch
can be dropped.
