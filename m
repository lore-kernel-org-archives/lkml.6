Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70633C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3365C206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3365C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeIJSYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:24:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeIJSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:24:12 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzMGN-0000OK-5f; Mon, 10 Sep 2018 15:29:59 +0200
Date:   Mon, 10 Sep 2018 15:29:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 4/5] x86/kvm: use __decrypted attribute in shared
 variables
In-Reply-To: <1536585310.11460.34.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1809101527030.1292@nanos.tec.linutronix.de>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>         <1536343050-18532-5-git-send-email-brijesh.singh@amd.com>         <20180910120416.GD21815@zn.tnic> <1536585310.11460.34.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-590345044-1536586199=:1292"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-590345044-1536586199=:1292
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 10 Sep 2018, Sean Christopherson wrote:

> On Mon, 2018-09-10 at 14:04 +0200, Borislav Petkov wrote:
> > On Fri, Sep 07, 2018 at 12:57:29PM -0500, Brijesh Singh wrote:
> > > 
> > > Commit: 368a540e0232 (x86/kvmclock: Remove memblock dependency)
> > > caused SEV guest regression.
> > When mentioning a commit in the commit message, put it on a separate
> > line, like this:
> > 
> > "Commit
> > 
> >   368a540e0232 (x86/kvmclock: Remove memblock dependency)
> > 
> > caused a SEV guest regression."
> 
> Heh, that was the original formatting until I asked him to change it:
> https://lkml.org/lkml/2018/8/29/809.  Checkpatch throws an error if
> there's a newline after 'Commit'.  Though looking at this again, there
> shouldn't be a colon after 'Commit' and there should be quotes inside
> the parentheses, e.g. this satisfies checkpatch:
> 
> Commit 368a540e0232 ("x86/kvmclock: Remove memblock dependency")

The whole 5 lines of 'commit bla broke' are bogus to me. They convey not
really useful information and the commit line will repeat itself in the
Fixes: tag. So something like:

  The recent removal of the memblock dependency caused a SEV guest
  regression because bla....


  Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")

Is much more useful than the above independent of its formatting.

Thanks,

	tglx

--8323329-590345044-1536586199=:1292--
