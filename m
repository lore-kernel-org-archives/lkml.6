Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DAC39C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E788208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gyijERiH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gyijERiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E788208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964921AbeFNPa5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:30:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964820AbeFNPa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:30:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A11CA600D0; Thu, 14 Jun 2018 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528990255;
        bh=TeMrxAk5XyuHDtuqYrFDucy9EnkQ5py0nxuJyCMx7j8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gyijERiHBN2MLIYKB5FqCbeTcALqPjabpnW3VTm3Jz7K8d3KS1CwDIMEro30GV9Lk
         6/tejiOVvMJgHQ5NjTsYwG0YYO0TATRr3mUokrqyQXNCjHVbBpO2QxuamROMk1J3LF
         4bvIa707bTHKYbm7XlDnWw8wqv/nkfqfWBkJsvTk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id F0F426022C;
        Thu, 14 Jun 2018 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528990255;
        bh=TeMrxAk5XyuHDtuqYrFDucy9EnkQ5py0nxuJyCMx7j8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gyijERiHBN2MLIYKB5FqCbeTcALqPjabpnW3VTm3Jz7K8d3KS1CwDIMEro30GV9Lk
         6/tejiOVvMJgHQ5NjTsYwG0YYO0TATRr3mUokrqyQXNCjHVbBpO2QxuamROMk1J3LF
         4bvIa707bTHKYbm7XlDnWw8wqv/nkfqfWBkJsvTk=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 14 Jun 2018 11:30:54 -0400
From:   Agustin Vega-Frias <agustinv@codeaurora.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        timur@codeaurora.org
Subject: Re: [RFC V2 3/3] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION
 DEFINED event support
In-Reply-To: <20180613130232.GA27675@arm.com>
References: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
 <1528379808-27970-4-git-send-email-agustinv@codeaurora.org>
 <20180612144055.m2h26n64spfm6k6o@lakrids.cambridge.arm.com>
 <9957219b64252d3b2e19724db04a1179@codeaurora.org>
 <20180613103555.GC26280@arm.com>
 <06c81a64-904f-59fa-5751-62818d6d2107@arm.com>
 <20180613130232.GA27675@arm.com>
Message-ID: <4a584145358bd046d735c30ba0d49db6@codeaurora.org>
X-Sender: agustinv@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-06-13 09:02, Will Deacon wrote:
> On Wed, Jun 13, 2018 at 01:59:58PM +0100, Marc Zyngier wrote:
>> On 13/06/18 11:35, Will Deacon wrote:

[...]

>> > Great :( We need to make sure we disable EL0 access during boot then, but
>> > that means we need to prove for the existence of this thing in head.S
>> > (since the PMU driver might not get loaded).

Unfortunately it appears the only check we can do for this is through
the MIDR or PMPIDRx. I'm investigating whether we can detect this 
through
some other mechanism, but it that doesn't exists would the MIDR.PMPIDRx
check be acceptable?

>> >
>> > Also, what's the kvm story here so that we don't accidentally open up a
>> > VM-VM side-channel via these registers? How do the EL1 trapping controls
>> > work?

Traps for these registers are as follows:

Architecture traps:
- HCR_EL2.TIDCP enables a trap when accessing IMP DEF registers. kvm 
will set
   this bit for all guests and access from EL1/EL0 will cause a trap to 
EL2.
- MDCR_EL2.TPM enables a trap when accessing the PM registers from 
EL1/EL0,
   causing accesses to trap to EL2.
- MDCR_EL2.TPM enables a trap when accessing the PM registers from 
EL1/EL0,
   causing accesses to trap to EL2.

IMP DEF traps:
- IMP DEF register PMACTLR_EL0.UEN controls EL0 access to all IMP DEF
   registers related to performance monitoring:
   0->disables EL0 access (default), 1->enables EL0 access
- IMP DEF HACR_EL2.TCPUPMRBB enables a trap when accessing the RBB 
registers
   from EL1/EL0, causing accesses to trap to EL2.
- IMP DEF HACR_EL2.TCPUPMPCCPT enables a trap when accessing the PCC 
registers
   from EL1/EL0, causing accesses to trap to EL2.
- IMP DEF HACR_EL2.TCPUPMRESRRLDR enables a trap when accessing the 
PMRESRx_EL0
   registers from EL1/EL0, causing accesses to trap to EL2.

>> 
>> We'd trap the IMPDEF register access and inject an UNDEF (assuming 
>> that
>> the IMPDEF trapping works correctly). I have strictly no plan to 
>> support
>> this in a guest.
> 
> Ah, so we could actually configure that in el2_setup and solve the host
> problem if we're entered at EL2. Agustin -- does that work, and what do 
> we
> need to do if the host is entered at EL1?
> 

Yes, that works, I understand there is no desire to support this under
virtualization.

As for the question about the EL1 host, all of our firmware 
configurations
boot the host OS at EL2. Is that sufficient guarantee or can you suggest
an alternative mechanism to ensure security?

Thanks,
Agustín

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
