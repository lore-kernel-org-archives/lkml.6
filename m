Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C15C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F0120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scub+JjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F0120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeLKL4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:56:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34429 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKL4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:56:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so6544453pgg.1;
        Tue, 11 Dec 2018 03:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2YPMnrZvb/ynXn//cGGy9dniHzNzN3agBhFSIWj+m/Y=;
        b=scub+JjWu816DwOm7gKbzY6eTQJni0wcPZNApNxW1vYBfo9nysd+3hPxTtpsQJAsiS
         iI/N4UxfstUj0Ts9CgKf5xx0diZ8zCAh7/u+XqC7Y/6ic9A9dHLl4c581SKuweGMx4hy
         a1nfSmlszeoI/c4kRKs9ZQLeZZRG4DbCQ2T8n2UwzHO3JO5i7S5pom5EomgKn4riFRi3
         17KuQyce3w0vJFx++xv867dHGw+92Tzoc06XrITUWiRaDyZoMd1yX1bx+XfgVZ561aaF
         M/SjmWxQdN60JfTGYguZTq2lZfFO3V9lt4TJzoXDPYCyxYgYZ0YV8X+M2E60CTy1Z0KJ
         n3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YPMnrZvb/ynXn//cGGy9dniHzNzN3agBhFSIWj+m/Y=;
        b=SXQHbQy5mn64goDpR9jC55tT0NA/PrhWZs1uE51FmzRfNWG4RuunQOMjEt/Xu9UaFu
         qUCJVlf/SPfPQeu1LF0J3lvaoTLcmUWCESAvE3gygilJt4Yg2btyasyKpYiNvN9oL8/L
         /z+7Ax3SyCgc/MnNISluKSM5BDtnfcfsn/RmQdJIZzQYoMgj8kf1zkMIqRBOe2XRdG7b
         LFvcQEDbZ3U3ovdfCxEFMaFIxYF6eq8Wr93vE9LhYa7JYVe18uLGaw6x1FwMo3SEucjv
         In8bp0LfNXtf8HjQGoZcNhpSVHHZeylZfTedsvCO5Rtfw0N+ZurdhGHDs/K9rVq4kW3u
         MOMQ==
X-Gm-Message-State: AA+aEWZLa825zuc+r4TclqiNtlQ/OlHG+HIDg9g63mKp8628zBq3OZJl
        32NR7O/w5cifeaDVtBggqkOsFoyE
X-Google-Smtp-Source: AFSGD/XdTftpYxdBi8BETy9Pl9MYcZuCsVuTMqN8o/TMJmfDcpvF8BCaqS2jO8Ekgu9jkTk/oau/bQ==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr14543305pgp.263.1544529362854;
        Tue, 11 Dec 2018 03:56:02 -0800 (PST)
