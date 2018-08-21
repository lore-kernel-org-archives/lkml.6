Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E18C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E4A2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0yASn7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E4A2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeHUM5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbeHUM5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:57:24 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8FFF216C4;
        Tue, 21 Aug 2018 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534844279;
        bh=3jMt+nZ52o+H8+fgMvTge2bEZOCIcl+WfVrgZmF9dTE=;
        h=From:To:Cc:Subject:Date:From;
        b=A0yASn7gsly1fW901IhGEJ1CmNE4B3TguiSSoBcwISCONDWgCLCxJxC/zt/8tUuQ6
         6LgbYSVD4fomOPqeP6TwOLqVAlIc8Uj1dRIcc7xJSTLzvL1RYGhU1Lazdz7RkSQrDD
         QpRn+WhBXzVS1gpE2XZbzILDSMQdkCCsHxOVPmUc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip 0/5] kprobes: Remove BUG_ON from kprobes
Date:   Tue, 21 Aug 2018 18:37:35 +0900
Message-Id: <153484425558.5385.1484910606397784412.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are patches to remove BUG_ON from kprobes.

Since BUG_ON() kills the machine, it must not be used
for debugging or assertion. These patches remove
meaningless BUG_ON or replace it with return errors.

Thank you,

---

Masami Hiramatsu (5):
      kprobes: Remove meaningless BUG_ON from disarming process
      kprobes: Remove meaningless BUG_ON from add_new_kprobe
      kprobes: Remove meaningless BUG_ON from reuse_unused_kprobe
      kprobes: Return error if fail to reuse kprobe instead of BUG_ON
      kprobes: Don't call BUG_ON if there is a kprobe in use on free list


 kernel/kprobes.c |   39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
