Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E67FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE6420811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTdOJEcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE6420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeLKLzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:55:54 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:43611 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:55:52 -0500
Received: by mail-pf1-f175.google.com with SMTP id w73so7005852pfk.10;
        Tue, 11 Dec 2018 03:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3bXWUq5CeAhUMNM7C0c+x4MGX+cdRwyO0jh9GC4XT0=;
        b=FTdOJEcg8+i4zPT81d+FvZLxyNOeVOeRv7l6341jGbZBMMJaSIUzaoAiEbFSS1rKs1
         zP3qWvOV/HVmC0MLgEMEbTiVq/Zh5u6AwiA/qdmQSdSB3jva/OleqMGpeE9N4DmwNXil
         avDq9x9ENeKC7vtCF+/nckgtgHEGnQClypu9jxOGPlHAlZgmWEHwny3LQPaiXZultT3B
         xW8sgqjpvVMpTHAd12WSKPOv859HIKsjD/FRcrPssxJnCItzWsl0hHDkqFvM643E8SZG
         n9Bf+21hGZhUc8AfyHhUrMt5ifwTE68m5icPqDB7VjPR1t0wUNkgD+hxz+L/u4fqoU53
         5/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3bXWUq5CeAhUMNM7C0c+x4MGX+cdRwyO0jh9GC4XT0=;
        b=CCZ5I/Z7rmIqStHNJ/dWHQWQXjtYkVksM+4ev8MSc+/Z5zEUwpoCvc1KjpUN1tyvgn
         YpTzxxyLNc/H+K224aN+QZnxvbJX21XRnfgc4q2BNcyrQFd0YBw4OYAm/+aIrnN27NIG
         sNzw0ok7QpOSuzGxzlJpaYuwg29fH6c1gg6RvzCSFiTRUbaI7/LQ1jQ1IWaW/B4LGXdv
         irASDnpe/RWi+p8KryyPbzfVroAqiMU6BEP2+By0kQe3fV4I25AKfyQ3chLeUX3qjSR8
         VC+Owf5jGgIObsS6XakmwjgNDdehx7AF/4krHPiWdlh784WTd38tP3woSE3yfSUIkVE3
         bFyA==
X-Gm-Message-State: AA+aEWag5GhR1LFiHFiiIQuS0sTIWDJPr9q/MoGfpxZujECuQWO66XFJ
        mfK3HWG8/MSEge7GUmE5SXY=
X-Google-Smtp-Source: AFSGD/WNJHaO/Wmg7k7N14g0fp8w+vlZe4BbNuJjkkxH+gjiXpdHEBfETkxk9QS1v03KKLIVpi18pQ==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr14221312pgi.217.1544529351783;
        Tue, 11 Dec 2018 03:55:51 -0800 (PST)
Received: from localhost (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id o84sm24104383pfi.172.2018.12.11.03.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:55:51 -0800 (PST)
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
Subject: [PATCH 4/7] selftest/bpf: test_offload PEP8 format style fix
Date:   Tue, 11 Dec 2018 20:56:04 +0900
Message-Id: <20181211115607.13774-5-alice.ferrazzi@gmail.com>
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

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
---
 tools/testing/selftests/bpf/test_offload.py | 68 ++++++++++++++++-----
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index d59642e70f56..f80c4f13991d 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -29,25 +29,30 @@ log_level = 1
 skip_extack = False
 bpf_test_dir = os.path.dirname(os.path.realpath(__file__))
 pp = pprint.PrettyPrinter()
-devs = [] # devices we created for clean up
-files = [] # files to be removed
-netns = [] # net namespaces to be removed
+devs = []  # devices we created for clean up
+files = []  # files to be removed
+netns = []  # net namespaces to be removed
+
 
 def log_get_sec(level=0):
     return "*" * (log_level + level)
 
+
 def log_level_inc(add=1):
     global log_level
     log_level += add
 
+
 def log_level_dec(sub=1):
     global log_level
     log_level -= sub
 
+
 def log_level_set(level):
     global log_level
     log_level = level
 
+
 def log(header, data, level=None):
     """
     Output to an optional log.
@@ -67,6 +72,7 @@ def log(header, data, level=None):
         logfile.write("\n")
     logfile.write(data)
 
+
 def skip(cond, msg):
     if not cond:
         return
@@ -74,6 +80,7 @@ def skip(cond, msg):
     log("SKIP: " + msg, "", level=1)
     os.sys.exit(0)
 
+
 def fail(cond, msg):
     if not cond:
         return
@@ -81,11 +88,13 @@ def fail(cond, msg):
     log("FAIL: " + msg, "", level=1)
     os.sys.exit(1)
 
+
 def start_test(msg):
     log(msg, "", level=1)
     log_level_inc()
     print(msg)
 
+
 def cmd(cmd, shell=True, include_stderr=False, background=False, fail=True):
     """
     Run a command in subprocess and return tuple of (retval, stdout);
@@ -101,6 +110,7 @@ def cmd(cmd, shell=True, include_stderr=False, background=False, fail=True):
 
     return cmd_result(proc, include_stderr=include_stderr, fail=fail)
 
+
 def cmd_result(proc, include_stderr=False, fail=False):
     stdout, stderr = proc.communicate()
     stdout = stdout.decode("utf-8")
@@ -128,11 +138,13 @@ def cmd_result(proc, include_stderr=False, fail=False):
     else:
         return proc.returncode, stdout
 
+
 def rm(f):
     cmd("rm -f %s" % (f))
     if f in files:
         files.remove(f)
 
+
 def tool(name, args, flags, JSON=True, ns="", fail=True, include_stderr=False):
     params = ""
     if JSON:
@@ -158,10 +170,12 @@ def tool(name, args, flags, JSON=True, ns="", fail=True, include_stderr=False):
     else:
         return ret, out
 
+
 def bpftool(args, JSON=True, ns="", fail=True, include_stderr=False):
-    return tool("bpftool", args, {"json":"-p"}, JSON=JSON, ns=ns,
+    return tool("bpftool", args, {"json": "-p"}, JSON=JSON, ns=ns,
                 fail=fail, include_stderr=include_stderr)
 
+
 def bpftool_prog_list(expected=None, ns=""):
     _, progs = bpftool("prog show", JSON=True, ns=ns, fail=True)
     # Remove the base progs
@@ -174,6 +188,7 @@ def bpftool_prog_list(expected=None, ns=""):
                  (len(progs), expected))
     return progs
 
+
 def bpftool_map_list(expected=None, ns=""):
     _, maps = bpftool("map show", JSON=True, ns=ns, fail=True)
     # Remove the base maps
@@ -186,6 +201,7 @@ def bpftool_map_list(expected=None, ns=""):
                  (len(maps), expected))
     return maps
 
