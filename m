Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA84BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704C0217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmhZL6g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391083AbfBRRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:22:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46238 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfBRRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:22:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so19947086qtm.13;
        Mon, 18 Feb 2019 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKlhuD7R0WkRQ8r9+a4cSAG6VdZm70kh8u647eLl2is=;
        b=CmhZL6g+XGqqTyEtMWlNiSrk4ektfxZV5t7vNsot102EqrU520R7PTqJT0UE0pcEGL
         rtzMs91VaIPUylYWm0cqe7njsBJTJmbNUwbD9IDvEKpcehO4T5AGuI1w4yIaJ9uMlUmX
         Yiliz62BorMnObi1WS0dxaVrTDbt1rRMS1PzUlKfKkiIxKvrTfCm6Gfm29fJ3KmO+REW
         YSF8Te6hI+imGfRrTsy4E4zeyVXo85gvbpgWbmnHmk5v5XfIlpePOJ2zuSz4M2BFkE6i
         hJYOjvW7aFvSYrT2pOD0Hbc82P1caIqtaKss7Pc64WhY8AE/hb+GrmchWjciHBg36q4E
         JcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKlhuD7R0WkRQ8r9+a4cSAG6VdZm70kh8u647eLl2is=;
        b=Ie8AN/tjPr8pG7QKehGc3TsNrfu+MC84+pDveoLIu2Zb/GyH21nRfuZhm5kAzlWX2F
         PB6rZCEdN+832KzCDI/0+rPvPngA1+Rzz2kWMxcxVs6hP+6gg+Al75mp+ZMEuQPQJ6rC
         OkjhTVmXYcATTNzH2FvUVCaCvjcQb1uVY8cdmwS+l3rDHqgBl+qjzprzPQZ6suj8W2mN
         IH8sOGKSL5aTYijEpzhLqriExiQtpTu/TvqHkyCEKiHj2WaMGh9hMsg3A6ySs6Iuv1gh
         eNoxr4oxQi6sCRkxMNPD3tHTjmINCrnHkcOtNChy4a7nS42mkjTw1I5IWXOatmu++D31
         G50w==
X-Gm-Message-State: AHQUAubAdbzmfTlATkfQrPJ3SEzslWtyZSWZYYDu0DVT7dy44rnSVole
        6psfHuvjvGd805dgCLDjuRY=
X-Google-Smtp-Source: AHgI3IYzTl1gBl+A+ye6UBydBdjXuI9XSuWyQNsOkMoO218KHsJ7Qa6EjoebYDeeq8IdcXBW6BjjnA==
X-Received: by 2002:aed:3b92:: with SMTP id r18mr19003277qte.7.1550510570286;
        Mon, 18 Feb 2019 09:22:50 -0800 (PST)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v18sm6525275qkj.13.2019.02.18.09.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:22:49 -0800 (PST)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH 0/5] iio:potentiostat:lmp91000: Adjust codestyle, and minor cleanup changes 
Date:   Mon, 18 Feb 2019 14:22:31 -0300
Message-Id: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We solved some checkpath.el CHECKs and WARNINGs. We also inverted the arms of
an if statement, in order to make the code smaller as the else statement was
supressed. We added a missing '\n' on a dev_err message.

Lucas Oshiro (5):
  iio:potentiostat:lmp91000: remove unnecessary parentheses
  iio:potentiostat:lmp91000: insert braces around if arms
  iio:potentiostat:lmp91000: reduce line width and remove blank line
  iio:potentiostat:lmp91000: invert if statement
  iio:potentiostat:lmp91000: add '\n' on dev_err

 drivers/iio/potentiostat/lmp91000.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.20.1

