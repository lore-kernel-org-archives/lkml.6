Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753795AbeDKPK6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:10:58 -0400
Received: from mail-ve1eur01on0112.outbound.protection.outlook.com ([104.47.1.112]:54636
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753150AbeDKPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:10:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Josh Wu <rainyfeeling@outlook.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
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
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <20180411165925.2be0d45b@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <bb64d0b1-bb3a-06b0-9e90-0caf7531f3c5@axentia.se>
Date: Wed, 11 Apr 2018 17:10:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411165925.2be0d45b@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0014.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::24) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:8jwtx/4bST+XGarBIdW7QpIBN/nDGTC1qf2BgMj24sz9rDhhbJlKk9HmHfMyKzZ2XfvASooM5XZAlW+PHoBWL3YNq8MbeIJ3Eidfz4AZ8AXnUVhBqsCNd/e9Zy/5wLafidQVSjQZW6b75Q/L0fZhYPEgod+4ym09/wHX2sR3Y9iJ35z4G61TBZOqGWKa1MZ0BAyRr19Ztjb5G/xxAUd6BpgHIex5Wek7dsZY2kvj0ctfdrauygzMm2hKQ6RK5zQl;25:8CUHZPhV/8qzccbG7lstf0Qt9PewYAXSehyQJFOSUFd54CsBkVHskUSkO8lQ5jZG/0tjRuB706DgxH9XGI2W3jVWruJ+yxVzn1xJJ8a2UutKzdn6Vv7S13HQfJscAP29tZ+vSE3IPuypnJV2cdolt51sS8xU2M/F0gFhiF1Cv0xEOIFUO/rGSPYUw2+AwVypZnfj9jRBjlHLxy+7bw0yupZOyOazrJCQogfMr9HcEDmbI8A0XUh1N/uZVAMrQvQuspD1syo9NfyOzzfbtUaSuvni0BsFNkdksqps4GmpeTzvqcyNscXkUwdO06/o11sBRjz8J8RkK9/HnrWm8ttLpg==;31:SZiC1azsiWCiEBHflh6RsiD0/nFyAWUjdFxK/BP/As15rjrbDqxsA3IVIe4eDRAqHMR8iyffsDHDcSNL4v/iWecoBepPiF9xJtK9MSlANJLd7f+hSE8OIu0KoLvAVWMtEQLdQTF/M0lRu9StMpFMhnwK5Hof7u0DQrVJckxJkGv+xmGfFNyqGMpzbvMJy8X/90Ae70ODm36hShbGthLOnTrNyPd6HEABxj2iLUNh5Xg=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27757A64B6FBE421DB5DE658BCBD0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:d9z3iP6QKu7r4QxjsvUoZm6eWzrWwBvBHjBIaXJ4IDQEpuHWOe5AgKrmmH0CIpZvNVZPY0MS8NiRb5mNWDrR29oKuMmdK5L4ubciQkyJIBC6rClqqTmjDHAJblTzdCwtiy5+Re+DWbMx9AEDNnWI/FS7s4BfilC8kfaRGuyWh81fKuF1elxZ4FbLmsI0PIXXIt5ZilsU48vcHiI95CzEHZwFODYvgKYJZv4FUL0Py2XQiy/wmex+ujjHOw6nHN6VwI4jjMN41gCtrCG81SBFrA==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(376002)(366004)(346002)(39380400002)(61684003)(189003)(199004)(377424004)(31696002)(229853002)(93886005)(6116002)(54906003)(16576012)(6666003)(6916009)(58126008)(316002)(31686004)(105586002)(64126003)(6246003)(50466002)(53936002)(97736004)(4326008)(230700001)(39060400002)(6486002)(106356001)(3260700006)(25786009)(446003)(66066001)(65956001)(65806001)(47776003)(74482002)(386003)(53546011)(2906002)(23676004)(2486003)(36916002)(76176011)(52146003)(16526019)(186003)(478600001)(3846002)(77096007)(26005)(7416002)(52116002)(86362001)(5660300001)(11346002)(81166006)(476003)(65826007)(36756003)(81156014)(7736002)(305945005)(956004)(8676002)(117156002)(486006)(8936002)(2616005)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6VXFIU1kxREwyTHVHZmlCcjlNcXlWUitl?=
 =?utf-8?B?ZmV5TFZTVTFyVjRINithcTd0V1ZCUFBxS0xsTW0wakdBVDI0Ky9VOFN6UUkz?=
 =?utf-8?B?OGFnTnYrdXR3Y0FibE9pOTlZdC9LQ2ltWENxQWtHSGFFSlFRYTZ6elNqbTdD?=
 =?utf-8?B?bFNvSXBEQVUrRVpxNXYyelRqdEtUNG0vaUxkQTRHRVJBWUhhaW5FWkVGWkdX?=
 =?utf-8?B?V1cwcUtIb2NVNk9NdHEzVXAxcmU5ZWJBUDkvZnVvSUVzTHEvNld1MVNmTWJo?=
 =?utf-8?B?T3VVeWExeHQ3ODloR1BIQW9pOHJkMlM2Ri9sWTYzYTdoZXh5eXQ5ZytsQXdo?=
 =?utf-8?B?MW1COGZTU0dUVEZsamxUWDB5dWlwalZmYWtRNEJadUZKWGRiNlRDNE1MS2lk?=
 =?utf-8?B?SUx3eHliMU5XUFpaZ21JY2R5ZUpkb25HK1ROcVdrNk0vWHNyWFNINExPcDlO?=
 =?utf-8?B?ZCtqeFJ5VVZ2REpOTlE5RkhWVDNKWUNNOHpGM2tCYmZ2Yk5CYndhQUJWOW9E?=
 =?utf-8?B?bzZTUnM4RlRsS0JnNVJETmZVQmU4RCtEanBTTU1pZ1dCbDk5NHU2cytKajIr?=
 =?utf-8?B?S2tKcllHS202TlltWlRRdUE0aENwQVFkYU9XcmtuVnFKSVo0dnhUSEg2cFNM?=
 =?utf-8?B?THlwU1gyWGl2WGhpaFc1MldYUEhycUR3NzFhVG1KYnovTFBjQ3FOSUZuVDl6?=
 =?utf-8?B?ZmFSNHRpTWhuNjNlYWRrSXpqTndBSWk2aWhZbjljY3EyNCtJNzh6YjQ4V3V3?=
 =?utf-8?B?OVhMNUFySUJUeklCbzFqcjJncDBvUHM5dzBoNGF5NkJuN1prVmQyUDFsU09r?=
 =?utf-8?B?a0ZzRzVESEZ5YUY5TXhDRFQwcnJqbko1Rm1Dc2xCaXczNmp4QmxlN05BZ2dT?=
 =?utf-8?B?ZkR3WngwL0FNOCt3RVBJN3g2T0Uvdk16Z2xGeU45RFQ5R2tqSm5LMnJPY3A2?=
 =?utf-8?B?cEJ5ekIvenE5aWNpNktPU0dnZ1NXZE8xZlZrR084YnZmMUIxZFpEcHdpWmhO?=
 =?utf-8?B?TEF3YzB4cFp4N3BOSy96SDdhdVlDUUNOOUp2c0NBYm5ycjMyTHJiRWM4cVIr?=
 =?utf-8?B?RVRHd3pldS9wOWQ1TS9odkZhb1p1Y1U0NFh3VXo4UG5NQVN3RUNYZkUzQWVP?=
 =?utf-8?B?djZ4MlFoY2Y0Rk1BbWZjWVYrUk14TkpsN2d5d1NySEdGaE44T1BvekVNMjRq?=
 =?utf-8?B?Tmh1TjdVUlRZY2RwSGhDeEVBNHB3TFM1TFdkcmFEZG04enpSUjNWbVBnRGdC?=
 =?utf-8?B?dzUzY2FZK2I5SGdxcW4vQlkxNTJXVXdRelZwbkIrY2VYbE5UeFNYUjU4SXNF?=
 =?utf-8?B?SWpYRTlGa2dBSUx6V040K1dVUlZxVjJodUxERTFrL09YVmpkK2RSMlFlZ0xW?=
 =?utf-8?B?RllEUlZuQkt6WDd2WGk5N0oybzMrOFo4UURRYkhSdHpIeHQ1MHBFVzJpbzlJ?=
 =?utf-8?B?NXEwbFk4aDdicHFhdThqZ0RoZWg4OTJSQ25KOUpNdkxGSllvMEVkbHJBSFVF?=
 =?utf-8?B?UlVmd3VDQUdKRXhYRXF3MkY1YUZkVEI3QzloaXNoRmVvYTFmcjQ1M0tyVVN0?=
 =?utf-8?B?QTdpSUhlRXUzTWRWSjFjZk5uZjl4Um9vaDJJSGZSVUdFYXdxU0VCQ1RWazhE?=
 =?utf-8?B?SGVxdU01LzJnaWtOVjRYUWl5T1ptRlk5NlZ6dVhROVVaSnArb1FiLzBvOUNF?=
 =?utf-8?B?dmpZNHJmLzJKaFNVOHJtZE5mcWNmSnFBZk1hVmtwcGtPSWRtY3paY0FlK1h3?=
 =?utf-8?B?bjFUYkFoekZDdnYyc3pWQzZoclpMaGlnVDl2by82OVpSeXVDeW9zbHpsdXlt?=
 =?utf-8?B?Sm1yUDVzaHlIZXlJZk1YRkVrTE55OGpsdjdMSlBTSVBXRW9vVVFVdVRJK3cy?=
 =?utf-8?B?OXYxSmU0emZOQUh5bTFibjY4UzVsYm45cWlqT00wQlVHaHhtTmlIYjQvdWpF?=
 =?utf-8?B?bGRRLzR1RGhTVU82OHdVWWZZSHRhYlNlRjVDaXlpMG9mMUcvODVJK3FueTJk?=
 =?utf-8?B?OVdEczB2STZ1MWl6YUFYanFZMzVHcnNTR1Z6TnYycCtvcE82Wm1HRGNQK1Za?=
 =?utf-8?B?aDVrLzV1SXZrOExnL3Jma3QwNnh0aWRUVDNHM0NVMkp0NlZIeVkzeEZ1cXlQ?=
 =?utf-8?B?WTFkTmFKRjd5Y2RydjEzM2JxSUlYT3JCdFBzdXpnWEVyV29MZXhQRlZxOWky?=
 =?utf-8?B?dXFRZURuQXRidnBuSW1UbVJ4RHArbGZwdGdma1FGVitxUkVpRXdMVHU5MEhz?=
 =?utf-8?Q?mfzlyZ1flZuxtBh+7g3K?=
