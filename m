Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2671386-1527002177-2-6011551268358734199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527002175; b=F2eHuD1iDkh1tPCDTmX5w+r7nDmTUyNhDt3bgYHAVY84iiwmYU
    eo6h/bA6qPB5Gxhbdye1eNs7iPJ+fQwt19IpN8n43Hjd50DWvx46CPefK+//XU0v
    nMfQeH8sQAgL0WNgZsMcVujCoXze5H5TcM6aiI28yVhp+o0VbPVaJu4h2yb5Wz+u
    sPsGFJ8mcoFT1isyMM90p2dFG7db/RgrrQ7PiCPCeJYVAtmBelQVuJ28hvhLeIqp
    qz3yDeq/JFlFw0Neuq37chRR8wol7QMh/p1dygjMDsd/ryYBjjIQEOkE/EiPkQFV
    M54u8CPeNGYPgSOP8YskPwJmkhucWZeEtF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527002175;
    bh=RCspH65drDNiP7i2HGseFqnkmACjeLHK8yK/JW4FRgw=; b=mZ9hRs9kGyZf
    onTVWqwRVI+Vo/vSoWYx4o6hcuVtajm69ehdqnd+FTqd6PncrV2STZyxYEP0UGvt
    tN51ahjaN15b9neInZHrk2A+F/bdydWvttOa/kUzchSpxAZd3q5QUAWoYlY+2G2w
    2tRy9lcl9FiojWUjs2Ik1b9U0mwjcDrEywLPvxlJ31Zl4IprgvtAtkvuYhIwVrqi
    /R95fLaYl6sc0bAzhcgwtLDJiVCqJOPRS+qG8X41qU55mveYrouL36duKA9Fmtot
    1wjJ5r0R71Gpj4xvNd16sTi11GRLZaWyKYS4is1I+2hxUDXe6jDyWXFN/mSFmihB
    wFCa6EDMmg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJoBCTqSFHpWO+fZSAotSq8jEZN6W1XgjLNFv+zVaUOpb/F/+ry1YHwT+IvPmUW++60N666GoeQUQJlTXRO+ZW0Aggw9Z47d03OVFVNaddwXXk7+X0a3
    7REC4X5LXkGJUVa9dVI4pFxWVIO1KehrCEPC5gPael8zprBDEuWWVNaJCO2EeI5/onNH5QFyHixA7ClPmMA+YS53j1NtXnLRyARTsCf7hMN6O27hieQnxFYV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4Zbj-4zmMWkA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=6XR74fzSqHsHqd3t-TAA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeEVPP5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:15:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6261 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeEVPPk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 11:15:40 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 May 2018 08:15:40 -0700
Subject: Re: [PATCH 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
To: Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-3-mperttunen@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3ddaafbd-d8cb-3cca-be4e-8c5c53fd9734@nvidia.com>
Date: Tue, 22 May 2018 16:15:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508114403.14499-3-mperttunen@nvidia.com>
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


On 08/05/18 12:43, Mikko Perttunen wrote:
> Add bindings for the Tegra Combined UART device used to talk to the
> UART console on Tegra194 systems.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> new file mode 100644
> index 000000000000..86763bc5d74f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> @@ -0,0 +1,35 @@
> +NVIDIA Tegra Combined UART (TCU)
> +
> +The TCU is a system for sharing a hardware UART instance among multiple
> +systems withing the Tegra SoC. It is implemented through a mailbox-
> +based protocol where each "virtual UART" has a pair of mailboxes, one
> +for transmitting and one for receiving, that is used to communicate
> +with the hardware implementing the TCU.
> +
> +Required properties:
> +- name : Should be tcu
> +- compatible
> +    Array of strings
> +    One of:
> +    - "nvidia,tegra194-tcu"

Nit. We should say what device the above compatibility is applicable for ...

     - "nvidia,tegra194-tcu": for Tegra194

Cheers
Jon

-- 
nvpublic
