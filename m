Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414879-2-1357246701442132309
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
    t=1519414879; b=vBNdiF8fFbBa9JB+sygt9pbv9nZWP6OFA9jKoB7GETM+hLl
    KWmQ3paHrXxL849EsKs5Yk2RlXRBCWSKN0p+9Y4bUSrzhKh7vKXW8ha+Or6DztHV
    fh7dfE1WPiyeObUGBur4tdtLbTp3wru+PNjETiIGDw3xdv0hhhi0/v+hmx34z0kN
    J/vMVdbdpRfZmD4tAnDRbxKuq4xtR7ZXblqjbb2EDp+U4agtbig1d/cbqSj5rdWX
    KTmP9qCPLCTFtJXl8Chv5FolfTeVR/zsQ1RtvByIWCH1P+tycaQ7D5Bjbnbfb6e2
    6tlZNVvfCiO59k9+ptaoB+U8zt1laJkX8UkpI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414879; bh=lH1f+YA/ZiMdkFsVtCSNltFmBr
    WKdSTQ1AbXBlNsWvY=; b=U3IlmrXqXf+5PwVvgyInZSDb/cpriEezBLqdLSPc3C
    dp/Qk2+rPHhJ6YxJen5wvtk6OJLy9aBk6OilBYuzTqlB0UgYma6OIxEeUQ25nWa7
    SIu1rbkChL9I9e7IMNRt58YYcyGztz/uNwr3cDkg6A4V4QjSbJPfBprDN+3OXXu0
    i2qBKsrx/hbGnt1GQAIcQqRzhDoYtWx2mHK2ikrKXMKhvW7EMgUYJnfK4fgw+TuQ
    /cTB12pOIowwsENM/6et+2EEKnElpgSzoj/TqBvpgYgqCRfupHknag7rjDMOrGz6
    vWTf9nARpZRlTJaMCSTFqxhKGvy+Gtrn6h4NRL/MljqQ==
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
        id S1754668AbeBWTlF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:41:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934493AbeBWStP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrey Utkin <andrey.utkin@corp.bluecherry.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 130/145] [media] tw5864: use dev_warn instead of WARN to shut up warning
Date: Fri, 23 Feb 2018 19:27:16 +0100
Message-Id: <20180223170741.602094154@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 27430d19a91615245babaa9b216d0807636903a0 upstream.

tw5864_frameinterval_get() only initializes its output when it successfully
identifies the video standard in tw5864_input. We get a warning here because
gcc can't always track the state if initialized warnings across a WARN()
macro, and thinks it might get used incorrectly in tw5864_s_parm:

media/pci/tw5864/tw5864-video.c: In function 'tw5864_s_parm':
media/pci/tw5864/tw5864-video.c:816:38: error: 'time_base.numerator' may be used uninitialized in this function [-Werror=maybe-uninitialized]
media/pci/tw5864/tw5864-video.c:819:31: error: 'time_base.denominator' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Using dev_warn() instead of WARN() avoids the __branch_check__() in
unlikely and lets the compiler see that the initialization is correct.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/pci/tw5864/tw5864-video.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/media/pci/tw5864/tw5864-video.c
+++ b/drivers/media/pci/tw5864/tw5864-video.c
@@ -708,6 +708,8 @@ static void tw5864_frame_interval_set(st
 static int tw5864_frameinterval_get(struct tw5864_input *input,
 				    struct v4l2_fract *frameinterval)
 {
+	struct tw5864_dev *dev = input->root;
+
 	switch (input->std) {
 	case STD_NTSC:
 		frameinterval->numerator = 1001;
@@ -719,8 +721,8 @@ static int tw5864_frameinterval_get(stru
 		frameinterval->denominator = 25;
 		break;
 	default:
-		WARN(1, "tw5864_frameinterval_get requested for unknown std %d\n",
-		     input->std);
+	        dev_warn(&dev->pci->dev, "tw5864_frameinterval_get requested for unknown std %d\n",
+			 input->std);
 		return -EINVAL;
 	}
 
