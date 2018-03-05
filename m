Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1837571-1520262100-2-9989105655074001829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520262099; b=YkR+9zfFJLCmTcsiRVTZ0Aw6g1pyOGHjSqcI0u+EdAzRE0q
    2T2oE3MzdFU5La8/aLjcDbQymSM+UkxhMeG43tIqzdfhKIUXB5kfwj9y/h/E/wMv
    E76JgFRuh2QBieZOgJUBycX77aSGxarYVWf9j9fHvatbs9k82/c9QaoJo6uThp4U
    bvGewuCy7Jma9oD+AUS2zowwNPPGKYNLqI06W31Xa/WneJDBYw/F1HMqGNi7izIV
    cVlZCmBwkDHdF7EjgyH9j47Xj3dvwXCQhHs7ffQGCc5J/mTjbSQcd+C7r5MQMhMs
    GUR4I6+1IjGKVbF6Go5KMG2uDTlREU1yDXK8GRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520262099; bh=uFu2qSZwZ6HEXOvsX/XuhBUerl
    fl7AdQBGtlYwrAkBM=; b=tZh1+f7CXufBjO5yyIS8f8JafgXM/gHOgPs6PiVGJP
    SfNT5dXv43G959uQw3Z79mFpGRTpVd09C9mWYWWWQ18CXV0bKk62o7bILBsfjiIn
    13OMKi20c4G+HZLrvErQonOdRReLrzwAx5Kal2UYuO/zdlChDP+JWqb2WWl9pOYb
    ZsQ/DKTX+bAGcjtVZk8QGZcFem2KxLHgn1Iiv4kJ1W5KHHcrrEfDkXG/TDpbmxog
    r/cYKQBaHTgOOyZAzRboV0Biao5mST5xBBo8ho9UGJb01RoaV3husL1x6z8f8Q4X
    DFwtoaD7stGbbio/s3umO8TtH1Ce9AdH5N7sLtodr6Gw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1752144AbeCEPBh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 10:01:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44266 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751880AbeCEPBg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 10:01:36 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH 2/2] tty: st-asc: Convert tty alias in lowercase
Date: Mon, 5 Mar 2018 16:00:25 +0100
Message-ID: <1520262025-21088-3-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
References: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_06:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
must include only lowercase and '-'.

After having converted all STi boards serial aliases in lowercase,
st-asc driver need to be updated accordingly as tty aliases id is
retrieved using of_alias_get_id(np, ASC_SERIAL_NAME);

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..8d2167759258 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -29,7 +29,7 @@
 #include <linux/gpio/consumer.h>
 
 #define DRIVER_NAME "st-asc"
-#define ASC_SERIAL_NAME "ttyAS"
+#define ASC_SERIAL_NAME "ttyas"
 #define ASC_FIFO_SIZE 16
 #define ASC_MAX_PORTS 8
 
-- 
1.9.1

