Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD343C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9146F218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHghWIdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeLSQE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:04:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34524 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLSQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:04:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so7181322lje.1;
        Wed, 19 Dec 2018 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAUcPazIZwM1OnutktLk/uqXZzFMyPW/6RsuxIaDmiQ=;
        b=eHghWIdHJ+NjjhpXisQfhM3d67/F8mAexOkNDBE00gRdvjyZ7/YJjehGqxMt32ohU3
         sO/QXaUWemTQs12nJjBEHtbwUqN715D4m4+GFFiH3auMZR8YrgAnEcW0ovjXp+Xt35uU
         Eqyyq8v9LyEd83076NvYJeyIlSLvS434CikVvIjXQ/MAI+8Oge1R2VEjbyRgEmf13Vb8
         iIzBUdN3uDprrB+Uy8JZLMx4BZKgOkAuV+2j+mVKGez+nlmA8wRdtTKptkpKDfyAKkwO
         8GqUiJl/rdn2CTcGtSrQB3Q4XST393NPDVFvfPJRajKKFKpv3Pl0OyarwmAibx+MF5pI
         9wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAUcPazIZwM1OnutktLk/uqXZzFMyPW/6RsuxIaDmiQ=;
        b=jDEy4el5Qd3wasbazGN+gIQrQVLexKjeqIpdcQqX/OWN238v0XkZuXAxvGn9S88UHU
         VdPEITss0WSyWuhz2VpuHo1tNj5KN66FaiTapxIEVrSxu0h/w46Qog6Bt+RLbBDZC8un
         AMeIiwo4TQm062Ln3Y2KZMnIVpWcbUpvQjKEjG6/LyTRIG99SLEqEwsEKX8lv3m7abNV
         9xmY1YnM5d55ICMe89oKsX4nl8oxNMqQqaZdG5y3qD81T9LNgCg8WRPeojwwiZUtDrJl
         yoe18BmEo15cOhJOU11B9d5lHH3Z9IN87cno1mAMnNWwU9FEhReg0w1j4H/xKo2Dk7nM
         CjUQ==
X-Gm-Message-State: AA+aEWZH2JIFdlcIsIk36KmRm3s5F6bB2uqa0U6LKid37wzkA95wKksA
        +tfGX/l5HkFwpxMe4MWPk3UZZvi9bTsuCg==
X-Google-Smtp-Source: AFSGD/VeNDhvZLGS2jLxCp2f5Be6z8S92etd3HVV4WESVDWzEoFPQGOPJJSh8w/Rbn/uYg4B0uDGLw==
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr6578802ljb.126.1545235465190;
        Wed, 19 Dec 2018 08:04:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:253f:4197:555d:bfba])
        by smtp.googlemail.com with ESMTPSA id i75sm3943979lfb.58.2018.12.19.08.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:04:24 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     inki.dae@samsung.com, krzk@kernel.org, airlied@linux.ie
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/3] drm/exynos: rotator: Add support for s5pv210
Date:   Wed, 19 Dec 2018 16:57:01 +0100
Message-Id: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for s5pv210 soc, into 
Samsung DRM Rotator driver. Currently only NV12 and XRGB8888 formats
 are supported.

It was tested by using simple tool from 
https://www.spinics.net/lists/linux-samsung-soc/msg60498.html

Paweł Chmiel (3):
  drm/exynos: rotator: Add support for s5pv210
  dt-bindings: gpu: samsung-rotator: Document s5pv210 support
  ARM: dts: s5pv210: Add node for exynos-rotator

 .../bindings/gpu/samsung-rotator.txt          |  1 +
 arch/arm/boot/dts/s5pv210.dtsi                |  9 ++++++++
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   | 23 +++++++++++++++++++
 3 files changed, 33 insertions(+)

-- 
2.17.1

