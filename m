Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935580AbeEJMxN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:53:13 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:64287
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964904AbeEJMxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:53:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
Date: Thu, 10 May 2018 14:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM6PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::18) To MWHPR12MB1728.namprd12.prod.outlook.com
 (2603:10b6:300:112::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1728;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;3:koX7bmdaqLpjnB765dyPksUwSDpOKj9gatatvHHv7BJruMy1LgH1oooP0OhANp19FHhHKWqoBNKBg/caQoQUr1lrlpK3tgTQFnOSydLLJdTstzA822eWkmplrz4q13IqQdxtj65sxdmSAXk/5kpWeSul1lWfsyh6OHYkQlEdzkgMF1YYHF0rmPWpvncdjQgPfnXpZoUuy7LwRxsb0dTPhg+jpdo7w778/K7pi1lrSfWwY+U4UDQsG0QEHUNSuQq0;25:MJ+btxE2NYpc23c9J7GH1dhGQxHGIiNirG4IlJ4vJ/rpj9oqh4ux0+qc9Nw5rGXaSSWLOP4Yv3/xFzbzVhecAhUTNj9f9U33N/SiOoNIa+Lr6vIelAWoicTXjaPr7UjwIcvRblxprFMubxAl5jQpV6IczxUnD5IcvEf/bYU/1d920tBjeJisI2YO8eIBz6BAa8X1IDizVB857jK19m0xidYlbx5HUYrG2GWW4dW1g5G6mb80+/f/oTRGeD4AFpB0S6x6Z1YCWYcmDCao25Di6PN0ihKqnAIdEV9C74pyRW1ZqnJqRNezcpcsWxY3x7+P5utzydA+nV4wciPIEA2R6Q==;31:Ns7r0U0z0gMan/OHmg5wPKNOAeXzhiiF4u61gOYvbqho4RRKU3hoC7GOtrGWrcgfRUSGCwxR/QsUAmionel1AMFZ0eV9BachhbQqL8Xx5IdrN9RdBoNWcb49oxxY1T4A3gJvXFmEteqrAeqOb6SdMC8ds3J44dvLzaOxY/uGA+VA+Jmov95dxhkfi82JZa5tGfGlK9dpgkjsDGxXVb/lN7UTns8e1cm18m6N0PoVz3Y=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1728:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;20:Y8UrDQKUOevPJQeK3N9G5U44MhFyYQzFt2TLkj67GtKwaol03bnkZFLxV6zjcKeppE17A8z8qRiI5QZnmfsEyy61jXc1yhS0K4qAsjy/K+QH6VQF2Us+ZJUWjR9q/mPmnmB2cKuhM6u4GwHmS/TMfvb9gG1sHMnFexh54lxWJ1Y2pILZbWl9dNVHJKKAaZJn4q4IxLuHDuSSt/ui6cCMV6tT9uRMYC1SUSm+9DbkSQsr8HPJfk6SA1AT+TGgG8PcpiF1tRUfpYJyFfBuIzW1bz7lDxc5s5I9AI74Xbgu/W6Iq7YJiNGj8KEW+tTWlTKCij/zO5XgtqD8Ow7Czpg0v9sFvnLV/BofDg2vbmEwznrGMjovitmDp38xfMmdoqaYM6f79qLS0CK8m+JoEjhKSpIubJV0UMERN88fsaIE9dd5d401QHvlQErEtYdxdKb6/llTzzoQAUGNeUjkXSIzNGuzcsa7YNezCZrAxh50/7O3+RyDbohvJkEORwzWcHx2;4:2K4/Ag9APqfkBg4T5BW5Ie9F1sZ5hjy6tUDqcR1d/KBi3P5IrqGv30dat8xdOUE4ekw8W0pKj3RGnr2pJhpZWqykzyXs+SucVYiZ5OMw+XYI50/sb/Wga+SrGxk+n8FzcFThVB/JPGr5och7vrxHlhGY8mIkeEEjhy7YvcBRv+RsGdtBi1WSMtGCjBSq1fPfOlUcU7hRjR0bj5mLVo/5OiZqt5SZ4jQJUa9roZ97j8NXtgFyPPCQVdTEF9sQzq91yV4u4YYeKv68SKNzFF7ZuQ==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1728B54D8C87EAAB30DE2EFE83980@MWHPR12MB1728.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1728;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1728;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(366004)(396003)(346002)(199004)(189003)(65956001)(31686004)(6486002)(65806001)(72206003)(478600001)(53546011)(386003)(50466002)(67846002)(58126008)(64126003)(105586002)(25786009)(229853002)(76176011)(52146003)(23676004)(52396003)(110136005)(2486003)(54906003)(316002)(6666003)(52116002)(65826007)(7416002)(5660300001)(2616005)(106356001)(186003)(486006)(97736004)(47776003)(6116002)(46003)(11346002)(446003)(476003)(2870700001)(68736007)(93886005)(2906002)(1706002)(81156014)(86362001)(305945005)(16526019)(53936002)(4326008)(36756003)(81166006)(31696002)(551934003)(8936002)(8676002)(7736002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1728;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI4OzIzOklTQmJuUys3MHpvZnJLWWUyci9JYmhnRWRC?=
 =?utf-8?B?Tk9uSFlRMGkxbC9BNW9HcGRWZlNhUytmWGxQVGlHUFV5UHpIYjlHcEdlQ3gw?=
 =?utf-8?B?MGIyL0tKUmdjb3NsYWE3QUwxeG9tUlFudEVXazBtc1NhT212c2l3UDl2ay9W?=
 =?utf-8?B?QjA5eFJnYU1uZzlYU0NWZ29TMlRuRGFIUGVBT1ZheDh5S29US0ZtenJHbmI4?=
 =?utf-8?B?eHFLV2pvOXk1a3BmNE5MSEJUZHRaaXdvZCtmcEI5b3ZEemZLdExETzNhRS9O?=
 =?utf-8?B?UmNjSTd5eVRqRFhhaWZKOGU5eU84OUtOM3EzYWNOcFdNVGw4MzRCS2pxRm9T?=
 =?utf-8?B?WEJpRk5oOGFUQXBxSVdoSE9NSWNmZjV0NWliVldZNHI0clFjTC9ZRXF2czl4?=
 =?utf-8?B?eGJnZ21iTW5uclQyUFFCdGhXV3BLRXRFZkpDZ1ZCcVIxczdUb2JWTEFsVkk4?=
 =?utf-8?B?NVk2bWJicjFzTjZpZWV1b1FIVm1jYjRMMnZLam1DeDlSMno5TkRUWDZvanVh?=
 =?utf-8?B?dEROSHBvVTRxTmZabWI4dUZGQTB0d015MHFoaHRwVlY4VnFYWERaUEdLZ2dF?=
 =?utf-8?B?UnpZcEY3QXZ1eG1qbENndlA1UDRQT1ZDeEF6dGcxUHIrdWl3YmdLRDVvZjYv?=
 =?utf-8?B?UEtuSlh0QzlRMDBZc1pJU2NnbzlDMUNxMTBwR25JaHhZdWxNa1J3NkxuMmU2?=
 =?utf-8?B?bmp6WnFQUzVmVTVlWVhvVjJnTHhYU3ZqQkhCN1h0eWNzQVptdlNwbzAxT0hh?=
 =?utf-8?B?MG1hQ0hJSHNnc1pjbzV0WDZoS0RoTExjaktLTU13ZkNLTm1JdjFkNWxUM3Ry?=
 =?utf-8?B?dG1JNUt4L3lGOXVYTDBJcWIvSTc1UE5pYkR3aVRZM1VsYS9MN0NpWVNGTnla?=
 =?utf-8?B?dHJLVmtQdFFtYVFxdmZCb3prazlFU21EUXlnZGpDTFh4R2Z6WThMbWNuaGtt?=
 =?utf-8?B?cHBYbUVhWWlUcUlzRnpGQ29uaXpBNk9CSk85RVJaZUZuTmx6UG5sVnNaSmRa?=
 =?utf-8?B?eDJvWjQ1bCt6TUxHTG8zTHhRWjA0aEI1clpZVHMvbENMbm5aTlZHcWdKVVM1?=
 =?utf-8?B?SHBzT0VUYXhwRkcvV1NuZndwcVY5UWZSRG5xRkhmTHUrcEVhdTZUKzZmMWtu?=
 =?utf-8?B?L0NMbk5rKzBiUVA4L1VhbHFLZGJ0NUYxenN2djZ1V1ExZzRiMUhONjRmaUtz?=
 =?utf-8?B?RXo3Q3FMc0lRWkdjekU5TTZnbm9IZ2ZTNytVMnF2RjB4Ymc1c0VYZ0lnNjZq?=
 =?utf-8?B?cFZHd0k0bWp1akY3NitwdVBRTkVZVHlWRXdCSDdSQjh1OFYzZ1IraUEwbzFM?=
 =?utf-8?B?UHVhaTBYOUVtalhEVVRrL0llVEpPMmY2SmhrRXpKSGw2WWpzTTBnQ3NESDBG?=
 =?utf-8?B?aGJidEQycTBQcTVPYXVVSU1RL3NjZTViUm5oODdFcDZCazRtVWROS2tvZk9s?=
 =?utf-8?B?aFVWbStBNmVJdGYxNTYyazFwSDFuQW95d1dNV2ZrWVhLNGNWRHQvbHczNEpY?=
 =?utf-8?B?TVQxMElYMmRJWklRcFNuTTVQN2JTbTRaNmVscmluTHBzUjYxNkJvNjcrME5k?=
 =?utf-8?B?S2QzWlRnMG5aeGV4QVNDQnowNmRWeWxYK0NNK3JsRFZuRGNFazVyblJjaVI1?=
 =?utf-8?B?cHRrQm5Dblo4NUdwdmNTdjVUOTcvWGlTc2JFVXgrNXI1VUttZkhGRHJoL2FE?=
 =?utf-8?B?TlFVRGRKWEorWk5JZVN2UitvT1J5L1F3WG5iSUxiRkkvYWg3QUduSVVnYURt?=
 =?utf-8?B?bGMzTmJmMG8wd3B2UjNhbXI4ZzkySVVqRXM0U2hTNjFObzJ5SEZOQXMwMWpB?=
 =?utf-8?B?eHdON0RkQ0tYRlc0T1psbzZqMDRnR0VpWFcvM2JyaHFTU2UwTUdzR1c2K05J?=
 =?utf-8?B?MVByTmNQcEJKalhFUTZKVTR5UTFUYlNTUTRRNG16OSt4ZHVpUU1iTDZGTlk3?=
 =?utf-8?B?NXB3M00rQnNscjNsaGowMFdqVllWeDM2bk1DQkI4NlRHY1BISTdPZVlTTW1y?=
 =?utf-8?Q?PZVYYH?=
X-Microsoft-Antispam-Message-Info: AsTG4cSm5YeTLxQJZ8TlHD86EpEAQQXqL+y7G3xKBzx7AM8gbhahR0SQyyP0bryaOEfUmWGo+gxNTAgMvaZ0+uFzyJ+rOERY0p5hU4qQ2UdONasKmMU/Pntnj9U1c2o2nco2y/brKisjL9NB5B7TF+BmJU0oY/7OEzkDWKrR8TiETnEIS0xmQMOtBD6RF1mD
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;6:d763nXMM2amKP0GpjXX10C8S/tL58dSmSu5Fh7DHJ1RZ+3JZfeNGwqKNpgQVOWfE/J9qosN/4unRZWHE0OATMR2NgFxCkOvq04ld/5cg0hqN1Xv3D8EFz6JWGWMfFjZP3ZQzVzeWgF+aNnBgKKXzfJEO62GhVMQXaVgXCNkM4WOxPqgsL6G+4Zrsu5eWX6wSPPxcfGi0SHmly/PC4wm22Kb1Rh7vqLJV9Tja0kRLR307dPTjwGTp7AfudtbDdNdX27yFdNxGrt9F7EUgTOElOF31wK8X/YNFgObbj52PN48C5QKVOKZq+qz7jEF+XPp9O5/9+OFuhAthfJ1G49D23HlY2J2qTQukVT0+PYRu761kFBzmcTTX281iSKkp+aCG1pzTvHa13zY8lTrPs1CpRCmXx/gzzmU42rBLpaEreJfNTdnRvRtsq+MzQgXdjCA4LWQg2S18eONTjsUzhTGaXw==;5:QF5QWQCY3sy8UNFFa3av4hVe++2cSR1uNFdqd6JwZ0PgKCNQgeUyFrPUNiDP3UbtjhKyMoXzRLIbG737mRfdj722uVolxE0bJgxyONYqFLhEUr/zToOcx2IM5kU/6A3PwiHUFufsSemyt0RcQ85B7NCJNeSJ5G4DYHyfe601AT8=;24:WPcYAeoOehgpwhjSriE0kHWkQBd+6BDY/avyOSEZMy6V4Zh3QN6ddtgAzJX9M8yV06K4w9bVo/w4cF6pA088jOZT9HT6sNiqtjFlsSYC1j8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;7:8z/rKBsa1pqt4y6010etG2OCJocgyxsHdfIfBPFpDKG8l4dnt9SMPzxBe6C7DAnDtQ1XQLbeHTqMOUJpBUK1jk3TFmqbCdDJQOKfaecv3o+rgCSI8sLiMBbPhW+8xBCvh8s8akxtLGpqLg1Hws7k9F50nLA+3FyzDQF2cPWaacRHfqn9xHpEhETZwjLVZipJIDF1exnK8+qJAq5yzI5QqF/D6cCreZCx+OVHIA+j84sBEt/StySBGcU6ka9Gr67h;20:dPwZ05qyP4Zs5Cw+vu1BBJYBj6mkBXAqwBjkv2HADIVMojxt7D9Rc67pjXfuH4Rop6l80GOesgEdD6M/ziEWVcdXyHwCZGJIAQlyywrkw85udnmBm5SjBt3MGXAx045eWnQnaJvP7kaESRiP1hcEyvBcUqHOWWE3hTLFNMF5wbPsLKtEARi9CkhSIAsxY3AX7w/4afeUXhFuM9WTGKnpvnepHZBie8W+XsMqdzfRhh9NpqwCI+G/IvqU4ETCk2EL
X-MS-Office365-Filtering-Correlation-Id: 6606e444-4458-460a-8aac-08d5b674f923
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 12:52:58.1048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6606e444-4458-460a-8aac-08d5b674f923
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.05.2018 um 18:45 schrieb Logan Gunthorpe:
>
> On 09/05/18 07:40 AM, Christian König wrote:
>> The key takeaway is that when any device has ATS enabled you can't
>> disable ACS without breaking it (even if you unplug and replug it).
> I don't follow how you came to this conclusion...
>   The ACS bits we'd be turning off are the ones that force TLPs addressed
> at a peer to go to the RC. However, ATS translation packets will be
> addressed to an untranslated address which a switch will not identify as
> a peer address so it should send upstream regardless the state of the
> ACS Req/Comp redirect bits.

Why would a switch not identify that as a peer address? We use the PASID 
together with ATS to identify the address space which a transaction 
should use.

If I'm not completely mistaken when you disable ACS it is perfectly 
possible that a bridge identifies a transaction as belonging to a peer 
address, which isn't what we want here.

Christian.

>
> Once the translation comes back, the ATS endpoint should send the TLP to
> the peer address with the AT packet type and it will be directed to the
> peer provided the Direct Translated bit is set (or the redirect bits are
> unset).
>
> I can't see how turning off the Req/Comp redirect bits could break
> anything except for the isolation they provide.
>
> Logan
