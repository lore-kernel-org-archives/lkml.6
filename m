Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA36C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DE320868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfAQXQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:16:05 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48048 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfAQXQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:16:01 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkGse-0000yc-BJ; Fri, 18 Jan 2019 00:15:24 +0100
Message-Id: <20190117231501.560475279@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 18 Jan 2019 00:14:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        YueHaibing <yuehaibing@huawei.com>, Yonghong Song <yhs@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Sean Young <sean@mess.org>, Jiri Benc <jbenc@redhat.com>,
        David Calavera <david.calavera@gmail.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        David Ahern <dsahern@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Petar Penkov <ppenkov@stanford.edu>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Stephen Hemminger <stephen@networkplumber.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        okash.khawaja@gmail.com, netdev@vger.kernel.org
Subject: [patch 8/9] tools: bpftool: Cleanup license mess
References: <20190117231416.111952141@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Precise and non-ambiguous license information is important. The recent
relicensing of the bpftools introduced a license conflict.

The files have now:

     SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause

and

     * This program is free software; you can redistribute it and/or
     * modify it under the terms of the GNU General Public License
     * as published by the Free Software Foundation; either version
     * 2 of the License, or (at your option) any later version

Amazingly about 20 people acked that change and neither they nor the
committer noticed. Oh well.

Digging deeper: The files were imported from the iproute2 repository with
the GPL V2 or later boiler plate text in commit b66e907cfee2 ("tools:
bpftool: copy JSON writer from iproute2 repository")

Looking at the iproute2 repository at

  git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

the following commit is the equivivalent:

  commit d9d8c839 ("json_writer: add SPDX Identifier (GPL-2/BSD-2)")

That commit explicitly removes the boiler plate and relicenses the code
uner GPL-2.0-only and BSD-2-Clause. As Steven wrote the original code and
also the relicensing commit, it's assumed that the relicensing was intended
to do exaclty that. Just the kernel side update failed to remove the boiler
plate. Do so now.

Fixes: 907b22365115 ("tools: bpftool: dual license all files")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Sean Young <sean@mess.org>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: David Calavera <david.calavera@gmail.com>
Cc: Andrey Ignatov <rdna@fb.com>
Cc: Joe Stringer <joe@wand.net.nz>
Cc: David Ahern <dsahern@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Petar Penkov <ppenkov@stanford.edu>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
CC: okash.khawaja@gmail.com
Cc: netdev@vger.kernel.org
---

P.S.: This patch is part of a larger cleanup, but independent of other
      patches and is intended to be picked up by the maintainer directly.

---
 tools/bpf/bpftool/json_writer.c |    7 +------
 tools/bpf/bpftool/json_writer.h |    5 -----
 2 files changed, 1 insertion(+), 11 deletions(-)

--- a/tools/bpf/bpftool/json_writer.c
+++ b/tools/bpf/bpftool/json_writer.c
@@ -1,15 +1,10 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
  * Simple streaming JSON writer
  *
  * This takes care of the annoying bits of JSON syntax like the commas
  * after elements
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
  * Authors:	Stephen Hemminger <stephen@networkplumber.org>
  */
 
--- a/tools/bpf/bpftool/json_writer.h
+++ b/tools/bpf/bpftool/json_writer.h
@@ -5,11 +5,6 @@
  * This takes care of the annoying bits of JSON syntax like the commas
  * after elements
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
  * Authors:	Stephen Hemminger <stephen@networkplumber.org>
  */
 


