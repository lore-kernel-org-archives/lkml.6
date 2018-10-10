Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40498C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC9A2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC9A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeJKFb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:31:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51711 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeJKFb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:31:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gAMdQ-0004O6-Pz; Wed, 10 Oct 2018 16:07:16 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gAMdB-00086K-Fd; Wed, 10 Oct 2018 16:07:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
References: <20181010020641.GE13396@shao2-debian>
        <87sh1dvmc5.fsf@xmission.com>
Date:   Wed, 10 Oct 2018 17:06:52 -0500
In-Reply-To: <87sh1dvmc5.fsf@xmission.com> (Eric W. Biederman's message of
        "Wed, 10 Oct 2018 10:43:38 -0500")
Message-ID: <87h8htv4lf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gAMdB-00086K-Fd;;;mid=<87h8htv4lf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+C8+NQGdDit9eMbrncDKOBGWSbptvxYsE=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [LKP] 4ce5f9c9e7 [ 1.323881] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:1031 kmalloc_slab
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> So I am flummoxed.  I am reading through the code and I don't see
> anything that could trigger this, and when I ran the supplied reproducer
> it did not reproduce for me.

Even more so.  With my tool chain the line that reports the failing
address is impossible.

[   73.034423] RIP: 0010:copy_siginfo_from_user+0x4d/0xd0

With the supplied configureation my tool chain only has 0x30 bytes for
all of copy_siginfo_from_user.  So I can't even begin to guess where
in that function things are failing.

Any additional information that you can provide would be a real help
in tracking down this strange failure.

Thank you,
Eric Biederman

