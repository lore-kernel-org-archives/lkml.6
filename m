Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C8C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C3E22436
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C3E22436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeHKDwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 23:52:15 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:43005 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeHKDwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 23:52:15 -0400
Received: by mail-pl0-f50.google.com with SMTP id g6-v6so4693545plq.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 18:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fL67/HFN/7Hbbgg2gbbVxBdSCGEg4ixwvA911agE4vY=;
        b=JH33vTuw8ei/B4yXbU4YC1ahAz6efpGFRv8aehR4D4fQNBKSlIKU3fdmF0NBnUsE3l
         O5R9mviIVdix8OXML+p97yq47C1FFHTRy//BosTCv4tQHzKb+nTbnw/m6PVluTXnJm+u
         OCPqalYthfF1G+nZgUSxQuvVTBnScEUDetmalxUA4B4ecJxcglbg5GavJqKf7i3zag0y
         FYrMLVDSlzPDYdAY1eJW6yDS2OFSlbCGY0e4WjCcAQGlNQ4hy+Z3dC+HDIiavMwX2yTX
         nFoMySU1qPeM67JJoWYPHeDDeENqP9qLL+zJLbEtnj+nIDZj27xjWl1rSi05ISbQ7GzI
         0uNg==
X-Gm-Message-State: AOUpUlElmAoXayavQP9O0zXc1C8An56hpcIy/snNWgaqRQ9iV2FKRQCQ
        9ZGZcqEyE6NIj53dq9m4ivS7Ug==
X-Google-Smtp-Source: AA+uWPzN4vJkjU7BFLsbKgs6Eq+UdM4KUqyUZ9acmi+sGsiFDwvAg+fUVkP5dU00wETlHbEBh243DA==
X-Received: by 2002:a17:902:d88d:: with SMTP id b13-v6mr8158001plz.314.1533950397119;
        Fri, 10 Aug 2018 18:19:57 -0700 (PDT)
Received: from localhost (c-107-3-165-230.hsd1.ca.comcast.net. [107.3.165.230])
        by smtp.gmail.com with ESMTPSA id x15-v6sm10921217pgc.46.2018.08.10.18.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 18:19:56 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williams@ni.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/2] net: nixge: Minor cleanups
Date:   Fri, 10 Aug 2018 18:19:39 -0700
Message-Id: <20180811011941.6187-1-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

in preparation of my 64-bit support series, here's some
minor cleanup in preparation that gets rid of unneccesary
accesses to the descriptor application fields.

I've confirmed that the hardware does not access the fields
in all our configurations.

Thanks,

Moritz

Moritz Fischer (2):
  net: nixge: Do not zero application specific fields in desc
  net: nixge: Don't store skb in app4 field of descriptor

 drivers/net/ethernet/ni/nixge.c | 11 -----------
 1 file changed, 11 deletions(-)

-- 
2.18.0

