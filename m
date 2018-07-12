Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC255EC2CF4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DA7208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="zSNkj9s4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DA7208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeGLTD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:03:56 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37224 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeGLTD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:03:56 -0400
Received: by mail-wr1-f50.google.com with SMTP id q10-v6so22721990wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QbWSpP4hEVkZZTtoBspbWyZcUHglKk3NZFJ/EkyVPP4=;
        b=zSNkj9s4B3QVxdn2O0lC+5T1ovM+kwxEYVFDG7g7eb8mqGsbPj0+Ta16tj7hFoYnHF
         P6L2Eas3UQEpCfUtxGdU1r6ANaaS4x5fD/YoqtkmMEd2+FcltXbz1WsK+oFgbbsGnz3u
         Knpi6jaFaGdE65WZYOk6Qje9RW9DovIHYbn8zNFcL4ag+ASCtflmKlO1IAbOBLlwjKJi
         wNIkZUkhk0u5vTQeXghEg+k2nYVGYVzEYhUqDpLJE1/xKr6PyB4Giouhcnwwm92wOdDr
         49HRj1RdtpW1bAcP5ui0qSSyN2+g4bWfVs9TSo8HvrTQwqKrV4p8YyIhbSo9x8LEVwgk
         f18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QbWSpP4hEVkZZTtoBspbWyZcUHglKk3NZFJ/EkyVPP4=;
        b=ckgrkvq8Q1FycBSUVDnahBq1WUgBiSDFEEMAvtiSNckWU0FJXTWSI4o+mpZvRuqXU0
         B6LAgVnB5sS8HZDs7ZXreFVjuYi1imHu3o5SuxyPYFyqW2pKfUp7U7WDVtDMT3hIXYOO
         SZwRnu1z+JQ77tIdcwg7BQrClfaIp4vcJrHFOmFz2SPSvHRpeGeY77UC+VJ53pKOVdDh
         A3GsANckom3zPFgXiLm4CU/cQu92miGPo/JUmZR/dqT8oi11w8bdSEQJ1+8W4jBeAF4J
         Mc0XIg3mPEXkHdmsZFlQaO/wJnIUZZ20E9oEgFrWImgAfVQnNHnYTu94Dc1cXbhl2YVJ
         2Vjw==
X-Gm-Message-State: AOUpUlHHpuE++UaMW75w4LEjk8YJb9kHu3Vr4tEY34miYb63D+WJP3pQ
        +yTyrOrqXm3/xSmBaOXqlOsYcQ==
X-Google-Smtp-Source: AAOMgpdKVuz8RlCQ1IZxrNdSnZ0ZbsfunRexb3QyhmZKj/hVroRUc2yqA7aq/8eVMTE5PER0eBdYhw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13-v6mr2524724wru.80.1531421586165;
        Thu, 12 Jul 2018 11:53:06 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:05 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/12 V3] ipc: cleanups & bugfixes, rhashtable update
Date:   Thu, 12 Jul 2018 20:52:29 +0200
Message-Id: <20180712185241.4017-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have added all all review findings and rediffed the patches

- patch #1-#6: Fix syzcall findings & further race cleanups
	patch #1 has an updated subject/comment
	patch #2 contains the squashed result of Dmitrys change and my
	own updates.
	patch #6 is replaced by the proposal from Davidlohr
- patch #7-#10: rhashtable improvement from Davidlohr
- patch #11: A variable rename patch: id/lid/idx/uid were a mess
- patch #12: change a return code from int to bool, side effect of the
	refcount_t introduction.

@Andrew:
Can you merge the patches into -mm/next?

I have not seen any issues in my tests.

--
	Manfred
