Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4005293-1520323734-2-15757366337965075254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520323733; b=Uvyf/fsSCM68Im38kd2i11cV7M1omwVfTwNZhrFyRtq60cr
    I5gdC+6kNfReEGyNgkMtRrOR2UpQ1MZf2UpJHkUIqotdTPt9rbuaC8OPJY1opyNU
    SknxFekVBdBh2S5W6qeDjuQAFiWQRORtavTJrMt2DbmREtTAWqPmBxew9mCcWq7I
    oDmJI7KE3zOs75X0u5MzduXePK/oPhWnisdxNfi+PF1ZtNiQKRlso4nTg0Ll5dps
    Llacdoj+ZVQCwvYjL857eLozfupWfzArqphfWm67fN7HswuzRJpn0U3zopvXchgZ
    CwbYT12Qw6TaXz/84ZMZeqFuDnsyXyerTI4OAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520323733; bh=+Y4ORfgwFxk8srREJ1xaStSAJA
    OsucSEEz3m3JahWZg=; b=jEVmxV5/PHW8UhIo0hBhqbpBPG9rYQcbD1iMYsSfl2
    Nm5ukezIFAz3RhZc6AsoGsm09jj+kIMG2ijOBC70mEsAaqql0JWHoVPZXtTioVH1
    vpQpS2rJJFIVjRdxwj0UAsw+ouhs7iGHESivEsrIo//5Bve49Gu9cHyrjUiIGStW
    UG0n9xCTn6L9vDS1Ufsyc9NxBdKGSGkf37uoULFwND35vSND1eQUgrYMIi/I0qhB
    z1qWKSgKjILl/4h4tnvgQiUepZB5/WMKbMssxQbVMEbDUlFAUXnM7uK8usXLcaOh
    jZC8E+Rv6nODovLlx6r8ftFHmNExzT8yYl90D33ENqzQ==
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
        id S1753185AbeCFIIk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 03:08:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39183 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750730AbeCFIIN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Mar 2018 03:08:13 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 3/3] tty: st-asc: Update tty alias
Date: Tue, 6 Mar 2018 09:07:30 +0100
Message-ID: <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_04:,,
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
aliases id is retrieved using of_alias_get_id(np, ASC_SERIAL_NAME);

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ update st-asc driver with "serial" alias prefix


 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..f9372b690e54 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -29,7 +29,7 @@
 #include <linux/gpio/consumer.h>
 
 #define DRIVER_NAME "st-asc"
-#define ASC_SERIAL_NAME "ttyAS"
+#define ASC_SERIAL_NAME "serial"
 #define ASC_FIFO_SIZE 16
 #define ASC_MAX_PORTS 8
 
-- 
1.9.1

