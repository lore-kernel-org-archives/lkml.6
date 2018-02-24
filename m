Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-803568-1519459166-2-9707365196017725085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519459165; b=VCxZX4zp6wjt8tA/VCWhViX42hExutehdG63QKmkpTBKEHN
    vQDvjDSU/Be0tboo3GB/8bMgLJHQ8k/7MuNRq6Es+YUoRA4tlEbktklbWkxF7OW+
    KzeaNykH0xPA9g56qTBKChGympfO5sw/zx+IQSUFEUYgNxKY2IEFQPnQ0iqiVb9f
    9fMC4veOxZTUJy7jJZp9aDMxCzUVyUHX90XvC8xRTkUEcchJTAxWiZfggIqK7iOd
    as0fyffPN1q3l/Es78LNjS2IQzA19lLcf+C8JcXAvzmweethFIyRUNdh49LmUn2s
    Mt5M92MyVclSIasJOpz0/JZwvxgAeM9ETrtuhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519459165; bh=x
    2H2SEHRZO2KJKhnXs6EdRsOzQHyn6FEkOfhrIQZDzk=; b=qXGY45gbShbpasSOJ
    gPyDYCvq1m0U8bWfV4vKSwGrbtErM3l/PkJVpwYxBP6Pu4IkBwUjZdDj1DMN508Y
    PyPx3bBVynOJulH2TPc8cz0KWPl28FGDnF6s4CBEzBR9bRojmoSkjgoOjpmwGgPo
    9XljJ0fdzJGX2wQDGhggSVGh3C3waOh4aBDauLmY9Q+O+RBr0KBoGh+xveHGXuAC
    XbCtUiZQdhnpbv55vmyf4TJCGebNNdewfxXqAoU1JZ/x3KtO/+rBiYtjtD79xk5B
    685TNvtyrNqbUvyS6ReQZkSQTay3uT8cIMb9QcZU3gwyiR45WSvsI476LnDOiyDE
    LuZxw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com
Subject: [PATCH 3/4] staging: most: Remove unnecessary OOM messages.
Date: Fri, 23 Feb 2018 23:58:34 -0800
Message-Id: <20180224075835.11618-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180224075835.11618-1-quytelda@tamalin.org>
References: <20180224075835.11618-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:wUNY6SdarZ55oCTRGXR4WH5SD8hr3jLxTD2rpJ4LoQCEGJGAcqK
 sWzHto0Uv6vEijuMMLaMCmVbF8B7Dzd88Las2n5t9h9h5igM/IL7DHa1yCTJkyYxi6S3T67
 suxh1Ksn8GGaihgGY2auaDsoxBN+IC+xK9G9SQhLLCWHLcP1PIqpoKjViXRBZCDxqqPLCX7
 PCnAFP23X4YsvBj4WBPAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z7HDrraEC/Y=:yB2ShG64hmatvU4DXP2Vd4
 3hamPzpiWDHvqTepNiAwpbMOVxo/QboJcC41yaqaG2l6bscJsg5aTq1T9EDXSe7fnptckooRf
 Z55KdzvrFuev2KnZqtMjqaqcBkhtakhqw3+0Atp4UgjY7KbyRwYuAdpO6JGSyQREu+UgbtsX3
 v2d7IhFGpwsOTqPs2UEeGgwgMEOYRBf9uk+BGd7V6LbbgwESsgGBl0oVP0vC6DVQ3G8qpliBE
 dacKTvWDbGY075bbdsAcGZnXtSJk89HayqjXK7rdlpd1d+qm8IizUDeXL/kRECv6wLh01VVdM
 pQqUjWuEEKGNDZlLNwEHewqmgfRiQrPh9XKJwnx+HrutEk0GKCHrLBIaOuwi5dXMeHwCjSupn
 QW2cvTpMtzkZUBQvwdYDZ454++YsI/68oiVS9pn8VzufFjEeGy1saoGLA8uudbO6U+NYdTU+d
 q+zlsJopt7KsbkHoH6h+TCUYsQ1upidOMiFb+YONSus6NLiURDAigWdVoa29FATmxxSbq28ZV
 cWFqCnNH8NyHT9WlqtPWUH9DQTj3gw0LEk+Zr00jSMxWcchi50zW++U5lknCqRl8kqqw39X7S
 NSvcpIO4KP/k17LLTOsIlsVbca2ySzNvBHOQEYP5VEHCBi2ZnPDVnj/dK2QVsyvVlVFI918h1
 6w4LzR0fTs+WPq+sXj45JNRROEa4uoRxYVW8bnXlYNxau98IZx0lbzl5B2YOPWPVrPRIMXiW5
 gyPELCw0yD1tlRihlq612xVCLAvxe2GYmOu3Nw==
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
Cc: devel@driverdev.osuosl.org, Michael.Fabry@microchip.com,
 Quytelda Kahja <quytelda@tamalin.org>, chris@engineersdelight.de,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It isn't necessary for the driver to log out-of-memory errors, so
these have been removed and the functions simply return -ENOMEM.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/most/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 3f65390a6e17..b8792d70db8b 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -1210,7 +1210,6 @@ int most_start_channel(struct most_interface *iface, int id,
 		num_buffer = arm_mbo_chain(c, c->cfg.direction,
 					   most_write_completion);
 	if (unlikely(!num_buffer)) {
-		pr_info("failed to allocate memory\n");
 		ret = -ENOMEM;
 		goto error;
 	}
@@ -1389,7 +1388,6 @@ int most_register_interface(struct most_interface *iface)
 
 	iface->p = kzalloc(sizeof(*iface->p), GFP_KERNEL);
 	if (!iface->p) {
-		pr_info("Failed to allocate interface instance\n");
 		ida_simple_remove(&mdev_id, id);
 		return -ENOMEM;
 	}
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
