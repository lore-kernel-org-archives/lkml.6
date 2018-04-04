Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeDDFd4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:33:56 -0400
Received: from mail-db5eur01on0079.outbound.protection.outlook.com ([104.47.2.79]:52937
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750778AbeDDFdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:33:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
To: LKML <linux-kernel@vger.kernel.org>, rf@opensource.cirrus.com
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: [REGRESSION][BISECTED] i.MX6 pinctrl hogs stopped working
Message-ID: <8b07e30a-7dd1-7923-dc50-b84f0e43e9e9@nextfour.com>
Date: Wed, 4 Apr 2018 08:33:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::20)
 To VI1PR07MB3344.eurprd07.prod.outlook.com (2603:10a6:802:23::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd9f8797-c41f-479d-9e14-08d599eda649
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR07MB3344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;3:H5ARhag3mL5vkcDP8DwMfwTNcZhA+v+XRoHOcYT4Pw0Gyp86nBKIfvZrLZ1vVJjxFqH5SV1TR5fLWdFdUQTNBNTT2Q33Ncpy5VlOiY42+o2qyrSB+7dJgq+dAF5cZrNyym2Llun9oYaGA523kN27r2u1E8n7FLGop+qREBctooWamy5lZ/N0zsfYEA5r+7ImDUhaVZvdjXknYr7ktRKScTh7aI7bgNM8rMT+6yu2gpy/q0diw7mp2Trl4PryTCpH;25:N25eOgeLV7quW8gGxlFEaoXptuZP5KvCDENuDv33ml2IG2HRkmqTq2FwkaCaFrgXMvcnDrcPBp/djMBlu2ggfkk64EA4SrOjDoMMhTicU7itjC5XiLfWsxawAS0YaiWhOG29YindS25gqmSh+N2KeK9cRJUM0j1ExKFetqhbdHti4y4ZLOb/0hmLePdNw5uTODaiwBeOMBAFYqPIt1wxipAwkmIMAgG0u7e1pIbd0Wz2kCWhg9f2FfQruhk1F2YXXG5iutZrK5XEHjEh6lMmekZHidMlwMGcYQM2VXs0Jj1e/qbcDvAgwU8erN/a74pytJ6pFzWur/3gSbXNTdI5zg==;31:OVWq0Bn1gnWx/8GEsBNJci89lwjm51fwr5R3fyIYrsDh5dXA8K0HqisuTK2ZLo/Ss9F6Fnw5d8vNs51TQQYDmd/QeaFmKVaMZ/Muszga3rmB03q9txXZ1hWTwbbUVpQHgE8epVkmDIOI/RZzGVyRX/EtJtqsdDewILv9xtVTo33gH9YJjW7Q1CIQkihybsSCXwsNnQHrFmgHtUj46t8qdoUB15Lh6jEJOhbnobzYLTw=
X-MS-TrafficTypeDiagnostic: VI1PR07MB3344:
X-Microsoft-Antispam-PRVS: <VI1PR07MB3344FD3D1EB827A843C5B72D83A40@VI1PR07MB3344.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR07MB3344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;4:aZ0EbZP8Iw8XlmuIAZCkUsrCHFulGXiV8Xg4CPrjFQlnTcAm3A4TJjFRy7csPkZx7mYrUw7FNcKBQScAxHbqrKIRU5MjczVdNa8OgssVoZLEPmcaxZ8ix8t8zvy9yv924HcZmfFEaPMxrutMBuRrUWtkzp3pqzlImOJuSUEtmmfQAWH19o11ridfERG1Dz52ADaBmwLgFAyJh1Tgrt+qFvxV+t/B5e9Gao2wuvfrRo1hh0TkOAizsmPhtF1FI2JZvfWbPS1T4EbdsCZK1tt5eA==
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39840400004)(396003)(346002)(366004)(376002)(199004)(189003)(478600001)(16576012)(316002)(65826007)(476003)(86362001)(58126008)(97736004)(558084003)(36756003)(2616005)(956004)(3846002)(6116002)(386003)(68736007)(486006)(2906002)(6486002)(5660300001)(230700001)(305945005)(47776003)(81166006)(65806001)(64126003)(81156014)(31696002)(186003)(16526019)(52116002)(52146003)(2486003)(8676002)(105586002)(31686004)(53936002)(23676004)(6666003)(25786009)(1857600001)(66066001)(77096007)(8936002)(65956001)(106356001)(26005)(7736002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR07MB3344;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIzMzQ0OzIzOkgxUkZ5UGlzUGtIMSt5V3VkMDd4ZUlnSnN6?=
 =?utf-8?B?amgvQWVLbk5GTWh2NkZDSktkYm14ZUJBaUhUMkVoMFFiVHNyK0xjWmVlV05r?=
 =?utf-8?B?eVNnTVFTK0h6eGNDRVpnVVFQYVBSSEpndlVXRzdiVjVjWHZOUkhIZ2phdkN2?=
 =?utf-8?B?enkvb09TU3hxbkNoNExsb21EcEZhQVRUSlhFdEZUcDdtT0xFVktQRE9uRk9F?=
 =?utf-8?B?aEl6Q3BmcllyK2JpbDFZVnI1bHdJbFVNYW1OSmNQNUQ2NWpDV0JRSFVWT0tp?=
 =?utf-8?B?WTYyMzQvT29MaGFrY2VzeEF4c0tNV0dCR0k2YUQ5RGpWcGxuZDBrUWhpcllO?=
 =?utf-8?B?bVl2ZVNiU1hWVnRRQXRzUmhQVXpvcnNRS25NandTR1hJMXc3SGUya0lnRlpQ?=
 =?utf-8?B?VDVBemFnRmJnWmlsZ2pmbmJnL3VZNGlwU1oxZzI5WGt3Y0gxYU95VzA3dW1E?=
 =?utf-8?B?bGZsbWQwU3k5UUVhMHdET1A3ajN6U0pvY05tMEVEVnpHQUxDVDZLQzFyMXpS?=
 =?utf-8?B?OWRreVl1UmtBdHVSYTVkajg2c0FQSDVQeTFETnlQZVhiUnhYc0JRU0hRWldk?=
 =?utf-8?B?YWIwUnl0VHlvMW5GckV1WjVsN3BvM2JjMjYzcmU2emM4dy9ETTF6akllYnZW?=
 =?utf-8?B?bE16ZnIrWUpMRThweVBkdHdBWlFZOXBsMzhRUWFPSWFWYWxtd1g4NEFwY296?=
 =?utf-8?B?aEhmdTRkdTFTbmpBQVI0T0pNejBJTEt4bUF5OC9jU0M1SWlPZmg1V0pRKzh2?=
 =?utf-8?B?bE5FSFVpRkFhaGZCa0R4bVNTcGVrVERBOFAzWHRJNWZLNDR4Rmc3OG1tbENy?=
 =?utf-8?B?eGtxeTFJWTlqZ1BJU3JZMzdUZ1ZsdURYYVRNQnNUWTQzZTBZMGtvWXAvQjFF?=
 =?utf-8?B?RWkwTzYwa2Y5QWU4ejdnckpRTlNTWHdhV2pockRBY0pSR0xqY2ViS1FXYkVB?=
 =?utf-8?B?a0UxRzgxMnNOZ0hRWUt5YWFVWjJ6MmRWZVQ1WDZPRGE2NEJiODl4UDZvelYz?=
 =?utf-8?B?U0tZSUxMYjdGZDBEcmZlZDIrNmtiT21wbnp5WGZzKzE3Y2pNV0lVTnBjU1RK?=
 =?utf-8?B?clZRRTNqVnViY0MzSW5rUDVDQTFicWFOUGN0dFJGcjdJR3R3Q2gyamtLaFg4?=
 =?utf-8?B?azVmVU1MdUduQUtCWXVtVXRvSW1IRnJ1MWxLVis0SlR2RWRWTUNPTmIrOERM?=
 =?utf-8?B?OTBKc2VpWGtXSGxPdHJHTkJXN3NlSTBwZlZoVWg3SzlJbDFCcTkvS0pRVytJ?=
 =?utf-8?B?dVhKL29ZeHYyd1dUVm5BdFVteDhnSnJOUDZNSmFaNkJwL3VMYzFpUEVXM2Ni?=
 =?utf-8?B?ekVnTURYbkJmcmtxbDFmZkxaZk15Tk1lNDlaWlZtcnNZRUttV2lzWUpxTlJE?=
 =?utf-8?B?eVRySEFRVlRPT05tQmFVZy9PeW9tOWRXUVNBTGJHdEZXSHBUVEhEbTQ5c2lq?=
 =?utf-8?B?a2hJUHFQTm1rMzRwMDEyZ3lUdnRHRk9IQWNLS1RkYnlyWVhScHNQSHBiR0J3?=
 =?utf-8?B?TkZ6MVJuUFcyNUI3RFU0YTZrS1MxT0ptM1BsMTQ3bXZSV3NrMlhyVlVRK2dE?=
 =?utf-8?B?d0I1S0xCSktGVmdVaDNRSXV0MWovUTJ6ODdSQUVZTXJ0ZVVkUTl0VlBob1Ey?=
 =?utf-8?B?V3F1Ujl3YVNmanl3aWtLOFRvcThWZlU4c2praXRmMFFtdThZbkVtOXk1bDE4?=
 =?utf-8?B?N1lLcGV5YUZ3aDBiOEkrQktJakxocVBzSmtLcG9DTnczcTBpZkYwMGJBZ25T?=
 =?utf-8?Q?Bu3HvTDIMpsVSnwUtt8QA1iUMRDoxMHl3y5F0=3D?=
X-Microsoft-Antispam-Message-Info: vH7y54EJe2LfXGKQXKSYyavbNebHSZlPAABh8cvBWs81yLey7Jh698kD0BxgY0GNpdKZi+QVKmbD7f1P2px7kRRQcQN7ioMzHtLJz0zJnL/2TpxRgE026JRTG1P+DLTkBGlbxknQpEuiEOhIo9ak27U9LoS6tPGCR1PaTlTzPBICY81urCsVN9N1KNoLFCJo
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;6:3KU8h2GUPuDd3/CuFjmqYYd9bIfGvGJ+VV6OYr3Yh7+Po+HMGgNpbCmwlONZJMAtG26M0JmJ7kJgi3Ea1XMJgzku8AIk5E4dhQKyQIhLWGNSlIQZHDYF5dVMfhkYoF+mqKWhehFjXYXyPytp6vsBVGhjV/YAIBCWsIgAORL5kXfUMYSCz29MaF5tfEx/P/Pu8/GvgAmcD7RZq9cKzhLPqQw6ICs8rZXHM/NMV4X0LbZWyFx5vajHZMeADmVVSAHH1nFQESuL1jYsfbfgqkEsq/FYeW2rFm1dkwMraCTPVbLELReM0Ts/bkOSKWXnIp8jG402a7+AXiZedgI2DSvExRTr3cHur3/JK8cF4i2EzhU3im7h5EyV/Hbw3b2D7mXVDbGgL7c/zIfDESN2UoQSajVGup3qKSQrlkPoR6SY0twF/7fZlKBr1L3dLX0c3UMiUuO7X0FlZhmqw67rRdGz2g==;5:B9LL2BoUWGVKecqV/wZ/nk5zf2HEEOzODEn2TGeePLjo9PE3YoFOWZndnZpZC7u1cyDY2rPA3cfAO4Lqj7Yn0+udozpMpaZC+QOfjZ5dv1V7lZvCSCMyeC6MBAiYYuI+bVBswaHW8a86kv5BIdLeJg8IOw9mN01Zjhp7w7FM42E=;24:ocvKCsZRHH2suMrSSMXM+HLE/ILs/52Pz5yMu9kRjUoUMuYHVN0qXskZUSb3k1Xe+CNnbSQwtJvTVuQsDbgnQKZwQ+gl7l0QY37rHeqZtKU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;7:FDGnNb0Df0ZaCHDkTJ2SRAdLguydTWt1JixTQYYhc71srjXRJDF7f9hBFiBQvAyN76lRxUz0S2tcfFv5cEXngIGsHG9jN/3NKPm60u+BsEatx1KDSLGcGvrFOa/nqhsaeqRh6BFv2++SWg00dSleQ308/+KWdtUV7Of4FcLf3dpyaBLqn0zaPSflK2OKTDxEqrW5c1+wkR5xbN6FhRuV+EsGgsMwyrp9J44yRX58cqxIzHmrg5/lCOJX1hnAAy4c
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 05:33:51.6933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9f8797-c41f-479d-9e14-08d599eda649
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3344
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Reverting this made the hogs on a i.MX6 board work again. : 


commit b89405b6102fcc3746f43697b826028caa94c823
Author: Richard Fitzgerald <rf@opensource.cirrus.com>
Date:   Wed Feb 28 15:53:06 2018 +0000

    pinctrl: devicetree: Fix dt_to_map_one_config handling of hogs



--Mika
