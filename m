Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A42EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44C32157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zQXg3855"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44C32157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeHXKzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:55:41 -0400
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:16137
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeHXKzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN3WOJAhOS6Qj5YRQ22soFJVNtAXZmZTq0jxhQeXeAU=;
 b=zQXg3855TYmx1qgLPiAOw+NFRhNoqG06KMTdNqBex3+7t/oZcN+nfIowmsVNTtflr0Mbz/b6JTh5Jrh5+p/n1xXzX/2iAjRCKKZSDsOx8N/1P2n0qvCcsIAg49TWCrxNXoEXFw9ldeG2EZ94TN0DSoYwcHGzDzBBjgHMGSJ9rDo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:112::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Fri, 24 Aug 2018 07:22:10 +0000
Subject: Re: [PATCH 1/1] drm/ttm: Set memory as decrypted for ttm framebuffer
 mappings
To:     Jiandi An <jiandi@amd.com>, Jiandi An <Jiandi.An@amd.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org, ray.huang@amd.com,
        Jerry.Zhang@amd.com
References: <20180822185754.104729-1-jiandi.an@amd.com>
 <d22f2dce-7229-aac8-036b-5312927632e4@gmail.com>
 <2eeaae95-181c-b856-09ae-4ee2423fe3fd@amd.com>
 <92cfac31-a408-210a-d901-1e6511a1cb9a@amd.com>
 <3ef2e755-eb99-0e4b-1e0c-c2ae62aafc10@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b44280d7-eb13-0996-71f5-3fbdeb466801@amd.com>
