Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2286252-1521051151-2-7895172308867654006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521051149; b=Ub8SeLwFzViNvj06NOFHJH500Ux8N16W2GOPoz49Yzjm1Qf
    BBy3+UQEiGtBLLzahAKWFjXyfbOyBtwVhYQ1IXOLE0Ai7ZwmXQy1Vzqr8iRNw6GF
    NmQO2j/kfcLHX0H8VaE314+PokTjjeqUuHLigCBlGLLMF3/F2ge2AQJn5nRKyjh5
    +NvG4/LsrNNAZYyupsomMXz1BlxsuqYZGcGHTkYxSUGJkQa7d39CckHfmS5CK55C
    kzyDWYTngREQoXCweA8ZDnFF4G8hGeIaaNpsbEIVjE9e8VP+xnR0Ma0ZuHYt3q6O
    T5zSMLG+97ou+kvGJJYt54CDpkyFzdSy5XYZYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521051149; bh=W
    eBio+k1CfBGOeXRk/LRopP0jbV6HsQuQVlp9vmunDQ=; b=P6+OJlt6nKhF00dlT
    4vs3vi70t5UVufceqWvikB0kDYbNfG35Ok/Z6SZ7TCDMJSpSeU5YJCXeYFTC04iZ
    bxD1yuJJ92E5c+t9qvnE+/7EalAfC6sn34WA/W97dkGcnbve5B3vibCtLv5WXU4j
    VgGo8UYuOgw1Q9m8DUmhPPIqEmGveHPSgryWjzyyRui2NOmZzTiigjVmZzy8hURS
    UzNZDYeicrvndXZk9eA7DwN01ICo8PoqqaITo16+rvOWOgcz7H0RNs/htTBqnhLw
    jDxVYVhvE0bOGzj05jgER0gWzJGJ/HzaS6y6dqUbnQjxq6sHmv4mxVwtNnwXqZjd
    W6Z1w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UlnXQc2p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uUjc8o+l;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UlnXQc2p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uUjc8o+l;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvf6MtTPDYurd+EsK8Ga92zBOesTYi2aKRZgnMWPfEZqRfQat6xh0juG9cRglnuEcfT8o5mug==
Date: Wed, 14 Mar 2018 15:12:18 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Subject: [PATCH 7/7] staging:iio:ade7854: Add proper error handling condition
Message-ID: <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180223
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

There is some improper error handling for IRQ and device register.  This
patch adds a proper verification. The IRQ correction was extracted from
John Syne patches.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: John Syne <john3909@gmail.com>
---
 drivers/staging/iio/meter/ade7854.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 09fd8c067738..49cbe365e43d 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -436,7 +436,7 @@ static int ade7854_initial_setup(struct iio_dev *indio_dev)
 
 	/* Disable IRQ */
 	ret = ade7854_set_irq(dev, false);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(dev, "disable irq failed");
 		goto err_ret;
 	}
@@ -544,7 +544,7 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* Get the device into a sane initial state */
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
