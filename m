Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D73ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB672087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btUdyx6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB672087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeGMRp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:45:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:47084 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbeGMRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:45:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so22995556pfl.13;
        Fri, 13 Jul 2018 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qYWAQXMhNiXNWzNtGBtQfOA7woxFxGOo1YMO4V2Rfk8=;
        b=btUdyx6cceybSqV1AQ7dd7R4LpUS23mIbiOZo/IAQ5hT6E7SpZOvuLzW4/oREesqam
         PuuBi4jg9FB6fvxMzrFSt4VqDaLzs7DFYrfwODA11Mv/s35LSvswWm2gLE1Sz3kVPSPD
         Kp3UUp2N7nOCgyoGCMn5E6YluMWlJ+pphPL5EbSmyrTspRWvh288XvPbWu7ZTGs+zUlR
         NqnajAdy2zrP4RYJPy/KB1Iie3ek9v0NKOLzpqfpMPXHncqskv8/vYShiw7EkSfTVmez
         KmbSFt5TA765j2+iNIL27VIgcGq3x0/MAY30xMTlefzl7LNKwz5y5fgAuod0OQMquzo/
         +uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qYWAQXMhNiXNWzNtGBtQfOA7woxFxGOo1YMO4V2Rfk8=;
        b=ml00oxo/Hab8885ManBFBD1HwW6RwlkGsk2nWF1mV6IfledE4KF032KAoAGn3rq85D
         p5LoVBjda8YiUN+sVbOX979FVCoyPSItUbMJVqMz277Bss+G+FH+rLtp8Tp08eLHKN/S
         cg6r9Zb2Nzl6QVAvWafop79B0dKpfpjsmzYtee7Z1elib08Sb5psDGiGwUu8keXSx3d8
         SsDvvo8wvcKHj5OviJ5QNa6wsWc1Opx/xRTsvmmSzh3hC3cVbFKFxGjWWFCWsbjJdwAg
         W3/b8b1PYwyW1xfAJ/n4MxfZCzb4Hv7fsE9ABcKnn6zMf7oivl8WTtnR5C16Y4pZFymm
         PkpQ==
X-Gm-Message-State: AOUpUlH8ggJ5+k+EE5n1+tEv2xNO0Mse6NNJldz1KzaXMBDP1wwoPDFq
        11UJ5DqntI4OceiujD3eSVI=
X-Google-Smtp-Source: AAOMgpd5d8BADh+OQ3B7bqqSUrH5tWttd6hnQKuLJ0j0jdH+BulR0mS45UMANZjtsoCzOGNos0DDAQ==
X-Received: by 2002:a62:3001:: with SMTP id w1-v6mr8006423pfw.19.1531503022566;
        Fri, 13 Jul 2018 10:30:22 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s12-v6sm38371547pfm.41.2018.07.13.10.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 10:30:21 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 0/2] Follow up fixes for SCU3 ESB
Date:   Fri, 13 Jul 2018 10:30:03 -0700
Message-Id: <20180713173005.19552-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn:

Here's a couple of fixes for things I missed in the
[original-submission]. Sorry about the inconvenience.


Changes since [v1]:

    - Reword commit message for patch 2/2

Thanks,
Andrey Smirnov

[v1] lkml.kernel.org/r/20180712023337.30112-1-andrew.smirnov@gmail.com
[original-submission] lkml.kernel.org/r/20180711050704.11492-1-andrew.smirnov@gmail.com


Andrey Smirnov (2):
  ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
  ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string

 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1

