Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6945BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252F1208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252F1208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935611AbeFMNle (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:41:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47716 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934508AbeFMNlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:41:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 887A61529;
        Wed, 13 Jun 2018 06:41:32 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3315F3F59D;
        Wed, 13 Jun 2018 06:41:31 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:41:28 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
Message-ID: <20180613134126.GL22983@e103592.cambridge.arm.com>
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFxu4pD2Z8VFhojeSczb1Jf7sp9_vETvukAxFpadyj-oqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxu4pD2Z8VFhojeSczb1Jf7sp9_vETvukAxFpadyj-oqw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 07:43:50PM +0100, Linus Torvalds wrote:
> On Tue, Jun 12, 2018 at 7:03 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
> 
> Grr. Several tedious conflicts. I fixed them all up, and they all
> looked trivial, but since most of them were to ARM cases, I couldn't
> even test the end result.
> 
> I suspect the 'workaround_flags' could be merged into the (now)
> allegedly generic 'flags' field in the arm64 kvm_vcpu_arch structure,
> but I (obviously) didn't actually do that.

I think we decided that it was a bit premature to merge them, but we
will likely be able to do that later on.

> Adding some ARM people to the cc so that somebody on that side checks my merge.
> 
> (Still going through my basic build tests, not pushed out yet, but I'm
> assuming that will finish cleanly and it should be pushed out soon).

I've now build-tested master (f5b7769eb0) in a few configurations
(particularly KVM + !KVM) for arch/arm.  The main risk there is missing
new hooks called by the core virt/kvm/arm code.

For arm64 I've now done some basic boot/run/KVM testing as appropriate
on Juno and the Arm fast model for various configs (defconfig,
ARM64_SVE=n, KVM=n).

For the KVM/SVE interactions in particular, the merge looks good to me.

Cheers
---Dave
