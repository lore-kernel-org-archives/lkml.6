Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B793CC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815F22086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IImAnO6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfASJBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:01:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47005 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfASJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:01:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id y14so12171919lfg.13;
        Sat, 19 Jan 2019 01:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yww/q1jFw3l6TVcJi8RYti1Nuo+2WwuCQ/8CHa9h/xk=;
        b=IImAnO6ZZMTWiEbSRkqx9BNmmB7fObKCe72pn8iHCLVUYAzjcmQ29P1an97BXEkIZc
         LcrCMyXNBA2ZVV8JP5C/4qHXoAtJazqZA3TkVooMo/vf/HvaMK6gXcu9yChB+L+okfmS
         DVeX83vvr47ixU5Zy9CvU+YG2YGDIl92ac95YwDFL9frmIaxB3L9XmFYmYssv5pVWXJf
         ujiwa7/YH3mxi+hqOk6boOYDq5dGxzvpdV/3lbPXekUDJwlqMFsV5CoTY0ivo9nykOa+
         mWYgZuvdzxfsyQ9y8xc+loL6Kx7oTk7dNM5DlTP2EZ3glWWVvmbS/5xuCWIko4xzC0uR
         z+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Yww/q1jFw3l6TVcJi8RYti1Nuo+2WwuCQ/8CHa9h/xk=;
        b=VSK2N8sawOIgEGnFEsLcTWIJjYqvazHv0M0v5UKF2l4ppRCkJU1ceTmfTYb8GZcAV6
         QDwswoxQrkCwPoz65EoxZVUxCrFlplpeAqu4HP5ByXQUUrCrKCj+IaubXnlXvTSj5w9T
         R+dSnF/A5f+8HFC//eCdAXRRTpjVf3bASLfJHFiiFO1W1/mL3iZTy77CHcu/xdA5f+kT
         GfdKLabKRH9bS9uRCv9ExKWd099kN4q12rl6xlLtkTI6YnshHPbxm/aXm2+YxdrJSWNj
         dWcKZZ6V6i+o1KJzIQZwOAMB7xLVySiSzHQkNVYUuVy5yT0kHMKbC7RlRb6BASV/uAtL
         ASjA==
X-Gm-Message-State: AJcUukcjTlUPCeaZ8eBHAaYjxU0YqTn02vF6rf3yeauhqAWL5FLQ3i+c
        taNjtpZDWEeYJNVuhF1dPL4=
X-Google-Smtp-Source: ALg8bN6aWa3Zvf92+23UEemYuBgYau3IsAgzLgIWadqrHPgoGkCyt0AOqa7jBcS4rxM6MO0AwY9tTw==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr15234796lfe.63.1547888460683;
        Sat, 19 Jan 2019 01:01:00 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1254995lji.45.2019.01.19.01.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 01:01:00 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 0/6] add quartz load support to NXP rtc drivers
Date:   Sat, 19 Jan 2019 10:00:25 +0100
Message-Id: <20190119090031.29147-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respin of patchset on top of v5.0-rc2 with feedback addressed (thanks!)

Introduce a new generic property "quartz-load-femtofarad"
to specify the quartz load.
The default value is selected to match the current Linux
drivers, so there are no behavior changes if a binding do not
specify the quarts-load.
The unit is femtofarads because several RTC's define the quarts load
in steps of 0.5 pF.

The two drivers rtc-pcf8523 and rtc-pcf85063 are both
updated to use the new binding.
Previously pcf8523 hardcoded the quartz load to 12.5pF, and
pcf85063 used the reset default of 7pF.
With this patchset it can now be specified in the DT,
if the defaults are not OK.

The patch-set is tested on a proprietary board for both
RTC variants (v2 variant only as there was only trivial changes in v3).

	Sam

v3:
- Document generic property "quartz-load-femtofarads" in rtc.txt (Rob)
- Fix indent several places - ups (Alexandre)
- Use the simpler name "rtc" in DT examples (Rob)
- Collected "Reviewed by's"

v2:
- Introduce a generic property "quartz-load-femtofarads"
- Add femtofarads to property-units.txt
- Make the changes backward compatible
- Reduced logging
- Warn, when we continue with a default value
- Tested, by Søren Andersen, on real HW
- Rebased on top of v5.0-rc1

        Sam

Sam Ravnborg (6):
      devicetree: property-units: Add femtofarads unit
      dt-bindings: rtc: Add quartz-load-femtofarads property
      dt-binding: pcf8523: add xtal load capacitance
      dt-binding: pcf85063: add xtal load capacitance
      rtc: pcf8523: set xtal load capacitance from DT
      rtc: pcf85063: set xtal load capacitance from DT

 .../devicetree/bindings/property-units.txt         |  1 +
 .../devicetree/bindings/rtc/nxp,pcf85063.txt       | 18 ++++++++++
 .../devicetree/bindings/rtc/nxp,pcf8523.txt        | 18 ++++++++++
 Documentation/devicetree/bindings/rtc/rtc.txt      | 18 +++++-----
 drivers/rtc/rtc-pcf85063.c                         | 39 ++++++++++++++++++++++
 drivers/rtc/rtc-pcf8523.c                          | 28 +++++++++++-----
 6 files changed, 106 insertions(+), 16 deletions(-)
