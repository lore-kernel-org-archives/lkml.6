Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519416465-2-8501460963008053561
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
    t=1519416465; b=g+umdvi7KhyrJ7XzuZWIQQCeK/2g5f2E2LcDasTwIGiyj2Z
    HvjLiQGoXoscoHwoSO7Owtgfc71Q+Gw5j3WddXk27lRD+1kbspOWdHN9uLDSGeiA
    DZk23cahQfTQW02qD9XVsWVyV86dT/g6NIqG9d53m8vyT+BxoQ6/h1JD4FSegZUG
    7jMAuq1/1yuA4ck31BF9UN7Vw/Wi0cwqc0Yf8bP4Gboe7JlzpJkITWsIsWn3/JBN
    PlVkTployfdssepKxNEtCZ0iu/oiHBKKNdeOLffkpPNPXApUaMqcyb/MIdvytZb3
    /GqnGks8AZz/MU9HP6A0I0DpHk7mfp+ppOmTwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416465; bh=eLONtD1tdrM1rgD8cJyP6OuL6q
    JH7tbNKkIHtdspGIk=; b=qtNyypzliMNi615/XXRBWy7I0ijEyTiMTtDrhkSW9I
    bm47sbJNgyv0F34p4I9/70oQ7KlGN2BvKJ+7TSAzsQ7RdJ/0U1ueUIq/njqElbwU
    M6KPWMa6M23mdSZcjT27JifXBx7eBheocDGhDh6id68IDVEsTVyJMeNeHxvtppnT
    gZoeA0LbiTW1qjoBk1ghGs9u1ObPjoDqlkWd9AgTamZz+e4kVBVzrHjo22fMDJQu
    4xJenm4vYoeiPKLm4ffKAzc+zx9waS/Vv2KTtQiCT9jIhZSI61F4BmDsIYHasE/I
    Q6P08fprtVVTB8MVMIQ40cYLVYWt9VIQwtgq9YcGuIug==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbeBWSmo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:42:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeBWSmn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fa2d5f63ee5904a0115a@syzkaller.appspotmail.com,
        syzbot <syzkaller@googlegroups.com>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.9 018/145] staging: android: ion: Switch from WARN to pr_warn
Date: Fri, 23 Feb 2018 19:25:24 +0100
Message-Id: <20180223170726.990651317@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Laura Abbott <labbott@redhat.com>

commit e4e179a844f52e907e550f887d0a2171f1508af1 upstream.

Syzbot reported a warning with Ion:

WARNING: CPU: 0 PID: 3502 at drivers/staging/android/ion/ion-ioctl.c:73 ion_ioctl+0x2db/0x380 drivers/staging/android/ion/ion-ioctl.c:73
Kernel panic - not syncing: panic_on_warn set ...

This is a warning that validation of the ioctl fields failed. This was
deliberately added as a warning to make it very obvious to developers that
something needed to be fixed. In reality, this is overkill and disturbs
fuzzing. Switch to pr_warn for a message instead.

Reported-by: syzbot+fa2d5f63ee5904a0115a@syzkaller.appspotmail.com
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion-ioctl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -83,8 +83,10 @@ long ion_ioctl(struct file *filp, unsign
 		return -EFAULT;
 
 	ret = validate_ioctl_arg(cmd, &data);
-	if (WARN_ON_ONCE(ret))
+	if (ret) {
+		pr_warn_once("%s: ioctl validate failed\n", __func__);
 		return ret;
+	}
 
 	if (!(dir & _IOC_WRITE))
 		memset(&data, 0, sizeof(data));
