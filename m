Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34FBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8AF20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjArh2Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8AF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeKHFsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:48:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45623 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeKHFsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:48:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so12420909lfa.12;
        Wed, 07 Nov 2018 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zuxixJVQpJW4M1s4dH4ZRGxewZJY/xnJJuSkeL7tp04=;
        b=AjArh2XqVfZ52fMg4NJGhrTp6E5+AVFAJzGOnERtUwJ1eW53Ot2ld0IsyY+Tjce6Mc
         A2ONJwdMuMJZ5YIp6DR5H5ghq5so2aVuY/JW9rw9b6C/6lmMWwICCqVC9S5kNpVRSIpF
         ap3vllpUrwV6UvL8YR5zmmqo0KYmT0/K2CzQX+0uhgtAGi2x23g1d4z1/93ws2gsu9Gv
         Tk7QSu3uM95NBbS6yo06PTmb+tLFqQ+rPRghj3wXWMToalf/H33mQUSRUW2hZrcSDlt/
         KhEe4D8S68kh7+y0fD1y3NIpJijrJZlj9cBiTs2qaUoisUFNhPSWhI9uE+JFjgKAbsn5
         8mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zuxixJVQpJW4M1s4dH4ZRGxewZJY/xnJJuSkeL7tp04=;
        b=qZbipFZvHvRyhf5FfK2xVdwbrOiw5biobqH5S/RFMzFYOy2PPjhUm0epjlzLwZGTk0
         1ON0xJ9gAXd4Krm5uSUveSaJEj44pULI5C+VRCk0RC/cnut9dNT3lHqMHqdJPWSNMPHR
         QyQk1O4ejYbYbj6mfEFg0mG/wYfKSChl/e8vaTIkN4abKM8m5jYdvXjLEUczmRr9Daaq
         szbRFRXpCaujbF3RIsOsym1SCLtQa8AzsS6BNTrKZGwgDz0HPKdFhx+hH2Xf+3NZN3jf
         txMyrqfJbRCOTCYDzWTHUhjbCospG4Yqvhys6z5d7yCun/oE4TrCuJ/v+LANeOkUPpmh
         tu7g==
X-Gm-Message-State: AGRZ1gIqqgsK8GmK4cJCRdTAZpYaiAY3C+mYpiI0jsPxw0zUmAe16xV8
        0fdr0RKq95qyHZ11ofYiawA=
X-Google-Smtp-Source: AJdET5cUobaINuPbCng8jVV4HzSfvBwZRL1j7k4yUqRqMGGJKAnebsdOKa8ei+dtpWvEICWaiTipFQ==
X-Received: by 2002:a19:4287:: with SMTP id p129mr1019245lfa.135.1541621772731;
        Wed, 07 Nov 2018 12:16:12 -0800 (PST)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id c19sm285650lfg.86.2018.11.07.12.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:16:11 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 0/3] ARN: OMAP1: ams-delta: Post-GPIO-refresh cleanups
Date:   Wed,  7 Nov 2018 21:17:43 +0100
Message-Id: <20181107201746.14705-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Janusz Krzysztofik (3):
      ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
      ARM: OMAP1: ams-delta: Drop unused symbols from the board header
      ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file

 board-ams-delta.c |    9 ++++-----
 board-ams-delta.h |   22 ----------------------
 2 files changed, 4 insertions(+), 27 deletions(-)

