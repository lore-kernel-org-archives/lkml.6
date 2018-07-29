Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB71FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A9920870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcLhCIUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A9920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeG2NKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:10:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39521 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeG2NKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:10:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so10449665wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oeEqcemZnTgdCcs/XvkkaPTf6TrAKN0DmO7aWlzcD6M=;
        b=KcLhCIUFzfi23nlZ9p16SQGikqm/PpQq8qjao/dZqvU2uFyrC21utsnnVf+XpbIf0H
         5Zr9S/c8xnE2vvf2EaAb4iaQ4CJhADP1Kn57uuO46j3gjcBAoF42aFg6kupkrflAmg85
         HMTwk9q9gslx6UCgIE8TeNwqnX6acYkNwsw3/5HbWsEEVBKnyrhNiwXI53psF5JVtFui
         7RgaRZndFc25KGfvNdatbPrUrLLBEt8bfcCjDq7EvAVBgjGDFCRDj6/7LoxI7l16N5ux
         n0A2HiPyaN6tfNJoC9vo3aNoikKeF/9D8doQ3dVlNldiHloKyi1IYd74fNsGMKxFxQwF
         IGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oeEqcemZnTgdCcs/XvkkaPTf6TrAKN0DmO7aWlzcD6M=;
        b=G1ju5vRSm68pXvsWXhppBx/QB6Cw2VfRN9cmGixBQR+/IdNdQ3t5dBr2oBzqXrhDpx
         kIVC4k9uJBUkXzw+olaTHwPQs5jB+FJbwWy29wNFQblkTQ4zvVeNVPAf7qneOJdv8oqN
         T+i1G1ubbW7xgmoZEqBFyZY9OTITVQ0j4lbwYI3XorEET0L6RkU5dSIqzEkOH5Vs46L+
         4tUdpLQzSLH91OVXFr4RjATADQwDWTKlRrLvfU8Vw+FAQIbhpppwwFgt7TQJT6M+zcHK
         DoMF7FCBnipD8FBBg7qT4JnrndG7Iklo7I6+1obOKbPCeoFg7Pa7yPYeRWw+5QpNkaRO
         eb1A==
X-Gm-Message-State: AOUpUlFDK0fk32dYt8lV60B20KlhFpVJzna5K4f39xe1UJp0YDP8nIPM
        ycfbwPfsAv9jhnLiF/BByuE=
X-Google-Smtp-Source: AAOMgpd3ksMzuKEwfitD6XESgPoasx+Cnb+2P1JTe+52Aea4w7FgN75hSOHkcGU+Bej9MehvUZNorw==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr9439616wmh.61.1532864443171;
        Sun, 29 Jul 2018 04:40:43 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id l11-v6sm11150699wru.25.2018.07.29.04.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 04:40:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 460556403C9;
        Sun, 29 Jul 2018 14:40:41 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T07iCLnmk0cC; Sun, 29 Jul 2018 14:40:40 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id C98136408D2; Sun, 29 Jul 2018 14:40:40 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Staging: octeon-usb: Changed CVMX_WAIT_FOR_FIELD32 macro
Date:   Sun, 29 Jul 2018 14:40:33 +0300
Message-Id: <cover.1532864087.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180727151527.GA2209@kroah.com>
References: <20180727151527.GA2209@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to previous message, i changed CVMX_WAIT_FOR_FIELD32 macro to function
and altered a multiple calling of CVMX_USBCX_GRSTCTL call to single call and
stored to variable.

Georgios Tsotsos (2):
  Staging: octeon-usb: Change multiple calling of CVMX_USBCX_GRSTCTL
  Staging: octeon-usb: Changes macro CVMX_WAIT_FOR_FIELD32 to function
    call.

 drivers/staging/octeon-usb/octeon-hcd.c | 77 +++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 33 deletions(-)

-- 
2.16.4
