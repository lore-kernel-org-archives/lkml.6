Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1072153-1524212703-2-11478950935623656153
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524212702; b=uSrbFQyU/6NF4ZB5IjZganNYvLjt5iQzCiSIdw5C8oIkZJ9sz8
    j7Q+nuWyu4xcL79yZjydceWAK3Bd0f4T74wkfMoofnGAc3U2VPvUPnOGVbJ8NAZt
    XtMbqH+wlzSnaV1HD58Icquy2oBHsFbG/bSPVOiSWDf/nb5lV+N1+c34o4pxb2l4
    fMbXntHn5DwfYyy90WJp01HlpSCfQVtrQqacqQh+WQRTFG4LAaQ9nqyflpCKxyMO
    Drgjgq9cbU2gJKdNs41Us8VyNWk5vH15YZp4WfTQ5bYflr3Wgyn4TiNCoJnr557M
    NK6GI1J1NrFirrPsPKIMg3lQClVRTHwxgHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524212702; bh=
    oxtF4pu4yYA7jZg1fhEeNTiMoOeIdwoNy17u+BVCYJw=; b=D6ELYPq3SpVgBAYB
    sqgeU7mDdUkYNu8e7IvzGbQKrcFoqHkScfimBIZVQMjhOuzfUParsFP9+YOHmmOF
    QAruajzjDRmu5vw6i9J9wcFvAuqzu1C2bmkEk4avH5n8mynNAYR/qaxCBlrYcJvJ
    noLc/JuCBCkJ5NBetg89K9UsE7ZQt7SZqbxpQnWGg76Or2ulTgg+Ys/jNT6OtklF
    6dnE2leTKhLeVO6VwuQfCDnNAgpyZtRJEob67i8j4g8Fax7ZW62vqikZKJQba4lY
    KCMsr+uzoYMUhzc8Bw7ipdwj4gmbN9bn4m6Id33VLwcW9uOqrp1Zzx3zx+I7h/+G
    OkM24A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD+J+erqsWXQuYYg1Rnf6XfWzjsVB2UAoQcBIvCJqJlEQ1HcaTvXXNgSjaXWqG2gWQItJWOVC2Z/RduFJ4BBV9JwKxJm8AvtAvRfn4m2vhTrYXOH9EE+
    gRSdlkLojb5nFOVuld1lJ0mWctZNMA7BIdVCDXie3uokxNqIlesCZ6sluLy23kQXQzRoKq+AIkp+yfwoziUs3JIouTQuclFBiveu8MpEujdaOvOX6kaPdUi8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=UuiDwGNAz9aAz-hgAXsA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeDTIYg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 04:24:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754066AbeDTIYK (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 04:24:10 -0400
From: Cornelia Huck <cohuck@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>, stable@vger.kernel.org
Subject: [PULL 1/1] vfio: ccw: process ssch with interrupts disabled
Date: Fri, 20 Apr 2018 10:24:04 +0200
Message-Id: <20180420082404.13949-2-cohuck@redhat.com>
In-Reply-To: <20180420082404.13949-1-cohuck@redhat.com>
References: <20180420082404.13949-1-cohuck@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When we call ssch, an interrupt might already be pending once we
return from the START SUBCHANNEL instruction. Therefore we need to
make sure interrupts are disabled while holding the subchannel lock
until after we're done with our processing.

Cc: stable@vger.kernel.org #v4.12+
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index ff6963ad6e39..3c800642134e 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -20,12 +20,12 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	int ccode;
 	__u8 lpm;
 	unsigned long flags;
+	int ret;
 
 	sch = private->sch;
 
 	spin_lock_irqsave(sch->lock, flags);
 	private->state = VFIO_CCW_STATE_BUSY;
-	spin_unlock_irqrestore(sch->lock, flags);
 
 	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
 
@@ -38,10 +38,12 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 		 * Initialize device status information
 		 */
 		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
-		return 0;
+		ret = 0;
+		break;
 	case 1:		/* Status pending */
 	case 2:		/* Busy */
-		return -EBUSY;
+		ret = -EBUSY;
+		break;
 	case 3:		/* Device/path not operational */
 	{
 		lpm = orb->cmd.lpm;
@@ -51,13 +53,16 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 			sch->lpm = 0;
 
 		if (cio_update_schib(sch))
-			return -ENODEV;
-
-		return sch->lpm ? -EACCES : -ENODEV;
+			ret = -ENODEV;
+		else
+			ret = sch->lpm ? -EACCES : -ENODEV;
+		break;
 	}
 	default:
-		return ccode;
+		ret = ccode;
 	}
+	spin_unlock_irqrestore(sch->lock, flags);
+	return ret;
 }
 
 static void fsm_notoper(struct vfio_ccw_private *private,
-- 
2.14.3
