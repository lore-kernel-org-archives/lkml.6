Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAA3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7070021582
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjFeZT2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7070021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeKNFfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:35:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37237 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:35:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id j10so430798wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4VXjzxcwwXlCyyFjtTx3GqLr9Oz4i3d3cX1C2QRDmhk=;
        b=kjFeZT2Ca6TOV+UHjupHaJ8o2b2OKhzympDtUoTh8gv+Ut7JAaXrMXtjSQma2jniA8
         tJxm0xnBrjjO5mtv4AE5lJSibVnzoFw/d6Wfatct5hmNZlblQVAW+V8gXVgIJiTlwlhH
         x7NjkEdwJDvGpK4dNShCnGqvdwp0YDEvh6LNeS2uHHMW/oXHKKlCnqspU8fTUitCdljw
         57apoFdNhb5adRJEk5WLO15D0DswhzH6x0UVTAVZ/UPfebK2O1sz0VmKv6ir/+wvNPlg
         UFb7XBJ6XpvGdV75vxu0SZTA69kAr8x6qzyymvB6NPvHM0xH5jSKqBuFsQs0nD+oLEd2
         +Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4VXjzxcwwXlCyyFjtTx3GqLr9Oz4i3d3cX1C2QRDmhk=;
        b=QFzsU7QtDUZcgYPZ5TcS0XRvkBjdwfm7S0Fj1VUQDMH1L3EmUYc6+BVuQV/WFmOEsH
         u8jz4Iq70z9RL3Hx0QP8zQ4Rg+Z7tSimGW7r0NNZjpZolFlDSCYlvQwQNxtNfHiA3BUs
         CcdclIbo+b63ZKK5TPLjCArXXQ+AoI5Vczh56mdQvmgg+JXJcr0eDpi8dWEBnkqpGMSP
         B5w8AR3H3gwnE42R0QWXlksTHB7CQjqcBAxdfljjql3eMUG7XNFkYoJA1WLA8Bnda8sO
         4LVExixZa2VSZJSWXMQmtnkIJqCskCoV4Zk/4m2mcrAi7zf2DEHH4drYcNPqv8DwQpDy
         3+8Q==
X-Gm-Message-State: AGRZ1gKpJDP3JjZJ9nCcqS70iy8FJBa089izipoXBVCHu6xzu7jurzO1
        5La6symmLaqq+YjUyRgXbqc=
X-Google-Smtp-Source: AJdET5fa4QEGis8oVxXMf7oULvsD7IvgmV3jePTVtJWj8tD3I+GeNSfDZa5dneVETNC1HSxDvNHIRw==
X-Received: by 2002:adf:f04d:: with SMTP id t13-v6mr1432510wro.170.1542137725441;
        Tue, 13 Nov 2018 11:35:25 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id o15sm1199484wrp.12.2018.11.13.11.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:35:24 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Aligh parenthesis and split lines
Date:   Tue, 13 Nov 2018 20:34:37 +0100
Message-Id: <1542137679-31726-1-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542064736-27655-1-git-send-email-sicilia.cristian@gmail.com>
References: <1542064736-27655-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first patch I added some space to align previous
parenthesis.
In the second patch split a line to stay in 80 characters.

Cristian Sicilia (2):
  staging: rtlwifi: Add spaces to match open parenthesis
  staging: rtlwifi: Add new line to stay in 80 characters

 drivers/staging/rtlwifi/core.c | 3 ++-
 drivers/staging/rtlwifi/ps.c   | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 

This two patch was sent in two different mail, now are
in a single patchset.

2.7.4

