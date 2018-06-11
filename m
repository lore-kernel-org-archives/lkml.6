Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rryHHZx5HluDOAAAmS7hNA
	; Mon, 11 Jun 2018 13:31:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6022F60541; Mon, 11 Jun 2018 13:31:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="biqU4aXu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B124E60541;
	Mon, 11 Jun 2018 13:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B124E60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbeFKNbA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:31:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36953 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbeFKNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:30:57 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so28582053lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEII/3fKlM7VRZMuVo9waV9UCHHYm7cpFanxZdTzUfI=;
        b=biqU4aXunnW+Ivubo6AAStih02saSFcm/A0BAVAf0fP66QsB9ZTJqMVG0NLi+ZIQVe
         dv86FxQ+x6T9o2MyTSXZxglWMHKfoXQBSugY5v5baYKJLRhIt67PHWiNluhy9tYwPE7B
         yUppEjuoho4rn5HFtaBC7eMUSjwYyuHWykTYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEII/3fKlM7VRZMuVo9waV9UCHHYm7cpFanxZdTzUfI=;
        b=Ie9Vvx0qc0i2L6vP6Mc7CE8BxsCDHRVkzQ+6DQKHm9d23sB20N7U89NQ+/sgvGaPGT
         MTSDQqiQArkBpTiUUhKt5G/FcXKYsIRgOlmMcszCdg1fqiAQj4AyPhpDKj5teKBFEiO3
         FcLbKd6gj3tQh2KABe0F8isvN9fuSB79mfOUygarpny0uANCflHiR142csUOEGTNPbY4
         LHLNOk9Cm/oLK4gOtkRy4N8Q+9PKLYHvEK2MiCkKeVSs7+pnla2E7gpMENZC78bqJosz
         HrmGI4hRR05e32h6pkiAOvC7MpLmuqxz7YMxGuGYKjMLAOEQ0Xw7RFov/0UtBpWPWF51
         hHWQ==
X-Gm-Message-State: APt69E1VgV8gxjdwdNHaAOAya65yQjlfN3ZBJ3rQYUTim+fQxTifi5o3
        LNg7q5Cv6gUqTKLggRmnXQlt5Q==
X-Google-Smtp-Source: ADUXVKK7H1EI56c31XznnWBdzNJcFlb8kJAdzXLyBQbTdxAY3CgeYcV8/pduVfJZLrDYNS/pN2Z1nQ==
X-Received: by 2002:a2e:6f02:: with SMTP id k2-v6mr11739267ljc.72.1528723856439;
        Mon, 11 Jun 2018 06:30:56 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id u24-v6sm2617712ljj.96.2018.06.11.06.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:30:55 -0700 (PDT)
From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 0/6] net: ethernet: ti: cpsw: add MQPRIO and CBS Qdisc offload
Date: Mon, 11 Jun 2018 16:30:41 +0300
Message-Id: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
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

Ivan Khoronzhuk (6):
  net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
  net: ethernet: ti: cpdma: fit rated channels in backward order
  net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
  net: ethernet: ti: cpsw: add CBS Qdisc offload
  net: ethernet: ti: cpsw: restore shaper configuration while down/up
  Documentation: networking: cpsw: add MQPRIO & CBS offload examples

 Documentation/networking/cpsw.txt       | 540 ++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw.c          | 364 +++++++++++++++-
 drivers/net/ethernet/ti/davinci_cpdma.c |  31 +-
 3 files changed, 913 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/networking/cpsw.txt

-- 
2.17.1
