Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3504153-1520957161-2-10745494575614982911
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520957160; b=VirHE3UPLVneqoqO+h0Lj4LQYhsT6Et7SkBoAG7s2xWfBU6
    AbJmspXSXiAH4oNDYiTK01iFqrYiVDycrZr/7havDzYAcl5Wt1t/BRyuHU4+lCIO
    ALS/xBfeqRuoS2ljuM1/pcp5XwNGoxh6h79GtYqrVO1A2d7Z6P9m1dEexdT3t0cP
    4zpTWpXpPnQkE31EZ+9LHGWULqVQTqsdgRHUvfzVJhT89x4ketmWBJAsWG25qjMn
    KoZy70QgjTRAO1OlHYCkkDiZeQ2kDgg+pLU35UNCvV+IzopfvCJvQT4pwAWU3y0R
    hY7cz8G1asAWbFq7/PrdKHTD3FnUJnS33y7kN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520957160; bh=F
    ADGrLxHWcHkTLJYXZgXmbjxw2vCq+FNjUhnk0G0hmI=; b=BhLxLsWrSPiUj5LoE
    V8Yea/LQJ0HH9iJc/jl8/Clt+sowMF/C0ygNsmNRdN4p+esDBokBlAgUsMHAeXrx
    GdLgT+IsemUv/8VyLyfBn1U4ikQepp5BaoNK9PV2HG/Fl7+EwPfq5rTRaYuc/6oC
    +v46EdDKihQxgDvEhl2Be80T/wniY1kggwa8YStKK5OGohMkMt4TykW66zeaBsOq
    acAF2KJ+FEGO03iU2WK0wzEAf/MWFP914sQA+BNj1uqiyMgSj1XyjIqUuPoWID+p
    p7yy5NiP2v9yFZPjBVCO6mEbytXUvJkEzRcNoPdG/5ZEKkx3iEgV/9psnOijIEv8
    +HUKw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TVSZCO/m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aB9Woa2c;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TVSZCO/m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aB9Woa2c;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvkU5vViFzAptIdmli23IrMEJaNg3wNl+bHtMFWLxX2Wm56DywdMvMCtfauviwtcEzqp0zqCQ==
Date: Tue, 13 Mar 2018 13:05:48 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Graff Yang <graff.yang@gmail.com>
Subject: [PATCH v2 2/3] staging:iio:ad2s1210: Add frequency handler in read_raw
Message-ID: <9296eddbaaa4f815978ce9433c7970a3a498d85b.1520956563.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
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
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 daniel.baluta@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Read data from fclkin and fexcit does not utilize the ad2s1210_read_raw
function. This patch, append the required handler in the
ad2s1210_read_raw to return the correct value. Also, this patch removes
the legacy code related to the read function

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 45 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 28c3fd439663..27a42ed10fcd 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -210,15 +210,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, 0x0);
 }
 
-static ssize_t ad2s1210_show_fclkin(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%u\n", st->fclkin);
-}
-
 static ssize_t ad2s1210_store_fclkin(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf,
@@ -249,15 +240,6 @@ static ssize_t ad2s1210_store_fclkin(struct device *dev,
 	return ret < 0 ? ret : len;
 }
 
-static ssize_t ad2s1210_show_fexcit(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%u\n", st->fexcit);
-}
-
 static ssize_t ad2s1210_store_fexcit(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t len)
@@ -486,7 +468,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val,
 			     int *val2,
-			     long m)
+			     long mask)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
 	u16 negative;
@@ -535,23 +517,36 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		*val = vel;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_FREQUENCY:
+		ret = IIO_VAL_INT;
+		switch (chan->channel) {
+		case FCLKIN:
+			*val = st->fclkin;
+			goto unlock_mutex;
+		case FEXCIT:
+			*val = st->fexcit;
+			goto unlock_mutex;
+		default:
+			ret = -EINVAL;
+			goto unlock_mutex;
+		}
+		break;
 	default:
-		mutex_unlock(&st->lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto unlock_mutex;
 	}
 
 error_ret:
 	gpio_set_value(st->pdata->sample, 1);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
+unlock_mutex:
 	mutex_unlock(&st->lock);
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fclkin, 0644,
-		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
-static IIO_DEVICE_ATTR(fexcit, 0644,
-		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
+static IIO_DEVICE_ATTR(fclkin, 0644, NULL, ad2s1210_store_fclkin, 0);
+static IIO_DEVICE_ATTR(fexcit, 0644, NULL, ad2s1210_store_fexcit, 0);
 static IIO_DEVICE_ATTR(control, 0644,
 		       ad2s1210_show_control, ad2s1210_store_control, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
