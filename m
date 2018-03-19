Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971045AbeCST4k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:56:40 -0400
Received: from mail-eopbgr40099.outbound.protection.outlook.com ([40.107.4.99]:45074
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S969445AbeCST4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:56:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <99548eb6-1958-b2a1-1f2c-ba995f8965ee@axentia.se>
 <20180319184850.GB23774@roeck-us.net>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <11684f49-dee5-7037-f5c9-5bb8becf114f@axentia.se>
Date: Mon, 19 Mar 2018 20:55:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319184850.GB23774@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0063.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::31) To AM4PR0202MB2771.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03bd4c53-616e-4086-1349-08d58dd36fae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;3:Pu6ky7pxSWiMfC008VA8saWNlnzaFCyY6/N/kToTIyEJZSOAh5D9MKyYQVIcQl22S0ffudzZwtICiqbwMsvB4/PQ45BD2lCEDUlpXpqLLW1sjuHNVur4StZKUmawzKLGnrla9NwSXTF//YhWRcCq2ux+4+XQtxyNtk8LgEVh5N/PYNNJPUJ528xIKiKt7tCWYLw+T5LZsiTOngG3VWS2jJ8rmc6F3kG7Kz60ITVEO7BQn60HTtVEsVaT4pd+KYNU;25:OEreWXn3mXgPsKA2Ik3PIgw3yvjn8Df+0asWg87NEBcVSONnokOVkCcbw9pOibAnRii8QSqWi/q+kL3BIzK/9OFSHc1uPJ0syGd/i/+b8rddYOMEbrh9MtSMCpMHJcVs6SejhDyGpEXvr3gRB+oeq8yj2rL289JRbblGkTU4ZStuYdm6mYtdCfTrphl4yDCks7/0+SRZlDSFcvsE7M68TO74E4eN4E308j8W/lWjMGOgVV5CoIJRP+VzxPqzXD5u7nvmyeuTqmT68khGBiHfc9F6Z/xS8PFvp0yPtN7Sk62eQT4gg5G57awCyq7NxjA/n6FniLIwYAD9Sid5u/tElQ==;31:+q6A0xYY1xeNlvH0kvpA9/Lyz23qTAPbFHZkOjEOP46/LoqhvyxM4GFlQilJ9hs+lUuxyDd2gAz2b1zx1+wePFhy5ny9MNQK1HmUE6sXlc347ahyB2m4EvULXM+kreGk7PTTVqWS668Fb95G8dTLOZvY9idiligKo2cO2FvSF6DQUQDPDdL3cFlUikXfgYdlUlitsffohjneXpA7TiZqtaDDhTmcaQ2g0MyAsCnLuv4=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2771:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27718B424BE5B5A808353A70BCD40@AM4PR0202MB2771.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501302)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2771;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;4:ztQNfdiDtLhnrj4f4RJTcPc0j7KHdTlc1KrXwmyZs6C93gJJeASQtAAkQY4SdKRA888qc6tCtfvL+TToy4s0b/ULdovstnDhgyIy2qAnUA5peYFXs7ojy38euOUk9D08LYffc634y1/IwvrQ12g3fSTMjKOPBHap0M1/HJ0l8V4qb9M+4rYEDWAYFdYeeCqWTIk0kocrjCfHiMRsWfgVM6fXdbrcFE+yHxtdFHg+azVTkhUmerMjzS4UENUlCXOtF25ToCC3stDW5Zn7OglCQZUWW2rQsYkwqaGI/kiSKXXLz/CoRHfqqcCJdGqxDuOF
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(39380400002)(346002)(366004)(376002)(377424004)(199004)(189003)(6666003)(16576012)(58126008)(76176011)(6916009)(2950100002)(2906002)(316002)(68736007)(54906003)(66066001)(65806001)(36916002)(47776003)(2486003)(23676004)(6486002)(52146003)(105586002)(65956001)(86362001)(6306002)(52116002)(50466002)(966005)(229853002)(478600001)(8936002)(31686004)(5660300001)(65826007)(53546011)(386003)(97736004)(16799955002)(64126003)(36756003)(8676002)(4326008)(81156014)(7736002)(81166006)(106356001)(15760500003)(25786009)(3846002)(186003)(6116002)(230700001)(31696002)(305945005)(77096007)(6246003)(26005)(117156002)(3260700006)(74482002)(16526019)(53936002)(217873001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2771;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzE7MjM6emFCNjR5RTJGOVlZRGgvUHU5ZkxjZy8x?=
 =?utf-8?B?ZjFYWGh6R0JCTlpMQThiSFNreHBTVlk4V1IraXFqTGZ5YU1yMTkyVlh5cnI0?=
 =?utf-8?B?MHRDNHhmR3JSK3RpRHBpWjR3dVhKUDduYmgzRzZaMkNHR3pWdmwzMVA5YjQy?=
 =?utf-8?B?LzA4b2F3QjRDb01RblYrOVpKZWorK24waGlQcmN0MEpUUUVVeXhlNS9ZUHFm?=
 =?utf-8?B?d201aVVFRDJJYXZ4QWNGMlhhTG1TaWJWN1dsNllML1ZjV2wycFFZeFRXUXVN?=
 =?utf-8?B?bFQvZEtpSEl2M2FVTmUwZUVYS2FzejJhVzVOWVM2c2hJaUx0L2Y1WFplNy9P?=
 =?utf-8?B?cDdiVGpoVlVsaCtYcVpEeGY0RkduZUhITXk5aHJTZk5GNDZ4QXowTnM5THBT?=
 =?utf-8?B?TUgwbjc0MjU4bHdwZysyczFieisrSGpaa0NZRW5QbitOaVZtNUhmRHNMS0lx?=
 =?utf-8?B?WXU2aU9ESUp1UG1sT2liR20wSUNGRjE1cWxGaGMwaVpvOE1jOVFpbkFhd1Fw?=
 =?utf-8?B?RjBhbk50SUdZeHRUSUttcE5LOVdsMnFkemo1cytVSHUyVi9KNm1VRnVNeVR0?=
 =?utf-8?B?SW1menRVU0xhc2puNlJNUG1ubUt3M2ZLbUo1TFhjTXZ6bG4vKy83Q3YzS2VT?=
 =?utf-8?B?U3pLVytWalFSY2M2LzFzRExDNlN2aGpaWENUdTlEV1Q0NDVpa1I1Z3E1b0du?=
 =?utf-8?B?eXJNNlJRWitoZWw1NElPQkMramhPeXhKM3dtQVVTZGZETkNTZjkvRkxLd3lx?=
 =?utf-8?B?ME5lWE8rQnZsQUZXT0tzMjJJKzg4UzJxUFZHVG9PSU5rMWlkK0U3S05WQ3hH?=
 =?utf-8?B?bGZEWGNZYzh6Y0tKS2JVNEgwWU5SM1dkNm5GVWZBam1Cb09JSmFlV2hRU3Vm?=
 =?utf-8?B?ZEZqSDVUd0U5REFSVVhWSi9RTFdyR1NXd1hMcVFha0ZRZ0hGSUFqQmFHSHVt?=
 =?utf-8?B?NUdFOGJGMXlZbzVHOWQwdFhyQXBMdUx6THVQNUoySktqU1lkY1laYWVTUzNZ?=
 =?utf-8?B?NkNJa3ZnNkl3QUVHYVhjK2FZdTQwM1c4Y2ErTVNyTk1mZDQ3UU1ZK2Y1QWVE?=
 =?utf-8?B?VE5VL2NDNFIyRytYSHJBYnFFNEdxL3FRVUFBZjNEc1AreURBNUlldVlNdk1j?=
 =?utf-8?B?SDdrNm5YTExYUjNiWTlLbE15dTEwYUpmVlQyU2Z3dS9FcHU4cDlyZGhHWEVH?=
 =?utf-8?B?RjMwMFBqcTlWeGpJZnJWcGQ4R2h5amlkV1pySjJINFIrYXFYZjNpSXBkaGxP?=
 =?utf-8?B?MDNlV3VyWDZ0ZWlLdkl5aCtXUWVIVktqQUdQZWRoZnhnT3MvQVJQN0ZxVlNF?=
 =?utf-8?B?ZWNhd0hiTmxJUEgxNkQ0Y0prTlNTb1VaY1hEc29ycWgxNlMzcmxYb1pJeFlD?=
 =?utf-8?B?V0FoVy9vQVVoVnBJS3hBNWwrVVlxK280M2Jlc0Q1bU5hZDdnWW5xaElzK1Fl?=
 =?utf-8?B?WVNSaXJmMWN5MUVKWmVVcVlydVl0NlJxTkx3dVdMaWwwK2F6NkVDSGh2WTNl?=
 =?utf-8?B?Kzc2WEIwdE9YemhFVmpPa3JmSWFXOVp3b0dJV0pBQXYyRVZsbUQwMytsbWZs?=
 =?utf-8?B?K0QwZVdmck1xZmdNZGx3Q2JZbEJDOGx3aS80Q0ZYMjhkQzI1eEEycCtZWmd2?=
 =?utf-8?B?Zjc3YzRaOFR3S0VpWHExV2tCcm5XbVowdlUzV1NmYVNOenVIWGhRWU5VSlc4?=
 =?utf-8?B?TStDcG9qamxkamVMdFh1bXlNM3BPUUdHbHBnc282UlE4VE5mMUJTd3dVbWtw?=
 =?utf-8?B?bkFJMm9EQVovbW90SEU3UGI4REpLeUEyd3llU05vb0c5S2p0NVAxZURwQWQ5?=
 =?utf-8?B?OURMZWFrYnIwRXpSUDUvTWdjV2trOHI2RnFLdW83N1Y0dHNrbWRTRUNlUGJt?=
 =?utf-8?B?aVdzS3ZFaUpUaHBqdVQ4UTY0RGp4dzlrMk0wMEVRdGJpb0k0S3Mzc2ZUVURK?=
 =?utf-8?B?a2Zoa3RWb2tTeHJ1UEhveEF6L1gvNHJ2bzdmUmt2YnNGYjBYQVVXNEMvWk9i?=
 =?utf-8?B?SzM5aU9CNHFYdlhvcU1lZURLSS9DWlFxTkNUeis2eE1vQWg1cVFhd0xqRHFW?=
 =?utf-8?B?MFFOSXFWVkpHSXgxQzVtTHk2UHZIeDM1YW9YeUtDL1cxL2N3YnlLZVZDRTE5?=
 =?utf-8?Q?W16G0j0cnBxxTnUY8bDCH3RtWVVn6HAvmB322+4t6TBGH8?=
X-Microsoft-Antispam-Message-Info: oIAo5Ilw8WR2aMAfHhkoReWUaZeLullWT+1twmSLKLNqaozqesWvaU8N3IoWTHWuN7NKRCbbNdnWUfh18gG9jhjoHhIJuNii7AACUR47N2Gunkn1jGZWjPdIgHy6rc+jmgQe2/BEL/EU9LdQEzHHk3gjiexX7gMo0cGINLZsyQPg8e9n+j9Vgd1i4Vh1WZR6
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;6:LOAWnmH9O3h7PT7pjoV6DZDEo2xJzvjCT3B2bNr/1piLc4pzpVcQXHkTKKnPEbnkEO6nKYK48NifQ68bGe0eTa6QVsF6j2W9762Kn7yu+vE4vSVQmQHyRh7e7u8eO8teMyoSmJaddEV344/NjDBMqVoplgZgyaPZJKeKpro6NswPJ+SRqXmRF84FYzjSdCER3QYxIS9wX32x/eW7ZWMrdaT8TdDMEJjj2X2zhasKwqTvilGpP/PbSbRCDx1I8leatSqKJEL3LIHiX6XUSctn0aIbw0+8JptLjfPxHWEb4fIvS8q93RfNH6X67gFYPiaTEoDfq4rc9bIqWJ6hMJWUWo6S2DgZQP9hAhrV6PawtNU=;5:DTxppE1pod/ogYN/cWUFvn3gt2/7KNvUvJJ9xfKygAhdARBjug8wO1O/au7jVi2htuaVikI90jha5z2KYsvqD/Qgxnphg4066M9zhqaDAxsz8Burw0tiSZWxfFM9BDD3qt2kfMWx0FAaopcwlFd/VFui777rUYUdhrUxuzMnJ3U=;24:54C9VjtEsqf674IWH6yABlJjv995b2Ao5VAlEU0A4BsOirPs7mHZ4l7kbUCBlwcXTya7hK/0DbVsI/sLjtZSca5iUrccyIyc8M47vWD9w0k=;7:LHDSKp2de6Tw6+CdnOQ8Lf8Y4JpKWoKZU6tm4fpkPm2X+87KMPC2VAOA2EZKdBnpQuNpnnb/5Y8ho/2yRIcsZHL2VsHonfTlX+ujWBmo+vZ2l2oUEAeJn+VTJ4pTjqoEwRk5OSXyV1EQ30VzJQh2igefkdqQS6lIcDLcu7ONCljXSBcvPo5xM9Ufy15U32my3mKt5G46GihOLaXPE698TAaaS4aI8vGj6Y9qyTDVJ+4YMrgGAlrBUG6iix2ocX9/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 19:55:58.7682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bd4c53-616e-4086-1349-08d58dd36fae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2771
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-19 19:48, Guenter Roeck wrote:
> On Mon, Mar 19, 2018 at 05:47:05PM +0100, Peter Rosin wrote:
>> I also wonder if NXP will ever release a chip with part-id 0 and
>> die-revision 0? If not, an all zero struct i2c_device_identity
>> could be used instead of manufacturer_id 0xffff and that would
>> simplify the pca954x driver code a bit more. But I guess we can
>> never know the answer to that question. And even if we did, the
>> answer might change later. But it would be nice...
>>
> 
> That would be nice. You could ask at i2c.support@nxp.com, but I guess
> it would always be somewhat risky since the standard doesn't restrict
> its use, and some product manager at NXP might decide in the future
> that a device ID of 0x00 would be "cool".

No need to bother NXP, PCA9848 has already claimed 0-0-0. Sigh.

But while I googled that I found old datasheets for the chips PCA9672
through PCA9675 which use a different layout for the three bytes in
the device id. They have 8 manufacturer bits, 7 category bits, 6 bits
of feature indication and then 3 bits of revision. The top category
bits are zero so it is compatible for NXP chips. But since noone else
has implemented this, it is probably safe, but still a little bit
disturbing.

I also found that NXP apparently uses the same part id (0x100) and die
revision (0) for PCA9570 and PCA9670. That seems odd.

Example old datasheet (2006):
https://www.digchip.com/datasheets/download_datasheet.php?id=1098812&part-number=PCA9672

Cheers,
Peter
