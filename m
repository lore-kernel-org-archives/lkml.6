Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA813C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B84320657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+hmCxb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390738AbfAPOEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:04:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39269 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfAPOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:04:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so7066003wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hHXoFUtu+ddd4xxKPygSSUO6RvYAa9FR8CgoDBJzUJ8=;
        b=M+hmCxb/VO4buKAMmDJuWYSvcTKdbOQJxaDQw5p2nqKflYI6twnXR06AbIUwrGAF2p
         gzgHCWoe5Y1lsAnDFoMWAC8IfWkVYfVMdImDd3i+mMmYix8JLtga87XaoM/IZQdg83oP
         /BJsAaUNP4PyMyY1P3aiO4tJmnRua/3PTuwHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hHXoFUtu+ddd4xxKPygSSUO6RvYAa9FR8CgoDBJzUJ8=;
        b=d6Sct8hxA/DPZRsZg6XgbrHcwLNx6AmXNOPqZi85genjPbnosBfziUbndCdzQUAzpH
         eWHP7Xi7DEbqIeXMWdjZKYiNog3ely/dqX9fkH7lm6IZAO0Dc6e3l0A1QPzg9erNEfJR
         Sc6cX+3VjnJlqf/XOOo6iDf9P6Z6B/wuNiA4UhJ2bH9S425nTHaZDKITQYPUxWsk1SDi
         IiLXT6R1QHFOlgQGSODNLgm1ULpUB+gfP9/U+nFTh+Ng1dc+EKnqv61oBIYoHXyQPGdA
         MGagxOE4fgpiP/KMYnCW6stXSwiPLdNg5LT0tsZPlNSuQMKFmpI9MGDu3ozFG1B98PyZ
         7qig==
X-Gm-Message-State: AJcUukdAsxkA+mEUmv8AlpZoQguwrj6bhxw8pU8C3UfMiQ2+OrgS8iUL
        aypOtxBKEGe403zVx7E4eixecw==
X-Google-Smtp-Source: ALg8bN6YtQI2EELIJFf9GvIiOh/nmYLu3rHDpN6vtBhR818pd+E95cUipKwe7T84Wu0ZSIBDVbqEag==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr8098176wrf.164.1547647469209;
        Wed, 16 Jan 2019 06:04:29 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id t5sm38754503wmd.15.2019.01.16.06.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 06:04:27 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:04:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: [GIT PULL] Immutable branch between MFD, Input and Watchdog due for
 the v5.1 merge window
Message-ID: <20190116140426.GF23399@dell>
References: <1547460290-21049-1-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547460290-21049-1-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-watchdog-v5.1

for you to fetch changes up to 28804c2c8fb3401aa4b7f16a883d49dd82f5e377:

  watchdog: stpmic1: Add STPMIC1 watchdog driver (2019-01-16 14:01:19 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Input and Watchdog due for the v5.1 merge window

----------------------------------------------------------------
Pascal PAILLET-LME (6):
      dt-bindings: mfd: Document STPMIC1
      mfd: stpmic1: Add STPMIC1 driver
      dt-bindings: input: Document STPMIC1 PMIC onkey
      input: stpmic1: Add STPMIC1 onkey driver
      dt-bindings: watchdog: document STPMIC1 PMIC watchdog
      watchdog: stpmic1: Add STPMIC1 watchdog driver

 .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
 .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
 .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
 drivers/input/misc/Kconfig                         |  11 ++
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
 drivers/mfd/Kconfig                                |  16 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  12 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stpmic1_wdt.c                     | 139 ++++++++++++++
 include/dt-bindings/mfd/st,stpmic1.h               |  50 +++++
 include/linux/mfd/stpmic1.h                        | 212 ++++++++++++++++++++
 14 files changed, 955 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
 create mode 100644 drivers/input/misc/stpmic1_onkey.c
 create mode 100644 drivers/mfd/stpmic1.c
 create mode 100644 drivers/watchdog/stpmic1_wdt.c
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
 create mode 100644 include/linux/mfd/stpmic1.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
