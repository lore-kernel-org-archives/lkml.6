Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39A3208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/IOWY/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39A3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGK6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:58:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39302 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so3173336ljh.6;
        Fri, 07 Dec 2018 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezxIAocllX2vllHzXgiVkOphw6Sa5YczvoC1P1nCBqc=;
        b=D/IOWY/wOIVkmMHEcnXrfSSUkem3G/2b4ROJ5wcsPlcqZ2WDbZbAtOKk9KoZmDkT8/
         AL6iZqhZepdtEY8nQ6lhlm3h/DK5tZTWG0EDsJJNqqnBuVHzYwc8d09H0b3B//UHfq1Z
         s6+NL8OgB4WdjLX8z+MeM8TC6Nm0+aQW+6qm5JVcEZB9Ou6OEZbC2qLHA5pfSvcUAvd+
         aROHGXX1QBIzZrsQuOC5wsnr0aVTwZ4bvg1twduHPmZ4pBMNfaAnt49L4tLj1gEM/Nkg
         13ywFIeJ/8VXFxh2HrKoOOjduccHoA38DcfHq9zc9KaUkmAIqItVb7QBu1ooQoqKJOcN
         k4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezxIAocllX2vllHzXgiVkOphw6Sa5YczvoC1P1nCBqc=;
        b=eea8KjwPSv2PwuiWfX9ZYe4o3Uq1uM1ELQsqThOmag4n2Y4gedzJOfE0Q5fZ3KDSLJ
         Jb8wylVYiEwE4BfdHS3rZhDbEau5cZp4S/5e2wTlGHLfOV0iUMno+UsHNbiz2rG0TZ04
         FycNiizuvzUP3/+zLQarJOGRPNN3xKiT0jbKh7PKyF1Bq/jQgFR3Okv5SMQYCW8eSiLG
         v5y81H1STI0kTfdczLEedT5VT8txOiIVrCIz8RKBSUR5AcP1ylr8qqvQUE1rqkzSK2b1
         HjZ5njSEyKiA/ls0PetIVKz7A8GJkgK+Sf6rjkQVLRCa1kV/cgeWd1kZ7Nfs4vglxJMO
         1BMA==
X-Gm-Message-State: AA+aEWaSwPw+dpsrme5hiTVB68rnVVKqY7GbXN5zbLqXnC634xRNLZe5
        vFUKXGWOqooj4xq3obA0XNQ=
X-Google-Smtp-Source: AFSGD/WcNg21rLf0i9EbhVQaBmcWkTQmVREaeBKNl/5ngtiZq3eCPgP0tZ3Ddj8LyXL6ssr8r7DD7w==
X-Received: by 2002:a2e:90ca:: with SMTP id o10-v6mr1066907ljg.134.1544180299662;
        Fri, 07 Dec 2018 02:58:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:18 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 0/8] Input: tm2-touchkey: Add support for Aries and Midas
Date:   Fri,  7 Dec 2018 11:58:03 +0100
Message-Id: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches adds support for Aries (Samsung i9000) and Midsa (Samsung S3)
based devices to TM2 Touchkey driver.

Jonathan Bakker (6):
  Input: tm2-touchkey: Use predefined device name
  Input: tm2-touchkey: Correct initial brightness
  Input: tm2-touchkey: Allow specifying custom keycodes
  Input: dt-bindings: tm2-touchkey: Document new keycodes property
  Input: tm2-touchkey: Add support for aries touchkey variant
  Input: dt-bindings: tm2-touchkey: Add support for aries touchkey

Simon Shields (2):
  Input: tm2-touchkey: Add support for midas touchkey
  Input: dt-bindings: tm2-touchkey: Add support for midas touchkey

 .../bindings/input/cypress,tm2-touchkey.txt   |   9 +-
 drivers/input/keyboard/tm2-touchkey.c         | 149 +++++++++++++-----
 2 files changed, 121 insertions(+), 37 deletions(-)

-- 
2.17.1

