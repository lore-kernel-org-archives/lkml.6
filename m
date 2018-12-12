Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2769C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B373A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B373A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeLLSdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:33:10 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:46370 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727910AbeLLSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:33:09 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 44F84B4007E;
        Wed, 12 Dec 2018 18:33:08 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 10:33:04 -0800
Subject: Re: [PATCH v2 0/4] Static calls
To:     Nadav Amit <namit@vmware.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
 <20181211180521.ljdvnnztjnvoijge@treble>
 <86D72260-838C-4CE0-ACE3-BE92A3E9CFD8@vmware.com>
 <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
 <294E22E9-7577-4716-A531-CBFE628789C3@vmware.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <496ba248-eca5-d432-0ec9-95b2e0d775a1@solarflare.com>
Date:   Wed, 12 Dec 2018 18:33:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <294E22E9-7577-4716-A531-CBFE628789C3@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24280.005
X-TM-AS-Result: No-7.334400-4.000000-10
X-TMASE-MatchedRID: byfwvk+IcRkOwH4pD14DsPHkpkyUphL97f6JAS2hKPgNht78/JfyBGEz
        sspWQGLKIeo9PT0ztqNHpPeBBM9pze4dcT3ZaTocLcLAlVGnzPp7tnRTJA7lM1wpnAAvAwazxWv
        oa1CgRvqeUhwocpyNBeJTTC9C/TDrCNWeV68n9Ogve6W+IORwrVmLvTysL4PPyvfX8jlSts9aat
        ivxJpZNR7WlQ5pB5kSnfehGHiY0CSLKL8lZ3zQMqJVTu7sjgg1RvyVHewb0kIs7eP5cPCWQ/hTq
        8/WMstvS5DUDNSUJGfEgyASJMxFeVNxgS5+r8A704Rmz/agfdyL6a+kPOEFsB+ZGcvxEG4E89es
        er3ZpAa8uEGvQ61JTzf9o2/0YdMdHW4ITGtaUyQZXJLztZviXNMxD/3e8Txd2xnElvBKO5OjxYy
        RBa/qJUl4W8WVUOR/joczmuoPCq3Z/X0YaWjr4JMBiv83MFI1qnDsdOkvm4MlUA9MkGlyy2UQ2l
        hnCJkZ
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.334400-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24280.005
X-MDID: 1544639588-niP8f85gSrnW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 18:14, Nadav Amit wrote:
> Second, (2i) is not very intuitive for me. Using the out-of-line static
> calls seems to me as less performant than the inline (potentially, I didn’t
> check).
>
> Anyhow, the use of out-of-line static calls seems to me as
> counter-intuitive. I think (didn’t measure) that it may add more overhead
> than it saves due to the additional call, ret, and so on
AIUI the outline version uses a tail-call (i.e. jmpq *target) rather than an
 additional call and ret.  So I wouldn't expect it to be too expensive.
More to the point, it seems like it's easier to get right than the inline
 version, and if we get the inline version working later we can introduce it
 without any API change, much as Josh's existing patches have both versions
 behind a Kconfig switch.

> I tried to avoid reading to
> compared target from memory and therefore used an immediate. This should
> prevent data cache misses and even when the data is available is faster by
> one cycle. But it requires the patching of both the “cmp %target-reg, imm”
> and “call rel-target” to be patched “atomically”. So the static-calls
> mechanism wouldn’t be sufficient.
The approach I took to deal with that (since though I'm doing a read from
 memory, it's key->func in .data rather than the jmp immediate in .text) was
 to have another static_call (though a plain static_key could also be used)
 to 'skip' the fast-path while it's actually being patched.  Then, since all
 my callers were under the rcu_read_lock, I just needed to synchronize_rcu()
 after switching off the fast-path to make sure no threads were still in it.
I'm not sure how that would be generalised to all cases, though; we don't
 want to force every indirect call to take the rcu_read_lock as that means
 no callee can ever synchronize_rcu().  I guess we could have our own
 separate RCU read lock just for indirect call patching?  (What does kgraft
 do?)

> Based on Josh’s previous feedback, I thought of improving the learning using
> some hysteresis. Anyhow, note that there are quite a few cases in which you
> wouldn’t want optpolines. The question is whether in general it would be an
> opt-in or opt-out mechanism.
I was working on the assumption that it would be opt-in, wrapping a macro
 around indirect calls that are known to have a fairly small number of hot
 targets.  There are plenty of indirect calls in the kernel that are only
 called once in a blue moon, e.g. in control-plane operations like ethtool;
 we don't really need to bulk up .text with trampolines for all of them.

-Ed
