Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-121884-1518785492-2-9815753480236552288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518785491; b=oju9VHSnYEkK+jeC02yQWbx9lCHJVbvsrSyEjG6sGXFyvIr
    FIt/jMIDJ8f7ExnQNVNwstX6CqQQNUA/ZBVBG5ZPdC/KX+KkECnTtBqyG3WREyRz
    P9JebsMXL6MGflBjT+0pPyMewjGjKMLb1uxAXtIFOy18ujO68NqFUoeeJQ9Yv8t9
    rmCovr02z33P7sQlhfZLRlXbl1h12242x6lbmF030RhEqBwbeJsqZuBSOVv2uWA/
    xugjrU7xaZZetZ7hMADCDZOqMpfVpu+SO9Q1+rDJtJa0IKLKTzcHs78hH6BAryR9
    A/VcySrHoD0CtTX2RHAEkMM8ypgD3pPVN7XpXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518785491; bh=L
    wMu+zalxJeHjJ52NlGu5Gn0+rpQVARemLtrXCp4PEo=; b=alaK6i21zNiP8o7Rl
    KieBSHgX6WoRurOJXIqbys/HfnjiNgscBzim5RaOCb5/iudKI2HebNmT39tDM0vp
    D9j38ysvePzIkFeNEhO5Ej3DVCHBDE4WdClb1CeLTRoryFGU23u2/a4gjQUE64rB
    C8xvUoO3uMWOZD2GBxdxaxPFRFapkAbbuw6GcOUuIsbiuTSxhEGf64fnrFrGhvdg
    VeamOtKO9c2MAPSu0JMRxJd3aUbcyYkUOAbnYMvJvm5v0ylBkBmcn9NUXCmtH7m9
    KAQGwIeGfFNMe9SrBci2PDy52RQIV8Fw8qu2l/IFXpVZeMTtDZhLhDy65QruV6Dh
    0tYkA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J/4BgRbx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lZn+h9kD;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J/4BgRbx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lZn+h9kD;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2265FcDxOq3GbE3CudVjnz9BkiY0Ly/5A6rlULX6kqe4WRv0RWuxuU5xyVP9wPdN02zT/WJ8LQ==
Date: Fri, 16 Feb 2018 10:50:41 -0200
From: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: iio/meter: add name to function definition arguments
Message-ID: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
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

This patch fixes the checkpatch.pl warning:

drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
argument 'struct device *' should also have an identifier name...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index c27247a7891a..2362a4a51ce3 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -152,20 +152,20 @@
  * @rx:			receive buffer
  **/
 struct ade7854_state {
-	struct spi_device	*spi;
-	struct i2c_client	*i2c;
-	int			(*read_reg_8)(struct device *, u16, u8 *);
-	int			(*read_reg_16)(struct device *, u16, u16 *);
-	int			(*read_reg_24)(struct device *, u16, u32 *);
-	int			(*read_reg_32)(struct device *, u16, u32 *);
-	int			(*write_reg_8)(struct device *, u16, u8);
-	int			(*write_reg_16)(struct device *, u16, u16);
-	int			(*write_reg_24)(struct device *, u16, u32);
-	int			(*write_reg_32)(struct device *, u16, u32);
-	int			irq;
-	struct mutex		buf_lock;
-	u8			tx[ADE7854_MAX_TX] ____cacheline_aligned;
-	u8			rx[ADE7854_MAX_RX];
+	struct spi_device *spi;
+	struct i2c_client *i2c;
+	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
+	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
+	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
+	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
+	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 value);
+	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 value);
+	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 value);
+	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 value);
+	int irq;
+	struct mutex buf_lock;
+	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
+	u8 rx[ADE7854_MAX_RX];
 
 };
 
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
