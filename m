Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1720880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAOGKt/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD1720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbeGWVxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35331 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbeGWVxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so2002574wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z+Sb/4RKi9snFoiniRhX/5KAuF2szslsm1LnwDrG4K0=;
        b=EAOGKt/td5B0rgGn8U0jbtf5dU0MNUNlhcPWCeP8wg0XvEyiADiTZYTzlccVrGRIPB
         7jbN1yCBLMGKA32E/XdFB/9dHx6IRADgtj8liCAgpjGDD5UpywSkMs8gT4+Rdv34VCPx
         2gCoS7qBFbWGksJl3sjc/Hh4V6uGrrDCvpCTeEq8ZnldWYv7ChJPdMkYnR+2jXJA9Zed
         Ur21djBv2c3Lhd5hNfZNxK7bRseQa8gBAwqgxuAnyrJDpqzMpSw342coba1YuwCjx6Px
         C826JgwNMRYNBstBtrgnkD2kJgFNcdhShuFTD94m3b97k/T0V/jlORCOicq9oiCONVZF
         vulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z+Sb/4RKi9snFoiniRhX/5KAuF2szslsm1LnwDrG4K0=;
        b=o55dXd5F8Af36XD90qx8juspT004L3TO7ALuykao0Q2Mo40UEFm5nHoh1c55yzXAIf
         wADwDQKbmJrz7gNPePlv4yCdlo9DiJZYn3ZyWwWSES/oD4hHsgf5pL2pAD4k+Blkxdh0
         Qg6LIgeYE+nkDoX576Yffrte2abSpjHRjimU+VW9e8yWkWkjH8OXgQQgQlOicASYP4JZ
         WIBgaNFu8WEsiGj3OvzZCZVzzm8HJMbltwi4dwF6Y5ZBOcbkyB+V+htnVJ0r7Z5SPgiw
         783/fy0kaRfP+dnc2lvdwZ6j04CSqhFKDeA5yka6dTvX6LMporGiwmELWwp1UhsVusce
         el8Q==
X-Gm-Message-State: AOUpUlFJKVIvyy4YkSYPbDgqVyPSOUkLEUHPpi6HdAVLeouFZIuOImIA
        bD5epKvpQknMXXncZ3WKkoAGJWng
X-Google-Smtp-Source: AAOMgpd9zLm3OXs/2zjh8Y00wHgOlAjk7nkl4T5XrxaBnTsSxVw90U5wAuZ8s2UAHs94r5SFGHqQwg==
X-Received: by 2002:a5d:6601:: with SMTP id n1-v6mr3471214wru.281.1532379043715;
        Mon, 23 Jul 2018 13:50:43 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:42 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/15] Removal of usused definitions - Style
Date:   Mon, 23 Jul 2018 21:50:16 +0100
Message-Id: <20180723205031.19816-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up of the file drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h

A number of the definitions in the file are unused so were removed from
the file.

John Whitmore (15):
  staging:rtl8192u: Remove typedef of u32 to QOS_MODE - Style
  staging:rtl8192u: Remove unused enumerated type ACK_POLICY - Style
  staging:rtl8192u: Remove unused QOS definitions - Style
  staging:rtl8192u: Removed unused structure BSS_QOS - Style
  staging:rtl8192u: Remove unused structure STA_QOS - Style
  staging:rtl8192u: Remove unused structure QOS_CTRL_FIELD - Style
  staging:rtl8192u: Remove unused union QOS_INFO_FIELD - Style
  staging:rtl8192u: Remove the unused AC_CODING definitions - Style
  staging:rtl8192u: Remove unused enumerated type QOS_ELE_SUBTYPE -
    Style
  staging:rtl8192u: Remove unused structure QOS_TSTREAM - Style
  staging:rtl8192u: Remove unused structure WMM_TSPEC - Style
  staging:rtl8192u: Remove unused enumerated type ACM_METHOD - Style
  staging:rtl8192u: Remove unused structure ACM - Style
  staging:rtl8192u: Remove unused AC_UAPSD definitions - Style
  staging:rtl8192u: Remove unused definition of sQoSCtlLng - Style

 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 336 ------------------
 1 file changed, 336 deletions(-)

-- 
2.18.0

