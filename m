Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A714218F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mo+liTx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A714218F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeHRAqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:46:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35466 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeHRAp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:45:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10-v6so4128669pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Pg36XBKoZm1we4ods0Zzt48tJGC39crqSnN/rNKiVnw=;
        b=Mo+liTx+64UDfw5E5KEIQj4P7PkZAF3rB10qi87fC2K+T4RO3fncI/ty77PP2Nou2q
         1/Osdghe5e2cUG1b5QEBxUB59rIz/WBzqdfBNSVktTIj7AzdVhEjo4vccMwL8lQYvHgP
         4J8ZKrgJO7YuQRZWgltItBec2Cm3VKazC4idM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Pg36XBKoZm1we4ods0Zzt48tJGC39crqSnN/rNKiVnw=;
        b=U0/qXoPtIVeVjqDTG1huYoVdayE+9tc3kw8q9oGxKRvC/UILD7fCvfgAw+O5rL9HCZ
         ycsdo10jGhycwYAaM168CLFfpppB2ZGmJl7xE0YclIkdrpJnVvV9N348mnpePKyy1dBe
         DHfSPcMFAvMM2B6BYwKXza31i5AwpXPOUN8eGrdCQAFVbcRbtyRHecsO+6Bjcc0fJ1bz
         ss21iY//c0fiSoQaPL0Md6VDVsqw6idkGGRt2SnGQzI1lSOj1tH8Cd4bnhQT5m28EKAR
         5txXdOgUBY/zIEh7ovpZ/OckHwGcgc1RQM3RISRtfZVSR42VHakWUGLtsw/ruZPqR/bE
         3krg==
X-Gm-Message-State: AOUpUlECN9pXbBWaysYrYqaPZxQI3QZ0uz16FY5MZZHmpA5sLvalMcIu
        zNT+KS/rZYwIwbmesrF6KNM7QQ==
X-Google-Smtp-Source: AA+uWPxiNsja+mSIIHgjC5xQ6Mvoau0jMoYQTNypxy6WUPxF04yeq7TfjAUGMVohQr3B5Zfc1GAMxQ==
X-Received: by 2002:a62:41d6:: with SMTP id g83-v6mr38048260pfd.219.1534542057272;
        Fri, 17 Aug 2018 14:40:57 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 16-v6sm5764188pfo.164.2018.08.17.14.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 14:40:56 -0700 (PDT)
Date:   Fri, 17 Aug 2018 14:44:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [GIT PULL] rpmsg updates for v4.19
Message-ID: <20180817214447.GB3941@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rpmsg-v4.19

for you to fetch changes up to 00b645e0b4e4a3e5f8d88a4e9acf7e80045c34b4:

  rpmsg: Add compat ioctl for rpmsg char driver (2018-07-30 23:40:23 -0700)

----------------------------------------------------------------
rpmsg updates for v4.19

This fixes a few compile and kerneldoc warnings, allows rpmsg devices to
handle power domains, allow for labeling GLINK edges and supports compat
for rpmsg_char.

----------------------------------------------------------------
Arun Kumar Neelakantam (1):
      rpmsg: Add compat ioctl for rpmsg char driver

Chris Lew (2):
      dt-bindings: soc: qcom: Add label for GLINK bindings
      rpmsg: glink: Store edge name for glink device

Niklas Cassel (1):
      rpmsg: smd: Add missing include of sizes.h

Srinivas Kandagatla (4):
      rpmsg: glink: correctly annotate intent members
      rpmsg: glink: Fix various kerneldoc warnings.
      rpmsg: smd: fix kerneldoc warnings
      rpmsg: core: add support to power domains for devices

 .../devicetree/bindings/soc/qcom/qcom,glink.txt    |  5 +++
 drivers/rpmsg/qcom_glink_native.c                  | 51 +++++++++++++---------
 drivers/rpmsg/qcom_smd.c                           | 10 ++++-
 drivers/rpmsg/rpmsg_char.c                         |  2 +
 drivers/rpmsg/rpmsg_core.c                         |  7 +++
 5 files changed, 53 insertions(+), 22 deletions(-)
