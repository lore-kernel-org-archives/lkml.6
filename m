Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELsgcf9HZ1jRjWTIAQUO2VFTiL2bomkimWS6A8n9uLzeHWbjpL9HE3atxHZos4OTze7ZCRtU
ARC-Seal: i=1; a=rsa-sha256; t=1520621412; cv=none;
        d=google.com; s=arc-20160816;
        b=iZhwAoIfrdwHj5G/rmqnSVWrBHUmEOa2cDXGHFoVoN+VfSRhf5Izhjrgr5MbJN7YhI
         j1a69h2+2jl+9Kt8x4aMIYqRx0B7TJetxK3vsMLWxXVx3TlU3g9qpGVmQKqykpMjKHAs
         hDQyuwPdEMfDn/tVl6COBPmyKgT3zhkosUbD9ZLu6dGR8eYYlwt+mz0PjKzJvhikL0uB
         vRW0mEJhCuRJdvi+QWSzWthD8QLyN4Sc9Uik9mj+SD8cYH+vV1DtkDGoCiDAdA0Kkz+P
         6IJQjNPQPAjkpJlrB0K1eg45u6lBLgBNDZ4fCFvrISjTa/M4NSOohZDu3Y3PAOXrL+Su
         6BBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=bb2GS4ur+U7NlilyhFI8S6gMfh+vFShPp/CNgNTQwxU=;
        b=enNy4escgmJKVvO4mIprCnkjz7DQL2c26QneZiwwT7dfGQ0VY83Z3M1kGXz30Hb983
         bwsWvI+NIVZ9/ycQHu3otNHZzKA6+62plbxO8GlCk7sWlg21k1xAU/704Av0IGvJUNK8
         yfE4kasi6W/n2HMSl/AmNWNW6Xf92fVZ1AiHn+59J5xFVWMWX5aUVYISIDgea5rEvuv/
         0Cf0+kUFAvM/Lj0Zb7kQdqFxJtcG8e328LKlBxLSKiKV7jDTsBkq2aFvZRxD3xjklliy
         uZNRtKnhMW7RAOcULmiYgZDzUM+7Y5H3k+uJAMyWCPV0xRgJbizb56Q7m2kU3/6ziipA
         PBPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
To: Nipun Gupta <nipun.gupta@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "joro@8bytes.org" <joro@8bytes.org>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
 <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
 <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <20180308074115.GB15748@lst.de>
 <HE1PR0401MB2425871215B13AD0EFDCA5C3E6DE0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <579b3df0-f78b-3c77-7a8a-9cd69848f1af@arm.com>
Date: Fri, 9 Mar 2018 18:50:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0401MB2425871215B13AD0EFDCA5C3E6DE0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108392554438818?=
X-GMAIL-MSGID: =?utf-8?q?1594487117905304723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/03/18 18:29, Nipun Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Christoph Hellwig [mailto:hch@lst.de]
>> Sent: Thursday, March 08, 2018 13:11
>>
>> On Tue, Mar 06, 2018 at 04:41:56AM +0000, Nipun Gupta wrote:
>>> Sorry for asking a trivial question - looking into dma_configure() I see that
>>> PCI is used in the start and the end of the API.
>>> In the end part pci_put_host_bridge_device() is called.
>>> So are two bus callbacks something like 'dma_config_start' &
>> 'dma_config_end'
>>> will be required where the former one will return "dma_dev"?
>>
>> I'd just use dma_configure as the callback.
> 
> This would be a decent stuff.

Yes, the PCI version should end up looking a lot like the old 
pci_dma_configure() used to, before everything got pulled together.

>> Currently the of_dma_configure and acpi_dma_configure are only used
>> for PCI anyway, as no one else sets a non-NULL dma dev.
> 
> My understanding is that even the platform bus uses the of_dma_configure
> and probably acpi_dma_configure too. So platform bus may also need the
> callback implemented. Please correct me if my understanding is wrong.

Indeed, platform and AMBA will want an implementation to dispatch 
between {of,acpi}_dma_configre() per the current logic. Host1x doesn't 
seem to care about ACPI so probably wants its own just calling 
of_dma_configure().

> I will submit the patch with 'dma_configure' callback implemented for
> the busses shortly.

Cheers - I've been trying to find some time to take a look myself, but 
having something to review instead would certainly be easier :)

Robin.
