Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02531C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A485320896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIJeVI6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A485320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756368AbeFOSNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:13:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42007 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbeFOSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:13:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id v135-v6so15883624lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=INkN5fVtTut2zEu33+1uKA5DpWw6RvcT/ID+grvF9Zw=;
        b=EIJeVI6SXWlVyDT7LMlZkH4oqckcpy0Ud7a6JScRlgjP1AIkAbfwjixyIXRQPl92pQ
         Z55C0rF1hrWsXlHYoCVaumKJdRipUAOZtgTrhw5glDnfPoVX+Kde3TfNpWjmURzVUZI6
         uOpZRnzCDyhWrA0K3IqIZO1S0pT0A3KgNNbEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=INkN5fVtTut2zEu33+1uKA5DpWw6RvcT/ID+grvF9Zw=;
        b=bV4/bF3DrusMRel6F5M3e9FoXlGcwRDmKjdqSGoL7iDAhPWLJGg9N48scqTitg5owP
         +sBc/RGXQMIcyB338BEU0hlrMIatbefSXBgawcN2AVK5e3HzI9lNqwxF5TAL74pl35te
         E8X+Gi4H+5iGibrDH7YGICLlOv8kASAH7yF9uo/X4zYlEkEaq9qA9wnuM/yFBJwNl8CZ
         fsmbCijcZrb29em5XMgorSd6cxeIHT9Cfzxybcj8lLbJXVRrAt4chKAwKsXzby1vzh/l
         Qayj4Fty/BkxkSDr1nShipGzCTxvpybfC9RXj+zvSFgZYlW5u3pdntSYqpED8ZQHMHn6
         w+Yg==
X-Gm-Message-State: APt69E0d59dLfNBUFmUdu5iPzVeJdfox/EbQFqoQJ0K5A+Yg7UfFG3v6
        N5oq23hOhoPE9RFvqL5t4TVwFw==
X-Google-Smtp-Source: ADUXVKJsVkIYfTyEvXNeaJGxrT1t8pXqEeCiIHkwAsPlRDEc8dH4QBWHuJcwawDI5K9AoJ6Brt6Fqw==
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr1777222lfe.39.1529086394564;
        Fri, 15 Jun 2018 11:13:14 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h4-v6sm1543260ljc.8.2018.06.15.11.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 11:13:13 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 net-next 0/6] net: ethernet: ti: cpsw: add MQPRIO and CBS Qdisc offload
Date:   Fri, 15 Jun 2018 21:13:04 +0300
Message-Id: <20180615181310.10437-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds MQPRIO and CBS Qdisc offload for TI cpsw driver.
It potentially can be used in audio video bridging (AVB) and time
sensitive networking (TSN).

Patchset was tested on AM572x EVM and BBB boards. Last patch from this
series adds detailed description of configuration with examples. For
consistency reasons, in role of talker and listener, tools from
patchset "TSN: Add qdisc based config interface for CBS" were used and
can be seen here: https://www.spinics.net/lists/netdev/msg460869.html

Based on net-next/master

v3..v2:
 - corrected typo of "shaper" word, any functional changes

v2..v1:
 - changed name cpsw.txt on ti-cpsw.txt
 - changed name cpsw_set_tc() on cpsw_set_mqprio()

Ivan Khoronzhuk (6):
  net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
  net: ethernet: ti: cpdma: fit rated channels in backward order
  net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
  net: ethernet: ti: cpsw: add CBS Qdisc offload
  net: ethernet: ti: cpsw: restore shaper configuration while down/up
  Documentation: networking: cpsw: add MQPRIO & CBS offload examples

 Documentation/networking/ti-cpsw.txt    | 540 ++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw.c          | 364 +++++++++++++++-
 drivers/net/ethernet/ti/davinci_cpdma.c |  31 +-
 3 files changed, 913 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/networking/ti-cpsw.txt

-- 
2.17.1

