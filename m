Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2329085-1517959212-2-8800824763809222199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517959211; b=XKqMK0lkC88vYoQj0TVoZ5d9lvLbKtAFlGAafVN61qd8+bZ
    ad3sGYc++e0F8wqdVOGmtln9ZS978XAohk92EVOsH38CoSRWUJOv6HafrKTv+MPl
    eetOCsrpZWsv2H4cuEXDcUjP11HBnaLa9SnKewmxukCzxf5wEeXESdsgzQcutbmo
    FMmu02+MVt8qco7CGFLD6vIMT2VherMyjE6TWBv8btPtWFJIVZIuTzf4Asm2gE28
    Pc/Ems+TUklWaiB6CoL+lQ0ILvgfFEn6no1WEg2Za3UjAmCbxvcbkDWi3JM+sutQ
    RE2JkNQbCd2nJR0OVUnyr7nWf+DJ+7zPZja/9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517959211; bh=c
    2znUo1dsrBplsVDdV10tztRpcAMTrvFrjuXm2+gRx4=; b=ANN+mJU5+9gEJ25+D
    TuThZQMdZSftoMgOKjv7CnFovEd+8CvJJ3wEEjymic8J1oRamO2Jv0EsIssPIPMQ
    CewLTdIAfD4kM7Hby4Cf3ii6LtIvANSC3MOjQAK6mzSz7EWApxBby3G0fxjQzohc
    fv5HVu99Ve/yq2pMDCTxHAwpKRy9a4OKaRn0il3tpk1vyxndS4KIzHv9pzkM7NLi
    viHbajR3Z46o9nQ8LpgxFdRdwWGW/rOphW+DBFOlDpg/4vAJK2bqB5jwK+i69y+c
    MuxIxagQf2RTAjog+qCQIQsa3w1OMh8wNaB4714GTs27pw7PVkF7iwrSidQ+4UGb
    ryssA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DTaXnNpq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q0lhx6eI;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DTaXnNpq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q0lhx6eI;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225Ug/QlFz/sIIbXKx8u5QKZt1HdxSWpbtZoyrVwMpYmxKboBXt3uPouD4mqpgIpHp2fvfuVjQ==
From: Santha Meena Ramamoorthy <santhameena13@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] Staging: media: atomisp: i2c: atomisp-ov2680: fixed a coding
 style
Date: Tue,  6 Feb 2018 15:19:58 -0800
Message-Id: <1517959198-3647-1-git-send-email-santhameena13@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devel@driverdev.osuosl.org,
 Santha Meena Ramamoorthy <santhameena13@gmail.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed the following checkpatch warning
WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Santha Meena Ramamoorthy <santhameena13@gmail.com>
---
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
index cd67d38..65006c8 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
@@ -642,11 +642,11 @@ static int ov2680_h_flip(struct v4l2_subdev *sd, s32 value)
 	ret = ov2680_read_reg(client, OV2680_8BIT, OV2680_MIRROR_REG, &val);
 	if (ret)
 		return ret;
-	if (value) {
+	if (value)
 		val |= OV2680_FLIP_MIRROR_BIT_ENABLE;
-	} else {
+	else
 		val &= ~OV2680_FLIP_MIRROR_BIT_ENABLE;
-	}
+
 	ret = ov2680_write_reg(client, OV2680_8BIT,
 			OV2680_MIRROR_REG, val);
 	if (ret)
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
