Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B9C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFAE208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvqRrovR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFAE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeF1EYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:24:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42582 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeF1EYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:24:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so1878212pgu.9;
        Wed, 27 Jun 2018 21:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ea1NvmJq5mTTOxFBglB6GfJdQMvUrVLaQabx/xR4qCQ=;
        b=RvqRrovRHxyyRMqq6rPeJBtua8wXR3f5ev1WZKhhsC8mB6n4rOA5tH4L4P7D+iDhLL
         N3qR2UXs5SvdaADZJanqZegKsqMIdCGI3pbZ4oWmN3Y4SZfSVmRaZis9y9fXEOCJreiL
         svaEsuBenqXF7bSXQOJW+VyFJaDCkRiHbQ8lh4rJeJBuVaa2xdAoX0uzJ97S+rVyVRiS
         q3zJz64VSt9dc7eVRrDhYgDcEQxp2mZePNzTbbLLpygcKor51JLAuDDWuD5iBZ8L++Wz
         HkAV0gOZowFhSvWuBiZIi0dZ9Y2pUF4ubSiTvyf/pyfFJpXPLjRJn9qWHGEQnDD2nsA0
         rGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ea1NvmJq5mTTOxFBglB6GfJdQMvUrVLaQabx/xR4qCQ=;
        b=WHtskm+f2fxT858s70dshoHeVMj0e6SMYr6RytZWnT92iRdQJ6OwRNG4ZYZYF1EqmA
         8Zq8ZpdbTnozNVvogm4nuCOrnt/jRdPJRdjqUgB/KrB/UEselzjw2TQWRYDGWrz09VeM
         6eTisQCXojj3CJjlGTpLr7lZgKb2+GpEvDgVBtEURnDIHtLDnlKVpBNsGxpkolzW7lYx
         V7pbNw7lLzSWOo2taofSCpgABnS5pPuTNvC91uVVwowczkA3eSuIBwN7rH7pFKhb81U0
         suFeLwy45n6EI9vL3eQvGvIX9CLXl75t+b2o7y40MdF4/A+9sAQIZ8RelyjrnltKIIiN
         620w==
X-Gm-Message-State: APt69E2lNy+lc4X9Z6Rw50WAa4+fv/R/fj/iX4FR3kL5Po5r712Xo5mX
        OBbv4nX/MdoP/PUV21ptmM8=
X-Google-Smtp-Source: ADUXVKL6ncc4PqfRiKv+81WVfsgYItu5Amn1NiEzF9IKJCdxNOR2MIQollpu4p3OczR4uoG9F1JA2A==
X-Received: by 2002:a63:7847:: with SMTP id t68-v6mr7420162pgc.329.1530159887518;
        Wed, 27 Jun 2018 21:24:47 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t19-v6sm12328577pfj.169.2018.06.27.21.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 21:24:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] RDU1/2 latest supported RAVE SP nodes
Date:   Wed, 27 Jun 2018 21:24:20 -0700
Message-Id: <20180628042424.12664-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn:

These are patches adding the rest of RAVE SP child nodes covering all
the rest of currently supported MFD cells. There's more to be added,
once more drivers get accepted upstream.

The bindings three drivers mentioned are availible in:

    Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
    Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
    Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (4):
  ARM: dts: imx51-zii-rdu1: Populate RAVE SP EEPROM nodes
  ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP EEPROM nodes
  ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP backlight node
  ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP power button node

 arch/arm/boot/dts/imx51-zii-rdu1.dts    | 29 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 26 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
2.17.1

