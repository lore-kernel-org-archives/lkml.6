Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E23C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7132084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYAasLbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7132084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeLLMb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:31:26 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38931 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeLLMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:31:26 -0500
Received: by mail-lj1-f171.google.com with SMTP id t9-v6so16112031ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oM7AeCHhjJOAyr8ADYL7ecfUVGQgyXPwClZKi4GtDW8=;
        b=VYAasLbdR1Umx0nfjWCo5OFRQFOcBq0mXFaR/2u29geb44g3Kfz6mM3GZ6gfiK1Nr0
         y+j1E/zwbrPoL9+wuJm5zU2R6JRi4D7k7z2U+XWLNAc9CHko1RP/JAjHmyRgju/FsBI7
         ytEl1J5Qb6amIGub3aw6myGAo9T7cWVZuxOzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oM7AeCHhjJOAyr8ADYL7ecfUVGQgyXPwClZKi4GtDW8=;
        b=VxBc+4FrTL6N9wQHzpRK0yG++rHEoXmpYRdW9mXOlh7rEA4sk8SKPrU50JOZkMzXyr
         s6obk3dsnxxmb/c9vMgwtakgcfsNxKEQink283F+K4CA4TD9XgqYSm2uHpErVmo0iQTu
         VzT8/7thxT2NsPTMRIZoS3KDGfTIiSVB1uf69T/QMdWGUGfmM14fTKxtcBUQ46ToD4qr
         GJr6HPZsU+vqvJtvt1eMEPgoMTdI/PSj/XG7gAB4IBw9OkwqJM3cHrZU/IAM6fbI2u8d
         EdFz+qjzSHjyBz+lAuk/+V4x4M2BvmdOrmtEERszGPgrKePsFqNlBTUMBcNleAjPD/cA
         rPwg==
X-Gm-Message-State: AA+aEWaBgm3Bz/VxoX9PQ7P7cHdtl3CBE+CdLQm02Lw5UXsRCH7z+Mxk
        sdP3E7b1jJgMnjF6hPeEh3InGA==
X-Google-Smtp-Source: AFSGD/U13KJTbQxjOoRnRRkThFeeVYy1ZFk2VlxuDAH+1wCk29DXz2pMsTF584un44Cyb7GR4GXUPA==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr8517354ljd.140.1544617883987;
        Wed, 12 Dec 2018 04:31:23 -0800 (PST)
Received: from jax.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id n8-v6sm3511302lji.90.2018.12.12.04.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 04:31:23 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:31:21 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee subsys for v4.21
Message-ID: <20181212123121.GB29450@jax.ideon.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small OP-TEE driver enhancement. A friendly log message
is added to inform that dynamic shared memory is used when initiazing
the OP-TEE driver.

Thanks,
Jens

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-optee-for-4.21

for you to fetch changes up to 3c15ddb97c77f34ba009910becd5921f169770a2:

  tee: optee: log message if dynamic shm is enabled (2018-12-11 14:38:40 +0100)

----------------------------------------------------------------
OP-TEE dynamic shm log message

Adds a log message in the OP-TEE driver to inform that dynamic shared
memory is enabled.

----------------------------------------------------------------
Victor Chong (1):
      tee: optee: log message if dynamic shm is enabled

 drivers/tee/optee/core.c | 3 +++
 1 file changed, 3 insertions(+)
