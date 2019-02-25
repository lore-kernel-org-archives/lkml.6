Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B935C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182BE2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyyWA7U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfBYQ63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:58:29 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33818 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfBYQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:58:29 -0500
Received: by mail-lf1-f67.google.com with SMTP id u21so7455013lfu.1;
        Mon, 25 Feb 2019 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhJZin/7F8JDRslMcPPdslgl3pSRNlxec0nu7WmSk5k=;
        b=SyyWA7U3ChWZOEfZcLOTs2KnMKj/TCr1CSvORWm3gHfVZ/un/1m5Ji3WBWXbgLlsI7
         o0VWfEJhdMVbs8VBbK947F+PdTk/9nU1nLdq9a1oPqHr872Xb98rH/Wb+TltsgevPF3b
         QIVmtQyEFDGXBc7QIhuREB1dbvtPxZVdzEbYLa0IyJNLx3ZokvCHW2YV3HMidl/GBxyr
         w6/eVAPMcazbdEgopyCyvHDwq0qkILgwzZdulMtU/xi8NUUEmxuWhd5ZhkLoAAvv+VnS
         9Z/G3t2CRNm7Dyc9smds7nyj1PWCd+NnCBnJdR8iOx+PeBfnDr+ehy1pi8gZ+2mUo10e
         YyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhJZin/7F8JDRslMcPPdslgl3pSRNlxec0nu7WmSk5k=;
        b=hBtPaPhPZyvSGvZj7mle9McJ50Z/ZJLyuA7NNuMtmg+dFjqZBH+w338RqlKbxRppw+
         1W96yWZS5Cke0/1ZSqEjmkBP4QtWEf1YC3cdQv9TkwgPku1UO3IAh9u7nk5qPfxJo+wI
         xSGpluK9Ri2DbZC8iVdTkLteoOoa6FbYHvtNmfCrcuwfDWA5xby1UE0GSfIK6epgdoBK
         wGQf3927x90nKQjwTdJOI6rO1YdGsMdh6EFUh3RPkZV25IHE4VIcyMc2HZCb1dRxxfvf
         Yu2JLqlnBM9+p0+t9KC0ROh5I6wpfPTmtZU0Z6jwVJi8Z0KLxTCzrEIhti8P3QABceRt
         0vyA==
X-Gm-Message-State: AHQUAuZhKqQ27110sMtWXsweHiAIONHYmS2ykrgQyJ/MeRA3t0QEzW+A
        fjTsbFgWLwfP9rkaaY2JQ4M=
X-Google-Smtp-Source: AHgI3IbLexV8GJk7F8z8+Oi6orGCRFBtAEFWkrnMys6NIdAZuZOIDm7DL59PebQzdaDmB51htGsf4g==
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr11592942lfm.66.1551113906778;
        Mon, 25 Feb 2019 08:58:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:780d:6cb1:e20:559d])
        by smtp.googlemail.com with ESMTPSA id l30sm2597575lfk.83.2019.02.25.08.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 08:58:25 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     myungjoo.ham@samsung.com
Cc:     cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/2] extcon: Add fsa9480 extcon driver
Date:   Mon, 25 Feb 2019 17:58:20 +0100
Message-Id: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset adds support for Fairchild Semiconductor FSA9480
microUSB switch.

It has been tested on Samsung Galaxy S and Samsung Fascinate 4G,
but it can be found also on other Samsung Aries (s5pv210) based devices.

Tomasz Figa (2):
  dt-bindings: extcon: Add support for fsa9480 switch
  extcon: Add fsa9480 extcon driver

 .../bindings/extcon/extcon-fsa9480.txt        |  21 +
 drivers/extcon/Kconfig                        |  10 +
 drivers/extcon/Makefile                       |   1 +
 drivers/extcon/extcon-fsa9480.c               | 473 ++++++++++++++++++
 4 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
 create mode 100644 drivers/extcon/extcon-fsa9480.c

-- 
2.17.1

