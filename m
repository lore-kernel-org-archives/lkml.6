Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4103318-1526051209-2-6784065184977443528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526051208; b=CNAqXgELPfzOzgs0Z9EGDyrzTcUQ2XrsId/F35x0v6yR5orpPJ
    CS5M36IfBmGphH3gW9ho4C86QMwHopVrMPQEaxUXh1B3ToExnAx3sOWgjfOYBp0K
    8A25KI63Cxbn3G4mRsOOE5sVMXq7+R+rw2Ghl3HHa4U63RTPRlv892SWNR8Dcqk4
    ZxafrMYJsNqVAlXvDOBHEMsiLO8ide2YErtR2RaCFZvG1r9Ry8Hg7fBo31bJDBn6
    cFTcBWaU4uVMcUtkeZ39e7vzmot/Y+kHawQECJWKDMB4dq74rhrNLMBr1LhNlLse
    ClpdDxiNTfko/UlsklHGfSD17bmVebRXhWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526051208; bh=4xnYK
    BlSnt71GdFsPzRNLpY/katYU1RMkXxw3uhz1ZU=; b=e/WCHb/ieh+W0orK2Apwu
    d4SY8bhDfY4iZEqZGop/752rQHI/ttIqU92uhxRy3rupqyJWBfMY8HqGMqSa5OGR
    YRw0Hh5o9IZ9KtfeUcwLnMbbLI3pOvMGIo9M8Hn4oRS44hv71JaK006jEae3QbpE
    wInVyopdCJa8N8CBC/zN/VhoB/20luDMz4TqAgouNOp/ltO8E4VGz0/WJmBtIWo4
    PIooh5MNxGDbEMVcP0Ub/GrNngWHuSRgOA79IvycBdGoWm0JGEevVgAM9eBbuGRm
    lpvoS/IK7T8Gpx0Xp5wKohEnFBYrno90t7T9f1MLpZyvFv7LggtSQ/Zf7HU8jyY1
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=25 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=25 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGO6VsNrterLViQFMMBkG9geFt4dq1Ra+0Y02l+jILOrcGd+Wd8KsoNo9dss/CrSFhdvDdkYauim2bJizX1N61uvLtwOV5PUPBt9alyoxnpBU6wpndTd
    2Z3LcjIVfcvfIY8cnqulMtT+52aRdEU8m2IEV09VaQkKTjxBCaiEejUuhZCxgaHTPRGStJjmS273bGtlK1+Z0xioSjUmGFY965oPZTvt9/noFGSNWO6jRbQ7
    zu8JALZNFKmGlhHxWb6hlg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=jQZD9b6nzSCjgMAzE7sA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 11 May 2018 17:06:37 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: alan@linux.intel.com, sakari.ailus@linux.intel.com, mchehab@kernel.org,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 chen.chenchacha@foxmail.com, keescook@chromium.org,
 arvind.yadav.cs@gmail.com
Subject: [PATCH 2/3] media: staging: atomisp: Fix an error handling path in
 'lm3554_probe()'
Date: Fri, 11 May 2018 17:06:17 +0200
Message-Id: <f762630a681c08d9903cf73243dd98416ae96a7c.1526048313.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
References: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
References: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
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
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The use of 'fail1' and 'fail2' is not correct. Reorder these calls to
branch at the right place of the error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
index 723fa74ff815..1e5f516f6e50 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
@@ -871,7 +871,7 @@ static int lm3554_probe(struct i2c_client *client)
 				     ARRAY_SIZE(lm3554_controls));
 	if (err) {
 		dev_err(&client->dev, "error initialize a ctrl_handler.\n");
-		goto fail2;
+		goto fail1;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(lm3554_controls); i++)
@@ -879,7 +879,6 @@ static int lm3554_probe(struct i2c_client *client)
 				     NULL);
 
 	if (flash->ctrl_handler.error) {
-
 		dev_err(&client->dev, "ctrl_handler error.\n");
 		goto fail2;
 	}
@@ -888,7 +887,7 @@ static int lm3554_probe(struct i2c_client *client)
 	err = media_entity_pads_init(&flash->sd.entity, 0, NULL);
 	if (err) {
 		dev_err(&client->dev, "error initialize a media entity.\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	flash->sd.entity.function = MEDIA_ENT_F_FLASH;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
