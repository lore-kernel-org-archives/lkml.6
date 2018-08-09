Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CE8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB082238F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUQkKTn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB082238F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeHJBAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:00:47 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36955 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHJBAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:00:47 -0400
Received: by mail-qk0-f196.google.com with SMTP id t79-v6so5202949qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=HMq6Vfe/Nymr+KMcqzkv9JWl3X4GP+3PgZH3m3QM3ss=;
        b=QUQkKTn6FYnftq0ZpnDfDeLqDmxKeGI6gMnlUndlSp0Ns2xHgptwifDxpajl6WLoW2
         rScCKikPh6Sco6JNflfNaqRMlyDth7jVdrNDQQGFrTpWziLa9f3JKhUCjdGuUGT2RD/p
         4h6RJ4cbJMfwzamT+TK41iQgJwk3UCfyj/onJxxR+J8GWcxoNzaomKoEOPvsw1mZB/uv
         u82Q4rCxMYDQilOo+jPEPOHds93yQznrcMlP//SH19KtbNQGRD/aWkaBTJGR9cfhW+En
         9+CC5mskVfSxHoxcrpkD612J9h9Ff9T7KlwnjG1YY+4W820YEgmVMTgP5ELrdz0/uqdB
         vPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=HMq6Vfe/Nymr+KMcqzkv9JWl3X4GP+3PgZH3m3QM3ss=;
        b=eqDfqxRiuUH7rzs/my1CcAoaDz5afj7LxApshoEtPI8ohxkozkiQjpGsUj7aSYc5HL
         5UJTZD06fhn2O6Kdwtc7cgDEnM76yq5CHXiPFiuZ+6ryx6yjYsMjf11Tyy3Y3LLVZ/Zn
         Zw5VyIRJZgOiY/c7axRE9K7TcrEpHYckV2WK9zV47Pcs4GsCKcS6VFvKUB9MfA/VZzFM
         jsg6lLVt6/IPvV6ZMM+i4+7dyJWwPJfB9OXhsdRIGtP3KyHQkrtAF4BAPYrEEv/8DY48
         FmfSUf1yO1VpQQurJCh1vmOFEdHrNSsHg9oJv8EjQx5eiOGTuE2fSK1XE51YgTGKzuo6
         Zphw==
X-Gm-Message-State: AOUpUlEdx01X9T9aln/iHyCPP18VrWXGhBIN61gfwoXF7r/h5U6Tk9vR
        f5/f8C/v4No30ME9ceFNUyY=
X-Google-Smtp-Source: AA+uWPylkc4gVYqYU5jUlXq35Gd2V8y+NfcNQ8ztVxFPahJ0dXevvZSIcPs7Rwh9BXyFS5qJiPMSdg==
X-Received: by 2002:a37:641:: with SMTP id 62-v6mr3646255qkg.227.1533854030933;
        Thu, 09 Aug 2018 15:33:50 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id 14-v6sm5929550qty.57.2018.08.09.15.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 15:33:50 -0700 (PDT)
Date:   Thu, 9 Aug 2018 19:33:43 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Style changes
Message-ID: <cover.1533853354.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some style changes to help readability.

Leonardo Brás (3):
  staging: fbtft: Includes description to mutex and spinlock - Style
  staging: fbtft: Replaces (1 << n) for macro BIT(n) - Style
  staging: fbtft: Corrects long index line  - Style

 drivers/staging/fbtft/fbtft-sysfs.c |  5 ++-
 drivers/staging/fbtft/fbtft.h       | 60 ++++++++++++++---------------
 2 files changed, 34 insertions(+), 31 deletions(-)

-- 
2.18.0

