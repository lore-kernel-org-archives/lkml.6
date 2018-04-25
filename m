Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbeDYPrg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:47:36 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:12734 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754847AbeDYPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:47:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="13279912"
Subject: Re: [PATCH v2 1/2] crypto: ccree: enable support for hardware keys
To: Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC: Ofir Drang <ofir.drang@arm.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1524468316-6606-1-git-send-email-gilad@benyossef.com>
 <1524468316-6606-2-git-send-email-gilad@benyossef.com>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <0caa0d1d-eb05-c5a1-9958-2285bb11db8c@microchip.com>
Date: Wed, 25 Apr 2018 18:47:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1524468316-6606-2-git-send-email-gilad@benyossef.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gilad,

On 04/23/2018 10:25 AM, Gilad Ben-Yossef wrote:
> Enable CryptoCell support for hardware keys.
> 
> Hardware keys are regular AES keys loaded into CryptoCell internal memory
> via firmware, often from secure boot ROM or hardware fuses at boot time.
> 
> As such, they can be used for enc/dec purposes like any other key but
> cannot (read: extremely hard to) be extracted since since they are not
> available anywhere in RAM during runtime.
> 
> The mechanism has some similarities to s390 secure keys although the keys
> are not wrapped or sealed, but simply loaded offline. The interface was
> therefore modeled based on the s390 secure keys support.

I'm interested in hardware keys, ecc508 supports them too. In your
proposal you expect that the user will provide a specific key token that
is meaningful only for the ccree driver. If another driver that supports
"cbc(paes)" shows up, you will force the user to select a specific
driver implementation and to know what kind of key token to provide.
Shouldn't we have a common API that can address other drivers too?

Best,
ta
