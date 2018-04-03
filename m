Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755210AbeDCIh4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:37:56 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com ([40.107.4.94]:28608
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755117AbeDCIhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:37:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon>
 <8e35701f-1bfa-c9c0-62e6-48ed19d7ba37@axentia.se>
 <20180403071843.GI14180@piout.net>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <6a2b49fb-8e2c-ff76-4743-08f8d6a8d5e9@axentia.se>
Date: Tue, 3 Apr 2018 10:37:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403071843.GI14180@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0050.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::39)
 To VI1PR0202MB2783.eurprd02.prod.outlook.com (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49dd5fd2-dd86-4be7-0d1c-08d5993e2edd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:7OFecZI4VEduQI+GunJ7Y5yImTwo4bU6ccVF9p/SI2xHSSntwqBlCWlZChlSiNzqaDw6jyHVKe6fSEBtDsUnlLnIcZ2veNM5ZQ9mzckYjPrkbRFE5KwJKKj/9ZVZ6RPN53HJnRmGg4x8BhCSudNALEnjrNsQ+QZnsBGI7aiOtzI2P9beqGwxTIUIW+YTCeJjZuUkbPa+WlfZpVC/3yXTTkhNQgNtQ7xtVaTeYM9V4tOoYMJLpHWDE2jQG1jfZa7s;25:h8OgIssfqkXLp4z+qRbwvMF7yyqj6ENXsAHyiUC5flVyzuwjNe8S9GAYKMcuuS42drRvAaHMvgaO5IBnXG6+ukCbi+rrMX5hlTgEymMECtIastx+wCamSfaQTX2JJip+da0uFfESIDkk6z3qcWcDVcCRNbEHmuyOX/RFzRrklxR7riIPA/RKNr1uBwu1/229LdB5EG36nZOvC6iqGShS7fMknKIr0K2NzolGL/+wTnqRrcUU/Gxxt11n9ZNzzTQ5oeg8av/b09ajUXOd329W7tatpfrKfxImJwCFLPUz6u6W9QZb+DW9dvttSa2J5o/wz42hjbyMMkPZbci0ux1DYg==;31:RboRjKc0qTPo9DwvqygTuCQkWuWwjrqBKU9qp7QKwbAHYu9xVAT5gHrcd8aCHFJGY3bPU90h5Ync1dFD6M4EqqJKFB/KPTAevQCVmUBS61XIfrtWOYcwrtZG5yZBvf84Zb45t2LgDmS5S0iaNfbcQFgAf1XTCs4ZVdpexTx84ezaKuMb/fvZE9oi18CdSYBmyvmQwKR17DXohynWqLmlBHE7sljpqve69WBpi3h9YAY=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2783E6B2789532F516FF2B65BCA50@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:JnEX53hPV/Vis9OAI6F66MRugiajdg67J8ZDVpk1RAvEdBePpmhEzqJx86RVkIuXED2xH7B9AY70XdlbTaps3k8ETP9IGOlSSy4c7WwN090ofEhwU6xfDuThd7hTbwXROCF5RBTleDr5QISpWNpXrCJNI9oXxJGSe9RmP/4eNsoJeFR2zX6qvhjYosrJ0ZAvndprUklobMpdivY+jffmv8TV+iB2CrHsoID7QsAHT9mO1Rah8GuEq6HkwMI1ZxIBSgdJXuB0EZgeKAux6AN+/w==
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(396003)(376002)(39830400003)(346002)(377424004)(189003)(199004)(6116002)(8676002)(3846002)(476003)(8936002)(81166006)(77096007)(2616005)(81156014)(16576012)(6246003)(16526019)(186003)(93886005)(52146003)(2486003)(36916002)(23676004)(36756003)(11346002)(316002)(76176011)(31686004)(230700001)(97736004)(956004)(26005)(486005)(486005)(86362001)(446003)(2906002)(4326008)(54906003)(6666003)(50466002)(106356001)(6486002)(74482002)(47776003)(229853002)(65956001)(65806001)(39060400002)(25786009)(64126003)(31696002)(53546011)(386003)(65826007)(7736002)(6916009)(117156002)(3260700006)(52116002)(5660300001)(68736007)(105586002)(7416002)(66066001)(478600001)(53936002)(305945005)(58126008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODM7MjM6VDFXNVl1UitvUUNueWkwTm1zdWZQdGpn?=
 =?utf-8?B?eVRtRWcwYVk3MDJzM25GbVltdlhvZ0Q3WXNiVm5EaGpVTzYzNEJOYVphbjUv?=
 =?utf-8?B?Q1h2MTBndjJoTCtmSTUwbEpZZ3hkOVpSMVNRSTA0eDJMeUthYkZST3A4NHFP?=
 =?utf-8?B?RVBIK0RjTlN5Zjc0Q2VDeTVUb24ydjd6SGxxdUZPemxQSXNvbmExRkxqK2Fv?=
 =?utf-8?B?RXlkY3VUMUdHTXVMRjcxcEZza0tRampoUGxqd2tpU1paUzRyQUE5ZmoyTU00?=
 =?utf-8?B?OXBZdU9qK01sYmhieWpPaFFvUVVhSUUzM29JWXorSWxXZE54TVkwUk1PVkhq?=
 =?utf-8?B?UEZSbStYc2VibUNwT1VaUXNlV0p4RFVKa0tzRlR4dDZEL3lvS2NmNm9XTVZx?=
 =?utf-8?B?cTkyeVMyVUtCaC80dHZQbmdIbGZ3cy9YMndnd0J6Lys0anFVZzVOM2s3VjNw?=
 =?utf-8?B?bXREVFMzaXBCQmNwQ2NZNURDS2pHUjRpWXNOanpWSlExcytQc3V3SEJ3U3ds?=
 =?utf-8?B?MjV0WFo0NzdGeEI0cm0zVy9rbmhjakM4eEFQVVlkdGd4VjgycmxKcDE3U2Ny?=
 =?utf-8?B?QTVxYXFGcGxkUjVPZUxiV044Z01PRTVYdVpuSGlTanRFbHJOUlZFVkd1ajhQ?=
 =?utf-8?B?Mys0TkRMM1dEeUd3eDBTdUEzQ0hkYjljR1hDdVFUdXoyUlNWaFRxeVY4SEtC?=
 =?utf-8?B?QkFHU2VPa09MTG1qajA0SnpMd0xPTEVCb1BNa1ZqOGxMOVc1N1Axd3BhVm9X?=
 =?utf-8?B?dTJHb0wrUWtPY0xEZlRmU2VibVBMaGlPNjV4Vm1yc3pqbU1rV20zSjRqOXNk?=
 =?utf-8?B?czRJc2hzdG45WEVSaWtxeWtGTTExOUVyM0JUZnhIYVZzMUVlVzR6cDAxYmps?=
 =?utf-8?B?RG1ReG12bHZoWnphcFNYVmg2SG5KQTVEOTZkOGRNVjZxT1NNYzVMTXRSOHdN?=
 =?utf-8?B?dFFxTncreGF2dXJuYTc4M1RzeEVwWEh4anNrc1BvQUFqQldDdjJwbjJDMHBm?=
 =?utf-8?B?Vjh2SEM3MmZLazVqRjAzbUQwRXZPQTdKSk5LUlZNMUxQWlBZTTBCTWNCemYy?=
 =?utf-8?B?b2ZsYzRIYW1JNW4zRjI3RFliOWovYUJoQTJzY0JhUjlNUzhRY1lKUkRZK0NY?=
 =?utf-8?B?NHRZclg5YWk0d0hBVWdDQ2lCa21OVmNTNzhxZm82MXR1L2RDRExCbkUwQVZC?=
 =?utf-8?B?dU9nRkk3MDE1WHNCWFh6ekNabHNnV2R2RjBVYk9WUXA2S1pKbVRSNjhhT2lJ?=
 =?utf-8?B?NkZnTXNVaWdIa3lHZkVGMC9ocXJqMDMrQjFyUWJ1WjhrQnNqcW05emwrY0dl?=
 =?utf-8?B?d2krU0RleWh5aUVVSUQydFNUcEdEOGxYcFp2TDV1enptZzZ6cVdNMHJOTDQ3?=
 =?utf-8?B?TXNNcmNJTmdOYlNtU0FhL3RCbUJnUDAzYUVDL1ZML1JXYXNqdVlRNzIvTGFB?=
 =?utf-8?B?T00zdXRHLzNHcjZwbVdjK2p4QWY1UDkxTzVvTmg3U2ROVEd4S1JzVDJINno1?=
 =?utf-8?B?TGhQVi91QytnbFo4M1U4eVRxK2FxZmRYbHVJSEFnaVZpSDFqNk9UcllqdTNy?=
 =?utf-8?B?bG81aXhtK3ppUXNVUmFhZkIvaUhFeWhaaWtUU1dlQzNaLzN2aUV0Wm5oRDRI?=
 =?utf-8?B?ZXZxeCtlV1grV3dMVWQ0UVhRb3EzQ0w2N2I0NmdjczBOd2dQMXdvV2dieVJk?=
 =?utf-8?B?anQ5RzZpNDZ1RHlubDJVY1dsMkFJMklNaXRIZCtzNEJQbnZqTk1kc3NueEx1?=
 =?utf-8?B?dmZ5Z1dLci83WGNzYlFBbnFTc0RxblFzMVY3bXFyNnpGMk1MelE1Z2ludytu?=
 =?utf-8?B?T0dnRGxlb05jNStvSTFwdXR3R2t5aEtjb216dmxXb1lkb2RuWjFHV3BzY1du?=
 =?utf-8?B?YmJGQSs2SHR1VnpqQkR2ejFuT1lIZkVsc2g3SVhVK2NlZUMzdm9FTGx1U1FD?=
 =?utf-8?B?NVFVUFNOdDdHK3pQWDZ1NDNHUFI2NzQ2MUlWZUw2K1grRE1RemhpeG9nZFU5?=
 =?utf-8?B?Q29lN1kyWDR4NzJkRzBCNW5yK3lCcUo3dmw0dGxvWllhd0FqQzdhMDZsWWo1?=
 =?utf-8?B?eDlpc1ZUZlJFVnBjc3ZZU1hPSjBiV1JkbG9LaDFFSkQyMkcwOEJPZEE5bDVP?=
 =?utf-8?B?djh4YVFTMkxsQmlKSHk2anNzRnlzOFNDRThQc2QvUkpUeTJiNG1LOVpYRmlM?=
 =?utf-8?B?Mjd1VEp0RHhzbHJaejFxYjlxTlFQaVpZVnNibTRwYW1wa1dqQ3NlZ0djYnN5?=
 =?utf-8?Q?vcc8nftJyxxGg2YjcOB0?=
X-Microsoft-Antispam-Message-Info: +G0uUrR9qyyUDiVofkn8xMnu5CU1uU1kR6uPbk7TDZS2D8s4rYeqROwz9KT7c1XgvskekdJenkzVYr+EIV9WTXpJrnIIjQs/y9xzRs3bHAVT4CgmCqSdHU/CENFqzUvKG36O1mWKQb9SiTYAnkxYtUiDPVB4Z08pIxKzxxxJmNpryID3+EUz9fb2uYnmDeEb
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:2LxoPX3no6BSHMMFsjFi+BmomWe7k+DovXhfoI3+nI8N8Pj7fpsXvxg9ClG0GAGcmcACRg6c8mjwdTqa1ua+b70igb/5paLXwnP52FocxsmwMuBGkMQqyKLXMheYdFmo0EY2hYfbgZtz4gf1wMsISRT3jHGXicsRV+zCtBnBOHrHCwHU18ByfNfUVHREDz4L6QbmQHrEv3xu2sREiJDiOOdKzCjBeniMil6PtbVbM/icZx1F2W9uSUzqvcGG5RkZKlnEQ7luo6c+1ufANkQm8cnuJgRxhAmUG1xQ4/w0g7lyAr/Ev0mei+lQWhOkHymWOkm+nG2ifK1GKFfA40mDx5vM/719mIPtAeXrMfe0O5qQzD46MBQFHl1BnjHnBzNl7h5I7tECog2v6TEzzxdv/3tc1OaaSFXLpgGmDSfnULaZ8M+n14NQIItHkC1YsOGHrrO0XA1TI9Q0Zvpus9dLQA==;5:xVFkUVzoy+a/AchAB7fRouyKyEUScCDtIBq7GNCtwhnJPK76uex7w85rRJrqn6GOjSg3BCNemN5Ujor8MwCQsoqyKQ4pT5BpzDHnJpdY9dhytttMYopnwnPQeBzoWyEYbaGv21jP3aDaaFG3jgLPJJ6fJNQqL+8j1QUFzYCzUgs=;24:Z3KENSOPvOutMoQjQE5b3BUy7Cfj1aKqdcNgcpDME5CQXFxW0z7thj4BYAMZJwSIzaYRueEk1pJaeCYYLQcxvapipDLX62EndR90MP+LF4c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:WcSBFZkUYlGgZRqn4w5wcVPCS4xBZu1lFJkP24M79ngSTyVTTKZMnlWq01eF5weVao4hEpsOwjgh28YMwy3QTUsmpUY96Eddn8dt+Dd9ijAinvwJG5lxiVE5/AnohEzpvEgklPqJKGPGyj0dARqNKTEWjrzYySqfmHS3R6f41SRTmPH/cMV/dsqpa5TM2p8Oeyp7o82Hz9eo1Yhp4pznyvQzSa5L3uIwSKnql6tYPGcRU3rLNQjyStwjr2SI4aLH
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 08:37:48.7303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dd5fd2-dd86-4be7-0d1c-08d5993e2edd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-03 09:18, Alexandre Belloni wrote:
> On 02/04/2018 at 22:23:17 +0200, Peter Rosin wrote:
>>>> No, but did it again and checked, see transcript below.
>>>
>>> I don't use devmem2. Is 'readback' information accurate or is it
>>> always what's been written? Because when you write 0x33 to 0xFFFFECBC,
>>> 0x33 is read back, but just after that, when you read it again it's 0.
>>
>> Looking at the devmem2 source, it seems very likely that the compiler
>> optimizes out the read and thus outputs what has been written.
>>
> 
> At least on x86, it is not optimized out.

Looking at the disassembly, they are gone here (not that I'm fluent).
I then tried to compile devmem2 with -O0 (instead of -Os) and the read
is then fine. So, I guess the devmem2 devs could claim that it's a
buildroot issue, but a volatile would certainly have helped...

Cheers,
Peter
