Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2940329-1524271353-2-16688894982601317218
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271352; b=N3ui3Nxr5ZwgfiqXv6Uy63pS4ba3hBn8G71401kNu5DUb6UteK
    QrmaGSf9JiHDhFdGfFTYh0cwb8nZY5iU67E3C3kUtX/zEmraKyWaIb3I1nu7tzWJ
    ZuoYYwOpDOkWTcEAzgOS9719bEIhGpxgPogcs3MLGi+j2XgARakueHHMkffb5a8h
    aZXjwZfH4tGnTm864vvbiQfbyxOYAfpQg2mV/BFlK3a3iPz+LaDV/zAG5GwOVywg
    YCKH3iAysHyxvWM2p68Vmh9uNpF0da4zDh4FtZQXc5f4Dso1m+dPcJc+tbIv0LLr
    7NgakMt9o7gq78eDN95eDkrXwkzwW5yjY6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271352; bh=egKG/
    obVC5A2VeiAgnpC9f8pNZD1VGzKV7nAyPvI7S4=; b=O0TTaRq2ZsIL53sZ7E5qB
    VP0+1UGeS6YEdbl3PBNVcXir4KrJ+1sIeqSGrw10MS04ZL4I2aGTQNp9eikw+727
    GTT7Yqb+jgJCCaQNJWTLEbRp/Pt13Ux4M5plMuTp4cgLDRVlemO1zSkspLIVkmUh
    eLzDcgpDJzw+u4jJKQntHs9oHPR6HMz9XhLFEDKaZp/LNjfSh7brZzIaL0J8UYQi
    xqxVzEYawWqTFj3NADkmRBezu1n7rhx4qMvmVuHSEYABGtW/FwVZALc+K0TiWvUJ
    sXcV5HhmbQYXajAiMxhfw8+1Ix7lA6tmjiKATG8e2wrJE/+4n6wZ0u79uMOukuJ4
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=e77ujiIN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=e77ujiIN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDS28f8GfaP//lbfXycg6auvAW3X04Faso2yScpiwkgiFVAJrBhXDLV+VA26s9OTbGhXakG6df5hDeoBZndTmyFiOjziTh8o5cnFxKu251TJFhS5/lvj
    Q2VeZHZhAfsK5jMMIb2gNDBFLvFyRl3FXNPyK0gJzRlzcspF+Tk/3u5M8VeWl/Bz9y/4f3sK9o76F2uS09yreM3hjxs6XpspHLSURYVb/x2sxxvUAvZr85rr
    CLLCsaN1//27aLKzIVN7fw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=rGTBWFA5KDu2mHfs3kMA:9 a=hmW2vZdC7uXTp1bi:21 a=v1CRzcwShWaRhdnO:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 11/13] staging: iio: tsl2x7x: use device defaults for als_time,
 prox_time and wait_time
Date: Fri, 20 Apr 2018 20:41:51 -0400
Message-Id: <20180421004153.19073-12-masneyb@onstation.org>
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

This patch changes the defaults of the als_time, prox_time and
wait_time to match the defaults according to the TSL2772 datasheet.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index a7b4fcba7935..293810ff11b9 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -201,11 +201,11 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
 };
 
 static const struct tsl2x7x_settings tsl2x7x_default_settings = {
-	.als_time = 219, /* 101 ms */
+	.als_time = 255, /* 2.73 ms */
 	.als_gain = 0,
-	.prox_time = 254, /* 5.4 ms */
+	.prox_time = 255, /* 2.73 ms */
 	.prox_gain = 0,
-	.wait_time = 245,
+	.wait_time = 255,
 	.prox_config = 0,
 	.als_gain_trim = 1000,
 	.als_cal_target = 150,
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
