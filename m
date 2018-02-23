Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414229-2-15964984379689183259
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414229; b=UmZ+ndCRxVuHKiJLYn8AE8ejdZoEiei+8biQ/hM3ANk7IoR
    vs07MKkrSl1k+hhw1k+wDfe5tcFHj9HhTTjWWJSc6sfyuW1b1LSzOpOJf841GjLB
    +Xktc7SI/naBPgZL73cRnMHw3b9GsKIslDp1OTSoBHEqlckLtIfLSyv49CV5Owur
    uZEp2IsV4L+rpTOTpgCw7bYvDQJo7eN+3ryF0pYGAhTOTsoWNiuAFWEAyLlH1nTn
    W+bM6WKXaadkrsc755dg0xbGq6Ou+UwtNl7fbXUmO5f0uxwyTua8pkydg7gS2gT8
    5R7C3KHdtwU8+DnDUDaUUFyQZheMeU3Euj2z4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414229; bh=deub3poQHP66lcC5/bR5yeiUUv
    zKAWqaufY2KsyVBLw=; b=Sn/U13qqutgpiy6DxVzn943FKuqJuqw2UFHPpDeonV
    8aO2eYj0e1pIBAySx/PtZ1MXLTWpNhqs2DYnGI5k4yllH2keUDm0XOWzbHJxENYD
    GZJTV+28yUOLjeNBn5MoNQfVUPDHXvaG328gs8MLKhdAEhNZypm9anNHIt2M3Izj
    DG0AdpRqe5mumT2GIfU1fufl2PqmO6XH7S1V+2Dyk7/06GcVMmDU1vnOFKY6vWEx
    i3mZLqpyMzE+KgWlgUcmKVRU5GuUjPJ/JY8+T6cO1WGZObaKKtg491lUXZUAZg/k
    lSqt9vnEGueGhbG442TemYmREKF5G+6QlBqJa7fztudQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeBWTaG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:30:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935019AbeBWSvq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 057/159] staging: iio: ad5933: switch buffer mode to software
Date: Fri, 23 Feb 2018 19:26:05 +0100
Message-Id: <20180223170750.533009651@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit 7d2b8e6aaf9ee87910c2337e1c59bb5d3e3ba8c5 upstream.

Since commit 152a6a884ae1 ("staging:iio:accel:sca3000 move
to hybrid hard / soft buffer design.")
the buffer mechanism has changed and the
INDIO_BUFFER_HARDWARE flag has been unused.

Since commit 2d6ca60f3284 ("iio: Add a DMAengine framework
based buffer")
the INDIO_BUFFER_HARDWARE flag has been re-purposed for
DMA buffers.

This driver has lagged behind these changes, and
in order for buffers to work, the INDIO_BUFFER_SOFTWARE
needs to be used.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes: 2d6ca60f3284 ("iio: Add a DMAengine framework based buffer")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -649,8 +649,6 @@ static int ad5933_register_ring_funcs_an
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &ad5933_ring_setup_ops;
 
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-
 	return 0;
 }
 
@@ -763,7 +761,7 @@ static int ad5933_probe(struct i2c_clien
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad5933_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
 	indio_dev->channels = ad5933_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
