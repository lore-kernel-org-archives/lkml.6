Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-610692-1526294160-2-15463934891857649003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526294158; b=KVb5kPz/ks6PGilpG1+RYuZa7US/fGdqqmk9VzgL/MU3set7zs
    4L1gSM3gTVKGRiB0O+mnu/8tPt/X7t/y3cpvC3e5psdt40hL73AVMHDLiirSZhMI
    LHOugjDgz0hXyznyvsiWWZv+3WT8YnhiQli/1FsQT5aFXyHWSrIt58g/+/8cGiMl
    XsTLXlzxtEJodfVgRY6T7e0ob7qzfBuEYsWyubtn8mFbykR7NcUVPuLOtrCdzHrm
    7cMjywBnbn4574uT77usk1fhws4boWccilZwMz8vBBXXCqL0EH/sZQ0qE1To8WXV
    XT1kTvfj/5AC4Lk36wTZRfz4VEoOTEP+3nQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526294158;
    bh=h472v7vyERAWLCtPcrZh+U8EqgZ26E3hc3k2FSyHZU0=; b=Kphbl++cJKBg
    PSa7Tfgf86jB/fv13r2OCHdHy8xujtQ45NqxZvENCE6jElMoiP/YyiNwUPV4ewQw
    IaxxBkURLKvzKFobL52VLieqkt7UzWr8w2EpL3O7B3B94hNUyTKOdcXwzGSNnBY9
    qSrE22UIa1YCWDfJzcPyFrebpuuv82/Vf29QZL4gn24i9FXDaq55EE2/4LOVQmTs
    wxCeOx+uX9sfvcOAJln4LP5FA8jXAwSyrjVOUqUA9JHQkTOcTJQbJ3UiNEn8aDhI
    kveHO7tpMXoYMMe9I5b4bR7uAcEEbdKpRcFL4h9VUgyA35VU0GJEcFDSbSuvgOrB
    SZ7Hz6BdtQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLisAVZc6C8vX9Jyhzf7FX2+rkIp01i4ZozZyLIsPINWVcJP4nbzN9GYJkvpFRLJ+o0fM04zv6CBf+Kusk7UoSh3m27JfWnmQo3YhO75AXeSwSwL0l4o
    WqtVzaG702IYfqx5W2GCQF2N8dYXtANCMXBKr1i9UBl8u32wRLy5I6JtlU5+QD/aODgXAs50Kp/lmG8FvoeOBjtR1V3hEUY3V5kozG4dhk5HV7KBS4bjLYWK
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=NJj7LuO3ce83yzopwIwA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeENKfy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:35:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39666 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbeENKfx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 06:35:53 -0400
Subject: Re: [PATCH v2 4/4] arm64: dts: Add Mediatek SoC MT8183 and evaluation
 board dts and Makefile
To: Erin Lo <erin.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, Ben Ho <Ben.Ho@mediatek.com>
References: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
 <1526293351-32794-5-git-send-email-erin.lo@mediatek.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <efa91778-e81f-9ba4-22a6-43ff0f94af4f@arm.com>
Date: Mon, 14 May 2018 11:35:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526293351-32794-5-git-send-email-erin.lo@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/05/18 11:22, Erin Lo wrote:
> From: Ben Ho <Ben.Ho@mediatek.com>
> 
> Add basic chip support for Mediatek 8183
> 
> Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  31 +++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 178 ++++++++++++++++++++++++++++
>  3 files changed, 210 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> 

[...]

> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> new file mode 100644
> index 0000000..8564a26
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi

[...]

> +	gic: interrupt-controller@0c000000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
> +		interrupt-controller;
> +		reg = <0 0x0c000000 0 0x40000>,  // CID
> +		      <0 0x0c100000 0 0x200000>; // CIR

You're missing the GICV and GICH regions that are present on both A53
and A73 at an offset from PERIPHBASE.

> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +	};

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
