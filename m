Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F14ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1917E2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTwnpYJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1917E2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391596AbeIVDuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:50:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44010 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391311AbeIVDuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:50:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so14131923wre.10;
        Fri, 21 Sep 2018 14:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/i4vnxgLid+QaWWqvNTm1yzs8ccRRHRwuz2dSaudjvU=;
        b=LTwnpYJQijS31oVIi9Au8RfHUf2DnOPM7ZqCCZsAxh5Qo722qvmN87U8j5mSF8DWBt
         u58uxzV9981H6y9t7Clebs8US0mmQ4BxLjMBB5lXJVQ9NYB7LUTKH/qgUvZBba6F4RLD
         Pph9wUUenBBEf+W3wJYmBoqdw1kHmKQUrHnQLf9nyYh4TLwhYTZXbLzN+ol64clgWEIR
         3lS1oRfR0cjW9Y3WUGqsr0XfroMWYCNGvrnNwlResYMPwCSZaeSxafqmTddy3/8wMUF5
         dayC5nSuIvqe4AFeqEW1XgorgmivPeOcoqVYgRGE6ioa9cZ8RqeDepvOHm7Z+5RMrskO
         y26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/i4vnxgLid+QaWWqvNTm1yzs8ccRRHRwuz2dSaudjvU=;
        b=MRenc6T1qBCehIb6CPbQzgUuRVEc5YwmaDfIlri/dYLdzdOO5/MwU9xG1aGYYmESfd
         E6oD9Ht/fgJJgkEiaXPhkh7n7d6RCn0Z97aB5MWmoKehTHAZIH01qoFgPqV89Cxmkac9
         jy3wWaRKKnWUfx7uYgqSJAY5lfzqJ7JBORCk6uqkW9V6o5WrGbruq21VnqQeVL9ZWjIo
         x5fVYfZgqDr3X3asbWbkT6P3CoRuxAS1vo4XG+qHXomYsNxiGyvIp6jAkbDM0uYvDkqH
         uviVpw94cxi8aZGjTRW13TT7DxmyB7Q6ZdApji0xGNRlbcg8YuA9nJeb0TMyteRi62BM
         NEcw==
X-Gm-Message-State: APzg51AS37rNlmC7YlRMu+Snr8lN23NqCaQQr1hu6ZPIIgbgEROCL/je
        wL2/hJwI6NmvgF9DzvoUNKk=
X-Google-Smtp-Source: ANB0VdYBrzrba7I7qsdKXZwN8RGazY7dVjK2bY20fI1x7FRUYgfyfDurAfHqKXUN2/01ZpgMO6aEZA==
X-Received: by 2002:adf:d4c6:: with SMTP id w6-v6mr39162107wrk.185.1537567183227;
        Fri, 21 Sep 2018 14:59:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e13-v6sm22857350wrt.76.2018.09.21.14.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 14:59:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: BCM63XX: Fix incorrect interrupt specifiers
Date:   Fri, 21 Sep 2018 14:59:33 -0700
Message-Id: <20180921215933.8592-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920001402.1585-1-f.fainelli@gmail.com>
References: <20180920001402.1585-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 17:14:01 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> A number of our interrupts were incorrectly specified, fix both the PPI
> and SPI interrupts to be correct.
> 
> Fixes: b5762cacc411 ("ARM: bcm63138: add NAND DT support")
> Fixes: 46d4bca0445a ("ARM: BCM63XX: add BCM63138 minimal Device Tree")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
