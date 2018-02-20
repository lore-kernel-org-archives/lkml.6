Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2058923-1519109829-2-14838364758609845073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519109828; b=nIOwnjjLe6qz1CrIRyONIIv8KrGuGSvdYbNFPggKMlIGFNW
    onQ7HJQkXGCLll64azessieiyz+Ut0pjIFLOe04AGrco4E1UGWOtJGZrcVGx2VlM
    PAXVvwwfultLE44lhfWzjkX6kBvI0A37nEVhF6w33aJZO/xJsqWwngLJ91Jg4S2L
    wpknDZCkvtY+e+TeREcLEiQeNRWZNmkHZydelbtBr59O7WIrQfwRAs9h7dKLY7xl
    3rtsiSXDTCkcCII8UdrJGgEF72K4vzrkR/s0SOT2vBzY1Thit6Tweu3xD95c8Q+e
    4coIPyNDDuauYwsOH9SVJH4b7QenpDh7UrUYNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519109828; bh=n
    LsUUOSu/15qzKLO4dgggISdqujCUAbUmfz97G6mfDw=; b=ELY07Mseh83lCobfD
    c+UcMYFF7xa5jVwJMqazcDkmfSH5gC8p8jkuqfXIhsaZvx9QZ+LnCe0yg1UtGhB7
    ld0UURPwZSPd1h/R8ncPXc7lbfRwmAwcIXeZEpMhLkm5Qk8mKJeV+k9ejhaeEd6J
    Iu0Y714l3kLX+sRdklYumUXq1rwrx0NtqayXeLlKtBy6E5cfgXn13Bt94+ylphoK
    Ab7FP/xW4McFbz2vhza/ifITYpw8DNij5jWd1bGCVrPCGG7gULJuDXDKmi+AWq8Y
    YHker2ovg+bwXFdv21dCQx4pza1S51lUOt8u4tBKGj5V9ZS6dE+kMZzau/y8qS4D
    DbxNQ==
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
To: gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
 hans.verkuil@cisco.com
Subject: [PATCH v2] Staging: bcm2048: Fix function argument alignment in
 radio-bcm2048.c.
Date: Mon, 19 Feb 2018 22:53:04 -0800
Message-Id: <20180220065304.8943-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180219072550.hz4vpomsaz2ajrnm@mwanda>
References: <20180219072550.hz4vpomsaz2ajrnm@mwanda>
X-Provags-ID: V03:K0:fs9hCWKhSsN8vvVXb9mYvPfHtsrYsgvThlx3KWR6zW2kfIPEETJ
 y6iWHoPPny59DnhRXRSKeGqTWxkwX1yNWWndsUddhIZ7OSMmoaIktfWg2SJrRdm9EKrVTCS
 ivVYTfYWs0Ak6o7HICy7Cwxyc3m/pWP8GAmF2avsoUjONLohkLIKAB+IL3bdxXVuhCpabhZ
 D0q39FRFGqaJGjxap6G2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KPqxnLUXOvQ=:rX9/ZXeq0+MEeA+WtWNV+x
 muwd9VKiDaFk59ETJK5R1EMN3yl29lCGsRv++f/7sd7DxfsPTgX9STIQ/rqqDhnqsif8wFP3c
 pbgGvfh3k0QqvyIoFhoCoKFKgP1eZFH7z2kw+YMz4x2EhV16QBrsmagYwa11Cc0kf/3saEys/
 MKDQi8i6AkQUuMpiXVc5LO9fElZhzRSBjlZRQgpF9T9Q9nLJqulUfzVRKbiwgtYIWNLiUsxcQ
 QrwcpYG2opGrJAN5nThKr4/LZEdKIHwNhIkQdHTi08yvobajKc94RtWkl43Xa7KVylvdGt8sK
 sNVIUUhfcFM3YFzYXEUnjsSPrPwsSqQVsU8oopDYkCvueJHekFT+dtWTAgxbbrO8QxsuOHqdW
 pAUwShbbIJkd8S0lN7XmlYEsFOlXguPhhZa/sxJ1H4FwZZOuJCqbVWkm7DL9I+ard7jAXR8jT
 UC6ceAQYHDe7cvzRDeikAmJIu1xKjHc/6Ftkozy8hpwvbUlv7r32jnHG8rD9U0WS/TTACKeVw
 SL0obosqz7jVk3/1n+rJjEarI5yOIjwoFFgl0SRtgxFoR2c5+hjSet8TsbDfpp4UqPrm3bIIw
 LxLwX8Ep4xxFeAtkmblWN2bCLf0vU0UKpwIi8Bc1Ge7gv3Rq1+jNiopZBN2PkTv/L3u6Yov7w
 eLAJ3e5jy9OigKSyL+GLQGg5qyJyEjyYjoR2ozyxAmp5sCh2uk/fZHaOBg3/nyUNwfye6eixS
 DiQUliPsy06S7Gb6YIBABRAC1pqsuisfJHCHUA==
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
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix a coding style problem.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
This is the patch without the unnecessary fixes for line length.

 drivers/staging/media/bcm2048/radio-bcm2048.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
