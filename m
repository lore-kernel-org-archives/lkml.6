Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4094253-1524311792-2-4736239337639921466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524311791; b=auY9wlJ3rwi0hIinx2YBgtGH+uQ+qnYq/1PLMyUbTDDn4sYAex
    0XBCWFs+h7/8T/0BYqqbVbpb9BXl8uG6/hDiTeYTTHI8k+nfPUlwC5LqCTQEvrpM
    gfQ9inH8KuodRO2KInKPn4mdZV1dPY1+qAd0CS36BvQ5LroU8Cw8TE+z3MHV042S
    ELOmjZzw0to6fje0tJVGWQKAX/kE3T4f97xxsr8nACAyXYhRgLKeeJQeTNrEtZlF
    uPTMojizojQfwjWuRset9Fkw4DzWDDZwklb3E/eGq+SE/siFETyYky3J3llBNdbO
    eEJqFpqnptVIdjizv3gxKuw5JBJ8CEKZE+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524311791; bh=Zk0n1
    XZHjGgJIYXQM4+V+UMMXx7/02KTe37zLbcsrHA=; b=u3e1LarDdit92J0fQQIit
    BO5Q1jJse93QQ79itg6GQi6cBnizaULj0IH9rNIhpntLX+hlRm8tRSPTs7EWtW5Q
    EaWfPiIM6smk0YUFJuHnSHEA94kRd5CRzXtuytsHDThC0AzAxPc034hF0QSeycsH
    867h0j4GaXc8y+XtDWBMck+CIZFMPvET6Kc53nM9+DZsOb/bL9UvkaAkHVzqiqKY
    PWBnGqBCoQS4lFEcM62E963u6YLCcwIJVmpoMa0KO5yPw2Yy4zO1bXCJqWt6IUEX
    K5tykj5Qih9p1R/mTyKe0Bk/R2VzMferSyy6uHPDfeNZOTFyIgU3A40ruvqWnRty
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u/izpABi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZCfZ+jSd;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u/izpABi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZCfZ+jSd;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPusv0q2Z8yzy90mG0EpIpRPCIiEUrkmz7ZBaW2uKNdK9PyLSRAHjWjc4AsZ/JNZPnsW8tZewi9/mIQJQ2ZIfSfxfoZR0OYaLgcXqZjb+qDrNkVSs94t
    Q2r5wB4+np5u0b3YqIiJblL7v/wrgzE2mEWGI5DHkx0uZLnq+wGCf+nrvyYmwVqlcsE5rNEukoGvmeKlbXZ7VQfOcoSbvC+4AFidla67Q5Lo62S6DDCUCiX5
    vh0HEs+xEYhdTUjuWEhE5A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=px3f5oUF_X8A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=6vgqkGN3aXGLInhuMR8A:9
    a=ezIW7YCsTGVTYCoD:21 a=TkA2WJcIkrFFghYE:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpKUrUtvpBhz+/cDBtUcbfaCsLvVjhYFbCTCwstk71AS3/j28x5iq6rGPxDoRp13x3TTuAXcg==
Date: Sat, 21 Apr 2018 08:56:19 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Syne <john3909@gmail.com>
Subject: [PATCH 3/3] stagging:iio:meter: Add ade7854_write_raw function
Message-ID: <82a36a0f4ee84d8ff53be2055bad22be4b75634a.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180323
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
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds the ade7854_write_raw() function which is responsible
for handling the write operation for registers: AIGAIN, BIGAIN, CIGAIN,
NIGAIN, AVGAIN, BVGAIN, and CVGAIN. Finally, this patch completely
removes the old ABI used for handling the registers mentioned above.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854.c | 60 ++++++++++++-----------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 242ecde75900..df19c8b4b5d7 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -228,34 +228,6 @@ static int ade7854_reset(struct device *dev)
 	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
 }
 
-static IIO_DEV_ATTR_AIGAIN(0644,
-		NULL,
-		ade7854_write_24bit,
-		ADE7854_AIGAIN);
-static IIO_DEV_ATTR_BIGAIN(0644,
-		NULL,
-		ade7854_write_24bit,
-		ADE7854_BIGAIN);
-static IIO_DEV_ATTR_CIGAIN(0644,
-		NULL,
-		ade7854_write_24bit,
-		ADE7854_CIGAIN);
-static IIO_DEV_ATTR_NIGAIN(0644,
-		NULL,
-		ade7854_write_24bit,
-		ADE7854_NIGAIN);
-static IIO_DEV_ATTR_AVGAIN(0644,
-		NULL,
-		ade7854_write_24bit,
-		ADE7854_AVGAIN);
-static IIO_DEV_ATTR_BVGAIN(0644,
-		NULL,
-		ade7854_write_24bit,
-		ADE7854_BVGAIN);
-static IIO_DEV_ATTR_CVGAIN(0644,
-		NULL,
-		ade7854_write_24bit,
-		ADE7854_CVGAIN);
 static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
@@ -497,6 +469,30 @@ static int ade7854_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ade7854_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ade7854_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_CURRENT:
+	case IIO_VOLTAGE:
+		ret = st->write_reg(&indio_dev->dev, chan->address, val, 24);
+		if (ret < 0)
+			return ret;
+		return 0;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static int ade7854_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -521,13 +517,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
 static IIO_CONST_ATTR(name, "ade7854");
 
 static struct attribute *ade7854_attributes[] = {
-	&iio_dev_attr_aigain.dev_attr.attr,
-	&iio_dev_attr_bigain.dev_attr.attr,
-	&iio_dev_attr_cigain.dev_attr.attr,
-	&iio_dev_attr_nigain.dev_attr.attr,
-	&iio_dev_attr_avgain.dev_attr.attr,
-	&iio_dev_attr_bvgain.dev_attr.attr,
-	&iio_dev_attr_cvgain.dev_attr.attr,
 	&iio_dev_attr_linecyc.dev_attr.attr,
 	&iio_dev_attr_sagcyc.dev_attr.attr,
 	&iio_dev_attr_cfcyc.dev_attr.attr,
@@ -599,6 +588,7 @@ static const struct attribute_group ade7854_attribute_group = {
 static const struct iio_info ade7854_info = {
 	.attrs = &ade7854_attribute_group,
 	.read_raw = &ade7854_read_raw,
+	.write_raw = &ade7854_write_raw,
 };
 
 int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
