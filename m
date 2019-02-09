Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4423DC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0499521773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBIMYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:24:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:24:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19COKnI2626537
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:24:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19COKNp2626534;
        Sat, 9 Feb 2019 04:24:20 -0800
Date:   Sat, 9 Feb 2019 04:24:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-8f2f350cbdb2c2fbff654cb778139144b48a59ba@git.kernel.org>
Cc:     ravi.bangoria@linux.ibm.com, hpa@zytor.com,
        s1seetee@linux.vnet.ibm.com, tonyj@suse.de, corbet@lwn.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
        acme@redhat.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
          acme@redhat.com, tglx@linutronix.de, ravi.bangoria@linux.ibm.com,
          hpa@zytor.com, tonyj@suse.de, s1seetee@linux.vnet.ibm.com,
          corbet@lwn.net
In-Reply-To: <20190124005229.16146-7-tonyj@suse.de>
References: <20190124005229.16146-7-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Add Python3 support to
 tests/attr.py
Git-Commit-ID: 8f2f350cbdb2c2fbff654cb778139144b48a59ba
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8f2f350cbdb2c2fbff654cb778139144b48a59ba
Gitweb:     https://git.kernel.org/tip/8f2f350cbdb2c2fbff654cb778139144b48a59ba
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Wed, 23 Jan 2019 16:52:29 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 5 Feb 2019 10:31:08 -0300

perf script python: Add Python3 support to tests/attr.py

Support both Python 2 and Python 3 in tests/attr.py

The use of "except as" syntax implies the minimum supported Python2 version is
now v2.6

Committer testing:

  $ make -C tools/perf PYTHON3=python install-bin

Before:

  # perf test attr
  16: Setup struct perf_event_attr                          : FAILED!
  48: Synthesize attr update                                : Ok
  [root@quaco ~]# perf test -v attr
  16: Setup struct perf_event_attr                          :
  --- start ---
  test child forked, pid 3121
    File "/home/acme/libexec/perf-core/tests/attr.py", line 324
      except Unsup, obj:
                ^
  SyntaxError: invalid syntax
  test child finished with -1
  ---- end ----
  Setup struct perf_event_attr: FAILED!
  48: Synthesize attr update                                :
  --- start ---
  test child forked, pid 3124
  test child finished with 0
  ---- end ----
  Synthesize attr update: Ok
  #

After:

   # perf test attr
  16: Setup struct perf_event_attr                          : Ok
  48: Synthesize attr update                                : Ok
  #

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190124005229.16146-7-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.py | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 44090a9a19f3..e952127e4fb0 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -1,6 +1,8 @@
 #! /usr/bin/python
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 import os
 import sys
 import glob
@@ -8,7 +10,11 @@ import optparse
 import tempfile
 import logging
 import shutil
-import ConfigParser
+
+try:
+    import configparser
+except ImportError:
+    import ConfigParser as configparser
 
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
@@ -100,20 +106,20 @@ class Event(dict):
     def equal(self, other):
         for t in Event.terms:
             log.debug("      [%s] %s %s" % (t, self[t], other[t]));
-            if not self.has_key(t) or not other.has_key(t):
+            if t not in self or t not in other:
                 return False
             if not data_equal(self[t], other[t]):
                 return False
         return True
 
     def optional(self):
-        if self.has_key('optional') and self['optional'] == '1':
+        if 'optional' in self and self['optional'] == '1':
             return True
         return False
 
     def diff(self, other):
         for t in Event.terms:
-            if not self.has_key(t) or not other.has_key(t):
+            if t not in self or t not in other:
                 continue
             if not data_equal(self[t], other[t]):
                 log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
@@ -134,7 +140,7 @@ class Event(dict):
 #   - expected values assignments
 class Test(object):
     def __init__(self, path, options):
-        parser = ConfigParser.SafeConfigParser()
+        parser = configparser.SafeConfigParser()
         parser.read(path)
 
         log.warning("running '%s'" % path)
@@ -193,7 +199,7 @@ class Test(object):
         return True
 
     def load_events(self, path, events):
-        parser_event = ConfigParser.SafeConfigParser()
+        parser_event = configparser.SafeConfigParser()
         parser_event.read(path)
 
         # The event record section header contains 'event' word,
@@ -207,7 +213,7 @@ class Test(object):
             # Read parent event if there's any
             if (':' in section):
                 base = section[section.index(':') + 1:]
-                parser_base = ConfigParser.SafeConfigParser()
+                parser_base = configparser.SafeConfigParser()
                 parser_base.read(self.test_dir + '/' + base)
                 base_items = parser_base.items('event')
 
@@ -322,9 +328,9 @@ def run_tests(options):
     for f in glob.glob(options.test_dir + '/' + options.test):
         try:
             Test(f, options).run()
-        except Unsup, obj:
+        except Unsup as obj:
             log.warning("unsupp  %s" % obj.getMsg())
-        except Notest, obj:
+        except Notest as obj:
             log.warning("skipped %s" % obj.getMsg())
 
 def setup_log(verbose):
@@ -363,7 +369,7 @@ def main():
     parser.add_option("-p", "--perf",
                       action="store", type="string", dest="perf")
     parser.add_option("-v", "--verbose",
-                      action="count", dest="verbose")
+                      default=0, action="count", dest="verbose")
 
     options, args = parser.parse_args()
     if args:
@@ -373,7 +379,7 @@ def main():
     setup_log(options.verbose)
 
     if not options.test_dir:
-        print 'FAILED no -d option specified'
+        print('FAILED no -d option specified')
         sys.exit(-1)
 
     if not options.test:
@@ -382,8 +388,8 @@ def main():
     try:
         run_tests(options)
 
-    except Fail, obj:
-        print "FAILED %s" % obj.getMsg();
+    except Fail as obj:
+        print("FAILED %s" % obj.getMsg())
         sys.exit(-1)
 
     sys.exit(0)
