Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937726-2-15581103429116116132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937725; b=HPgZIVZSxZXl1L4CRJ51c69heUz9Vke+d8PGhZ821el+Q6yZ7g
    J56V01/vJk9fBCrWB0pKYPs5Ldi1fRgZKsK2KvE73NPGi8a6qfJKCBe7BOXHaJeB
    F155QzFWmUzGFZp5O2hh+kL7ExvMbF7kUaZQWFj66RWsZrrm8hXsOUGVHKJ0obkU
    iPiStcazPUchIEDUgFkAk9ht7pC+ZRfsGrfJk/VLtxvOG4TS9hnIzkJgWcVwY82/
    +lhF+WwYmgMaRR5wibSe82QStsWEL+AmTo3nvpqHLS9w6jMN+n8BMJMVK06TrdEH
    tvXP4sji64VujvYCh7Isu7JJo3lJ2i19LTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937725; bh=ZxYD3o5wbbqOLOViq0kGmKWEf4274s
    ZSivJRnAkO8Tk=; b=jpGdISncSSvbtFHCojh2cmdo4W7SeEkt7460hRbW1VA2+1
    cTQNZfmS82cW3wt1ZOZ33wo+d8SqdQTMjhGwb+J+k0YXi8xKaZrd4RJDCofAVUQG
    UrHN6+Abgy6iKW4Dc1BaaCCL8A54i2XSJ0qpyGy2MikXF0pYrkAafrxccVtraekg
    VPW+3Tr+sGn3JdYGuaIjIvGGP0+fA9MFd6QPv5W0nMfD2ak4n0dXH5scU4DKwpN1
    Vkc5d/9bpkxBePgSKvPOyppCIRjGtQUbQgVC6QtD81KipyeY+O9+M5gWfH8vCzlB
    8bwBIEt4R9h6Cvd1p4OSFgZn3Xj3+JwmdF1YzXQA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=whu9/iUZ x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=whu9/iUZ x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHg9OnhrTVIHBHQqJoOtVUJ9TkvyB7gQOpPgREzllvxi2D7DjUvZnlsL1uZVSTxlCUPNh99/4pzYswcPCkJ7yhHfMx1eiDsECaTrPWPnWmzf22GyXZKC
    o1dKEDjLajSX+XmpKl+NwNurVk/mn62+SHXYhl4wiIJKQiVJ4mEs0QcBFR9uVF7LvaINTVEDqPZFM6Y4hJ+fklQP//eaXGYhSdW9eANYutpaVnIlLDAA4ojG
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=aaWAvk4bQpD_yfzoylIA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeEUVWC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753950AbeEUVV7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:21:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 69/95] seccomp: Use PR_SPEC_FORCE_DISABLE
Date: Mon, 21 May 2018 23:11:59 +0200
Message-Id: <20180521210500.404913927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b849a812f7eb92e96d1c8239b06581b2cfd8b275 upstream

Use PR_SPEC_FORCE_DISABLE in seccomp() because seccomp does not allow to
widen restrictions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/seccomp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -239,7 +239,7 @@ static inline void spec_mitigate(struct
 	int state = arch_prctl_spec_ctrl_get(task, which);
 
 	if (state > 0 && (state & PR_SPEC_PRCTL))
-		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_DISABLE);
+		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_FORCE_DISABLE);
 }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
