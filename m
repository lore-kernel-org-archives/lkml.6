Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F51C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94FB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94FB2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbeIXV03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:26:29 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33153 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeIXV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:26:29 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4SiB-0001U2-07; Mon, 24 Sep 2018 09:23:47 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Si9-00005o-9Y; Mon, 24 Sep 2018 09:23:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, Guan Xuetao <gxt@pku.edu.cn>
Date:   Mon, 24 Sep 2018 17:23:35 +0200
Message-ID: <87lg7q2a2w.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g4Si9-00005o-9Y;;;mid=<87lg7q2a2w.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+DU8RXYMKgqzZkaoG+kC5M/Eq2/n5ryF4=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 0/3] signal/unicore32: siginfo cleanups
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have been slowly cleaning up the architectues ever since I discovered
that the pattern of passing in struct siginfo is error prone, and
occassionally results in broken siginfo being sent to userspace.

I don't have a clue how to obtain a working unicore32 compiler so the
following changes have only been reviewed carefully and not compile
tested.  Still I believe they are simple and obviously correct.

Anyone who can review or test these changes please do and let me know
about any problems you find so that I can correct them.

My intention is to merge this through my siginfo tree.  If you feel it
should go through your arch tree let me know.   All of the prerequisites
should have been merged several releases ago.

Eric W. Biederman (3):
      signal/unicore32: Use send_sig_fault where appropriate
      signal/unicore32: Generate siginfo in ucs32_notify_die
      signal/unicore32: Use force_sig_fault where appropriate

 arch/unicore32/include/asm/bug.h  |  3 ++-
 arch/unicore32/kernel/fpu-ucf64.c | 12 +++---------
 arch/unicore32/kernel/traps.c     |  5 +++--
 arch/unicore32/mm/fault.c         | 27 +++++----------------------
 4 files changed, 13 insertions(+), 34 deletions(-)

Eric