+
 def bpftool_prog_list_wait(expected=0, n_retry=20):
     for i in range(n_retry):
         nprogs = len(bpftool_prog_list())
@@ -194,6 +210,7 @@ def bpftool_prog_list_wait(expected=0, n_retry=20):
         time.sleep(0.05)
     raise Exception("Time out waiting for program counts to stabilize want %d, have %d" % (expected, nprogs))
 
+
 def bpftool_map_list_wait(expected=0, n_retry=20):
     for i in range(n_retry):
         nmaps = len(bpftool_map_list())
@@ -202,6 +219,7 @@ def bpftool_map_list_wait(expected=0, n_retry=20):
         time.sleep(0.05)
     raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
 
+
 def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
                       fail=True, include_stderr=False):
     args = "prog load %s %s" % (os.path.join(bpf_test_dir, sample), file_name)
@@ -217,28 +235,35 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
         files.append(file_name)
     return res
 
+
 def ip(args, force=False, JSON=True, ns="", fail=True, include_stderr=False):
     if force:
         args = "-force " + args
-    return tool("ip", args, {"json":"-j"}, JSON=JSON, ns=ns,
+    return tool("ip", args, {"json": "-j"}, JSON=JSON, ns=ns,
                 fail=fail, include_stderr=include_stderr)
 
+
 def tc(args, JSON=True, ns="", fail=True, include_stderr=False):
-    return tool("tc", args, {"json":"-p"}, JSON=JSON, ns=ns,
+    return tool("tc", args, {"json": "-p"}, JSON=JSON, ns=ns,
                 fail=fail, include_stderr=include_stderr)
 
+
 def ethtool(dev, opt, args, fail=True):
     return cmd("ethtool %s %s %s" % (opt, dev["ifname"], args), fail=fail)
 
-def bpf_obj(name, sec=".text", path=bpf_test_dir,):
+
+def bpf_obj(name, sec=".text", path=bpf_test_dir, ):
     return "obj %s sec %s" % (os.path.join(path, name), sec)
 
+
 def bpf_pinned(name):
     return "pinned %s" % (name)
 
+
 def bpf_bytecode(bytecode):
     return "bytecode \"%s\"" % (bytecode)
 
+
 def mknetns(n_retry=10):
     for i in range(n_retry):
         name = ''.join([random.choice(string.ascii_letters) for i in range(8)])
@@ -248,12 +273,14 @@ def mknetns(n_retry=10):
             return name
     return None
 
+
 def int2str(fmt, val):
     ret = []
     for b in struct.pack(fmt, val):
         ret.append(int(b))
     return " ".join(map(lambda x: str(x), ret))
 
+
 def str2int(strtab):
     inttab = []
     for i in strtab:
@@ -268,6 +295,7 @@ def str2int(strtab):
                         (len(strtab)))
     return struct.unpack(fmt, ba)[0]
 
+
 class DebugfsDir:
     """
     Class for accessing DebugFS directories as a dictionary.
@@ -318,6 +346,7 @@ class DebugfsDir:
 
         return dfs
 
+
 class NetdevSim:
     """
     Class for netdevsim netdevice and its attributes.
@@ -340,9 +369,9 @@ class NetdevSim:
 
     def _netdevsim_create(self):
         link = "" if self.link is None else "link " + self.link.dev['ifname']
-        _, old  = ip("link show")
+        _, old = ip("link show")
         ip("link add sim%d {link} type netdevsim".format(link=link))
-        _, new  = ip("link show")
+        _, new = ip("link show")
 
         for dev in new:
             f = filter(lambda x: x["ifname"] == dev["ifname"], old)
@@ -384,7 +413,8 @@ class NetdevSim:
             if nbound == bound and nprogs == total:
                 return
             time.sleep(0.05)
-        raise Exception("Time out waiting for program counts to stabilize want %d/%d, have %d bound, %d loaded" % (bound, total, nbound, nprogs))
+        raise Exception("Time out waiting for program counts to stabilize want %d/%d, have %d bound, %d loaded" % (
+            bound, total, nbound, nprogs))
 
     def set_ns(self, ns):
         name = "1" if ns == "" else ns
@@ -473,7 +503,7 @@ class NetdevSim:
         if chain is not None:
             spec += " chain %d" % (chain)
 
-        return tc("filter {op} dev {dev} {qdisc} {spec} {cls} {params}"\
+        return tc("filter {op} dev {dev} {qdisc} {spec} {cls} {params}"
                   .format(op=op, dev=self['ifname'], qdisc=qdisc, spec=spec,
                           cls=cls, params=params),
                   fail=fail, include_stderr=include_stderr)
@@ -502,6 +532,7 @@ class NetdevSim:
         args = "hw-tc-offload %s" % ("on" if enable else "off")
         return ethtool(self, "-K", args, fail=fail)
 
+
 ################################################################################
 def clean_up():
     global files, netns, devs
@@ -515,6 +546,7 @@ def clean_up():
     files = []
     netns = []
 
+
 def pin_prog(file_name, idx=0):
     progs = bpftool_prog_list(expected=(idx + 1))
     prog = progs[idx]
@@ -523,6 +555,7 @@ def pin_prog(file_name, idx=0):
 
     return file_name, bpf_pinned(file_name)
 
+
 def pin_map(file_name, idx=0, expected=1):
     maps = bpftool_map_list(expected=expected)
     m = maps[idx]
@@ -531,6 +564,7 @@ def pin_map(file_name, idx=0, expected=1):
 
     return file_name, bpf_pinned(file_name)
 
+
 def check_dev_info_removed(prog_file=None, map_file=None):
     bpftool_prog_list(expected=0)
     ret, err = bpftool("prog show pin %s" % (prog_file), fail=False)
@@ -546,6 +580,7 @@ def check_dev_info_removed(prog_file=None, map_file=None):
          "Showing map with removed device expected ENODEV, error is %s" %
          (err["error"]))
 
+
 def check_dev_info(other_ns, ns, prog_file=None, map_file=None, removed=False):
     progs = bpftool_prog_list(expected=1, ns=ns)
     prog = progs[0]
@@ -568,6 +603,7 @@ def check_dev_info(other_ns, ns, prog_file=None, map_file=None, removed=False):
         fail("dev" not in m.keys(), "Device parameters not reported")
         fail(dev != m["dev"], "Map's device different than program's")
 
+
 def check_extack(output, reference, args):
     if skip_extack:
         return
@@ -575,13 +611,16 @@ def check_extack(output, reference, args):
     comp = len(lines) >= 2 and lines[1] == 'Error: ' + reference
     fail(not comp, "Missing or incorrect netlink extack message")
 
+
 def check_extack_nsim(output, reference, args):
     check_extack(output, "netdevsim: " + reference, args)
 
+
 def check_no_extack(res, needle):
     fail((res[1] + res[2]).count(needle) or (res[1] + res[2]).count("Warning:"),
          "Found '%s' in command output, leaky extack?" % (needle))
 
+
 def check_verifier_log(output, reference):
     lines = output.split("\n")
     for l in reversed(lines):
@@ -589,6 +628,7 @@ def check_verifier_log(output, reference):
             return
     fail(True, "Missing or incorrect message from netdevsim in verifier log")
 
+
 def test_spurios_extack(sim, obj, skip_hw, needle):
     res = sim.cls_bpf_add_filter(obj, prio=1, handle=1, skip_hw=skip_hw,
                                  include_stderr=True)
@@ -1056,7 +1096,7 @@ try:
     sim = NetdevSim()
     map_obj = bpf_obj("sample_map_ret0.o")
     start_test("Test loading program with maps...")
-    sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
+    sim.set_xdp(map_obj, "offload", JSON=False)  # map fixup msg breaks JSON
 
     start_test("Test bpftool bound info reporting (own ns)...")
     check_dev_info(False, "")
@@ -1087,7 +1127,7 @@ try:
     sim = NetdevSim()
 
     start_test("Test map update (no flags)...")
-    sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
+    sim.set_xdp(map_obj, "offload", JSON=False)  # map fixup msg breaks JSON
     maps = bpftool_map_list(expected=2)
     array = maps[0] if maps[0]["type"] == "array" else maps[1]
     htab = maps[0] if maps[0]["type"] == "hash" else maps[1]
@@ -1168,7 +1208,7 @@ try:
     sim.remove()
 
     sim = NetdevSim()
-    sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
+    sim.set_xdp(map_obj, "offload", JSON=False)  # map fixup msg breaks JSON
     sim.remove()
     bpftool_map_list_wait(expected=0)
 
-- 
2.19.2