Received: from localhost (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id u8sm19581710pfl.16.2018.12.11.03.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:56:02 -0800 (PST)
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
Subject: [PATCH 7/7] selftest/bpf: fix E501 line too long
Date:   Tue, 11 Dec 2018 20:56:07 +0900
Message-Id: <20181211115607.13774-8-alice.ferrazzi@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix PEP8 style issues

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
---
 tools/testing/selftests/bpf/test_offload.py | 35 +++++++++++++--------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index b06cc0eea0eb..3f78da0f87d5 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -208,7 +208,8 @@ def bpftool_prog_list_wait(expected=0, n_retry=20):
         if nprogs == expected:
             return
         time.sleep(0.05)
-    raise Exception("Time out waiting for program counts to stabilize want %d, have %d" % (expected, nprogs))
+    raise Exception("Time out waiting for program counts \
+to stabilize want %d, have %d" % (expected, nprogs))
 
 
 def bpftool_map_list_wait(expected=0, n_retry=20):
@@ -217,7 +218,8 @@ def bpftool_map_list_wait(expected=0, n_retry=20):
         if nmaps == expected:
             return
         time.sleep(0.05)
-    raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
+    raise Exception("Time out waiting for map counts to \
+stabilize want %d, have %d" % (expected, nmaps))
 
 
 def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
@@ -413,7 +415,8 @@ class NetdevSim:
             if nbound == bound and nprogs == total:
                 return
             time.sleep(0.05)
-        raise Exception("Time out waiting for program counts to stabilize want %d/%d, have %d bound, %d loaded" % (
+        raise Exception("Time out waiting for program counts to \
+stabilize want %d/%d, have %d bound, %d loaded" % (
             bound, total, nbound, nprogs))
 
     def set_ns(self, ns):
@@ -533,7 +536,7 @@ class NetdevSim:
         return ethtool(self, "-K", args, fail=fail)
 
 
-################################################################################
+###############################################################################
 def clean_up():
     global files, netns, devs
 
@@ -617,7 +620,8 @@ def check_extack_nsim(output, reference, args):
 
 
 def check_no_extack(res, needle):
-    fail((res[1] + res[2]).count(needle) or (res[1] + res[2]).count("Warning:"),
+    fail((res[1] + res[2]).count(needle) or (res[1] +
+         res[2]).count("Warning:"),
          "Found '%s' in command output, leaky extack?" % (needle))
 
 
@@ -778,8 +782,9 @@ try:
     start_test("Test TC replace bad flags...")
     for i in range(3):
         for j in range(3):
-            ret, _ = sim.cls_bpf_add_filter(obj, op="replace", prio=1, handle=1,
-                                            skip_sw=(j == 1), skip_hw=(j == 2),
+            ret, _ = sim.cls_bpf_add_filter(obj, op="replace", prio=1,
+                                            handle=1, skip_sw=(j == 1),
+                                            skip_hw=(j == 2),
                                             fail=False)
             fail(bool(ret) != bool(j),
                  "Software TC incorrect load in replace test, iteration %d" %
@@ -824,9 +829,11 @@ try:
     fail(dprog["state"] != "xlated", "Offloaded program state not translated")
     fail(dprog["loaded"] != "Y", "Offloaded program is not loaded")
 
-    start_test("Test disabling TC offloads is rejected while filters installed...")
+    start_test("Test disabling TC offloads is rejected while \
+filters installed...")
     ret, _ = sim.set_ethtool_tc_offloads(False, fail=False)
-    fail(ret == 0, "Driver should refuse to disable TC offloads with filters installed...")
+    fail(ret == 0, "Driver should refuse to disable TC offloads with filters \
+installed...")
 
     start_test("Test qdisc removal frees things...")
     sim.tc_flush_filters()
@@ -922,7 +929,8 @@ try:
     offload = bpf_pinned("/sys/fs/bpf/offload")
     ret, _, err = sim.set_xdp(offload, "drv", fail=False, include_stderr=True)
     fail(ret == 0, "attached offloaded XDP program to drv")
-    check_extack(err, "using device-bound program without HW_MODE flag is not supported.", args)
+    check_extack(err, "using device-bound program without HW_MODE flag is not \
+supported.", args)
     rm("/sys/fs/bpf/offload")
     sim.wait_for_flush()
 
@@ -1072,8 +1080,8 @@ try:
     delay_msec = 500
     sim.dfs["bpf_bind_verifier_delay"] = delay_msec
     start = time.time()
-    cmd_line = "tc filter add dev %s ingress bpf %s da skip_sw" % \
-               (sim['ifname'], obj)
+    cmd_line = "tc filter add dev %s ingress bpf %s da skip_sw" %
+    (sim['ifname'], obj)
     tc_proc = cmd(cmd_line, background=True, fail=False)
     # Wait for the verifier to start
     while sim.dfs_num_bound_progs() <= 2:
@@ -1244,7 +1252,8 @@ try:
     ret, _ = simA.set_xdp(progB, "offload", force=True, JSON=False, fail=False)
     fail(ret == 0, "cross-ASIC program allowed")
     for d in simB:
-        ret, _ = d.set_xdp(progA, "offload", force=True, JSON=False, fail=False)
+        ret, _ = d.set_xdp(progA, "offload", force=True, JSON=False,
+                           fail=False)
         fail(ret == 0, "cross-ASIC program allowed")
 
     start_test("Test multi-dev ASIC cross-dev install...")
-- 
2.19.2

