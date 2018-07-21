Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356AFECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E3720854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhPWa7aA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E3720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeGUBeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 21:34:08 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40317 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeGUBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 21:34:08 -0400
Received: by mail-qk0-f195.google.com with SMTP id c126-v6so7218855qkd.7;
        Fri, 20 Jul 2018 17:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ihg/8jer5BsW2VgIb54yzVxs964umeEWPrHqlNFHtDI=;
        b=YhPWa7aAjkrZWwqsvB7vR0Xi7Wz1ycSIKRsC9mh+5LzoZJkUCYhy7rziwfu/kJJ4uo
         MFMCw979GTLFzukc+2Yg/xQYB0MNqg6IQ5xzemmqVTK9zC8aCDRXcclpDLRyIZ4xmvE1
         nG28NbyRxCBS/2/z0QOS2Yl9HiB2C8Yl4INMX+Bjcs1uDqeI3d96hhG88TcMPJJCHpLe
         dAxESa9OCZAwOwovkesdfzYEGNHbQsJJJnPaFQqsTQUem2wq9XTjLvfJ6v48UDYLHgWz
         i81t+s/1ATZznJTPAnLz0ciLbd2K1Bonb7xCEq0wwKaN1bUwk9Dr6c0eTSwbpbPW311P
         t3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ihg/8jer5BsW2VgIb54yzVxs964umeEWPrHqlNFHtDI=;
        b=tMzQbrqrLI0d3YzoVLJ1EtPoTgtvfsmXFeiOhtH90ATksI/BpP3BuCMtUHrnmv3jJO
         ORCwknpN2DtbJFmETmT4z1uIr3tY1jPijXWKR7hWngIRzthXpRcjrDUI9Pwm2YOo0UB6
         Ufp9Qxb5TPWkT2x3wZtpI71VSMFHXndmNLXchlY3KwNDqrx41UJmvLAqG7MkVOpS/55q
         iEMsu1R7SXosErMx/J9dOjGmmi0nBa7PFh5qQWSeCg6O3N8PBvzoayQzH7aBZ4bCvprS
         HpK0bSO2HZOmCAkxInjDmWs+T8IIbMkWEdLEP2lNw0xlml4YJ9zoXEJwEAPNc1B1QumF
         4rbA==
X-Gm-Message-State: AOUpUlH5zlfYeuoSp+y1frAQb7MSHF/L0doiymXup2KdW8+IEuns4+oM
        4oRSSEDs4p+WBElsPUFefUABx6r6l9+Ncw==
X-Google-Smtp-Source: AAOMgpcm1w5jLgdqmzYonR8nzQ3JUlSNWzXol7XmUsfMkRc55Oad2IeeugdfWC1Je6BZ1t2wMuWVLw==
X-Received: by 2002:ae9:df87:: with SMTP id t129-v6mr3641037qkf.361.1532133806935;
        Fri, 20 Jul 2018 17:43:26 -0700 (PDT)
Received: from ?IPv6:2601:153:601:7d2a::100b? ([2601:153:601:7d2a::100b])
        by smtp.gmail.com with ESMTPSA id g207-v6sm2073615qke.41.2018.07.20.17.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 17:43:26 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 0/2] Add support for cpcap regulators on Tegra devices.
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Message-ID: <72f7b6c2-f5a0-fa27-da01-e37edc6024c3@gmail.com>
Date:   Fri, 20 Jul 2018 20:43:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Evening,

The CPCAP regulator driver can support various devices, but currently 
only supports Omap4 devices.
Adds the sw2 and sw4 voltage tables, which power the Tegra core, and a 
DT match for the Tegra device.
Tested on the Motorola Xoom MZ602.

Peter Geis (2):
   Add sw2_sw4 voltage table to cpcap regulator.
   Add support for CPCAP regulators on Tegra devices.

  .../bindings/regulator/cpcap-regulator.txt    |   1 +
  drivers/regulator/cpcap-regulator.c           | 103 ++++++++++++++++++
  2 files changed, 104 insertions(+)

-- 
2.17.1
