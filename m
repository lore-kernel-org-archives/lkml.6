Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B97CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B466020693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeuvBCGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B466020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeFTDMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:12:46 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:37839 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753972AbeFTDMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:12:44 -0400
Received: by mail-pl0-f42.google.com with SMTP id 31-v6so930974plc.4;
        Tue, 19 Jun 2018 20:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=qLEqlNs2Tsej1THZNjXmq4yOTu9boAp9mTua8EpvQ5o=;
        b=eeuvBCGIPKXljkHUilFlh9vCk+bZHK8fzU39b146cm2lr/EBlATw4ce93AXOXxYibd
         sfdyloFwTUaItn7QSqaF1N3iBdA8Q34+VoDDB6YfYTqmvQv4Zt5YH6MCzeLkWCKrW9/i
         SmvhjEE+RjDf28pOc/tf7Kk3nYmS1RGT57UNqjf1Y6jHMMDT5rciUOFxXQVsCTOgynwb
         70kw+Sl1dcm/+g2yzkP2/1QpbhwKeuueGP7jBxKGlpCEa2c1rpkgbcJjqNXGWHqrg80t
         r/QfvIzKTcZSrTo0LjJC+yj965aIijuNeFroF1+WyewPip0tzKBcjNTgGr8uoDvjhEdA
         8dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=qLEqlNs2Tsej1THZNjXmq4yOTu9boAp9mTua8EpvQ5o=;
        b=M+7rUWUA81Jq2MP8pvsFv0kw7/jWvVXDeIJ3MZBp2zdtmYYGqKMsRmBp0ZSDLAzcvY
         3zruofpgS7TckrcHPLRq4V4ArD2VFj3RfFCD8ZAmj3LRn3KDNOrx+AYXjO3A0ZXC6XDD
         mwKbCP312cQTkXy5/1gcArmvaHsnz7YVISlycEYwMSYzrvimr+e65KrL5iVb5Dv7ChFS
         Q5Wsxr/ZeAs9Bh/g8WRFXbEyGN3XSox9gNofkRCW2Sb4f8PJbLR63b67IyLAKi85FlJo
         eNC5yVNrGoU2pKJjzRaNOFOk8KLy5SecmiAWVHumTiAoozRdz6vCn2TcPqKI0dwYeo1h
         pTYA==
X-Gm-Message-State: APt69E1jlbKX/JC8vGcBvPM5A2uR0j4/qpNbBRvL/w1o4HUttkm7hn9Z
        Ykl1yfzs1R9fAuHMApDlRKrCh9uU
X-Google-Smtp-Source: ADUXVKKX4HQiOHKJNvYzgi9b17p5zTbeKDBW93LGrDNwrDfdXA5fcGEzFaUyBfTuLxjMmu/yMviu6g==
X-Received: by 2002:a17:902:6105:: with SMTP id t5-v6mr21803105plj.138.1529464363846;
        Tue, 19 Jun 2018 20:12:43 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.11? ([2402:f000:1:1501:200:5efe:a66f:460b])
        by smtp.gmail.com with ESMTPSA id a10-v6sm985500pgw.90.2018.06.19.20.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 20:12:43 -0700 (PDT)
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] usb: xhci: Two possible sleep-in-atomic-context bugs
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <a2f62eac-b3e1-bd1e-3993-83e2f6adef03@gmail.com>
Date:   Wed, 20 Jun 2018 11:12:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.16.7 are:

[FUNC] schedule
drivers/base/power/runtime.c, 741: schedule in rpm_resume
drivers/base/power/runtime.c, 1322: rpm_resume in pm_runtime_forbid
drivers/usb/host/xhci-hub.c, 647: pm_runtime_forbid in xhci_enter_test_mode
drivers/usb/host/xhci-hub.c, 632: _raw_spin_lock_irqsave in 
xhci_enter_test_mode

[FUNC] schedule
drivers/base/power/runtime.c, 570: schedule in rpm_suspend
drivers/base/power/runtime.c, 434: rpm_suspend in rpm_idle
drivers/base/power/runtime.c, 1343: rpm_idle in pm_runtime_allow
drivers/usb/host/xhci-hub.c, 670: pm_runtime_allow in xhci_exit_test_mode
drivers/usb/host/xhci-hub.c, 1387: xhci_exit_test_mode in xhci_hub_control
drivers/usb/host/xhci-hub.c, 1038: _raw_spin_lock_irqsave in 
xhci_hub_control

These bugs are found by my static analysis tool (DSAC-2) and checked by my
code review.

I do not know how to correctly fix these bugs, so I just report them.


Best wishes,
Jia-Ju Bai
