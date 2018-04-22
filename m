Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406536-2-16823849378704097938
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
    1524406536; b=ACHh713kmj0BZ23u4/2gAOzX609Rei+W+hklGh5tKbnw3hqCCv
    vUFsOGqaBpC/8afBnfQk+KFQ773zMCY2Sq1FNpoDIDO/DHasR9JWOFj/9C2Ydije
    eGaQAJ6MZ2LahVHerxvUcCtt/16I+5g9OaxhA+Hf+KU0RW32jPXC1ENjyRanY6V0
    u+FFCZr33Wb4utOQ3DNWkxseNYtj3yU0kwaEnsdE9+SnzMUocbCIM/AivfclQu4V
    LHqULN458jzWHWWVqaYXmeQ5AZvkIgC1LnOkewuKFsrrRfbxZloPHSsm0ztFfq6x
    mKB8ZMXuU7rvW63GwM3JVD7E4qbxTFl/hGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406536; bh=f9VJRdCIdmJKLTU7Ia8iErsVmYW3ew
    iNZNX3qo3V7lY=; b=Zg67FDFIy4vAlO/x+ySuRfYpvaatW0iKOTkYrUMBY2ieZ4
    BmQKwva/l7AzYOXb4vmxn99AWE0rqpKPDLHvAipY/ke0BoRDO/17DXi0akbk/avc
    acpGWvaEQATRlA3OTrX5aKM8kg/iFY3x+W/k8jtCk1oCkjhYIWb1AI7W8QbkjuYD
    i4C8D9aa3VdMVH1/1lnPnOGiHOzddR/iIaR7wLTddlKo41ZA/9dhS4bwm4ulAhWG
    0Y3/4QJfhOZT4sDvdaL3EyoVRvaUhfMUK+Vc3T30I07R1fbU1uFLvpyaygeIhY5B
    5wfVS2FRy10kKRzD1dCPaVNKZH6pdq0evDZHl46w==
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
X-CM-Envelope: MS4wfLEl+czFsArwxoUNP2VKdnVv6Y5+Ye3NjrDumn32CeNhMxZ6EopOdaDMZaZ4/dntfefsXuh7hMDV0TfkFHKrJHSfowrSmQ/sgs9eILObnzx9VkW/b8MT
    01urFN3vXb8wXjNQYAIaG7dllPU0Tk2wDFaz/E7jzB4RpXYxtWACEKl/tB/LN7E/dDdc5d8++rwIA/JHw21SF6WLvX8Ng+CwYcsKyXpJz5Hdz9JLOUA71TI0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=_8xu5rv4WOfE9bXWKCUA:9
    a=qv-3zZOHgxCR6gKB:21 a=M7MLBYOlE1M0hlT6:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757039AbeDVOPc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:15:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756709AbeDVOPa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 10/97] s390/qdio: dont retry EQBS after CCQ 96
Date: Sun, 22 Apr 2018 15:52:48 +0200
Message-Id: <20180422135305.218207497@linuxfoundation.org>
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
@@ -126,7 +126,7 @@ static inline int qdio_check_ccq(struct
 static int qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
 			int start, int count, int auto_ack)
 {
-	int rc, tmp_count = count, tmp_start = start, nr = q->nr, retried = 0;
+	int rc, tmp_count = count, tmp_start = start, nr = q->nr;
 	unsigned int ccq = 0;
 
 	qperf_inc(q, eqbs);
@@ -149,14 +149,7 @@ again:
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
