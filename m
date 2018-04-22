Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406346-2-7627229673699453547
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
    1524406346; b=Zk3NlYtF+rcNkci2mVXC2z2imzObgnf0mHfhjpFhMWmhh77KgL
    KrmCv9Llw3FOBqVsiUD2YfH3WJxV6sf8YFViYhXV/9RgLwO07B7yyxXESV74rixt
    G+Bb4yLBMQSoPSmqKPLjt1ol22z+IQyYd07N8NM0K9QJ5t6tGHhMenm0v+odCqwZ
    MrThbc4+sCr9zDfnsXk8L8Z8rxYyoiKk946KIdOUhE7xUuROHT9NRiYTYYIiw4wi
    g2QOp3+tN4YZNmOmdJKz0nqzKQKNPaDKf9m8tYqaRXJYI/rGjxWRFJsvfLuqxWJk
    4uHmE1oHHjPx6gNsPBRVkMRL43pLGtRzveTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406346; bh=83eHG4a+TiPB44+Imus61DTK/DEyjL
    Al0ZlpUOtZTgo=; b=ANwMHZe92F8IUzJZ+abJyu71ScmZmDT60mX9V64/zp3Lkg
    1eUDIOKaZjjQaJrB0e3xoDSmpo4kNrhZfhuoGKFdGyLZmrCDQ5tEBuNWrtQAM4cF
    e8QfOMMM7E2MrbIh5VtEa/CSmoEQ4S/JFnT8J+BtX4QoaVIPOfNp4K/YOtRbfZDI
    TJdUK3usf265HZvGCu2oJA2p7rmMBWnFV92s+looErJCWLKay0gOOTyMzzUqvhH3
    F81I30ZwT0PnlwODmDbRQzZI4epJGtZQYtECbNMrW+R9og2P5dhJxm1rYXWLPqkN
    IVkj3IyZwsVz7GhiKjU62Fg1mGnJdoYVg3px8+xg==
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
X-CM-Envelope: MS4wfKfn8JD/QrzIqzmiTO7cIf4dOCKRKR0fS+cr+EDGDLKRy22yQHg6zISW3lOTnEcz4z7gJWBjGgeDVSUU5QIN0OwNLaMXriffH6GpoK6T2XzQMY6+kPm7
    UVpWzjZxJQN0adxfz+Ulden2E4KTjmstfQ4Cp2iUq60G7A/Jm10HN2u/wjX9U+/ztELeokisJKp3ACAIGNZViNbXxJmuh6IWyhMw2S7yidDk0TKP9OZp383D
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=HsDDrbOFvXNNo7OG3RkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756655AbeDVOMT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:12:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755657AbeDVOMP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:12:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 34/95] jbd2: if the journal is aborted then dont allow update of the log tail
Date: Sun, 22 Apr 2018 15:53:03 +0200
Message-Id: <20180422135211.826438494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 85e0c4e89c1b864e763c4e3bb15d0b6d501ad5d9 upstream.

This updates the jbd2 superblock unnecessarily, and on an abort we
shouldn't truncate the log.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/journal.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -951,7 +951,7 @@ out:
 }
 
 /*
- * This is a variaon of __jbd2_update_log_tail which checks for validity of
+ * This is a variation of __jbd2_update_log_tail which checks for validity of
  * provided log tail and locks j_checkpoint_mutex. So it is safe against races
  * with other threads updating log tail.
  */
@@ -1394,6 +1394,9 @@ int jbd2_journal_update_sb_log_tail(jour
 	journal_superblock_t *sb = journal->j_superblock;
 	int ret;
 
+	if (is_journal_aborted(journal))
+		return -EIO;
+
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	jbd_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
 		  tail_block, tail_tid);
