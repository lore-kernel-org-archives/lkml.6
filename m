Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECCCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACDB21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UBe4hx85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACDB21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbeKOEKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:10:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44644 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeKOEKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:10:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id b81-v6so7797773pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lbcVccfhtSZbJaG4asGm7Gtmboe+/b7Vmk3/13dlQTQ=;
        b=UBe4hx85YDF0N8OoLiD8P+iBTd65eU58kPGFe0i1KYsnBQbLqmJXT9xerOtfhyd9J+
         PFmdZqzAIxfoAgQNYSi5TpNahU6xpXesgz/hceJZTxKlbnF6Gjggm27STeOlI6bGYzS+
         xHX6bMH4WsnN8L24lcZO93U85QFclmkH/N0v5eQSjoheuHP83400U6tT7Ad2zflONgjG
         PEK9PTFJWRP/P3v+bGNdHxQJ8U5LQ3YoZR1KT2b7XSZ0Logi4gAlRsYbrhG8BJFhkLdI
         TneqYztnHmD45AwnQihgcY8Y8HQABGtu8pKDahw6LOTJSrsILXO0mka+jrYPAzzDuUJz
         Utqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lbcVccfhtSZbJaG4asGm7Gtmboe+/b7Vmk3/13dlQTQ=;
        b=SAKmsCfiXZusiGQARaX7Pe18DCPYaUvnmZTkmx/9rX+gz00iI9rSiKnjk60ehGudm8
         us0TIXF6bWpb7ryIu5k4FWgvDyRg26wAOviBkC8FfNaqh5jklqoSTovrx/gRBXNCLCyQ
         GOK6yFSnuVUuaUmdhoRatBOg83zuyYIAGJhXZ6mBV9oXAMsjQ8XfOCnvTROsIUgYMENr
         qkkVV2lJExiU6zFtG2dD5ZgQJQsRf+zyVz7UzN6gMAmPrlQk8LVBNXbkN+Pc5Kqq9w5h
         0Vdt5yHK9cHOFO43BpPtSC2LppfTgQSQcW4QvP/dzQGGrLhbYmqGieSK0u6g7qrtZJx2
         2ODA==
X-Gm-Message-State: AGRZ1gLOrli5vg13mOiSb+KGHdaSbc709np2w30aTld0BBQrAZKHHhO0
        Kd+uSeigZA5KfUIgs4u0K7WhvC8ZKlR1hA==
X-Google-Smtp-Source: AJdET5e3KmwOCpkhKsCCAEaxA3wJX+ZqZprDYTEAFoI9F4ij4mYi4qSTcAo16v3A4U/4rT8cMqUvkQ==
X-Received: by 2002:a62:ae06:: with SMTP id q6-v6mr2995619pff.126.1542218785707;
        Wed, 14 Nov 2018 10:06:25 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id s144sm23566927pgs.87.2018.11.14.10.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 10:06:24 -0800 (PST)
Date:   Wed, 14 Nov 2018 10:06:24 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 10:06:22 PST (-0800)
Subject:     Re: [PATCH v2 0/2] Introduce common code for risc-v sparsemem support
In-Reply-To: <20181107205433.3875-1-logang@deltatee.com>
CC:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        sbates@raithlin.com, aou@eecs.berkeley.edu,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        logang@deltatee.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     logang@deltatee.com, linux-mm@kvack.org, akpm@linux-foundation.org
Message-ID: <mhng-dfc065e5-80c6-4a9d-b95b-95170df42969@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Nov 2018 12:54:31 PST (-0800), logang@deltatee.com wrote:
> These are the first two common patches in my series to introduce
> sparsemem support to RISC-V. The full series was posted last cycle
> here [1] and the latest version can be found here [2].
>
> As recommended by Palmer, I'd like to get the changes to common code
> merged and then I will pursue the cleanups in the individual arches (arm,
> arm64, and sh) as well as add the new feature to riscv.
>
> I would suggest we merge these two patches through Andrew's mm tree.

I haven't seen any review on this.  It looks fine to me, but I'm not qualified 
to review it as I don't really know anything about core MM stuff -- and I 
certainly don't feel comfortable taking this through my tree.

I've To'd linux-mm, hopefully it just got lost in the shuffle during the merge 
window.
