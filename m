Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64718C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AD320658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJcAxyst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AD320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIEQou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:44:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43984 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:44:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so3340396pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ehyFcQbHsOydXpAFh0pOBu5S1X+h/HyGlFJ52nDgPu0=;
        b=BJcAxystfSoUDCyvc/u8XKv9QSxGylDx90mjlI+GSfnMH4Jf/BQk/VKAqLygnl6bh5
         TQ97CxyV1458dEP7M3Bc8X5yN9ZANFHBaQjC21ZmQGU/SKyM/PUuHfEqDtBcDhWtuA42
         gidaN2jmgFzOCd1JnUw7tz5Bx1pUGnq2iCxqVka/ozQvRYO1N+LLsmp8lBMJkFbHOm0/
         J5lPKm2xAajbO1BnyBaIer8img4IyUgZVmM/0X/6rV0fvDie+f98dX3JvUXrhvPRLAEB
         sVzvpGBnpw2asALAHTVbtPVatvZd4/6ktcyDKcPfUrstixjXR8W+msh4B3ZboOueM7P+
         QW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ehyFcQbHsOydXpAFh0pOBu5S1X+h/HyGlFJ52nDgPu0=;
        b=fBpknWmShG/TIWUBqtdnKvNPlJ3A+b8HAXg2EG14WBmAbVpwmecZRJPj2yi3bUS5++
         nSPTvW8qmLY/2PszZt1gc280qu6LETV0k3PemjFVyU9YgB0921Hul06TS6lOrTykN5EF
         ASPA5C71nhWAEAc0ZBYzw9q3UYamh15gkfgT8mVcHN+Ok/sEPV29nOKDcmiiK/Rut3Aq
         veiDLsDtFh1XCctekNMexrtPQAOv73y4oIaCLpOy0J+64PY10ez8jM6J4yBNGY33UCKX
         pZvwn2mEBhbDe5RBc/sTQriXLtWNlXSVtmFlonRRqJYz4MMdDUyxfUSpP5wXkImBJBIq
         u4bg==
X-Gm-Message-State: APzg51AfTUQ1oiQnF01FP82HqU/4piHR5/i8Ma4ixToGzCR2AmF5Pisn
        UbM/ib9oU558Y7e2Hy1CEFfMc3Kv
X-Google-Smtp-Source: ANB0VdaGlJvwLQjTGuVzZyd9NZkmQMV9MBR/UVyniGMuGJONuzgR2ED2hKDEJpH5iwJz0suMIdoX8Q==
X-Received: by 2002:a63:1551:: with SMTP id 17-v6mr7633839pgv.383.1536149690622;
        Wed, 05 Sep 2018 05:14:50 -0700 (PDT)
Received: from roar.local0.net (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id w5-v6sm2496227pfn.44.2018.09.05.05.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 05:14:50 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH 0/3] tty: hvc: latency break regression fixes
Date:   Wed,  5 Sep 2018 22:14:36 +1000
Message-Id: <20180905121439.23809-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are fixes for a few regressions that came in with my
carelessness with the irq latency work for the hvc subsystem.
These were independently reported in 2 configurations, and I
confirmed with another.

I think those went upstream via Michael's tree, but he's away
at the moment so if you would be able to consider them for
the tty tree that would be appreciated.

Thanks,
Nick

Nicholas Piggin (3):
  tty: hvc: hvc_poll() fix read loop hang
  tty: hvc: hvc_poll() fix read loop batching
  tty: hvc: hvc_write() fix break condition

 drivers/tty/hvc/hvc_console.c | 38 ++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.18.0

