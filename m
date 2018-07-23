Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BF320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVudbTyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BF320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbeGWTA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:00:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38791 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeGWTA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:00:28 -0400
Received: by mail-qk0-f196.google.com with SMTP id 126-v6so973246qke.5;
        Mon, 23 Jul 2018 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XLFpeiWrBDEATcKd6F0YkIScfImEc491xYT10JYyjZg=;
        b=fVudbTyItmwLfolSwo+3z9mPmYHHn8jrt0zvOjxVipFcHWq0gZxxd6m5hSdzb8aX55
         pkdShvBf7m5A5zz+CnjzfK3qyMmHIIEVDNbetf4vBFtmtkkVJQu9+QjOwCaHS/wtkZOV
         Hr/6t49NzhCRBWC2s1JBnYU/jkTn5sH+O/17IhP+YOIZSqaii/R9Hpb+6Ob52USM5ZJX
         TV9uAR2fMW2lFCjFVXknrLFW6VbBMw41529yZReW4DjjGJ0vMCCR6X7EpuMnSv1h6fF3
         jL39S9FDrGewzT5QcnIXU8YBprfXLzgQ49UPEan+FxCWkcmNNy7uBh1PrMk+Byq8v4kV
         25mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XLFpeiWrBDEATcKd6F0YkIScfImEc491xYT10JYyjZg=;
        b=Zvl4dgylcOG2eLXZlNJw5wexQXvpfJkfsojxSh8gAzas3eUkFxdnafQkdQsRqmQ4Oa
         SaCuOSbTyuOeO7z+KnM9mTMJdgM5owyqv51cnESSPaIldX19/R1T6TCXbba2pUkDMisq
         QkNVVKqgUCFOqDlLXsyOAegdKPtgKMBFveVv4kaBvD5ZDEFd9PijewcRIcCN7Dt8Qq/M
         O/RUPm53xj25Axg2jo2oaEZaxsWoSCsVslMjtunrvB2a0ob2nOhqBCjDCRjwoFEkHhN5
         tMN6X62z9EhkoShOPR0eidDYTJv/1w4OtWxm8/WARnuPXCSCUrtgjMdldpk1GzkvHWA4
         mAoA==
X-Gm-Message-State: AOUpUlGxFaJyP+3n2xY3/wrUEYDioutREGyyuVJpM+yyGjLo142CUUfR
        7I60QDxz2m00ZlB0fppSzTdEw6gl8YE=
X-Google-Smtp-Source: AAOMgpdOX6n8Ib1cdAyZPXhtoqtiEcO8FlBama2FvYRBLb1eMZqk3JvYfsgGICq2/R1L7RP1VSM8oA==
X-Received: by 2002:a37:14e3:: with SMTP id 96-v6mr12451932qku.116.1532368685692;
        Mon, 23 Jul 2018 10:58:05 -0700 (PDT)
Received: from [192.168.44.96] (65.sub-174-226-2.myvzw.com. [174.226.2.65])
        by smtp.gmail.com with ESMTPSA id u129-v6sm6113943qkd.45.2018.07.23.10.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 10:58:05 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 0/2 V1] Add support for cpcap regulators on Tegra devices.
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Message-ID: <ddc14012-7afc-b3d9-7293-615a0dce1c7f@gmail.com>
Date:   Mon, 23 Jul 2018 13:58:03 -0400
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

Good Afternoon,

I am re-sending the whole patch set due to my error of accidentally 
converting the tabulation to spaces.

The CPCAP regulator driver can support various devices, but currently 
only supports Omap4 devices.
Adds the sw2 and sw4 voltage tables, which power the Tegra core, and a 
DT match for the Tegra device.
Tested on the Motorola Xoom MZ602.

v1:
Fix conversion of tabulation to spaces.

Peter Geis (2):
   Add sw2_sw4 voltage table to cpcap regulator.
   Add support for CPCAP regulators on Tegra devices.

  .../bindings/regulator/cpcap-regulator.txt    |   1 +
  drivers/regulator/cpcap-regulator.c           | 103 ++++++++++++++++++
  2 files changed, 104 insertions(+)

-- 
2.17.1
