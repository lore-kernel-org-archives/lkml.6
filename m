Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225F6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D153420874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYdUj7nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D153420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbeGXUAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:00:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38097 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:00:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so4504984ljc.5;
        Tue, 24 Jul 2018 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l4DxCWcjc7EIC4KgORJCdIVTkxzo+vRhxAQxdPczEag=;
        b=eYdUj7nY5aUOeOjs/wkasxsmcFIioE36/XW2+iebVlq/ovU1TEMNnh9geJsIvppGah
         VoW3Hjg5vQWmpIen4yg50AeZ4Mde7WhBEAWW1cPy6HAQUkmPBZSxYCd8f8Hf/F5JRGe3
         BU63k/Z7qLRCxc2D33+GccaL8rjH65W2OOptnLyYdJSbJLEkH2x32yQySO0PvH+874id
         hfiUY20LIuXrW2jeKaWRtQXvzSZQZpbLeVOof7ScCQm2o6X0jTK3wE2bLgfGuywzodVF
         HA5ZilHdMVYR89bMn6cMJxt086ahJTN0wJmYh8CzSXWZjtFlaJUTHwnCPG/WynpMlqjM
         OUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l4DxCWcjc7EIC4KgORJCdIVTkxzo+vRhxAQxdPczEag=;
        b=FDhN3MrfsH7TyiZBe8+mjtMQncU3jhz77LhebwvSUWxHmfOLxLUVpdOXQA3z9jBsh8
         VC3PBFr/I5yo85lyY5XbdDS1eBaBD/Am5tBPgW5NxQFgtdgEOwt0zdvUKitZ3/uY6lDk
         jrVyJxNFbzKlFjxG1+anZ/eAQkekQ1a9ElxAEd7UGvS5qgMJlA+uS2kq/rX6XvhwA19d
         8FG1Yd4giXDPezJumG3KyzpALqdUQy1S7bFAFELd+1IJNBovLTt/1Q4AchW6COIHii2f
         Rs9/s8GJ5Vk/KIxSo2eXxQ/Fes76Bxg+62LckV/8JvRH+rcxBL7bApx3lORedb6oXlhm
         iwcQ==
X-Gm-Message-State: AOUpUlH8KvhAYfXgqqq/ssusw08xNcIyNE8eIG29PPu4uPxzphhQwNme
        Xy4sGk0uk8H+BpkEUD4E8OQ=
X-Google-Smtp-Source: AAOMgpdFHdPJLw6GoqPhqjIuEYbmY/k/1mT6CkK1Uu2t9UoX9c+Kxvu0VSeyVZBxE65C2NBOYMt41w==
X-Received: by 2002:a2e:94d5:: with SMTP id r21-v6mr12748303ljh.126.1532458377691;
        Tue, 24 Jul 2018 11:52:57 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2f9f0-74736162.cust.telenor.se. [46.194.249.240])
        by smtp.gmail.com with ESMTPSA id q14-v6sm1899287lfq.7.2018.07.24.11.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 11:52:56 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for mcp3911 ADC driver
Date:   Tue, 24 Jul 2018 20:30:04 +0200
Message-Id: <20180724183004.20279-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180724183004.20279-1-marcus.folkesson@gmail.com>
References: <20180724183004.20279-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for mcp3911 ADC driver and add myself and
Kent Gustavsson as maintainers of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
---

Notes:
    v2:
    	- no changes

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79bb02ff812f..9276da915d9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9271,6 +9271,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP / ATMEL MCP3911 ADC DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+M:	Kent Gustavsson <kent@minoris.se>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/mcp3911.c
+F:	Documentation/devicetree/bindings/iio/adc/mcp3911.txt
+
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb@vger.kernel.org
-- 
2.11.0.rc2

