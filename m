Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5842C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9672084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfALRUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:20:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:43379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfALRUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:20:07 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUlV-1geGGm3i65-004iaL; Sat, 12
 Jan 2019 18:14:42 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] kernel/sys.c: Clarify that UNAME26 does not generate unique versions anymore
Date:   Sat, 12 Jan 2019 18:14:30 +0100
Message-Id: <20190112171432.11309-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAHk-=wgAH7QZrAyzaTV1-6MecaSdVkiowSZEM7qwa0L2oegpLA@mail.gmail.com>
References: <CAHk-=wgAH7QZrAyzaTV1-6MecaSdVkiowSZEM7qwa0L2oegpLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X7YqSsUp/bUlVd/W068eqfOmXqKb06eaYslFsm0tTXnattKabUe
 LuLVGZmaBU1aPjsTCpbN5fICrSKCMHqElBJyvT0hr3kSSbiclPE/pVYONjd1eXveUe76JjJ
 842UiD/x1a2gcsbz4tWVlcbsJ4uSF4v/s79c5mBfhGqfACCdQ3vrdl/ROXK6ih7UeTEcYWE
 bNR6cZD/bZ6TbSAb0otUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8iGpCx1FRhk=:3gP/qYWWrHPjn0zzBSBKpG
 35fPm+OgWIk/NDD3q2b5lSxTNwB5xh3Q2c9ZDlo/KprfsZN5oi+6Xd3S2u9CIM4YofdpTezKr
 VtxxzfRGN5JOVAO7blaKB7G1eLF5LrCuA3txtpqLMe+90pxM0T5H5I6RZCfD5PslvRFLUlphW
 jMRs9WnR0kGG/p5w6SVp0Pyp8nYf0BTQP4PQieyckVKfxh3YdcfLyaY+TsNhJnd5Lyi1DqWv4
 DJZbuyFH1f+SqP+YOW1Q42OZt7O/YLf2zRABQznmtkwGJgW1RUGoRR1izVFKghPzHAADB+VKD
 eqMUbcj9TrLXGlapLfhJkN0F9ota7PmK/ggTUt916yviBSDk+QRuqOuIV4T0TItC+GhEgWDdS
 awyKbh+06CYAHgjRfcZnpLbowggGlm2iyhsEXBwPrJnzbjlp1vNf/4yAiaeV6HkE7iK8f/HbR
 umFenz/3EO9pC3sx5DhVaJSGIu8c4ixk52+HZTYDAQ+nm6bgSYfmB4mkm7cp3otjeYl0qhHm/
 tfzXqHfJ1crfSwkta9Jb/aVj2O17l7hQ2BXcNKYJZqXQxxESmlyRjjJ3O3DCoK1kXCswAzxgd
 Hr2AhAy0vstellQxgp3zwbyZIGecNxjyNa2gPt1TLIMhI4g6uYG1X3dR7h0/r1sUQ72KhHrLk
 YGRmHmIMC37mAWK3Ru3o1++/hII6Vibm9uo2sM9c3ju713fOUgQqaScW//j3/WF7LgFcIkqhP
 zdkQ4J4L0RanQSMFypWsGzZ7U/qoWeKrhIMjUTexWjgd8HJOwIFaPQ2EtRRre9q+BZDBq6eeU
 a7xSEOxm9qBDocU0uvOxlbcxf9AiPPyiB7UHejEixL5PB9BdKvX9SLxtpJCpw5SEzIteg1yqe
 xcTsHPPUhQJzwaOsrBuQpxABlOBu3pGZJXnSSH9NwNFmSZ0ySqq3D0sqgjGHWyfk1dM4mfebN
 XO9lxGkjWag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNAME26 is a mechanism to report Linux's version as 2.6.x, for
compatibility with old/broken software. Due to the way it is
implemented, it would have to be updated after 5.0, to keep the
resulting versions unique. Linus Torvalds argued:

> Do we actually need this?
>
> I'd rather let it bitrot, and just let it return random versions. It
> will just start again at 2.4.60, won't it?
>
> Anybody who uses UNAME26 for a 5.x kernel might as well think it's
> still 4.x. The user space is so old that it can't possibly care about
> differences between 4.x and 5.x, can it?
>
> The only thing that matters is that it shows "2.4.<largeenough>",
> which it will do regardless.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2:
- Switched to documenting why UNAME26 is not updated

v1:
- https://lore.kernel.org/patchwork/patch/1029578/
---
 kernel/sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index a48cbf1414b8..f7eb62eceb24 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1207,7 +1207,8 @@ DECLARE_RWSEM(uts_sem);
 /*
  * Work around broken programs that cannot handle "Linux 3.0".
  * Instead we map 3.x to 2.6.40+x, so e.g. 3.0 would be 2.6.40
- * And we map 4.x to 2.6.60+x, so 4.0 would be 2.6.60.
+ * And we map 4.x and later versions to 2.6.60+x, so 4.0/5.0/6.0/... would be
+ * 2.6.60.
  */
 static int override_release(char __user *release, size_t len)
 {
-- 
2.20.1

