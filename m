Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A46C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D682082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="zhbG5Koz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D682082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeKEMcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:32:19 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:54236 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeKEMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:32:19 -0500
Received: by mail-it1-f181.google.com with SMTP id r12-v6so7982692ita.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 19:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0+GdDQCJP/L91n50efTxaRIYjaTy+bnJbY46S8liEqg=;
        b=zhbG5KozA+MeB4Anm0ayfu0qyKTTb+6qZhaHnZCkd4x+jxUBomQqrDof526Lw6fanU
         qNUw8FEwD2AEw4YraQ90bNN13hw0lPQsPewaIs+bLR4b0rYZpW3WLucPO2eEXlvqH4z3
         uA1PJy7G1sM/o+GrmfR57xM0xfENJC6+m3DrxW6cA2pqPr7gNJ0UwpnH+NvLxds5+Is4
         DXOedj7ajxs/c7ytFwsDt5hzbZh3Nh1wS8HkanXKyZna/6IfomwbYWmufitzFPFXPrZs
         lmTb9MQxF2V1nKo0QL7rSiLR/hKf+ueMlEmADPx5PR+bpCU3xkZR2FgR6RtxcVVTMaXX
         iw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0+GdDQCJP/L91n50efTxaRIYjaTy+bnJbY46S8liEqg=;
        b=eNinKveWF90zSGPwm/AYgDkRk3owIKpi8bNUVxl1f0c5eeDo3t/6eeaNZs3+AlE3h0
         S3V9/t/MiQXnbFkWTSxx54XasHYSUA9ASVPPOEuNcgT+yGgG8T1ykb44df+bHaWM4DIl
         cUPll095pUi40QO06pZNlB3S1J/Tv+9m7dV4wQo0R4N15/wYtaFKCF5MkQP7X5plkfS9
         jpTBzV0g10iFmdiX0OHw3Omu2cUkjs0qfcRMeelWzzeS/Ae6DrRGgPhHtAhmXxWZi+Uq
         Jsuhm6lDcnBFcGnHB5ln7sqWnPoSckNUlUDIpfXFLshxRVflQaxsJMIJ0I0/JYgfY4dI
         k5pA==
X-Gm-Message-State: AGRZ1gI35FRu0GqpP38xoJ9jEDL8MuHi2G1zNVS/ISCVg6M1D/A00rky
        857aouydcOwUwon3GAbnqfPw8YJTkzk=
X-Google-Smtp-Source: AJdET5dPEFeI4llqIGiE0FB+hunm1Ei3/3aSKnrxrYJiJtr5v8k7F8YRKKuqZr5lwwmLRT8qkJkGrw==
X-Received: by 2002:a24:1989:: with SMTP id b131-v6mr5668755itb.105.1541387691468;
        Sun, 04 Nov 2018 19:14:51 -0800 (PST)
Received: from [192.168.43.100] ([172.58.142.130])
        by smtp.googlemail.com with ESMTPSA id n199-v6sm17687996itn.1.2018.11.04.19.14.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 19:14:50 -0800 (PST)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Rob Landley <rob@landley.net>
Subject: The CONFIG_UNWINDER_ORC bug is back.
Message-ID: <52931643-0c44-d571-b538-7d648139c1c9@landley.net>
Date:   Sun, 4 Nov 2018 21:14:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do "make defconfig" on x86-64, fire up menuconfig and select the frame pointer
uwinder (under kernel hacking -> choose unwinder) and:

$ make
Makefile:966: *** "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
please install libelf-dev, libelf-devel or elfutils-libelf-devel".  Stop.

Confirming:

$ grep UNWINDER .config
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y

Rob
