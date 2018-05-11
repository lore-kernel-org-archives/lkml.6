Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4103318-1526051208-2-318314550116401759
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526051207; b=dv2bqQzN6k/xo4W2N7jBuigkkLfw3GkfWRxrMBQotgO4yw7Utn
    Hhh5FQ02AKth2uXFZXhOAk9KjDMj71w7eMtUvvrjsSVlqHEaYXdQ4EKyLuQNSRUX
    Jtrgwd8CRTA4jKJzn2WCm3cb8LSDz+KzdV2DKua0+n3WMxVbLOTCZGPfoxVwl13G
    5hHFuzmYat02Xl58iNTeqLnD7ZLQ/4MVDGJ35K6bW2V/rh0iMP3aQqTcReTu+dsZ
    +lrpgO8JQbsncfE21Fz8690hAXa6N0aT/BtcFzFGMNAqCqtSD9dAjEJch0RU0MzD
    wwtqMXW8/loIKyjJ6OxMyrb1s1HZjWhSOeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526051207; bh=eYQN+
    L6EnKiANbhPhAxH0kI1D+Rf+CJ3xHu9NXwg+Xo=; b=cRnMJletnwU7OH/0c5cAA
    95n8GzRRPC1ZVQ5iUYAmb4r5ZURNtGwr9EvkAgOhqCpQ3MJMIDVyADT7ZL3WqJCQ
    ipARNG/gb6g+OecULPwY0Ygs+nU3zvYYu0Y/wVRqF4oIbtJOl2MtQT07OwLyqVZG
    KYgSLbaA+Cp7NZotDLIi5k746uaucrkpmGKJ5G88S7VHwrHqFSUdp7WI/7HyX9e6
    CQeZYMl04wSb8Qbw4BKutL43Kq3ozNiQ1UxIl2nW2BWWMJfsHrotzCkMt2eqkJV9
    LZS2stVeksVwalwagxj9E+JL4IOyb9sZYzY+sCftZ6nIQID0vcbuwy2SrJ+o+7w/
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=25 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=25 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGz76P8JxvaRGsxf7xLy3E43y0ClEdv56u3fgNt79mpXQBg17uc3AhCCYopR74BBKSExeWmd6DnQPIrQpzZ5Y9VHOJOI1UQyvOu8p0GCsKDUEZcz8u9I
    fErsMe3NQZU/VIgiWQZD0XziQzDES9ZXhrJnHr+W1Nm7X9mTiv6GXP5libtsE3M1e/AsmEPEzxzWT/vMHi5TebbjCPlHTsDxdGoZ63zZALYjRXwSd6wLfyfm
    NSTgXs2lA5ewawub9UVgcA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=Scm9U-RdewEpgwyJ5XkA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 11 May 2018 17:06:38 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: alan@linux.intel.com, sakari.ailus@linux.intel.com, mchehab@kernel.org,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 chen.chenchacha@foxmail.com, keescook@chromium.org,
 arvind.yadav.cs@gmail.com
Subject: [PATCH 3/3] media: staging: atomisp: Fix usage of
 'media_entity_cleanup()'
Date: Fri, 11 May 2018 17:06:18 +0200
Message-Id: <7c1d9505a90619764bc2f2a29fcfc9132a72e391.1526048313.git.christophe.jaillet@wanadoo.fr>
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

According to the doc, 'media_entity_cleanup()' must be called after
unregistering the entity.
All places I've check do it that way.
So, move the call after 'v4l2_device_unregister_subdev()' as done
elsewhere.

Actually, this is not an issue, because 'media_entity_cleanup()' does
nothing, but it is more future proof.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The change from '&flash->sd.entity' to '&sd->entity' in the last hunk is
done because most of the drivers I've checked do it that way. Not sure if
it is correct. It looks logical to me and it can be compiled. That's all
I know.


If this patch is reviewed and confirmed, I'll propose similar fixes for
some other drivers.
---
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
index 1e5f516f6e50..b369b101abe7 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
@@ -902,11 +902,12 @@ static int lm3554_probe(struct i2c_client *client)
 		goto fail2;
 	}
 	return atomisp_register_i2c_module(&flash->sd, NULL, LED_FLASH);
+
 fail2:
-	media_entity_cleanup(&flash->sd.entity);
 	v4l2_ctrl_handler_free(&flash->ctrl_handler);
 fail1:
 	v4l2_device_unregister_subdev(&flash->sd);
+	media_entity_cleanup(&flash->sd.entity);
 	kfree(flash);
 
 	return err;
@@ -918,9 +919,9 @@ static int lm3554_remove(struct i2c_client *client)
 	struct lm3554 *flash = to_lm3554(sd);
 	int ret;
 
-	media_entity_cleanup(&flash->sd.entity);
 	v4l2_ctrl_handler_free(&flash->ctrl_handler);
 	v4l2_device_unregister_subdev(sd);
+	media_entity_cleanup(&sd->entity);
 
 	atomisp_gmin_remove_subdev(sd);
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
