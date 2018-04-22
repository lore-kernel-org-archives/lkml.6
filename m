Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405575-2-2933955785571157414
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
    1524405573; b=B4jfybp5rUf5degAk0bsxlu5m6H0yWTlDg1m1F3w1jPeyRIa2h
    dI6s/YOT50g8Q/fuADoVy3A1iuKJ6RXfyqmuCZ1U+S8plhovKSiSJmTqwECAiRod
    x29GBMg1iaHia0dfb5ifAoA+qehbghY+3xg6K9C/xOwRif6+c7PjAU7sp5NnKTlz
    ZR4uo+PUXnSU4sl9cseUedgEt11XCxwynHQpSO5U0P+FjZZe/ODrkVyB0KCu6f4m
    q9joNhRrnSKmrt57h23B1RfiZU5kERn7jRXgD1s8qGPUoeLQ40gCKNYzaBeMcz/l
    ARq6kUas6DmVwPG9Eeopegak44zKvtYjJoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405573; bh=nfw1fMbLDOeST5dys4jC/1PCmHx2L5
    /p/4Li9GjCxIE=; b=WMehWnU5jT5NGZdvUtU8X4j9wRYn6dUsai7pbHNzLKiEw3
    QmoWuiPIYNlaU0bIgbLdQnxNE4qZSGvJC/JefacQYa8NB8cBFv/2Y24+dZzuZB2/
    i6Lv+TnbaiIFKzTDIhUYMXiBw9Z16RJnmFr4EA94nJGW+3dQe8OFBoP85ILKCgXp
    aBvS1gFW4zCnougDQ3dQtNOYn16oTe4hxbZYPEP5u4PBp5nUJYFLlBBpxJUlN8/+
    ZGU+d/I1P8f92ZV7E3vt/As6USXN+d9X2WidYMbOw2DKYVxgxn+ubsFslBFOoT0Q
    Q5VFPmTG8pTSAURiZGZN+8zofNP+KTu73ikrymtg==
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
X-CM-Envelope: MS4wfDJFjCY545zfJ82t7LyHsLa1UIKxDRFC+Yb9WMuwPxhs82JjE4SM503bRge4fG9K2gD4CrCF+PlubTT97AMcJ6HMbaQ1DRIGqlaIrlJkI3WZ4MxdHQ0d
    S1DvNZGHpMk3sH4B/ZgTXsSBTElNDIU7/5rKKU/wxjD/zABKmelVaasWV8lDi3Xl7snBfIq+YXGFlIo4eRfoA0e+0+YIv09cS0qsxyhRCpt66DmidHA/EFzo
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=CbDCq_QkAAAA:8 a=ag1SF4gXAAAA:8
    a=HpVCBnNoGEzVIHtxbwsA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
    a=AjGcO6oz07-iQ99wixmX:22 a=1qrBK16LubpBFNPVNq2M:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeDVN73 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:59:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeDVN71 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:59:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.16 113/196] IB/srp: Fix srp_abort()
Date: Sun, 22 Apr 2018 15:52:13 +0200
Message-Id: <20180422135110.111237232@linuxfoundation.org>
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

From: Bart Van Assche <bart.vanassche@wdc.com>

commit e68088e78d82920632eba112b968e49d588d02a2 upstream.

Before commit e494f6a72839 ("[SCSI] improved eh timeout handler") it
did not really matter whether or not abort handlers like srp_abort()
called .scsi_done() when returning another value than SUCCESS. Since
that commit however this matters. Hence only call .scsi_done() when
returning SUCCESS.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srp/ib_srp.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2974,9 +2974,11 @@ static int srp_abort(struct scsi_cmnd *s
 		ret = FAST_IO_FAIL;
 	else
 		ret = FAILED;
-	srp_free_req(ch, req, scmnd, 0);
-	scmnd->result = DID_ABORT << 16;
-	scmnd->scsi_done(scmnd);
+	if (ret == SUCCESS) {
+		srp_free_req(ch, req, scmnd, 0);
+		scmnd->result = DID_ABORT << 16;
+		scmnd->scsi_done(scmnd);
+	}
 
 	return ret;
 }
