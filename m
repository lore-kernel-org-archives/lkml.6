Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520639198-2-4761850970034212530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520639198; b=nEg/YMPaBY5SIYMNyKEMv3EubMWawhs13WhYCEprljABnhz
    0/vGOx256oXuV/zdnEA6EBUAaumr9jMEEuYNowJgQJ3yVmO0uPPTwe7Jdl56O59L
    kTSUnET+VpqnIJo6S2+qilddnRBL7BbHTX4c827EsG4UsDM7yHdwtL9XFwkgrkAV
    h2UsxtCOH0HTbt+5Li1Q4weHNGamjdV5bhZc+QW5alApyRCfShlCQcN7dEoWJ5nk
    MYvhRsQRzFDgO/a6j4xPTemho1jsEFyNOJcfJnZ+Ez3A2sauMIUzgjREbdtsKg/G
    KWzAPotVhu3WQZ68KX8uFe08KjiZCR4YJMheJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520639198; bh=v
    gEWifsmLfvIaMVue/rTVOwqM8ipSiZ7MPxrUs8Rxec=; b=U1dMIUFJnnIJClPne
    Pny3/9cCKmdQBeoVXmYcEwmEaoPBKK7z2344wExf3m4629584/3cwzGpVbMQq+xY
    LA4BmcTSG1TboAaeYfMWFaDD6G8sDDFjwqnKfcv0gXKmB089nXZmoD7FujCqQwgO
    XGendRdtpzWK79Vx+lebb+8IC05fttNZabCQ84CycVxnW5TGFdTKj0ICA/Fj5oTv
    SIFt0MvtACXgDWNMi6oG5s6eJyW7GRcv3VeJDBy/ELw6kRSbn2qYhmp4B94Utmrq
    m9GCRfFBOtL11ot5Y1vrUCx91XEBGURsgzZm9efQ7peeyKJkTu6kUMRkShh9P/Nz
    XkFyQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Xkk5O6oo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nDbss6KB;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Xkk5O6oo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nDbss6KB;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELslSOzxPS3B89/R/3gz1UJZgj7tvOnDJJWV7GbxgFut58ICtBGer948MoCKwTu/jVmLPIFkLw==
Date: Fri, 9 Mar 2018 20:46:25 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Graff Yang <graff.yang@gmail.com>
Subject: [PATCH 3/4] staging:iio:ad2s1210: Remove old_data from ad2s1210_state
Message-ID: <c622bde87a9e1ed5ddf89b999231c69579b7d2e6.1520638889.git.rodrigosiqueiramelo@gmail.com>
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

The variable old_data is a bool type, which only receives the value
'true' in the function ad2s1210_config_write and ad2s1210_config_read.
There is no other use for this variable. This patch removes old_data
from the ad2s1210_state and from all the function that use it.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 79cb56670fc2..ac13b99bd9cb 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -76,7 +76,6 @@ struct ad2s1210_state {
 	unsigned int fclkin;
 	unsigned int fexcit;
 	bool hysteresis;
-	bool old_data;
 	u8 resolution;
 	enum ad2s1210_mode mode;
 	u8 rx[2] ____cacheline_aligned;
@@ -107,7 +106,6 @@ static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
 	ret = spi_write(st->sdev, st->tx, 1);
 	if (ret < 0)
 		return ret;
-	st->old_data = true;
 
 	return 0;
 }
@@ -129,7 +127,6 @@ static int ad2s1210_config_read(struct ad2s1210_state *st,
 	ret = spi_sync_transfer(st->sdev, &xfer, 1);
 	if (ret < 0)
 		return ret;
-	st->old_data = true;
 
 	return st->rx[1];
 }
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
