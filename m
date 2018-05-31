Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1611488-1527778953-2-6756784241994959945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527778950; b=PCwDklusXJdx6c+Ol4+3QUxzZOfkn97rDUKeYKp4WwV5eksEzp
    rFDVdI7M03AeqVlTDUB1dL9RJoKiFCilXTC6zF1nQxpgJNvf5BBTdfExupOXXPQk
    vMw0afg538M65BPfR4wbCDy3dXBRdV4UiC+ufNyex2b3wr2dhNmRswvxf5juFERT
    rCPHbepDmymbnVHgmeX9VHeyEiGAUvBXCw2XD5BpVypsgcuFCnSzwfZ6K7NPmV0b
    AUkVNYnrCfB5BTcI7/eu6Dmy54LczEfE6En9zbzFWURSZ6Nh9ZRacZ6Cmj74Gxah
    LVEwK9eDQZxlHd7oK7cW062yWWkB53j87ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527778950; bh=
    IYepeFnqrRq1PA1LTDSXNHl9eHWlDgVXFGPYMiPSBHk=; b=glK7c5dim0Odla3d
    LdbEZ2JXK/vLVF36UVlItAPDQYx7L+cXgDFUgZC3ZalPnTE6xgrX3iA5sNxJgpfV
    eMKu/TJ0Iso8JssJzyHy8GgsWApFJoLv+24GJLgdYHqQZq70p6L0IVhM03zhNMur
    VtU7gBf0guSYP9PKhNGCE9ARnLHvk1zdx2aY6Xl10lL9yD4QA6cwexAExv/EOQZB
    aLOVogAJWtMr/cMhgha4VMzELwHOpwzLxGs72buFa6lKsLqGqdMB5Hv61//OlhER
    XTzyip5n5IaH6PCI/dJ6vWQvxqSLJ9jakfSra2pwrN+xjaHN3oTSJqPilRafRVGQ
    jDcc5g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NlqY+N5T header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=NlqY+N5T header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM87A5Fb7u2wb1WNyk+ZcGg7a0FcoQ+Xn/EmKgoRVBCPHTnK1sirXrHQS12+qzZN5UDjvjjBC6hadIzw0qSSEAUB0tjX+GFdr7S9LgL/I0BcthgltKhG
    3dsIi0+Rc7gpuhc4gzo/75i/2jIMvLkvh8VSU7AAMzEacOmKfo51FB1xpb9yywG070gagyEDiMe2pdnXLAgMlROopu8tq+Q5Ag5vgU+oqzUnXjqm9m+dRbH1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=LM-GQKInOcAnbAygF_QA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755421AbeEaPC2 (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 11:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755414AbeEaPC0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 11:02:26 -0400
From: Jeff Layton <jlayton@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, willy@infradead.org,
        andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk
Subject: [fstests PATCH] generic: test reporting of wb errors via syncfs
Date: Thu, 31 May 2018 11:02:24 -0400
Message-Id: <20180531150224.24933-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531112945.8629-1-jlayton@kernel.org>
References: <20180531112945.8629-1-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

Add a test for new syncfs error reporting behavior. When an inode fails
to be written back, ensure that we report an error to a subsequent call
to syncfs().

Because we don't want to grow struct file in order to support this, we
only do this if the file was opened with O_PATH flag.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 tests/generic/999     | 99 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  8 ++++
 tests/generic/group   |  1 +
 3 files changed, 108 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

This is the companion testcase patch to this series:

    [PATCH v2 0/5] vfs: allow syncfs to return an error when inode writeback fails

We probably don't want to merge this until it's clear that treating
syncfs differently on an O_PATH open is OK.

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 000000000000..e468d0108ce5
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,99 @@
+#! /bin/bash
+# FS QA Test No. 999
+#
+# Open a file and write to it and fsync. Then, flip the data device to throw
+# errors, write to it again and do an fdatasync. Then open an O_PATH fd on the
+# same file and call syncfs against it and ensure that an error is reported,
+# then call syncfs again and ensure that no error is reported. Finally, repeat
+# the open and syncfs and ensure that there is no error reported.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018, Jeff Layton <jlayton@redhat.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_dmerror_cleanup
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmerror
+
+# real QA test starts here
+_supported_os Linux
+_require_xfs_io_command 'open' '-P'
+_require_scratch_nocheck
+# This test uses "dm" without taking into account the data could be on
+# realtime subvolume, thus the test will fail with rtinherit=1
+_require_no_rtinherit
+_require_dm_target error
+
+rm -f $seqres.full
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_dmerror_init
+_dmerror_mount
+
+datalen=65536
+_require_fs_space $SCRATCH_MNT $datalen
+
+# use fd 5 to hold file open
+testfile=$SCRATCH_MNT/syncfs-reports-errors
+exec 5>$testfile
+
+# write some data to file and fsync it out
+$XFS_IO_PROG -c "pwrite -W -q 0 $datalen" $testfile
+
+# flip device to non-working mode
+_dmerror_load_error_table
+
+# rewrite the data, and do fdatasync
+$XFS_IO_PROG -c "pwrite -w -q 0 $datalen" $testfile
+
+# heal the device error
+_dmerror_load_working_table
+
+# open again and call syncfs twice
+echo "One of the following syncfs calls should fail with EIO:"
+$XFS_IO_PROG -P -c syncfs -c syncfs $testfile
+echo "done"
+
+echo "This syncfs call should succeed:"
+$XFS_IO_PROG -P -c syncfs $testfile
+echo "done"
+
+# close file
+exec 5>&-
+
+# success, all done
+_dmerror_cleanup
+
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 000000000000..950a2ba42503
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,8 @@
+QA output created by 999
+Format and mount
+fdatasync: Input/output error
+One of the following syncfs calls should fail with EIO:
+syncfs: Input/output error
+done
+This syncfs call should succeed:
+done
diff --git a/tests/generic/group b/tests/generic/group
index 752ee35ed3f7..e35491f69e97 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -497,3 +497,4 @@
 493 auto quick swap
 494 auto quick swap
 495 auto quick swap
+999 auto quick
-- 
2.17.0
