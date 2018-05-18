Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3125139-1526614098-2-11550841050654875541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526614098; b=HxbF1n6lXujgXjmygbny8xtc+PTVeHHQ+W154NFqc8v4WIycgA
    641IVMB1KJg8w8iGr8cVTLXFeaNtHGu/rHnD5YjrwocpaUJFS5nH6S0Nx6TwtNDf
    /F1SGjYzEMke2c4mCrmgx8OJnBpVykE6y2tHHHlIJRwUnzG2jWpU2E9CyqXkUi1I
    FjOYs0DkQVRKaVq7tLVev7oHBos1a0KClQ+zL3YczzekMU5+BGOA60TNGDAGpxxo
    coGJYwTvidBtXAH3n7cW31Nu25h0jonoYIrEzQQ1eE27ajAlNz6QXI1DEsZ1N3M5
    3iPv9TLiiCvT+OnxDha+BvbGEKjwMiDuEJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526614098;
    bh=+n3pV8gAxnGHQAy3IPMTwciNKJoFjbn5Dag9gUnHvrQ=; b=khkssszjvgOP
    vizMjpAcer61EIHYCWXEMemUchj/U9UQhyUaJKxlUxMD7v4AnhuCT8QqfOkuNwGY
    53SazW2aIwMTCi0Ky8DePHO+a4qcbmziA6e3qah2A9449cq8ssuKmpp4KEixfDtZ
    EqfjtA0LELvT8Mb8vLRCL3QJ9kcAzovxPZbf9UbGaKLlP9vQoh+ddMkRebq8zEYD
    gT1VWLIW/a7sYYHEFsoL0eVW47JhLPPHUE/VCYtI0si3Fb6UbMJ9ieRKkwzYVRtW
    VKIg+7cptFGjKXjOC0rXOY8LxDNPeMXsHGtROwx3+DfH1xj1ODF0/wIrBpQuQBeK
    KGKmj8ME+g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN7XZnKhK1jEDY/8OiAcF+rBzi2CNkSh7TpPLyY4nTBqmPz1HUbeK9ZbM4MKjjt/bd3HlZXxUbsuzO0ChkiJq4DRrD6zf0T5edHmhkxAPdXIxqdcPZrs
    CqPTejGFfSrPe3Pvpe3DghZNFfoX0EBF1TyqPf0aq6i6/MwoC7A74DstwjlEJu7OfrOSAqQ+kQcpEka4BfWlJyx5Mq8AD1uoR2RIXLApSVgzrJGfE3rGkEfV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=KjavMEGI9a4A:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=hGzw-44bAAAA:8 a=yMhMjlubAAAA:8 a=EA8IUCoez2DFUg-v2rAA:9
    a=vs_jdBD_Myc1ZMK6:21 a=X2sA1nVMHpt7KZl5:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeERD2M (ORCPT <rfc822;linux@kroah.com>);
        Thu, 17 May 2018 23:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbeERD2L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 May 2018 23:28:11 -0400
Date: Thu, 17 May 2018 23:28:11 -0400 (EDT)
From: Ronnie Sahlberg <lsahlber@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <1169121702.2774727.1526614091337.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH2r5muobq1gDbGcPE1AYeeKmdFx681=mpCyAZWfSPUa5wLjSQ@mail.gmail.com>
References: <CAH2r5muobq1gDbGcPE1AYeeKmdFx681=mpCyAZWfSPUa5wLjSQ@mail.gmail.com>
Subject: Re: [PATCHv2][SMB3] Add kernel trace support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.54.54, 10.4.195.27]
Thread-Topic: Add kernel trace support
Thread-Index: sp38wRgA4smd1If0PeDl7EtsIrlULQ==
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Very nice.

Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>

Possibly change the output from 
pid=6633 tid=0x0 sid=0x0 cmd=0 mid=0
to
cmd=0 mid=0 pid=6633 tid=0x0 sid=0x0

just to make it easier for human-searching. I think the cmd will be useful much more often than pid/tid/sid
and this would make it easier to look for as all cmd= entries will be aligned to the same column.



----- Original Message -----
From: "Steve French" <smfrench@gmail.com>
To: "CIFS" <linux-cifs@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, "samba-technical" <samba-technical@lists.samba.org>, "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Sent: Friday, 18 May, 2018 12:36:36 PM
Subject: [PATCHv2][SMB3] Add kernel trace support

