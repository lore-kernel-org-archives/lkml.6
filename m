Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32599C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F3F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PmKZuLyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeLRAKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:10:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44319 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLRAKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:10:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so7168884pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpiUli9kzHYigLDR/R7tiNR9Bv1sbbGoN8YSt+jHVQQ=;
        b=PmKZuLyuRSbMC/15vHf4ldEbrU5HPnAhThgSW6UfxC6O5yxHJpRD6SuyjGQ4r/361K
         FZ+/a8DarL7FnW4bTswS4UwY3qBS240u7oKAs8jwV/geCjmZdXJFsFH9uIzkDyOcr/Wr
         GmesaTB7FjkAjRZUxN5Ewf9XD4i6RIswEz9PWy1sySh7wDk2RBnQmJjNf5T9oILJagS6
         jIAPEfKz3FzkLmvSGL3yS7yl8FOuRhTzw31frO1Vu1XwfPR8ZqqsK1JXPPzl22rcM1ct
         Ho3lyVBE/sbcHn/tVWDQtKJTgis/DCUmkeBXibTILtYG4xRg75MUzPqKmF6T70+fpTqK
         Pyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpiUli9kzHYigLDR/R7tiNR9Bv1sbbGoN8YSt+jHVQQ=;
        b=Pvo+gmrmGKoJnTLy7eh75kKmU+2tOrz+7W8ZC4EacPgJJhdyo7ZUK+U16+hRztzbLk
         Q8gaGP8zkvZFVFQX8oDH1aXwbCb531OzGnLjbxxJpKd00TILLXgtlpZoLLsKU7ZJN+z0
         ReDwVrfL6ZtqO9UsdVr4LYz5GrIPqZhNsgA732l0Vj2UH/BJnOAsy5iYYVfjrHyr5ugs
         TZiWT4kFe/jQQ3bxlS7M/WMKuZUG/nziKdba1VxqRBftBnuZ8CxoUsF4oGQOqg76SKk7
         2X58VMJ1BY4DCFUaZAUnKjINMzHAxMT0vZKCd/yQHJKrwpVug0P/Igntp0CDEQX9d1Di
         5hEg==
X-Gm-Message-State: AA+aEWaOulxeWlrvVKMcTsOt1prcXNPmLdPkvTxEUWo/sQU+Tn/GlbtN
        zF/cptpCklXCzqeeEbLtdoYVPo8uMMw=
X-Google-Smtp-Source: AFSGD/W0yde+dCMb4ZY5hsefWl4U7vij60FjFohX5TnrvgZyROglZmVIRZ151PVa1wqQzCQXWumhkg==
X-Received: by 2002:a63:f30d:: with SMTP id l13mr14022744pgh.399.1545091803448;
        Mon, 17 Dec 2018 16:10:03 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d25sm20878535pfe.40.2018.12.17.16.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:10:02 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 0/2] MAINTAINERS: SiFive drivers: update the URL and add myself
Date:   Mon, 17 Dec 2018 16:09:57 -0800
Message-Id: <20181218000959.31352-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS entries for the SiFive drivers.  There are two
changes:

1. The URL has been updated to point to a SiFive-specific repository
   for SiFive drivers.

2. I've added myself to the maintainers' list for these drivers, since
   I'll be helping Palmer out here.

Applies on v4.20-rc7.


- Paul


Paul Walmsley (2):
  MAINTAINERS: SiFive drivers: change the git tree to a SiFive git tree
  MAINTAINERS: SiFive drivers: add myself as a SiFive driver maintainer

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.20.0

