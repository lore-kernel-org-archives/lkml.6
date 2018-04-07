Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4175590-1523112930-2-12567197440000846990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523112929; b=U1MwtrySqtMNKzsuf2R94RbMWb8/Ek3Pin8ZOwAw+3io8ZkaXS
    esJXYUVjtgL+lLN8HR/gf63PRNdBBu6EevZgUvR5w4WyxsMrxDLjEJzjGNB2SH7l
    GAvD2rAmw7vHCPEYVeAt/O9r7GLwZFWM/L5mv/YDfJYlqdSuctV/TZJggWA6jRqR
    j1x9+H92o5KIgy2OGwm3SzvMuOJL6FRFAvhCndtpZOXpf6kuC8Md1FYNF8mpTgsJ
    mJk3eoEFPUI8dPBVS4eXBdCPZBMHbIRDctIunufJkdgfP8dfGIyGt+2Ruwwwx2xV
    BFfDvPva7oERO2GruaIIKetDQ3wmgCIk92sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523112929; bh=V7XTv
    z6QCeW36v3HCmnkmnismKZWxH7/4jdUzE+bbAE=; b=cYeT0g3S02/T87wpEndl2
    5auOfx7UCvQv8I/q4nxhharJuH98TCQj3qSi2luxHi/ShHG5f1rx6Hd7AlKzt2dx
    1Tb/A8DtXo6M36I99yOkQHc86rPPJ4jKd7oZylfHFtiS70RGZ7ilpMoh/cv2bJ3w
    +jQti2e90UJb35bnOFeUYa/geATchvoPJbKlYrx0RRgrapncrgV0Z6Bsdz/ayIPM
    Yna4xnQGWrAzP4Zu/kVUIVM2y+zZSPqBMx+v+M3wSW3F8F7rRsmA8DSaRqsOZ/g5
    g2Ayfh1UKEQcgHAaixSyozEuSVjcfve4x7tmokZEzKPh2SjDX3ZJLLJSgjvPCucA
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=riseup.net header.i=@riseup.net header.b=OxqqNFV0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=squak;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=riseup.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=riseup.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=riseup.net header.i=@riseup.net header.b=OxqqNFV0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=squak;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=riseup.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=riseup.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFZTXIvI42UjXLBjAAsfZpEzuGpVqP2QEi4VA2soCw1cDBH+S2RcY3E4bXrua1ve4VFSHysb5IxMaUuOm86/A11L2cTpMH7hQjiY6vwEan8idgTAAOtd
    VJZ3QsqOOCgY6v7glfK2DZrLHOZteJG+0JWcXNp7MB+qRISTOCgbkrl95B8fJesEgfc/pRDMzcDssE2C0JX7TzQzdEQXBaVDBAhJVrVsLdQbluSnY3EIN/87
    msuRoP0ztVywFIsvXB/xGw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=bBqXziUQAAAA:8 a=DDOyTI_5AAAA:8
    a=xy1ZRjJBDHkVoAkOD3YA:9 a=CjuIK1q_8ugA:10 a=BjKv_IHbNJvPKzgot4uq:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Riseup-User-ID: 7F60947B8C6137E992C45EFE11ABE6141E6E2B1BE01594BF9B71F30ABBA08EE7
Date: Sat, 7 Apr 2018 11:55:15 -0300
From: Danilo Alves <daniloalves@riseup.net>
To: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH] staging: vt6655: remove unnecessary line breaks in function
 definition.
Message-ID: <20180407145508.thocnosycdk6wx55@glitch>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch corrects the function definition style of CARDvSafeResetRx.
Issue found by checkpatch.

CHECK: Lines should not end with a '('

Signed-off-by: Danilo Alves <daniloalves@riseup.net>
---
 drivers/staging/vt6655/card.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index ea0a4b57852c..52e9e6b90b56 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -557,10 +557,7 @@ CARDvSafeResetTx(
  *
  * Return Value: none
  */
-void
-CARDvSafeResetRx(
-	struct vnt_private *priv
-)
+void CARDvSafeResetRx(struct vnt_private *priv)
 {
 	unsigned int uu;
 	struct vnt_rx_desc *pDesc;
-- 
2.11.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
