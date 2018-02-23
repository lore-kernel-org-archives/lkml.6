Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519410954-2-6799392743954831276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519410953; b=jbZTP3obFZS1HrK5+5A3Ycxfp5vbApbTXbx2I/UJzC1XKzH
    d78PKU+mIwQexjUG8xUvXsyjyqqUFKGtQk1XtU/C9f1rovJ9cfgPGPgaA1kyM2tH
    YWNYbT9WCK1VzOKiFjXDcjMNjMPxS1wdCYYecm4tzWPhyM6bdVTcB2gQNydLVJXT
    YIutzA/qn131U8T+ajn3QlYEI+5mJCunoHaSqVnsPPVg7W8OVsl8uck/Xagz5rJ3
    YC/9iH40uq8+h4MP4wpysJNaTtvXhkkIKFqQK9hap5ss5jBDLc/9Pq7oL2FKMcFu
    l1VBwmrORhksjACW83aXxoe36W5T7EsqH+/0vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410953; bh=c5LArvcBMsmXgSSZtyFqh1SC+8
    flvr8XAWOsxcEOW1A=; b=EcncEgatSj1pXaFexgiqC5R9Nbo6381BEA6M9k+EO8
    XIx8koKKnh4aSNs15F0fbjQhorN62TiDm5KMVf3+qW4CBKRefPH/j7Q87WsUkeTN
    afbl9xPWyKK0c2vZVEVE5N32m8/w3aqqfIyMyMybMZqnpYb/FTHE/VKQ/SlinTnk
    ZzEmq0dHSdaA4+yVaXcub1URL37TlB/940wC+4I+rlKfNI/uV4zrhwFvdE6H29FX
    c7mt7j10sHdsSzTPqhjHZ1/w5QPAzhYM8rEiNU4T/02U5oFKUKOj0R1VFtxb2T4K
    r72ykGw3l/2dLn9WS9hghEXwiYYF/g7TlmZ8aUeAB4Gg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeBWSfu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:35:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752919AbeBWSft (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:35:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.4 067/193] video: fbdev: via: remove possibly unused variables
Date: Fri, 23 Feb 2018 19:25:00 +0100
Message-Id: <20180223170336.473005962@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 484c7bbf2649831714da3a0fa30213977458e9b5 upstream.

When CONFIG_PROC_FS is disabled, we get warnings about unused variables
as remove_proc_entry() evaluates to an empty macro.

drivers/video/fbdev/via/viafbdev.c: In function 'viafb_remove_proc':
drivers/video/fbdev/via/viafbdev.c:1635:4: error: unused variable 'iga2_entry' [-Werror=unused-variable]
drivers/video/fbdev/via/viafbdev.c:1634:4: error: unused variable 'iga1_entry' [-Werror=unused-variable]

These are easy to avoid by using the pointer from the structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/via/viafbdev.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -1630,16 +1630,14 @@ static void viafb_init_proc(struct viafb
 }
 static void viafb_remove_proc(struct viafb_shared *shared)
 {
-	struct proc_dir_entry *viafb_entry = shared->proc_entry,
-		*iga1_entry = shared->iga1_proc_entry,
-		*iga2_entry = shared->iga2_proc_entry;
+	struct proc_dir_entry *viafb_entry = shared->proc_entry;
 
 	if (!viafb_entry)
 		return;
 
-	remove_proc_entry("output_devices", iga2_entry);
+	remove_proc_entry("output_devices", shared->iga2_proc_entry);
 	remove_proc_entry("iga2", viafb_entry);
-	remove_proc_entry("output_devices", iga1_entry);
+	remove_proc_entry("output_devices", shared->iga1_proc_entry);
 	remove_proc_entry("iga1", viafb_entry);
 	remove_proc_entry("supported_output_devices", viafb_entry);
 
