Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B345FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8248A20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8248A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeLCEDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:03:44 -0500
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:37176 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbeLCEDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:03:44 -0500
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Dec 2018 23:03:43 EST
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
        by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id B90FF307503A;
        Mon,  3 Dec 2018 05:56:13 +0200 (EET)
Received: from [192.168.1.131] (unknown [188.27.64.30])
        by smtp.bitdefender.com (Postfix) with ESMTPSA id 962EC300F70D;
        Mon,  3 Dec 2018 05:56:13 +0200 (EET)
Message-ID: <1543809373.23880.17.camel@bitdefender.com>
Subject: Re: [RFC PATCH V2 00/11] Intel EPT-Based Sub-page Protection Support
From:   Mihai =?UTF-8?Q?Don=C8=9Bu?= <mdontu@bitdefender.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Nicusor CITU <ncitu@bitdefender.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Adalbert =?UTF-8?Q?Laz=C4=83r?= <alazar@bitdefender.com>
Date:   Mon, 03 Dec 2018 05:56:13 +0200
In-Reply-To: <1c7e9821-df4b-9b1c-76aa-d1c4c654c952@redhat.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
         <1c7e9821-df4b-9b1c-76aa-d1c4c654c952@redhat.com>
Organization: Bitdefender
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On Fri, 2018-11-30 at 11:07 +0100, Paolo Bonzini wrote:
> On 30/11/18 08:52, Zhang Yi wrote:
> > Here is a patch-series which adding EPT-Based Sub-page Write Protection Support.
> > 
> > Introduction:
> > 
> > EPT-Based Sub-page Write Protection referred to as SPP, it is a capability which
> > allow Virtual Machine Monitors(VMM) to specify write-permission for guest
> > physical memory at a sub-page(128 byte) granularity.  When this capability is
> > utilized, the CPU enforces write-access permissions for sub-page regions of 4K
> > pages as specified by the VMM. EPT-based sub-page permissions is intended to
> > enable fine-grained memory write enforcement by a VMM for security(guest OS
> > monitoring) and usages such as device virtualization and memory check-point.
> > 
> > SPPT is active when the "sub-page write protection" VM-execution control is 1.
> > SPPT looks up the guest physical addresses to derive a 64 bit "sub-page
> > permission" value containing sub-page write permissions. The lookup from
> > guest-physical addresses to the sub-page region permissions is determined by a
> > set of SPPT paging structures.
> > 
> > When the "sub-page write protection" VM-execution control is 1, the SPPT is used
> > to lookup write permission bits for the 128 byte sub-page regions containing in
> > the 4KB guest physical page. EPT specifies the 4KB page level privileges that
> > software is allowed when accessing the guest physical address, whereas SPPT
> > defines the write permissions for software at the 128 byte granularity regions
> > within a 4KB page. Write accesses prevented due to sub-page permissions looked
> > up via SPPT are reported as EPT violation VM exits. Similar to EPT, a logical
> > processor uses SPPT to lookup sub-page region write permissions for
> > guest-physical addresses only when those addresses are used to access memory.
> 
> Hi,
> 
> I think the right thing to do here would be to first get VM
> introspection in KVM, as SPP is mostly an introspection feature and it
> should be controller by the introspector rather than the KVM userspace.
> 
> Mihai, if you resubmit, I promise that I will look at it promptly.

I'm currently traveling until Wednesday, but when I'll get into the
office I will see about preparing a new patch set and send it to the
list before Christmas.

Regards,

-- 
Mihai Donțu

