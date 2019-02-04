Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D3C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6962214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOdGPWmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfBDI4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:56:36 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43294 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfBDI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:56:34 -0500
Received: by mail-lj1-f170.google.com with SMTP id q2-v6so10828707lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 00:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hLZSdf+huKW5dk/MnY/yKzWtbwn39zq8nIfDIBeCUto=;
        b=aOdGPWmJHU8ok5sydy5afbjZMQydKSEyxhOR4CyGcp0iVBEkJvuHkKNKviowz8lS6F
         LAZoT3cDdA18tWxt8VcWqv5Ub0V8y5NxcD1jg3RXa9q2PtNCwNBY7AZfJTPXxDui7MU9
         LiC//X1DK+J8ZUwB1PmMw/1II5jI9DlEfYF/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hLZSdf+huKW5dk/MnY/yKzWtbwn39zq8nIfDIBeCUto=;
        b=jF762y+pnjbF0xfF4CGWOX27GdQAjcXQWmp3+WScWwp1M4oXbFuYasy1hYO9MMJ319
         Qel8kBQZ1IKaofTsH/c+x6H3xDMOvn9Xt+HNA+DBItqbuQFZS+UU3dLxdCdhFN0MoEEA
         VpCcH4Tbt0vYxTqWOy/tnDF+vXYTEbpzkcyEYySX7WpD3Dk/y8SEe+NEc0kKHDvZLbPv
         fewGqUgwoRnxGA6SsY0NgXKSGvOCVX4fQ5MpjNpkCTX9BwG90eVUeoPOUavf7om3ZJen
         yVjs+9eJvrUR+Z1QO5BghXUfb1Ye85b/SYBh+B4GbTyrecUahmh5b3kQc9da8zJzlI7J
         0zUw==
X-Gm-Message-State: AJcUukfwfP44jVf4rlxiQ4TO4ORnCfmYD+f4F21asToSghAZ4UwtNFhg
        Cu1S+5nPoHBSnPRBTn+hAWhv7g==
X-Google-Smtp-Source: ALg8bN4aQBbTsF3jHkNXIQLqygVQGbzHuJKyX2DaL28aKeSCqzWUFbqZO++T+HJ/AUy8h9MNQZ4VLQ==
X-Received: by 2002:a2e:9d8e:: with SMTP id c14-v6mr41075705ljj.146.1549270591801;
        Mon, 04 Feb 2019 00:56:31 -0800 (PST)
Received: from jax.urgonet (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
        by smtp.gmail.com with ESMTPSA id c77sm606778lfe.23.2019.02.04.00.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 00:56:30 -0800 (PST)
Date:   Mon, 4 Feb 2019 09:56:29 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee subsys for v5.1
Message-ID: <20190204085629.GA14098@jax.urgonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this TEE subsystem enhancement. A tee bus driver framework
is introduced in order to support an OP-TEE based RNG driver.

The last commit makes changes under drivers/char/hw_random which
also are acked by that maintainer.

This time I've relied on others to review the bus driver framework.
Please take an extra look at it if you can spare the time.

By the way, I've just renewed my PGP subkey so you may need to refresh
it in order to verify the signature.

Thanks,
Jens

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-bus-for-5.1

for you to fetch changes up to 5fe8b1cc6a03c46b3061e808256d39dcebd0d0f0:

  hwrng: add OP-TEE based rng driver (2019-02-01 15:12:46 +0100)

----------------------------------------------------------------
Introduce TEE bus driver framework

- supp_nowait flag for non-blocking tee requests
- The tee bus driver framework
- OP-TEE TEE bus device enumeration support
- An OP-TEE based rng driver

----------------------------------------------------------------
Sumit Garg (4):
      tee: add supp_nowait flag in tee_context struct
      tee: add bus driver framework for TEE based devices
      tee: optee: add TEE bus device enumeration support
      hwrng: add OP-TEE based rng driver

 MAINTAINERS                        |   5 +
 drivers/char/hw_random/Kconfig     |  15 ++
 drivers/char/hw_random/Makefile    |   1 +
 drivers/char/hw_random/optee-rng.c | 298 +++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/Makefile         |   1 +
 drivers/tee/optee/core.c           |   4 +
 drivers/tee/optee/device.c         | 155 +++++++++++++++++++
 drivers/tee/optee/optee_private.h  |   3 +
 drivers/tee/optee/supp.c           |  10 +-
 drivers/tee/tee_core.c             |  67 ++++++++-
 include/linux/mod_devicetable.h    |   9 ++
 include/linux/tee_drv.h            |  38 ++++-
 scripts/mod/devicetable-offsets.c  |   3 +
 scripts/mod/file2alias.c           |  19 +++
 14 files changed, 622 insertions(+), 6 deletions(-)
 create mode 100644 drivers/char/hw_random/optee-rng.c
 create mode 100644 drivers/tee/optee/device.c
