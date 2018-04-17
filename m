Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2126129-1523980948-2-13204604355444111071
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
    1523980947; b=r2BFOjUSfXzc1cHa+rPqQMKuoiDcpFuhKGTznAbfqvsUsLFjrL
    ljmDEVMwHzwU6N6OH4rF0blXA9A777ncjElcEvyxR2zubkK3KgEHIqhVo2CK51dX
    dDLG4PvJjMW7KFRx0AyCBR3ODeszqSqg3XUhjNB0tdt+mAtgzbBSEgHP63rkDRww
    Sb7c05dNJVMX3eRmvljFhMXfnCE2AuLIMmP9W8x4fVAvcJacVMJxJ4OrZ2zGp3MG
    bNueTx92HBG1UU7Odlv/MQ5VXrMfvQetX2fWbsxsyy/PLRNXjsfWvqaFzgLcWsmv
    wzhpL48fXM76IaxTk9DQMDM4LUKWKuWBr9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523980947; bh=hMfw/WAJUozV7eVaZ8C6dWzMYqZfga
    qACF/OQXW7E+A=; b=LYbnlATytkCTaYlK5xykmdXHKGeo2xULxgGY19AqOQMcdT
    lS0F5KWYfWfsOpd32Qxv/KAUTNE/nicc5K3mb8uNDfkgK9+g9q6dNYwS8jbpAaLH
    WPJL8Xs/A3gxc+P9xyeMUStlzZssdPEhxf5lA7hzyu4wJwJTmfF/Ac9CFJWb85dV
    hW/zwChwkPqZk2OQkaCI9SBkl6EHwT4GuQe5Q6NLhdVnsO8b2MzZzPCt2BX2z2cY
    bOl9X+34i0DmrThVszMGZFnCRJSxeBaOsB5PYkHx3XFLhvFxdUnw4vhgHSWrufFa
    ixTNMKf/9WwvT8BXOm5PFGKiGnU0HjknUuDzdbXQ==
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
X-CM-Envelope: MS4wfHqwhSe+I7qPWDkzCMF9rIUnVs38Ijy7UgLuwFB9mS8TS4TNoaR+H7TZOyaQp49jIHMdr+vfsLFEEj8B3/id//mWEZ2KWncG3wBKdXAEkpjFK29KPoXA
    PTLGAdPSBvl4Ezsk3+u8SVbYf6qasog9iTX4cFJLb8n76mueH//hzzPkgA3whsiaUnV1f44WUY9fleUO+L8zqOJEY/g22dTOomSEoc3x4Z+PbOqBftrfr/OX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=_8xu5rv4WOfE9bXWKCUA:9
    a=3_SlipdarYeamWb8:21 a=M7MLBYOlE1M0hlT6:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbeDQQCZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:02:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754022AbeDQQCY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:02:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 59/68] s390/qdio: dont retry EQBS after CCQ 96
Date: Tue, 17 Apr 2018 17:58:12 +0200
Message-Id: <20180417155751.735062039@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

commit dae55b6fef58530c13df074bcc182c096609339e upstream.

Immediate retry of EQBS after CCQ 96 means that we potentially misreport
the state of buffers inspected during the first EQBS call.

This occurs when
1. the first EQBS finds all inspected buffers still in the initial state
   set by the driver (ie INPUT EMPTY or OUTPUT PRIMED),
2. the EQBS terminates early with CCQ 96, and
3. by the time that the second EQBS comes around, the state of those
   previously inspected buffers has changed.

If the state reported by the second EQBS is 'driver-owned', all we know
is that the previous buffers are driver-owned now as well. But we can't
tell if they all have the same state. So for instance
- the second EQBS reports OUTPUT EMPTY, but any number of the previous
  buffers could be OUTPUT ERROR by now,
- the second EQBS reports OUTPUT ERROR, but any number of the previous
  buffers could be OUTPUT EMPTY by now.

Effectively, this can result in both over- and underreporting of errors.

If the state reported by the second EQBS is 'HW-owned', that doesn't
guarantee that the previous buffers have not been switched to
driver-owned in the mean time. So for instance
- the second EQBS reports INPUT EMPTY, but any number of the previous
  buffers could be INPUT PRIMED (or INPUT ERROR) by now.

This would result in failure to process pending work on the queue. If
it's the final check before yielding initiative, this can cause
a (temporary) queue stall due to IRQ avoidance.

Fixes: 25f269f17316 ("[S390] qdio: EQBS retry after CCQ 96")
Cc: <stable@vger.kernel.org> #v3.2+
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_main.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -128,7 +128,7 @@ static inline int qdio_check_ccq(struct
 static int qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
 			int start, int count, int auto_ack)
 {
-	int rc, tmp_count = count, tmp_start = start, nr = q->nr, retried = 0;
+	int rc, tmp_count = count, tmp_start = start, nr = q->nr;
 	unsigned int ccq = 0;
 
 	qperf_inc(q, eqbs);
@@ -151,14 +151,7 @@ again:
 		qperf_inc(q, eqbs_partial);
 		DBF_DEV_EVENT(DBF_WARN, q->irq_ptr, "EQBS part:%02x",
 			tmp_count);
-		/*
-		 * Retry once, if that fails bail out and process the
-		 * extracted buffers before trying again.
-		 */
-		if (!retried++)
-			goto again;
-		else
-			return count - tmp_count;
+		return count - tmp_count;
 	}
 
 	DBF_ERROR("%4x EQBS ERROR", SCH_NO(q));
