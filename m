Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218798-2-8040080865781373762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218797; b=qbBbr1UPy5MFszzuv9mJhJgp9fSgCa1JLeGDddTzz11WIzu
    UBHTl4trlSYm6h+HpoBziVWcH+HgsyZP1h1DYo93gywbdD1hSgEiZEsjrnZtLuII
    LksR+8EZfV1VSdbuVjOrogJFH8DFWwxQ1SvLmU2P1s5oRd5OzzQsjbN7/CG4etfV
    AvTTXWeD4KYrPvGgaJMw+zCgUoOJ2UxTU7o90W1JPNjCemNup0HJfDj+3N2TSOgd
    M0YFW8qzv8FxhtX4tFV6gurMLt7bso6Sjqna6LAGslJ4w8tFfIcivMhyGDzLEjvF
    KrGCmLhKyw7wtKmowcN8ZkRa0mlf4RDJrSNT6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519218797; bh=8
    omwmrT336VOBRpC0Qsp3Q2A6dis2GS6FDwR7Cz/XKU=; b=OxkAktgNHHndN2daz
    JEcXQklkR94NCWTpp86P/sm+XsjQNc8ki7SH4r1jnRlW2puZDYsEFJoZuHBtkKO6
    c9D9lSSiOOuMp+/jfKRpajlDTJezQ/rDCoxvNNcgg18zO+bfVqaxP6YeaF3tiHSF
    9hqb0jUAbtRf1MWrhqOGJLTPjiN4VvC4oyY89D4Q3Ro6Zz3SsNTRNE/78i4UFbL/
    +nuFE72Cay+vSS7G/fI/nMr7QTJTdtI2IThNuGQKAQ6Jp2OMlpjygK3pnWqGxTYw
    ZP4skUPhcezq9js3Wf7cHIdr/R84nKhD5UfOg2X4Sq5fyyHbV2JgMoHzMnuNF7LK
    Mf1lA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
 dan.carpenter@oracle.com
Subject: [PATCH 2/2] Staging: gdm724x: LTE: Refactor gdm_lte_pdn_table().
Date: Wed, 21 Feb 2018 05:12:37 -0800
Message-Id: <20180221131237.10960-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221131237.10960-1-quytelda@tamalin.org>
References: <20180221104306.zq7fdbgzjmfdrqju@mwanda>
 <20180221131237.10960-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:pooY0AjWmQughfXWa+Heh7xmdCY7o6gy0NuDlCGpSsGrv+VUIep
 MSlO5wb+YmbiJ22ledNx0cst2cEQ8Qcg9VID+h2YCCvZzwEAe26d5gF7Je5QaSBoi3P9tBO
 zr6nrSatGlTS6/g5Y9WNjNpQ8N5+A0E9istMq6tvtE3YKzWHihAUrtsI2LcSM63anWwKKSN
 AXuNWWCVZOExF/5NHPKzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FkHGwJtPBYU=:rzzH+zy3TeO9ippsTQQ0lk
 CM7oknnUi+DKyLNgFsX+xJKj9dYb87Czza/OnooI82GIf1rp5bOt/gpIuMjELSbsf7ZirKQRd
 mGr++0fg3icqUPVF/O71Ws2mGBmraG/q6fgxmuWw4lm7rV/aKbyU30KKtswyx2Z9uhQ0+aRpD
 ldrPwmuP1x/U0xw1YZVaRgD08ikmoXOz8260KrmSXzl2PRdJX6uLWDACQ2ztLFSiMtHwgkowo
 tuH5e59Bgr+7Joxa8onr8KvPuUQieFtTndMDS0MkQ/2XehmvA38v2d7aeXs6vFOJo4DGX4E19
 41bZG7Y87eQ+WURmrEO3U4lFZWOZyBUxEfZ5QXzEeA9xvSiaTModnKBvXvHi6OA09TWYP0yyV
 3OTaUi7wS+CE9M9rD3IKiRRkiWzRbdFcsdgfiO7B1iCd1c5T9RDtjjRQT/pCneuVBPZHCZYXI
 6ilY0b2Sv59U8dwDLQZQiHjEG1ASjP0DZOLgoN6twuCoSHwA6W06yZ5HCXmTkD8CwGwlmKmn6
 Sj4znSR26V0LCOjdqwZbi3qqfYD0AOscZk5nKulqCAnv4TspVQa3EvOH7k0fJwQBJSIg8mj/s
 NHcbAk9QwG13eRq5RDN2YzqnkKv9jNbRn1kTtsmV6gogVLVqIf7ARpq/+z1gYIS+56iY6f11T
 W3sbDoWfHv9DVsF+hqDuilyDJz84SGJRwm6X80jzup4HLWgqta9iSQSl17kNwmsw0SW1vWh/s
 jDTBHAb6R+UGPyAvHS6l88Rgq/nww+K4NcIPzw==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Quytelda Kahja <quytelda@tamalin.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mostly this change just reverses the primary conditional so most of
the code can be pulled back a tab, which fixes some code style
warnings.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_lte.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 92cb9d115fe3..4f3c518304f2 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -730,21 +730,21 @@ static void gdm_lte_pdn_table(struct net_device *dev, char *buf, int len)
 {
 	struct nic *nic = netdev_priv(dev);
 	struct hci_pdn_table_ind *pdn_table = (struct hci_pdn_table_ind *)buf;
-	u8 ed;
+	u8 ed = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
 
-	if (pdn_table->activate) {
-		nic->pdn_table.activate = pdn_table->activate;
-
-		ed = nic->phy_dev->get_endian(nic->phy_dev->priv_dev);
-		nic->pdn_table.dft_eps_id = gdm_dev32_to_cpu(ed, pdn_table->dft_eps_id);
-		nic->pdn_table.nic_type = gdm_dev32_to_cpu(ed, pdn_table->nic_type);
-
-		netdev_info(dev, "pdn activated, nic_type=0x%x\n",
-			    nic->pdn_table.nic_type);
-	} else {
+	if (!pdn_table->activate) {
 		memset(&nic->pdn_table, 0x00, sizeof(struct pdn_table));
 		netdev_info(dev, "pdn deactivated\n");
+
+		return;
 	}
+
+	nic->pdn_table.activate = pdn_table->activate;
+	nic->pdn_table.dft_eps_id = gdm_dev32_to_cpu(ed, pdn_table->dft_eps_id);
+	nic->pdn_table.nic_type = gdm_dev32_to_cpu(ed, pdn_table->nic_type);
+
+	netdev_info(dev, "pdn activated, nic_type=0x%x\n",
+		    nic->pdn_table.nic_type);
 }
 
 static int gdm_lte_receive_pkt(struct phy_dev *phy_dev, char *buf, int len)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
