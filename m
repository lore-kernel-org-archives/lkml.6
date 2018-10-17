Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3935DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F027721523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiyOmGBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F027721523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJQVNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:13:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38978 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJQVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:13:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so12534291pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RvCfURdXckyBrJoVSesx/S6C9+TP3eBpJdvmYIBHb6A=;
        b=aiyOmGBy0zNhX8Q1SAbWAqCphRtkUzSWiucZau1BCZVc2IDkAyvkpDnWul5NITIBJ7
         8VGvaRSG9V8E7synewApD5IZrEk+IBIEsP7+VWvbrlwSKzKyV/onteEiIhZX6boBV9RA
         heXrYUadMu23dIc0OIylZj+lO0ItSah5pBaxG27hBmZJR4SMGyEuSyxRDUGi1vzFSlWS
         xJBapJCSqtZRVRAjzCxSMdw1O18cvOgwCT+i5HKOG9AjaEQLGHSlnZs9AELUsSJ6ECXK
         YxNaRMxzJbOXnbj80rTeFvSDcgVol6HJosEmwMPbpGS2/gjjhRg5UHzTCXhthQNpomHf
         7LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RvCfURdXckyBrJoVSesx/S6C9+TP3eBpJdvmYIBHb6A=;
        b=RAipXCQ5477fxpuQ/QsX2U28lCmViFlglQxYDKE/jW8O+sE2KL0zvXF3Yv136+UqM8
         4ZQCI/MEgon0XdlKVSLvZijbJKZG99DlZUecDlB4fF6tLlKq8tMUgieijzXyB/okgkiY
         o4ZbmBq7fwyd1cCKo1P290YA1AOUQL+QKF8hxY3du8f8mjhEAFO7uBdyTqFR5rdh/VYO
         53Te1V8o12g3cBo+GKLW+Grndp8xinZElG9TGaKAuTNvvE6QggomEgJ6Fl9fxZrPrMRX
         rZrjVJSKlVdcsNrkQcAHjcwaV1CNyxyWp96FCMLIhZfUiqjDfLnQ2fmvV5XEPGQ0mgzQ
         VeXw==
X-Gm-Message-State: ABuFfogBKjT3PwJQvMpStAUD76vsRBEZNTYYLkNxVhTekNQ1gbFGCksf
        KL0JDXRdoLgkYNdp9P0jIYY=
X-Google-Smtp-Source: ACcGV62Jg84bxirGV1SrN+Xda6zAdJbRRT2cZ/poBuSU5qwOjswrr4W/s+A0mC+UvIyx4SJPACt33g==
X-Received: by 2002:a63:d84a:: with SMTP id k10-v6mr24450859pgj.314.1539782263449;
        Wed, 17 Oct 2018 06:17:43 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id l16-v6sm34943010pfj.179.2018.10.17.06.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:17:42 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     green.hu@gmail.com, deanbo422@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     greentime@andestech.com, Zong Li <zongbox@gmail.com>
Subject: [PATCH 0/2] Remove the no longer used mechanism
Date:   Wed, 17 Oct 2018 21:15:50 +0800
Message-Id: <cover.1539781832.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset remove the no longer used mechanism as follows:
1. Reserve the TLB space for UART mapping during booting.
2. Assign a value for UART display when an error ocurred during booting.

Zong Li (2):
  nds32: Remove the redundant assignment
  nds32: Fill all TLB entries with kernel image mapping

 arch/nds32/kernel/head.S | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

-- 
2.7.4

