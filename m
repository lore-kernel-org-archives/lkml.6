Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F971C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F065205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549639038;
	bh=SmZ5nefOIB9ZbcGDd64JipZ3QrK+n7/3svGA8BcTVOQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JXFM1cLxfQgpDfzbDdhi6erRm6YRJIhIXdhIaqL+uZA7lvTr7HhuTCn1/8A6MXfR2
	 xrx1mX87faycnZY7e9Sy63MSpQPRXGOi0BpMbVc3S3qjLiDAxrCELPgQqZERUiBqYG
	 s6fx6z9KYelJFHjBmS7c6/uLdTu2U1vMwG9Kd8Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfBHPRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:17:16 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:36417 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBHPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:17:16 -0500
Received: by mail-lj1-f172.google.com with SMTP id g11-v6so3328278ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OshfdMeehAL7UQ62+Vg9895F4/iGtXUhhY9X/D7mr5c=;
        b=tlIXnrZZQwc8wjxmYjvdgZ2sEljKMcEsIYRhRSjIwiMthWP6J73nsTZG223MjMCDnw
         9Lvow7s7UzddUfsaFZIRR8e11heikT8sC686WOhegQVky/KnsmaRAzG/s+zjxdaBIUDd
         z+gn6SEAGPhZ4DXUBzMB0l+SuzhL5l9yV3O2PfAaozG+pyY5O/42ke7P52Mqlp9AJhMS
         ARvWQPEDkMnSK69bhjlOuSrd7UinxGNcjtjLrI3W55R+0YZAnc0Ym8WNMGQ9Sr3HC8DI
         WQmt9mEMYJFe/3/aU2ACNtpk/lwpTFwVJ/Bo1lzbNaj9xFWkXAIkctqoNVZwCIi7fNLe
         n4Iw==
X-Gm-Message-State: AHQUAuaLc9XgmlzPyiFAsOdeEyKYE7FblHz2pd7T3deKgj7GuF306wOT
        DzuqjGTKuubYbJ6CuNmPaZgSqkYH
X-Google-Smtp-Source: AHgI3IZIX3Oq1zReMyNvzStES+7jGUABFDYDpWa9JJtafAAtx5TOU39vrnEzXwoVdB+6GEfOdPvqoQ==
X-Received: by 2002:a2e:4c0a:: with SMTP id z10-v6mr13782833lja.85.1549639033837;
        Fri, 08 Feb 2019 07:17:13 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v19sm421922lfe.69.2019.02.08.07.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 07:17:12 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gs7tv-0006y3-EL; Fri, 08 Feb 2019 16:17:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/2] ASoC: msm8916-wcd: license and documentation fixes
Date:   Fri,  8 Feb 2019 16:16:54 +0100
Message-Id: <20190208151656.26735-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the missing license information to the
msm8916-wcd-analog driver and converts it's digital counterpart to SPDX.

Johan

v2
 - drop the now applied binding doc update
 - switch to c++ comments also for the copyright headers for consistency
   with the ASoC style


Johan Hovold (2):
  ASoC: msm8916-wcd-analog: add missing license information
  ASoC: msm8916-wcd-digital: convert license header to SPDX

 sound/soc/codecs/msm8916-wcd-analog.c  |  3 +++
 sound/soc/codecs/msm8916-wcd-digital.c | 13 ++-----------
 2 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.20.1

