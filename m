Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2771174-1527006566-2-4941670400940228674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527006565; b=QpUBre4r3RKeFUFHPZVWnOmLutKhVag9snVRnE5x36xXNpGPxF
    X5lgw/V5XKLxcIwcho6TnPUPIc2ygH+g4MbCQc21i0w2mX6H3CBW5Ps9sZ6uUTUu
    txxnZrsnuq67hBtQL36U71E9rFn3DQ7cV4zUTh3OM+pveFitM4buuagxnpc4PgUy
    GJjj0jXdX/sr92rVyXPzxGknP3Wyc1htL+2sHORYhOjj5CEr/vUMjdysxhw2MoK1
    SrTnQMUw1pcsAprj9zj7KWprcFXHFns1Uuks9ID8m3UHD1QBjJoYS5FjBwsdpYbZ
    MA6Jg6S2foi8GNYXnZBmUVz9c37r4N/hajcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527006565;
    bh=kU20wUgNCbTYqHeub1PwrACmkk4d+YoU/nANry4seHU=; b=NVUm5S/GhDHb
    9ku0fzOnmYGZFLkyjBkymhi3IOVxjBHqozvGEjDXUnQhnTFAhBdd8GVtN4i09c0T
    Yp1J4BDFljJiEN9i35kWQTJbIAv3WKx76ndHGDZkmwMyXef5OxAzwk9cmwBKykaj
    3/BNGryVWJroHIr/Th+XjXiYhNT2DLfjU1CNgjmZcHdA9UclbPL+x/FjGLXlXyaT
    xtVmnTYS0q00TvYZ51+POBGedOEJbwk2ojlXZxHMue5vysV7pXjcj275FhzMt30f
    Ds2KEdOsyuc+PnoGJG3Q05JkQKDKmgixRy3yEZvLozc6JRNYrnb1eR1iM7A5AvGK
    k7vz27ZVYA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHgXAJSPoFB4MqWhv64qbxjUacXCQVvFfzh2QnWT1uHzb7ABAkiOEzTPfXDy0awQedTbMFXkxa132bqsFWJwNa1lKQlMVBMC5sTYwdUOuxCUnBXihs+X
    35xtoRWx8xDMv2A/ORj1UYWU5yT1lfB4GHBoCyeJu+wd7eqPI2Y9OCgK28Q6/oDS6qfdYYMVDADOqdP21Zmu/PMPgGG1OOhVctstUc7Ah24xU4uYcw83L3s/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4Zbj-4zmMWkA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=DOW5XPpJgs1BEVNbt08A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeEVQ3X (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:29:23 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9772 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEVQ3W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 12:29:22 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 22 May 2018 09:29:23 -0700
Subject: Re: [PATCH 8/8] arm64: tegra: Mark tcu as primary serial port on
 Tegra194 P2888
To: Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-9-mperttunen@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d7b65d6d-c415-ac49-d729-9c6b44feb8c6@nvidia.com>
Date: Tue, 22 May 2018 17:29:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508114403.14499-9-mperttunen@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 08/05/18 12:44, Mikko Perttunen wrote:
> The Tegra Combined UART is the proper primary serial port on P2888,
> so use it.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> index 859ab5af17c1..95e2433984f7 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -10,7 +10,7 @@
>   	aliases {
>   		sdhci0 = "/cbb/sdhci@3460000";
>   		sdhci1 = "/cbb/sdhci@3400000";
> -		serial0 = &uartb;
> +		serial0 = &tcu;
>   		i2c0 = "/bpmp/i2c";
>   		i2c1 = "/cbb/i2c@3160000";
>   		i2c2 = "/cbb/i2c@c240000";
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
