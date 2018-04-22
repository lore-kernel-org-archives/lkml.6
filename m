Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406660-2-9930786698749101352
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
    1524406659; b=QpqOXYgIwWuy+JLUEpLtYgc03NLQw/8ypER1XCO55REIISNpSw
    f3bevYJ1ODSLem+sqlHiXWcBYKtj6qLWLlFtleB9naMysLJNfW7c4Ef6pLawl7WK
    5RsTiCOZaa9+85wQSrjuBijLjzcIJMa+R2e7FlkpxhnJkoTJpLt7hAvEmqPIRjHf
    mCaY39nen2S9DinybAs1OMMkppAePHfz9xOHbTrWbnpfFVuZSjsZAthfha2dIcRU
    rdrqt7m2gey7eqLdTWMluCPfzrrhLyepUn1tnThDHKYKazV3QTWZsT+iuAHg9yFz
    5VZDKfnWHu2aPDUUU2FXsTkawFp4c3jIKQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406659; bh=fsoV7jrnLZk4oag43FQdZK9PBueLu0
    7b2zcOv6Pnt2M=; b=j8rUsDVD2NJ69QrI3doIWLkHA+ie5CZ5dwTPkEbp+8/GTR
    9L6lZpX8IdEm3u8cQ47d9OWRALpjlHP2EeEDpFR+UcLxMX0OzmnVNps4AeN/yb+f
    wBTLWVeQQIt3DVCuvsEvMdXJYwLvdn3kcwiAUb9d8zISNxxmLYzQiGmIzNGeftK2
    t1xBeJaWpfA8/47MU9qu8solkb03d1hlcGo/C9rpbewumcgmqopbqCUQ7WbnJabj
    cZNJeto8m7ir3kzZsqxFClFDRQVyLNiqUe0wt9tatFpg5uCn5IOe4kpLoI4ASrNJ
    qtJkXKDHHz77TH2rw58iKpUpd9AmFvzqLG/YPZAw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfNryx4hHwl4v0xanrjtL1M9/M8SwLKG2PMFR8AS2LPnE5H25eXqLU93MGFNs42pixUCU086d0n0nYNIFaE6P6JGbjJT0Rvuzn+7OkRLHL5TnwmNGyJ+y
    2cqDAK3bmt0uDAX45PV5sdtHtyoPgOzrlc8lOMK22INpkGtE//sfDT31qNGB0LIUZkvDmCJHiBfCdmFcdy5FRsWcAUbtU2zwMAJofjMgtA9FfojmOYNIsayN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=CbDCq_QkAAAA:8 a=ag1SF4gXAAAA:8
    a=HpVCBnNoGEzVIHtxbwsA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
    a=AjGcO6oz07-iQ99wixmX:22 a=1qrBK16LubpBFNPVNq2M:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeDVORi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:17:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932477AbeDVORe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:17:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 54/97] IB/srp: Fix srp_abort()
Date: Sun, 22 Apr 2018 15:53:32 +0200
Message-Id: <20180422135308.306965851@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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
@@ -2581,9 +2581,11 @@ static int srp_abort(struct scsi_cmnd *s
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
