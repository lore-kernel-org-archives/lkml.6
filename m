Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1387311-1523021233-2-6930511035215617892
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
    1523021232; b=Jc4IbJ8PtYNty13P0lznzUPXsAZTTmjRBiyCrTNJNjRuPXRtky
    ECfJZXUfcFRQagIdnmh6UqH8gc+YHyWy3j+SFURuN4KKJWu2fpRNATxT1Rffr8Ny
    0MxFLYy654k+VBWnhbB5aKJLxfCzERFB0kFBL7MRLxhdLQtrjrdV4XV350jYSok7
    yYRGD854rLWx8LYFMjPcC0w0VsKWFGbW00EonmYFXY1vzPVN2puZr+RBNBFNDgug
    evq2CDeFQoGS0XxJ2Y3UuXeJ5llnCpqlQ7MvRHfOozPKl1H7rm0/toZXyK8y1W5B
    OxynVa8nPw46MNPmxOQwMlP5PpRuj487gIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021232; bh=xwzg4DOMkrKvH/RQn2pN4Qq6s2yC+U
    R8n3MhJ9KQOzE=; b=izWl7Aprd77zRVU1bq3VL9Mi+IedxuBws0wwgPDIy6Jqgz
    mVL1SbdV3pKUOStjWe/o6/74dDlZgvu2FkYTzxbFxd+xZA9d3/4NPWt6Gq0mwtWv
    OmCx1Z2zs5ZPk7sA7RQrgFPrKs0Bje6AoIGsGL11F2LMrQ7EIszjBW+qFoKLOKpj
    AQyygEVww7YTgVoSMiezQnRe+AcA6HP5y/5JYpfYwo1wlwWU+LVzVBPYUPesfHs+
    pLR5d2rUNhiQ4LaCRKxe2wAFkdSf3z/L2AljMybALh07DhArXt9V1YH2PkIJQFoB
    r+WsYfbVHgV12nvTMid7AGU9//nMfAbBiYqWuzKg==
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
X-CM-Envelope: MS4wfLhqjGqyuzLo7Noe6F7yy2vuUcS/ge6raK+gO+Ftv+4dUqz7WQWVvTVkHErlW71y3OaCXcFSdMRS7l+uh0DvSA9M4YwvE7DiM1aE37xOjRgZQqQDPqDJ
    5deQC87Qp9q/dXG+2DH0o4rXgbqipxwGhS+8C3wuijCgAlwHUGLmzdzInh1gwTVSFTiPH8CqakcULdOVILIsBQ8dWBClS+mJ4xZGkcfbNW0Mv4/jGctYfte+
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=NCkSHYsgAAAA:8 a=yPCof4ZbAAAA:8 a=svO6gwnVAAAA:8
    a=ag1SF4gXAAAA:8 a=GOGJVlkrU7N_rJJ1U5oA:9 a=QEXdDO2ut3YA:10
    a=AnMw66Xr5OuzjdxB04dI:22 a=5awQwY9Y38-QVGG67zo_:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeDFN1G (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:27:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbeDFN1E (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:27:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Andrey Konovalov <andreyknvl@google.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH 3.18 21/93] scsi: sg: dont return bogus Sg_requests
Date: Fri,  6 Apr 2018 15:22:50 +0200
Message-Id: <20180406084225.893303250@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 48ae8484e9fc324b4968d33c585e54bc98e44d61 upstream.

If the list search in sg_get_rq_mark() fails to find a valid request, we
return a bogus element. This then can later lead to a GPF in
sg_remove_scat().

So don't return bogus Sg_requests in sg_get_rq_mark() but NULL in case
the list search doesn't find a valid request.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Doug Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2121,11 +2121,12 @@ sg_get_rq_mark(Sg_fd * sfp, int pack_id)
 		if ((1 == resp->done) && (!resp->sg_io_owned) &&
 		    ((-1 == pack_id) || (resp->header.pack_id == pack_id))) {
 			resp->done = 2;	/* guard against other readers */
-			break;
+			write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+			return resp;
 		}
 	}
 	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return resp;
+	return NULL;
 }
 
 /* always adds to end of list */
