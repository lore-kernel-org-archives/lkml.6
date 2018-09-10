Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0FD206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0FD206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeIJSJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:09:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:45309 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbeIJSJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:09:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 06:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="90428126"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2018 06:15:10 -0700
Message-ID: <1536585310.11460.34.camel@intel.com>
Subject: Re: [PATCH v6 4/5] x86/kvm: use __decrypted attribute in shared
 variables
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Date:   Mon, 10 Sep 2018 06:15:10 -0700
In-Reply-To: <20180910120416.GD21815@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
         <1536343050-18532-5-git-send-email-brijesh.singh@amd.com>
         <20180910120416.GD21815@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 14:04 +0200, Borislav Petkov wrote:
> On Fri, Sep 07, 2018 at 12:57:29PM -0500, Brijesh Singh wrote:
> > 
> > Commit: 368a540e0232 (x86/kvmclock: Remove memblock dependency)
> > caused SEV guest regression.
> When mentioning a commit in the commit message, put it on a separate
> line, like this:
> 
> "Commit
> 
>   368a540e0232 (x86/kvmclock: Remove memblock dependency)
> 
> caused a SEV guest regression."

Heh, that was the original formatting until I asked him to change it:
https://lkml.org/lkml/2018/8/29/809.  Checkpatch throws an error if
there's a newline after 'Commit'.  Though looking at this again, there
shouldn't be a colon after 'Commit' and there should be quotes inside
the parentheses, e.g. this satisfies checkpatch:

Commit 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
