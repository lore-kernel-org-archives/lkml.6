Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3819521-1520444187-2-18016874145904545927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520444186; b=vAY4SxR7ZOAqzgPAYGQ2uo4aY5j1FxJawNGvPzSsbiQMCB2
    Qxx+95l/J7mBg69TJnTbkP5+fkp092jeN81O9cShz3Jt4vPIk4sAGzwC0GDLV3T+
    Vw2NrEFEWGiP2FmdBPncsMItE0t8aDrhma+Xf3E+zQcqtibdBdv4uP7yR+UxH8+G
    3pWxNfNY7JCboh1sJBJ5y+OuIYzWw6cW+4rYqTPeGvKYMURJP4BB9d5Wa8fxop8z
    b+KDubz94QvDsEY33DL62+RjwKr2zd4ApYfYVPBoPslG6mPVP5LEl3KChLIe2J+i
    7zW5OX126EKkwuLS983t9bhtemHKaKOxWWbdbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520444186; bh=bXRNEg07cZUkPkY5jQpAuZB3Xg
    EEXvBf/sPwHfXhyV8=; b=lUIEEeKWQUuAMkTmC1z8wssnlLem7/jx0HXFMrjLF0
    oflaGrFB0A0CPJy5I6b36+XvHavIzhebMGKEFu0zglA63NPDfTFSesYpeDTEA923
    iGpkWoy7DMKAbFz85Ti67CvEqMcj8+pTNDNabrbAlNwBegjaolw5kbICnxacDXdV
    z94VBeSWJcc8ZTXCT2HjjHT0owNGL2OzZIMcB974zUwb/x4YngUKrX0NFUTVXAjo
    wt78glIlkqC1fzQJMWr8R/yuBWWBTVyEcX1CDEZfhf1VJ1sRLfPmRmUKgccPkexi
    C2QdzgkLfJOUMvAZImPVrfs47Ghhos5By5FvwxHwYbCw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S934104AbeCGRgW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 12:36:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11287 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934044AbeCGRgT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 12:36:19 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v4 1/3] tty: st-asc: Update tty alias
Date: Wed, 7 Mar 2018 18:35:32 +0100
Message-ID: <1520444134-30144-2-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
References: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

v4: _ add Reviewed-by
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

