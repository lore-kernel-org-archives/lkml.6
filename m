Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2946400-1524271352-2-12755098520350723503
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271352; b=ChpZP95lKe07W7ZmKuF1VKnbeGS/lFZQZnGrMO8cEIYw4vVMbp
    82qnirFLTK3OV2bTomUQrUifdpqlP0BvhIanAGK4fiFIMLoBZhArS3/P/1d15THW
    RhOZ9kK8WcI6QBX+gD0ja/15WLLoolXNqF5/72T1vFEzagScxuKRf4T0Z294bsQK
    UDpS5lnuG//zCb08c7xz+dIf8Va2iEAux41TGatdzwHcRT12JtHGfadEA4K5ym8H
    Ekz5ufDOA9nwDBQLhEURpyd3moSIt5lyK+wf4VIfLvqQPeAJGmAfZDFoxNqo5kJs
    PbkTvjdy5/O2gSbfYm4PfNYK2mpZY8fNPh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271352; bh=zF/WS
    Ro5x8efCjS9IlX+9cx+/27TJ+laZWGdXhXErgY=; b=vw/fxYufvYEzL6rkxPP2r
    /jj2+x6iPmwyNdTonCotSjzN0MYaonrWpQz4icLLEQAoMKWLq1qegZqWI4oAY1GD
    3RULkVpVJViK3EgWBuRPS6E3k5Ap/oWkJWDQnPEJ18nmWU0vo8l3EsLaDQb6N7tn
    58tqd30c8jVkIA7VdNzqixbuSX1jksn31KeZ3OX2JNmQO8E1m7rWk5lrj559CBs9
    ew6jn/XAukM1H2Oy6Vq+CvGGIc7I6DvL+JbArhT9SKUCZ/yL3e1Y+ElCZ8ntt2TY
    8zhPGslz7vIhD3oG1PThVOxVS4gCpHeZXyhdA5a8I4ykEuf5SwjjUzSMVtL994af
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=l3i6mRU9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=l3i6mRU9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBUULInTE/IE1us1OA/vSn8A/rWp8/9ZIYYLklgTtIvJjms/YPwY/CjsoKQLS6hhZIf48ylTbmTPkH5wjdO7Wtont1ZV7p0khn5AiIYwL/75M+/CVfLM
    zW1A7K1mbkj/rgf/QqU/JfX4MVNw+llncLwTDbd/7uMVvhwzrhwCnUUOnm5OVSrJzTWUmPew9SAf5Uk7wdpyYTPqdNGhNrjZDIx6sIyonPF6MtarH89GQ2Ov
    pAOHEdAvJ+jKa8ggDctPrg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=6Mx2dI9op3OjwEuYFUYA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 08/13] staging: iio: tsl2x7x: add range checking to three
 sysfs attributes
Date: Fri, 20 Apr 2018 20:41:48 -0400
Message-Id: <20180421004153.19073-9-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
 knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sysfs attributes in_illuminance0_target_input,
in_illuminance0_calibrate, and in_proximity0_calibrate did not have
proper range checking in place so this patch adds the correct range
checks.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 56730baea927..15bc0af1bb6c 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -835,9 +835,10 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
 	if (kstrtoul(buf, 0, &value))
 		return -EINVAL;
 
-	if (value)
-		chip->settings.als_cal_target = value;
+	if (value < 0 || value > 65535)
+		return -ERANGE;
 
+	chip->settings.als_cal_target = value;
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
 		return ret;
@@ -853,14 +854,12 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
 	bool value;
 	int ret;
 
-	if (strtobool(buf, &value))
+	if (kstrtobool(buf, &value) || !value)
 		return -EINVAL;
 
-	if (value) {
-		ret = tsl2x7x_als_calibrate(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = tsl2x7x_als_calibrate(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
@@ -946,14 +945,12 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
 	bool value;
 	int ret;
 
-	if (strtobool(buf, &value))
+	if (kstrtobool(buf, &value) || !value)
 		return -EINVAL;
 
-	if (value) {
-		ret = tsl2x7x_prox_cal(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = tsl2x7x_prox_cal(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
