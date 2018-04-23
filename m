Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeDWGFV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:05:21 -0400
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:1281
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751414AbeDWGFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:05:10 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; the-dreams.de; dkim=none (message not signed)
 header.d=none;the-dreams.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
To: Wolfram Sang <wsa@the-dreams.de>,
        Michal Simek <michal.simek@xilinx.com>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hoan Tran <hotran@apm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, <linux-gpio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <34f4679f-d306-073b-eae0-28c9e8965780@xilinx.com>
 <20180421162333.d4jtidmbxrx76k4x@ninjato>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <19e48035-917c-7bb0-eef3-a7d6db4c1db2@xilinx.com>
Date: Mon, 23 Apr 2018 08:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180421162333.d4jtidmbxrx76k4x@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(346002)(39860400002)(2980300002)(438002)(51914003)(199004)(189003)(9170700003)(31696002)(86362001)(36756003)(2906002)(65806001)(356003)(65956001)(478600001)(54906003)(4326008)(316002)(110136005)(58126008)(106002)(336012)(39060400002)(81166006)(44832011)(47776003)(2616005)(476003)(6666003)(426003)(126002)(8676002)(11346002)(6246003)(486006)(446003)(229853002)(8936002)(186003)(26005)(93886005)(7416002)(63266004)(31686004)(50466002)(59450400001)(230700001)(64126003)(77096007)(65826007)(23746002)(5660300001)(76176011)(305945005)(106466001)(9786002)(36386004)(53546011)(142923001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2037;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;A:1;MX:1;PTR:unknown-60-83.xilinx.com;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT011;1:c0uU4kVqsFoUknPT1m1d1rkVN5yJz5nfv2PmUenuDsAhRXB2Jg4op8v/HEqXGN2QfUyvkCtQF3mHYIcQ2ZKouJcYqE8hDdoqCcrC26UYczFkxivday5UJ0JxPqMft0TM
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR02MB2037;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;3:mPMpB1YzKwPfJsd+tp/PKIlFzCo5ELOd7nOafwD8boq3pFBs2OUySWGFL5GR1T8Hcjhgo7c+/HZfZRvfQwnomQB/uf+zJ52jh4uWmdjGsBrzTOiR1kaYDhBZ8iyhaqMY9LO5ZGzuPruZGQt6OABri2JZfP6oW8hamUYQSh7iPSpNHJzhF7g+e87BihkVtFxkYYUZZD0rFemJWcSXqvL1owBs1aS5NqsI9BxrCjTS4B76y9k0wm9YVFOqY4jn9Angec6+jHyYXP2A/SFWaEoe/oByvnwbNENi9qXhuyVtjSa1Br6FMFb1q0yNbrxXywEx/kQ/HOS/AXHCAGFY95Mt2zZ/dityPrKkQsAzy0xMRr8=;25:/um7hYe/OrJqzgO5CkwTHGcO49QwAR6T48AsPwlULVtGP3ylW83gLAsgl2XHVYCf8kW9P8xJuZ1V1ZTq9txMwEvSWv/F2BTu2jyl543ebV1HJn369U3/eYXIBQPJyoLGHfgC3k+9KAwrChxlYp+ccWGRVa6Mb058/LF2qGHNLhjpEKHv4Ta5v8mz/b5Bkaiph0GEn6qlxfB1SsIvghAID1m1Ya3vvozWPQAxeEbNWp2g6lBoRRcz69QJCWkjm3f8mMnGlLoiUWoERdBEz+AAS98SdV4Kf5YveMFhCF1mX1rHQe2MAVPTM8erk+UekWZA0PUP3ZYIlbS95emeVsVvrg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2037:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;31:iPY71NIcfE/5WRnTAy/DjSQfDhPJO0chU/1KKzofAIWjUSNbi2UWWlwVA6JSkc/UAQ+pPgXRtXD8zOA4ZZ3pZfkR3Se6jPiOnzlavcz3qK14njNBaaiHcE0y9fViPa3/V+Wu4gfuu4Q1jaGKJGt7r9v8uJhKkyEpbqwUxhmcp0+Fi+hbQVLww5+1kHyiaYq21pGKqFNlnfB7AJCyPh+c9q35/Oy0Y3V1xmJKQe018ys=;20:TwPsld2UebPeqN5N2s+fDhMv7FuS91kXtF35AWUf/2HlFBV4Fbke/230txNNrq/QBRFwwyFJWKWnlotQv9kDQCq1VvJvyRAjKuVwEluY4aahOSqOpBIorTor9SWTaASXD5w36KzHUSEZQrrnKfvi5MhZhN7b2QAZsPWX1cXudhd+bPBw0z50KTPYnAbbQiKpHG3l18mR48wgSMAo40K5tbS9db8EaFMGSLXZv6vD7XMVvG53Z3FvCZ/pV7h+0Mj5obPxvLp29W8Cc0RgqPuFS3VI8adGcG8qlQkbtnFQkKxV2Jrt0gB0RigR5Yj/fuM11/sOIesQna8Yv4N4KvioQKH3JEoA9CG8hzrifyYDLMa9kxTwzMZVEp18t364Zd2Ob+Hd6djQhBpnHCP77X5aPQI0UuKliiPnTVHwZZoIu+/J83PlPps4Wi6Wo8o6giIM6sFO/GRM13gAy6OiRUhZgph4MiyiQEIK6S+WAdoMMYRyVh80uBzfHdkPVJWB7oXu
X-Microsoft-Antispam-PRVS: <BY2PR02MB2037C435E83572341A6EE653E2890@BY2PR02MB2037.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR02MB2037;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2037;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;4:vSiS+X+qQPoLWw2JPQw//5d1JxiBp4kMav30tyqxc/yVVzSW6F3uTCxxLnh3DUASzgtlK+KVtcaCXpI8aGiDKv+ecDfYORwc0wG40MRshD7tR27e7hma2WaQSnZDIQYvTmxXJ45rtfohvubg4vxlRNVd/EwNCJLaJ9/mU0StFuLpF2VH7U61Pid+cJMImZyRKkblPs7bwhSyNC28KLTatvvRdNZpLQO5sy6uE3Z5NM0VZFxwlt2fQCttCeP1pv/PfkJDRgJTPEJDVYEg3fC5ig==
X-Forefront-PRVS: 06515DA04B
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY2PR02MB2037;23:EMSC6YauR754IFCo9oN7yIb6BdgQhe/wQIIUT?=
 =?Windows-1252?Q?q2tP7x9O7RNslvuhaiEP/WAOVYbgAIuE/o7pQRV2tdQQ1iFPw393QGdG?=
 =?Windows-1252?Q?TMExO+N94A9D7zrYhuOxnYCkSmTjcM741IiS5VAlCK9P03FS3YJ4tnRK?=
 =?Windows-1252?Q?nXUbX5McUcv4wkx9n5KaosfVWlFU1oelxbmFhnH5lFPGRhxG0LC0T2RR?=
 =?Windows-1252?Q?9s1VytwcN3I+hZNO0uh/Bozpc48lMICzVDGOIRRgGr5/B38/mKGpU/Ny?=
 =?Windows-1252?Q?02tptejVqXzoCFi/pZ055ZimQVF9lrr7hNMn6n67spiSdHc2qTEwQfYE?=
 =?Windows-1252?Q?mzUPNova1h4G7FBu8Y6CEmqXuy7CKZYsxA7xFSPf/dyeI8nqFpDVi3Gr?=
 =?Windows-1252?Q?8TzRIEsusY0Hyl2ygrrBy/PSIMJirRZKYKmBieAIeMHGOu/y5GH8a5uX?=
 =?Windows-1252?Q?pgkNrRJfH45xUXLAPUrAXTc3JX6yOyrJTBiaiO1SuFQepqgST5XNiY2z?=
 =?Windows-1252?Q?IcqlFJHwz/iYrjcJuTV2ttkDOtO6pPPyUIUkfKUTouNMHgVzQNUJp8Al?=
 =?Windows-1252?Q?p7HVTomhtd+EcTivWQ8dhvpYTCroXrYcinlE5wMANfBFPZNS6f6B4hDf?=
 =?Windows-1252?Q?/fMExayuN2kGWOANu04re6G2eWmadbQ2YWTiaydILn0ijOlAkcSk2kB1?=
 =?Windows-1252?Q?IPuwWIj5ia71YKAK8s28kEBj4mh+f3EJklBMDCtrS0ln4+MSt6iFh2FF?=
 =?Windows-1252?Q?j4MsE6hc2yVT0Nfd0cyAT9Lce0jPTctkQmn2xqrU6+ckMK1jYG+GJdGG?=
 =?Windows-1252?Q?6dv5AZaNjtJ1jUgZpQo7VL4oFUYXdzr/KWctPFGFwZZlMd+O/gV9tMHN?=
 =?Windows-1252?Q?0nRmx4IH6etbriv04/knN1Oue+ZjEJ5BD4c2wc5I27wFssisIOHGuKQn?=
 =?Windows-1252?Q?gOcWkhwWNf7AL0sb81IQ9Jl84DuVhcZv+JigI3AZv83Poars16LVCBNN?=
 =?Windows-1252?Q?2ulPWt1OVNk90bCw4x1U+Dect+S4PJ796tiukcsDE6h0ouzZVu5x88BL?=
 =?Windows-1252?Q?g/XzsS+NuvtG4Y4oUxoM2ILcDwtj9QZSkKKvdB9sOh805V4lGlWm3RUL?=
 =?Windows-1252?Q?2t7ajysrhRk83MkgaZZHtDnA4o84P+8cTO3okbVO/Q39jvfaMoffvi7Z?=
 =?Windows-1252?Q?ySJk9ke5e4gl4msuRrWJql8LOfFl6OK7953wFKx8wIjuoui8BUFS0yug?=
 =?Windows-1252?Q?el5/j5N4YPU072bnrQly5lLTdNExWTOC638ykJXU7WBelegRm/4Sv35y?=
 =?Windows-1252?Q?Tvq0kqUnRqk3ZuS5dRprFBpGYrjM1+GCXDiksMLdip8ucw6V5gAVEPZo?=
 =?Windows-1252?Q?LyDq+AP3GYfrxbIa553zcWuz9UJTD8YIKkyTnn0JcT3L70C+c0uKHL7Z?=
 =?Windows-1252?Q?ZO53FOusRrcMGRF96587IiHF9lZBvOhJH4PkPq0N/boQErqDIKICRgbc?=
 =?Windows-1252?Q?3bWdBFQlMIr8zvzOPpkA7J81C2uez0oA2fAI47r2YOYHiZWedwuGMTZx?=
 =?Windows-1252?Q?/cRSQ5dTec6pQE=3D?=
X-Microsoft-Antispam-Message-Info: jfSmiSYgHyuxvVfPSJck/x11Lgo3sVg/Q9wVRblq6CNAKN8KqP9bF9uReLBegtpqQRDNZPR06I8SB63r/pZDOv4X6mNvKwSWCsCCV5LXulX4mntFmuOGCIFNAbSaPYft0fzhh/W+UiI+ZVOyK9HEQ9fY+2cjzauTTBLPBpuwm4wCzqc3OLHpHvBmbjjViAz7
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;6:FkPRsF+NKkb9GDbEk+084DWvd8PqXKh4H5QxxsMoY6Lm8y6oH+9+MsnARLqRnTvQTutNAvBtsgsclEAIVoViJZS7g/FW5QMYD0rUPWAeU+5+ebLnhBOR0JsKJxkfxO3ktFYmk9tCsdj5+3AsP+fY3dV4NijBC4qdhIpe6/jdhBAeWh12nm0CtATdj3IewrTD2I9GuosMt59cGGkaQn75lD0M+ehlW1vYQHop67IXPmysQAt7M1lVUYxf4OcNmrcd/W4QeGpQEFZUeSr9uKdNY9aChBivO+0jN5lJv3y8jvpangq5QXDj2RqNyWA+83uZQDVZ0JcGx5dZCHHhhjs4O6ogGRQ57NRPQUNa2kG4rsspM7g7VRQHmcLMgQfhZHQS4l4/58puyHlZ2rWHO9w+ATxsfiKe9JOXlla4yRxPWRLNuUBGfNdNmlpdpJY3sZWQcGQxru9Vm/D3WZmyjMcthg==;5:RwWyzSvJvb8zOthb1pr1GaEWFFfwe95TtgEyLHbd5sAh++tt2DKVmm2n+kza73bDDyTn4VVayjUgmMbDXL3ezxMUmkwx+eMnC0kRqbNVtwg2HwFs+i1Tn7mhYJE+Vup8sWnSOQ/o1nXyhxDTZt4vtbMj/Ctqo30peEpvwq2bLHE=;24:ilT12M5U1jnvZ6fLtRwiii+qa/N8qIJ3sxKwA07Ks5fUM0Ep+KMn5vCk5e6vnTwCsvYeNZafAYBteqyUCcydA9PUH0xW95COQqAw511RXRw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2037;7:ZYK83SURX5jLQeu8NghR0h6fNtyDDHBsE0BtlonINLY5T1T/cN6KnEedEOvtdub8OJ+yWxvjEhjK6kFTjtpalKA7jdypfw8BohLdxwDgg24JudR/tM1DYa2tiPgCXXYrwG0WCKfkdwClqmeFE5Mg1TQWnrLhbmC2edguLD/nduK6u6CIjfLI9lVmBjIizZ0r/Bpw61UH9YTYYkQg4T+uns0naG+9aUF06sLhVYXgCcjigj4rMsCAOaJ4b3VJOo4W
X-MS-Office365-Filtering-Correlation-Id: ffcc908a-2a75-40e6-700c-08d5a8e02924
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 06:05:04.9968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcc908a-2a75-40e6-700c-08d5a8e02924
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 21.4.2018 18:23, Wolfram Sang wrote:
> Hi Michal,
> 
> Thanks for the reviews!
> 
>> There are two more occurences in this gpio-zynq driver.
>> zynq_gpio_resume, zynq_gpio_suspend. It wasn't detected because these
>> two lines are not together. But the same change can be applied for them too.
> 
> Not really. The rule would have matched if there was just "something"
> inbetween. It did not match because the "something" involves the
> variable 'pdev', so we can't remove it. And just changing towards
> 'dev_get_drvdata' and keeping 'pdev' was not worth the hazzle in my
> book. Especially since I think the code should probably get refactored.
> Calling platform_get_irq() in suspend/resume paths in order to get the
> irq_data looks a little expensive to me, but I haven't tested it.
> 

ok. Thanks. I have overlooked that.

Thanks,
Michal
