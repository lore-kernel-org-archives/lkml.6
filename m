Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D06C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6213820868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTE4fFiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6213820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbeLHMFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:05:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38072 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeLHMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:05:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so5801647ede.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 04:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=upJ4W9sZXaJvX52jmKfQ0MU6kTlF2DPCYP7RKfK3vyk=;
        b=JTE4fFiF/IaCbl5cD3qvnNTNYXu8pwCgcEOmiBC2HiFRRhUxImN+ED6Zvuvc2j2aEn
         2WChYj+62MQGKAJJ2Nbm4E5pmmpu5a/XT1MGNVV5+jCrIbTXBdUGbec9zpVN7fVcchSF
         9LzmYXbgg8ZNFOKNP4+2fhWLv29ZSErTwP7ePNa20IWA9UyHJjmuVNsZIbOzeXhgYgzR
         o7UXLVU1YbeCkF/amxyWgEBv79ZSD44O/NVdpsHorPpgpLlYRpALMDek6uf6cK0oCrqw
         UZf6H/V3NKAyBD7Khdr0izpc9jHMtIiS0ZzSX8blxmNM7wLV7OIclp2q9mxvaza7+8mK
         1ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=upJ4W9sZXaJvX52jmKfQ0MU6kTlF2DPCYP7RKfK3vyk=;
        b=YHqFgGiUqc8W0ggTllFDgiru05Y9Z3CwCaf3HbJm5HMp8IpYINc5E5yM5Bxq/oCDPh
         j0AHGpv12rQHCeFeAwN1dsC8iJQ6XN5QuvC2D7sRNBBLqGP2qI4Lgg62ol8QZrCUYWGS
         WBG0/07DElyYUDVRWxhiwVfvG8kbSp3tkITt28C4yNSeYVXlvT0028F90tk6G5UeQAVN
         psYsoAqmD7SVrEJxkaITIIrI1lElJcTLsgyUiKCUx4NliRzXYqmif1tzxISaVScHNLj1
         gsgiJfMamRCDGKJcQZDTG6+6cQhAB3AzxU/s8SAT76gfCSAfDnCF2EJL1cEhVqWVAVpk
         j4vQ==
X-Gm-Message-State: AA+aEWY3s7NsZewDC8ulN5en6aUxEMT0oBmJLc4nLj8J0xckwMOk56fe
        CRwVgTXYTVC6Fy12kY4aVnbYK6X1cXdG7QaPf+cpBXjmBMM=
X-Google-Smtp-Source: AFSGD/X6SMQXPVPAjgMXuMWPZRs7MbPz43K2YnqoRZGjIpGqgvcnIpKI7d2yqiduV+JYxU5SFlHrtpniU68zwHkQmTY=
X-Received: by 2002:a50:9ac4:: with SMTP id p62mr5338602edb.179.1544270702165;
 Sat, 08 Dec 2018 04:05:02 -0800 (PST)
MIME-Version: 1.0
From:   Lei Wen <adrian.wenl@gmail.com>
Date:   Sat, 8 Dec 2018 20:04:50 +0800
Message-ID: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
Subject: Coresight etmv4 enable over 32bit kernel
To:     mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        leiwen@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

I am enabling etmv4 coresight over one Cortex-A7 soc, using 32bit kernel.
And I am following [1] to do experiment regarding the addr_range feature.
The default addr_range is set as _stext~_etext, and it works fine with
etb as sink,
and etm as source. I could see there are valid kernel addresses using OpenCSD.

But while I try to store one small range of address pair, which contain only one
kernel function. It doesn't behavior like what said in [1], the write
pointer would
grows rapidly with the read pointer. And I dump the etb buffer and parse it with
openCSD, finding that there is no I_ASYNC packet in the dump and is fulled with
I_NOT_SYNC.

So my question is why ETB continue to grow when there is no trigger at all?
Is it normal? I could provide more info if you need it.

[1]: https://wiki.linaro.org/WorklingGroups/Kernel/Coresight/traceDecodingWithDS5

Thanks,
Lei