Patch updated with additional tracepoint locations and some formatting
improvements. There are some obvious additional tracepoints that could
be added, but this should be a reasonable group to start with.

>From edc02d6f9dc24963d510c7ef59067428d3b082d3 Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Thu, 17 May 2018 21:16:55 -0500
Subject: [PATCH] smb3: Add ftrace tracepoints for improved SMB3 debugging

Although dmesg logs and wireshark network traces can be
helpful, being able to dynamically enable/disable tracepoints
(in this case via the kernel ftrace mechanism) can also be
helpful in more quickly debugging problems, and more
selectively tracing the events related to the bug report.

This patch adds 12 ftrace tracepoints to cifs.ko for SMB3 events
in some obvious locations.  Subsequent patches will add more
as needed.

Example use:
   trace-cmd record -e cifs
   <run test case>
   trace-cmd show

Various trace events can be filtered. See:
       trace-cmd list | grep cifs
for the current list of cifs tracepoints.

Sample output (from mount and writing to a file):

root@smf:/sys/kernel/debug/tracing/events/cifs# trace-cmd show
<snip>
      mount.cifs-6633  [006] ....  7246.936461: smb3_cmd_done:
pid=6633 tid=0x0 sid=0x0 cmd=0 mid=0
      mount.cifs-6633  [006] ....  7246.936701: smb3_cmd_err:
pid=6633 tid=0x0 sid=0x3d9cf8e5 cmd=1 mid=1 status=0xc0000016 rc=-5
      mount.cifs-6633  [006] ....  7246.943055: smb3_cmd_done:
pid=6633 tid=0x0 sid=0x3d9cf8e5 cmd=1 mid=2
      mount.cifs-6633  [006] ....  7246.943298: smb3_cmd_done:
pid=6633 tid=0xf9447636 sid=0x3d9cf8e5 cmd=3 mid=3
      mount.cifs-6633  [006] ....  7246.943446: smb3_cmd_done:
pid=6633 tid=0xf9447636 sid=0x3d9cf8e5 cmd=11 mid=4
      mount.cifs-6633  [006] ....  7246.943659: smb3_cmd_done:
pid=6633 tid=0xe1b781a sid=0x3d9cf8e5 cmd=3 mid=5
      mount.cifs-6633  [006] ....  7246.943766: smb3_cmd_done:
pid=6633 tid=0xe1b781a sid=0x3d9cf8e5 cmd=11 mid=6
      mount.cifs-6633  [006] ....  7246.943937: smb3_cmd_done:
pid=6633 tid=0xe1b781a sid=0x3d9cf8e5 cmd=5 mid=7
      mount.cifs-6633  [006] ....  7246.944020: smb3_cmd_done:
pid=6633 tid=0xe1b781a sid=0x3d9cf8e5 cmd=16 mid=8
      mount.cifs-6633  [006] ....  7246.944091: smb3_cmd_done:
pid=6633 tid=0xe1b781a sid=0x3d9cf8e5 cmd=16 mid=9
      mount.cifs-6633  [006] ....  7246.944163: smb3_cmd_done:
pid=6633 tid=0xe1b781a sid=0x3d9cf8e5 cmd=16 mid=10
      mount.cifs-6633  [006] ....  7246.944218: smb3_cmd_err:
pid=6633 tid=0xf9447636 sid=0x3d9cf8e5 cmd=11 mid=11 status=0xc0000225
rc=-2
      mount.cifs-6633  [006] ....  7246.944219: smb3_fsctl_err: xid=0
fid=0xffffffffffffffff tid=0xf9447636 sid=0x3d9cf8e5 class=0
type=393620 rc=-2
      mount.cifs-6633  [007] ....  7246.944353: smb3_cmd_done:
pid=6633 tid=0xe1b781a sid=0x3d9cf8e5 cmd=16 mid=12
            bash-2071  [000] ....  7256.903844: smb3_cmd_done:
pid=2071 tid=0xe1b781a sid=0x3d9cf8e5 cmd=5 mid=13
            bash-2071  [000] ....  7256.904172: smb3_cmd_done:
pid=2071 tid=0xe1b781a sid=0x3d9cf8e5 cmd=16 mid=14
            bash-2071  [000] ....  7256.904471: smb3_cmd_done:
pid=2071 tid=0xe1b781a sid=0x3d9cf8e5 cmd=17 mid=15
            bash-2071  [000] ....  7256.904950: smb3_cmd_done:
