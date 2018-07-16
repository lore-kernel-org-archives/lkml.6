Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E8DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB77320844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyp+E8yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB77320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbeGPMq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:46:29 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35196 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbeGPMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:46:28 -0400
Received: by mail-wr1-f44.google.com with SMTP id a3-v6so22459851wrt.2;
        Mon, 16 Jul 2018 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=MEENswka685bqvM84rhpfFT4pEy8sdWXD4501BY2glk=;
        b=uyp+E8yzOQTWOWfeHAtt+OlgBqO20JC2Gj6omnyT4ACA2PpeuCLRmT324k9c5WUCBN
         yXaTr6YT1vtjXB2kyxcbCR2BBxhudMV/eGmlMlyWMF8hyV+p/CS9OAy0x0WYxmYJPyjs
         IuUpXqVzvHH/Jt5UN2WfTigdR89ez0hkZYdj3ul6Vv4VU3gbEKgaS95ITtwkbajPPmC9
         Uv82OWJoiwkabBPzMA+/LjCTamj0QxxgzCCwCFPrNZlrDcOp2dsuOBVb4p7hf9YNaKqh
         2Us1GS9qbC/5bzC69hjGHHNjbZPaAtiaxeZVlOmYNNurZxAda877INvmJM0WM7Hug9uM
         V5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=MEENswka685bqvM84rhpfFT4pEy8sdWXD4501BY2glk=;
        b=nYuQUIINe6PQSlh5j5rZeRl46G5937yIf9AUHUZ/ysSACL/TYM4aqRa1bpUKslqJd1
         VI0Wl2aAnl8xtXtOy+SHFToKT1Q85bdPafQjpLgziUikxX/Dv04Vs4MlQRTuJPZj6/00
         lzuJUH2LSyMYfvbAWP4NgjJJwfZ/UxtnUQo1PfK3JP/Elx3HQBviUyjC0QgZRF4caSDG
         iQ82pdk8J4P5XonuPl1rEmm93Z8oWgiAKu+hWj7mWvir6WHB5KeMKEebFBMiwhaAZaFR
         G111KC1xFeeLC924qqaYx0nsXzpwEe891uAYOdT93xorEFCumHqCv/MIsVqyV3qVVnRG
         X1fg==
X-Gm-Message-State: AOUpUlHstWrMu92qQ2d8AmGVGgCyNbAajYMUHo0hyvKNd4Txszhr3LoR
        mC8zwT7gEQ1JQ0r6TmtsySIvMzmw
X-Google-Smtp-Source: AAOMgpdcNmJlxbllph1ms6+H8yaWINdN3/8T24oJTmVbNLFm4LtbbOIe4+MnFKOt0TVboJB09KKDNQ==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr12350492wrb.127.1531743556608;
        Mon, 16 Jul 2018 05:19:16 -0700 (PDT)
Received: from mdionisio-BM1AF-BP1AF-BM6AF.powersoft.it (net-93-146-228-90.cust.vodafonedsl.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id z3-v6sm30264828wru.27.2018.07.16.05.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:19:15 -0700 (PDT)
From:   michele.dionisio@gmail.com
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: watchdog: davinci_wdt: add possibility to configure watchdog period 
Date:   Mon, 16 Jul 2018 14:19:08 +0200
Message-Id: <20180716121909.4869-1-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, 
in davinci_wdt it is not possible to configure watchdog period. It is also
impossible to stop the watchdog so it is usefull to configure the watchdog 
before start it the first time. This patch add a module parameter to configure
the starting period before stat the watchdog (default behaviour is not changed).

I think it is a good idea to integrate this patch in mainline.

Many thanks for any comment/review and 
regards
Michele Dionisio

