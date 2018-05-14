Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281243-2-16891270180043880202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281242; b=Wo3TsOatyVbtoXKLxUDmiL/g4Xys/PI42iztdGGxe93yiPlHxL
    en0YgAktMYrO07iRfo7XAH57faGKs/WtoW5e2+TmmpJ2Ee6hb4ixREtBsRWutlLE
    q1j219i5ZFGOMPk44EIHPwLnwfYAg8NoJu8pSUsBuo452HUWWYr9tgpJmIXkMEIX
    0XgxUqzJawfrs5wCr7wYiFRbyGQKGhqe+K/lWUzl+EYxApnqrhxGN/0kE0WgNG99
    +BrKr4W2b0xqkssLBnKzlZpF8iwioq90QSaBrb4YuMRlAl1f6UoYwVvaFbhtTe/J
    Cu0o5Txa4gxCC0owb8syajdeh8yZwyX6qIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281242; bh=x1OvVFq5v1LSSg09EIXD8HYnA9heFS
    K0rDsxI+wxoLo=; b=LSRf0zgCdB52+Xd1CR4kq5UcAyyi3lTZTUAZojEFY26neo
    NcukurOKCyEiUKcg3Ew3DtcYDes6fCRyrKOg1a3pHQV34uI1vvdSTCSxazU9bahT
    xWWY8FaJPOpPQhadsEW/CWWOUKbvyXYD4FEccVZEC200f6S+FzQnqZ+xpoNgHLyh
    p7XXsEQv6Tba2T93e1vImBZj5JsYlMOK2kzzm9VRWYexS/9+XD/zggaLQSXBosaD
    afP2S5dIW7CQNuqKl5WvxBbPTOx0ekeMaSc76tFQZAi2pjQbm/9S93vUbilbKx1G
    eXfhzLShY9ecUwtZ/JQQcLAgFThzguayoGCvcR5A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=2v9xzFJh x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=2v9xzFJh x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJd91eSYZViNE/OQqU9RlOAXon3SIi4ljsCHk4/0mDfC3uKh7GPegfk25jnr0kEYCmiSFdn471LrfUULxzhecASvovgfYT8ehJWtMceL+xmESbXUAKwk
    bHSRsW9IyNkx3Pv4lJWkNgNxgLNxd5TgOOIJWICgYdKwdVNRkqscwA5VUF00l943gVC+4yOC9S4lcURccYItwfgYsPHyXHRfsjte8j2AFCXnhTRR61FKmrD8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=i0xxPojNtY-ySMRN-uUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeENHAk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754173AbeENHAa (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.16 63/72] smb3: directory sync should not return an error
Date: Mon, 14 May 2018 08:49:20 +0200
Message-Id: <20180514064827.412015479@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <smfrench@gmail.com>

commit 6e70c267e68d77679534dcf4aaf84e66f2cf1425 upstream.

As with NFS, which ignores sync on directory handles,
fsync on a directory handle is a noop for CIFS/SMB3.
Do not return an error on it.  It breaks some database
apps otherwise.

Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsfs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1047,6 +1047,18 @@ out:
 	return rc;
 }
 
+/*
+ * Directory operations under CIFS/SMB2/SMB3 are synchronous, so fsync()
+ * is a dummy operation.
+ */
+static int cifs_dir_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	cifs_dbg(FYI, "Sync directory - name: %pD datasync: 0x%x\n",
+		 file, datasync);
+
+	return 0;
+}
+
 static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 				struct file *dst_file, loff_t destoff,
 				size_t len, unsigned int flags)
@@ -1181,6 +1193,7 @@ const struct file_operations cifs_dir_op
 	.copy_file_range = cifs_copy_file_range,
 	.clone_file_range = cifs_clone_file_range,
 	.llseek = generic_file_llseek,
+	.fsync = cifs_dir_fsync,
 };
 
 static void
