Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839874-2-12014448521481030326
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
    1524839874; b=PVhKh1gwOz/hVsDqNyBT6EHCpicRUjTm7I/TTKhFDOUMz3aeZJ
    s9YEcweEFi2lDYDGj2seppaS3J4yMka25KSIkstIHZJEvn0yQzczU9L+XgOd0J5d
    UchBPvDMxTiiC7Mbom3QXMUcq266DbyAhag70nt8XO+2q1ENL86jghFWtG/puh7p
    6gCmxA+F8YmGO1phh9Z80GCr3XN5ZO7sxsDEee8N8Q4md6cAtw3y1eIJqe4tky9F
    UO3BIQiYIDGik8e+04EpUR11t3WNI5SJWDXl25s31Z+LD5HFM+dC6fmpKJ4n51Ez
    QMdgdwIFl4MLE3RzOiqJbqdkfMIsonQNgSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839874; bh=sBDo3btuUOxf4wZG/Rqiu/Ang8loVQ
    wliyUoiSQi5/I=; b=NIZbOocneaVeu6B/gdGCMzD1bZG/yODMgOnzZ3MCImbh/Y
    hC0i0I9BqdZU8L6Xe2efJNGJeUn2U9e+75/r4ZAbJSaRox7vYb89XnfL1ML+ynSZ
    GwdiWk49Cjb8ZGVWV0Tn3wjhXaj9rBssMlUhE7mI+KmJdwbeeJAFh4GTa5a+enjV
    wxz7b8PfMNnT0UfQ0smKvcq5wbhtdj3fBetqyaNydYk5RrLaTmuHu/gJriX+3j+V
    4S25AqPqNWinfvAXwvNu+n6lkvmUUGqX+Ca/OF5i8njSaSXshI0mg0JKZs9M0PWj
    qf/lMxoa2WN+dKnAtjo1eS7+Jjjtyi0PRrsXIrvA==
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
X-CM-Envelope: MS4wfJ6eEy2bGnB7C2/j2SW+6d/NNgxFWW9Q2nGwqt+qju21kBhHmv3UFiT2fBiuPX7jaw1a2GuR9BtNHrrQARZfa5lX4V4JK1lK3d1JIjM++SOhtuNWd6ph
    07++ONaGw9rM3LKVjXzHzBGp/oyMqDgbPRhQTOfpVFRkjRLFxHvc8+OZrU05q0KoXz40Cxxhy6NAOsgYxEiF56eVggzMHMNZcmm5sc/BoN+p3E0DTezDD/61
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=sc6aKZH_jA7jYgAn10IA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934301AbeD0OJX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934654AbeD0OJV (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E832E21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 77/80] s390/cio: update chpid descriptor after resource accessibility event
Date: Fri, 27 Apr 2018 15:59:10 +0200
Message-Id: <20180427135736.924594134@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Sebastian Ott <sebott@linux.ibm.com>

commit af2e460ade0b0180d0f3812ca4f4f59cc9597f3e upstream.

Channel path descriptors have been seen as something stable (as
long as the chpid is configured). Recent tests have shown that the
descriptor can also be altered when the link state of a channel path
changes. Thus it is necessary to update the descriptor during
handling of resource accessibility events.

Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/chsc.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -451,6 +451,7 @@ static void chsc_process_sei_link_incide
 
 static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 {
+	struct channel_path *chp;
 	struct chp_link link;
 	struct chp_id chpid;
 	int status;
@@ -463,10 +464,17 @@ static void chsc_process_sei_res_acc(str
 	chpid.id = sei_area->rsid;
 	/* allocate a new channel path structure, if needed */
 	status = chp_get_status(chpid);
-	if (status < 0)
-		chp_new(chpid);
-	else if (!status)
+	if (!status)
 		return;
+
+	if (status < 0) {
+		chp_new(chpid);
+	} else {
+		chp = chpid_to_chp(chpid);
+		mutex_lock(&chp->lock);
+		chp_update_desc(chp);
+		mutex_unlock(&chp->lock);
+	}
 	memset(&link, 0, sizeof(struct chp_link));
 	link.chpid = chpid;
 	if ((sei_area->vf & 0xc0) != 0) {
