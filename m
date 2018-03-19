Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3686006-1521491172-2-3054330609515236799
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521491171; b=GjiAws+GH+T8L3qIk24XTnFNzqP1FNllQwYwqbbuqmRa2cU
    eHJjV77pwYuDYnOpiEn+NSJT8j/UQZX54HuKjzt3BKVIZGzP/nMxIMqDpF2Lsczo
    qicczqT9iy7eNMeyQX6//up7McVSazmF1Unx0joGTArJh++tSw8G8xwFf/nfg30T
    fifV2kHFtltS/R0UAjAAq1oMV1XG5lJNXTDBbWMnjKtHYbvx/zPu0HMiBfJbBxxc
    bpn4xD1ZbdLslcKT0rTl1HgBbFwSHZtPTeptJAt+fVbvLVudYU/gCyf1t3EJ21rs
    tEgj9LXCw14PL5xayAGm8//+kF7laLjhTv6cAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=arctest; t=
    1521491171; bh=IM477vH2R5GpECEJg54e/xA1AwKxLj2FQHmylKRRN8Q=; b=S
    679zVFPWSQMUgkEc68lngLmK5otNMg4IBj6JLSuPn0yCF3kJZz/dRIN64C+kvXP7
    Qm+Mxiem2D9htbRxAhZcSy0PF9nQ67H2nnkF5wZXfxGC5P3P5N+2/SnmqO3SBByu
    u9ShRfP7dNWM9pxNffZhvda+7/lOrjGt0IbEIk7ND4HT5S4MKgR6SXIQ0PcOtNDA
    Eka5NlaY2RYHnutsKvWqAyZCxjubU3K4INiJVkzmoekb6AAP9ZJDcwFKOqlUd1MR
    4RC7XCzRk3U99Pbkf0vwFT90bh47WmMhRHwqJvmKX9cIptQ5L4S+4kqUApD+PBMa
    YHBZTqsmffaOP64I72aAg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-60 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurheptggggffvhfgjfhfkfgfuffhsphejsehtjfertddtreejnecuhfhrohhmpefuthgvphhhvghnuceuohihugcuoehssghohigusehkvghrnhgvlhdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtgedrudefvddruddrjeehnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvdehkeelnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-60 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurheptggggffvhfgjfhfkfgfuffhsphejsehtjfertddtreejnecuhfhrohhmpefuthgvphhhvghnuceuohihugcuoehssghohigusehkvghrnhgvlhdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtgedrudefvddruddrjeehnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvdehkeelnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031527AbeCSUZl convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 19 Mar 2018 16:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030605AbeCSUZh (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 16:25:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBFA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: mark.rutland@arm.com, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@codeaurora.org, sean.wang@mediatek.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        stable@vger.kernel.org
References: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
Message-ID: <152149113631.242365.14902026013263544653@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: add binding for fixed-factor
 clock axisel_d4
Date: Mon, 19 Mar 2018 13:25:36 -0700
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting sean.wang@mediatek.com (2018-02-28 19:27:50)
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Just add binding for a fixed-factor clock axisel_d4, which would be
> referenced by PWM devices on MT7623 or MT2701 SoC.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1de9b21633d6 ("clk: mediatek: Add dt-bindings for MT2701 clocks")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> ---

Applied to clk-next
