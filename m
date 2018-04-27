Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524838444-2-2901469030682797386
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
    1524838443; b=Le+Tca85JFGEfgkvbtdNm1FjAHoozMBfLIorOJZQEKrDDnYDbQ
    WxNFPwu9yR5DG7ENnCV1jwRDrojs6i4BwdCfYBJ4SRFO6pK1A6gqFDQJFArRkdiN
    /GzjMOacpAYsphB0f6ib3WZltjKrwaS4PLozaoH9sBJeFOJWHnsJluP2+eS0OoSJ
    GPbxFPezTb/qTXXsv+w3Ly4H3bO3SEYbyvGkTQP3lellDTZc8N15g7Sc1q8edfLZ
    yBn3CpwogNFGfKICfWYY3Rdc5181mTYov3kNS6g0QRhrlJQVfzb4fpGuTZBZqjdh
    Q+bWDTHb4I5K3DMISoldV/pLzwxrgN0BlIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838443; bh=ju5+gPW9d6+nFdr8SJZowVzTAVeF16
    B9a+z2+B8Cb7Q=; b=d2ydLlf8GkZyz4sr07JcBPjqY/kzdeUl12NPG1o+uu0XlM
    9AQN2gMwj+QKRu2C2ZACNdmHxmTIiGHarP+4g5wgSiDsulGcjb1eGz+98ysVZ7l1
    WUizyf5/v5kGxKJOPdXYolxxIejezgQZqvB8uZoEz/KIX0okYIhzzX7ITjz3h0te
    GvOkccHJWgHUDgxQ5BSbkRtnfw/mt30nfjyatD+1YFjepaq0NnPN7wzErbOPa+Q0
    WxopU39bPvJT8MOjrStvjfg2OsRFKqQmLbK3sbc29d7WaY//JPukKQlLzGXiwNfX
    6mR+zAWxGqjB7imGIPWyfrQdn7uemRAbkmY15O+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfGh8xrTbRC/ZQgAov78WCUMroSY+Z8bC2wyL3jiIPutY8z8RTTsweidt3wNxGEO5B410WDq40YmGfDj4MKALAMyhWlwhnlfUIFeiG8NdrBZwrWqvyrcl
    YBpkBOnzzn8rjchiDkFquTnxzGjX2oRCmxK6mKQYrcNVVWuNX2B62bUidne8U5tJS06GkC0dDNlV0/aU5JJHToqIadLVldnlqQW82tjdi3odftIO9EGqaMSz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=sc6aKZH_jA7jYgAn10IA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935104AbeD0ONS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935277AbeD0ONP (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:13:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E97218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 76/81] s390/cio: update chpid descriptor after resource accessibility event
Date: Fri, 27 Apr 2018 15:59:18 +0200
Message-Id: <20180427135747.661800713@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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
@@ -452,6 +452,7 @@ static void chsc_process_sei_link_incide
 
 static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 {
+	struct channel_path *chp;
 	struct chp_link link;
 	struct chp_id chpid;
 	int status;
@@ -464,10 +465,17 @@ static void chsc_process_sei_res_acc(str
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
