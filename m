Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ED120C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ED120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbeIXSLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:11:21 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50437 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbeIXSLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:11:20 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Pg9-0006Tr-Fa; Mon, 24 Sep 2018 06:09:29 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Pg8-0001CO-6z; Mon, 24 Sep 2018 06:09:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Date:   Mon, 24 Sep 2018 14:09:18 +0200
Message-ID: <87pnx32j2p.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g4Pg8-0001CO-6z;;;mid=<87pnx32j2p.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/G6/QdhbzQ92cIMzIFIoE5ul6ApH6SIO4=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 0/4] signal/arm: siginfo cleanups
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is the latest and hopefully round of siginfo cleanups for arm.
This replaces the use of siginal sending functions that take siginfo
with siginfo sending functions that take the values that go in siginfo
and this is harder to get wrong, and frequently results in cleaner code.

I don't think I have made made any mistakes in this coversion but if
people can look the code over and see if they can spot anything I would
appreciate it.

Eric W. Biederman (4):
      signal/arm: Push siginfo generation into arm_notify_die
      signal/arm: Use force_sig_fault where appropriate
      signal/arm: Use send_sig_fault where appropriate
      signal/arm/kvm: Use send_sig_mceerr

 arch/arm/include/asm/bug.h    |  4 +--
 arch/arm/kernel/ptrace.c      | 11 ++------
 arch/arm/kernel/swp_emulate.c | 16 +++++------
 arch/arm/kernel/traps.c       | 63 ++++++++++++-------------------------------
 arch/arm/mm/alignment.c       | 10 +------
 arch/arm/mm/fault.c           | 28 ++++---------------
 arch/arm/vfp/vfpmodule.c      | 11 +++-----
 virt/kvm/arm/mmu.c            | 14 +++-------
 8 files changed, 41 insertions(+), 116 deletions(-)

Eric
