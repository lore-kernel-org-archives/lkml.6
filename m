Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1543765-1520897778-2-15976385963356910814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520897777; b=sNytu9+unpUP73UTw2PQ5ALhd7yDeIRTfD7WaC0L0vT2Fac
    3epA/oRTUwx+jjwiK4Gd4etvnQ7xZE5TCpjASdPugdGKuDM6evsS53/cuipaqiyy
    yPYto2OQQoDtGZ87lZm3kw5Wy/b494FTFfM00MgcEMCBEAm1YkpVEednMQkl225n
    DNx5g8cbDHXuVoApwXLKSdfPcA+oI0beGzdjYTzEFsAYGdvpasdnR0AaQVIxnAJU
    I5Qr7AZ1gpc/DaY20n6YflEnSHucPALWVMKd6R5IqOdCIK8m8qwSP7HzPXX+8eFL
    Tx1s8d9fHTavVtZqliKF6Kwb5w6dqKD7zUMeYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520897777; bh=Y
    P/QxqymplXz5FJ/XOxoFT+CilMx28WCJzB6VI8YnBg=; b=YIGI4sVwEVeDJkkF/
    nR0WqYaJmUfidcqJv4feyOpMr7kqxUjYY8573W+76vJjWdoXqsFFmiT/dTrAoTDU
    bgOlGTuzPAtRPsJCUE/LUHLgpbBrPy+eueJK8VmnkQaN+6vlm6ioLo2ELGWDo04c
    PU2cCaeZY3fj0NnPpCfbgi38HsHJMdENA6b68kAWToxNli+vZYEBsnOlJCrvJurM
    gefXarOPcZpdxKgn1Ri20XPYncYLHmJ3/7DFxu+N58/wI7If0IWk5o95rWsRY6NF
    731RYJB7bK1/OPSVUtAcPornDqoYZH2gahV2rJxXa2HFMV5ePSHVBGVyB/7RYKYU
    IQrwg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org
Subject: [PATCH] staging: comedi: adl_pci6208: remove redundant initialization
 of 'val'
Date: Mon, 12 Mar 2018 23:36:05 +0000
Message-Id: <20180312233605.8643-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Variable 'val' is initialized with a value that is never read, it is
updated with a new value again after intitialization. Remove the
redundant initialization and move the declaration and assignment into
the scope of the for-loop.

Cleans up clang warning:
drivers/staging/comedi/drivers/adl_pci6208.c:61:15: warning: Value
stored to 'val' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/adl_pci6208.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/adl_pci6208.c b/drivers/staging/comedi/drivers/adl_pci6208.c
index d39b4eabce8d..e21840e9002d 100644
--- a/drivers/staging/comedi/drivers/adl_pci6208.c
+++ b/drivers/staging/comedi/drivers/adl_pci6208.c
@@ -58,12 +58,11 @@ static int pci6208_ao_insn_write(struct comedi_device *dev,
 				 unsigned int *data)
 {
 	unsigned int chan = CR_CHAN(insn->chanspec);
-	unsigned int val = s->readback[chan];
 	int ret;
 	int i;
 
 	for (i = 0; i < insn->n; i++) {
-		val = data[i];
+		unsigned int val = data[i];
 
 		/* D/A transfer rate is 2.2us */
 		ret = comedi_timeout(dev, s, insn, pci6208_ao_eoc, 0);
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
