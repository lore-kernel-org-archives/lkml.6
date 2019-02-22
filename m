Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526CD20818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550798814;
	bh=989A7BSexnRSnyzjf9YT8Eh4dwSWd28SmE2hX3v+aMM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iVRDUehT/Ip/4HWsAEA4CzNTDHLKx2+DZXvO/C+ByN0Kx8AlRc+Y8XtK4+yNhaCVz
	 C8y/qDHeX5NM6JK2SM62rPPofoS8/jfo2UTZbfln70MOeuuWjYJOwTgd21IHooM+b1
	 17Z/yDNLxoSLQXQ/NeNPkgQuX8iWf/tC79yXi0OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfBVB0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfBVB0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:26:52 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5CA2080F;
        Fri, 22 Feb 2019 01:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550798811;
        bh=989A7BSexnRSnyzjf9YT8Eh4dwSWd28SmE2hX3v+aMM=;
        h=From:To:Cc:Subject:Date:From;
        b=zPe5+ekuZWP4alc+UGg8YcvXAs6u1HTvHnMky9+QLeq+Jr8C21q41xSKXjylf6byo
         FI/ut2+ur/JAvRTYFgWQs4FpMCwWhOzgEH0pKvVlrBjuqqWOvJlIRairD0A5WZjZ1Q
         bOvLvl7nkTFQiFBv41QIoNIGrYVInzm5x07Tpa6I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH selftests 0/2] Add checkbashisms meta-testcase
Date:   Fri, 22 Feb 2019 10:26:27 +0900
Message-Id: <155079878723.5157.12433171255092403676.stgit@devbox>
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

Here are patches for making sure the ftracetest testcases
are checkbashisms clean.

This actually needs a patch from Juerg, "selftests/ftrace:
Make the coloring POSIX compliant" to complete the work.

http://lkml.kernel.org/r/20190220161333.28109-1-juergh@canonical.com
(Note that this is still under development)

So as Juerg pointed, recently ftracetest becomes not POSIX
compliant, and such kind of issues happened repeatedly.
To avoid those anymore, I decided to introduce a testcase
which runs checkbasisms on ftracetest and its testcases.
I think this can help us to find out whether it was
written in a way out of POSIX.

Thank you,

---

Masami Hiramatsu (2):
      selftests/ftrace: Make a script checkbashisms clean
      selftests/ftrace: Add checkbashisms meta-testcase


 tools/testing/selftests/ftrace/ftracetest          |    1 +
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    2 +-
 .../selftests/ftrace/test.d/selftest/bashisms.tc   |   21 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
