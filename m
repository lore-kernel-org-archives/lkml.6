Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeBCEj2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 23:39:28 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:9048
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751756AbeBCEjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 23:39:20 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
Subject: Re: [PATCH] net: mlx5: remove pointless memcpy
To: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Networking <netdev@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180202154636.1624079-1-arnd@arndb.de>
 <20180202190600.GD9080@ziepe.ca>
 <CAK8P3a2gi4EC+0tEzoRQ9ojscmXgddrmgwtB=TfQKriszPVaLA@mail.gmail.com>
From: Saeed Mahameed <saeedm@mellanox.com>
Message-ID: <99c7fe90-824e-b32a-295b-b7cac3370801@mellanox.com>
Date: Fri, 2 Feb 2018 20:38:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2gi4EC+0tEzoRQ9ojscmXgddrmgwtB=TfQKriszPVaLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2601:647:4000:4586::87f9]
X-ClientProxiedBy: YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::19) To AM2PR05MB0849.eurprd05.prod.outlook.com
 (2a01:111:e400:8433::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 386a77ab-6a99-4020-2bc4-08d56ac0145b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM2PR05MB0849;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB0849;3:SGEFZJg2xxFdWdn8yQp+Gkh7mJDANk+ngPW/OB+9nGHtG593WyK7fJv//hKaq0mNLbvQwjKMvql9rj2kCrxFkvq7GXCMAIpLoenVLUfumiVfH+57KTyLzXb3QEIwwNl4vgsqYWzrx9PNGwo0WvIBhz9XM0a1EoUSPJdrU6TUmOZ8RJEAf49OHlj5vinryyFY2B52082RxvSCAY2e0MGXe0mENI9a23z8WQ6lFLHGY04o181iK20H3zPAkXwk2l2F;25:IL6mMrmTiebZPIEh6vsaqAwgWhYYur3KkpYFj4253zdyQRgvJp5miUdN3j+Yli5L5NbLE5jDr4AnWooRkqQVlSHltmdjQxK9XxniSxmqeL0XljUysU12zp+/6H2ZphwbJbKPf7uzuIUTZ+t4U6q39bhx1+Hmo04EDV65tPQVgVU7KJCwf7XFW+OKMkQdkkP9J4O4qOcZyVcuMh4cxNHbiTuDig8HLo4bdO05npoKV+Q38hqUCnAfNl8XxeWkouzgZflAk+x8U7ZXmK6BPuCj5UAxgvp9fQVxSEmAyGCz/R2qTTOhX+iywFhtZB+KVQZYge0mZg4gjT5wH3CrlhVzng==;31:9dp48VHiCW3Y5zvU7u7v9DwtKbu04vX6ykby/6CMaDleFcX8/kACyXgWyYiIviHr03xhTY/18QQPvCEgQHiqzi6DAhlXSYJ8aAos7Sxf7gcaeJSsMOkd4mARwmMxXsoYtpUGIkgkIZtJDHm4IOBqBg2kFW7fc9/feQC/DkyUso71p8iw0UIKVw9jQkqS4N7T9nJ2um16cy4zqUyPQ/K1E/Vvw/dK5Zl5hqCYT3m4N0o=
X-MS-TrafficTypeDiagnostic: AM2PR05MB0849:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB0849;20:DNPt4JnjxlH0529PMtbD0PSAHnnRyrWSZkLvZpc/5KtRzgyGeh6in+0H0JDu6IVwCqqdSh2gSDeizxDajvTqC7u2Mn/e6BHijX3GjrDDJrWGNBOR2P4MRxv1h6x235tXOiS+df8nno5pdiD2OMDAL7j+LU6J+PKalJyxpO0RXjq5ui/Aw1cL1Dn+k2ax8H+KMgsKw+Xfi1lzEaJ6E2mirEhzhKb+DjQ+bM5LxnfByI3cUHS/PEyxMudNH7tOEsa8PxwbzxY1TvDYn0BZM4KJkTrIE257W/MDRGKlCR3ARI3+KTHwJUgTDNQO9YoTabUugzeqoeXI5ryqd9tRG/eQT4FjtGTD8yvPWUCYn4BOVa4wUsrdRJ4smxXj5RystVeN5YM3vpsIhQYF1gvHxBwEYbgXgXyPPpBax3EZUNGNCyRJIQdMVc2G9WUmKZRtIhHFWYci8xOxdd3TQFg90p+cclx05RsPJbtDKSJlk8Pax4f2NtBB/MsgIaYKtWkRT7Sb;4:X5EHJ02WWYVO85g5hEhEkLNwEJ7J0iMFCJkljCwxyB8ubYomjNjtitbQxLjvB1JH4BSqjMOdyuPFBKRCl154fv+Fr8xW71ievWzDt+zW3mzigsapGEXzBAemCPjnMcIlCE+KBQAR43l1EXSxUY/GZD4zjfCf3XcL0MkVN3CGWSVJf0P4ZrqWDR78sneqbnmVGmFjje0dxjnpXOf6Wj5jGH9O7PcDxQNkp542Lgnwwyr5z5FU906Chcoqg2e3IC9Wvr4XmEkSK3xPghE/my8hBw==
X-Microsoft-Antispam-PRVS: <AM2PR05MB084955D85480AD3D0932DA39BEF80@AM2PR05MB0849.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:AM2PR05MB0849;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB0849;
X-Forefront-PRVS: 05724A8921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(39380400002)(366004)(199004)(189003)(52396003)(81156014)(81166006)(6666003)(6636002)(5660300001)(8936002)(68736007)(65806001)(478600001)(53936002)(229853002)(31696002)(65956001)(105586002)(83506002)(1706002)(230700001)(8676002)(2950100002)(47776003)(6116002)(65826007)(52146003)(97736004)(86362001)(6486002)(316002)(23676004)(52116002)(54906003)(4326008)(106356001)(58126008)(2486003)(6246003)(64126003)(76176011)(50466002)(25786009)(7736002)(53546011)(16526019)(59450400001)(36756003)(110136005)(31686004)(386003)(186003)(305945005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB0849;H:[IPv6:2601:647:4000:4586::87f9];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTJQUjA1TUIwODQ5OzIzOlNsM1NZeVRhZVdjeEVSWG5tTldhd0lmQk9G?=
 =?utf-8?B?OThLQzJMSk9VV29YUWtQNUtZbFZDM3lidldCUlhCWlRDQ0didGJ1OHlwNEVK?=
 =?utf-8?B?LzI3S3FnMmdSZS9kUG1SRlVoRjVUZXc3cXRmcDQ1WDRSN3lBYlZUczBtUHFF?=
 =?utf-8?B?Q1phWVY3NHVaUHlrQi9GSFFkU0hiNTFwYnE5cXFWMC9OQjloSUI5VUNzTDA1?=
 =?utf-8?B?RExSRlRqV0MvWEpVNU5rRnN1UmhlRjJTckpwVFdHZ09KSktCbHEyMExNV0dh?=
 =?utf-8?B?eG9oZmdVNVBHVWV1Rkp5aEhrMFZMTUtvblRuR2YxNFZZS3dYSVdZYldlem1E?=
 =?utf-8?B?ZnVoSGxFdzd4dVREOGhkVkN0YjNKSFMyQUhMKy93SmJjejltbTNUWEFDSW51?=
 =?utf-8?B?a2RXRHBROHFaenlZRDN5eVdOeU4vWEJhWUVLMHFaalFta1ZBUTNtcThMVVdw?=
 =?utf-8?B?U0g2TkNRY0pxMU5va1p0T2JEYzEzNDNwdDE4eHk4cUM0QS9EQmVjeWpLdlVP?=
 =?utf-8?B?dWllbXc3dGd2cHJ1RFVHeVJVMk5xcmN2bHYya0hvMHlJK0tSQXRqOGxUSW1J?=
 =?utf-8?B?cHIzWHptbjNMTjVBeWNlQkQwTlNUMDNvQXFMaXZuMStIdEZSSjExNWoveEV5?=
 =?utf-8?B?MGNEYXA2WVplQzlHOS9JbmdYOTNtK0RwYnRZSUl6amdNRW9mUmZWWXpwMCsr?=
 =?utf-8?B?NkE1MnFkakFNWHNjc1FnRDNDRU1BVUUzS0hqdXhjdlY5aCtDMmpiengrRm1m?=
 =?utf-8?B?K1dDdFk2cERhVEV5OEVIVUVpaWZqakxGNm9IczNLOUlxTXJkcURJV1g3RHgw?=
 =?utf-8?B?Rnd6amh3WjV6SlUzUnFaWHVOS3VwOVQweExtSFEyTkZiN0g5bExWdUJLc1hD?=
 =?utf-8?B?UTd0dHV1TEZJcTFNdEJ0SVVVT0g1a3NjMG5QNWRMWjM3Rkg4cEw5Y2dGbWZM?=
 =?utf-8?B?dG5qQnFNTTVuYzdCbXhIaC9zeFRZNW9GSmNVSzc0ZUc4WUdUM0NKdGZhWGFv?=
 =?utf-8?B?OU5MZ0NyT0FCK1RTWk0ybGE4Rk5Cd0dhTnZxT3JtaXhnelY4b090RjRIQ3Fq?=
 =?utf-8?B?ZFlZREQveU41eFJDSXF6cCtPM0oyaTd4UCttVEJjLzE2eGtueVFadVF5ME4v?=
 =?utf-8?B?QTNjd2lUN2g3Njc3Q0NIYUllTEZwZVZpb3JvbWxyallUUzhleUhJdyttNitx?=
 =?utf-8?B?WFh0c1c3V3hMTm5ySGxUYkpqNTJiZXBTUGVkVGlWTThJTU50aDVtc01qU09n?=
 =?utf-8?B?c1grWjhSb1JhbFBEQkpBVG5Eb3ZvUzh6THQrbmNrbVdOdWc1NmpMc2hoMkJI?=
 =?utf-8?B?ck5BdTlMSzFGTmkxSGE3THNTKzhxTXJ6a2RDY0xkTmZwUDZ2YVMrb0FteDlB?=
 =?utf-8?B?NFo0WllhcExXbjdDR3NzTWhlRGdwc3hnN1ZWRXl3TERVMnNwaXF4SE00WkFO?=
 =?utf-8?B?S2w0QXc5VHVPcFhkMmczQ0hic2lPOHgvUHZwMTl1YjBTcE9VR3BlbW9VdEph?=
 =?utf-8?B?RWdyYnkzclY2MHJOVUJYN3d4dk9SN1RvYjh3am1qcGgyRkNQdzFSYXR4cG0y?=
 =?utf-8?B?b3FPV1lVNEh6WU8wNEVvRU4zTXhDdU1xK1JUKzBlTFlKdFVqcXppa3U0Z1Nu?=
 =?utf-8?B?aEdkR0R4dFJlNzVyN3JIbGUydzB3U0lBZVFUczdNRHlSUFVMTjVpVzk2RWs4?=
 =?utf-8?B?RHlMUUxYcU1jSDQ5bnBURWpGd1pGdWE3ZkZTZHFaWWFIeHczM3ZZWlduWG4y?=
 =?utf-8?B?T1g5bmw5VmZuVDNKanNPMzh6WGliVDQ5NFJZTVJGYkZRZHdsbUpEY3RpYklj?=
 =?utf-8?B?T2pJakVUOStGeU52Um41aHhoUC9Wb2xIVTFyTUR1TFV2OUE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB0849;6:YaMjbXFj9mjDE7HWWB5Obo34oGURDvjnj4NgeloZn3PNyeabUP5W/8ILSPLD6gcMlEN+2DTdHxVyEkFzUev0WobGJnueH9N0IlbFTp6d5fRaTfJZQKdsQoKu5evwVMgVfuY9+Xeb+YNiZe6bQTCaDUsqfumtIEm62X+AnIx2I6/ofBidX202Pv5a0zV2bnhjCrMUqPYFP8RYpS+EEZrS+Jk+98Y0AhRG0J5rPkzAHMlVVh4mwfSpRg+rsU8CTLmYQhYKCLmZqmn+RHxS2Omxkz1lD7L4nZ3RfRVfzI2pz0fq9Uavh8u09opVy4rr5TOF9JhZkZ9NRunpu55LZvmuWicjY3N3dIP9jOfKSqYs8io=;5:R8NsrJ56STukC6fTUnpawbdu+k3ufARaykQyngQcVgCP9NYt30/qmnqBLfaaj85CNAxge+2rasMByf7GIrFqHWaxbBn6OZ1iv0AVgD4rDLv8lLuvQPLeJHvuG9cRT1LPf+2nv90NVQzzWR3yioFF87wFtEBS9zsJwghcwFxcEzM=;24:x4NyKA9jeNG0AhVJbGZ+r673FBcfxS6RKcdw8NJ7Pdn8BVSAqQLqRAV8j/wUG5bIPEBvv0eCnYdKmLbOgCdt9yWYTn4TgHyr6mAXmKw3ktI=;7:OrrIN4TSht9JosBs67sbdgf6eRDx8yfUJIxaljIJn9u8RDENqlgq3lYCOw6rx4CJjULN96j0vZ0YY1x8TbquTJeb03IxrFRNKT6rgqF+rGBjMZNgqCfT1r+uCfMP+I7fOL5gT3LRo8fOt7YcMkGBom0TWqv2kIRWeXbJ/E+Ab2OPiz+AjZCBPFNlcRQiC832vCpB6jCmhzMNbpX3TwX8kpNQnU1fgYtRXaS9hKBSAB5gPy97TuG2scpDofmf4NGw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2018 04:39:13.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386a77ab-6a99-4020-2bc4-08d56ac0145b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB0849
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2018 12:26 PM, Arnd Bergmann wrote:
> On Fri, Feb 2, 2018 at 8:06 PM, Jason Gunthorpe <jgg@mellanox.com> wrote:
>> On Fri, Feb 02, 2018 at 04:46:30PM +0100, Arnd Bergmann wrote:
>>> gcc-8 notices that the memcpy in mlx5_core_query_xsrq() makes no
>>> sense because the source and destination variables are identical:
>>>
>>> drivers/net/ethernet/mellanox/mlx5/core/transobj.c: In function 'mlx5_core_query_xsrq':
>>> drivers/net/ethernet/mellanox/mlx5/core/transobj.c:347:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
>>>
>>> Either one of the pointers should be something else, or the code is
>>> completely bogus. Removing the memcpy() won't change the behavior
>>> but gets rid of the warning.
>>>
>>> Fixes: 01949d0109ee ("net/mlx5_core: Enable XRCs and SRQs when using ISSI > 0")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Please review carefully, I have no idea what the author actually
>>> intended here.
>>
>> I think they intended to adjust the command return between
>> mlx5_ifc_query_srq_out_bits and mlx5_ifc_query_xrc_srq_out_bits?
>>
>>> index 9e38343a951f..75450f7d53bf 100644
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
>>> @@ -332,20 +332,12 @@ int mlx5_core_destroy_xsrq(struct mlx5_core_dev *dev, u32 xsrqn)
>>>  int mlx5_core_query_xsrq(struct mlx5_core_dev *dev, u32 xsrqn, u32 *out)
>>>  {
>>>       u32 in[MLX5_ST_SZ_DW(query_xrc_srq_in)] = {0};
>>> -     void *srqc;
>>> -     void *xrc_srqc;
>>>       int err;
>>>
>>>       MLX5_SET(query_xrc_srq_in, in, opcode,   MLX5_CMD_OP_QUERY_XRC_SRQ);
>>>       MLX5_SET(query_xrc_srq_in, in, xrc_srqn, xsrqn);
>>>       err = mlx5_cmd_exec(dev, in, sizeof(in), out,
>>>                           MLX5_ST_SZ_BYTES(query_xrc_srq_out));
>>> -     if (!err) {
>>> -             xrc_srqc = MLX5_ADDR_OF(query_xrc_srq_out, out,
>>> -                                     xrc_srq_context_entry);
>>> -             srqc = MLX5_ADDR_OF(query_srq_out, out, srq_context_entry);
>>> -             memcpy(srqc, xrc_srqc, MLX5_ST_SZ_BYTES(srqc));
>>> -     }

OMG!

>>
>> Probably should add a
>>
>> BUILD_BUG_ON(MLX5_BYTE_OFF(query_xrc_srq_out, xrc_srq_context_entry) == MLX5_BYTE_OFF(query_srq_out, srq_context_entry));
>>
>> Just for clarity that the SRQ and XRC_SRQ are being used interchangeably.
>>
>> and the 'err' variable can be eliminated.
>>
>> Curious though that I can't find a call site for it, and removing the
>> prototype doesn't break the build.. Seems like dead code.
> 
> I checked the git history and don't see any user ever added after the function
> first showed up in the kernel, same for a couple of other functions from
> commit 01949d0109ee ("net/mlx5_core: Enable XRCs and SRQs when
> using ISSI > 0").
> 
> Can you come up with a proper patch for this isse, either removing the
> dead code, or fixing it appropriately? You clearly understand what this
> file is about, and I don't ;-)

Simply this is just pointless dead code, will remove it, there is no point of trying to
figure out what the author was thinking the day he wrote that patch :)

Thank you Arnd for spotting this.

> 
>       Arnd
> 
