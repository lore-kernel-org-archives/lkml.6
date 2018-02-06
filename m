Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeBFKQ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:16:57 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:35200
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752726AbeBFKQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:16:42 -0500
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Subject: Re: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate
 q_depth
To: Sagi Grimberg <sagi@grimberg.me>, <sbates@raithlin.com>,
        <keith.busch@intel.com>, <axboe@fb.com>, <hch@lst.de>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1517869943-3655-1-git-send-email-sbates@raithlin.com>
 <98265620-4f3e-4606-1000-070e717e0624@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <df908632-720c-7a73-a636-4acf53eccb88@mellanox.com>
Date: Tue, 6 Feb 2018 12:16:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <98265620-4f3e-4606-1000-070e717e0624@grimberg.me>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(31696002)(86362001)(53546011)(966005)(2906002)(478600001)(2201001)(106466001)(65826007)(1720100001)(6246003)(186003)(16526019)(67846002)(76176011)(77096007)(26005)(336011)(6116002)(3846002)(31686004)(6306002)(229853002)(356003)(7736002)(16576012)(58126008)(50466002)(2950100002)(36756003)(47776003)(305945005)(64126003)(8676002)(81156014)(65956001)(65806001)(83506002)(316002)(5660300001)(110136005)(8936002)(81166006)(230700001)(106002)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR05MB115;H:mtlcas13.mtl.com;FPR:;SPF:Pass;PTR:mail13.mellanox.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT011;1:97oTLNOz2Ey8tXF5RJtAzPSogX9z9pGJQkTy2NIVxqeAcG8scIfqq1yv/9F5/uF3vy/EWREuPAwpWi7wnjymKLXm/9B8gtGf8uGDUIlwhURCWE4HZ2DJ41wbgnOIfv2n
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8400ad93-d023-4c36-7b46-08d56d4ab57c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AMSPR05MB115;
X-Microsoft-Exchange-Diagnostics: 1;AMSPR05MB115;3:+F+G3lQZ4G/OZZUTVlTj0e+b4IpkGba9UCxQb0p1eBL7bR9c68sb3LL4CRHL/s3GyCp+fUHTp5ipidsg3SiT10gPpgKit1FbpIiDI413v8XrpBwTYEA99yKZQBat/4LzVlG+GMlCQrgkxG2PReFOg2uGVgPL56CS74FVCdyI1nxLP/wgU0mSS0TE26lAZpaeYrAT7bXu7SVBWjfJ0RQvYqNzvJrMDq/8+0GhZd1O06ThFOFLZ7tZ/oZksGmDJpGl+INFE6mYSy8JMofmDTlBBqIt6nOriCqhF7VCrS3a1F/hrP+OTqAJu3e79mldY6CQfd9ADcH/puwNEnSLEiV2meznbcHcubAdvE1sYm296Sg=;25:smXC79oZwCDTajhp6yLVWR3W8VdOsDsOVx3mFKcg6y0J2GKdPyVM+dW5UCnU6CZ/8TnxKyl0rftR1+8HqVa3fKQe1mtBZQRkyrO+apSjff8BKlj2cZlyRZ2oT+NENIYZa8eESLlrUzAFZS7cPvDkGiZjqMeXFK+3RuuRTdUVQbPUZm2X2kEumjd9t57dvSXlOV+bGLw7Ref5Hp6kACSa+tB6Gh7Wr2l8J7AJym9yI/Q8MfB8B++uPxht57sPN8MI5Jl4EalX5S6/gKeQUneUkRSF91vo1DZdNsZEXfVqMrY1BmAElfjtUhC5kY1FJ00Ja3Qd1MG/4Z3jjwjzRPsqLg==
X-MS-TrafficTypeDiagnostic: AMSPR05MB115:
X-Microsoft-Exchange-Diagnostics: 1;AMSPR05MB115;31:ApePLjZyRCzq/kpQwOsamMMyHQuUfdwfSMS3NMailAsjcJ0+TFjNI2rSK8nPz0F6xTaAUFzrtq/QxdP48GhHhBLHHtWkyYahrVtEjR1KbkoJFLv/s+4UIIb5iYIFlR2dJYOsCPESH7fWOxAaE26OzIclzVkmAmh0ovasODwXoYhF2XC02aSJplO6K/6ikB12GRvcH37k7kxme5YQO9nfaWWmW71N5eP+94DSCy/7iso=;20:CFieSQFOxJf7Hhwlau1ZX0pfvh5HDXlCi3KTlGD42UpwHXbXbyaO/BHW+VXp4sPyxzDsO5gfOuTXFi6ALdRer9t1xRSRwdXayMQ6QBSubajJmO7YBV29w6/7M+5JBD9EAx62Rv0Y6BXbwMysd2tJOXfPchtjh1jxmYN0db0zauNaIF8PKfLyOrff+qbKCmIrcO8OZkVeHMb5cXO4j9Bumfrprdh1GIZ6bdEJSwbJjLQXtVONXNRGSJdq3BLEHovNAWkyuqsPucAfgUivoW+6XN/5CNmrOHSiEpXgG1RTE7+f4eZUtuHtVXbsomQs8IDkcxGpJPYgXNcnRTFO+mB0Zb//gIoD4oucfTBNBlklE9j9eQRUsrCU2KmC6hDHztjbC0Q3/zL+6tchY+sebQ2fP5n0RwuJPqo9BxfSllESw1E8fyAqweL4UUcsww7w9cLRutjnWU1dVH3ne1QqfSn9DhTVkLhsvSB/Xi5aXqQzg/ak1Cmtf3goZXfbYrQ/PhTj
X-Microsoft-Antispam-PRVS: <AMSPR05MB1152844F05D98BFD12250BBB6FD0@AMSPR05MB115.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AMSPR05MB115;BCL:0;PCL:0;RULEID:;SRVR:AMSPR05MB115;
X-Microsoft-Exchange-Diagnostics: 1;AMSPR05MB115;4:cmyI+iubZdvNojd1GcRvdsxn6WFV2d8EyUuzdiJr1UDDJTBYJMJTLbrs8ScpRKapdbTHnjvgxIASnaIcQemf6Sy5x+Z3BmFLwvzGLB3P5btoMzeJjM1SrcocL686u9pN+P6y4105hu2OlPBbxj63Qz/HHv1o/5awlHuuKofTAo4GDJ0+TElkPkmIW+jTyb3Tx5L0rQ8ZWGzeILTGK1ocM87bsinPbD88KE8OvWmMzzvF10uZq/ykXPHQyjaZ2DTalvkKPNbDi487qxyqjOOp6QLAcpCcDUDfdNFZuYgqmXXPOOXc6KP+0TSzs5pN9y0a
X-Forefront-PRVS: 0575F81B58
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;AMSPR05MB115;23:N7j7MaHQn+AV1l/8Gq3apCgH/+W3CoS3n78fH+?=
 =?windows-1255?Q?6+lW25E1MXVLSZGINur27OZGHM98quzQMi8jQ0oHkstCZ8DLYSTrXQ1P?=
 =?windows-1255?Q?w0Uwf6K+YBomBnCMmWca9H1pxrBYGB+Sm69dq52XpDybPqRolkUg6bJe?=
 =?windows-1255?Q?jlYbA9xBZek6lNN+HfFJ2d5LPVAtBcOexDZxDgJiiK+xkzAlEQLqCSMd?=
 =?windows-1255?Q?oNvqXgz5Jzzo3Lqqy3BpywAc5PhJO6qNqMTIV4ode7u9rvltHIWA5Wnk?=
 =?windows-1255?Q?ff9w0fPbIC6Du3gaKNwhWVGO2oAVKaiR3OtNEQjRjHE2arhb0LJNpaxj?=
 =?windows-1255?Q?y741lr/ByrcRZ7TKoHAeG9mzzuWzyvKdu0MtkXlCGDndeFokqMXr5U5Q?=
 =?windows-1255?Q?+cmR1eRY9UwGBylBJOq5kjRRNGQXnvXU/4mUnADKWerk3NbhOWFbJJlr?=
 =?windows-1255?Q?mEbH9iGXb1Y9EgHFu+m35a+ELwJffBhmVQfHQZ7YJCTDqJgKIfNabSh8?=
 =?windows-1255?Q?P0Y22FdQ/zXRyE1M6MXLAL2Uf+EtvJ288dC44XdXRZqxr/q8ItgBrAwc?=
 =?windows-1255?Q?nCp+GNuGgnpZBjrHrDFQx4aJlp4vOgYm95+0uDHpt47O9CuRN4fL4au8?=
 =?windows-1255?Q?dnZBVvI5Im9KQKfo7xx/5fBce5e3XnXqGIVuasJGCinoXrAbQ8zNiNHo?=
 =?windows-1255?Q?bElTCUlZnp+Or044nmXhUqiGLPptfDWJ7wNEhnCwTXoIYxJ2Oqc/qU/o?=
 =?windows-1255?Q?DRBEJK2Xq9UFTRmzUylkyb59JahzLVwQLFjrdNeuI2C8HDCUl+BC95OG?=
 =?windows-1255?Q?f9sTnSdYlPu5lllPelkMOWibqZWe1UZBtjzC8+Tf62f2QjwZIDHf4TDR?=
 =?windows-1255?Q?cO/e9wjaakfJw8XCNsMs1ciSsJ5wBiygqKit6nN1T3uQaT+lBX3eBk/I?=
 =?windows-1255?Q?GESa1e4dkiGyupjs/4Ocn1tubMHhf7Oh7uky+aYjvs34sf1iKJ9ePw5p?=
 =?windows-1255?Q?mGpI4nyDJvCtB1Mvi9j/kRXEdbuSLMVwHa7ThsIcMGmxn9CspR+NDUde?=
 =?windows-1255?Q?E0I9+pH3Tszs7Fin++chvg+nlwIlJzx/8O3YBwN49ScbC/s8Vz/FMZDq?=
 =?windows-1255?Q?ss6+M02bX9ISfsl2D8zQ56VTB5PrL9U4EvFd7gg6qaVrEOQ0e/x0VIZk?=
 =?windows-1255?Q?0gUkDDDpyv1xCdECcEIwX6KLSEypHpu2GnVkZTcIE9FbSrRAQDXPM7fL?=
 =?windows-1255?Q?nvGJ81QH60NN+mIOGigYTnPG8UL86giDpkkMDJeUPfgYssTZm3ojPqlb?=
 =?windows-1255?Q?ilSxfHWw3b6eKqQfytqelsTN07SsjpZ0RRWG3TNSVUgdWF9il+hRJRmU?=
 =?windows-1255?Q?XmlBFLSYtF?=
