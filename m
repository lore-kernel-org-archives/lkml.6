Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4850CC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5F921904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549558728;
	bh=v9UpdsszQFQKCPth2MY0qUv8lWUqs20RrGyH5nV/ONk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dOUB6vDCGY/AHHPkkMFjXyvcRW+JzT5x87ut7rlQBefJ7TVvSoAV7bmGFjtHEBTL2
	 WmNILxGdzGtRs1SmkOPpKRoxzlmguNWLZwZjUP1MEUOezPY2nHivjfO+WSbDAetZDT
	 rCsdKdL+v99tgn2bN2kzw/lnQrgBvgt0X6U91F38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBGQ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:58:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36809 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfBGQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:58:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so503901ljk.3;
        Thu, 07 Feb 2019 08:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqcU75ldcuRtguVybVG75+enZLpopE9EivxnZdSmaUo=;
        b=AmBSctuWFE0n8b1naeJLiI5TYUNahaQqwgWmxDNwRcd/nAYDESpLaRsY2kNcz+5Jj+
         ba6chWaiCbtAbkQOCjVwckOVrM/RxKGD/tjevrqV1At5oNY9vAdABxIpX2YFAFxMV/RB
         TX8Pg715sk1MlZ91R06h4Z6H83W2yZMHsOsGR599bvuI1NYrUmYoKhxojncUSIuVQ8H+
         iah4MKbdKPNzocZE59onTG6bj2sEZ87DRzNcPbSnBFhr+CeZZV1ZjPDV2XW0GwSM0cgf
         NjO9CwIw4ajl2JIXCdqgW92fxE9M5pHExPKkvVvg/ioZ0Ldto4v8++U4RMElX5HPjVz0
         GqFw==
X-Gm-Message-State: AHQUAuYKXjqTJ+us19hJjFWc6C++FXkMW5Fv3GTSA/AgX3jdjVsai4TO
        QMfrjsbklXKLGr7ymn6hafM=
X-Google-Smtp-Source: AHgI3IboJ9mdsrwBG5JJkkvlI+kGok6NFkbSqSzCiqp3ovtZzH8dY44+2l44qd8b6ZCosbBFViVriQ==
X-Received: by 2002:a2e:9f0c:: with SMTP id u12-v6mr3482713ljk.178.1549558721167;
        Thu, 07 Feb 2019 08:58:41 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m21sm4987258lfl.97.2019.02.07.08.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:58:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1grn0Y-0000Pq-1H; Thu, 07 Feb 2019 17:58:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] ASoC: msm8916-wcd: license and documentation fixes
Date:   Thu,  7 Feb 2019 17:57:52 +0100
Message-Id: <20190207165755.1548-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the missing license information to the
msm8916-wcd-analog driver and converts it's digital counterpart to SPDX.

Included is also a fix of the binding example for the analog driver.

Johan


Johan Hovold (3):
  ASoC: msm8916-wcd-analog: add missing license information
  ASoC: msm8916-wcd-digital: convert license header to SPDX
  dt-bindings: sound: msm8916-wcd-analog: fix example regulator names

 .../bindings/sound/qcom,msm8916-wcd-analog.txt      |  7 ++++---
 sound/soc/codecs/msm8916-wcd-analog.c               |  5 +++++
 sound/soc/codecs/msm8916-wcd-digital.c              | 13 +++----------
 3 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.20.1

