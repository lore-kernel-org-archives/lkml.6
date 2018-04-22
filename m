Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405303-2-15039579102740585622
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
    1524405303; b=K16MOvV4Io+yj1aOoKP0jkGseOEpU9HcY3j3Ojb80UdE+R09I7
    sR9VM0sivT2WswlPy2TXIbaDA3xsxS6UcItMpsVEDqoCqACojEiF8rEdaju402Ch
    L2b2q4v00TJmUlp31SlPkG4/8ZfE2xfGUiVHNFnm5sYQSukFXZWuY0E4VU0u7QYG
    +qBx4i7nR+3AzVlveIeVcUIopUYK2xzhhmW1N9JS8ofdXkzxq5cWT7AKHtuM6Hh6
    QEG7y2PKJJikRCJSNjTdugT/IXyiYpmkimh1aWTXOaW/Ayb6spWY1AZVlT5sm74m
    tcbPuSJKdM9GistlPw8FcEzhneEbaRxEGkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405303; bh=ARX8y2tGvar0WtTMFt71ufjkoVpWB0
    qK9wdtJLchgQY=; b=d0EF4GbRzp0tShiKUiWDbwTdzZSNMVUcpuRc02JF2/NMvl
    xwmJhlnwdX25tq8KOSWEhYwnHqzeugfbP7HxVQP72OGCRTuSZ2YnbljPmlu7BBT4
    2LTDHO6CsNLh6bWRi4bIqqAlqjeQrdvta/8H9ETnxjK8/UeIKBjCHvt8/jf22BhJ
    y6pijyn0UzWb4+6uBwEQ003jDUc/4gwUS9X+0gODd1OVcCD/2S3AB1n6ypoBPmNu
    +MWQ+PWAkmBryHNXqza6G6a3c8NDjibZTv3eaylghUFE+X7E7QqoDAozltO+YQcH
    qh+5EPkfa1tT+O4mcW7FhHAIoEMZKqCq6E5VbzQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCgBLk4Ema2537VZpNbCMVyUDR2OTwBmWlROkSON8t7u8szNRec7cjuupEFVcKxWddVkjrvtazAwEG3acoRj3+aq8Qwp2Ic/vUXpLqAiQ75AqcZ/V+G0
    vVtEbb0aMIqlcsFZetQ9O1JyoRc0jf9l3zyu9Qzh19kmdWjwa2AXoVQGQmtKV/7KIC3QtcQ8yqf0yvmr2sXIblazBEusKw3Z23Xdb1j6iZlYpp9ImZ1OCxQb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=cA917tEuKh2QAOatFzUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeDVNy5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:54:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeDVNys (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:54:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.16 004/196] ubifs: Check ubifs_wbuf_sync() return code
Date: Sun, 22 Apr 2018 15:50:24 +0200
Message-Id: <20180422135104.464853640@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
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

From: Richard Weinberger <richard@nod.at>

commit aac17948a7ce01fb60b9ee6cf902967a47b3ce26 upstream.

If ubifs_wbuf_sync() fails we must not write a master node with the
dirty marker cleared.
Otherwise it is possible that in case of an IO error while syncing we
mark the filesystem as clean and UBIFS refuses to recover upon next
mount.

Cc: <stable@vger.kernel.org>
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/super.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1737,8 +1737,11 @@ static void ubifs_remount_ro(struct ubif
 
 	dbg_save_space_info(c);
 
-	for (i = 0; i < c->jhead_cnt; i++)
-		ubifs_wbuf_sync(&c->jheads[i].wbuf);
+	for (i = 0; i < c->jhead_cnt; i++) {
+		err = ubifs_wbuf_sync(&c->jheads[i].wbuf);
+		if (err)
+			ubifs_ro_mode(c, err);
+	}
 
 	c->mst_node->flags &= ~cpu_to_le32(UBIFS_MST_DIRTY);
 	c->mst_node->flags |= cpu_to_le32(UBIFS_MST_NO_ORPHS);
@@ -1804,8 +1807,11 @@ static void ubifs_put_super(struct super
 			int err;
 
 			/* Synchronize write-buffers */
-			for (i = 0; i < c->jhead_cnt; i++)
-				ubifs_wbuf_sync(&c->jheads[i].wbuf);
+			for (i = 0; i < c->jhead_cnt; i++) {
+				err = ubifs_wbuf_sync(&c->jheads[i].wbuf);
+				if (err)
+					ubifs_ro_mode(c, err);
+			}
 
 			/*
 			 * We are being cleanly unmounted which means the
