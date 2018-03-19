Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeCSKwT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:52:19 -0400
Received: from mail-hk2apc01on0093.outbound.protection.outlook.com ([104.47.124.93]:9776
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932823AbeCSKwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:52:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shunki-fujita@cybozu.co.jp;
Date: Mon, 19 Mar 2018 19:52:10 +0900
Subject: Re: [PATCH] fs: don't flush pagecache when expanding block device
From: Shunki Fujita <shunki-fujita@cybozu.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
References: <20180316152256.2f4883edc3cb6b374bcdd448@linux-foundation.org>
 <1521183353-144817-1-git-send-email-shunki-fujita@cybozu.co.jp>
In-Reply-To: <20180316152256.2f4883edc3cb6b374bcdd448@linux-foundation.org>
X-Mailer: Cybozu(R) Garoon(R)
Message-ID: <0_14961900_1521456730.19987.cbgrn@bozuman.cybozu.com>
mime-version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Originating-IP: [103.79.14.77]
X-ClientProxiedBy: TYAPR01CA0018.jpnprd01.prod.outlook.com (2603:1096:404::30)
 To SG2PR0301MB2078.apcprd03.prod.outlook.com (2603:1096:1:12::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2642274-fa4d-4f64-9fe4-08d58d87777a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SG2PR0301MB2078;
X-Microsoft-Exchange-Diagnostics: 1;SG2PR0301MB2078;3:Vzc4dPYEizAKohJ0buj+5vvB8uyIX0x7sMQWZeO3/1ScKyxHQ5ea+hbbt5ovG6JnJjbiHGVNU6D8FUn6Dg+YxiYeVfNXPCJjzpC6VtHUq/k562OVChnj65jE4m5BhKMyyttE1sr/AXRbEoIzsQmGO7SpuB+vBH9BIc534p31YsmYOiSuPZhnuR6ybYBVh0/mfyMoMkrOcSXAiSN29Xp6Uni3GADeJ2s7RfSlzP2gqP3jABXXe88pYzJzIur9Mx4T;25:eDcpI6cUYhnTDiZaPFC3XQJyc9NZm0d4vWSN0nJYOe4VtXrUlaFfNbtsB4tefyqJTyqmxNLPmmFUC7Yqyt8ID5D/dZIk9wFpKs0/5ctSdyNg3ovySq2PPo3ecf7khpp1224WJ6fX2yeciRW16v5weEeiFYelB1MS9iIJNyeLh3Lpe/jOiFv6FOF7zWxPaZ5xFHQRF/GOjwmy0fnXLLl01HyzDo6Yb3nU7Uh3zldF3BUMBFqUiisVeNOn4CEPuLdkLaGJ1bMQW2nttcIJfeimcHoeFDxpLWvoJP6aDegqbHUbdn9E7aB9Ws3pL5NHf4phwZuJBvH/soXnVKJXAEYWoQ==;31:DnMyFW3yM7Z6prsMhAVvtq1Spx4pNVUHCi2IsT7CM6Izq9ffyiEXZIGjVvIRU6+MbeqS7e1v4sqUGQ5EdrrnaoX5NYjseI3JdNyZCpqNhJppJQQncfDzMor9qPalvbcCqzbLtGwEzOJ8FC7IuJClA/ytIYrokVsOzk3AEf/IHjzeXbj1oIdjG/HUUzcj2UbIALHWSV8U3ZRLZEOsoIQB5SE80YlGrjTu7GbcHgQ8Qt4=
X-MS-TrafficTypeDiagnostic: SG2PR0301MB2078:
X-Microsoft-Exchange-Diagnostics: 1;SG2PR0301MB2078;20:eBoYVaUA44uuCRIwc3wSPNYOY/ncpse3VPWEI7Xh1y64jrTsHvzZKWs1J8AH4JEzzUbBbaXpXlCjDVN9DK3uCm7PLbU2lavYrHoPfGJq/I5NWWFmPlQMRd9PaiPaclXBQ97BNV9ez6KXHRUIYvix6AgXufpzVjgh70xh8XxuQ8OawCQAhyMLfFEoaC3KSG4SDyVdIqK/AlFY59JTaHbudEveGSyUXihT22ypkKqKpk3giOzNh0GcKeSxu+VXStPBvwpPmP0XbxVbfokFae3qLu5LzA2+a/x6+ww8O9pineKEJsMnuPenI/iKTSfRCANHi/ZHbdCfGw5WivbaZ8aqe9UEr24KbyGk1ju2ggdoNGZgb6JEak87gCBckWGSH/LqsGJmwXOu005XwPxWPejBQWHodJphBdoE4Shf1OndEjVeH+FOM2j3ep24AA7DON8GxKdMJpIzcK2nnBr2Xv/RDqCj8PEEewOjwn3gqgb/wiMyHZjlNKOu41iUvN8+5geL;4:HUkTY9C95NvuCfgOAZMRxBEeSHBkAWsSWPyxaXStmuYA2ij1VwcAPaobIMoDx3K8hbFL70mLBja2/rrr/eS20gl5Guqmc6jO73oOB5lsVhUUwBrvvVip8l9teuqY1hA9RY6+4swyYVBkRM08MuQO8RblvbxSYI77aQ1kWYuNdXPJS40Cb3vOsGx6WHoi0q27SXCUgrA/fREV2bYaPc2sH98JEFZQ/KC0EFJaYMLZzXmi29HCUQVuOWZ3D1gpjrf5gnAjy8mc9GUwVhr0eGh2q20TDXr2RwvfMnCJyqSz1mzAVT4lBO6FfF1HKAc9yk9Q
X-Microsoft-Antispam-PRVS: <SG2PR0301MB207883DCFB82CCC7C403F192DED40@SG2PR0301MB2078.apcprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SG2PR0301MB2078;BCL:0;PCL:0;RULEID:;SRVR:SG2PR0301MB2078;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(50466002)(6246003)(53416004)(69596002)(2950100002)(6916009)(106356001)(230700001)(68736007)(229853002)(53936002)(97736004)(305945005)(3846002)(7736002)(6116002)(50226002)(2906002)(5660300001)(8676002)(23736002)(47776003)(66066001)(6306002)(9686003)(6512007)(105586002)(4326008)(8936002)(478600001)(81166006)(81156014)(6486002)(386003)(26005)(76176011)(316002)(86362001)(186003)(16526019)(52116002)(25786009)(6506007)(74482002)(966005)(341764005);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2PR0301MB2078;H:nat.cybozu.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-2022-jp?B?MTtTRzJQUjAzMDFNQjIwNzg7MjM6ajA2a0RlMnRYUTBLTkJ0aGdRMkZp?=
 =?iso-2022-jp?B?M0lmSUNzUWU0Qm5sL2I4RlJsbFdVcGMrMFRnNFBSTjJQL3VCSmRYd1Ax?=
 =?iso-2022-jp?B?OFBQNy9jRFJjYUp3K3ZrV0g0V2t0RzYranhSZFlYbmQ5d0JlamxZUzYr?=
 =?iso-2022-jp?B?NXkvdzVhNjRGWGp3S0U2Nk1Zb1dUWkJUMjN6TzgxSFduMzNSWmFhc2sz?=
 =?iso-2022-jp?B?cFdNbW1xUWdqRzlseGQreStBTzZoMzVCK0Yzc1JlNVBRbGJUUERqdmlZ?=
 =?iso-2022-jp?B?T0RSenBQYkNtdFM1Rm81cHpqaCsxL1UyWlJyNjA1eEpsMEVmL3BrT1B0?=
 =?iso-2022-jp?B?TU9mdFdraVZHNk5hVkQyQnZ3bU5qSEpZNWVqUHlzK09TWUh0QS9SQ1o1?=
 =?iso-2022-jp?B?SFlqNDgvVUpnV3MvVG1qVDdNeVUrNFdSaHcxUExtNlBMbjFaT1dMNHI2?=
 =?iso-2022-jp?B?QnVsOVd1VytFaTJVRk8zVE9TMEh1NWgzbk1NeFhOL1h2SEJNckVCYi8v?=
 =?iso-2022-jp?B?SVZ0YkVoM25iTnIyQ1dBTjMxay81emdxcHJOREJlaTQrTnRKcDRGZUtr?=
 =?iso-2022-jp?B?KzFhcVJuRWhTSlhKYlpSb3ZaY0hKUFdCbVBFdUxxT1BhQ25Ha01PTEhq?=
 =?iso-2022-jp?B?WGpJM0xiNE1KQVhSNFZjTHR1dXJ5ay9TRzUvUDRzdnRPaWNGak84NWZ6?=
 =?iso-2022-jp?B?ZWgyY25sWEh1TjRaa1cxL1JYVjJINHJMMHlzUzVPYmZKaS8rQkNLVzRo?=
 =?iso-2022-jp?B?bEszRzRvOEl1dGR1Zk5Qc3ZPUlYxUjFMUFdFWVVvZnNxdy96TVozcTRt?=
 =?iso-2022-jp?B?QnZ5a2E4ZGNNdnFPanNtZG83RnNEaXpXdVdnUWJraWlXOVMzaFNFbDYy?=
 =?iso-2022-jp?B?Mms4WG9wOE8zNElsazZ5emRITXV0UnF3enBLNFBVbTk1emYwa2NnUUpE?=
 =?iso-2022-jp?B?U0RTcG92SWNseU1lcmFvN0tyUUtGckpTMWhrWkNkeHdxL2d2bEJYVCt3?=
 =?iso-2022-jp?B?aTBnWjJJbEc3SHpCWWVValVxKzdFRkpuZkJ6eVdXQ0hRSXhMWEFxajRR?=
 =?iso-2022-jp?B?REU4elRsR0xqUUVDVFh1VlhaWTFCTTZrRkJUbUN0Uyt4ekdwcVFEM1V1?=
 =?iso-2022-jp?B?aHlsVkNFamlpaThoOGZxYlVKdHZTRXc2S2JzdXlRSkhHZTArSjdMWFJx?=
 =?iso-2022-jp?B?MnpQL2cvTTg5ekRRSld1Mm5mci9vdzVCcmlrRktmeElqQ09JRHFDMXZu?=
 =?iso-2022-jp?B?OWZGMmd1S09lc3FhZnJBWHU1NDMvVW54Sk10UVdFVXB2L011ZEdETHBI?=
 =?iso-2022-jp?B?RWZHRnBMbnY0V0ZPWlR5bkMrSUl3cFpEK2R1SThRSnduR0VQZ0Y4eHA2?=
 =?iso-2022-jp?B?NlROWGlFVUovY2lCVGE4a0FiczJNTDYrYm90b3IvQVRYLzBqZ3h6a1p6?=
 =?iso-2022-jp?B?RGNsUkJlWTRDOHpZMHJlU2dXbVJKT3FvK3RGRHc0SXJCMUhjdGFlcUJE?=
 =?iso-2022-jp?B?UzJYWVdwam5kK0lxZnJMd3JEQU5vQWxWY3lCVEF6bGtBWGJDUEovUkIx?=
 =?iso-2022-jp?B?Z1c3b1hEV0NQWjJUOHU1ektQR0tpNFFNVnEvVC9PYUJabXpoTlFkdDRo?=
 =?iso-2022-jp?B?eG53Mjlqb3J6SUFKYWtHaVA5SWtTVE5SYlFwU01OdlVYYzE0K2V5dnVK?=
 =?iso-2022-jp?B?V3M4Um05dzVQNXJTdnFhcFFZc21iUDl4WWpvUW1qaGFoUkFwV2IvVWgz?=
 =?iso-2022-jp?B?OVhvOU5sTk0zRHNtNnQzTEgvbnhFeXE4SUw5cjFmLzFWaGJyVkZsQkE9?=
 =?iso-2022-jp?B?PQ==?=
X-Microsoft-Antispam-Message-Info: 9Ii8kJERG77sVP9/68W+tfpsKqQXHSDhuJXBhWdtFXZiOQTGp3b5Jq9BNHBarBeOc18y846RvQhRHLSBc21gDqN7WQMZpJAgWgzUfwDeHrTZ/Jzz+EPbsEy8qAsZp7gvj9aBK4c686ynvmUgcD5Wm1e5gVcDYP21869RaEegi9yqvz1Xfzzb6MYldYdpJpZB
X-Microsoft-Exchange-Diagnostics: 1;SG2PR0301MB2078;6:4hV3qpJfJuTgUn6JgQj2FjvSBOUG2WsJPQeRKlTTn7+v8PvnGw9IPpbMqon9hvDgqfbbcUqaYYruOpRFWquN6aqv9I95EVbdt7/XsjPeSFwR7J/onjd6Y2jPpRlfKqwrqkMrzBUrRTdkVBut5d6lErkQJNnKMpkEqwr1rT7SlbhKpqjQGo/pyleHuhFOMl7uQN2qQJ/3HNZPfsMs/CJmL/n9x1zYPsv/vXLeqTSXXmJx+P1uUS89yIL9LyiYA+BSiXLiA76Qwf1NTUORR5ZkerJ382ybfNNnXtEoOWWnvgba8yhv/dDVul45jXjqZykGzinc7/9TxAlZAd9yMiu0KTFwIhuFfoCZ7EGZJ98vpo8wH9/ut5w/qVcdFbnN7Bksla5oQgjSIJoZ2omsK90BCisuIiFdo2zwmSGM5erYnGclVo7oRmXbBN722yf9kxUCTY0XboqsDBr/JvoHYt9BZg==;5:hr2Nkw6wR7lO83RmvN+6/rjCsjOUuHPmVYrhaB7SK/iyowt6T5dCYX2+LrrGq8iKBg7WBn4OauNZr0WVCVouzumG/LN8P2AgilYCwN//L3ARHsWReRcp4rY04q+m2T3BFYC8iBtN3JmJeXtflHq0mo1Z0CnbVpWdqcnIEUQQRT8=;24:SMdKr+JJS1gmOQgzIX5QQDB9jqlQBJt6wGVtkXrae92ZogJyc79GXytSX9fRkEsrqRXQV7xgPmkiU6IRpfD9M5yvFIXv3gHZFYxYnZXwsME=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SG2PR0301MB2078;7:utqzdE/62CY0Q8tk7MoOlwN2+ec2sxjFtUOZ7zzWfkXk0TK3BP4IKPcPeZbm1q5jxVKXLfxSno+ZdB5det1wg/MvtYPo9kURDPtJhFhgLVfVmzTwikK1u2NBHJrdtxXpvrSPRUSNe6wVm0C3DOt5xyDicfjo10vtpBqK6YTb/Tyb87288Nf6CdFi+/AH79/D7V2n//UTTq5NEsgRzOmhTYJ7IDpzU86J23xh85eAwvhDAlPPSIYGMiVSVJn/yjSo
X-OriginatorOrg: cybozu.co.jp
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 10:52:10.2375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2642274-fa4d-4f64-9fe4-08d58d87777a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3761f390-05f7-4386-9a0b-b6806c13b841
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0301MB2078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> On Fri, 16 Mar 2018 15:55:53 +0900 shunki-fujita <shunki-fujita@cybozu.co.jp> wrote:
> 
> > When changing the size of a block device, its all caches are freed.
> > It's necessary on shrinking to prevent spurious I/Os to the disappeared region.
> > However, on expanding, such kind of I/Os doesn't happen.
> > 
> > Similar things can be considered for btrfs filesystem resize and resize2fs,
> > but they are designed not to cache drops when expanding.
> > Therefore this patch removes unnecessary cache drop.
> 
> Yes, the patch removes the flush_disk() call when shrinking.  But it
> adds additional code which is unchangelogged and uncommented.  What's
> happening here?
> 
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -1337,7 +1337,14 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev)
> >  		       "%s: detected capacity change from %lld to %lld\n",
> >  		       disk->disk_name, bdev_size, disk_size);
> >  		i_size_write(bdev->bd_inode, disk_size);
> > -		flush_disk(bdev, false);
> > +		if (bdev_size > disk_size) {
> > +			flush_disk(bdev, false);
> > +		} else {
> > +			if (!bdev->bd_disk)
> > +				return;
> > +			if (disk_part_scan_enabled(bdev->bd_disk))
> > +				bdev->bd_invalidated = 1;
> > +		}
> >  	}
> >  }
> 
> Oh, I see.  It's a copy-n-paste of some mystery uncommented,
> lost-in-the-mists-of-time code from flush_disk().  Argh.
> 
> The world would be a better place if we could move that bit of code
> into a separate function, figure out what it does, document it and call
> it from both sites.
> 

This was an unnecessary additional code.
Since bdev-> bd_invalidated always 0 after check_disk_size_change (), no additional code was required.
https://github.com/torvalds/linux/blob/master/fs/block_dev.c#L1365-L1366

I will repost the fix patch.

Thanks,
Shunki
