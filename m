Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93ED20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547634234;
	bh=ZKnO5mUQXnw4su13YoE/BjLRJ49rWTEjJPLnCDa4pxk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=umoyiw3EhazXNVZDuLrQwowQL7yzzQ8w1tVHAZ5nOljnb06eZ5y4UvzFaFtlzoBxJ
	 QhMA6sNWk+Ck/Rp2lwMv/+5bizCWOdGJhla2DKy/EQdyxqhHn7IG46Eu/vgfUZxjMy
	 /Mm4RbMYWl/2C8k1iSshGOsO/GW7tDbUeSSGCWdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391960AbfAPKXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:23:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44382 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391922AbfAPKXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:23:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so4934445lji.11;
        Wed, 16 Jan 2019 02:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xO+CZAdIi+l+AZbVQCdj2Upztw+Q8ZEi0WrTh7a9RH4=;
        b=XWmnsSUjVqLGtRnLfSgIhA3iCH1iridPtVY0oS8KFPrr07nQQMV1sKdwe6tZJANyjV
         FBV5DLJQVmJ/KJIcWqcB/SLEDga9so+imk23hsKDtrIurUfATLLqKdfP8P/L8+xNp83E
         MO+Nhmg+DmYg/6Kj3KhmBsdLvBM7MesExd2pcZmjD9WUgUMBt4TM93KdWiazgYnzETEM
         ZreUnZ3fMNb00bBuP2b0LkYLvmA05tql5edHrWFAQPZWMSOSIh49E05y1e4dRjUVUJYL
         /UjR9go1PtiKEcUvPej+Qex0zJLGEVTcqrTG8o3grbPH4np9X4ZfTgNzlL1wD2sTIhhY
         LeXQ==
X-Gm-Message-State: AJcUukdVDr9ENWxHjRTGkAthf3yHjiAIVqhS74Lr3eZ54ZBbZLSnqxXJ
        oQxycZULkw73xXmNxvkCYafMKBZs
X-Google-Smtp-Source: ALg8bN5rpYTUiWQY+Mo2QOLicmO03yeDTdhvVbH1x5wTK/ClHne49hqdT2sD3oItrMRxw9P8/diP2g==
X-Received: by 2002:a2e:917:: with SMTP id 23-v6mr5856258ljj.1.1547634222966;
        Wed, 16 Jan 2019 02:23:42 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o5-v6sm954879ljh.75.2019.01.16.02.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:23:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gjiMH-0007vd-K1; Wed, 16 Jan 2019 11:23:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] net: dsa: lantiq_gswip: probe fixes and remove cleanup
Date:   Wed, 16 Jan 2019 11:23:32 +0100
Message-Id: <20190116102335.30433-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix a few issues found through inspection when fixing up new
bad uses of of_find_compatible_node() that have crept in since 4.19.

Note that these have only been compile tested.

Johan


Johan Hovold (3):
  net: dsa: lantiq_gswip: fix use-after-free on failed probe
  net: dsa: lantiq_gswip: fix OF child-node lookups
  net: dsa: lantiq_gswip: drop bogus drvdata check

 drivers/net/dsa/lantiq_gswip.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.20.1

