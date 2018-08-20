Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AF1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A9F2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJxQW6gY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A9F2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeHTV3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:29:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39969 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:29:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so12322636ljc.7;
        Mon, 20 Aug 2018 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AXj79Yh9rQ6PthwLMbJo48kaVbgxL4pmvxtjEHBIUcA=;
        b=aJxQW6gYHnP34Pz2WObxLrlK24ByCMr9F9fdfAo++kw4+PU9U0jK22WGHCLRVkOFhr
         SxeZYtHysH3xynQcyW+1NusMrrmpRKLhHFWMn3A8qNE+g8dy/4xRB2YUSwYH6/K5niIj
         liceTEhZNRrzva4iwxo3RoVcVUvDyLwZEibDBEfB7JMF9NLW34rFuLKQD00V8SgBC1Eo
         LE4tlndAlNoMgoOgVQvV0tmgZZMc8ntL5fuYQcJ16TqWuEdfRxDsq/dKVRvmMioD/NXB
         0hWxljDHHt5pb3uL0SErIY48np/rhTRA72aP9qPasht8gTqOfX4qzvNXWGfjo5pcSgml
         IVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AXj79Yh9rQ6PthwLMbJo48kaVbgxL4pmvxtjEHBIUcA=;
        b=i563M0bKrA/NulckX5O9XcrUFmZgAkuk9mRE2yc8nkQK7R6noPfct+Qy/ECgeXxRak
         lPcEu4QSMCqnpRAIiOFtlQ9ENclhoz/LMSSrJLA6RknVJvMElaXKuD1WBcj5IGkBlmB2
         46jLKaH74oHq3ScyrpjeHypHYknM0B6EkEDpmv0h3qjZ5xwrEltdM1EN61Nu61pLzgli
         nYDD3i/j2CqfgaZ8KtHTdQRvH9ls+WXbZvXicFrEtbq46eP/HjjyTnWZK7+pi8aclVwi
         UxmsnJBvf7nxHGhL7I2FboaNI1DcBv4sMruMqMUcNJTcUv1cdk96YrlgLMLl9zHQsjVJ
         MEXw==
X-Gm-Message-State: AOUpUlFS1cAuSKVKTDgzbfOSSwqVU9OUABDCbN35MS4ko5UfHOj/i2gc
        5KS/37kbCLhzk0T2o9PMi34=
X-Google-Smtp-Source: ANB0VdY6pxhJ4j9NYNEbyjsoqxV4F9jKSLHN67jgwQwh0t7cNGCt0P6ejQThDZYWyDhMvo4CVmK9Og==
X-Received: by 2002:a2e:105c:: with SMTP id j89-v6mr192234lje.152.1534788756206;
        Mon, 20 Aug 2018 11:12:36 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id g16-v6sm379918lfb.5.2018.08.20.11.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 11:12:35 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
Date:   Mon, 20 Aug 2018 20:13:30 +0200
Message-Id: <20180820181333.2527-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Convert modem related GPIO setup from integer space to GPIO descriptors.
Also, restore original initialization order of the MODEM device and its
related GPIO pins.

Cleanup of MODEM relaated regulator setup is postponed while waiting for
upcoming conversion of fixed regulator API to GPIO descriptors.


Janusz Krzysztofik (3):
      ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
      ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
      ARM: OMAP1: ams-delta: register MODEM device earlier


diffstat:
 board-ams-delta.c |  120 +++++++++++++++++++++++++++++++++++++++---------------
 board-ams-delta.h |    7 ---
 2 files changed, 88 insertions(+), 39 deletions(-)

