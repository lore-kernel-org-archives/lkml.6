Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800236-1525644189-2-8109771686936525447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525644189; b=gQhacCMZwzpC9kKr8wN9fW8bN9GOp13EKp0dicJa7KinVoXR9t
    veT02/spDtDwRejqeURBpEiH6V6wCAJj7szEVlpq/8lfvuwXiuxETgJ/lzYOj2IJ
    QQ0i0lpcuiyro7tNQmgFOMSJ2jvi15p/guvTCmnbI2TSE9EZLp3LzJVi+SCAqIrf
    I2C0IExqnGui+EjjgLajLzq1c20zfuSMMC2Y5154pZF6bGciaB4YhGyZRftO3sqt
    oOtgx+GdKFiczG37R2C5j2I2vwYlHGSViMgnPnrLKsD6GclCxThUouwjypRnrS97
    p3VhGIKbPaUlrbAD7PTQMwujK+CudXRNujWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525644189; bh=lrReb
    juIm0XYJKjmOSfH02/5175lViEagDNc18s4/u8=; b=GuhArLGHq2XbgCcXvcRei
    R9AjqHuvZhlYtPfhJn4SPioRbx1mNgmRWGO90PUqXvVBuMP28OgsMnMA7iXxCeNw
    VYq/+4CqBA8Z2bET6pg8wEczLaqOQgV6Hnoa2OagT0a5XVwU6Oc0eAyYiOUfgB81
    uMLeDRomMHLlO6RkDmKUaFSWk4x5SIfpXZNF/yxw2vKxnZ9ZNu15zJZAnlCKCo/H
    bUFDRi0IStS6N2Ru6GCKYAiEDlA0DbMBi+ZQNKhwLk24Ln7se9JrHSWHhQtWBCfK
    6M3GhtPQGvoK1jhNBG8kpgUhuq2AO64pP5j2UNJDMEk/mrIoi7KLpG9JbjbttU/a
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=d7hpDgvZ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ToCPaWx+;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=d7hpDgvZ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ToCPaWx+;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIIwQRo/5k2tN+AHuCStXaV6a7+rXycDDbZR2i4tvd4CNs+o2gsrj7PKMySiX3Qq3hqNynxpG26HSowKWW1O35g/YlL6LhMH0629BszJgiVcY+oLrnIs
    maSxxQtVXxInuSriK46vUxExPqGbSwxt/6deSonP4x6dGqeEE6fh999OYD30imYrNH6Xg3a8qJNl/F/5+ni46DX2wwpWL8XwlnMH7QgnE9uJO3yOoTdvQ1Dx
    39KL/Bofi7zp2Qzchzq4vg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=u9UfurAK6a8cR_MhOWYA:9 a=SPqNxYPHe7nLQFb-:21
    a=9QC_YshoM5SPTofF:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoCidOsdqiH39SmqhFxHJ+kDY2I8oEXNmUCXT0i63fY3XWbx80dx3dt9dAmkdPlV2+SHueoWA==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 3/7] staging: ks7010: Remove unnecessary limit checks
Date: Sun,  6 May 2018 15:03:00 -0700
Message-Id: <20180506220304.13040-3-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506220304.13040-1-natechancellor@gmail.com>
References: <20180506220304.13040-1-natechancellor@gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

uwrq is an unsigned 32-bit integer, it cannot be less than zero.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index e96477937f65..0c83d6fe270f 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1928,7 +1928,7 @@ static int ks_wlan_set_beacon_lost(struct net_device *dev,
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	if (*uwrq < BEACON_LOST_COUNT_MIN || *uwrq > BEACON_LOST_COUNT_MAX)
+	if (*uwrq > BEACON_LOST_COUNT_MAX)
 		return -EINVAL;
 
 	priv->reg.beacon_lost_count = *uwrq;
@@ -2133,7 +2133,7 @@ static int ks_wlan_set_tx_gain(struct net_device *dev,
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	if (*uwrq < 0 || *uwrq > 0xFF)
+	if (*uwrq > 0xFF)
 		return -EINVAL;
 
 	priv->gain.tx_gain = (uint8_t)*uwrq;
@@ -2165,7 +2165,7 @@ static int ks_wlan_set_rx_gain(struct net_device *dev,
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	if (*uwrq < 0 || *uwrq > 0xFF)
+	if (*uwrq > 0xFF)
 		return -EINVAL;
 
 	priv->gain.rx_gain = (uint8_t)*uwrq;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
