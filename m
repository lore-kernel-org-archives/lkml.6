Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeECRaJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:30:09 -0400
Received: from mail-dm3nam03on0084.outbound.protection.outlook.com ([104.47.41.84]:40161
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751007AbeECRaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:30:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <b8acf835-df94-9967-2327-8f0e39d88511@amd.com>
 <805645c1-ea40-2e57-88eb-5dd34e579b2e@deltatee.com>
 <3e4e0126-f444-8d88-6793-b5eb97c61f76@amd.com>
 <ce2e5351-f32a-bd80-1c77-b7fc38842175@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <38d866cf-f7b4-7118-d737-5a5dcd9f3784@amd.com>
Date: Thu, 3 May 2018 19:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ce2e5351-f32a-bd80-1c77-b7fc38842175@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM0PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::15) To CY4PR12MB1718.namprd12.prod.outlook.com
 (2603:10b6:903:121::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1718;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;3:aPc46D9a5TuUQYSrXWgxN6bQwoSArndt+TAH7IaWjyRxvhyZ/p8Tae1k0AgZ4zAWQC1kafvjd3QSJ4KOC5gOdx6TxXRG3zSrdVE1WTYv7p49UdQt2kLgOsovuGJoBeUzImUZaHuD6WqQDZQqOLhPVFbp3q/C1wstY2zuM8NQhVpG+vrV/NdREBZvpVMUpG0G5X+RfLaHblKa8BekRLkDX48naCYWEC2B4M97zaCYlw1VpsANLdoJHKnCfKycyTI8;25:UcG+q7a80ah8zH8suCBjZ2ttKTvbnNguET31VxyHvLNXFrUz078YewmgmiECVEFnaywJyD2EGWsLmkVI2ixxOgmt94lQSdfTi/TW5SQ9vGcfUI15fbN9mvcZ5l9A1snG/RCi7Wu20js6gyJ178QyGdgumJLeOcXLfx6paml7KiCntXjSNJFBMB19ygt1sPTSdt86LWksUdq4x2GEyigo1dIvb2iGZ/mVHSGNzvGmi7h/twP1Ckx2Q5nz0jRfOCVzLdJ+AKM5JAPdQ6wZH/cDoeiJt4JvTPJNZM5vWD5WsFIBdHGlznMebcQTC+SdKZXHJG1kZvN6ETSMYI/uqNmMjQ==;31:+isb+OeahnHBomOlZXHk+8Z7btwuVo4rvdlNdEAMCAXehmp1y9UYGZejNZ23PzYpO6EXfO17KpFtotXxkMZ3/pckVyEpy/jHDYhPlJkHFBvvQbVecqMbPJpS3cu3+J7t9LTVWcN8/o8Mh6YZno2Kg6IiY9jnKMM3uAjJE2bkRVTO0UH/CQRufqz3QchVRjyXjcbgugqve5FdjbpIj6b83sp8llXPoM+BgLdekWY2vR4=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1718:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;20:HpUIfwofpK7/mMC0D+7qB3Md7st6S/aiZMBMuoMK5flc5nR2hAg2YjZX0Arpke99UeicbXTACk8ppEarYFdwjNQBKaGwJ7P9QUwe8C0Kg9WOrNECkYlNo/8dbeMRq8y5uITarsN9hGMMz0Qb779MFZrZt+eL745n0peJSYPeG8p9BgXqWiAJexWas+xgAYxNkZjcsWkbt2OttPEFetMeWJw+hbVH3dJXi68419cx7LCFPnHJrCePkacdSGxLIhMcj+mPDaIOxiux5YNTewxGOLLzCGbf0hkZ1I6KlOOq9JXHEHwPbPm7oj2UUaPaT6AJHEpa9AGKWjMdfxcSAI7GLvDkOlVlEI2da2WAE4er4Fs+8u21qa3lQJS978MmmcKvyFRMbZ6dE/9GAujzrTmL7KTektvCoMZ6ySpmkA48bp/wuDMbvfWYYogBJpLM529zgqTsdFwFwjQ5KxxqLObE+gLNgTKad1GdPtVXxmiaF4EiDjqDG0dxaa0uI1XxlXID;4:QWd/92KNnwqyLLMdqYmnlW0bP9XEttWpqFF+80050qAAffHVWKZm2giP8xQ8/syZBIKjyyKbjAC8+cV1ssrzQx/XkUG+Vqy9e2+v5u4DVCUJA/A8Zz6Ceus6Pa/AyigHy6WiKS7QyiAh6lEk7AGr5rybURp7c/CYaO+9xQ6sNJeUJNkKuSfCYe2gw+jm6CRBc1TfqAbQ93Jc8ZydNJAQIIs7SqEYSiZDgRkM7vMnxWZSpwfVywNRGWOMUCd19XRYIVJZh93/OPDsJfoYccwpew==
X-Microsoft-Antispam-PRVS: <CY4PR12MB17182232A90B76C1A19B78D883870@CY4PR12MB1718.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1718;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1718;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(376002)(39860400002)(366004)(396003)(199004)(189003)(57704003)(51914003)(305945005)(31686004)(81156014)(105586002)(8936002)(8676002)(81166006)(97736004)(93886005)(54906003)(58126008)(316002)(50466002)(6116002)(68736007)(1706002)(47776003)(65956001)(551934003)(65806001)(46003)(11346002)(5660300001)(446003)(2616005)(476003)(486006)(76176011)(16526019)(186003)(72206003)(65826007)(53546011)(67846002)(53936002)(36756003)(386003)(52116002)(478600001)(59450400001)(6246003)(52146003)(23676004)(31696002)(52396003)(2486003)(6486002)(106356001)(2870700001)(86362001)(64126003)(25786009)(2906002)(4326008)(7416002)(6666003)(229853002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1718;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE4OzIzOm1uOUI5bWZ1NHB5aUx5NlZiZ0JrRlF3RmhX?=
 =?utf-8?B?YTJGd0tzZmh2NllHamtPazBiemMyWi9ic1d3YmFuajA3R0tFaXBaRFVpd0wv?=
 =?utf-8?B?VzMwQWc0M1BwVnZTcld0bzVicUJRZWhXZTJXTEc3Y3dyeWR3VkFPREc2STdu?=
 =?utf-8?B?b1BlK2FEV3hSVktqQXZnM3Q2Mk5KQkhTbkZIZXkzYSsyalIwVStDN1RwMnVQ?=
 =?utf-8?B?MXFia1libTdmZ2VMNlMxUnNOa25MZHA4YkVUS25ReFd3MDRyL3hXZStBYSs1?=
 =?utf-8?B?YnJ4VXYwMkNVQkQ2YTFjWm5CSGFRamY2UDNRTU1XT3Zmdi8vMGdORDgySGRp?=
 =?utf-8?B?MlpuQ3EvWkRCV2ZGZFZhRTFXQ2xwVWFlQmd3WWNqSWp6SmY4YlN6SkJxbFdD?=
 =?utf-8?B?R1FRQWUySWg2UUcwOVNPZytpazdkOXZNQjdBZ3pWNkdRc1RyZXltK3FoNENQ?=
 =?utf-8?B?VWJRZ0NEQnhqTEdNSGNrSGtCbEY0TklwQ2x3Tm8vRHgxRHRTYThFTDFucjVm?=
 =?utf-8?B?K0krZDM1eW1OMjFWaklhT2ZhQUV3TXNaNGhFQjVHQll4THV6Wm1WYkJyV29x?=
 =?utf-8?B?d2hlRDlMMWlxaVdJR0ZaSUV2SWx1aE1VcmtMcGtaUWRuVzkvQkMxblhxUmZs?=
 =?utf-8?B?Vnd0YmUxLzVDbFZtdWhxOU53TW5jcVprQUdaSnF4U0ZtNThIMGVJUHNNWUR1?=
 =?utf-8?B?RmdnWDgySnpuNnF0UytVSVlGZG0raERxT2t4SE9VaStOLzYvN3orR2xNRmZO?=
 =?utf-8?B?WlJPd2d5ZzVhQmc5c1p0bkpXK2h0QmFTRUprQVZkaHc4Z09aNDExdWlGUk02?=
 =?utf-8?B?U2QvU3N0ZUJLL1UveDRJKzI1WDd0TzFzTENpWlduZXErRHVidit2VThjQ0VG?=
 =?utf-8?B?bWthNytvZ0NzNmdlZVlCUkJMQXhrbHFRcDNNLzRYejlZcVM5MjZWY0I5TkNz?=
 =?utf-8?B?UVBBcGVoMy9na01TMGs1Rk5vMGk1V09lbVZBL3pUYnI4VVgyTXQwakdyMFc5?=
 =?utf-8?B?eWIwUEJxM0hyd29MNWcya2xXRnA1MjZNV1RsQW9tVnVCOFczT052T0NRN1NY?=
 =?utf-8?B?U3dsT3hML01FNEJjVUNraENwLzZhZkp6N2Ezb0ZKZHI0NmluVkVCcHBTYTNz?=
 =?utf-8?B?ejA1cE93Q1htNVhkcFp4Z0E0ZEZqd1dKR28rbGpySjhKQ3dGbEFlbVlvRUQ5?=
 =?utf-8?B?dXdtMEwrYlJkaW01dysyTnRHdk1xT0w4M0dKNnYyRDAxNzkyeFdjelA5eUNv?=
 =?utf-8?B?TnlUUmpOSHJ6WEVrR1RYRmJIbTI5VDBPeE1uRnd5RFBOQk05TkVKQVRnNi9Z?=
 =?utf-8?B?NWtpZkVLQjlHTjFTRFYrd2sra0pPZjlhbld3WGF3dFRCOWdpNTl5MjltRkl3?=
 =?utf-8?B?RFZtU1YzUXNMMm1ZMU5UdFM5UGZUZlN1aUg1RFJrSTNkVlhlNjB2dktpb3hh?=
 =?utf-8?B?cmU1bkZwL0N1Q2txSjlDbm9HTm44SzVtdms1eHBEYm1LNGRTVndVNnhUQ1Bt?=
 =?utf-8?B?dTZMaGJVMEF5d2xqRzFwUmRGYnl3SEZubklObVJuK2ZVVm1Cb0RuRlpHOHNp?=
 =?utf-8?B?TzB4ekhKTDBLVW9LNXhjQnNnSUdZRnlUbUpQQ2RGK1dRYWJjYTFRM2lJSVZq?=
 =?utf-8?B?SWloVEk0SHZJRStSV1U5OFlYU2hxdlo1ODE3bis5cDRCVm1rZ3BqNFQxUGty?=
 =?utf-8?B?ZXIwNllFVUJyaTI0c3VpK2NFdi9ZSVN1SUNzZFZCUWNGb1JrbExRVkp1Uytr?=
 =?utf-8?B?MG1aZzlnazJXSHFqT3Y1b044Z2V5VFlZMWtwNVJ6UUoxUnJhWXZyV1dHcFBs?=
 =?utf-8?B?Z2FPVFoyblplQ2dWNjlUYTZuVTZnZ3pqV3BmYlJaUEdXd3RESExOZGQreGZK?=
 =?utf-8?B?d1BmdzNDK3B4a3F2bnJBTTN5ZWgyWGtnYWxyZjh3eGxpU1Q1QkxPeTdFYUY5?=
 =?utf-8?B?MUNwT1RsdVAvMUZBYlFwclRGNjkzakc5UlRpNXdheWZSYi9KVFludFFsNHJw?=
 =?utf-8?B?WFFLOVp3TlBsd2VwN0N2eUxiVkt6dkVTY2hrZGk2TjYrV25XMEo0ai85Rm94?=
 =?utf-8?Q?K1gSpRuDVp6PfYr5w8Qt4VPIb?=
X-Microsoft-Antispam-Message-Info: OtU0TH7vwqRR1dm4iaqojZVx6DDAcYdyBqoWQZ05GPdm3UAe8ZGFVtTp4FM9BNNpNdtQDJJdNFsUgMCF0ErBr744QXEtcmNoLTQWNxFhS+tZGHWWbYygdZcmT5B/NTaRlL0iw7ksCQPglxMs6gUPm9HYW5v0tcQkMm7hc/5Ks4Q0HiE2EODI6XTQPp7xg6Ms
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;6:9XZfzBjjEgoNj+8bepI83Kuh+mG+z9SQJh8Ace5WfQG6gEtKI6IWsj4hoa3bwhiSclzJoaJ0KXcWopd6ZcxtxFCBbPvqUjMeI6ZYXhvABgJyECNzz+SSNoWb8Lb4pWngTERZCp8e1LvhgcmXrU1BUDiJgQWk3gR46Rgk063aTx8q6FafECRsIf4XJ+ARm3j7NV9kIhIYjZ4Nuelw9PYYJeY92GSxLdlQwqep1jBU3AuMxVi12XqEtqFHMmdGKcHWd+2nFic0wkV4fZBhSI9MKH7iI/3FNqD0nnrgSAPtXaG2TC5f/u4vZfrBbdG9s8xfH5VJxjz3R/myAzjMfxmGdMNhzl1W62Kog/cjTXEE8EzVAQmpCj8FEH73W83IIHuzy8ZmASSqlFGWxsS5ptj2fLsXDxAH/7qoWa6NFO0hyDcopo/Q2mb0iTArCz1p3eV70swMJ0o+Q0nZN1ZDHHUjJg==;5:dOtO+/qcPbBVdkYg2bV5B7McHbTSUsq6VkUT+F2w5WWA1wOUUnMOxh3zQtQWfeJCPNfkH3NBL2hRjfhyoWSroFsimaTQiQK/A/DPHlD+1X8+RS7nSH3u5ycPl0DKzDcRZWELyVlnhrWJiuHbACT/rwnKxAyOSQcwEce8dS0jzn0=;24:Zy8xiv06NkNigSxSOA9irvqLgy92zuaDy4+ZWXEYwq+/SHQMBrrVVu2BYKXNvOAZR4HKEwOxNUEpZzBcg3ZgqZPIJyqcULf3X1cX/Ho2ioI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;7:hPEbjK+7+pdf++NQucm9ZIqvI4vKnne3D34E2hiM+zRO3zYnlfD7RqXVv2FVDN/EFrVfPqrA32kUa5RxGK6XMhM9A+cVZVUWzuiekVYClPwhWudifaEcrNZh6N877YQIM7vfzK0IhIU/piVhn58uVk6zLj7BdkSxlm23amtcCTwOBc2yKcScVrwAGJgKbkQ5aaqt3uh9UsUDsxzFilzdO7xHo9MfI0Yoqs1UdGKKftftygVESCc0fdX2hdcXNqaI;20:j3KGZChkq07NtWmOjDB0vxHdpOpAkznDblZYPvt6bPpgIXicQDZamEYYOHpnUcCRTWS3FqhmJ2PRDU+Be/47M9kUwRn6JzZ76Aqsw1PSNGkoIQLt5qx5/Q/MrKNexEdKPQ4nAYbvMp4GLqxkqaCaoykYiH2Xflfk2lDQQXjdgnNfWyMkIRAZlZuePYDX3iBi331AKrIlQSDNyjBiDzKRdJ9DAVND6iUu6vOy1aI80nw3jZmdVRphSHdAfZCYqaEx
X-MS-Office365-Filtering-Correlation-Id: 06362dbc-178f-4d90-d0a4-08d5b11b8065
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 17:29:57.7463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06362dbc-178f-4d90-d0a4-08d5b11b8065
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1718
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.05.2018 um 17:59 schrieb Logan Gunthorpe:
> On 03/05/18 03:05 AM, Christian König wrote:
>> Second question is how to you want to handle things when device are not
>> behind the same root port (which is perfectly possible in the cases I
>> deal with)?
> I think we need to implement a whitelist. If both root ports are in the
> white list and are on the same bus then we return a larger distance
> instead of -1.

Sounds good.

>> Third question why multiple clients? That feels a bit like you are
>> pushing something special to your use case into the common PCI
>> subsystem. Something which usually isn't a good idea.
> No, I think this will be pretty standard. In the simple general case you
> are going to have one provider and at least two clients (one which
> writes the memory and one which reads it). However, one client is
> likely, but not necessarily, the same as the provider.

Ok, that is the point where I'm stuck. Why do we need that in one 
function call in the PCIe subsystem?

The problem at least with GPUs is that we seriously don't have that 
information here, cause the PCI subsystem might not be aware of all the 
interconnections.

For example it isn't uncommon to put multiple GPUs on one board. To the 
PCI subsystem that looks like separate devices, but in reality all GPUs 
are interconnected and can access each others memory directly without 
going over the PCIe bus.

I seriously don't want to model that in the PCI subsystem, but rather 
the driver. That's why it feels like a mistake to me to push all that 
into the PCI function.

> In the NVMeof case, we might have N clients: 1 RDMA device and N-1 block
> devices. The code doesn't care which device provides the memory as it
> could be the RDMA device or one/all of the block devices (or, in theory,
> a completely separate device with P2P-able memory). However, it does
> require that all devices involved are accessible per
> pci_p2pdma_distance() or it won't use P2P transactions.
>
> I could also imagine other use cases: ie. an RDMA NIC sends data to a
> GPU for processing and then sends the data to an NVMe device for storage
> (or vice-versa). In this case we have 3 clients and one provider.

Why can't we model that as two separate transactions?

E.g. one from the RDMA NIC to the GPU memory. And another one from the 
GPU memory to the NVMe device.

That would also match how I get this information from userspace.

>> As far as I can see we need a function which return the distance between
>> a initiator and target device. This function then returns -1 if the
>> transaction can't be made and a positive value otherwise.
> If you need to make a simpler convenience function for your use case I'm
> not against it.

Yeah, same for me. If Bjorn is ok with that specialized NVM functions 
that I'm fine with that as well.

I think it would just be more convenient when we can come up with 
functions which can handle all use cases, cause there still seems to be 
a lot of similarities.

>
>> We also need to give the direction of the transaction and have a
>> whitelist root complex PCI-IDs which can handle P2P transactions from
>> different ports for a certain DMA direction.
> Yes. In the NVMeof case we need all devices to be able to DMA in both
> directions so we did not need the DMA direction. But I can see this
> being useful once we add the whitelist.

Ok, I agree that can be added later on. For simplicity let's assume for 
now we always to bidirectional transfers.

Thanks for the explanation,
Christian.

>
> Logan