pid=2071 tid=0xe1b781a sid=0x3d9cf8e5 cmd=5 mid=16
            bash-2071  [000] ....  7256.905305: smb3_cmd_done:
pid=2071 tid=0xe1b781a sid=0x3d9cf8e5 cmd=17 mid=17
            bash-2071  [000] ....  7256.905688: smb3_cmd_done:
pid=2071 tid=0xe1b781a sid=0x3d9cf8e5 cmd=6 mid=18
            bash-2071  [000] ....  7256.905809: smb3_write_done: xid=0
fid=0xd628f511 tid=0xe1b781a sid=0x3d9cf8e5 offset=0x0 len=0x1b

Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/Makefile       |   7 +-
 fs/cifs/smb2maperror.c |  10 +-
 fs/cifs/smb2pdu.c      |  56 +++++++-
 fs/cifs/trace.c        |  18 +++
 fs/cifs/trace.h        | 298 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 379 insertions(+), 10 deletions(-)
 create mode 100644 fs/cifs/trace.c
 create mode 100644 fs/cifs/trace.h

diff --git a/fs/cifs/Makefile b/fs/cifs/Makefile
index 7e4a1e2f0696..85817991ee68 100644
--- a/fs/cifs/Makefile
+++ b/fs/cifs/Makefile
@@ -1,11 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for Linux CIFS VFS client
+# Makefile for Linux CIFS/SMB2/SMB3 VFS client
 #
+ccflags-y += -I$(src)        # needed for trace events
 obj-$(CONFIG_CIFS) += cifs.o

-cifs-y := cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o inode.o \
-      link.o misc.o netmisc.o smbencrypt.o transport.o asn1.o \
+cifs-y := trace.o cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o \
+      inode.o link.o misc.o netmisc.o smbencrypt.o transport.o asn1.o \
       cifs_unicode.o nterr.o cifsencrypt.o \
       readdir.o ioctl.o sess.o export.o smb1ops.o winucase.o \
       smb2ops.o smb2maperror.o smb2transport.o \
diff --git a/fs/cifs/smb2maperror.c b/fs/cifs/smb2maperror.c
index 3bfc9c990724..20185be4a93d 100644
--- a/fs/cifs/smb2maperror.c
+++ b/fs/cifs/smb2maperror.c
@@ -27,6 +27,7 @@
 #include "smb2proto.h"
 #include "smb2status.h"
 #include "smb2glob.h"
