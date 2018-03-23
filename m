Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803698-2-5530102048445556378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803698; b=GkEiNB+QgHSEYtSgcdfw6onnpDP1odCea/xKik3Y6eXsyrR
    R3xKqi9yc2A8P0CSDTLyciTdA++XJTbbygm17Zg7F7qqFkuVCQN4LlwcJwagqgHJ
    0PudMHz9DGJOVIje6BT3+NjbZKie6tnGRMR+0XkaR/zj23JXJ6Qao0//6SxHVQL9
    WhlcyfuyjkcZEkegE4wGFMXADkkQeNZvG/kSq0zT8tPwFMzZWVIYwykWtmQ/pkL1
    35yoaf9qvO42shAJBvyI1YhD20toXuxfb8dk2vziqlJzygsdm/sY6wSEic1oLZ3z
    n9nfLZpvLu7qQ5qh54rn40WkuQ6jOVrIdIQODJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803698; bh=bvARXT9eVvGLpU4ZoJFTm/Q9lT
    yh7+HqbILIwUV3DvQ=; b=eHv3Dkj+5D9ggXthlwsSh02HKNBgwKXfFq337FrAwO
    DTls1+rzYvIL8+kcF+0eXzd1M9H9aRXMlh+ohaD/vKYspIMJ8gExpHYmgQulMgSR
    tMZHZ2IZA7Ypmg9nSjUSjT9F5hPkbAo3F6tDRyXRohlBUfX0/niBTOUTjZkZ0WR4
    IzVqinMRBfubm4DUNLjl/2MmT/oxfC8QbEqirvUdzeCADC9sbT7PiVAMBnZ+icky
    cOnjEHKYLmCd28FU/zno2C1CiNtXBOJ+C7LXyLJZKD8Jm7N2V/9/1B2ebyrd2Ux6
    IBzbbvAC14DwFN8dToWJEHbrm07yhEkk3qSNEuPn9j7A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeCWLOn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:14:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42432 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932645AbeCWKKN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Mera <dev@michaelmera.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 131/177] ath10k: fix out of bounds access to local buffer
Date: Fri, 23 Mar 2018 10:54:19 +0100
Message-Id: <20180323094211.007752670@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Michael Mera <dev@michaelmera.com>


[ Upstream commit a16703aaeaedec7a8bee5be5522c7c3e75478951 ]

During write to debugfs file simulate_fw_crash, fixed-size local buffer
'buf' is accessed and modified at index 'count-1', where 'count' is the
size of the write (so potentially out of bounds).
This patch fixes this problem.

Signed-off-by: Michael Mera <dev@michaelmera.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/debug.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -624,17 +624,21 @@ static ssize_t ath10k_write_simulate_fw_
 					      size_t count, loff_t *ppos)
 {
 	struct ath10k *ar = file->private_data;
-	char buf[32];
+	char buf[32] = {0};
+	ssize_t rc;
 	int ret;
 
-	simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	/* filter partial writes and invalid commands */
+	if (*ppos != 0 || count >= sizeof(buf) || count == 0)
+		return -EINVAL;
 
-	/* make sure that buf is null terminated */
-	buf[sizeof(buf) - 1] = 0;
+	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	if (rc < 0)
+		return rc;
 
 	/* drop the possible '\n' from the end */
-	if (buf[count - 1] == '\n')
-		buf[count - 1] = 0;
+	if (buf[*ppos - 1] == '\n')
+		buf[*ppos - 1] = '\0';
 
 	mutex_lock(&ar->conf_mutex);
 
