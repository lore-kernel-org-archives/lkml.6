Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2640480-1521458300-2-3329566065472384425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521458300; b=HJTFPkmFPL7Wvg6qFs9Sictl9vxjKBEzvM33bsHMIOjPaJn
    blWYuqOLjjTGFPNWhutYRggTk9VM1fuNoqnhuuG6q55r7wpgtotrFV7D0d7Go9VI
    974AfbVZdWxbJCKvewDbGs/7HiCxKIotZkwxALO5xJou9nLLswOLSr8DEyU3LZlq
    yMJWpW4s8ZVFou9owuP7DyB5ogYgwM7v/pN1sRKYZjj9LwY16zJRd9YeDBNN8zmN
    aJh+ZfVwaU1Nb9Go7MIPk7aFch7r5trwlJXCHHFfD9ePJafS724ns6+r3OHv2oyV
    jUBaqJDhLwv6mD6ANUCNPTegJhv04lgRVC0JBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521458300; bh=d
    i31okvjMcEYeobuu/x4GKgJUKxOaSDqsSKimiaMqsw=; b=C1IiyB31Tzx06hPZm
    YfEO3zAbVlMXfnix41m5z+/I2v4lwvsnk6+p2z/hBqQ/uj614ggb+usQN6p2x75l
    nJ7kHIz3Atq8A8lIDTteVu8BsXoiKm3AdXk4DiIelnyumj8uiGbWgzv6c8ZejWAQ
    Zis03JlksGYCyhZqwgFuh9shu1PRVELOpopyCnD+s1OqKQJD+zVuSGvbil/fXBNZ
    vRstQ+XooMBe3Jgjj3zDj3I6/QN3fR+O2N3lekViClNoTQx3IqlgZDIj7KExMvD9
    +ylMMO4Ht9gBq+jzX8pmtR2UK0MCj7XxVGcD9xMF59GGDg5HreApRwn+KvjEUp+8
    eFHEg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddvgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogghpjefjgedufedttgfgvghssehtjeertdertddvnecuhfhrohhmpeevohhlihhnucfmihhnghcuoegtohhlihhnrdhkihhnghestggrnhhonhhitggrlhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefjedpledurddukeelrdekledrudduvdenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefjedphhgvlhhopehfrhgrgihinhhushdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepgeelgeeguceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddvgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogghpjefjgedufedttgfgvghssehtjeertdertddvnecuhfhrohhmpeevohhlihhnucfmihhnghcuoegtohhlihhnrdhkihhnghestggrnhhonhhitggrlhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefjedpledurddukeelrdekledrudduvdenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefjedphhgvlhhopehfrhgrgihinhhushdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepgeelgeeguceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: media: davinci_vpfe: fix spelling of
 resizer_configure_in_continious_mode
Date: Mon, 19 Mar 2018 11:18:09 +0000
Message-Id: <20180319111809.1275-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix: rename function resizer_configure_in_continious_mode to
resizer_configure_in_continuous_mode to fix spelling mistake.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/media/davinci_vpfe/dm365_resizer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_resizer.c b/drivers/staging/media/davinci_vpfe/dm365_resizer.c
index 857b0e847c5e..1ee216d71d42 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_resizer.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_resizer.c
@@ -480,7 +480,7 @@ resizer_configure_common_in_params(struct vpfe_resizer_device *resizer)
 	return 0;
 }
 static int
-resizer_configure_in_continious_mode(struct vpfe_resizer_device *resizer)
+resizer_configure_in_continuous_mode(struct vpfe_resizer_device *resizer)
 {
 	struct device *dev = resizer->crop_resizer.subdev.v4l2_dev->dev;
 	struct resizer_params *param = &resizer->config;
@@ -1242,7 +1242,7 @@ static int resizer_do_hw_setup(struct vpfe_resizer_device *resizer)
 		    ipipeif_source == IPIPEIF_OUTPUT_RESIZER)
 			ret = resizer_configure_in_single_shot_mode(resizer);
 		else
-			ret =  resizer_configure_in_continious_mode(resizer);
+			ret =  resizer_configure_in_continuous_mode(resizer);
 		if (ret)
 			return ret;
 		ret = config_rsz_hw(resizer, param);
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
