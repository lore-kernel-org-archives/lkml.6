Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1675485-1520383459-2-11461726071708125232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520383459; b=fosr6WXuxmF4RYE37FZZgT2UwoyPmoqFVmUhF3ikYvddZFR
    FeeH/WPwgD8FomyWiSnEat6trXvIF2qk+hNHjZniJk86+RpMlZmoF2pbtt7zGXHC
    XrIxY9Qhnvip8tiKH3PreMZ1rK9272THaYxFuPmRv6Wr98mvGsjTQ2ymimU0To9/
    hH3tQV0KO8fsApKWo8WKaWmHwt/WigWiGK+b8NS1hQejucKUq/4d6326puR0qD8Y
    g74v1lAiXfXpjXR/2IrMIthlQN3kzuJKWHFIB3iKQ2woi84i3Ie9OQa+Ygci0E0q
    9tlfyb34XbOo4f4BNDOr2R+YtFoiKjPL8wizN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520383459; bh=u
    4YSCDZmK5F4lq+jgIYCTnwka+zwDNCykKysEpvmxoo=; b=ZzKmz6aYDoF2hCw4Q
    XkDiPP60QhipciqrYH0BXptHaHD8RWgIWG5ZLS+KF6ZwrGJWiNOgWFhVST8ezvFE
    2Pa/AjSRTHKsgIOjk/XPB85F42F+1gr/aKmXgR6l4oJFXJiXq+eHDtsorTVeKV0c
    ThCy2h9NcTYA/NlR2O531mYAXORSIVwPmBdjsVqlcu7Es3XNtp0M5mcj/SSlS8hh
    e6iKOvMfU9FobdLW+fRyohw9BXANPQbwtEfNjZYqfU+Vg6+peohyimT3KR/MqOQe
    2mR8pSeUXy9pvZv7bqEQxy2ky/GeL6qwa4+cdNeOwc9e3F5NvWl/mFO5bcuxrX40
    0gLBg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rLp4smhC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Xhlr+Rkw;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rLp4smhC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Xhlr+Rkw;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtzwDA0EodDpKLUcL8t63U/gOIAup/7VexPMjbyc30fr/BoR1VZFYhicuIMm8tmhRyw1n6l+w==
Date: Tue, 6 Mar 2018 21:44:07 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/3] staging:iio:meter: Remove unused macro
 IIO_DEV_ATTR_CH_OFF
Message-ID: <d22093b4c22f6df9c6efc2e7f711417726719fee.1520382753.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
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

This patch removes the macro IIO_DEV_ATTR_CH_OFF. The macro
IIO_DEV_ATTR_CH_OFF is not required, due to the replace of it by the
direct use of IIO_DEVICE_ATTR in files staging/iio/meter/ade7759.c and
staging/iio/meter/ade7753.c.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/meter.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
index edf26302fa57..5ed59bf30a25 100644
--- a/drivers/staging/iio/meter/meter.h
+++ b/drivers/staging/iio/meter/meter.h
@@ -348,9 +348,6 @@
 #define IIO_DEV_ATTR_VPERIOD(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(vperiod, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_CH_OFF(_num, _mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(choff_##_num, _mode, _show, _store, _addr)
-
 /* active energy register, AENERGY, is more than half full */
 #define IIO_EVENT_ATTR_AENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(aenergy_half_full, _evlist, _show, _store, _mask)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