Date:   Fri, 24 Aug 2018 09:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3ef2e755-eb99-0e4b-1e0c-c2ae62aafc10@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: VI1PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:803:14::21) To MWHPR12MB1726.namprd12.prod.outlook.com
 (2603:10b6:300:112::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b2b432a-9e9a-4c93-0661-08d609924f6a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1726;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;3:S7Y2SHfuBfOTS6tpdx1C83eHqgvEZG7Cs7w8AXdEV1sjpHC2eqhX1WMPnCK7gyx7bl7uQHiMUc/M/W5NQ5k/2S9fQMOaq/o9qomNDZf/dgiLBtXPjPZFaMx0E6qdHo8KfBH/0GRN3kWgO/QjuTTFIHo6lfDy/g7oppWhWea4FRH+itJ9jf3q3kW/7eI1KReuqZSDB8Y1dliU1R0yi2JRrlRCPrY8qNzKMDFR6jYKQ2daSVFKuGA0p4GsbwWSWu4x;25:bGkk9N5y93nzCrmo+cvJuOXZIY5PnFBrYHMs8/86sLxOl3+ObdE/9IVLQ9jPeYMq6AM6Uf5OUXa7D4jL9n+5yD88U7vfgqX1jSR1roeeM2qWbZlBU468rMaZQyzxocdWobVU04SKmO66F9buCbAcfu90e4SUV3OGTPBPzPou3WAvQmvszEIJ6AapUs3w/REfHnj9MS3voPvWDw1auW9NAWsmxkHXDDYPUMvMqMm+YskifCGrKZoVWnso1xy/fum9c58vVQBKZrXd5ShLrrQmOTsM9kHkOZ4nM5mjzJmHRPr3vOPtghbaOWWE8+MsBHezkznc5r98GuPUr7yeNLCMCA==;31:Nw+Yz3lZCuRXPM+edvoVXTlvMa7oUPgIiyDddxVI3jstIjh/AAYTJxY4vLVqzD+93+oRbgnyBBUvV2vS4y9mfNd0u73G9xDikzpgGYBRwGSHW06vYBpFdEr1jGFvG7uxX7CXhnwLtYpp/cJxrkr5nwta4Z7RNyW4MG3g0/Q/PDuCzbWAkoDSCl9JGLI4RgTMJ+4/kmVKbaxM3LyvjIpPc3t9M9sVQFdcjniJZLJCMFY=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1726:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;20:r/9aDSV6D8oDM1+/ijRnaT6a7RwbHpROEGw9AbY/BQYAvoJTwJIwtUzkWoMP1dDMmBldDXEXbDCTgfvFQ4/rXttbEcL/ButVdP8Wp1HhmzazJUWSNl/V7MRq7GKD8PXl4lOnD5Ck7GrTx3aIrGSklnh9JZ16yb64mTtkTGD6eiVmDPB1uqw8SoWPu4AtJaliztx1fis34rOQ9dBxDLY3ZqMa9WFZqhNyQSxwEUQ/uA56rvAgPtIFTdpRPYdGo1IJmObkt5AxRruPGvrROu7TyOybiXw/thmKNsfR7irwPEAACdMjzExfy5DL0chxCxootJm82Qv0l8j8BbnBu2youqJQxFiJ7IWldSZy0tvQsuds5WDAOZS1zZAi5WaGB75OZYArbZqsbxId27iVW53Q9b1hTBZHF+XVe6/QzsUxC/+Wuljo0p5SqTe6OzjKqLH/DUf1nL74E9gGK87QwkvjQIzsoasbARLaTmL8wHvt00N/Qm5pc1KC3SCaBMIKN5cr;4:I/S0s4C4xA+7iNomHFOqxXs4uHg5Y3HpzLr4hQR0g7hIoRFGcZWY0W7w3j/monpluGZ9K2YTTvgAPe8OrH/7FDs3APuWr4d9fydDE3xgN/7WmuuF4tgy38N6dxngBFEUo23BAwVYkPkN5rQxiSa/T8X/GzK7nb07YpA6acehp8n/D2dfoEZ68knoD01FrxrGfj9ja+T9b2y6lg/VcvDvjnuqSrwJDGorT/Uz2DJ1lKWIrRxWgFQ5sSbw1JzA1gvijiI4e6CdhdudfxJ/IYZdJ8re3L1wmMggMlEtg3mBpoNJmjmz/x0mYedjEBdO96zJ
X-Microsoft-Antispam-PRVS: <MWHPR12MB17260653C2E7097288FCB96683360@MWHPR12MB1726.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR12MB1726;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1726;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(43544003)(51914003)(486006)(52116002)(2486003)(76176011)(4326008)(52146003)(68736007)(23676004)(6486002)(16526019)(36756003)(476003)(11346002)(316002)(6246003)(52396003)(47776003)(25786009)(67846002)(2870700001)(110136005)(478600001)(53546011)(65806001)(386003)(2906002)(446003)(8936002)(229853002)(72206003)(14444005)(5024004)(46003)(2616005)(58126008)(50466002)(6666003)(86362001)(1706002)(65826007)(5660300001)(65956001)(6116002)(81166006)(64126003)(105586002)(81156014)(53936002)(305945005)(93886005)(97736004)(7736002)(31696002)(31686004)(8676002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1726;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI2OzIzOjFtL0V2ZnBqQ1pPRmZiQjZRLzd5MTJCQkxu?=
 =?utf-8?B?VFRQSEpnKytnVUNrMUFvODRKbzF6MkZ4SW9oNld6c1pVa1NHdjRlNm9ZcGJD?=
 =?utf-8?B?anYySDVkdGkwbDhOYlo2VEFUZ29PdzJraHNBbThrV2ExaHJKeW8yaDdHWWJS?=
 =?utf-8?B?cFh4WUwzalVKMUVCM1AvYUR5R2lEV0pzTThpTTVEWEZyTTVHbnByK08yNlI2?=
 =?utf-8?B?MS9lYTBRU2NvZW14VVY3ZDc4TEZrQUdIdG56YWsxSjNVNVNPb0I2T3ZQbFUz?=
 =?utf-8?B?ZUVMUlFQeVczc3QvQllLRzRZd2wvZCt3OS9iTjUrL3kzZEd5TjUyOTRVR3VP?=
 =?utf-8?B?UFVKdEVadEE1dXI2Sjkrd2gvVTRIUlJQVzQ2RU13bDhPblJ5aVNLcHZwam9v?=
 =?utf-8?B?NUxrUDhqa0cxOFIxVkRLbGdLL3o3NWhpZHdXRlpBck5Ba3R2MmdnbDN6MU5n?=
 =?utf-8?B?clpuNzJ5cVhYWlJrcFRtUWlHYWtqT1N6SDFrbzlPcXB4R2lUWTdlTlZlQWI0?=
 =?utf-8?B?bG9vOWY2ZlUyNU1vNm4rc3Y4TG5jczk4V1YxOG5oN1ZFMXlwWC9VMk9jMlZB?=
 =?utf-8?B?YWJ4L0FEVnpVamsxcWp6bHhZY3RMT2x3RzlCbzB0V29iU0ovVEhjWTh3WFRv?=
 =?utf-8?B?UmJKVlBSaGdpOFBOaG9HT3Y3VkpZV0I2bEo5UW1FZXR6RmtTL0xHSzI4bDJG?=
 =?utf-8?B?eElsZWRvNVZ5S2ZMM254NVR6VHJWMjhRZmVRV3haNlR6cUNDcGtSbGlZb1ht?=
 =?utf-8?B?T1hmTFFaQjlXVkVoNVhsSnZxRzA0RkZUTzgvTmE4WUxOV1Z0M215YjkzMU1K?=
 =?utf-8?B?R0g0Umc4NXJQcXFSL09UbEhQUVhINTkrV3FjVGZDQnd5Y3BzVVZsbmYwSHdV?=
 =?utf-8?B?SFRaaDcrTVA3RlliZml6c1o2bkR6VHZweFhuNzhNOEt6Qnp2U3Nqc2VUeG01?=
 =?utf-8?B?SmZSYzFSS1hVWEprNWhPd0tnSWJOcDBJemxoc1MzQ2xjOS9DTXRRaG9sanNv?=
 =?utf-8?B?YmxWWmVtNGN4bnNkdnE5OWg0Zy82cUIvTjJLZFd3STJWbUFiYmpJdkhiMm9U?=
 =?utf-8?B?Y0F1NmkzTjRKd3AvNTl1U202L1hJbGFrZFNQbzBvU2dQRnV1SGU3L2VZOFpx?=
 =?utf-8?B?bFRGK2djUFRKSjRVNm1KUHZWbXNpYllMNVlMSitqejdwZkVGNEswakhIdkVJ?=
 =?utf-8?B?Y21zYjZHNEo4K2FhcWdvc1VQbk9aSUxWTUxuQ1ZTQTQzdXc5Wmh3Qm1iYmsr?=
 =?utf-8?B?TXJ2VGtEejZJbTdyVWdjcGhQMStjc1pOMmpTbXEzeGI2WkE3MXJnSVgvM2Uw?=
 =?utf-8?B?WDZSSnZDdnZBcUZsNkF5QTJ0dkc2cXJBQm1JS3FUVGV4YW5WNERFSTZwdXNV?=
 =?utf-8?B?VG95RGhxYkxmWVU3bklBakRxSUFPNndWcitEMXBsSmc4YWZLLzNKb0VOUVUx?=
 =?utf-8?B?ZFdzK0JGOFRXOU9jS0ZWRW1jdUd6bFgrRUM5a3lBMlpnbGF3NUdZMlVKUy9n?=
 =?utf-8?B?S0hySlBDaC80RDhCNkFpMkFLd0d3TzBtbVdqRFMybWlJYWRyZ00rZVVMYS9w?=
 =?utf-8?B?Uk5weDJJUWJUVXZaNDBrNkNlT3BKQkhvU25tVDNQM2dhQ0RMVXl4SndRUGR4?=
 =?utf-8?B?S1IzWEJqcVJEVlpybllZWG1ubjNYeFNhTFRkRzRRUHNocFJxd0ptWE55NzJp?=
 =?utf-8?B?OXdCQXR6a0tNb1J5cE1LVnQrbkJCNzdNWDBEZlVKM2lnMWRQMzFoREl6NkxU?=
 =?utf-8?B?ZjB1WjJzRllORkpIWDJmQW5xQy9kdWtpZXRhdlpmVUYzOTBzYVQwZFFLQkQ3?=
 =?utf-8?B?NkpxeFRyVDNoK1FxWGZha09tYkFGV3JyMHJ2S2dJdjhMTmVtZDVIQUhKK1JP?=
 =?utf-8?B?azQzMVhjcjRhRGtVUHQydlBOeEhPU0Q1bmRQS3JnQ0M3YWRZU29Ybm12Wnh6?=
 =?utf-8?B?VFkybHlwMlJObDBCVkpTWFhnZjNNSGdXZ2M4WW0vMFQzWUpxN2tGdUx4aGc5?=
 =?utf-8?Q?+cnW3q?=
X-Microsoft-Antispam-Message-Info: pGH8YgEBeWcfvhk4o8Z3hOvyuu/8NVKG7uzkixzENW6DaDKTGpB6iPooOFtNRiHW7EQh5fjvKTnUh9Sf7Fcuu1f7jOj8AaA20Rc06BjHqFOowcAiEig3svylA61mlBuPNQjg5D7MgIZWX5NuDXLBJEqpXGAqHQbmiD9l2oNGKFbUbDmIbRixkWhug+FKpLobGODbVItMa+TQHJhDG38hsMJN78MQx2C+naGzXnsvUNnQo1bEDwdG2EoPG/xiCanq6KjImDskOLxmfttUTXwPPaohoEuRP+mqdSsITNiF3gKHfb00YVAZaCpJGw0foxFMT7MDz/fRch3ZMQqyQEADpQT6/V+qduQ5QiA91PMQkWs=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;6:B1efcFJoBzFYlyyIFphW8JX3EQV8punBMiZPera0oeyXZHOCf6rc0rM5RgfJcrDvBFpScbSzU9d8fYhlGJk98aU7SpDhEzxxctOoqbyIzLfg/vEYcxuxK7N0BUWzVBfEEGIV+LyUjCYc4mhmuc7SSMPY9wnGwoO//aCmDpJDy3GUkG82XBE7jPMpVPqUtUXVVlJqtd7LcuThnmkbQfuE9lFdU4IHtbd+QhxbLMrcfMCRTI2dk66vzp9FO0zQxYv7evqy9Ho2OMM2jHe+xG/QQOG0ZZ2/b2wXMV6nJ6k9VRnuNxNH8F2AsmQO+gVCiMdl+KbqhWFBu/mLOhDoI7FFUx+4wPogWWfcimOV+1wtK9oO0hYn7rw32DLecX3jl3XASIUigErdX1dZbnv3aiNoOqzL0wLacGNSnH7erGn8XD9xRut/PcmSrQEDPIbiCVuDgbDfFD0uvnu2XL77oAjOWA==;5:fkpPqmdsHoK5TOlvUWhY4Lhp6NvXJq8bSLNmQnGZiWKaAugN666QWvBbCgevvfJqSzZDcJOnWDzWvJ1VpAhvT+JCkKRTtYrn0pOdytJ6c2rMopG0BTLFqvhxq2D2Ddlh/Nb2NHMqVyWnntMfKL+E5SBzt7xpuiO4GXurGDCjP0Q=;7:V3PdAuFWknI80IscOlIXIqf01p/Q8wfwGxHKL6yjLEFcLEnL1qf/qk+NGMDZNLDOVBhsxfdwHeaZIVBR05hQuri2yHT1GEHUozc/Sr1fJWWZNC79UZppALOXMjScEXBwBboZcHdDrhA+nASPbpqm3wiIrEaxDHb9r4Aso2ChF3Lu51sTRkw1Uxd7kOb7gXt6e1Os47H5ckni3cRwmYBblQUGfRSecsQDOZfVPKFFZoqOJ2nLtIAxUUJXc5czbh9S
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;20:vaDcOXEklVcYVPEB5jYr9KytiGfhwEKAEYQpq93bbq3itQ+Aux5jSh5I9lTTbfpktNA8ubxa/U5+xoYbV21s9Mqmu8dUULY4os/WG8GkuhYNvCFDOdz3aFVQh1rbWFtFESJIHHEIBY3cLY6nx0h/ZlFA/bFrJyrCclu5BvibPy19wB4+ayj9IOmq+n5LGxtaGNCPYme5EjXrARosjG1cdRetL5Mav8JdczG+oF7INBNO+EpWKJkN+J1j4yFzb0og
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 07:22:10.3482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2b432a-9e9a-4c93-0661-08d609924f6a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.2018 um 01:05 schrieb Jiandi An:
>
>
> On 08/23/2018 01:47 AM, Christian König wrote:
>> Am 22.08.2018 um 22:57 schrieb Jiandi An:
>>>
>>> On 08/22/2018 02:09 PM, Christian König wrote:
>>>> Am 22.08.2018 um 20:57 schrieb Jiandi An:
>>>>> Framebuffer memory needs to be accessed decrypted.  Ensure the
>>>>> memory encryption mask is not set for the ttm framebuffer mappings.
>>>> NAK, the memory not only needs to be decrypted while CPU accessed 
>>>> but all the time.
>>>>
>>>> ttm_page_alloc.c and ttm_page_alloc_dma.c should already take care 
>>>> of that while mapping the pages.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>> The path where the issue comes in is booting guest with AMD SEV 
>>> enabled while using virtio-vga device.
>>> The ttm->pages doesn't go through ttm_populate_and_map_pages().
>>
>> And that is the point where you need to jump in and fix the problem.
>>
>> When a driver implements the populate() and unpopulate() callbacks 
>> themselves it needs to take care of all that handling.
> Thanks for the suggestion and guidance.  So you want me to register 
> the callbacks something like virtio_gpu_ttm_populate() and 
> virtio_gpu_ttm_unpopulate() in the virtio_gpu_bo_driver,

Yes, that is one possibility. The alternative is directly hack that into 
the ttm_tt_populate() and ttm_tt_unpopulate() functions.

> and perform mapping by calling ttm_bo_kmap()?  Then bring setting 
> memory decrypted/encryped by calling 
> set_memory_decrypted()/set_memory_encrypted() outside of 
> ttm_bo_kmap(), do it within virtio_gpu_ttm_populate() and 
> virtio_gpu_ttm_unpopulate() callbacks?

No, don't call ttm_bo_kmap() here. I think I now understand where we 
have a misunderstanding.

ttm_bo_kmap() just creates a vmap of the original pages to make them 
look linear to the kernel space.

What you need to do instead is to change the attributes of the original 
page mapping, not the copy in the vmap.

In other words you should call  set_memory_decrypted() for each 
individually allocated page.

>
> Then get rid of the separate call of virtio_gpu_vmap_fb() the 
> virtio_gpu driver does?
>
>>
>>>
>>> In the kernel path, the virtio_gpu driver calls 
>>> virtio_gpu_alloc_object() and goes down to ttm to
>>> allocate pages in ttm_pool_populate().  Driver in guest then does 
>>> virtio_gpu_vmap_fb() which goes
>>> down to ttm_bo_kmap_ttm() and does a vmap() for GVA to GPA for those 
>>> pages.  If SEV is enabled,
>>> decryption should be set in this GVA to GPA mapping.
>>
>> That assumption is what is incorrect here.
>>
>> TTM can't work with encrypted pages, so you need to set the pages as 
>> decrypted directly after calling ttm_pool_populate().
>>
>> And obviously set it to encrypted again before calling 
>> ttm_pool_unpopulate().
>>
>> Probably best if we add that to ttm_tt_populate()/ttm_tt_unpopulate().
>
> Here when you say ttm_tt_populate() and ttm_tt_unpopulate() you mean 
> the virtio_gpu_ttm_populate() and virtio_gpu_ttm_unpopulate() that I 
> register in virtio_gpu_bo_driver right?

Either as driver specific callbacks or directly in the fallback path of 
ttm_tt_populate() and ttm_tt_unpopulate().

Regards,
Christian.

>
>>
>> Regards,
>> Christian.
>>
>>>    Guest then sends object attach command to host
>>> via virtio_gpu_object_attach() which stuffs the pages' physical 
>>> addresses (guest physical address)
>>> in a scatter list and send them to host QEMU. Host QEMU maps those 
>>> guest pages GPA to HPA and access
>>> via HVA while guest write stuff in those pages via GVA.
>>>
>>> virtio_gpu_alloc_object()
>>>     virtio_gpu_object_create()
>>>        sturct virtio_gpu_object bo kzalloc()
>>>           ttm_bo_init()
>>>           ...
>>>              ttm_tt_create()
>>>                 bo->ttm = bdev->driver->ttm_tt_create()
>>>                     virtio_gpu_ttm_tt_create()
>>>                     ...
>>>                        ttm_tt_populate()
>>>                           ttm_pool_populate()
>>>                              ttm_get_pages(ttm->pages, ttm->num_pages)
>>>
>>> virtio_gpu_vmap_fb()
>>>     virtio_gpu_object_kmap(obj, NULL)
>>>        ttm_bo_kmap
>>>           ttm_mem_io_reserve()
>>>              ttm_bo_kmap_ttm()
>>>                 vmap()
>>>              struct virtio_gpu_object bo->vmap = 
>>> ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
>>>
>>>
>>> virtio_gpu_object_attach() <<== Sending attach backing command
>>>     virtio_gpu_object_get_sg_table()
>>>        if (bo->tbo.ttm->state == tt_unpopulated)
>>>           virtio_gpu_object 
>>> bo.ttm->bdev->driver->ttm_tt_populate(bo->tbo.ttm, &ctx);
>>>              bo->pages = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
>>> sg_alloc_table_from_pages(bo->tbo.ttm->pages)  //Getfrom ttm->pages 
>>> and put in sg
>>>                 __sg_alloc_table_from_pages()
>>>
>>>
>>> There is a separate userspace path for example when displace manager 
>>> kicks in,
>>> virtio_gpu_alloc_object() followed by virtio_gpu_object_attach() are 
>>> called through
>>> the ioctl virtio_gpu_resource_create_ioctl().  The mapping of the 
>>> pages created in this
>>> page are handled in the do_page_fault() path in ttm_bo_vm_ops's 
>>> ttm_bo_vm_fault() handler.
>>>
>>> do_page_fault()
>>>     handle_mm_fault()
>>>        __do_page_fault()
>>>           ttm_bo_vm_fault()
>>>              ttm_bo_reserve()
>>>                 __ttm_bo_reserve()
>>>
>>>              ttm_mem_io_reserve_vm()
>>>                 ttm_mem_io_reserve()
>>>                    bdev->driver->io_mem_reserve()
>>>                       virtio_gpu_ttm_io_mem_reserve()
>>>                          mem->bus.is_iomem = false
>>>                          mem->mem_type == TTM_PL_TT
>>>
>>>
>>> I originally handled setting pages decrypted for the kernel path for 
>>> GVA to GPA mapping in guest
>>> in virtio_gpu_vmap_fb() at the virtio_gpu driver layer.  But for the 
>>> user space path
>>> virtio_gpu_vmap_fb() is not called.  Mapping is handled in the 
>>> page_fault handler.  So I moved it
>>> to the ttm layer.
>>>
>>> What layer do you recommend as more appropriate to handle setting 
>>> memory decrypted for GVA to GPA
>>> mapping for thos ttm->pages?
>>>
>>> Thanks
>>> Jiandi
>>>
>>>>> Signed-off-by: Jiandi An <jiandi.an@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/ttm/ttm_bo_util.c | 12 +++++++++++-
>>>>>    drivers/gpu/drm/ttm/ttm_bo_vm.c   |  6 ++++--
>>>>>    2 files changed, 15 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c 
>>>>> b/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>>> index 046a6dda690a..b3f5d26f571e 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>>> @@ -29,6 +29,7 @@
>>>>>     * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
>>>>>     */
>>>>>    +#include <asm/set_memory.h>
>>>>>    #include <drm/ttm/ttm_bo_driver.h>
>>>>>    #include <drm/ttm/ttm_placement.h>
>>>>>    #include <drm/drm_vma_manager.h>
>>>>> @@ -639,7 +640,11 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
>>>>>        if (ret)
>>>>>            return ret;
>>>>>        if (!bo->mem.bus.is_iomem) {
>>>>> -        return ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
>>>>> +        ret = ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
>>>>> +        if (!ret && sev_active())
>>>>> +            set_memory_decrypted((unsigned long) map->virtual,
>>>>> +                         num_pages);
>>>>> +        return ret;
>>>>>        } else {
>>>>>            offset = start_page << PAGE_SHIFT;
>>>>>            size = num_pages << PAGE_SHIFT;
>>>>> @@ -661,9 +666,14 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
>>>>>            iounmap(map->virtual);
>>>>>            break;
>>>>>        case ttm_bo_map_vmap:
>>>>> +        if (sev_active())
>>>>> +            set_memory_encrypted((unsigned long) map->virtual,
>>>>> +                         bo->num_pages);
>>>>>            vunmap(map->virtual);
>>>>>            break;
>>>>>        case ttm_bo_map_kmap:
>>>>> +        if (sev_active())
>>>>> +            set_memory_encrypted((unsigned long) map->virtual, 1);
>>>>>            kunmap(map->page);
>>>>>            break;
>>>>>        case ttm_bo_map_premapped:
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c 
>>>>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>>> index 6fe91c1b692d..211d3549fd9f 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>>> @@ -249,10 +249,12 @@ static vm_fault_t ttm_bo_vm_fault(struct 
>>>>> vm_fault *vmf)
>>>>>         * Speculatively prefault a number of pages. Only error on
>>>>>         * first page.
>>>>>         */
>>>>> +
>>>>> +    /* Mark framebuffer pages decrypted */
>>>>> +    cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>>>>> +
>>>>>        for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
>>>>>            if (bo->mem.bus.is_iomem) {
>>>>> -            /* Iomem should not be marked encrypted */
>>>>> -            cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>>>>>                pfn = ttm_bo_io_mem_pfn(bo, page_offset);
>>>>>            } else {
>>>>>                page = ttm->pages[page_offset];
>>
>