index 06d1920150da..f38a4f2acdde 100644
--- a/drivers/staging/media/bcm2048/radio-bcm2048.c
+++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
@@ -1864,7 +1864,7 @@ static int bcm2048_probe(struct bcm2048_device *bdev)
 		goto unlock;
 
 	err = bcm2048_set_fm_search_rssi_threshold(bdev,
-					BCM2048_DEFAULT_RSSI_THRESHOLD);
+						   BCM2048_DEFAULT_RSSI_THRESHOLD);
 	if (err < 0)
 		goto unlock;
 
@@ -1942,9 +1942,9 @@ static irqreturn_t bcm2048_handler(int irq, void *dev)
  */
 #define property_write(prop, type, mask, check)				\
 static ssize_t bcm2048_##prop##_write(struct device *dev,		\
-					struct device_attribute *attr,	\
-					const char *buf,		\
-					size_t count)			\
+				      struct device_attribute *attr,	\
+				      const char *buf,			\
+				      size_t count)			\
 {									\
 	struct bcm2048_device *bdev = dev_get_drvdata(dev);		\
 	type value;							\
@@ -1966,8 +1966,8 @@ static ssize_t bcm2048_##prop##_write(struct device *dev,		\
 
 #define property_read(prop, mask)					\
 static ssize_t bcm2048_##prop##_read(struct device *dev,		\
-					struct device_attribute *attr,	\
-					char *buf)			\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
 {									\
 	struct bcm2048_device *bdev = dev_get_drvdata(dev);		\
 	int value;							\
@@ -1985,8 +1985,8 @@ static ssize_t bcm2048_##prop##_read(struct device *dev,		\
 
 #define property_signed_read(prop, size, mask)				\
 static ssize_t bcm2048_##prop##_read(struct device *dev,		\
-					struct device_attribute *attr,	\
-					char *buf)			\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
 {									\
 	struct bcm2048_device *bdev = dev_get_drvdata(dev);		\
 	size value;							\
@@ -2005,8 +2005,8 @@ property_read(prop, mask)						\
 
 #define property_str_read(prop, size)					\
 static ssize_t bcm2048_##prop##_read(struct device *dev,		\
-					struct device_attribute *attr,	\
-					char *buf)			\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
 {									\
 	struct bcm2048_device *bdev = dev_get_drvdata(dev);		\
 	int count;							\
@@ -2175,7 +2175,7 @@ static int bcm2048_fops_release(struct file *file)
 }
 
 static __poll_t bcm2048_fops_poll(struct file *file,
-				      struct poll_table_struct *pts)
+				  struct poll_table_struct *pts)
 {
 	struct bcm2048_device *bdev = video_drvdata(file);
 	__poll_t retval = 0;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
