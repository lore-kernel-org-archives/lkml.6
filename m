Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4EBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317D320700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfBUOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:47:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:48084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728232AbfBUOrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:47:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C670DAFA4;
        Thu, 21 Feb 2019 14:47:03 +0000 (UTC)
Date:   Thu, 21 Feb 2019 15:47:01 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable-4.4.y] KVM: VMX: Fix x2apic check in
 vmx_msr_bitmap_mode()
Message-ID: <20190221144701.GB8380@suse.de>
References: <20190221135213.23926-1-joro@8bytes.org>
 <20190221141530.GA18436@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221141530.GA18436@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:15:30PM +0100, Greg Kroah-Hartman wrote:
> Ugh, good catch!
> 
> Any hint as to what type of testing that you did that caught this?  I
> keep asking people to run some kvm tests, but so far no one is :(

We caught this at SUSE while testing candidate kernel updates for one of
our service packs using a 4.4-based kernel and debugging turned
out that this is issue came in via stable-updates. We also build a
vanilla-flavour of the kernel which is nearly identical to the upstream
stable tree, but what usually ends up in testing is the full tree with
other backports.

This particular issue was found by updating some openstack machines with
the candidate kernel, which then triggered the problem in some guests.
It is also a very special one, since I was only able to trigger the
problem on Westmere-based machines with a specific guest-config.

Regards,

	Joerg
