Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493325-2-18434929769392635300
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
    t=1521493325; b=k8gZwPcLJXNS4Hj1/qrgYhZ6RTuEmTu+efw8AI2miIF1jlP
    jzn2grTmrKavVwKA2vs80LWf0VQ5wfjpSadya58IkQR94SMsatSdXbBoBbCYrSk9
    Hcovq7VTk6AeTP3axDYd4qjpL3pdqF5n1o3TdoWoRI+MMMucfzQJYUeCwui0VHJZ
    SRfwJS+OpX8JruSo6sdFv1cjp8GuWIaZPIJJKyaiXrINkXeZclEZrGCahdMP2wSH
    bZH1VAzfyxWGlMqBhnNDnnC4FE4ofo6bmSaI2YVnlZvh0d6aGYfF7V1TnT6k7g0h
    pak8nZ7lMMSsy+WtbfK1uexpaK0fEUfPu6xtdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=arctest; t=
    1521493325; bh=a2cgR3brhVlyz8/5pZh5cD6a2gOFthOEe0hJ+4lqTY0=; b=K
    MmJa8l2HGnPRddKBuy373edYE2RvRvpRHQiuQCBb1Aruon0sMFL4rscu/VUVjFDA
    8EBHl5t0QDRgK/f41DCKTlv5OaOYXR6m/W9TAj0tDioOgX0anEN3mF6OFVdZy1TP
    ANmnVmsJfy6tVPql0RGQDVkXTJ1cAbDEX+3GylucSrc+iemk3czw8qxIG6aDeexE
    aGU3C+9HkCnBhBpzBP6o088g6Z/IN9e1lKZJ9e7uQnix9l/HUGoiA+EFw5xqt1Xu
    DTR5HgLj6df1zqVs0jxZNxC6ypdd1GLm1hx1pneJqq4J97fd1Z2b2CN+hUmUgTFl
    lNr2F6fWK2RznnMv9ncxQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfgvffhjghfkfgfufffshhpjeesthfjredttderjeenucfhrhhomhepufhtvghphhgvnhcuuehohiguuceoshgsohihugeskhgvrhhnvghlrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpddutdegrddufedvrddurdejheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvkeeifeenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfgvffhjghfkfgfufffshhpjeesthfjredttderjeenucfhrhhomhepufhtvghphhgvnhcuuehohiguuceoshgsohihugeskhgvrhhnvghlrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpddutdegrddufedvrddurdejheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedvkeeifeenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032100AbeCSVA1 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 19 Mar 2018 17:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031917AbeCSVAY (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 17:00:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E230A204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Richard Genoud <richard.genoud@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180313152702.21070-1-richard.genoud@gmail.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        stable@vger.kernel.org
References: <20180313152702.21070-1-richard.genoud@gmail.com>
Message-ID: <152149322220.242365.11252668841166595824@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: mvebu: armada-38x: add support for missing clocks
Date: Mon, 19 Mar 2018 14:00:22 -0700
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Richard Genoud (2018-03-13 08:27:02)
> Clearfog boards can come with a CPU clocked at 1600MHz (commercial)
> or 1333MHz (industrial).
> 
> They have also some dip-switches to select a different clock (666, 800,
> 1066, 1200).
> 
> The funny thing is that the recovery button is on the MPP34 fq selector.
> So, when booting an industrial board with this button down, the frequency
> 666MHz is selected (and the kernel didn't boot).
> 
> This patch add all the missing clocks.
> 
> The only mode I didn't test is 2GHz (uboot found 4294MHz instead :/ ).
> 
> Fixes: 0e85aeced4d6 ("clk: mvebu: add clock support for Armada 380/385")
> Cc: <stable@vger.kernel.org> # 3.16.x: 9593f4f56cf5: clk: mvebu: armada-38x: add support for 1866MHz variants
> Cc: <stable@vger.kernel.org> # 3.16.x
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Applied to clk-next
