Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C8ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C99821529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HQP9ak0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C99821529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbeITVGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:06:44 -0400
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:59757
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731025AbeITVGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnyI7CEUnEdmTwhF1c1DRGH7N1Z2FiUa/fbYLcUhxns=;
 b=HQP9ak0kdP/KrqKV1fFzMRF/z4VNP/0sm2XMYskM4s6lbNvbVliSaKP9NxpM8vTb675vQAKclzLlIZrrvY0UU0Me6Z4IEsfDGKay45VeekvyvdMZFSe6/9It1DTKsuL5nakGgqVnojju7icILBVFerSy2fBtPKTKNDAALPARP/M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suzuki.Poulose@arm.com; 
Received: from [10.4.13.23] (217.140.106.49) by
 AM6PR08MB3093.eurprd08.prod.outlook.com (2603:10a6:209:45::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 20 Sep 2018 15:22:38 +0000
Subject: Re: [PATCH v5 11/18] kvm: arm64: Dynamic configuration of VTTBR mask
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-12-suzuki.poulose@arm.com>
 <15830d79-cfc3-964a-c232-a508758ba1b9@redhat.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <77c89ec4-9e27-92b8-1d7c-91fb98496808@arm.com>
Date:   Thu, 20 Sep 2018 16:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15830d79-cfc3-964a-c232-a508758ba1b9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: MRXP264CA0040.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::28) To AM6PR08MB3093.eurprd08.prod.outlook.com
 (2603:10a6:209:45::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bd8138a-8aa9-4e93-b3cf-08d61f0ce6fe
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3093;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3093;3:1bP609k9JPHZO4UslJuU5pEKhCS/mjl9hrKkydsx8KNXPfOmkQsKi6ZLPFEeVfG8rVFxDMm8FFxDB8IBVFWHJ3nayYeR7VkLCgd9pYMNJBGxFqvI6w2zoknnziPcl0Wwcwpiq0lxqdxuFk5rqmlGhLBMQhw/Q5T5pDq+1g0vA4VNpRdJkY3Gh1cOZNmDIPTRnHdqSWNrHeE+0av3ir1HqCqc0ASq7UAFdvqtiRxmlibLW+kkpVY2WHoqRszzRk/S;25:t4qyVmsuLBiPZ4ve1xjioGxkWrf1cR7jpX/LEZJvXhSacPVBV1JjCGI8kRA1535dAuKXhisJTzuVSPR6gvskx6atBzazp+rkc9Dc1bde960RlkYwaAsft8zGdZh/8bZxDozf27pNmTwI1r3f8ynz2Qf5/KtalKQmfokHpQZDbAqFKhTyO3SYlQ1WBdNOQzlt6iHssoHOcstZJsX10DslO4hMfmBzXVVsw7YnnRirf5nWp3ieeKK2l3GAbU0XEvSMznUcsObI27tXaBDfsQ4tV519UfioqXAlmMngzJsdcEko+yDrHFH60jX9bLc3ArPhTtwkjgG+Y5+YvZS/orSZEQ==;31:QNjBMRRwqsXHWfq23jH949B61yTvmEBvUd4Sp97zwncAA6ZTQ5lpNSp1cHWQ6C+7x/kw0QZFPpXkYOEwIHi1cfYj0sGWI/0mI3Q3Pr8FhTxhLHWMLNEMGoDDnTwFA9r3r/p8SKFAbtgNh1QzuQcnEnx1lfd4GZEfyWg5/QaO6c+3sSY5bIZeaBIRhLoMkYnp6x8ohUIEfRgMa8WSlDBQRjpwXKowz0rLMnQaDVJHobk=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3093:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3093;20:Al39a0I+2hwzIOaDAqJjCAw+EVPc0+rwESauTDOnwKJy7fxjHz+lG7Eai6DNp464mi9AZcJvbgB9bFokO9dYOtVJ6m+iIUjaK9olpmqlVU/F9PUaJ8tCFleooBMP/1XzCMBebXyLD87xk8DR6agQwixFUtyV5DwcSy/bUdYaEqswfr/rpqo6sWBWpBkKbOCV16iIYG2h2IOBJbkANOJcO8+gmPfaHUJq7GH0i9apYuj+rIQrSqtii6PzPgjswIXRRV1Y4SE5MK7V1l9k3cHPfQqqZZK8ZhxC9MOgak8qEUIHvUSqdHs9iGZ7SxZBQcGgigaQV4f6zDC1Lw/38VK/ks+oLKiGcBUS3IH8TQSwXs0JL9J4+MVJJEEQpxeR3ThFFZbFXbLEMSPBpSxnHkuMuhLJzq+aXv3hTwtETfjCMyEDo1gnjFHnIeX0z7Dqfvlp8nwSRgGbo39Hxd2OrkXCdxnvPEIJ8ODIO9TWwrPPRMFNaNWsHlnTJX1Sed1D988j;4:k9gSKHGi4dNyJn/DHbkkyApbn36l5nHCeoNgtPphcHDLHljXbWrJeTyteHrdWY6IDxNch1s5uxhAGkZvjo8XSCN2V7NPPOuSFuYhsW/WwM7SEssMf0RLSf2IzLrVKrjVIXwBTOg+/rHJMDfg2n81zkhniQRm1aZHES7O9AYqbA58eFZLd9q7T4WUfD8ZXZZJIAABvZ6wCk8AOLeIgBMZMNROMfJ/9upEG/DIdCEFJA0MiN2fHH5+RtuO4GWshp4w8t9yT+XJR5irOC5cMOQkI4y/FuN94wkfGo060ATxy0w8t1GEdfO5K1zzlVEGtXtGeEBoA2YKw7ePBCo1t61VoiB1ZWILpW38smQ5GG1GZuc=
X-Microsoft-Antispam-PRVS: <AM6PR08MB3093F6AFCA16918219A40D6491130@AM6PR08MB3093.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR08MB3093;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3093;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(376002)(346002)(39860400002)(136003)(40434004)(189003)(199004)(81156014)(106356001)(52116002)(25786009)(7736002)(8676002)(16526019)(47776003)(8936002)(305945005)(4326008)(81166006)(65956001)(6666003)(53546011)(50466002)(77096007)(66066001)(8746002)(65826007)(72206003)(26005)(52146003)(6246003)(186003)(2486003)(23676004)(65806001)(105586002)(386003)(575784001)(67846002)(5660300001)(31696002)(6486002)(31686004)(86362001)(478600001)(14444005)(58126008)(68736007)(2616005)(316002)(2906002)(5024004)(3846002)(64126003)(97736004)(486006)(36756003)(53936002)(11346002)(956004)(76176011)(229853002)(16576012)(476003)(446003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3093;H:[10.4.13.23];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMDkzOzIzOi9PWkkyZ2hVeWVKY2RVS2ZNeWV6Rk1lSXUv?=
 =?utf-8?B?cStzekNnMUlya2poUTBvd1RCOSs2QnNIRk9NQUJ6OEZscnZTUE9KY0x0Uk4r?=
 =?utf-8?B?YmRQVUgzS2w1WnN2bkJFNXRGS2lQckVNeUk3YW5Qa2JYbERJMnZMOEduMCtH?=
 =?utf-8?B?elRYQXVScCt0SSs2ZFE4L2JLL2dud0pwV3lRckxLSDNOSUJ4OTA1Q1RpdG45?=
 =?utf-8?B?ZEUxYWNxeVBiam82Q0tWbXRiZVJvcU9wdE5IRitBMGJRZEdRKzVYMkR3VE96?=
 =?utf-8?B?eEY5U0xJUEVJNEZFY09HbkxPUmJGNVg4cUl6R0RLY1l3NGRRdVREMGg5cmFL?=
 =?utf-8?B?MGlLNXZpa2tJNnBId0lpVWF3K1NvVnV3QjR1TTRnbHRBYzRldmROL3U5aVZs?=
 =?utf-8?B?OTFjL3FqMVAxWksyU3djN25XOFhla2VBQ1dtOFJUYlBvdWlma09NbWI1YWNv?=
 =?utf-8?B?WUkxbzl1YkgxU01ERWVMSkcyeVB5TFlWVjlwQnFoUXZyYjFWSXRaUFIrb1Bj?=
 =?utf-8?B?L1QveHBxdW5ZVW9oNUx3NkxWSXpHUVNyQ0xjVWxydHhLUEExUFRodzZ4VTU2?=
 =?utf-8?B?cFVLSmFOYTUrZ0d6bHNUQ0xzdml6OFFIbzdFemhwcHRtNlh2ZFVjYXB0L2wv?=
 =?utf-8?B?bTBqYWNVdVg0QzI0bG9MQkRFY1YxNHhiSng3RklwcFdFR2gvSC9HZTBUUXVY?=
 =?utf-8?B?SGJYUjlzTXQySWJKU1RtTHJhNFJ3cmM3UTl6Wll4RFBtQTJKOUZ1WmtPUnRi?=
 =?utf-8?B?NVJGUmpldHhPUkJRNjNhU2x5OEJRZkNwOW1ad1FrdjQveitlN3l1KzVKWW0z?=
 =?utf-8?B?UWhwZlZKQTFjMVVaRGdGSUdhbTUzR0RySG1hOGRkdmVUS1ZsVndjOEFWWVhv?=
 =?utf-8?B?ZmpiVm1hY0V0SVZQQ0l2YVNYWDk5a2M4SGZLQk04TlRCWXJwZXdUNUwxalAy?=
 =?utf-8?B?ekFqam5rNHlzUGVJR2QwbUR1VUFkbDFqc09mZy9WUHJ1K0Z2QjZrNmNnMG1y?=
 =?utf-8?B?QVc2ZEM0Z2ZlWGRFYStJL2FETXcyaGVCTXRJd2Z1NzBtaW5pTDM4YkR1SHhL?=
 =?utf-8?B?RGYwbUo1MEltbXpMYlVGQW43OTN6SVphZXltM1Z0dFZmYzZmWE1ocGpwRjU3?=
 =?utf-8?B?VlNac25PcXZZQUU3SXBjSUFWVml5a0dPOTdrYkFYd1RRYWxnRXZXYVZDVita?=
 =?utf-8?B?b0FhbHZPRjBmK1VkMHZ3WE1RdUQwTFlCTDU4ckhBaHhFUG1PNDZydlNDdXhB?=
 =?utf-8?B?aVFYMjM5RzRraUh1UEwyN1VKTXE0S2NUQnQyaEg0bEJFaGFMci9qbnZpN1hm?=
 =?utf-8?B?c2s5MXNDMXpKUy81aytqK09KSHhDazYxOEhZWGEwVmcyU0hXNUV1bndSeVdT?=
 =?utf-8?B?OVpMREZNQ3hnQldLQkRqK252a1BoeDYvd0JwaDE2eHRIc0NiZEJJVkpxMnpE?=
 =?utf-8?B?b3o5N1ZRYmNWMTVNVDdwbkgwK1ZucEpvWXZCVkdNb2tmWUw1WDhRd25Fdzcr?=
 =?utf-8?B?bncyMUtQYmp5Y04yL0pQWmNNdVpIMGpSMjc4dUpHSjk2RmlFb2pYV0tvcUpN?=
 =?utf-8?B?WUVUclpBNE8wSEF6cTJsYkxHTk9DekZ1U3JpYkc2NW5uNTM0WUQwNUpqVXM3?=
 =?utf-8?B?WTJYb1cvSDMrT0dpb1krRi9Nb0tkUjd6VXh1RFF2MHlBeXYyUU52QktwdXJl?=
 =?utf-8?B?ZXhyd21pcWZuaVBReGVmNzZFMGlVUElObk4xTDdUc3RNU01jZjZqUmk2NFZr?=
 =?utf-8?B?K25uQXFhVkRYcXF4aDZUeTdqZXVXZDhyRW96eVJqNzFhSS9aMzVDVFR1c2tY?=
 =?utf-8?B?OVN3VVIrSGFuV2NCUzhZdHV3Ui9SRktYaUNFZExxdHhzVUVwcy94YnZyT0lK?=
 =?utf-8?B?aGZWMjl1U0h3aEc0NHFnM2Z3Q0JYZUhoTTBZMEt5d3dSUlM1ZlgzTlV3bzRC?=
 =?utf-8?B?bHA3Nmh3WHhpbGd4MjloNFE4K1pTNTdZVjlCalptbU9YNE9JeTdEeHVsdysx?=
 =?utf-8?B?dDhMRE4xVlczVG92cGl0YmIyemduSjV2bFk5VG9UR0w5VVE3VjVtd2h1bFZo?=
 =?utf-8?Q?5RSY=3D?=
X-Microsoft-Antispam-Message-Info: /XLxh3l1lVjxHILvDS1B9Yttk4XXNSnVJR9O3blfKKWW0+gCsha6RBw8X22hl70+ehF6iJ2vFYJ4HrRM1dvvIWnHQbm7YYn3VwetIHHomCJTdx7dh86VkQv9Q/NwpEtISvkvq6ZyIv+v83MO1R4Rdpln7FEtYbsH9k/R0t8Y3q1i3I+JX//kCXTg0j5bFQsPakMQ1gUhGy5vL0L8eJFQax44E9gVyVBG3Wb8WODi+qKadnfE42TbGWo1wy9vfF8LwFZA0OKAGec2M7q/hSwg4Ygzu2YxlaQ/MUIQprLa4gC5k08nYm8Dj/ACBNdu5Qq4oJnUpwUp1aBIBV3pU7L/FcfJuFk3WWCG4Ll3ofoFu7k=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3093;6:cZ1BbKHM4fXV5s/MuOwPTu050V524TPUMD+j0PkbYnDKFE7f4vN0BMzJJiQMly+eLkB7rf2Noq2g1lxiK7rorHCQskDyfjuEt6KnzGBLgzyGTpuu9didZ7WyhhgnTytZJHYtPtvUKmm45cu/WJtNHlWNmt6sy3jmpVt4/tmQ9/q9Hh/TYds+itqXjdnPW2YM0HpnUrkrqrsba6/gYDq+jGydj7jYA0keq5gXIbcFD5XOVKFVpNtply2X8AjgGhBYSvbj7ghed/12tgJgysGsIyn4wGruDlpKQOi1Iy+QVLMYEpMAdn7VpMsBPFtVcG23COY7+Hy0tuQRNLlCVdVJARfLM5+ER7uhjVpOfc2X14jB0nLqWpCyCEpeOKGnOaq12GuuCFyUvjezxGM7qscMRjD0g9crtS1++tkg5Ujl/IJHxkLG7vFN0vQqhP+qtDt7lQLu68OZVn9TGEt1m/BBUA==;5:hEFsbO6K2eSAvo0LjAdE1b/OSpERpog0YYVwWJ6pN1rDgbsnG8bqv8tIeEtdMT04z35jEz+OXbQFbnABoQo/j2bYY9EKui8GNK1JsRxai3HxK26D2HmIBy1Uq3/84x8GpzEXLwrQXdjgWNlN4hc32ZgNIBmbIN9COmp1AUjfOX8=;7:4g5xTzGncnG8nS2E6/903Ghw7z9nweR9m/Z4hqmJuYls//wfL37Y99JR00eWxnSCN6UOh76KiqFdun6woCc+I6gC6RKQDxqYTxdmRZvgPJRiCg9asCmSsTL69LcSU4NhVAdhR4xDS7qE/j11lf1rwMlrrG7enHzYAndlUiLVOt8W1QDAn3fkqz/GPs4K/FIjSPMflNzK7LNeOGX5gnZ07Wbr1gD1RGek8wm9Cv+cgVWhJseHiQyWVQyNwRiuA3SO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 15:22:38.6578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd8138a-8aa9-4e93-b3cf-08d61f0ce6fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/18 15:07, Auger Eric wrote:
> Hi Suzuki,
> On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
>> On arm64 VTTBR_EL2:BADDR holds the base address for the stage2
>> translation table. The Arm ARM mandates that the bits BADDR[x-1:0]
>> should be 0, where 'x' is defined for a given IPA Size and the
>> number of levels for a translation granule size. It is defined
>> using some magical constants. This patch is a reverse engineered
>> implementation to calculate the 'x' at runtime for a given ipa and
>> number of page table levels. See patch for more details.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
>> ---
>> Changes since V3:
>>   - Update reference to latest ARM ARM and improve commentary
>> ---
>>   arch/arm64/include/asm/kvm_arm.h | 63 +++++++++++++++++++++++++++++---
>>   arch/arm64/include/asm/kvm_mmu.h | 25 ++++++++++++-
>>   2 files changed, 81 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/k=
vm_arm.h
>> index 14317b3a1820..3fb1d440be6e 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -123,7 +123,6 @@
>>   #define VTCR_EL2_SL0_MASK  (3 << VTCR_EL2_SL0_SHIFT)
>>   #define VTCR_EL2_SL0_LVL1  (1 << VTCR_EL2_SL0_SHIFT)
>>   #define VTCR_EL2_T0SZ_MASK 0x3f
>> -#define VTCR_EL2_T0SZ_40B   24
>>   #define VTCR_EL2_VS_SHIFT  19
>>   #define VTCR_EL2_VS_8BIT   (0 << VTCR_EL2_VS_SHIFT)
>>   #define VTCR_EL2_VS_16BIT  (1 << VTCR_EL2_VS_SHIFT)
>> @@ -140,11 +139,8 @@
>>    * Note that when using 4K pages, we concatenate two first level page =
tables
>>    * together. With 16K pages, we concatenate 16 first level page tables=
.
>>    *
>> - * The magic numbers used for VTTBR_X in this patch can be found in Tab=
les
>> - * D4-23 and D4-25 in ARM DDI 0487A.b.
>>    */
>>
>> -#define VTCR_EL2_T0SZ_IPA   VTCR_EL2_T0SZ_40B
>>   #define VTCR_EL2_COMMON_BITS       (VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN=
0_WBWA | \
>>                               VTCR_EL2_IRGN0_WBWA | VTCR_EL2_RES1)
>>
>> @@ -175,9 +171,64 @@
>>   #endif
>>
>>   #define VTCR_EL2_FLAGS                     (VTCR_EL2_COMMON_BITS | VTC=
R_EL2_TGRAN_FLAGS)
>> -#define VTTBR_X                             (VTTBR_X_TGRAN_MAGIC - VTCR=
_EL2_T0SZ_IPA)
>> +/*
>> + * ARM VMSAv8-64 defines an algorithm for finding the translation table
>> + * descriptors in section D4.2.8 in ARM DDI 0487C.a.
>> + *
>> + * The algorithm defines the expectations on the BaseAddress (for the p=
age
>> + * table) bits resolved at each level based on the page size, entry lev=
el
>> + * and T0SZ. The variable "x" in the algorithm also affects the VTTBR:B=
ADDR
>> + * for stage2 page table.
>> + *
>> + * The value of "x" is calculated as :
>> + *  x =3D Magic_N - T0SZ
>
> What is not crystal clear to me is the "if SL0b,c =3D n" case where x get
> a value not based on Magic_N. Please could you explain why it is not
> relevant?

We only care about the "x" for the "entry" level of the table look up
to make sure that the VTTBR is physical address meets the required
alignment. In both cases, if SL0 b,c =3D=3D n, x is (PAGE_SHIFT) iff the
level you are looking at is not the "entry level". So this should always
be page aligned, like any intermediate level table.

The Magic value is needed only needed for the "entry" level due to the
fact that we may have lesser bits to resolve (i.e, depending on your
PAMax or in other words T0SZ) than the intermediate levels (where we
always resolve {PAGE_SHIFT - 3} bits. This is further complicated by the
fact that Stage2 could use different number of levels for a given T0SZ
than the stage1.
I acknowledge that the algorithm is a bit too cryptic and I spent quite
sometime decode it to the formula we use below ;-).

I could update the comment to :

/*
  * ARM VMSAv8-64 defines an algorithm for finding the translation table
  * descriptors in section D4.2.8 in ARM DDI 0487C.a.
  *
  * The algorithm defines the expectations on the translation table
  * addresses for each level, based on PAGE_SIZE, entry level
  * and the translation table size (T0SZ). The variable "x" in the
  * algorithm determines the alignment of a table base address at a given
  * level and thus determines the alignment of VTTBR:BADDR for stage2
  * page table entry level.
  * Since the number of bits resolved at the entry level could vary
  * depending on the T0SZ, the value of "x" is defined based on a
  * Magic constant for a given PAGE_SIZE and Entry Level. The
  * intermediate levels must be always aligned to the PAGE_SIZE (i.e,
  * x =3D PAGE_SHIFT).
  *
  * The value of "x" for entry level is calculated as :
  *     x =3D Magic_N - T0SZ
  *

...

Suzuki
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
