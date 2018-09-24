Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA47B2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA47B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeIXUu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38001 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeIXUu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4S9S-0001UJ-Vv; Mon, 24 Sep 2018 08:47:55 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4S9S-0002Vn-1B; Mon, 24 Sep 2018 08:47:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@synopsys.com>
Date:   Mon, 24 Sep 2018 16:47:44 +0200
Message-ID: <874lef2bqn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g4S9S-0002Vn-1B;;;mid=<874lef2bqn.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+JYbt40p09L2u5PiBWzZL2Wde8xMlli7M=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 0/2] signal/arc: siginfo cleanups
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have been slowly cleaning up the architectues ever since I discovered
that the pattern of passing in struct siginfo is error prone, and
occassionally results in borken siginfo being sent to userspace.

What is happening on arc is pretty tame and I have compile tested
these changes, so I don't expect problems.

Still I would appreciate if people can look over the code and perhaps
test it and see if they can spot anything that has perhaps gone wrong.
appreciate it.

My intention is to merge this through my siginfo tree.  If you feel it
should go through your arch tree let me know.   All of the prerequisites
should have been merged several releases ago.

Eric W. Biederman (2):
      signal/arc: Push siginfo generation into unhandled_exception
      signal/arc: Use force_sig_fault where appropriate

 arch/arc/kernel/traps.c | 22 ++++++++--------------
 arch/arc/mm/fault.c     | 20 +++++---------------
 2 files changed, 13 insertions(+), 29 deletions(-)
