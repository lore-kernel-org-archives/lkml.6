Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B9C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6A920834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMiHZPhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6A920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeLAER6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:17:58 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:37331 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeLAER6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:17:58 -0500
Received: by mail-it1-f172.google.com with SMTP id b5so10300664iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A6d95ynj6282wRxqz4fQaV//wfF55DnLPOF8iKAUftM=;
        b=HMiHZPhpcadrFA4lLWOWpptyTvo+HIBfq2nSmwuk6bY+1eiiMpUh8t5HuD5gz4T/RY
         6jjTlTeU/XHKnyI7qh5TphMCAVXwzonSai3VUbwEhVnvAhxSfu9STe9l6RmRFPSt6RGo
         N4JRnt5ZSGkZEdzBoaF88YD04icGOxS1pN62JGXfdFHYw5YdrZeCsN/Hql8ntPJJxVYD
         BbsaTnNYHSv2y4Wgh8WiMwSd9LVOR+hLlZFKyLFyVII9GZuNdGiZ6NLKC1aib+LxKI9m
         SMR5Q/QOaUbIhs6whPYW8cBbHunby0ig16kEz/Lk/W1GOujrOj6+YoG9mI1F7PguzMim
         76Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A6d95ynj6282wRxqz4fQaV//wfF55DnLPOF8iKAUftM=;
        b=BGg9SUnBH8Mfut88ekPp3OXvoQGcE3G/J8fO7IXDAFb1EmCMI1dcVnakAVJ2yo3F+e
         5oYvLOqVAa7/QXglwooF0AqScOdZuHlCqXLYqm7+JlOCko3Jeo25jJ1B8MC5doRECx/G
         rBM2WurCMqrUACo2e+5MLsEq6+zHqkuNbhhQFhRMfk14PDwvkJfa6HcxJUbyTpfNDtKE
         j5B61MfVOWhz9R6RPNi5AGLvZ7PQ8Z80BQGESzi+cySoRtATstYn+ZExEOFAhYnOnBKx
         URzFP9LQ8nEaE7DY9W8B/B4otusuA+GbXTHn31hg74wiMSDPliu6buBec4pephoqVVFn
         h+JA==
X-Gm-Message-State: AA+aEWa3jVgBEcqCjScfmhmLTQmvYlxcnT5amVzr2EJ9axcxKbThHtsO
        iD+Q8HH3r8N/VwlO+nhIfzc=
X-Google-Smtp-Source: AFSGD/Vm7clou12PpvYZskOpBNtLdxxXx64yicn6rjCjn1KqurSuxDrfOO1YkAqnq1GSqu4UTGmg6g==
X-Received: by 2002:a24:2716:: with SMTP id g22mr5347402ita.40.1543597680884;
        Fri, 30 Nov 2018 09:08:00 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id u26sm2143387iob.31.2018.11.30.09.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:08:00 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] bus: imx-weim
Date:   Fri, 30 Nov 2018 12:07:52 -0500
Message-Id: <20181130170754.346-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@googlemail.com>

Support multiple address ranges per child node on imx-weim.
While we're at it, insert some code which guards against common config
conflicts.

Sven Van Asbroeck (2):
  bus: imx-weim: support multiple address ranges per child node
  bus: imx-weim: guard against timing configuration conflicts

 drivers/bus/imx-weim.c | 69 +++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

-- 
2.17.1

