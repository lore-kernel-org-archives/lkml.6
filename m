Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA32206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWQU/EW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbeLNRff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:35:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51210 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbeLNRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:35:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so6462192wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iJTci/dMZv6OxczQYBaBGFdMVtjgiHQ/y6WXyHH2vVw=;
        b=dWQU/EW3ml7g3V+eYlohjhqI5OZBPxMfQ2S8OSMqehrXZpB8UU0whIN50e8T12doCv
         mFEXEaW01K+MjZ2M8tuf4G//7YpsmA2UTANjAS2T1+KGWktorY4dpG+gR6eMS/DtU1mE
         s48R6wzqZwzC9g21Emh7lH3iKtLQhsLzumgco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iJTci/dMZv6OxczQYBaBGFdMVtjgiHQ/y6WXyHH2vVw=;
        b=r4hguioDX1Cy9IEUFglMKDuDiBrMSgMUi5TuU9Rx29RFKpSlY0WXIPAd4ukGAZ6b02
         ZYCO8NyTg6vwPf0A36gHLnHwsb/PzYHOeGsvX2ThjG6QFpBdTvtoEYZTRXZO22bAH/GJ
         WuBB/nJcAqAs0y9THB9vRdwjPTnruEuzxOxMQSbcutUv3L+UILMR9C0L0OgjxfM9DSGg
         hR09G0JqiNwgds1IWCWOr2NgS4FAwuP4Ix1ByMv53LY7tQwEtsDge2FF1Gz1GRemZ6U4
         U7gpzwm3VrswOQXuzLzzZwsK5K3BR9B4++HdFVnWt8iq5YYunvuFJ/xIZYE7+dqR3QWa
         w4Bw==
X-Gm-Message-State: AA+aEWayFC0o0Fsw15dD/IWl2E28fPqLddDEr4Uo0+Nlxrw78ABYPOEE
        moYUlWIXC0ga9RSQKISr1c7iOpQPXUQ=
X-Google-Smtp-Source: AFSGD/Xe8WISKtGrsCIoWGNkNPDfkLgzPa/sF4bJ7pjFX0VSYxalUeiLwX0ADqWcJAW6vkdddbanCA==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr3966389wmf.14.1544808932896;
        Fri, 14 Dec 2018 09:35:32 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id 199sm6259772wmh.21.2018.12.14.09.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 09:35:31 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, joe@perches.com,
        gregkh@linuxfoundation.org, himanshujha199640@gmail.com
Cc:     apw@canonical.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 0/2] Fix Co-Developed-by
Date:   Fri, 14 Dec 2018 18:35:26 +0100
Message-Id: <1544808928-20002-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following set unifies the terminology for co-developed patches
(losing the capital in Developed) and adds the rule to the
checkpatch.pl script to stop warnings.

Jorge Ramirez-Ortiz (2):
  docs: fix Co-Developed-by docs
  checkpatch: add Co-developed-by to signature tags

 Documentation/process/submitting-patches.rst | 4 ++--
 scripts/checkpatch.pl                        | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.4

