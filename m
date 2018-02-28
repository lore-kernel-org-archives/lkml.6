Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519832325-2-9939701017882587174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832324; b=Km4fkiD2Q8go+lhay3BKZcTqYxC5HEdxc4WRG38q12EAYit
    IAbfRtP5WfruEVkd8xzdTQFFF4TLgzAWqUndWF14AuH17eris3uywt25ututwM8n
    ibcN1tPy50z3+dCOoOJcctMvUcfObgi+M1GjW5t9FHW/sBYzCfC7VaS6lTVOvUxz
    gOl+sMdELhKa4fktvSvZPUL9d4yM40u3H09DbsmkrjjKv9LNPKWZouw4kumQqsG8
    VRzUXreAucxSX3e8My0zpO8D2Ed6mFAWK/GVhixwcV2+UVRdmwJkFAHZMDplIsPR
    BoGcki8X9hHokdlk4DTqi76zRPBUD/JjoEKzKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832324; bh=5bdLjTTapBrJzI81dRL
    dAbWsS5MqGovfV1dU/ucfk08=; b=WWYHbIPt742kFdMDu/fQm/Hb8l0rL2VUAll
    yVjmDN+zsjPV7tKu9NnRQiOL+STtpAzYBt7U9aQTuW7L2i6+jWchMKbHPVGFAX2S
    nPVMYnrgN/UHWfcqwewoTp0etD6J/p0QYiVB3WYaIiUJDYW649o3DLEPG6cX6O1R
    oGHOxv7Uwc+UtZ9tapu6mgxXZIKImXsgoelhc4ZbwwHlawxBjxuGz9T7yD5J7YSA
    eBPklGrGuVHK/m8C4En3jIfuHbjfBsEfXkAlW9QGiNa5TcO0qOhHWtHa6N+F0HzL
    qYLuIvOn/ptHU0a4Sj3+hMO30wh/QMxF+vI7iIDjBZb1xiomvwQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeB1Pgk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:36:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33293 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752773AbeB1PWe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Douglas Anderson" <dianders@chromium.org>,
        "Jon Hunter" <jonathanh@nvidia.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Brian Norris" <briannorris@chromium.org>,
        "Benson Leung" <bleung@chromium.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.672675594@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 036/254] mfd: cros ec: spi: Don't send first message
 too soon
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

commit 15d8374874ded0bec37ef27f8301a6d54032c0e5 upstream.

On the Tegra124 Nyan-Big chromebook the very first SPI message sent to
the EC is failing.

The Tegra SPI driver configures the SPI chip-selects to be active-high
by default (and always has for many years). The EC SPI requires an
active-low chip-select and so the Tegra chip-select is reconfigured to
be active-low when the EC SPI driver calls spi_setup(). The problem is
that if the first SPI message to the EC is sent too soon after
reconfiguring the SPI chip-select, it fails.

The EC SPI driver prevents back-to-back SPI messages being sent too
soon by keeping track of the time the last transfer was sent via the
variable 'last_transfer_ns'. To prevent the very first transfer being
sent too soon, initialise the 'last_transfer_ns' variable after calling
spi_setup() and before sending the first SPI message.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
[bwh: Backported to 3.16: use ktime_get_ts() and timespec_to_ns()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -347,6 +347,7 @@ static int cros_ec_spi_probe(struct spi_
 	struct device *dev = &spi->dev;
 	struct cros_ec_device *ec_dev;
 	struct cros_ec_spi *ec_spi;
+	struct timespec ts;
 	int err;
 
 	spi->bits_per_word = 8;
@@ -379,6 +380,9 @@ static int cros_ec_spi_probe(struct spi_
 	ec_dev->din_size = EC_MSG_BYTES + EC_MSG_PREAMBLE_COUNT;
 	ec_dev->dout_size = EC_MSG_BYTES;
 
+	ktime_get_ts(&ts);
+	ec_spi->last_transfer_ns = timespec_to_ns(&ts);
+
 	err = cros_ec_register(ec_dev);
 	if (err) {
 		dev_err(dev, "cannot register EC\n");