X-Microsoft-Antispam-Message-Info: zqK8B9lGnkgUdlt0tGC6g0KFBTYnHXzXFhU0BGXiRPi8X98Fyk8rPo0K8cLWi1sg289cIlYAewece8v3ZK/pF7TkckcE45yEZlLhzTbHvesuVR2INXrt+V7w9vDuMh1Qbb1MlB8UtO+CXU4Md2sPygwx4wRmj9BYPFjQPmS160cferhRkFeCWLpD0T4JzsyK
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:isxRb6iq1EWvLnVzKLIbt8OX/P9AtniLQcyJ/o0eIsqujQDFKKtnEMA+B2aKvkHDPNSjwugQn5uuMbfxWIWXv5S4XfB7PkDGjZbGUF2sZR6ARTc5st/ov4QLXc9VeCBMmMG81JXH7e1d2KEO4C7FBodd+rlY+AKn8Q5oPBYtzniOXIVFEYv1IIiECxtQVtcvDDJBtqvej9SYMHLdBMZMFbb2hxLrcyCMPCpVCJlEsxMoxm8shqB11toIou6iBigfA45KN0Dz/YPwdybWZFffam7rphBUhP3NbffzS1WCiVeiIH1c7jbSf0UP6tfBmRYLX7VWPez1HM7UDNnL7jUegGZbf54zGtM3Fl8Bd3+Jz8qfQzyFgSOnWwxsSaoamEL5sz/j4ScgyaiOkm7nannRqj/rqVz1yVfmBCGhvF6wuF/KttmcAM2uHR9elwI65pad6dQKGzybvxs53cFLXmo9rQ==;5:7LN9WRBCtpN/8bUk3vQuznlAkxYchfd9vbTr/g8+TdbnGJHneCNzAdyq5KE/EBKczSklcGaKOGtqooCdA2O6pLSTCKT3yIuf/N2BSRaigdmx05T6OqGW7FzgVJW+9g2gW9dj0SHoC7mcvSNbaybhFpye289jxdbDagkaVQYm8L8=;24:DNOlyCikQZtwpkhiMBRX2X7OAiB82/PyLFaTpxiVM9Q1EBpkA53iZKdenalfdPVR/r2SzV7zC7TvJ6uoirJeMYqU0z6eciWrnO67pMQZ2r8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:f9WLHWJN9U0ZSsTKpxUjirKoeEYZVOmIbvyBGhbvLudW+EzIEoriLTq+ukexgXMma7IwyYcsAsFIZV3f6sNemcmTXsl2BHWVyN9P/6YNcSA/TEGIramzKz3ph8HtiqwDwIwHAfw/QxxOG3RawLuhfxsRdig34WNVT1jRidcotrY7J5i/dnrO9miveDgVre6GulxJVBzMcvRMaS2i3InRAVBn3DabHxJtkNJg7RB7nZkUs1zcmAvBR7TQOIMujfcj
X-MS-Office365-Filtering-Correlation-Id: 9244c7d4-e57e-4171-6d96-08d59fbe6a2c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 15:10:50.6536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9244c7d4-e57e-4171-6d96-08d59fbe6a2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-11 16:59, Boris Brezillon wrote:
> On Wed, 11 Apr 2018 16:44:10 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi Nicolas,
>>
>> Boris asked for your input on this (the datasheet difference appears to
>> have no bearing on the issue) elsewhere in the tree of messages. It's
>> now been a week or so and I'm starting to wonder if you missed this
>> altogether or if you are simply out of office or something?
> 
> I was wondering if you had given up on this problem, it seems you did
> not.

I have my local patch to disable dma for the flash, but local patches
are always a disappointment.

>      Did you try forcing the HLCDC to use the 2nd interface (ahb_id=1)
> instead of the first one?

Just tried, and it's better that way, but the problem still exist and is
very visible on some (but apparently not all) flash accesses.

Cheers,
Peter
