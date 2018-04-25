Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584447-1524656055-2-17872229381375526522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524656054; b=HALjyB8MG2VKmNFUiWbYsqPmVDjxemQmxesxDebIICx4r5JVeH
    5O5GvHhS5KjW+iE574Usk65XhoHM0teyMqdigp6ls6PADeZgIPiHay3ZOCSStL78
    j3merkInFRlGu4E4j4++Gd9W/UsUgarxHHxoGJYYhYaTL/hkvzq7VrVStXIOaEhU
    4ackq8UNseBuCYO+jwzlEpfnS+ezKqBijT9qvB2SX2ZHdE77mi9/tPOQCP+wDTZW
    vZcNFM0MLx4859PVvvKHe4FVvoEwEiDALXSa67iOCnNOIFIRwSuhweib3nmwPObv
    a5L15Lf+LeSyukuOhku7EdyK1Rx6rusXy8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656054; bh=z0fgF3dTU/RJD8kpp58bJtSoCHc9KX
    uxkUA63EDTs4Q=; b=qvB/pHAWckhluN/EBbNZt+zipgD3iQ4a6uzjtwlOQ9J7TF
    NJ9SHEFkt+SQOwEaWr1HUhpZ9ZD8/zcZIxRIPE9AybN0vKRgUscDGV4uBOqzM8P1
    Ig6Oy0D+yoDkfU6zZMDFcge3vtAAhC7CKQfJKznH3WsxQk918ew4JD35pgY64DCG
    MhMJxj6pQLmmn7wYbiDawv6wDU6yNGS39TjOaQgqPC3vNjc+/lY6+svZIgRfsRHE
    ShrhAl1CiAX6SH+FxjDMj9UePyO8qrKcnAINp0/YtpcVxSrRNVf7dmm5aQywxrV3
    1jZr0g+jDMXNqO4+zCH3RAqoAN6sEW15zMHdjukw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfElAeKH9zGBcnU3jyHv8LNr6aAcWI7DhTV7TuJQfV84/5Ivybf+Y7Gw4LNIeLvqoVSJBtEQ9Vm03qMR85uEmrTYSUCPjt/hEkovT7LOa5xRSSVZJDZb7
    OUACE4b3L7Eo9AjPzrFBP2XTJZ5Zxyb2fv04UzezTq0YBstAaeEb9q0Utww8JlxkNlFTEdBkHKzPEbrAj/H8CN87k3vwqU78MM9RRKX/K2bZE7ApjKpLBuib
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=_Wotqz80AAAA:8 a=DfNHnWVPAAAA:8 a=yMhMjlubAAAA:8
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=9GihAUzGDAH5BQcAHsIA:9
    a=hZFYp5xOGIwIXZUw:21 a=3J4n-IJ5SUQ9EAOh:21 a=QEXdDO2ut3YA:10
    a=buJP51TR1BpY-zbLSsyS:22 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbeDYKhD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:37:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeDYKhB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Colin Ian King <colin.king@canonical.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Eryu Guan <eguan@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <smfrench@gmail.com>
Subject: [PATCH 4.14 001/183] cifs: do not allow creating sockets except with SMB1 posix exensions
Date: Wed, 25 Apr 2018 12:33:41 +0200
Message-Id: <20180425103242.651841985@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <smfrench@gmail.com>

commit 1d0cffa674cfa7d185a302c8c6850fc50b893bed upstream.

RHBZ: 1453123

Since at least the 3.10 kernel and likely a lot earlier we have
not been able to create unix domain sockets in a cifs share
when mounted using the SFU mount option (except when mounted
with the cifs unix extensions to Samba e.g.)
Trying to create a socket, for example using the af_unix command from
xfstests will cause :
BUG: unable to handle kernel NULL pointer dereference at 00000000
00000040

Since no one uses or depends on being able to create unix domains sockets
on a cifs share the easiest fix to stop this vulnerability is to simply
not allow creation of any other special files than char or block devices
when sfu is used.

Added update to Ronnie's patch to handle a tcon link leak, and
to address a buf leak noticed by Gustavo and Colin.

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
CC:  Colin Ian King <colin.king@canonical.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Reported-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/dir.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -684,6 +684,9 @@ int cifs_mknod(struct inode *inode, stru
 		goto mknod_out;
 	}
 
+	if (!S_ISCHR(mode) && !S_ISBLK(mode))
+		goto mknod_out;
+
 	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL))
 		goto mknod_out;
 
@@ -692,10 +695,8 @@ int cifs_mknod(struct inode *inode, stru
 
 	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
 	if (buf == NULL) {
-		kfree(full_path);
 		rc = -ENOMEM;
-		free_xid(xid);
-		return rc;
+		goto mknod_out;
 	}
 
 	if (backup_cred(cifs_sb))
@@ -742,7 +743,7 @@ int cifs_mknod(struct inode *inode, stru
 		pdev->minor = cpu_to_le64(MINOR(device_number));
 		rc = tcon->ses->server->ops->sync_write(xid, &fid, &io_parms,
 							&bytes_written, iov, 1);
-	} /* else if (S_ISFIFO) */
+	}
 	tcon->ses->server->ops->close(xid, tcon, &fid);
 	d_drop(direntry);
 
