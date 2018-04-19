Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeDSL6x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:58:53 -0400
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com ([104.47.36.82]:10621
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750973AbeDSL6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:58:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com;
Date: Thu, 19 Apr 2018 13:58:40 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mahipal Challa <mchalla@cavium.com>,
        Balakrishna Bhamidipati <bbhamidipati@cavium.com>
Subject: Re: [PATCH] crypto: testmgr: Allow different compression results
Message-ID: <20180419115840.GA14706@hc>
References: <20180411182832.27761-1-jglauber@cavium.com>
 <20180419034210.nsmzuf3f6lmn7suc@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419034210.nsmzuf3f6lmn7suc@gondor.apana.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.67.137.83]
X-ClientProxiedBy: DB6PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b7::18) To BN3PR07MB2499.namprd07.prod.outlook.com
 (2a01:111:e400:7bbf::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN3PR07MB2499;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2499;3:1O51i9rmZLAu7HR0hyh2s5+k7VTfpnch7DCcNwTxNm6+Z2q7MEq7UULv3tmb8aMMQRbflnS/TgWfL18T06UvOIBb09uprGzZIs74mjnpt0KxqQeEFVOvegxlrDnTeuJqnV67vqNUaNHSA76BYfV0ifs7sgAcG3ooHZU0Wh3oke4krG2DDQYNZfBns7S+J36pDf6eggtt2j2VerI0oYXfRFABrIcD7AWOKuQxJB0T3mdC3ymIcSlUc++EH1wp/JtC;25:ICvY3c0D3pxAqx0YEGkITMRlThcrJ/VCIN66xA1ivJQqhVSWY9SqGNhkTw90Dh75FY7vLiuERU7juteF/mTHdie7xnRj3Ss+j45ES+YVF++JRV/SNMbD9sG5qytZQYMCY24Cs6LsOMYAyck5BKCGRenHDQH8nd1QgmLL1xR0QICJi8AIA+Naf/J68Zu/uVcShDABVUpWKDAuUH8nR2tMkrfXdkaxI3qn/ag3UV4o9Ss4Vz3jDs3iSqp3T5mXnloqw/UxRTouAdXffIwsLlsqPfg9SqQT+KhR4b02b4eMMp3jTX2kMM4ZW36/bOb+LiL5pP1jpClHqi3W0Aj6PX5mTQ==;31:O0CYD+sK1M5pSa8tYTC4Gat+x4AtolOpX+IUrUScceK/rsJ/tjWglivXyoBO4AmPmonEnXYPSQDhdMy5kI5G7HbxIemB4WFseam3rdL0HrxOUD3FdVUuqMjJNDtdunY6OjIiwvt09GMe6pwxJ2EruHRAkAfMZJBdBWTzxMK2wbjDUS1EzvlxoAhUZ2HWy0ubjgME4uBrBw5X3rcJYL+SAsqy+7fCuV80BcPciUoJJ8M=
X-MS-TrafficTypeDiagnostic: BN3PR07MB2499:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2499;20:YNcD0j/uEINbMJ1N+O2/x5FMoF9kEsGpQ+3pfTz8z46Ojkd44FclzxYKRZ9Li5DCUoCDNO4La2DyQ4PUXRSN4rmTxriB+SoJz53UpLi1mfiVe6kLM7qguHDnd2vLIDBP1Po8RVUF1Q8Cdor4bA6QS28JNLKZp11hCRfUH21Ai3DAcKX4P0AouwgmBIYk0rXY9ksuDMzovlIrvPmNbRM0CLnPkYZFnCYQ+24bs44R9YPwWh7pJ7FWCef90VlZjkMiNilloLFHAWGnztkjOQWNvx8LUaECC33F/3c+H13JG6fr0QG61SwRth92bvPCwAXlqT2QRu0+RQg5XOiSssyZwE0pfTGvTNqsgkhwevyI9aCMtEQ7aZKtk85nilePdAV/pB79v2TxIXA5nkM8KkYpTrPeG/CF9IwBeFzQYv5Y/hHUCi5wuBa88zXgrZRn93qQzZL5UK47c/+wBHuKppvGlisV8TY3FuMpLizkGLmdDigNGB/PvLWWaWK1zlHoH1XibGha4HlSw/5QpsxwgFA3FEeIdV1GVRtW7iAoN9wU/Gl4p+2i+Lyx9k9wGx3OZz/xqH2uTin72UesbUteF00US6uxKL7lwlHsj5ffLt96QSc=;4:UIZoGy4ZB2bjvoC2GTxmV04Xgguykp502UgS1lDS+xtA+9gP8u6GmtdKnhmU6gHKqbnC4SEhPTe9aHqgf9BnSesjreMnFi8+ZmldsixxMCLI86QLyUDFXVZRMfJyjH1nb57ie0L0QQ2sH1YVOZHpC2TNdn4K/jM7dFrNBW72HVPwvyxeL97nIfeJM/gq+fiaeo/+T9ObZqhE9X+Nn2UxkxKBYZLIoYwIqa4HmOg4ChHnAR1cYCL/u7JeFMAfpGMQ1nr4TVy2/VpYbv846Rhsaw==
X-Microsoft-Antispam-PRVS: <BN3PR07MB24991D53738C878E23AA97B091B50@BN3PR07MB2499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3231232)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN3PR07MB2499;BCL:0;PCL:0;RULEID:;SRVR:BN3PR07MB2499;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(6916009)(478600001)(316002)(47776003)(58126008)(229853002)(81166006)(50466002)(33896004)(54906003)(3846002)(44832011)(6116002)(66066001)(476003)(33656002)(16586007)(6666003)(386003)(23726003)(1076002)(6496006)(72206003)(5660300001)(52116002)(76176011)(186003)(16526019)(107886003)(11346002)(6246003)(956004)(2906002)(55016002)(33716001)(9686003)(7736002)(8676002)(26005)(305945005)(53936002)(446003)(25786009)(4326008)(8936002)(42882007)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2499;H:hc;FPR:;SPF:None;LANG:en;MLV:nov;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR07MB2499;23:rZhvqexItOXcoGOJRQQ3Re7Oboxz6Sz03rSg4E1af?=
 =?us-ascii?Q?iDDbKVmowI2H9SDBkvGAzcP56pzfcOcLRldCGs6uDh6VW2rAxZHuVyByTYWE?=
 =?us-ascii?Q?OkEMrHkXBzWzAudmTzqeEtGTGFpOCOtTHbvPjFgZ1kcwMh4fwrhG/4AG5ZaL?=
 =?us-ascii?Q?mwYOfMsUi9z1wfc9XM7vGxkgCk38qy99NTOQ39cTlsPrRQcUcyDO2gJkK7+v?=
 =?us-ascii?Q?SEXh+J7Gw4meBOM4UoJi8f+gDnmoczt6wbLlH/GlaSLF74ScTsRgsaHXS0nc?=
 =?us-ascii?Q?JdRRadCUH92jxD3drYPtMkAiZVPl++QFS38tmWEGn8+YGgM6T0a0bxjtADFf?=
 =?us-ascii?Q?GP8WqM+NajEZ+f6tBMoS0cP9tCZsU8gmzizxSsr/kK2HaHFS6HjSD+Wic5Xf?=
 =?us-ascii?Q?tDuetmxt7gcx9gXcmVRnwwND3VxKi8kna2T0srTd1TcUf+NCNJd8F3GWRXwM?=
 =?us-ascii?Q?aMv7S/6yxLKYR4Prf5cZP1dANxpV+j2yBrp2ISqFhpvRAg4rjgRBVKDP6neV?=
 =?us-ascii?Q?8+41BiJ/N1gFbLHXeqacBfHVG9RAFSpefQNB+jXedPwpMZFbJV/SHhGodT1Y?=
 =?us-ascii?Q?4WAn/pLDQQJJ9NxcwDT/hCeBG9bX9uL4MGot7WvZbxlHYYbE7e+Wgdazavbg?=
 =?us-ascii?Q?WEPtNM0m6y+9JDosuloMFvTl+2EGXAJXqTJ0raP6k3efe5HiyFUk+lQY3h70?=
 =?us-ascii?Q?zyEfiNU3nzf4UFA5BWsjWfSSCwbDS5WhauuF/PSFqrGdFn8zIj0p+5VhWGDq?=
 =?us-ascii?Q?7BUNPQQ59tq1A/RExzIYLeKIgZ7fh4i038hABFNnrus+uiUn/130VOyA8Wza?=
 =?us-ascii?Q?geY7cjGQ3T0CZ8HITcE41th9T31ifaJYw+733jHNcsmAP/jth2laVThkh6/Z?=
 =?us-ascii?Q?3p6vSTGx6rFeqyCO5+sX0ky+IHDXmAtnAaNtBIBENhPhPZxYhGEOvGp5VGEy?=
 =?us-ascii?Q?3ajmMU3eqUcuK5i7MXZCmIoHdEUqU1PjSA57MvawMufScDmw49sxU8vfENJT?=
 =?us-ascii?Q?vplYLoBqhafJWIF1KIUW17eKEeHy6xxCwol/p01poTOkGOU/FgRkJa94aKAx?=
 =?us-ascii?Q?9l8/ukHBiD7YBvSMM5MC5IaL7FscrnZqN3WZfp+1jmlikiaAbU9BER3DnUcY?=
 =?us-ascii?Q?73dY36NRkDZWA6N5ZX2KDSIbykndvbSYpPLb3ly5PQGWTWAhaZDifDsmITi0?=
 =?us-ascii?Q?CdCi9tKOycZxRHHc5KIk4E0pwRXJm/3JWOB?=
