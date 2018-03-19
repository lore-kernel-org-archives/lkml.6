Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3715406-1521491152-2-2024323585239959550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521491151; b=goZTnUpZYgdVhOEzu5ePeBhObPeDBGI+aqIncMNv6YPKoql
    YaQdSmnCSEkHMa1ZnnmsE35dI4HXSF9Tr/zEuAZqal60TlvjJf0uWExQHvXAoTK0
    atykkmFJnloGejM+2MG2UG5MeeNhuarZdBH84sLjebvafKdZPauxNpUvmqMZa+DX
    A1nTZ6xtpjgU1+95S+FWSNMtfvfcxcWI7YwEepMsJSpr9Qdyq0V6v/O0z9zIGumr
    5x+5gUrIhX5PhvFKPi7dwKNAObfXgrkLo2Td7h7dMY4C57+3/fUxA1AVGvEGd121
    Sdvqmyjmnj/nlkuXtibFmGLS3tsrckhLWtGUc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=arctest; t=
    1521491151; bh=ibMu3iDUD4J5BJohIvFiE2xvwWA3OYBNkZFoOqVD4e0=; b=g
    taHAucv4FHHLbMojc94jVbBvYkzrGrAFcJjbgR54tRbk3kaMMTwMISmsSJh5i9EN
    4WXZjw2zLZ6kk7tff709qlKu7PcOb1fpIKEUryahdiZGviDQqGPTMrVfvN8m/O7T
    zzoOUj5JCEIPE9mhqG1TG1WRCXYr2x7UQIqMP4ay+Iilvt/60FeuiZg3sOTGPspT
    8No6S+WVh6Tck15bC/uknWgTjweM36xHaQkh3bTCNfFnvn5IO1bMORUp+0++KciZ
    0KpW+GLhljgsCT9qnj8BDnbsrcmwiz+nAmCelvwuyn2NltnaE23QkDnyekcjCzdx
    pwFjfSbmytlsGuZutJBFA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-60 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurheptggggffvhfgjfhfkfgfuffhsphejsehtjfertddtreejnecuhfhrohhmpefuthgvphhhvghnuceuohihugcuoehssghohigusehkvghrnhgvlhdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtgedrudefvddruddrjeehnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvdejieefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-60 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurheptggggffvhfgjfhfkfgfuffhsphejsehtjfertddtreejnecuhfhrohhmpefuthgvphhhvghnuceuohihugcuoehssghohigusehkvghrnhgvlhdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtgedrudefvddruddrjeehnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvdejieefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031556AbeCSUZn convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 19 Mar 2018 16:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031514AbeCSUZk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 16:25:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923BA21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: mark.rutland@arm.com, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@codeaurora.org, sean.wang@mediatek.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b6eafb38f8d697bd8d00c8d86a0b22be809f8062.1519874655.git.sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        stable@vger.kernel.org
References: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
 <b6eafb38f8d697bd8d00c8d86a0b22be809f8062.1519874655.git.sean.wang@mediatek.com>
Message-ID: <152149113900.242365.801086554904089563@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: mediatek: fix PWM clock source by adding a fixed-factor
 clock
Date: Mon, 19 Mar 2018 13:25:39 -0700
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting sean.wang@mediatek.com (2018-02-28 19:27:51)
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The clock for which all PWM devices on MT7623 or MT2701 actually depending
> on has to be divided by four from its parent clock axi_sel in the clock
> path prior to PWM devices.
> 
> Consequently, adding a fixed-factor clock axisel_d4 as one-fourth of
> clock axi_sel allows that PWM devices can have the correct resolution
> calculation.
> 
> Cc: stable@vger.kernel.org
> Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

Applied to clk-next
