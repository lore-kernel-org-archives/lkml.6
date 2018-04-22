Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406390-2-7965018667315127235
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
    1524406389; b=Vx3eUpIeo/0Mf2klGhCVuKoPyNrPaRpiItjVDQDWyA6w+DAAPm
    7FRTM1+SvzVJLGLBVXFLgnt32eRrc9qgEC32bJwF63+ViK9SkqawnM+hoPsGnR0q
    sLaf6LWx5AhOrUh9aZdCHz1FeoJG/TThP/tzTUfmP4T+UYlARQG/LbpMMQm/4haU
    SaMpqw55WW0WN2hyjpLzsUQNLDbx86BCb+pVCS9De9IdQAAQGNAZTRWUw1fZ1+qi
    NDMm0yQp1HZI+5VvEH1TiEt4xnJYiWgcsR/cksIFdeXG9R2F5rCMIZczhbUiNi5G
    m3mf8RRKG9gPjAuDw+cRxxMudbS2E3U2znIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406389; bh=0mCU1bFzN+w7zSpCzb9AWFngf/KlmM
    vfQNVBaYYcxjs=; b=VhvTkHdPkLalOuf4XwuT8jOxsNQn8Z/RKoO7G+a/4PKhqr
    bth+55PBHXT7cw6QtY9pbqAjNkzU6rW++d7Q8Mz+LiL9C6NojebeNO2m+EzsNDoH
    FpNkeE+k1/GekByQszF+raGbc2Kl4gWpzDCEj3ug7gS+J2s3NndZrV+LasXMTSVh
    uosVTHLEIow64s+7tcrQwOVj2Qx7/JuBeJ/al8s5ee5/3SE809B2xQ6+gd5gf49o
    X5rAHumaqdW/FV4GOACbfEALBi1fi5+u5zV0dtNWu7OtHB2KYzhK9/B+oEd7v8PO
    ntBT+w+D6ykUdgGDlBB49g6qCpGVozf2ml+ANlig==
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
X-CM-Envelope: MS4wfFYCRau1bURJfrcPfPDmKcu2EID8T7L18Z4NT1HmoB73sAkQ3FY836MxZRUIu/KrVUwirONB0YGT/dFAwHOcsqAIei9hnAjUmxQVWblxdbix8sr+JySH
    q5mgvaSvrxAeyA7vjp8KYdVf7CiGKMF6Pg9vMrH/cp953IKB6smCYlYBax6cY8ft5/AAPpB7j8LmG2pHrXVGhx3N8IwEsO1gPLAYspQtJ+Ps1mtyNc4ecMqk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=XVULgrViAT1zYlJddPwA:9
    a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756785AbeDVONI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:13:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756740AbeDVONE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:13:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 24/95] HID: i2c-hid: fix size check and type usage
Date: Sun, 22 Apr 2018 15:52:53 +0200
Message-Id: <20180422135211.425609597@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit ac75a041048b8c1f7418e27621ca5efda8571043 upstream.

When convert char array with signed int, if the inbuf[x] is negative then
upper bits will be set to 1. Fix this by using u8 instead of char.

ret_size has to be at least 3, hid_input_report use it after minus 2 bytes.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/i2c-hid/i2c-hid.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -142,10 +142,10 @@ struct i2c_hid {
 						   * register of the HID
 						   * descriptor. */
 	unsigned int		bufsize;	/* i2c buffer size */
-	char			*inbuf;		/* Input buffer */
-	char			*rawbuf;	/* Raw Input buffer */
-	char			*cmdbuf;	/* Command buffer */
-	char			*argsbuf;	/* Command arguments buffer */
+	u8			*inbuf;		/* Input buffer */
+	u8			*rawbuf;	/* Raw Input buffer */
+	u8			*cmdbuf;	/* Command buffer */
+	u8			*argsbuf;	/* Command arguments buffer */
 
 	unsigned long		flags;		/* device flags */
 	unsigned long		quirks;		/* Various quirks */
@@ -451,7 +451,8 @@ out_unlock:
 
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
-	int ret, ret_size;
+	int ret;
+	u32 ret_size;
 	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
 
 	if (size > ihid->bufsize)
@@ -476,7 +477,7 @@ static void i2c_hid_get_input(struct i2c
 		return;
 	}
 
-	if (ret_size > size) {
+	if ((ret_size > size) || (ret_size <= 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
