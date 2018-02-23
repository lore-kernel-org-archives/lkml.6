Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1550584-1519349624-2-5287522696273213959
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
    t=1519349624; b=UfOctC7/HYF0PCWLL+AuUy0aNyV/zkPBDF8N60bYYJ2UsYf
    fHwJ4qO4u1TdXaEWYMeIl3B2doNMnZ0EeTM/a+soNPiUDPmTiv5M4RyoGXUnpFDr
    bE6i2cPZEYnLsOZWmkcT/ubvbDxRtgovfYZ3qsWC6ofF7eFgY3l1dMiK0p0lTqcX
    p8PoxjBzO1hL15yPFeeW4+hQI9MxWrlzOlH/OJA6zRyjzOi8Sh4OGFaifX6lt1Q9
    c6kGrRvOGMNzDUc0vBuvRfmEboDglYwytEOHTRy3dTTw6YW/IvnwDzvBMdppjLTx
    xQQVwns4PEj1zdWTBcVtmI/XVw4L8NfTMt/f6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519349624; bh=8
    omwmrT336VOBRpC0Qsp3Q2A6dis2GS6FDwR7Cz/XKU=; b=M1kZGkwSVTh6v3Dqz
    n85TKG3WDTDRlmuwJ3127IoozcgwtXa+c1nt4zQvxgsbaIGcKfdm48tAkIfVK659
    Sltig8N3N8P7MaGIFkUo62h1llbMNImnyMu9HauzCeSkvxKrYiybolbYmQQPxTq/
    sOoIuKyEacwSXPpiASE6cvf5xvbFo7LgtvkRPgKId83OVeIWRRb6lwgNHhqZTPcx
    6+CdAqe0M8oo+9T9YCC5c9m1ZK/7XkCZt2yVXrQac45LGnTbbPMxac/mpgTfpmI7
    vyWlQE+qwcVFPa41wGC8DIobgOd2nsWope+2hQLWG2rzIUBcLKi3mF+W76o3gYN4
    ZrMHw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
Subject: [PATCH 4/4] Staging: gdm724x: LTE: Refactor gdm_lte_pdn_table().
Date: Thu, 22 Feb 2018 17:33:01 -0800
Message-Id: <20180223013301.17646-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223013301.17646-1-quytelda@tamalin.org>
References: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
 <20180223013301.17646-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:1O8Yu9/JfTzqNA6YVzSbjxjGcT4HlAXnosSLffDLnvE/vQIaUG0
 QEujHkSRwWXvT8umnU5RN1l+5eaIHu7NANqviNEnHBe3sdj1FfN+m151BISE0WcYHhg9z6i
 nEZMOSfcYtPEiLfJruINX0uL5pF3WFHhdIA4W0jByFkYVUDvAhw/QnQIp0tu2o7cZSO1bAH
 DCYBuF6z/tUQk0fsgXqag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3IvUHJubbcQ=:ERu3QCKOv5xr6XTyqN/psO
 V3ZoHnsoONQw3B5ik2KlKZcr/j/8lUK37Pr+Ktn3H9DRGl1Kl3P4JJNrFscSJxt+xT7b/2teK
 NhunnNiqDLUy0/M65LONOg1Mzkg1+4fz+wiFUhllrx8Xos5vmUe1Y2f6TbkfHlIR4Ihv/KOQp
 cOZ7j2FsxUCGOEgQe2himDHOuRAomW7YmzcO7zS339ESZ+2HQtm2c3ZS0HJOqdhRrITq4U0jc
 LN4wOexKPwcFGSuEYhT2KA9xUeBEiefvfJf7EdRk1kaf3/CUB6232Tg4QjeiUIpUpX6G9RSjQ
 lsPIyssHxyeCp+r6hgEWFoyX9cCRjYs6nw75m/bDSgvVjEltNYDmcvjYAT2s3SmDg3ylg1cUA
 nPYhiU3mc61f7Jqas7hhSqW6S18cC+Cs1oFRKruH8brjZpgeKlb3FZGVMhdIEc0qXYGofhY3r
 T0VnCYcXIwZIwyaaO6MtzHlUjw5haD5pEDnebTSWeNZ4kxOrghPgQvNax6naueF6WUAwFNR0n
 jpoNSdCvzdHanAjkI05bUHKPRGlTC4IBe+ipcSfOrWNQYleHP0ofy6UBerA5c7ej/MedX8UT0
 VdhZgGaAJ5kDa8MduTWS2rng0amXMyCIkNBAPFWY3YPVjLIniQi5w44YXfQvqrGEFMuDbD/8e
 aEC1ATxQVBA/zHvLWhXbG2LVAFT+EcZDrVTGSvU7KSEezQyQagY36PRLN4GwA8CuWlni4lykQ
 B38EhQlz8aoPkaMLRvtk4bb+poakN7JnooaG9Q==
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
