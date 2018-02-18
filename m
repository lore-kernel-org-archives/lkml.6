Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2125575-1518985670-2-5615235118972600748
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518985669; b=OwvlCdUAgM9cqDVFjF/CtZNXmQfioAFwxsZ7thrgwgPddQA
    9XVq+9bNWXxuIiJeJHzz9Uld/N08Ep9n6ATRr2C2HepSgwifwwYQMHtG1qYGndeT
    Wpe+mo48jLLbhCX6pib7OzgLFioN5tgyPYtQ/dftWFbvXuc82pBsD7LY6YYx3nbe
    0FV8y1Ex0Wr9/AoO3cWTz+L/fT0b/8mIx8nkH0FmwxMkYqi7FsN7hcH4nu/L4A5K
    9dr2301rSuB9V2tz1/i5KKVqT5gSeL8P+GaUFRaMqGPq7BnOMMoMTfedUvm5V1/q
    ItPSLY0zecFQSataHdsThuT3JnhmXpHxH9WJCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518985669; bh=8
    5Lbp2+687oBHXeYGw63rZCPuY1PcLLUenjB2fbNzpM=; b=qFS2jFCJRuujm+PuL
    xPxrJ8bxxp6u4ZVLGxf4BX8O2v8z9phQ0C9eOoY4J4X/BPLfoYFSxRTPqaiqnpSA
    UF7G+M2zBqQ9oZdVFBYkwK4wxAgQPlt7QDVwaLzfSRNP9qT2f/l1wK7OT6sk8iNF
    GXuasrSur6a+Ug03QAXWMIuK6eRLE9CMeJ7IpV+BbvU2lFKigBm0T22Su5yd+MNy
    lI0zrhtghS3VrKx4q9FPDgBdcuTXQHT9f0HdpVJw9GGa0W0b6+o64eYS5raezGSs
    MI5HwGQgT3Ooo4grOM9P26IKXWDnXNNAoj858Jrm++bnbqmdP2CqMQrrvIu6aKni
    eSUpQ==
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
To: gregkh@linuxfoundation.org, gs051095@gmail.com, jonathankim@gctsemi.com,
 deanahn@gctsemi.com
Subject: [PATCH 1/3] Staging: gdm724x: tty: Remove unnecessary macro
 'gdm_tty_send'.
Date: Sun, 18 Feb 2018 12:26:53 -0800
Message-Id: <20180218202655.5738-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
X-Provags-ID: V03:K0:IFZDb1cISmgnRWcZ36QxP+/PMwYniRydSwqJMmoRb/KQ4bOZGRw
 F9+lK4/QutTsIWp0rQbJayXZHJkvPuWZeRxVxCLat9FXacoLX0o+QCiCr+iezKDbwlUHWb6
 /+XtA5nPf5jxrJ1x7R4OD29C7Puqyh8v9P1kngf2S+jE/J10ZMJR413SQLMYtxDjvzCk1Y9
 SpghWlsJ8pTqzuktiXw/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cuEItdqh5oI=:1xGc78cac9Ftb289Ao76V9
 BJYMHxRKtKvXLPoDoy1B7BkVluYQd9AGHaCMOtgeNCkMiFoDw+OwJclcvP/NOv8sz9w6deecL
 8M9vdCnbxEPCud6j1rEfZmkgO7tp7KLKmAMvbU4Yzmh64guFVau+c2lVzw00/JhPo4O1KI0ID
 rhZa9/cQTAG0cpKrbKdgrUMgDF1Mu2b6tZ2pezvJizM7IMixCBWiGHabWJwqFz2SlK4cYB1CN
 ZDlTEN5wGsGIjPUIGyJjHWKSaSUHMCfdbVkj8j3z5501S8zo/AYM93EyUSnIpslYvUUmzUMvY
 tGEuo/YfTSLIvyEtb56QwXukYE/z/5ruRmD+l6pt2ACUXu/L9Z/wv5oFTJN00cRHZEWDd68P7
 yl2NuDFTVskCX4zgU+ZQSAwptaCiiwpCdY5+jG2dCY26WCEKePUPw0xHLG/HA0olHsSRU6a7p
 It4qxUxGz1ohxDDa5KfLi1vfBLb1YzIJ07tIWJMSAO7H/BAfTJr3DvJTOCiz6deD9zw/ZOgaX
 A/LeaDvR8pnHrrdo5g5bFnojiftXBwmNweVXoQbNPeXSr+3bojD8zaHIxQXmo6+b0CUe9E+1+
 WHnsiq/ta75CK88BnMD1/LU77rnjbwRI8Wt0F+IPAK5SF+ChB5V8ECq+C2WsDcuQW2K39FwAU
 nnPtXQqCJpZN+L5UfkJwYTnK7mX5cO8pnRxqxULXOQynA8+ALxWiOHzG78o+aYRDZimM7AfEP
 JtBHcy7MAO2ryGVCvEQCoT9vjfYskaq341d31Q==
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

Remove the macro 'gdm_tty_send' which adds unnecessary complexity and has
arguments that could mistakenly be evaluated multiple times.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/gdm724x/gdm_tty.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index fc7682c18f20..1c3853bcfac2 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -37,8 +37,6 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define gdm_tty_send(n, d, l, i, c, b) (\
-	n->tty_dev->send_func(n->tty_dev->priv_dev, d, l, i, c, b))
 #define gdm_tty_recv(n, c) (\
 	n->tty_dev->recv_func(n->tty_dev->priv_dev, c))
 #define gdm_tty_send_control(n, r, v, d, l) (\
@@ -191,13 +189,12 @@ static int gdm_tty_write(struct tty_struct *tty, const unsigned char *buf,
 
 	while (1) {
 		sending_len = min(MUX_TX_MAX_SIZE, remain);
-		gdm_tty_send(gdm,
-			     (void *)(buf + sent_len),
-			     sending_len,
-			     gdm->index,
-			     gdm_tty_send_complete,
-			     gdm
-			    );
+		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
+					(void *)(buf + sent_len),
+					sending_len,
+					gdm->index,
+					gdm_tty_send_complete,
+					gdm);
 		sent_len += sending_len;
 		remain -= sending_len;
 		if (remain <= 0)
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
