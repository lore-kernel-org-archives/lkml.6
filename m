Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE992C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7451820831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="v8cyD/iY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7451820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeKCF1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:27:06 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37427 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKCF1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:27:06 -0400
Received: by mail-pl1-f179.google.com with SMTP id p6-v6so1483219pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=OaeCDT5d6l2ZTAUpUt/JLkvcjNZk+2ZJUsPBQg2mYIE=;
        b=v8cyD/iY44GjAZk2ZRmHuzcp1HUCtGosy12erIcscX7GjmkUxJpJZ2vUpXBVQ0SNBY
         1q9mop6W2CYW4fVzoXNdqugk6ZVwLtoPHS0bx95fbqU5Rlc2xHZb4VKywem5ilNYMfsV
         ZcDXnZQ6hUBTjxdWdaRyvz3NJSV0lNWAWK3ROA528xHWWJI7cRQ6sKym/p7uJLQTU5al
         ot3Qe6Vd5W1wlSgguCjmCKQuHSvmJtHvZLO8PIphGNE4DcanfrO/kWPhlIfCQJfQ5CcJ
         HvuJyiY4r69oE3oaiFnZTParV5dj1AGFMrKnb8DRPbBsHB/HgsEaXLJBoX+w4bStXnUG
         /7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OaeCDT5d6l2ZTAUpUt/JLkvcjNZk+2ZJUsPBQg2mYIE=;
        b=e+XJtLYQmRWXMoUptHgxa60Em+FOMWWImSREAswRpvsxhSyotQ1IRtsUfBKdASlZL5
         EH4iHMTspB9k75PlzVogCxKRXhv9N/AaIR73bAAjoqZKq9kg7tw09YgBZnARk5+nk3w7
         X2R6+h1L5rrBAJBH0GzRHjsX5QUbbkZ0ZarCqH54KNgH4fKtsvwgMuQukPknN3DTM+Xu
         wUvCNGzKBtAC2RRTzQSLTob0s7LZI20BYUEpn/OMXakN6UI3JWirPaSEB0OSu0J9Z/JZ
         ggGmP5gqbukcl+XmaqvP2rpUQhcdI+TLuVIKY9CfCReGrDjQVXDhnhSzKAHx+4s+2n1+
         o+3g==
X-Gm-Message-State: AGRZ1gJoye0XiclZg6Pd/EMxYYDo7UltqMbYvpaZYgQu0Z3Mjjk0MJFI
        pyc4p7yEwR/7znoeStfzw4+3yrIPV+M=
X-Google-Smtp-Source: AJdET5fWgNkybbBKo18P1YDEfBir3mmAA/rSDVCIirBvUe7zXGa9axkptUWMPUIlmHhhukOv0YEDqQ==
X-Received: by 2002:a17:902:24a5:: with SMTP id w34-v6mr12847029pla.91.1541189912466;
        Fri, 02 Nov 2018 13:18:32 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.162])
        by smtp.gmail.com with ESMTPSA id h62-v6sm26641676pfg.27.2018.11.02.13.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:18:31 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 0/3] dlm: fix various incorrect behaviors
Date:   Fri,  2 Nov 2018 14:18:19 -0600
Message-Id: <20181102201822.12518-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here's a series to fix some bugs I noticed in the DLM. The third patch
in the series and maybe the first should probably go to stable, assuming
everyone agrees they're indeed bugs.

Thanks,

Tycho

Tycho Andersen (3):
  dlm: fix invalid free
  dlm: don't allow zero length names
  dlm: don't leak kernel pointer to userspace

 fs/dlm/lockspace.c | 2 +-
 fs/dlm/member.c    | 5 +++--
 fs/dlm/user.c      | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.17.1

