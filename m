Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44358ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E458B20673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jVlcn/wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E458B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeGRIRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:17:10 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:39374 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeGRIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:17:09 -0400
Received: by mail-it0-f44.google.com with SMTP id g141-v6so466580ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NwLE07YJZLOnuI+8iurziue2gxdWtJUgnZdmz2kCZ+w=;
        b=jVlcn/wAc8i4FFv8zlzAX1021uYtROLbhf8DRtfr3tbQlsaXrz9R8MG5+2Zw13aaO5
         k8Jj0t8f+UAoSmXQBY2/+Nmj8LsVyiKCmCnTvAqjtmozwiwCSj9NqfFxnXwC8kaVgoUf
         u/gyOizRWsHde6IVP5d4Ky9dGouKT8Enn9pWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NwLE07YJZLOnuI+8iurziue2gxdWtJUgnZdmz2kCZ+w=;
        b=LTA1QBHs5GC6DEnHdpHz6CyfTrlQi+lJ9wvjQ26DgRlE/INr6wWiUdal+YwkeDmT9T
         4uXH2OUNmbGY/HgSo8zg5Wxe0Xb4cFVnTaE42Gll6q5EIbuEr8n53P6u+pnlkI+d/ZH5
         HXyHnBOh3UrS5nu5VSiotQbRN/Yl5BS6JdKY7/Bvv3jM4M7D/NIHeWWR8/2Yq1tH5JHw
         BElfG2wl33vvDQVf/j0+AAMlfd/Ccp6KXIiZBR43OeTZAEReDjeK/4YQOSRBPyInTCSc
         RuLZydy5o14kf43EZldNy8KYYVL1jxOegBfyVxd581I1s7GnGPJdb7EpoDCflttBvQSB
         qv7g==
X-Gm-Message-State: AOUpUlGg83PpdXn3c6jvwwx3D0u3iXWK2zlO7F079rptcS9NHBdPIEai
        Y3hn9KpiEIOCxxbnOpD609AMQz2XL0hnHsavULLirw==
X-Google-Smtp-Source: AAOMgpdLGQodO4scN6OsfbC5Vr5zEI0YGrdh3jU0QN5XprQ58cQRTKvz9tdtTCY62H61C5xFp9DaLMlDbzDHt2LPUq8=
X-Received: by 2002:a02:6a2f:: with SMTP id l47-v6mr4413914jac.71.1531899636665;
 Wed, 18 Jul 2018 00:40:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a785:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 00:40:36
 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 18 Jul 2018 13:10:36 +0530
Message-ID: <CAMty3ZDG5sbM2w+Mymvm8JZ8vgmP-mvtXEzT4j8vqWsap+T4DA@mail.gmail.com>
Subject: BPI-M2 Ultra boot hang, with linux-next
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        devicetree <devicetree@vger.kernel.org>,
        inux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm observing boot hang 'Starting kernel..." with BPI-M2 Ultra,
disabling de2 status on dts seems booting.

Was it an existing issue or did I miss anything?

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