+#include "trace.h"

 struct status_to_posix_error {
     __le32 smb2_status;
@@ -2455,8 +2456,12 @@ map_smb2_to_linux_error(char *buf, bool log_err)
     int rc = -EIO;
     __le32 smb2err = shdr->Status;

-    if (smb2err == 0)
+    if (smb2err == 0) {
+        trace_smb3_cmd_done(le32_to_cpu(shdr->ProcessId), shdr->TreeId,
+            shdr->SessionId, le16_to_cpu(shdr->Command),
+            le64_to_cpu(shdr->MessageId));
         return 0;
+    }

     /* mask facility */
     if (log_err && (smb2err != STATUS_MORE_PROCESSING_REQUIRED) &&
@@ -2478,5 +2483,8 @@ map_smb2_to_linux_error(char *buf, bool log_err)
     cifs_dbg(FYI, "Mapping SMB2 status code 0x%08x to POSIX err %d\n",
          __le32_to_cpu(smb2err), rc);

+    trace_smb3_cmd_err(le32_to_cpu(shdr->ProcessId), shdr->TreeId,
+            shdr->SessionId, le16_to_cpu(shdr->Command),
+            le64_to_cpu(shdr->MessageId), le32_to_cpu(smb2err), rc);
     return rc;
 }
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 35350057fc23..47d53314fc7f 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -49,6 +49,7 @@
 #include "cifspdu.h"
 #include "cifs_spnego.h"
 #include "smbdirect.h"
+#include "trace.h"

 /*
  *  The following table defines the expected "StructureSize" of SMB2 requests
@@ -2090,6 +2091,10 @@ SMB2_ioctl(const unsigned int xid, struct
cifs_tcon *tcon, u64 persistent_fid,
     cifs_small_buf_release(req);
     rsp = (struct smb2_ioctl_rsp *)rsp_iov.iov_base;

+    if (rc != 0)
+        trace_smb3_fsctl_err(xid, persistent_fid, tcon->tid,
+                ses->Suid, 0, opcode, rc);
+
     if ((rc != 0) && (rc != -EINVAL)) {
         cifs_stats_fail_inc(tcon, SMB2_IOCTL_HE);
         goto ioctl_exit;
@@ -2200,6 +2205,8 @@ SMB2_close_flags(const unsigned int xid, struct
cifs_tcon *tcon,

     if (rc != 0) {
         cifs_stats_fail_inc(tcon, SMB2_CLOSE_HE);
+        trace_smb3_close_err(xid, persistent_fid, tcon->tid, ses->Suid,
+                     rc);
         goto close_exit;
     }

@@ -2326,6 +2333,8 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,

     if (rc) {
         cifs_stats_fail_inc(tcon, SMB2_QUERY_INFO_HE);
+        trace_smb3_query_info_err(xid, persistent_fid, tcon->tid,
+                ses->Suid, info_class, (__u32)info_type, rc);
         goto qinf_exit;
     }

@@ -2556,8 +2565,11 @@ SMB2_flush(const unsigned int xid, struct
cifs_tcon *tcon, u64 persistent_fid,
     rc = smb2_send_recv(xid, ses, iov, 1, &resp_buftype, flags, &rsp_iov);
     cifs_small_buf_release(req);

-    if (rc != 0)
+    if (rc != 0) {
         cifs_stats_fail_inc(tcon, SMB2_FLUSH_HE);
+        trace_smb3_flush_err(xid, persistent_fid, tcon->tid, ses->Suid,
+                     rc);
+    }

     free_rsp_buf(resp_buftype, rsp_iov.iov_base);
     return rc;
@@ -2799,7 +2811,13 @@ smb2_async_readv(struct cifs_readdata *rdata)
     if (rc) {
         kref_put(&rdata->refcount, cifs_readdata_release);
         cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
-    }
+        trace_smb3_read_err(rc, 0 /* xid */, io_parms.persistent_fid,
+                   io_parms.tcon->tid, io_parms.tcon->ses->Suid,
+                   io_parms.offset, io_parms.length);
+    } else
+        trace_smb3_read_done(0 /* xid */, io_parms.persistent_fid,
+                   io_parms.tcon->tid, io_parms.tcon->ses->Suid,
+                   io_parms.offset, io_parms.length);

     cifs_small_buf_release(buf);
     return rc;
@@ -2840,9 +2858,15 @@ SMB2_read(const unsigned int xid, struct
cifs_io_parms *io_parms,
             cifs_stats_fail_inc(io_parms->tcon, SMB2_READ_HE);
             cifs_dbg(VFS, "Send error in read = %d\n", rc);
         }
+        trace_smb3_read_err(rc, xid, req->PersistentFileId,
+                    io_parms->tcon->tid, ses->Suid,
+                    io_parms->offset, io_parms->length);
         free_rsp_buf(resp_buftype, rsp_iov.iov_base);
         return rc == -ENODATA ? 0 : rc;
-    }
+    } else
+        trace_smb3_read_done(xid, req->PersistentFileId,
+                    io_parms->tcon->tid, ses->Suid,
+                    io_parms->offset, io_parms->length);

     *nbytes = le32_to_cpu(rsp->DataLength);
     if ((*nbytes > CIFS_MAX_MSGSIZE) ||
@@ -3058,9 +3082,15 @@ smb2_async_writev(struct cifs_writedata *wdata,
                  wdata, flags);

     if (rc) {
+        trace_smb3_write_err(0 /* no xid */, req->PersistentFileId,
+                     tcon->tid, tcon->ses->Suid, wdata->offset,
+                     wdata->bytes, rc);
         kref_put(&wdata->refcount, release);
         cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
-    }
+    } else
+        trace_smb3_write_done(0 /* no xid */, req->PersistentFileId,
+                     tcon->tid, tcon->ses->Suid, wdata->offset,
+                     wdata->bytes);

 async_writev_out:
     cifs_small_buf_release(req);
