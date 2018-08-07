Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E468C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0492170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqZWmCMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0492170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbeHGUWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:22:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40193 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732383AbeHGUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:22:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so14155615ljc.7;
        Tue, 07 Aug 2018 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=caz4zpbrhsxCxjAXbBjsvCQXOktRb8UQQ+3be1uVpjc=;
        b=GqZWmCMUHhd0ldQ6twFzQNRp+2RYHVdgA5qBe2dmAU4Gt7cTBrcmiEnx32wP/7mVz1
         fDp80ncUW/3KTHwx8X3IaJ42pekX4HOnLJq9rrl4xWwTFiUQmlHBgjl9bJMYqUZYW6WN
         PUvsygnVhbn+cnb6k32K4jMrdyITL+jljlD2e6aRQGXMiM7ZQpVBcM6sQZzSE9lWnisP
         0DXa6sXbYMY944n39dd3kxwW2FpUBgsLJHPlYpV4UUfNUNDfzfiokS4eC/FvKrAz3HE7
         1yR31P1qCAtBsmmymBHkWcYe8F2hyXJsxXAQZcmVPg+da/RMWTesLgkBoR0P5xzdPCHg
         133A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=caz4zpbrhsxCxjAXbBjsvCQXOktRb8UQQ+3be1uVpjc=;
        b=lB5nLHjyHuranblX6OTbDOIVcq/05+ReAiVq65mCL52NqfjiRqe9FGTO0ZWJFtOB2Y
         j9uAfgfbAk+6Utxc/rJoy28IMuRuIfzpYQscTOpMOdb3kN04ThMSaDtvM9PwhAynMv/U
         DMyhTiVhHxJYOQc4GhvgC3NH1UI/GOnNt9P3m/qtjFfLEt4Lluei8Sj6g0PD27ASY5R5
         SL5EycYqU0ua269Ds8Rl6ahiEQsdEDsiLlYNRr0u1PJqYaidyr2EZpZOY3wYInGwaEyD
         Wz75FCNXbsiJI+L0yJDiaCC5U6Loo2TB17o2G4r3iDsn8XCpjHj05lAc07+kOZZU4QIh
         q3aQ==
X-Gm-Message-State: AOUpUlHSY+2xaA5sR4GNaZD2j4BgJL9dm65P2vk+f+gzx7hHfnRQmwIj
        0vC4xQQrhdCTsTu1+NEneUk=
X-Google-Smtp-Source: AAOMgpfEA0mUAxOFcB38VEMnQJbZI1mAQelo+md7vkx5c8jbAGMprbDb9jWEpUatTGmpahjqSZgzNQ==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr15947986lja.151.1533665212116;
        Tue, 07 Aug 2018 11:06:52 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id h4-v6sm375922lfj.69.2018.08.07.11.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 11:06:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/2] drm: Add generic colorkey plane properties
Date:   Tue,  7 Aug 2018 20:22:00 +0300
Message-Id: <20180807172202.1961-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:

1) In response to Ville's Syrjälä review comments:

	- Added new "colorkey.plane_mask" property that specifies which
	  planes shall participate in color key matching operation.

	- Added short glossary-comment to drm_plane_create_colorkey_properties()
	  that clarifies 'destination' / 'source' plane terms.

	- Returned "colorkey.mask" property that was dropped from v3, looks
	  like masking is quite common among different HW and hence makes more
	  sense to have that property by default instead of having additional
	  color keying modes.

	- Changed the color keying mode name to "transparent".

2) In response to Maarten's Lankhorst review comments:

	- Added a drm_colorkey_extract_component() helper which is supposed to
	  commonize color key component value extraction code among DRM drivers.

3) In response to Russell's King review comments:

	- The doc-comment to drm_plane_create_colorkey_properties() now
	  explicitly states that "The converted value shall be *rounded up* to
	  the nearest value". Hence userspace now knows what to expect when
	  plane has a 1bpp format.

Please review, thanks.


v3: https://lists.freedesktop.org/archives/dri-devel/2018-June/179057.html
v2: https://lists.freedesktop.org/archives/dri-devel/2018-May/178408.html
v1: https://lists.freedesktop.org/archives/dri-devel/2017-December/160510.html


Dmitry Osipenko (1):
  drm/tegra: plane: Add generic colorkey properties for older Tegra's

Laurent Pinchart (1):
  drm: Add generic colorkey properties for display planes

 drivers/gpu/drm/drm_atomic.c  |  20 +++++
 drivers/gpu/drm/drm_blend.c   | 150 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c    |  25 ++++++
 drivers/gpu/drm/tegra/dc.h    |   7 ++
 drivers/gpu/drm/tegra/plane.c | 156 ++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h       |   3 +
 include/drm/drm_plane.h       |  91 ++++++++++++++++++++
 7 files changed, 452 insertions(+)

-- 
2.18.0

