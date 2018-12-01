Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E658C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4137C20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="WTzLQ4c4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4137C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeLAVVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:21:18 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:59362 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbeLAVVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:21:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 0ABDD1F965;
        Sat,  1 Dec 2018 11:09:05 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=dkim; t=1543658944; x=1546250945; bh=1XCyHO7eZqZeNr
        IAkd/lbqZxbzZiJPinEBVkYo+Qnkk=; b=WTzLQ4c4GxwvhrLpmN88hFvDAuf3Lp
        94CDrcBxzA+5T22PSwLGlY8rGHIqja+oVgG2LlOXkID136tQ4PDpXuQullzdyZo6
        84k6oR3QsNdeuu/0Xpoyyjy3NFUpGVwlV32RAWWmHKM/XVfDcPOUbmh3UuUL0/8J
        eWX1y5YiLG0T3y65W1k1vGfuGAeYSeXP+TBlR4/HhPq2N/L6f8fc7JxLe3oTtIOw
        WHP2YD2TmE0Pbs7rOgPaz5f5d/jeNjXaYTLpsxR26AzlcRvUYiAemCetFLQOVSE+
        cTYF9f4IDIFd/BCZB4ZWyWG6KmlwuYYNj0/bIAdGnf6tGd5R3M7ascARLr6ZsoHW
        cPxcLw7xNFiw9IqZqixBCg/G30xYM6R/sal5t8t4bxFMz+oyJS3ylB3yCvgeWPBt
        6lkImTqlfpwHmmBAhqk81it8DQBFIO8Vz/8ObVKqsG/o5qJ/kzaHz1Co2y1wZZiz
        uII3zHixoZlvWA65mB9hytUp4vgnjF3UBlB8N/+YEUXgTulT9JA/V0Xd9L8ekpxg
        SohBhdp8g8J342S17XtwUfCd0PUj9O2Jyqzn5Ie4/T+Q0wkMBtwNvHBxDADRGf/u
        0ZYHc7OoR6ZERWK8/ADcDMSudiBhl/8njxjJuIL645EXUae1BPkgjKdBxTKspP8n
        x6DWm3MfubrwA=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OTrghL19Nc97; Sat,  1 Dec 2018 11:09:04 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id AA6701F978;
        Sat,  1 Dec 2018 11:09:03 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Akash Gajjar <Akash_Gajjar@mentor.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH 0/2] arm64: dts: rockchip: rockpro64 dts issues
Date:   Sat,  1 Dec 2018 12:08:15 +0200
Message-Id: <20181201100817.20688-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found two issues from new rk3399-rockpro64.dts file.

First one is incorrect regulator mapping. Rockpro64 has bit different
GPIO ports used than firefly board. Board is not able boot if GPIO
pins are not inited by bootloader.

Second issue is that dts have video output enabled but no outputs
enabled. Kernel will freeze if CONFIG_DRM_ROCKCHIP is compiled in.

Oskari Lemmela (2):
  arm64: dts: rockchip: rockpro64 fix regulator gpios
  arm64: dts: rockchip: rockpro64 fix video output chain

 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

-- 
2.17.1