@@ -3124,10 +3154,19 @@ SMB2_write(const unsigned int xid, struct
cifs_io_parms *io_parms,
     rsp = (struct smb2_write_rsp *)rsp_iov.iov_base;

     if (rc) {
+        trace_smb3_write_err(xid, req->PersistentFileId,
+                     io_parms->tcon->tid,
+                     io_parms->tcon->ses->Suid,
+                     io_parms->offset, io_parms->length, rc);
         cifs_stats_fail_inc(io_parms->tcon, SMB2_WRITE_HE);
         cifs_dbg(VFS, "Send error in write = %d\n", rc);
-    } else
+    } else {
         *nbytes = le32_to_cpu(rsp->DataLength);
+        trace_smb3_write_done(xid, req->PersistentFileId,
+                     io_parms->tcon->tid,
+                     io_parms->tcon->ses->Suid,
+                     io_parms->offset, *nbytes);
+    }

     free_rsp_buf(resp_buftype, rsp);
     return rc;
@@ -3374,8 +3413,11 @@ send_set_info(const unsigned int xid, struct
cifs_tcon *tcon,
     cifs_small_buf_release(req);
     rsp = (struct smb2_set_info_rsp *)rsp_iov.iov_base;

-    if (rc != 0)
+    if (rc != 0) {
         cifs_stats_fail_inc(tcon, SMB2_SET_INFO_HE);
+        trace_smb3_set_info_err(xid, persistent_fid, tcon->tid,
+                ses->Suid, info_class, (__u32)info_type, rc);
+    }

     free_rsp_buf(resp_buftype, rsp);
     kfree(iov);
@@ -3766,6 +3808,8 @@ smb2_lockv(const unsigned int xid, struct cifs_tcon *tcon,
     if (rc) {
         cifs_dbg(FYI, "Send error in smb2_lockv = %d\n", rc);
         cifs_stats_fail_inc(tcon, SMB2_LOCK_HE);
+        trace_smb3_lock_err(xid, persist_fid, tcon->tid,
+                    tcon->ses->Suid, rc);
     }

     return rc;
diff --git a/fs/cifs/trace.c b/fs/cifs/trace.c
new file mode 100644
index 000000000000..bd4a546feec1
--- /dev/null
+++ b/fs/cifs/trace.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *   Copyright (C) 2018, Microsoft Corporation.
+ *
+ *   Author(s): Steve French <stfrench@microsoft.com>
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ */
+#define CREATE_TRACE_POINTS
+#include "trace.h"
diff --git a/fs/cifs/trace.h b/fs/cifs/trace.h
new file mode 100644
index 000000000000..935a58979e1b
--- /dev/null
+++ b/fs/cifs/trace.h
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *   Copyright (C) 2018, Microsoft Corporation.
+ *
+ *   Author(s): Steve French <stfrench@microsoft.com>
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cifs
+
+#if !defined(_CIFS_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _CIFS_TRACE_H
+
+#include <linux/tracepoint.h>
+
+/* For logging errors in read or write */
+DECLARE_EVENT_CLASS(smb3_rw_err_class,
+    TP_PROTO(unsigned int xid,
+        __u64    fid,
+        __u32    tid,
+        __u64    sesid,
+        __u64    offset,
+        __u32    len,
+        int    rc),
+    TP_ARGS(xid, fid, tid, sesid, offset, len, rc),
+    TP_STRUCT__entry(
+        __field(unsigned int, xid)
+        __field(__u64, fid)
+        __field(__u32, tid)
+        __field(__u64, sesid)
+        __field(__u64, offset)
+        __field(__u32, len)
+        __field(int, rc)
+    ),
+    TP_fast_assign(
+        __entry->xid = xid;
+        __entry->fid = fid;
+        __entry->tid = tid;
+        __entry->sesid = sesid;
+        __entry->offset = offset;
+        __entry->len = len;
+        __entry->rc = rc;
+    ),
+    TP_printk("xid=%u fid=0x%llx tid=0x%x sid=0x%llx offset=0x%llx
len=0x%x rc=%d",
+        __entry->xid, __entry->fid, __entry->tid, __entry->sesid,
+        __entry->offset, __entry->len, __entry->rc)
+)
+
+#define DEFINE_SMB3_RW_ERR_EVENT(name)          \
+DEFINE_EVENT(smb3_rw_err_class, smb3_##name,    \
+    TP_PROTO(unsigned int xid,        \
+        __u64    fid,            \
+        __u32    tid,            \
+        __u64    sesid,            \
+        __u64    offset,            \
+        __u32    len,            \
+        int    rc),            \
+    TP_ARGS(xid, fid, tid, sesid, offset, len, rc))
+
+DEFINE_SMB3_RW_ERR_EVENT(write_err);
+DEFINE_SMB3_RW_ERR_EVENT(read_err);
+
+
+/* For logging successful read or write */
+DECLARE_EVENT_CLASS(smb3_rw_done_class,
+    TP_PROTO(unsigned int xid,
+        __u64    fid,
+        __u32    tid,
+        __u64    sesid,
+        __u64    offset,
+        __u32    len),
+    TP_ARGS(xid, fid, tid, sesid, offset, len),
+    TP_STRUCT__entry(
+        __field(unsigned int, xid)
+        __field(__u64, fid)
+        __field(__u32, tid)
+        __field(__u64, sesid)
+        __field(__u64, offset)
+        __field(__u32, len)
+    ),
+    TP_fast_assign(
+        __entry->xid = xid;
+        __entry->fid = fid;
+        __entry->tid = tid;
+        __entry->sesid = sesid;
+        __entry->offset = offset;
+        __entry->len = len;
+    ),
+    TP_printk("xid=%u fid=0x%llx tid=0x%x sid=0x%llx offset=0x%llx len=0x%x",
+        __entry->xid, __entry->fid, __entry->tid, __entry->sesid,
+        __entry->offset, __entry->len)
+)
+
+#define DEFINE_SMB3_RW_DONE_EVENT(name)         \
+DEFINE_EVENT(smb3_rw_done_class, smb3_##name,   \
+    TP_PROTO(unsigned int xid,        \
+        __u64    fid,            \
+        __u32    tid,            \
+        __u64    sesid,            \
+        __u64    offset,            \
+        __u32    len),            \
+    TP_ARGS(xid, fid, tid, sesid, offset, len))
+
+DEFINE_SMB3_RW_DONE_EVENT(write_done);
+DEFINE_SMB3_RW_DONE_EVENT(read_done);
+
+/*
+ * For handle based calls other than read and write, and get/set info
+ */
+DECLARE_EVENT_CLASS(smb3_fd_err_class,
+    TP_PROTO(unsigned int xid,
+        __u64    fid,
+        __u32    tid,
+        __u64    sesid,
+        int    rc),
+    TP_ARGS(xid, fid, tid, sesid, rc),
+    TP_STRUCT__entry(
+        __field(unsigned int, xid)
+        __field(__u64, fid)
+        __field(__u32, tid)
+        __field(__u64, sesid)
+        __field(int, rc)
+    ),
+    TP_fast_assign(
+        __entry->xid = xid;
+        __entry->fid = fid;
+        __entry->tid = tid;
+        __entry->sesid = sesid;
+        __entry->rc = rc;
+    ),
+    TP_printk("xid=%u fid=0x%llx tid=0x%x sid=0x%llx rc=%d",
+        __entry->xid, __entry->fid, __entry->tid, __entry->sesid,
+        __entry->rc)
+)
+
+#define DEFINE_SMB3_FD_ERR_EVENT(name)          \
+DEFINE_EVENT(smb3_fd_err_class, smb3_##name,    \
+    TP_PROTO(unsigned int xid,        \
+        __u64    fid,            \
+        __u32    tid,            \
+        __u64    sesid,            \
+        int    rc),            \
+    TP_ARGS(xid, fid, tid, sesid, rc))
+
+DEFINE_SMB3_FD_ERR_EVENT(flush_err);
+DEFINE_SMB3_FD_ERR_EVENT(lock_err);
+DEFINE_SMB3_FD_ERR_EVENT(close_err);
+
+/*
+ * For handle based query/set info calls
+ */
+DECLARE_EVENT_CLASS(smb3_inf_err_class,
+    TP_PROTO(unsigned int xid,
+        __u64    fid,
+        __u32    tid,
+        __u64    sesid,
+        __u8    infclass,
+        __u32    type,
+        int    rc),
+    TP_ARGS(xid, fid, tid, sesid, infclass, type, rc),
+    TP_STRUCT__entry(
+        __field(unsigned int, xid)
+        __field(__u64, fid)
+        __field(__u32, tid)
+        __field(__u64, sesid)
+        __field(__u8, infclass)
+        __field(__u32, type)
+        __field(int, rc)
+    ),
+    TP_fast_assign(
+        __entry->xid = xid;
+        __entry->fid = fid;
+        __entry->tid = tid;
+        __entry->sesid = sesid;
+        __entry->infclass = infclass;
+        __entry->type = type;
+        __entry->rc = rc;
+    ),
+    TP_printk("xid=%u fid=0x%llx tid=0x%x sid=0x%llx class=%u type=0x%x rc=%d",
+        __entry->xid, __entry->fid, __entry->tid, __entry->sesid,
+        __entry->infclass, __entry->type, __entry->rc)
+)
+
+#define DEFINE_SMB3_INF_ERR_EVENT(name)          \
+DEFINE_EVENT(smb3_inf_err_class, smb3_##name,    \
+    TP_PROTO(unsigned int xid,        \
+        __u64    fid,            \
+        __u32    tid,            \
+        __u64    sesid,            \
+        __u8    infclass,        \
+        __u32    type,            \
+        int    rc),            \
+    TP_ARGS(xid, fid, tid, sesid, infclass, type, rc))
+
+DEFINE_SMB3_INF_ERR_EVENT(query_info_err);
+DEFINE_SMB3_INF_ERR_EVENT(set_info_err);
+DEFINE_SMB3_INF_ERR_EVENT(fsctl_err);
+
+/*
+ * For logging SMB3 Status code and Command for responses which return errors
+ */
+DECLARE_EVENT_CLASS(smb3_cmd_err_class,
+    TP_PROTO(__u32    pid,
+        __u32    tid,
+        __u64    sesid,
+        __u16    cmd,
+        __u64    mid,
+        __u32    status,
+        int    rc),
+    TP_ARGS(pid, tid, sesid, cmd, mid, status, rc),
+    TP_STRUCT__entry(
+        __field(__u32, pid)
+        __field(__u32, tid)
+        __field(__u64, sesid)
+        __field(__u16, cmd)
+        __field(__u64, mid)
+        __field(__u32, status)
+        __field(int, rc)
+    ),
+    TP_fast_assign(
+        __entry->pid = pid;
+        __entry->tid = tid;
+        __entry->sesid = sesid;
+        __entry->cmd = cmd;
+        __entry->mid = mid;
+        __entry->status = status;
+        __entry->rc = rc;
+    ),
+    TP_printk(" pid=%u tid=0x%x sid=0x%llx cmd=%u mid=%llu status=0x%x rc=%d",
+        __entry->pid, __entry->tid, __entry->sesid,
+        __entry->cmd, __entry->mid, __entry->status, __entry->rc)
+)
+
+#define DEFINE_SMB3_CMD_ERR_EVENT(name)          \
+DEFINE_EVENT(smb3_cmd_err_class, smb3_##name,    \
+    TP_PROTO(unsigned int pid,        \
+        __u32    tid,            \
+        __u64    sesid,            \
+        __u16    cmd,            \
+        __u64    mid,            \
+        __u32    status,            \
+        int    rc),            \
+    TP_ARGS(pid, tid, sesid, cmd, mid, status, rc))
+
+DEFINE_SMB3_CMD_ERR_EVENT(cmd_err);
+
+DECLARE_EVENT_CLASS(smb3_cmd_done_class,
+    TP_PROTO(__u32    pid,
+        __u32    tid,
+        __u64    sesid,
+        __u16    cmd,
+        __u64    mid),
+    TP_ARGS(pid, tid, sesid, cmd, mid),
+    TP_STRUCT__entry(
+        __field(__u32, pid)
+        __field(__u32, tid)
+        __field(__u64, sesid)
+        __field(__u16, cmd)
+        __field(__u64, mid)
+    ),
+    TP_fast_assign(
+        __entry->pid = pid;
+        __entry->tid = tid;
+        __entry->sesid = sesid;
+        __entry->cmd = cmd;
+        __entry->mid = mid;
+    ),
+    TP_printk("pid=%u tid=0x%x sid=0x%llx cmd=%u mid=%llu",
+        __entry->pid, __entry->tid, __entry->sesid,
+        __entry->cmd, __entry->mid)
+)
+
+#define DEFINE_SMB3_CMD_DONE_EVENT(name)          \
+DEFINE_EVENT(smb3_cmd_done_class, smb3_##name,    \
+    TP_PROTO(unsigned int pid,        \
+        __u32    tid,            \
+        __u64    sesid,            \
+        __u16    cmd,            \
+        __u64    mid),            \
+    TP_ARGS(pid, tid, sesid, cmd, mid))
+
+DEFINE_SMB3_CMD_DONE_EVENT(cmd_done);
+
+#endif /* _CIFS_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 



-- 
Thanks,

Steve
