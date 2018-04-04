Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeDDPl6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:41:58 -0400
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:59316
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751447AbeDDPlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:41:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Wed, 4 Apr 2018 18:41:36 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+6887cbb011c8054e8a3d@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, syzkaller-bugs@googlegroups.com,
        Noam Camus <noamca@mellanox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: INFO: rcu detected stall in bitmap_parselist
Message-ID: <20180404154136.p7aeye7657q466sq@yury-thinkpad>
References: <000000000000edc3690568cc95eb@google.com>
 <f1a0af0d-44c5-e938-b48f-0bace885f0a2@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a0af0d-44c5-e938-b48f-0bace885f0a2@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DB6P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:2f::29)
 To MWHPR07MB2912.namprd07.prod.outlook.com (2603:10b6:300:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c54f4f8-318f-4d4f-dbf6-08d59a4295ea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2912;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;3:7tVF/NytVCYohmF7ybDavTkNOeNV1ImhQlFEJpHn3Fz8eGA0LqOYcuM+cbevEM11SEm3GCY/Mf9DGmRs4N4hKyqa5PAtQP5HAEgZlTTvZUkBXr+Zkh/epYm08vYe0XL+VZjNLy2zk/JxXllAuPGu3UOiqXT/GmRmIEvIN3SQVjr15eXhU5Nr2p2VDlwuZ44vmfMzlu4g1TQBdkM7oIOaHIlDBWREZ0/+LdntQG8wGQ2uY3HFHDx5yBRSOTHvZ0ut;25:hdPpubTdCUF0pIlTLXZaRB5Ykawb1dF1JrnG7nzP77z8mqZ3O3OQwBq+Gr7Qxx0r5lTT7uU+Ygfe0LOzUaEaE3L2wpDL14L8uWTC6FqS6c9A3c9WiC1+pOG4qk8CY4ttTgwd2oza4Wg74sOC3i4X4FpTqSy9OPaYd7TdW86F870KxQDYfK+2EG8uzx8yhN+KdYmXzf6EjfwNp9F+DAAaZ3mmeBId+waUNA8VugOkO/GUpFegKb3Vx/qW72sqkCpR9GgJ+Dfx6HmWHf5HmZaAIse1HU9bzhxxYrJqZd97QNUm+2a7SOPUSxKdOYmvdeECKPVfLuPmYMJO48G985Z3cw==;31:dGFpXoDhFmIVjpaP4nQg7gZ+ZBba2VIcnVE64OzYJXAR195hYe4SZ1YM9kUtAMxlgaHmTzTbQsuNuGIf0LgdvOZOpt8VwBUa3mBWAJStrEG3m4Mdw3Xku0hBrMTWvsydNDIEHNs9jXEVFEo3hCo6D1H53QQcinjS7uTE6Lw11m/3jC7MSGiB/Zl9ERlGiPjfsBa99AXSilw7xqrfHNPGnbElKQXxg4br430U6Ax2VTQ=
X-MS-TrafficTypeDiagnostic: MWHPR07MB2912:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;20:ro6SAL4EliWWPpnNT+dN9Y1b0hvtMc8fTAgMvo1Ahh0pPvOdhQd6+48CgaeqJCPr8KLOYw/PlYnOZSr7UmchIqtxDyfs2MWKXC7Uo0CBdIOWU6DLOGV3YtfCS63aKzFaPw1itbfjGAT56tqzusAvwhJO52PjIsTWSBxvXfJQauk5pxu0+5XTzmWbGzAVvpMMml3YINvjnYisFq3B0z5cbpPYcJoetgQQk3WBkDHbDlsG12pVWQr5coOKu3Ax72sy4k+nPZi97aGex7jWN4IXRwgWjWp08GDH7xmj5QPU2wU3P43Sw3+LcxPU7V7yEXx1vIsRlk5PWWAISWIW7Va7mgYBCQWIY/Vnhw7akmth7/UxnclWxhSwzZfxx7iS3/qD7tYl+j7JmW03WaPkEne0X8iEpOYVELIbMDIrDzZLbzg8vmRaU5hd4Ba0YGHfP8yNdV3KPBmkhXa+1J3gUejXUoPfZrMyIZ/ylGJXl8KWYrXXpsv6JXDsdvktVc3ZLkS6YahoZHa4YAhCNeG/t/Ms4iM8hmKcMDDM09O0GLJptGxNQGVyV7gK3RP4CGfBfrr5fqulk6pAkbwP/49GqHRHHmx/bfDW4rnhV4pzvJoSWl4=
X-Microsoft-Antispam-PRVS: <MWHPR07MB2912F6298C71A2EBAADF4899E3A40@MWHPR07MB2912.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(274141268393343)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR07MB2912;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2912;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;4:sKRIXFeeb2n8xeUI1LVLXkdeX7F9R+hNcqbnu30Nlcl3I0Euc8209ZZo7dY9mT/1/hdmRoJkoRFbo+T2DoeEjUcCfya420e/qyQ8jdKpyLMpLf4n3jp1dX8EJlfCae9zu21D+CEeJWtxibLwXYPLGP5A10IOYFuMCurl+UocyOCOH//azxpqJOGw0joNReF35E+FQYC6xg9M03ZVJXmYOulzH8XD83DAULI6eynxTkCrAPZ8WauegjpfFNyai7rmTg4pjCUjDa35b/n/8HtHnOikknc23EfYiuuRYuk++vfjCZD+ahiaU1FK/IwUUU+BAysHkDSFOVK8AR+IsQBI7b5nok8mUdw+mnbA24LlmONvxQzzU82xIBoR5n0ehDEN
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(396003)(366004)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(51914003)(478600001)(33716001)(81166006)(305945005)(2906002)(7736002)(25786009)(8666007)(45080400002)(3846002)(7416002)(4326008)(76506005)(81156014)(23726003)(486006)(9686003)(229853002)(8676002)(6306002)(6116002)(105586002)(8936002)(5660300001)(68736007)(76176011)(33896004)(6496006)(1076002)(106356001)(50466002)(97736004)(6916009)(316002)(26005)(6246003)(47776003)(66066001)(72206003)(956004)(386003)(11346002)(446003)(6666003)(53546011)(476003)(966005)(54906003)(16586007)(186003)(6486002)(58126008)(53936002)(42882007)(52116002)(16526019)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2912;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB2912;23:g5ZPs6OQlc1K93AsKmWJCFm/IESXeKUtz40VU5UGV?=
 =?us-ascii?Q?JZ2QxPbQqKhaoy+7I2Vob+2+2XMip1esrMzsZq4wzyl59YR4QB0G1+gjjNwx?=
 =?us-ascii?Q?ZiPaG8Q955wCD5inbpq4VYKo5Q5GbrF5tJCXJx/kmStIhUhlNrb+KBrgNKvE?=
 =?us-ascii?Q?bPpLAbuawwo4T1FbWmavd+htH1lJoCsFn6B3lf/Nsa2vCxMlSTvZNtHO2Xiq?=
 =?us-ascii?Q?HhA39qDnWTRqimup9OQkDMNXnIVA9fx+8UMqTDVThebZ+u/8OrvkUGLMe/Xd?=
 =?us-ascii?Q?dLyboQlFkVtLXAhcU4QVpxgXA7pZDvFZo5JDxsqSG7PVeuqS+lb/j+r6skHw?=
 =?us-ascii?Q?h8pmRn98NB3XH+9nMuAZRO/K3uog8YpyJrirFPRuL5MMApkY9uTjXbfC9MJe?=
 =?us-ascii?Q?BoUFC5VIVO8DIoN6UTOyU/mnwqmrXMakxemV7JM+uXDtW2QStm00Elj+Z+BU?=
 =?us-ascii?Q?tsRPVfkMWI1Joqz+tSgYr/s5w+ccteueFpjUprPU6WwG/W6RhMCjMD9Xr7zs?=
 =?us-ascii?Q?wu89JQ2Ltmx8xEGwYjqh4+B/XsdEKQ4ZDpDZ5k0x8VxdXkFIKdbcEmKp6HtH?=
 =?us-ascii?Q?w1H/+xDceiW7fakzZSKnkT6K4zxmE4KuCP7K3AlvziohE6s4clE5PF9hIvMR?=
 =?us-ascii?Q?oFPhY01OxgfUQ2sGqQqgf6OhCJDx1CEHZFyxG8wOZWc8F4Er9w1PL3ks8siz?=
 =?us-ascii?Q?VczqRg2rwVGlM4IxkkyOnSVV0KCE4Hn/9zgTDZzTo2PzVtucm6Lz4PYqrMRP?=
 =?us-ascii?Q?Fl9xEsl75xsFfPfxHxg59zUXTzZ1ZjGIZV1Lh97Y8ZLjxUe45KR4BeZ2vS9+?=
 =?us-ascii?Q?zrSt0+/M2yFEO3qDE8sCGDAUJsGU6AvlTWZBJ5oz5yZifnBh/VNjbyEpW2jk?=
 =?us-ascii?Q?PUPSF9Ifnbhw1qo4ZkXZnOmSvYUj1H4VU8tF0dRX0E69zi+GS9jrNldmFxYp?=
 =?us-ascii?Q?ib1S0Lcu/QHvvWJn2mma06SRUvF/0bhBd8aWk2XvkiBFXmG0+bkqFvY/PPmS?=
 =?us-ascii?Q?uKTqTP1dj8n1qwR0gQY4VK7mRjq7IhMKRYA9MPdYaYf9t3/UtwMczPUCSuw+?=
 =?us-ascii?Q?DL+bK7a4EGT7Lz6WtjyUCGqoDHj1s9GAzyReyh/ui3i6NsRuGM9ZT+1tbrzL?=
 =?us-ascii?Q?mqdspp/dZ+AWHmJAvpRhJ85qsyroiA+6yt68spMKcTQD3sYbRqhYloU1WqET?=
 =?us-ascii?Q?H1Yps0Xkhr7QxYozMvby2uTwA7zHaYprbgpI1b1LhWe52kPBESDPnU87U9bu?=
 =?us-ascii?Q?b+EZM+F/FshEWCDM0MYmRNblW/Sepx+rthCGXedE/h/DTQO9IKy62IVnRYNo?=
 =?us-ascii?Q?lo1/6uwSzeKprQmjX/f5xa2yHeKDyaV1K9HLTQA59MIUKiCjXMOSkQrD5V2Y?=
 =?us-ascii?Q?7Io0vtm6/BB7zJ7P0SaychKh/ahNY7RR5+SULOZLru9DEpSNXUfrUAJfS/dN?=
 =?us-ascii?Q?M8Tfvuh7tqRg0aNILlPWE6QHAKss5fFhwrAmCt5qpX73pnGhIOOfqa0DJmpX?=
 =?us-ascii?Q?Ix3saW7W6TqhA=3D=3D?=
X-Microsoft-Antispam-Message-Info: pcS+Z2ozY+zR1KTXm+c0364FT2dEp0wCZp42RV0Si4BKTkH0pnHDZgjISYXmPFjltHKdwK8yTiaXmvULfSRtehpES8GG1EI4yP36Qilz+sEz/GnYDVgs/bgvZ/EasXwC7mHxu+5V8vViyTNApPKN9cD2iRGtVJiIdEy4INwRsyJC06kJ9PqJsQjwnGmcuCvk
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;6:nYBpwhrb6mAF0IRTRkpES/U5cYkv7tb5mo19e+A+KfF4Zm6eElpr/cXCURJLROiF6Al4N+vXEyBYeylAIpjokCPObwONxhWsBzWBfg/R/J9XMpModowg5YXG+2XdfyvBn3eMR3yiJluQ7w8ihFvi2pM8wRESHg7nP1goShTAF0lz0YnPR6W7Y8grFAOZw0EDw0tyCIiMPoghHp+TUYhSsWC4rL71CZikrGiSJY8KMDuqNWMh+Qx3fRZc3DMp0lVLCERqBcIhOK+mC4ha7bvx3kuXovkm0W6n1IaansCTu3H6whuiJbs4GGMkGM6rmMLcIz4b03Su72NzPV99ZzDxD02co09sDiO2uTfJ4LCYeD9wqJPOmPOnf+cnPlN24qPKX0jLxPLpLG9DtdqW+J2Wq3r4UsswOgHoG4oykb+SWDlCeeQMYGNyN+HK49awEkIQSf4e/dbwcVM8k4NdC90f4A==;5:lpZemumbgvBSekb8BU60gmRqKA//636fpC1tw61HF2Hfdovg8UrUMvHit+TIrxggihK3EWdrTSjcGtaSiRGplzznlAoV7X3QUaHw43BHja7RFjIBoifN2RJ3D/gOjJbijX1iimeq5R27uAb72sYuLHOR+aniO2rjRv8GahrRYm4=;24:aR6sVrnxGmMvfYm+qOO3Z3j5WJNpAyaG2+5+rRBOco/Flj2t7CH8r6z247HuI3Df31deC4lRPCEmlLs6hJoKyb5KuyhJkzwbCdByLUcwhf0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2912;7:B4jUv7+H6E2+1LBw7Nja0ub6pygwTlftLuanXRMeOjgCFO4YUneNwV3e5zv3/kI4H6UgkgSM2TDZuvTIPcO9It7Ytu5BzhoZoo/AiLwQ/C+kZ5jZlvC/s7EPDOlzMqPtzu78ZUq3dSk0Z/6wIgAyzOWGZUD/nhzhGTA3PEtFPVNYuF6Qg/1BizcwlIm1S8JemO0WOvbQa2WW0lLvGzZMG2eZ7Hu6If0KKN+AZPT7e8Nj0TLX6JBiU0DGss2L5sJx
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 15:41:50.2133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c54f4f8-318f-4d4f-dbf6-08d59a4295ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2912
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

Thanks for the patch.

On Wed, Apr 04, 2018 at 09:21:43PM +0900, Tetsuo Handa wrote:
> Yury, are you OK with this patch?
> 
> 
> >From 7f21827cdfe9780b4949b22bcd19efa721b463d2 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 4 Apr 2018 21:12:10 +0900
> Subject: [PATCH] lib/bitmap: Rewrite __bitmap_parselist().
> 
> syzbot is catching stalls at __bitmap_parselist() [1]. The trigger is
> 
>   unsigned long v = 0;
>   bitmap_parselist("7:,", &v, BITS_PER_LONG);

Could you add this case to the test_bitmap_parselist()?

> which results in hitting infinite loop at
> 
>   while (a <= b) {
>     off = min(b - a + 1, used_size);
>     bitmap_set(maskp, a, off);
>     a += group_size;
>   }
> 
> due to used_size == group_size == 0.
> 
> Current code is difficult to read due to too many flag variables.
> Let's rewrite it.

I also don't like current implementation of bitmap_parselist(), but
discussion on new code  may take some time. Can you submit minimal
fix in separated patch to let people discuss your new implementation
without rush?

> My understanding of "range:used_size/group_size"
> is "start[-end[:used_size/group_size]]" format.
> Please check whether my understanding is correct...
 
My understanding is same. Can you add it to documentation or comment
to function?

> [1] https://syzkaller.appspot.com/bug?id=ad7e0351fbc90535558514a71cd3edc11681997a
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+6887cbb011c8054e8a3d@syzkaller.appspotmail.com>
> Fixes: 0a5ce0831d04382a ("lib/bitmap.c: make bitmap_parselist() thread-safe and much faster")
> Cc: Yury Norov <ynorov@caviumnetworks.com>
> Cc: Noam Camus <noamca@mellanox.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  lib/bitmap.c | 183 +++++++++++++++++++++++++----------------------------------
>  1 file changed, 78 insertions(+), 105 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 9e498c7..9cef440 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -485,6 +485,58 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>  }
>  EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>  
> +static bool get_uint(const char **buf, unsigned int *res)
> +{
> +	const char *p = *buf;
> +
> +	if (!isdigit(*p))
> +		return false;
> +	*res = simple_strtoul(p, (char **) buf, 10);

In comment to simple_strtoul(): "This function is obsolete. Please
use kstrtoul instead."

> +	return p < *buf;
> +}
> +
> +static int __bitmap_parse_one_chunk(const char *buf, unsigned long *maskp,
> +				    const unsigned int nmaskbits)
> +{
> +	unsigned int start;
> +	unsigned int end;
> +	unsigned int group_size;
> +	unsigned int used_size;
> +
> +	while (*buf && isspace(*buf))
> +		buf++;
> +	if (!get_uint(&buf, &start))
> +		return -EINVAL;
> +	if (*buf == '-') {
> +		buf++;
> +		if (!get_uint(&buf, &end) || start > end)
> +			return -EINVAL;
> +		if (*buf == ':') {
> +			buf++;
> +			if (!get_uint(&buf, &used_size) || *buf++ != '/' ||
> +			    !get_uint(&buf, &group_size) ||
> +			    used_size > group_size)
> +				return -EINVAL;

So this is still not safe against "1-10:0/0", or I miss something?
(This is another testcase we should add to test_bitmap.c)

> +		} else {
> +			group_size = used_size = end - start + 1;
> +		}
> +	} else {
> +		end = start;
> +		group_size = used_size = 1;
> +	}
> +	if (end >= nmaskbits)
> +		return -ERANGE;

This should be checked before we start parsing group, to avoid useless work.

> +	while (start <= end) {
> +		const unsigned int bits = min(end - start + 1, used_size);
> +
> +		bitmap_set(maskp, start, bits);
> +		start += group_size;
> +	}
> +	while (*buf && isspace(*buf))
> +		buf++;
> +	return *buf ? -EINVAL : 0;
> +}
> +
>  /**
>   * __bitmap_parselist - convert list format ASCII string to bitmap
>   * @buf: read nul-terminated user string from this buffer
> @@ -511,113 +563,34 @@ int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>   *   - ``-ERANGE``: bit number specified too large for mask
>   */
>  static int __bitmap_parselist(const char *buf, unsigned int buflen,
> -		int is_user, unsigned long *maskp,
> -		int nmaskbits)
> +			      const int is_user, unsigned long *maskp,
> +			      const int nmaskbits)
>  {
> -	unsigned int a, b, old_a, old_b;
> -	unsigned int group_size, used_size, off;
> -	int c, old_c, totaldigits, ndigits;
> -	const char __user __force *ubuf = (const char __user __force *)buf;
> -	int at_start, in_range, in_partial_range;
> -
> -	totaldigits = c = 0;
> -	old_a = old_b = 0;
> -	group_size = used_size = 0;
> +	int err = 0;
>  	bitmap_zero(maskp, nmaskbits);
> -	do {
> -		at_start = 1;
> -		in_range = 0;
> -		in_partial_range = 0;
> -		a = b = 0;
> -		ndigits = totaldigits;
> -
> -		/* Get the next cpu# or a range of cpu#'s */
> -		while (buflen) {
> -			old_c = c;
> -			if (is_user) {
> -				if (__get_user(c, ubuf++))
> -					return -EFAULT;
> -			} else
> -				c = *buf++;
> -			buflen--;
> -			if (isspace(c))
> -				continue;
> -
> -			/* A '\0' or a ',' signal the end of a cpu# or range */
> -			if (c == '\0' || c == ',')
> -				break;
> -			/*
> -			* whitespaces between digits are not allowed,
> -			* but it's ok if whitespaces are on head or tail.
> -			* when old_c is whilespace,
> -			* if totaldigits == ndigits, whitespace is on head.
> -			* if whitespace is on tail, it should not run here.
> -			* as c was ',' or '\0',
> -			* the last code line has broken the current loop.
> -			*/
> -			if ((totaldigits != ndigits) && isspace(old_c))
> -				return -EINVAL;
> -
> -			if (c == '/') {
> -				used_size = a;
> -				at_start = 1;
> -				in_range = 0;
> -				a = b = 0;
> -				continue;
> -			}
> -
> -			if (c == ':') {
> -				old_a = a;
> -				old_b = b;
> -				at_start = 1;
> -				in_range = 0;
> -				in_partial_range = 1;
> -				a = b = 0;
> -				continue;
> -			}
> -
> -			if (c == '-') {
> -				if (at_start || in_range)
> -					return -EINVAL;
> -				b = 0;
> -				in_range = 1;
> -				at_start = 1;
> -				continue;
> -			}
> -
> -			if (!isdigit(c))
> -				return -EINVAL;
> -
> -			b = b * 10 + (c - '0');
> -			if (!in_range)
> -				a = b;
> -			at_start = 0;
> -			totaldigits++;
> -		}
> -		if (ndigits == totaldigits)
> -			continue;
> -		if (in_partial_range) {
> -			group_size = a;
> -			a = old_a;
> -			b = old_b;
> -			old_a = old_b = 0;
> -		} else {
> -			used_size = group_size = b - a + 1;
> -		}
> -		/* if no digit is after '-', it's wrong*/
> -		if (at_start && in_range)
> -			return -EINVAL;
> -		if (!(a <= b) || !(used_size <= group_size))
> -			return -EINVAL;
> -		if (b >= nmaskbits)
> -			return -ERANGE;
> -		while (a <= b) {
> -			off = min(b - a + 1, used_size);
> -			bitmap_set(maskp, a, off);
> -			a += group_size;
> -		}
> -	} while (buflen && c == ',');
> -	return 0;
> +	while (buflen && !err) {
> +		char *cp;
> +		char tmpbuf[256];
> +		unsigned int size = min(buflen,
> +					(unsigned int) sizeof(tmpbuf) - 1);
> +
> +		if (!is_user)
> +			memcpy(tmpbuf, buf, size);
> +		else if (copy_from_user(tmpbuf, (const char __user __force *)
> +					buf, size))
> +			return -EFAULT;

This is not safe against this:
"[250 whitespaces] 567-890:123/456"

And it will be Schlemiel the painter's-styled algorithm for input like:
"1,2,3,4, ... ,98,99,100". 

I think we need something like __bitmap_parse_get_chunk() to copy
coma-separated substrings.

> +		tmpbuf[size] = '\0';
> +		cp = strchr(tmpbuf, ',');
> +		if (cp) {
> +			*cp = '\0';
> +			size = cp - tmpbuf + 1;
> +		} else if (size != buflen)
> +			return -EINVAL; /* Chunk too long. */
> +		buflen -= size;
> +		buf += size;
> +		err = __bitmap_parse_one_chunk(tmpbuf, maskp, nmaskbits);
> +	}
> +	return err;
>  }
>
>  int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
> -- 
> 1.8.3.1

Thanks,
Yury