X-Microsoft-Exchange-Diagnostics: 1;AMSPR05MB115;6:SlGj/O3jAkcxMJ8RMCPtBiaxybopMmHfpX8O6Td3ZlNdI6HJrBOUMw7PzMLTARWIYuWcOo4tD00k0DLXBEsU8WDamhdmA/JCYjWa5uPyRbZ7GD59OrJCOVHu2iLExhNuvmP7D+b13DftFgb4k0Fycfu6jfdK4O97KgLVIWj1v+l3K4DtwBmp7zGPqjNLGc0MS1Vw5IxbjKmUcrHPTo63esVa6kh7AgmUo/TOTda2pxbidPZR7CAOct+GxXUM/jtN5Y+yqO0sByt347ByKQIXWeeUx3FODvIlaz17CrVgZmuUkvfGkCwOQPPGyGIrLsMXCvas0sd5ao3uZyUoOLtwojW/ilKUjp5Is+I9rbc4zN8=;5:Zc4y0ZWejl44woiG43RFh+lPhkZVGe6HBdHfZWILKx5xxOJH/ongfMuuQZIPTVPfiLZyKAiLoVv699eGpW/Nj4Hos4X0iNpuG4jTwDIo42pVBEB2Wxp2ohRQvww0FFHc70CgWjJ+En6tgqjqwO3jDEiiqLWTL2c1rwCinmKN1L8=;24:NY6X1/czjGPUsuBJ0AoqFj5FJsFalSvxyKE9Wem2xX5SMU7F4Nnj3k9vXvuLD3Bwc3j4qLLkHr9KnL80RymqFX1xgAKfKlY/SFh6/s9FZkY=;7:u+KYdhkY8nYI5F0qK1RZ4wJafurzotIH2Bwhbg+JdoGsZOrVG5oGZuaFJARLzJJKNCASW/ALmXhUYabNLDP0JH8Q8+wjDvIZC6RPzccFdtkNfXFOtyHBldZxrTlgA/8tc0nVD1WuSPzRmawguA2atPnHHcOnHIM5hp9GKemViAIZI7JgqcXhC3Sn6vdJyiBtAjycdsez7SJz38MWwgFMkZB26ZKNO8VsKBQrt+HbbGPVaw5NZ2NWz1bGtzOsVRLM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 10:16:37.9509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8400ad93-d023-4c36-7b46-08d56d4ab57c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR05MB115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2018 11:48 AM, Sagi Grimberg wrote:
> Looks good,
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> I'll pick this one up unless someone thinks I shouldn't..

Looks good to me (I can imagine what scenario failed this :) ),

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