X-Microsoft-Antispam-Message-Info: y+xleT+0kt4FeL7yCSA4MxfY95Wggkj1u/0S2NY+N2Id+eBP1i7nHbh/XfpiqpEgd/DHMor3jaxrI+gfdZaFcuLl0JdDiPHy9kHiAPtZG+2LvqTW87n7efaYOr0r/5xN/TmM8zb0ENTSNoSRfbwg8n/PFeJA7hD2D8tL8YvY1JS+B7HMmcmqK6MvyWg6gQ3f
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2499;6:HhRLfFXvcNV6GUzrc5rA/c7szQnxftrX1sbx2+5uXP/rPZ9v0dst+YFl4q8OJXwxnG6gA13Y0ldwwOZwvK/zm7IZMq/upB7jktJUh94u+WMnNFnmo1l956BVFPezeQuj3SEzPM88G2b4uDgFaR/SbTPt/6jE2/oE6lolNn6iDPqUPlPouoSP6PnJhQhbZq02+zbljEz5jmmmy01wzZu5RAVmHn/vY3osD1/yF7m3/hTsGi6owjP4x7c4vBYl6tM4QOV5r0koFvqZqPb+3DioEbZH+d3S/8oLKBIeyDrc+5wRgwkldPdAot6M4AOAQZs9G/BZuIm6ADzbkxKWXb8y+6zjT+6iVxOblmASNvGGyqkhQuGX1V3CUYLca5SyQOAnfIN1jPLiaxn2kpZ6XxTw+3fVepxMpQmMnNhGKd+YEiLN017YB+PI/MBa/uPnuzlzJm9JeAvZJlAFKJXaPAvQwQ==;5:exwkWXA6OBl8uHzP/uh+z4xJjWAAZjEG+gLAIaCGj5tQqcSyZRiHjuYjiXXtfRYh4FDvdBppWKaDDkIb9osdaKRCBbbqKC9jd01dArDfUT35DKRub9vkXg38TD5rDdEks7z3Tu9ezWvZdp+559/0L/1jCvTMT0lYqLJKTgTtMzI=;24:0+2VSWzyoPTgCPfsuocIAcey5jsG/F4e0vNkGXPoe2UjrDhbDHnUz5eYHiQvRZB3aGxdiGWR7KbjDYQAzjq9CLi+c/CrFzCHEQ+hnoxBRvg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2499;7:2DUgHOhri0HdLJr9mEKszg/A++EdnAV8p8k0qct/LMH39uVyBaslAN3+9OdK589zvPNyTTeK5Hrw8mZvg2TrpdAwmQcuOhPAFzTTMPxOBuMYrZTSFxnXj25DwK3NL9s2m8IlVjjSsaW7xnKg9oUVfGZTjl2Qf27fdwKwHJTCmb2LdeMjcV/i3vsX8T1k1uoE7tfHVtk/l2tV/g1A3UsTNHaRfBTt18V5aoVdc/gDalRLemRDfRKvxysJDpTptSlu
X-MS-Office365-Filtering-Correlation-Id: 01d4ed12-f0a6-4eaa-f6b3-08d5a5ecea1e
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 11:58:49.0126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d4ed12-f0a6-4eaa-f6b3-08d5a5ecea1e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2499
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 11:42:11AM +0800, Herbert Xu wrote:
> On Wed, Apr 11, 2018 at 08:28:32PM +0200, Jan Glauber wrote:
> >
> > @@ -1362,7 +1373,17 @@ static int test_comp(struct crypto_comp *tfm,
> >  			goto out;
> >  		}
> >  
> > -		if (dlen != ctemplate[i].outlen) {
> > +		ilen = dlen;
> > +		dlen = COMP_BUF_SIZE;
> > +		ret = crypto_comp_decompress(tfm, output,
> > +					     ilen, decomp_output, &dlen);
> > +		if (ret) {
> > +			pr_err("alg: comp: compression failed: decompress: on test %d for %s failed: ret=%d\n",
> > +			       i + 1, algo, -ret);
> > +			goto out;
> > +		}
> > +
> > +		if (dlen != ctemplate[i].inlen) {
> >  			printk(KERN_ERR "alg: comp: Compression test %d "
> >  			       "failed for %s: output len = %d\n", i + 1, algo,
> >  			       dlen);
> 
> Your patch is fine as it is.
> 
> But I just thought I'd mention that if anyone wants to we should
> really change this to use a different tfm, e.g., always use the
> generic algorithm to perform the decompression.  This way if there
> were multiple implementations we can at least test them against
> the generic one.
> 
> Otherwise you could end up with a buggy implementation that works
> against itself but still generates incorrect output.

Nice idea. Would a crypto_alloc_cipher("deflate", ...) pick the generic
implementation or how can we select it?

--Jan
