Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520639177-2-2056137219766364072
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endask.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520639176; b=pLA8Hz/6T2/5gnDQ3WTMwmxZZOMivobYgcTkpBB6Z4PUGxF
    dBBTL/Zp4tWGeBZKzR+sHA8AqDGs3l/eFOZvEE2DNVk7k/CIEjR5Db/5FM4wI03+
    o+wNUn6AAwlqnN17o7czjR5qBcrNFn7Kui3jP86t2kwkA74eLpfgWTJrGv+wL45P
    gtSGkxGBPgJvMXiW2Q4pKyH95QrAw3hBsIUu+jabw2Rb28NMl2UCuAknGnQMG7Im
    ZCBBH79Vk2kvwmsv0oPCuBJ8j53Kivyk+912OsTXoTtpOMtptXg4KJCeHovhNU6K
    2DA/Gt4F80MAURdUKzyJsiv6j/8/1e1l4c5Ki6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520639176; bh=z
    K112cqS5MvefbpcZ8DF0LaxAJ3C2+QA5jG+6CpIr0c=; b=E/4KmfJ8NRlOpjwV3
    Qjw01rrixXL42pSaDnLpVQHPQNGdA1+BrR5zUqeErWEIkkDBr03ZJITuXRx66oj/
    Zg5dGIcdoQC9ZRT7dh6gxzSO7TAno3AYg+IWCAiVdewkjjpb2LUu04bUcoFf7QxT
    /qr45Q9cdlUIWAl3p7F64RU9OHoVYtPJ6flqxAeU/gvqslbEGK5HfBwYUPyW/uQb
    haS3dOnA6qP44f0WKe/79SBqSqwdakJoC1Dxbl/bGsJHsPZQ8o/I2iVwesjDn5Dl
    /ESeSFT5b+Z+THNjb2cc4lwnIabN2Er72IZlmFFQXu6aF1C70NNP9bkKBUxuQfg3
    662Ow==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Rqs7wufh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=isklUGhe;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Rqs7wufh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=isklUGhe;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELv2IqYwJGW0ZDks6pT9mtIl9xHYTkW/gA00WRjQt2UjdMZpsy2bfi9Uiv+IJOaUGOx67MYG3w==
Date: Fri, 9 Mar 2018 20:46:05 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Graff Yang <graff.yang@gmail.com>
Subject: [PATCH 2/4] staging:iio:ad2s1210: Remove unused #define directive
Message-ID: <3e7250cc1e99d3cb284e0337fcf4b1188940cd69.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
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

This patch removes some #define directives not used in the code.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0cdcd71e285b..79cb56670fc2 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -35,8 +35,6 @@
 #define AD2S1210_SET_RES1		0x02
 #define AD2S1210_SET_RES0		0x01
 
-#define AD2S1210_SET_ENRESOLUTION	(AD2S1210_SET_ENRES1 |	\
-					 AD2S1210_SET_ENRES0)
 #define AD2S1210_SET_RESOLUTION		(AD2S1210_SET_RES1 | AD2S1210_SET_RES0)
 
 #define AD2S1210_REG_POSITION		0x80
@@ -53,10 +51,6 @@
 #define AD2S1210_REG_SOFT_RESET		0xF0
 #define AD2S1210_REG_FAULT		0xFF
 
-/* pin SAMPLE, A0, A1, RES0, RES1, is controlled by driver */
-#define AD2S1210_SAA		3
-#define AD2S1210_PN		(AD2S1210_SAA + AD2S1210_RES)
-
 #define AD2S1210_MIN_CLKIN	6144000
 #define AD2S1210_MAX_CLKIN	10240000
 #define AD2S1210_MIN_EXCIT	2000
@@ -64,10 +58,6 @@
 #define AD2S1210_MIN_FCW	0x4
 #define AD2S1210_MAX_FCW	0x50
 
-/* default input clock on serial interface */
-#define AD2S1210_DEF_CLKIN	8192000
-/* clock period in nano second */
-#define AD2S1210_DEF_TCK	(1000000000 / AD2S1210_DEF_CLKIN)
 #define AD2S1210_DEF_EXCIT	10000
 
 enum ad2s1210_mode {
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
