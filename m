Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25615C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD60320868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlIxUTvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD60320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeK3XCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:02:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43668 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeK3XCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:02:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id f4so4591176edq.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhJWv/tl2gdo70ED6FfaBwGMPgLmh1RSYD2/eX0+nEU=;
        b=YlIxUTvZepxxmK9LAstvOmYJWNv4WVTbucIRY8zol0Xih1TfpNkgk+/bve9AblOb+x
         QeElm/ticcE4gRenjTimNPZNk+9AnqFX1veqwEzpEC2qo6tnlbdHVNxHmOisp6HdzQFq
         ATXncY67fIltCF0exGC7kp52vAUq76/Az3lCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhJWv/tl2gdo70ED6FfaBwGMPgLmh1RSYD2/eX0+nEU=;
        b=GMMuUTXIkSsS6kh1Yz13lJGRm2qA+Vvy2kiBbo3R9ZSZfFCTl5ga/5Hlxo3ffT2BOj
         J2nwYQhQikqNo8isAvHZq2cMclzvazx9FUymJVfd8nLVeUDQN/0TChL7GBa9j23tp63f
         NP6v1IDHmfn/hgRFERr3ij5B9Wv7gKReY/2GFfBlLaEOw+S7jJ0HcLuBVlAP+IcRmBT4
         r+/Jb9Oiv5nD+2H6wJjbBICI9NpGUnHR5S/PjooAXjZzWmBk3AWHCaKf7psBdU/KdouG
         afcc2/5E8BDFoJS4iAKep0uE6Oc9xJJYZ9NUlJ1Fnj7UaT/ZCMXez0UGoBZGunJ4S9sg
         V9HA==
X-Gm-Message-State: AA+aEWbXZIOCFK+UDC/ld6c4p2AKPfA7nsH/m4L/nqvZtSRRw7uD1qhD
        O8SXs4G/RqDVeqdEBAfTwlCEdA==
X-Google-Smtp-Source: AFSGD/Vc7YrtWG2CYmAyeiNNPTY7SpcNuvvRSgW2FjWzF1ey9W8EPwntydZtVUOTUgJW6NqfJ0Ajlg==
X-Received: by 2002:a50:87d9:: with SMTP id 25mr4934097edz.259.1543578816325;
        Fri, 30 Nov 2018 03:53:36 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t10-v6sm767932ejg.41.2018.11.30.03.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:53:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] nvmem: patches for 4.21
Date:   Fri, 30 Nov 2018 11:53:19 +0000
Message-Id: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This patchset adds support to
	- new meson-efuse peripheral clock
	- add type attribute
	- add new config option to ignore dt node to scan cells.

Can you please pick them up for 4.21.

thanks,
srini


Alexandre Belloni (1):
  nvmem: add type attribute

Andy Shevchenko (1):
  nvmem: Move nvmem_type_str array to its only user

Bartosz Golaszewski (1):
  nvmem: add new config option

Jerome Brunet (3):
  nvmem: meson-efuse: add error message on user_max failure.
  nvmem: meson-efuse: bindings: add peripheral clock
  nvmem: meson-efuse: add peripheral clock

 .../bindings/nvmem/amlogic-efuse.txt          |  3 ++
 drivers/nvmem/core.c                          | 31 ++++++++++++++++++-
 drivers/nvmem/meson-efuse.c                   | 29 ++++++++++++++++-
 include/linux/nvmem-provider.h                | 11 +++++++
 4 files changed, 72 insertions(+), 2 deletions(-)

-- 
2.19.2

