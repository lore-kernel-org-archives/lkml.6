Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022373-2-1548778518670162189
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022372; b=mN5gG55Hwc5NTNkwm8REAyiVQeQYjTWIyXjYRW4MGNZdgFFWg4
    ZPAk+skZAw9T3JdeOJhXG4Z+5r1VeuhU9pQHhs535TyeeK0+EKYHFNJXQ4rAi5rX
    ju3qAEX96O4NeCYXsbU01r7quMpXuO1lbYhhccWyGA4ZOPGr0UQA5a34q2YkhCXN
    GF+ltYtKjC25pgtgU3UBNoMORE2sBzYvk7DqHSs1/rnj4w176BbJR97dn361Zxnh
    oOiEB+CtWJbFRI/cQf0XnYPtynVsGu3jU9ISDw+2tVNB6tB0Ce3VlGLhE2eT+ong
    AzpXsG+34DInp6pK3tRBQmhkhYBQ/CFiMfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022372; bh=q6kIA7RPosejz6vP+5pFwGfBXP7fPx
    bzJVfe4kunqYk=; b=EsbIUBu4Tyr6NA4pIYzIC3e4scK1GMC2q9QjYH5VuPQGUe
    MAuc8Na7Y/+1pZCzek+MwxoEk/ruueZlJYFKkLgj0CDZauIoem+UJnS9gm/WS+Rq
    Fu2OLccpXUqraST2TUAC5UjZhjY5CA94b+/x3TqFqUz3JXyJvcDO5H9p9HpyXkJf
    imLVBkp2YipewC7C/mF1PsUBEts+uO8mPA9gbWS+tpMQKPg+1jelh/cZOccxAW01
    1y6+Wiz5Skl4Mk5JcnAZncrwpkxy60ZKY9hMB2c7X7rVix6x/8EP8QPLAN25OGFi
    jaNoCVrlqF+JEhXNBRQd91JWCqWJhz+9YVYWwwHw==
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
X-CM-Envelope: MS4wfNvlPHXNeB159nedXW4haagyENN06d4sIqI+FwgyNoZn3WrK1Mnc2ON4E9UHfsYj3Ue2y30a2XOWh1kaWK6ykaLKmghlghZveyfBKdRRpsDorPi8yAoI
    EPBj8Mx0Ax4QoBrmmlYt21eRltSv1vy54hgU7X9HVoYLgMMpnLM4Asp5mgWZNouOclQnIPjKNZQHi8X8furKxPe3YssdqFXvuRLpXsiwdCabOpsMO+JFVRRz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=XxtmG6sFAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=ow6l_K58c1a5c2hoUJEA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=CYKbh7h7szYBv2aNwBbU:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933093AbeDFNph (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:45:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933065AbeDFNpb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Spengler <spender@grsecurity.net>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.16 07/31] /dev/mem: Avoid overwriting "err" in read_mem()
Date: Fri,  6 Apr 2018 15:24:32 +0200
Message-Id: <20180406084342.044553170@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

commit b5b38200ebe54879a7264cb6f33821f61c586a7e upstream.

Successes in probe_kernel_read() would mask failures in copy_to_user()
during read_mem().

Reported-by: Brad Spengler <spender@grsecurity.net>
Fixes: 22ec1a2aea73 ("/dev/mem: Add bounce buffer for copy-out")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/mem.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -137,7 +137,7 @@ static ssize_t read_mem(struct file *fil
 
 	while (count > 0) {
 		unsigned long remaining;
-		int allowed;
+		int allowed, probe;
 
 		sz = size_inside_page(p, count);
 
@@ -160,9 +160,9 @@ static ssize_t read_mem(struct file *fil
 			if (!ptr)
 				goto failed;
 
-			err = probe_kernel_read(bounce, ptr, sz);
+			probe = probe_kernel_read(bounce, ptr, sz);
 			unxlate_dev_mem_ptr(p, ptr);
-			if (err)
+			if (probe)
 				goto failed;
 
 			remaining = copy_to_user(buf, bounce, sz);
