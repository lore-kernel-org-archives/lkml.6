Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865A1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD232080D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ryh2C4Bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD232080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeKLWUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:20:36 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37600 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeKLWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:20:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so2425451edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 04:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fss5laKnRtChi+dFlqgT5/YiGJG9bPOUSrD1xPma87Q=;
        b=Ryh2C4BgGymmd4xT0vVbpcBB3b9ZoUwmTtuU4NmW9qyEbAbQqzNDBP7d+//udU1UqF
         8SYbeWozmDXunBNX3EYCLicxcRdBi6D1I/iQIQY4M/wDcVnMVyUMOf15O+z5DJG0R32Y
         MHEzNFDZwno5VvTEZD47TlDxO9M4gAJYJAkZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fss5laKnRtChi+dFlqgT5/YiGJG9bPOUSrD1xPma87Q=;
        b=MQJUm98BAu4KkMHNN6dxj8iZH6qmjtF3jtrSl4jLDYEKkZJJnV6/Jr8W5k8w4+gjyy
         8M8s6F3TyCEaLtEAjhCHdZtVu/1+jqyTgxKuhNCr/Ntnr1TPCddL4MlNzRH4Lsl/Nwtf
         pthDrsFXYRmkIxNAL1UWQ5nW25M05rezQCsCGqky0bTSzALSEnAo0P3ZdMEHD107Q0Hz
         /sRxYwKfgWm8/5NGaUcKyVorSz6d7Mo7Kf0/W/En+G//YgnYfyDfkvDa0ccORbqMuCjz
         1bNY8EjptjX1TjuhmlkuxYH8cYGBZrej3uKFDjeE0pl45TmRutSQzQZegl+J/9Y81cwU
         W2kQ==
X-Gm-Message-State: AGRZ1gJW0yPmMrOKd4T+/FNtcHhBgtKMb1hyn+ASvzNN+E90QFV+buaa
        RKeBwVk5Ogu4+viiCWOn8oZR/Q==
X-Google-Smtp-Source: AJdET5e4jf0eUtgH29nH2jv06JdRpcD9FA/JzyZ7w0cWYmIj4p5/eqxuKCnPDqj6nm9KyaNkSs0qyA==
X-Received: by 2002:a50:88c3:: with SMTP id d61-v6mr12794501edd.14.1542025649962;
        Mon, 12 Nov 2018 04:27:29 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f11-v6sm4358545eds.23.2018.11.12.04.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 04:27:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     niklas.cassel@linaro.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: ngd: enable compile test
Date:   Mon, 12 Nov 2018 12:25:24 +0000
Message-Id: <20181112122526.10337-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes few issues with Kconfig and make the driver able
to compile test on other archs.

First patch fixes x86 build error and second one enables the compile test.
Second one fixes Kconfigs and add compile test flag.

thanks,
srini

Niklas Cassel (1):
  slimbus: ngd: QCOM_QMI_HELPERS has to be selected

Srinivas Kandagatla (1):
  slimbus: ngd: Fix build error on x86

 drivers/slimbus/Kconfig         | 5 +++--
 drivers/slimbus/qcom-ngd-ctrl.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.19.1

