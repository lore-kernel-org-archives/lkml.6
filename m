Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751116-1520412641-2-8940071627452621174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvsk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520412640; b=WP1w9hZ56M4Ylqw6DpB9HNqGaudBlwjdHuOwpjc5qAHhVVc
    Ec/h9gdTkeHE3Z6eSUIdTQnZPMj2xdkaf34lHzE4AfLe5t/J+JFmhPwJym1tBk04
    dMpDqlH2CCFL6Ho8zCISKAY8X32hPJ+uogJc/UHk/0Ijvxw6DgOt9WzQuN+VQ6bO
    dZolMqq6PPoHEflMm7do8O2q9y5hsJIFa1abcAnDWi349kIfKZbDVPv9Mq2ZtgU7
    XVwFDLvIHviqeU/NRQ2sRBKWSYdxRt2e1RuzhG1WjWMF4pUZVJck2hvY+Sg+QPKA
    MtpS47Ylni184AjWXy/LIJeIYQx35ThPXQ0I9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520412640; bh=0/e664GYctanklDC6SZYGqtT5r
    fJNasz8g6RUxw3ARA=; b=rzBlXj9bhqoBgCEsXQSkK3loJuHZynszCHKq/4JSph
    n1Ww2yO3Mc+Ij5zkLtG4PTmbd3Ctgm3FQwOR5aGHnVyBet0CynuWABaGAoFCF4Kn
    msEutsmVvJW/t5JGq8VNjggwsu9gY14qetd1VQJ3EuJJF9hNXDGE0oEzuDhyxbW4
    pxcIBcilkKvKa6eCPmTsGXfDRLFJKg+DAFpbLHliTvvgMFIGoahyPu5GDl8//eSi
    UJILXsTaHiV3i1xdyibA3V4wYJ9pZukPMZsCCD9atgO68V3aMeQT0rN6eGSy1Es+
    FxGkUnjzACb53n6rPRTHPPpLzjwHW68tLQ/Ic84d7YGQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeCGIuh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 03:50:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59920 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751159AbeCGIug (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 03:50:36 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 3/3] tty: st-asc: Update tty alias
Date: Wed, 7 Mar 2018 09:49:57 +0100
Message-ID: <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
must include only lowercase and '-'.

After having updated all STi boards serial aliases from "ttyASN"
to "serialN", st-asc driver need to be updated accordingly as tty
aliases id is retrieved using of_alias_get_id().

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v3: _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice
v2: _ update st-asc driver with "serial" alias prefix

 drivers/tty/serial/st-asc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..5f9f01fac6dd 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -782,7 +782,9 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
 	if (!np)
 		return NULL;
 
-	id = of_alias_get_id(np, ASC_SERIAL_NAME);
+	id = of_alias_get_id(np, "serial");
+	if (id < 0)
+		id = of_alias_get_id(np, ASC_SERIAL_NAME);
 
 	if (id < 0)
 		id = 0;
-- 
1.9.1

