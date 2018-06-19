Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD2DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD052075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cirz8YI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD052075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030769AbeFST47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:56:59 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40642 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030472AbeFST4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:56:55 -0400
Received: by mail-wm0-f50.google.com with SMTP id n5-v6so2602017wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nhWXV+HnXMAZwmM1pAyAl05/pUsjQkBzEsdd8rrlsuk=;
        b=Cirz8YI/BIdrtmEQFHc6cAjRKGyfFmxtp0sOu0d4glXnr7lWItUODkUWEU58Sw04AD
         NyjboroTjMatqWZP/xqIVZNQIBvi23a5qpBvR6gC0yImT86ccGJUBg3PMHGI/cZN1Z5h
         ZFVGrro4F1C0hE2dNGLBlgFktLJachc1Ztr0Uxb49UyYJRtOcxHLGMo9AAkFODJvAHg2
         WJmhkNc8OhZGcIsOPnqD7tcpRgklMgmcGrJJIZbb173nKbUbLmbG7W9o97C7HmAJx5Bt
         JqSEJ/56FMN+6n8Lm0FDM7z2uWNU4VgBSn5+bjW+9r3PH01nL2/gIYWmtqg2fxLkM4O1
         sC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nhWXV+HnXMAZwmM1pAyAl05/pUsjQkBzEsdd8rrlsuk=;
        b=d9CPZi/+1j5XW4Nq6LEGk4WF7L0T9mx86mdPFRmK+w3mxUbPUqW8/eoBhNpItmDMgm
         llQ2G4QZpTpoCye5jaD5hUEhRP1dBKXQt23S5ch2h30M4YucuBEDu0DsKVFM90hjAUeN
         MH1B1507EzhjoU9q/PuNjcPRdcKsaR3ksqU2lHInpbX33Mkoy1gn36tPwQeIoa6Pb35A
         S3Ml/h63zf8nvZE6vEt0rhHESGeHBozUCyQjBYU/xTTZNF0y4GdXYVvZpfDed3mRnBgR
         KmHVkVgUMFdXY4SgLhN27SOz9VITLNHJLT/Cv2UxLyTYKuDhsOEXyGNdBDszkPKrzC25
         e9WA==
X-Gm-Message-State: APt69E2ANEZ80tBth862tMwkH4sAVzGX+7aFxzfiG3snB54r3OJy0w++
        AbuPudFhBIIPXtgp0EFQjtFGFw==
X-Google-Smtp-Source: ADUXVKLFYD26PIptADcVBJzsrVKYJARhJMl/+rl7xrNySz8lES3AJxjfDhK/apaRl/QU1VMlhNzlWw==
X-Received: by 2002:a1c:d809:: with SMTP id p9-v6mr12519890wmg.111.1529438213812;
        Tue, 19 Jun 2018 12:56:53 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:56:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: v1 Coding style changes
Date:   Tue, 19 Jun 2018 20:55:56 +0100
Message-Id: <20180619195605.31321-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple coding style changes to single file
drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c


