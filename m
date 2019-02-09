Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810DC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF76421929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 22:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezf0bpyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBIWQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 17:16:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36892 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfBIWQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 17:16:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so4452401wmg.2;
        Sat, 09 Feb 2019 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j63yrZW3ckLWvgwpT498/p4LqxZ8ZPRqef4NQMYqCGQ=;
        b=ezf0bpyzy2b33t2K1jBMi2QvWPZfF/y8aszevViowKbSoMXdtPd94cvPAgkdb8NIrF
         06M6efknaS8O6UTz6pGwyOxIQ5wnAoPAGkh/10KaHYjsXbBCd1ABvC5vpKf2FHKGA5Xc
         hKCH4LO8ROU2pL/NHhS+IlCZOsFUt+POAXbMOdCe0+lsqWAjGzWUJIwYRV42EGOMT6Wv
         ank/fyuiZ4QfFjf9VyN74Sq9Ed5iwgmaiIdl801Y7ZgMfP1wmWOIerVHbETdlgDK9lEn
         QbJ+po1tUDM46+UQrEnDNyjFMDKxs4XgC4CP3Nen1RyxrC29VRKXCaWfPJd2OfOcUSKI
         NrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j63yrZW3ckLWvgwpT498/p4LqxZ8ZPRqef4NQMYqCGQ=;
        b=l1KhOljiGklXZlcvYbl8RoaEgnuIEM/gmJwxdCGALE5tqCavvNJYn0A3OumNY6hG7g
         FN6Eql/z8GTxLV7h339MbIBZAbmJtUxJd74qNWKN3jvfvyVUrzFq49cM7065VA2bg6h5
         cVDbVEmRMV5AzyetsVObHukM3nQWAZCbYG8AVTTIc7wb1I13SXJ4QFlE5WCbIk7B7VU1
         kjGxYEP73XPFxriQ8IsODXdMU70c5DwdWjdxhpDruq5I59a+KmM3j7JAeDYrW90eoGmL
         HBxN+/tW20vE7oNQjqvP7rhpaa8nsvavxAb/m16fjCxI5MOPn9PbXmvyRaPEKAfj0tOb
         g2VQ==
X-Gm-Message-State: AHQUAuZlf4qdZiBe1VZ7AVFPW/BGnjQFmHle7r3Y66c2KRUy4zkY6d4k
        Fr+qMP7puNx2uUAnuicpAs71I7im
X-Google-Smtp-Source: AHgI3IZEtuKP+S/NN1dTXHVM68ZMXMXXTh7W4MTskllGMQDVjILbymWFdOIPyMQDkm1J+/9/hkqwBw==
X-Received: by 2002:adf:f848:: with SMTP id d8mr23336369wrq.178.1549750611006;
        Sat, 09 Feb 2019 14:16:51 -0800 (PST)
Received: from localhost.localdomain ([46.216.193.21])
        by smtp.gmail.com with ESMTPSA id z14sm3673858wrm.48.2019.02.09.14.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 14:16:49 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gsavY-0006Rv-4N; Sun, 10 Feb 2019 01:16:48 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/2] Intel Cherry Trail Whiskey Cove LEDs support
Date:   Sun, 10 Feb 2019 01:12:12 +0300
Message-Id: <20190209221213.24052-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces new driver for controlling LEDs connected
to Intel Cherry Trail Whiskey Cove PMIC (general-purpose LED and charger
status led). Only simple 'always on' and blinking modes are supported
for now, no breathing.

Driver was tested only with Lenovo Yoga Book notebook, and I don't have
any documentation for the PMIC, so proposals and testing are welcome.

