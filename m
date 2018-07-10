Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0957AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B587B208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpAUm+7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B587B208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeGJPFu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:05:50 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41305 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeGJPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:05:49 -0400
Received: by mail-ed1-f49.google.com with SMTP id s24-v6so616278edr.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uq6bt3JiiJC7jxzvDIw8Uca9WAUv4ynFEpA9Uozs/88=;
        b=XpAUm+7PKEpz4UU4HUDjX9+Kj0QOZ6BNLMxac/rgu/cW2qDPErxVo7iIKojOAUzB+f
         HMFf/CkXdpPvy/lxNH7kLwkyTy9Labso3xHwbjPq2VCT3SCWitlmAb3pT4N13VeXNysL
         AIR0tvEZr4l0KzNhMh4ITkPNX1qHePS2h5H0LN/mgUy6E0CUYg4oPr3wXei/fQejXbL0
         C86Smjy6jr21HTS3Y5IvOsU4q/bX27oMPRQnu+WsPE9NIMFZrgzO7qgZ0FWpnuBaDz3o
         Q3JjpMx9WF6UTZAqppV1OmJXsQiYyjzzo/vQij7kpvfk19PdHILMUbYk9y2jMDyxvgEP
         k5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uq6bt3JiiJC7jxzvDIw8Uca9WAUv4ynFEpA9Uozs/88=;
        b=XWrdShvUSsnwuhzGzacI6QbU1myyo7Ykrlp7UZW6jwd3vLakkma+ByK70273PhlBpl
         TCdWPaD97I0I8vdMFxEJQWBI4Rm/IQLGun6lkIkbD0153qioTgPHKdeSy3kUeRJfm0gR
         WD8JybflKXwsLDbGoLO8DnA0vRHRz/tyu7x/zvvJLnwLKaxK9Cg8E/CFvpiszeYKubCu
         jwoXO0MqPJbOXivN2Yqv/pInihoR7peSLPrs45z9MCQkmZ+0zqmSddKi0JGG1oNzLNVS
         M3X5Reu+c1pTbdQGI71PSk9xejhEN0AnPZqBMEAU3EdPjFDs0/g0KKurd+9+HoBDFNLK
         GtAQ==
X-Gm-Message-State: APt69E2OeQLhQB+zELP/g/C9pm1183T86EkgfSC0CJCUz7xJPBVg3OT7
        fXmfakprSbvUkpCnIxSZaTIJga7S
X-Google-Smtp-Source: AAOMgpcG87iU3glfhdOspjdEQPBFOq0AyaggDN2eXC/qv2S6b14TWfB7DV6A2xaoGRMavhdO5uXWiQ==
X-Received: by 2002:a50:de03:: with SMTP id z3-v6mr27419113edk.245.1531235148058;
        Tue, 10 Jul 2018 08:05:48 -0700 (PDT)
Received: from localhost.localdomain ([109.76.156.5])
        by smtp.gmail.com with ESMTPSA id s19-v6sm1895389edd.53.2018.07.10.08.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:05:46 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de
Subject: [PATCH v2 0/8] staging:rtl8192u Coding style changes
Date:   Tue, 10 Jul 2018 16:05:15 +0100
Message-Id: <20180710150523.17384-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My last attempt saw some patches applied but a bad commit message resulted in a rejection and subsequent patches not applying. These patches are more or less the same but the numbers have changed from 3, 5, 7, 8, 9, 10, 11 & 12 to 1-8.



