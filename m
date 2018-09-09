Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9076AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418D9206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms5UEQCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418D9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeIJHZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:25:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40727 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIJHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:25:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so16537737ljc.7;
        Sun, 09 Sep 2018 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1UvbEM0z44IGB5zlPX194NMdzWFdtVo+r6gSDjo95Q=;
        b=Ms5UEQCBf933d/usM/IuDhFJUznBN/zrKLIq2NOXCYILC69xzlxzeABIAYj2iVvqG1
         yY1K9fsLSJOz87bk/zmTJNAcLNSpOCV+FwObeQrBEn7fapAr735F7r9B3FlWgAKFd3R9
         Y3IIdipN6rT7Fju6cuoaWlXF+SKsK+LXnwJrGeuAm4NoV06PFq6/VJ7e4pkTS7VPsMUl
         t6VNCr8aPvtNJW70J6DFd+Edb27d3Wum5EO8tdzy3Kqb2i47tuuCfo5Xw+gUcwMXZ/jo
         lYlQJBJ917fq7Yvf5MR8zLQhkLh3Ti0pG1TPJ9qIJHjD97IXNYSugIziYZCvxhcYiXj9
         sbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X1UvbEM0z44IGB5zlPX194NMdzWFdtVo+r6gSDjo95Q=;
        b=bU7zfwHNZzcXcxAdulwG9nQ8hw5p3Rjiq8J0ZTP1za9/4A13YFg5HpfjQwCx17YB3q
         59RUIET8HmDmaG2xZ03IArpSELQsCeCWRsaEYz+hVNiVmveSdzZM7UlW8ldvOF+sKjMY
         Gn135wChfR7er9cxydDIXHUZWz8PsHwcYQxjhLjlR/g8gUeTS+FJFR0jxVx8QarFA3jh
         7OCW3I01QZKco3cYMJFj/VlYIShItt33eNcZbue9LsCZUU2RTYy5QXAsbg/AVOYlW0q1
         clYfibC22VXsGZ/KV/3Imuyw676jZtKisxkL6BUy0JUPiBri6nCi0fGYPS9pRA0/KsiG
         DhdA==
X-Gm-Message-State: APzg51CphluO8i2Th22enssyjdkV+0wsCA3c7fz/PZeohDWQs6F0/lhp
        bAKLXFGZRRnfd9g8eEtoVHbryQVV
X-Google-Smtp-Source: ANB0VdY6Mex/+y74sOE61dbSSPswlB7ona4ClPFcvZ6Gpld40TOdI9iL60ZnCj7yO7p8L6y1ZD1QCw==
X-Received: by 2002:a2e:752:: with SMTP id i18-v6mr10472648ljd.118.1536536593823;
        Sun, 09 Sep 2018 16:43:13 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h4-v6sm2355373lfj.69.2018.09.09.16.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 16:43:12 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
Date:   Mon, 10 Sep 2018 01:44:16 +0200
Message-Id: <20180909234419.31261-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820181333.2527-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
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


Changelog:
v2:
- rebased on v4.19-rc1
- added Reviewed-by: obtained from Linus Walleij

Please ignore the patch "ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO"
sent alone on 2018-07-17.

Thanks,
Janusz


diffstat:
 board-ams-delta.c |  121 +++++++++++++++++++++++++++++++++++++++---------------
 board-ams-delta.h |    7 ---
 2 files changed, 88 insertions(+), 40 deletions(-)

