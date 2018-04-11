Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479576-2-15583746492481313095
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
    1523479576; b=w+fKQqcH06B7ZnMDykT7GjpHfbNqlunwfcFNdEbmHCp4owLlQk
    fNkn8TnvA/v7vPamrw8+fmJ2oQ0jNPTUEKddQ/QouIwD5zshi4E9foTkBnuDMdvB
    MpAMDlyRQAvvBb4itLq5Brs03P9/rmbLr/JyXJjDGPqP9IWgWbNMIVCczgg9uvgm
    e7BsF0ji09WsbI5CKf+khHhQmP88Kzm6Br8h6XMsHfufdGfII4RJPvm5VPQkmqrg
    UiMHA589VZg6Zg454vKf9VGd9yGpKtT0bbjkV55B3WRvtc2s1HWA8Xwb4YZNJ+pq
    um5y1oSEXo86ummjnx0ppteUvrmpv5Bo/8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479576; bh=eGITMebKrssREwwCzpwGhivbVgVYPy
    E0DIZHDMqvpJo=; b=ZZhoE87TqMLzGrWnwvXx5GARpR3vZyC+egdeW28NlyP3pm
    jtc/Y03Ztr2ipc9uk9tLfhvYO5b++XFlRLBFcMVORoJkr0nXFnQxmSZQa3xDY4/V
    OPY/+hCAAG8ggo1psx3wFM0gQwX5cA9BGKw/YrdSmS7rLlcZyv2wAwcM1M9EHahy
    Jk+sLVue6xLE0xBtdsRNZr04ZGVoTxha+tsCF6YsACuj76uQtuq8Hc+LJXmosTiE
    1AqCpvEFXWtH3WDPsDb+qrkn5UncMbF8sF+bqUyLT/cZ9B4eAB+EhV0MfikkHmbY
    MlrG0+YTQ6YMexBZgvD3FQZrPgORz6C1i2Jyhrog==
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
X-CM-Envelope: MS4wfLliEkO86vqn1K0uPdgivC9YpfNTbDVlW84tx54Oz/aAxvKoifFisflgFjsQzhuKJGQ3ElXc4uz60ww3J54s3Z3lK+HPHG/IjJiTOqowRKA1xO71aCK9
    vguXQFDO+4NyDZr+IU4/1DAmbhuFhyIC6eVdzfJlJEly2IeZdUHxMB6MekoHc+wQLFv0FglWvFG9UBLfBTm1L6sIGnKrNJZMEeCqvyyEsDNU0hFkBzm4PtQp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vrZRev11AAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=PMEpEP5_wKb1D8T3XNoA:9 a=QEXdDO2ut3YA:10 a=vE9JzVuArQVVuPm_qWxV:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755777AbeDKSqu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:46:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755740AbeDKSqr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 077/190] Input: elan_i2c - clear INT before resetting controller
Date: Wed, 11 Apr 2018 20:35:23 +0200
Message-Id: <20180411183554.982349567@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: KT Liao <kt.liao@emc.com.tw>


[ Upstream commit 4b3c7dbbfff0673e8a89575414b864d8b001d3bb ]

Some old touchpad FWs need to have interrupt cleared before issuing reset
command after updating firmware. We clear interrupt by attempting to read
full report from the controller, and discarding any data read.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elan_i2c_i2c.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -557,7 +557,14 @@ static int elan_i2c_finish_fw_update(str
 	long ret;
 	int error;
 	int len;
-	u8 buffer[ETP_I2C_INF_LENGTH];
+	u8 buffer[ETP_I2C_REPORT_LEN];
+
+	len = i2c_master_recv(client, buffer, ETP_I2C_REPORT_LEN);
+	if (len != ETP_I2C_REPORT_LEN) {
+		error = len < 0 ? len : -EIO;
+		dev_warn(dev, "failed to read I2C data after FW WDT reset: %d (%d)\n",
+			error, len);
+	}
 
 	reinit_completion(completion);
 	enable_irq(client->irq);
