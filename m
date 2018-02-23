Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519414038-2-2630889132996947360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414037; b=chz1uqofQZQUqn/eKVV9nZ2eUxmzI0eXceaT6NR+6YkB2Q4
    nOsC2oo5AjrHdy9ZehWRAOFGJqf1I/z742G6MAR/yRfGTUZ5RklMCohpzU8yibzX
    tKk9c7zFe9Fh5dl6jCXKDy2bsfKWw4XfKLf3iVmlQTgjPYCAvCVvuh/8Yx4NqyhN
    aqhJKRO+kP63fj1G9hLDjNjU0jDBagTtj+kfi/vTJ70NvpNS0+GxMWhUXjPyw4jc
    JBUN5nDCFGvm6KqO1Uw0RKu+zKeDHjh5tbG0o6Ys1AMjm1fjHyGQoC+qpFpNRvxv
    zKDc9vjP5WJ5VHHtgOsl13czSAVYMK6ZCinG0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414037; bh=f6h3VpHuzlr7zJK99xzvChxPNa
    4HUb/wNe2byNA5GcY=; b=L11Q9G5qxRNXzp8WvXTe6n5aSlbu6lgrV/BlaFzpl0
    kIAmlquww9/0/KLjjdRQFFwREpY6oeq18EPVlQIJhY6ysPXkWaKaK86X3MbZZ4U8
    GRuSH1WGAeuIdxGaPicJzB9Xsji+nanly1gDwGVONKwl9pTbe6+gMGhm87gNksRs
    MBEHtSZ7tWEPohHPxi7WyuWOUBj9u4kAci0NJxEpCNE5VjLqKfFOgZEyFMIZUVk3
    3g4KiEUeWbhuEPV9stwu+5bssL+Vj7u+HIj6Xf1an+GUCfeHrlBe1DAZFOMxNI4a
    DT+IupPYBbbhz0wKIb9V69z18T9hb/f2bDGdBe+i+yKQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754472AbeBWT07 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:26:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935135AbeBWSw3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 071/159] perf test shell: Fix check open filename arg using perf trace on s390x
Date: Fri, 23 Feb 2018 19:26:19 +0100
Message-Id: <20180223170752.223365418@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.vnet.ibm.com>


[ Upstream commit ccafc38f1c778847ab6d53dd7933260426731cf3 ]

This 'perf test' case fails on s390x. The 'touch' command on s390x uses
the 'openat' system call to open the file named on the command line:

[root@s35lp76 perf]# perf probe -l
  probe:vfs_getname    (on getname_flags:72@fs/namei.c with pathname)
[root@s35lp76 perf]# perf trace -e open touch /tmp/abc
     0.400 ( 0.015 ms): touch/27542 open(filename:
		/usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
[root@s35lp76 perf]#

There is no 'open' system call for file '/tmp/abc'. Instead the 'openat'
system call is used:

[root@s35lp76 perf]# strace touch /tmp/abc
    execve("/usr/bin/touch", ["touch", "/tmp/abc"], 0x3ffd547ec98
			/* 30 vars */) = 0
    [...]
    openat(AT_FDCWD, "/tmp/abc", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 0666) = 3
    [...]

On s390x the 'egrep' command does not find a matching pattern and
returns an error.

Fix this for s390x create a platform dependent command line to enable
the 'perf probe' call to listen to the 'openat' system call and get the
expected output.

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
LPU-Reference: 20171114071847.2381-1-tmricht@linux.vnet.ibm.com
Link: http://lkml.kernel.org/n/tip-3qf38jk0prz54rhmhyu871my@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -17,8 +17,10 @@ skip_if_no_perf_probe || exit 2
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
 trace_open_vfs_getname() {
-	perf trace -e open touch $file 2>&1 | \
-	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open\(filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+	test "$(uname -m)" = s390x && { svc="openat"; txt="dfd: +CWD, +"; }
+
+	perf trace -e ${svc:-open} touch $file 2>&1 | \
+	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ ${svc:-open}\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
 
