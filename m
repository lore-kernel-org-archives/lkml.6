Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479313-2-16469775779207972393
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
    1523479312; b=Ecsq7/KTDaA3E8fdXhttgWZCQsVM0SMnqblaI/CmnubJ2uMhsH
    koR1B7MILsHzreW9mRBRAdEYu2EZIoPy8nJJZK2Eakx/aB2BOaZRDqH70ceghcIg
    OCLtpzuUqqb5D6+c3QgBU4DosL8jopTiMrUPlcuZ4jcOfceQjp1SarF5PMz43ubr
    72iWcNdJM1AdXqYqyEX+ATtWq7oi4qf6qhZ4ugbgILHt1rzYYKLpo0DZrRtC4MPg
    ozlebcvfnmzPCngAFCAO/RbsIzOKpXRWDwXrxyr2uVvxtoM7mBcc9FV7BemawIOC
    IN4ovZjuZFQ/ABRktAAhYZ9+8Dn3y25a1DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479312; bh=Dw9luDRyTl3t3jPwx/n3wd+p/WHiy/
    5XkgDxhqNKzxw=; b=lVsk/DpxaLUM3fphyUQShRNPi+5BnKmqF4hKkzEkSJc01c
    Sm7kAwBCOuAyN+XcsMrgfn8+tr6hOAyhdgF0/Z1I7EgVhAVI3qTmdOg3/y1AwYiJ
    3FOcJAYQZ6YWa8t2vDkqJg5tLuRPiprC2RmvY8TLbahYKZnUcHkKO/Lkyb6yL9tc
    nVZoswl78tBYtHwLcA3w1WCPXx672+D5piCQtDvzkgYJCPBTdIODDB4Or868fynB
    y3EqvbU8Y71RTztyIypM1Yy8zyVTKJ4YjJhL6UekulwjDAQV0E992s3YaO8pFQjG
    ells6l8fIoae67R4VWuQiyA/hHQsl5J9eRGyqf2Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfMEtKqjFQUUQASotlHxVvnEAQgwRkDG07zhOskWR7WkbRXbRkdBBquDFAP8j3w95QTCep6RLwxnKxtNqSmTt0wSb/4HCy50FwWqgs6uAtCslQchc2ydn
    1s1U7dhaYiH/RX4xNJHHyX36ZV18fa06PcwfJZfWpLHtjx4GXW2oA+na3iAZbcZMDHAsuLoJ6G7rrkpckpaFspMPW6DWr/1r6u/mERyqHN05cDek3qrbIRma
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=abfIYhiCYBo1eW3fxfsA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756136AbeDKUlb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:41:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755978AbeDKSrp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 096/190] ovl: filter trusted xattr for non-admin
Date: Wed, 11 Apr 2018 20:35:42 +0200
Message-Id: <20180411183556.186437172@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>


[ Upstream commit a082c6f680da298cf075886ff032f32ccb7c5e1a ]

Filesystems filter out extended attributes in the "trusted." domain for
unprivlieged callers.

Overlay calls underlying filesystem's method with elevated privs, so need
to do the filtering in overlayfs too.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/inode.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -272,6 +272,16 @@ ssize_t ovl_getxattr(struct dentry *dent
 	return vfs_getxattr(realpath.dentry, name, value, size);
 }
 
+static bool ovl_can_list(const char *s)
+{
+	/* List all non-trusted xatts */
+	if (strncmp(s, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) != 0)
+		return true;
+
+	/* Never list trusted.overlay, list other trusted for superuser only */
+	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+}
+
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	struct path realpath;
@@ -296,7 +306,7 @@ ssize_t ovl_listxattr(struct dentry *den
 			return -EIO;
 
 		len -= slen;
-		if (ovl_is_private_xattr(s)) {
+		if (!ovl_can_list(s)) {
 			res -= slen;
 			memmove(s, s + slen, len);
 		} else {
