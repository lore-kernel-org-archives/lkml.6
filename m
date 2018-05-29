Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934880AbeE2OCs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:02:48 -0400
Received: from mail-db5eur01on0067.outbound.protection.outlook.com ([104.47.2.67]:39296
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933858AbeE2OCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:02:39 -0400
Message-ID: <0e0690c89b24b4b028e4a0dab63334af4b37fdd3.camel@nxp.com>
Subject: Re: [PATCH] soc: imx: gpcv2: correct PGC offset
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com,
        Abel Vesa <abel.vesa@nxp.com>, Richard Liu <xuegang.liu@nxp.com>
Date: Tue, 29 May 2018 17:02:31 +0300
In-Reply-To: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
References: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM6PR0502CA0036.eurprd05.prod.outlook.com
 (2603:10a6:209:1::49) To AM0PR04MB4289.eurprd04.prod.outlook.com
 (2603:10a6:208:67::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4289;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;3:wPMBthcUHBHAxd3VNSzIZy3t+Prh65lv61KvuwFRgJ8gUNc8NpEhtYsmF4fw7I4GUTT+Lanj8BBy4dQbm8MLrX61PnJymoHrgPdViJoWbP+f5w7HM5g82gtg2jsqgKXovmAlrYdj3WOeOK0k2a5OlA17OdLsIazgZk34FdT4DP5yC8LCBkVtETSXNcNGfA3KnDbT5rtE2zPU2zBTAqMNWNdPkifCalfQ1fWbdyvJuMUqY9kbcS9Uta1UWCcSLQ00;25:5h4hhhErMloyA3RT9K3Jd2L1ymji52OHrA9VK7bx8PQNYqLdat5PgHHmjLmmK7YLZ70ANMh8gnCnObBS19958gsut4tSPTMNyL+WUM5IqV5OqxiLrB8qMuyRoXZ/o7YI2GQTBuLP3NRFvC2Jx4LEqdPMXmBJi6SJetz2McBjp1hfl8zLkZDjD1A+fgnVHkEU5nrLIkOdU+JXLMEjQ5s5y1ymT/GM2CD0ZWs303SOaZkqEwWbHFNOUUyKL5AU9VegCRU3eM13l1junvBpWJU4ZgjaMTe9OMhRaO4zhcKZZjw7NEahh/s99O3Gvcvq0M1MVc6lSebYqszVM95SPVl72w==;31:Hdu5CcUtzI/iSzdnzVAqLyZGksNYeHHYPkSuQXhoF1PfNvFgEAhO3XxGwVSUJ0trcImEN3JTG104lUSEK7yR8IgkzEpf8UHXrSZiD7cb+SlUuVzmaRC1PGYx7iMrg4gvLTrNSKCCFmR1pIMdV3IByn1xZdyp//6spVyIlaFZ9nB3MGgZLA/L70vK4Ut80x67Bu1rahxptsn6i2qlUTAiATzTRCEpe/dHc5ZABp+9L3c=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4289:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;20:C929o6xomnYPq3jV6KhDSFQxNLYZnfJkG6cqFZS+PzmSKy9+4lQYS7s1VdrIvzGAxJxvMc4igixTOTXatOXZu9jqhMQ0SD1+vc1dMhN2yYnIVKDFRehbWwEkw9W+egJjMJ2ZqB+qcRHQ1bLsORMpFMSBLq8dhHvXofZjGhQ0kU4KRJyLBMh2IAYip0VBrFO1gKI4DWLsV1oVf3tiUzbFEQNlOY6uSiKMRg6z0VKKe1KrCWeEl5zBu+xtgFNFrwEwXZjhySqL0YCWQr2wyjwkEfERdwuj8G4NUfqvhwHERquIBoqNdL4AjkpybHdgAMFwKSWHNQ1KP/vtJGJb48WuNx0HLOW/D6G+lbtIH9uOpta/ZT8bPk3J5g0clyv+Z4tYy5EDreFXvrJWunRCRKQKqhLSr6ZE8k0YM5Uyeu+L2gXYb5+6FPy5RAY3uLra0XZGjwqyW0wHXT7hZm+XmtV87ypV8H1X+rIro+q2FPmOrci4HbKLvtsfQDAa4k+SjFdi;4:QLsmj7kNd+YzixUB6XNWtiPYDDDY51BiMpf+oAWArbbSyJyJbKdz469dHtxo+YAxsi35r/f6x+oYv92RAxwfIw8OJawp4FlkxAHK2Dbr4V1WHSjWkj9n0d3AJWGmyuubW6h8aCIAfxKzfrugb1xu4XFYlwDr9pFYKilPAmnPtyAE9bzHRf8Es64J8NtKVktGxanGJSarDdlZunf37wAovt599xN1Z05jyPk9UFWdrvlQU6gu2/iaCSlvxerwc9nVdnBnf85pdfOOYOEp456YWQ==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4289A44C2B0E91A613BCF1A0EE6D0@AM0PR04MB4289.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4289;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4289;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(346002)(366004)(376002)(39860400002)(39380400002)(396003)(189003)(199004)(377424004)(53936002)(2616005)(68736007)(956004)(6666003)(5660300001)(229853002)(4326008)(25786009)(6486002)(230700001)(478600001)(39060400002)(6246003)(97736004)(86362001)(476003)(81166006)(106356001)(8676002)(81156014)(105586002)(8936002)(50226002)(7736002)(3846002)(305945005)(118296001)(50466002)(2906002)(59450400001)(6116002)(47776003)(386003)(52116002)(11346002)(110136005)(446003)(316002)(66066001)(16526019)(486006)(6496006)(26005)(23676004)(44832011)(36756003)(76176011)(5820100001)(54906003)(99106002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4289;H:fsr-ub1664-115;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0Mjg5OzIzOnprOEFuaUx4aDlCaHYwU2ZubllkT1ovS2M0?=
 =?utf-8?B?b3JiL0prVDBZdGZZbkl1ZDFHakVlbGZrb2MxUVJxaVU5Ylh6TjhiK1JBa3p2?=
 =?utf-8?B?dm9memk3Qm9NQ0RQaDJDcEh3UjRBQzhPU1RhRjNINThkTXloVkp6TnRNL3Rh?=
 =?utf-8?B?VXhhUW1KQkpvQ3llMjZwMkpOc0pzSkR6TTlPSXo2VERRa0N4OXl0OFpIOFF2?=
 =?utf-8?B?MTZDSkZoRm9KbFNWTkY0bjl2cy9LeVJBclA1cVdXR2laOXN4T2hqZUZMUjBq?=
 =?utf-8?B?N3RPdGV4S1J4bG9mVEtqTFJINytqUjMwMnN3ZEJKeFdsaFp1c2JxRGxZeEVD?=
 =?utf-8?B?bjVyY2hyNVVpcDRPZFQ0VCtQOUxWWUpjM25qSHd4bFNITTZ0eHp5aUZqSUFo?=
 =?utf-8?B?czJaMDhZMFo4REJuKytXd3BER3BjVXk0UG5SMysxaGlHOWVsWXJNSjZWR2lr?=
 =?utf-8?B?UHZJMkdnZ0lIeFlQWFZUMlp2cFZwLzl3WWFqYzRQeW5MNSt5blNWYURtR2d4?=
 =?utf-8?B?aHBqcVFGdjNXMHF2emdOb3VESklhbTNCaXFBcVJzVHRjQmJhNzRnSDVWRnVn?=
 =?utf-8?B?UmNIeUdrNnBkMVFiMlV4ZE9BejF5RzRtN2NjbVBNSS9oTk40ZEdaUEYxWEZx?=
 =?utf-8?B?VnNpQkdjVFVMVFlpUW5rTDUzMUJ4TkNDc0hvWnBQT0NOUHpuT2pmNTE1VjRr?=
 =?utf-8?B?anJ3cGdmZktySU8vWEQvNXZldXd5d2Jkd05vZnVpK3NLZ0NPRDIvRWUzeHZh?=
 =?utf-8?B?ejlqQURPM2hJekxSNEt4S1FsN0wxWnJSVS9MN0pVUTNBZjdYR0hWbFk3SXJM?=
 =?utf-8?B?S0JhS2gwNkdCc3ptczY5MmwyenBaaFE4QUJENVNMSWgxNXR1K0dITk55RUZI?=
 =?utf-8?B?NGRrZDVMZTZmTXJrcTFsVm9DWnBmQ1ROei8wTENPUWsvSTNJNXVTQWk3RmdS?=
 =?utf-8?B?N2V2SVNYbTZqQjNFUVo1clRJUkY1WENUS1hud2RwaXJ3cFpGNEhuZlpvT3hM?=
 =?utf-8?B?UEc5TnRzMjZNc2xvS3YyYnZrUVJLWWJsbksxdHVSOFlDUXpQN3NCMUFsT3ds?=
 =?utf-8?B?VThTRzYrcUhtNFJFSlBpbjhJK2FuREVzTXE4akpBR2dJd2N1Y2FLeWtqaENC?=
 =?utf-8?B?Sm53RGFUd3hsUkFCdGNzZWJFRXFocmpDSWJJTEFnSnZxdGpkNEZTbDByQjlV?=
 =?utf-8?B?Qk4vaEhkc204cS9qVEoxaFFFWTZrRlpZZDNVN2RlQWFGc2tTWmdLOEZ5Tloy?=
 =?utf-8?B?QVpvY0xIOEV6b3NMMHRFY0FuUTBiR090QmNzQkhlQzVZNjNvWVBJMytQWXlz?=
 =?utf-8?B?Vkg0OUNLblBmdUR0QTZwSmplamZ1U2p1YVdxbGEvM0NXem1xckdEV05uaGpG?=
 =?utf-8?B?OENaNWFwQit1dXlWemtFWVJVYWxXWnk2bVZvazRhRnRSZ2pDYTdzTjhMbkdv?=
 =?utf-8?B?ZDZWbmNXMmorN3pUWVFyNUlkMUdFWWpvbzhtQUdjZUt0ZllIdnJwQkhpOUh5?=
 =?utf-8?B?SDVKNG1jWVVaM2F1RnFMb1dsZHJSNmJ0SVlHTWpuYlhEWU9wTVZJdDdtTzha?=
 =?utf-8?B?VENyemFnSlpJbzliWENxQ2hVakZjYXA1MVB1aFl3MG1ocW5WQkR0LyttMnd3?=
 =?utf-8?B?SHFNVFRPc3ZaalpiY1pJaGF5UlI2T2Jod1BKb1RONVdiN3FRQlBGK2ltaHJK?=
 =?utf-8?B?dlFneklJUnRQZFJZdU5qTGZaeFZkVG0vVE1zV2xWWVFnejB3dDYyVEZqczZH?=
 =?utf-8?B?Uk52VnhuRHVoM2pMTmljcEJ5RUx0Q3hJbmpldEpoVlpaZ0xnaXd0V014ODAr?=
 =?utf-8?B?UlNrUmFPSGxkNDFKNTVTMFFtQi9Xcy9jSTVRSUZPTXNZTm8yMTdWV0JGeUUr?=
 =?utf-8?B?V20zOE8rQ1lmUXRYaWVTYmp2Tld4aklHNlczTzl3c1orNGwrZzhGRHhXRzdQ?=
 =?utf-8?B?Vk5EYXBMMTZSRGd3TEpkSCtrNm1HS2s5c05FVk9BNnA4aU1vVHkrSDVDNHhq?=
 =?utf-8?Q?aNQdCp?=
X-Microsoft-Antispam-Message-Info: +zVlmKWXc1N0JKqpvIE+kDmdKJdiayWA1bqjoGkxSN0j801s8Xigu6EOWUpKV2VaoULoPVNtqWMllRL/l0+2VfvjBOYE2x10KdtF2AkMrhyyr3exUO7id/E+AoHWHDSHpHTZmvvWTkCcrCa6z/9q5+VIkZZQ4/fd+VfuUcs5VbpnQfzget9gW1Gw8oH3tBpn
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;6:viF5W2ObW4a9GLBeH9dgkZKFMErbUhUFWeE4fmdzNIp0Mm8+qZFtXqKB+PAw8cY7v6jqxkLyhG/6LCVG7Y9j4w79BSTsSY0r3hQARO61hkVq+u3Nh+lQUss8J7mahsmjzldKl09VIqtwmYGAcueZ3u66WEUzgEIRG7sEERSP8JO/jv7tEFMNrqku5v+MK665+b2maj55EnvNETFJjhIRHpPeVTKjKzAM/QqQ9aL/uQEUPqvtMHwMJ7T1+loFlLlvBaYogwDo/WAuF2tXMJ4RmjAPKH+GB93tYgrw2kgQ6h1VMqoie/D/zxdMyM/urgkClqAOdLawf2EM2D4dtOiAeyw/i0ns5/pSzw2rt+0+NIaMSjzrqz6BqC0sjYhJMJgLG4qsrprsDiNAGqFD626u5hNdU1PFUwidmm+ecuRweUuuaxez78WreZ9cdeEMdpAJpOvOA6hZdbo4Sn3hFqxbpw==;5:pCkD8EQKQN+noLv5a4eqwzgQxqaphr22rBJxB8UdG+JWCU4onruhztKeiK5qtSNHLMVrv5iFuCy2GcDdK9JfWrAB64SHUZelKLyMKHcONxQZ0v+J02iKYbRAgWvD3+46zDG/Pa0Hh5rOoG6CpDz2e4I2a08scdsZ9XmmnBPm1SI=;24:AR1WJn9qnfb5LUMjaq3PcZNjJKfC7MtiBDB0czdelF3wslj6OLSuALfs0nURqMqZQLj4emHaQ4oJWXl9EtQDWVGXFGwI2H5/UM3h3M8QIQA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;7:68zkAWrsJWpJqBgqRUYPXXfUmkzr0zsZ+CjWmKEjM05dRhuVa2uYDCEsw9ie6UQol7u9MKX7JZOUg9FM0mHZsvT20aOz7Efyd+FAItWrEZscUZHbJu4bOZ1OCqwJx4y2oCEzFUdYKgW+in2KWIWbrRH7qXjLrr8MuDC3S3qnYD+F9722a5v16e9dxVjfU4/xWvjyOPcBLCziKEQUnuxkK4NV9kNU9aZadZ3bNCWmvSWMd8MvBpfJnAuHia4JTY/q
X-MS-Office365-Filtering-Correlation-Id: 4a381b64-ed96-47ab-174d-08d5c56cd44a
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 14:02:34.5874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a381b64-ed96-47ab-174d-08d5c56cd44a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4289
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 16:02 +0800, Anson Huang wrote:
> Correct MIPI/PCIe/USB_HSIC's PGC offset based on
> design RTL, the value on Reference Manual are incorrect.
> 
> The correct offset should be as below: 
>  
> -#define PGC_MIPI			4
> -#define PGC_PCIE			5
> -#define PGC_USB_HSIC			8
> +#define PGC_MIPI			16
> +#define PGC_PCIE			17
> +#define PGC_USB_HSIC			20
>  #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
>  #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)

This gpcv2 driver is currently only used for PCI, it probably only
works because domains happen to be turned on by default?

On imx7d upstream platform suspend is not yet supported but even doing
device-level suspend causes a hang on resume somewhere in PCI on first
read. This patch fixes that immediate hang.

After suspend/resume lspci is broken (device doesn't properly resume),
that probably requires more imx pci patches and unrelated to pgc.

--
Regards,
Leonard
