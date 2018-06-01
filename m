Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeFALJe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:09:34 -0400
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:50048
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751311AbeFALJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:09:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ivan.djelic@parrot.com;
Date: Fri, 1 Jun 2018 13:09:21 +0200
From: Ivan Djelic <ivan.djelic@parrot.com>
To: Kees Cook <keescook@chromium.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lib/bch: Remove VLA usage
Message-ID: <20180601110921.GC4695@parrot.com>
References: <20180531184525.GA11068@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180531184525.GA11068@beast>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [62.23.167.188]
X-ClientProxiedBy: LNXP265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::26) To DB6PR10MB1736.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:6:39::26)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR10MB1736;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB1736;3:5P/CXSu6kl/rNiV50inzTLegtSt84YMYeFchd6yNli2kzH9pOSABeoTN87pG8YmbnPcXbzTfGkT+uWiYosWH5C/SZqTAkPBRy/G+MFb4sT6SKiJCFoqcO4ZLKoReJt429VtJNvpFzOhBZU3hyA/Pt/aK5xNWP9dBZ5D6HlopMq9rfruZy3xuR/G2DJP+kxO6+LtK8hM/THPWQ/4xJh44NmT5foD5damw7iPlDGzVSCB2EnhjoawqwuGJOkKdZ14/;25:IzNoPHrrWPFxyNfMVxK48nRWanNjDCjMS3N5nnGqH/zKLn40GHA0si+LBlSb5JQvPxpSja9CG0W6f2k71V2BLOGuJDFbRu2A0mOlYm97jYZiBu4Fxr15IV2FrLdFid7SFxoR8GYygYQ23Zh5vMgf9vLVuZ76B3Dp5j/SybSyegm1F8y1wFVU65ZqcxUDZbliUiNBD3XwWjxiYmaNl601zcKr7duEBmepjTd48oMtICo0X9nnazE58eRfntdCL0I4rEeLDiapXp6tnQ1iJJcIJ5tXIYGqNIcPe4FeQ0g4tWFORppR2zgRRP/nOWFlcVLX6pEHdce+pVXXmwDx4pkNMw==;31:5BDS9GPL3ozVco8CIZRSPWgseddNyfvfSQyxUMJKaz1esSr/sfozzrk1KNulbdGbwY/0U3fRBdDhXFEUUoaDM3tS/QAYqEZMErmC6tmX8lWBprHGVK2zXuprNPVIjrz9sZ8qkeZyt+hsg7XcG2AyN3FC7924f9p4CCmRmo5cvYIYQqVhie/fEHNCREOoYuqQo9Qhy7JkYRvIBi/7pxgVNRSHE2X9+V4IbU8myPdfJLU=
X-MS-TrafficTypeDiagnostic: DB6PR10MB1736:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB1736;20:Ef8a7xk88pP4aKHB68f1bcVNZ2hfrcO9olwn+tduY6K1uEk4QRUNBn9VYkTpJML0jdWughrMpYATJ/emqmHVyS3xDnr8tym5Ptc/zYPcUKjN/OvC6Fnp4qo+IDW8lNqCqsIJlereS3uwjQyPq/JZqtTv2rvZA06T1wBGiHldbjo3wb+1xbfBgKpc+v30BlpMnEFOuJE7uwxNqkq8aZ1kHHzk9iS2mWHWSPtbCpA8XgBfKaL77Ixr0HiDAo7njhqBmeVUV9jJXPiZ47xh4co3HOJB683bEy106NYJglqO+7dHxdYYbStQmSIOySgU0jjtwLK90TdyOYUmvltw+/mjaf5Suv/slEF9uUIzRskbaAY=;4:NB2z0gDHUxIKNzdKIoV30bIb7puApos2OiTCqJRvOz5P+FnvpmD1ECpJSygmu7u0ldiILFVFCw+NgIO5X1W6wrLGSVJPGY/3pZzjaKXaHr1heSSh/Fi31XT6mQfk5PF6x8thwf/AUlGoKDIiyuiQoAjb+YE9UqBKabVRjXVmhicVLwhRvDUwbtguDx7/C1FbsLXqvUmtKbAcuMZACvpT9YK4bUFf1rbI5FmTdMXTDWG2jplcJigM8czjjVcuiCph75B8F24IDKIvSuRzmCvCzt0deCtClpU1ujccU7NzPgEpHVJ6oQ61a839eI2ztWPxc3OBq4RvfwN4Y7ILI4AEQimqExXdPQFHCAnY8Q+Nt9Q=
X-Microsoft-Antispam-PRVS: <DB6PR10MB17369A1372FD5BDE9566B79D8C620@DB6PR10MB1736.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR10MB1736;BCL:0;PCL:0;RULEID:;SRVR:DB6PR10MB1736;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(376002)(39380400002)(366004)(199004)(189003)(58126008)(33656002)(305945005)(3846002)(1076002)(6116002)(6246003)(316002)(47776003)(36756003)(39060400002)(25786009)(229853002)(486006)(44832011)(446003)(11346002)(2906002)(4326008)(53936002)(2870700001)(6306002)(50466002)(2616005)(476003)(956004)(97736004)(55016002)(26005)(386003)(59450400001)(7736002)(6666003)(33026002)(6916009)(55236004)(69596002)(105586002)(186003)(16526019)(478600001)(106356001)(5660300001)(81156014)(81166006)(8936002)(966005)(21086003)(86362001)(66066001)(76176011)(54906003)(68736007)(2486003)(52116002)(8676002)(23676004)(52146003)(7696005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR10MB1736;H:parrot.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjEwTUIxNzM2OzIzOldmMThVN0tlUmtuT2FUa2NsQkwzS1VQZDF6?=
 =?utf-8?B?ME5tMnZycUxGU2NjUmY1M29pcXRML0ovLzh3K3JZMjNLMEFjTWI0Qnl2NEJt?=
 =?utf-8?B?dHdGck9HUDFJNGFHZmxjcXhldWZZZVRBZVA2VXA1QlliQW5VR1JGRm5NQUQz?=
 =?utf-8?B?QVcwMHg1bkJOU2ZNNXJzeXNHOVd0STdlZU5yRml4QURuSjhRQmxKNDRucDNo?=
 =?utf-8?B?YUNQK3Y5OUZJcTdyZGptL0RaVy9aTFJCR1hIMVlRQitkeHNzcm1ycGs2Z3pL?=
 =?utf-8?B?dWpYYUhHMnUwaElJK1JIckV3blNEVG5sek1aSStxb2pSWGVxTFp6NkFQdHhP?=
 =?utf-8?B?cFdhRmRsUExrd28rRUVOK0lBMUdRYWpuVmtKa0JEeUs2Nmx5K1JQc2ZSWTR5?=
 =?utf-8?B?d25uRThKL2prMWErSkRRRHRIRkp1aG8yT0pqZGR3Z2M5S2xqd1VmcnlPd1li?=
 =?utf-8?B?b1BmbWVIVEpkRnRtaU1CeDFXTGhWaDBwb2RQVVAvaWZodWRZTXNQWkYrN1Rw?=
 =?utf-8?B?YUhQSVd0VVNoM0ltWkNFYytjbGFDdjcxRUlEdi9YUEgwalM0QlRkWFovd2FR?=
 =?utf-8?B?aGxieCtkUFBXSFcwSHE0UVFtbERGRitJWGpJOG5FZVh6T0Z1SUxkMkJFbTBS?=
 =?utf-8?B?N3NPMmhFeDRidzJZNE8yNEUxRzkyZVhDODRmQm1LeEFtVDE5UVBvSUZwajFO?=
 =?utf-8?B?ektNSkpUT3oxcUQxZHM3VUQ5SUoxMVl4ZEFoNUwyV1llTko3cTRHbFZmVzQ5?=
 =?utf-8?B?SWd3aUVwWWxITkV3NEs3aFRsQVQxMGxiTUV4bTFqYVlzeDlIbno2ckJpQ2JP?=
 =?utf-8?B?ZUdHS2dqQUF5YXFnUzR0MVJRK1ZxVW1YUEdtN25CVGhlM0lzaHZDSEVhQlB2?=
 =?utf-8?B?aUgvYUliSE8xbWVZQTJlSUNkdDl2WjBpcll5S05tbmZkQ0dKSHVOcFY1NGxH?=
 =?utf-8?B?VndSdEwxLzFzd3NONk55VitUQ2dwbkhjUXJIbDBUNlJSbUx5UnZXRlpGQ3F2?=
 =?utf-8?B?Q3JuSFAzU0plYVhmaXljSzV2eVB4WmZDcThINFgwOWZwYS90NGVFb3E2aXFl?=
 =?utf-8?B?N2dwblN0cXFyTDhNMjNyd2EwTDFuUWF2bVVLMkt3V0NldmdGbm05VXE3K2l6?=
 =?utf-8?B?RVJLeTlwc1FJVk4vZmlOalVPTmQrS2QrcmJ1MGswZHp5cFlNZEoxa1hqUEQ5?=
 =?utf-8?B?K2MzY0Y1NFBkNk14eUNkOVpwb2ZaNWV2VGxZb1Y4U0NncWlPZ2YzOWpNN3JK?=
 =?utf-8?B?dnY5LzVlSzF5T0JyVXQvamMxK3k2emJLWUxEYVhySnVDb1FtaS9aQTRUYkFF?=
 =?utf-8?B?VVE0aXJDQ2wzNEEvVmMvQW1mejM1OHlaNVdNQkVYMWNNcGNRMnBzMHR3Qkkr?=
 =?utf-8?B?eVREMTkxeTVFWi84dUU5YzlFeU1FdlpVR3lkTHgwUUE1TThNMGFzNUpZYWQw?=
 =?utf-8?B?SmprdGc1YUN3MEsxaGU4eXZVTmo3bTJyNXBqajY0UDE1SzY0a0lMSnkwZUEy?=
 =?utf-8?B?MU54eXNUaW16OGV6WTVBVFBpdmEzb1E1VmNtWXByL0xDZmFMUWpiWksreEVN?=
 =?utf-8?B?NzVCekREdnAxUkl4RlNWcWFyeXBkQ1JjTis3VDRiUWpnYzF4dU1KRTlselpD?=
 =?utf-8?B?K0oyTFV1Y0dmVEpFRlIzcWR3NkJxeEFKTUNBSEdSVUhiUllUc3hPVGVvUmd5?=
 =?utf-8?B?azErSGJtYXd5N2FKL1lMSkUwQ0ZwdXFqWnNSSGsvRlVTYzhjQkhpZ3R2aXph?=
 =?utf-8?B?YlFXMDZrNG1xN2NjckRPU242SkxEZzc0RzA1L2xsRVNmNURPSHFKZHhYMWNC?=
 =?utf-8?B?eEVFZ3A4bVhRUzJkZExwWlA2ODhNeDZqOGw5WVFWZTNNdzdUSFdmaVJTR0x5?=
 =?utf-8?B?TjUyUWV4ZXEwTVhERUxja2YwdXZrUXdxVy9YVUxVTUpDRGlZTVlPaklKRUN1?=
 =?utf-8?B?cGhrQjhWaFV2WDBveWY0Rzh2ZmdLdnhvYjZLczBWdHJ3a0I4U0piMzI2aEZ2?=
 =?utf-8?B?QmdDcldMcFBUNnM0SDN4ZWRNdFJRYzBFT2JOQnZSQmxnd256RzdGVkhBNTNi?=
 =?utf-8?Q?hP/c=3D?=
X-Microsoft-Antispam-Message-Info: CZWfrrom8vv6m6CwEsiOlPA8FprnWnsanlh7FyuuHgojY883QCCsgl/JFMNeLFGsKw7eg29J48ClOu+aU7cycaNkY8JEgL0ToFcDTJQi0BdQcAv3zlvP4IWhqQuAc45d+6IQnGsMk60Pl1DFkWYFoJpITa2NmiHlkbe1r3hZFJ7L3VEchCwetqwBZuv/XfLr
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB1736;6:Y0AuR52VAKTSqKuzsarT746W08ad0d0Bna/ogtLihu1oekPW6UDKcZyhkhl4PCmHb9qspCymNLybbDOhUpD5Ooj5D3PKGUgNxKCxaIdbK9VSMuJMbVMOUCwvZDh6vJuolM/qebuclBr52aD5PcDYpljXYmG6dZwc3woHeYXRXM2Q0H3V3vN2usptB/JE3cRCoDssyZzuuDPLwCjEwx8tAYtZM1zXhM7eRCYB5F/YOIKX/2LOA9tsTcOaJQ+mrGpkazfc/gn5+xAHnRsPp0q7wHe6OpvF1QMOXUt7xCiyUTuVxeBhgNGAnO5JUgj+MGfLAcJZFDexsiSwAKm6pXtp9hadAWKbf1mTB+hQXPw2lIya1Dua7ZHHsmrngzs7XwqYmWW5/gYbipyBe6yktZ+EcVCh97GZ/JOtWQGNNwvqqUhSU/9D7vlTaLB51/8FxIR17HifRHbrruevAIw46X050A==;5:pvnuvBsjnWhpGyQ4m7Dmo3vnohEgEnRYWrWTRCddIE3sRj6IdUu0ZchWb7fL5HJfbMg632NS5futEN+jc9AsKvhE05Y+ktH2Cqzg75EX3ZLW+fGyDOOSfxuQBl1JN47sc2fImN3sMIaArqEy5oBM9E0y3N9EDK5Eb2K2d5Fk+Ds=;24:wVb3cczjXeFmLuKeklHkm0OY31qVNck+ceT++tvcIo3+kz+sXKu2ienoy1o6IBoHrvwmagyGc0sJIAbhvgF6s1RuXvUZ8LkuTwphsK2caA4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB1736;7:5eztz64bxC+IwQlRI7akWC2eJt1/wm/DLXmmGCL/OokQXoQW6E3pq7DSBMfrVyTPeimHq596uyfdRVOx+mYVVer7AG/5S4ZSyrDgvuV/0tuNZQIKdgv7UocwoeV5C0Rz505VIbBOQTrf88QS7kWU7pWQzc+5+WMXF5Hz//w+4Mc0FsEp2TF1RIoKoVDIntgROX73L22Q5HJDTJLLcHZ3P7cCI7gtUr4tVq5ufOFadykb1zDjhOOcfQ9qRazTPOlZ
X-MS-Office365-Filtering-Correlation-Id: 5c6c07a0-0d1c-4c19-6798-08d5c7b0224a
X-OriginatorOrg: parrot.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 11:09:24.2985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6c07a0-0d1c-4c19-6798-08d5c7b0224a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff7d991b-3922-4803-8418-ab806a3414a6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1736
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:45:25AM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates a fixed size stack array to cover the range needed for
> bch. This was done instead of a preallocation on the SLAB due to
> performance reasons, shown by Ivan Djelic:
> 
>  little-endian, type sizes: int=4 long=8 longlong=8
>  cpu: Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
>  calibration: iter=4.9143µs niter=2034 nsamples=200 m=13 t=4
> 
>    Buffer allocation |  Encoding throughput (Mbit/s)
>  ---------------------------------------------------
>   on-stack, VLA      |   3988
>   on-stack, fixed    |   4494
>   kmalloc            |   1967
> 
> So this change actually improves performance too, it seems.
> 
> The resulting stack allocation can get rather large; without
> CONFIG_BCH_CONST_PARAMS, it will allocate 4096 bytes, which
> trips the stack size checking:
> 
> lib/bch.c: In function ‘encode_bch’:
> lib/bch.c:261:1: warning: the frame size of 4432 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Even the default case for "allmodconfig" (with CONFIG_BCH_CONST_M=14 and
> CONFIG_BCH_CONST_T=4) would have started throwing a warning:
> 
> lib/bch.c: In function ‘encode_bch’:
> lib/bch.c:261:1: warning: the frame size of 2288 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> But this is how large it's always been; it was just hidden from
> the checker because it was a VLA. So the Makefile has been adjusted to
> silence this warning for anything smaller than 4500 bytes, which should
> provide room for normal cases, but still low enough to catch any future
> pathological situations.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: fix r_bytes to whole-word size
> v2: switch to fixed-size stack array
> ---
>  lib/Makefile |  1 +
>  lib/bch.c    | 23 +++++++++++++++--------
>  2 files changed, 16 insertions(+), 8 deletions(-)
 

The patch looks good to me. It also passed my regression tests.

Reviewed-by: Ivan Djelic <ivan.djelic@parrot.com>
Tested-by: Ivan Djelic <ivan.djelic@parrot.com>

Thanks,
--
Ivan
