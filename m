Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeEDO1z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:27:55 -0400
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:18385
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751001AbeEDO1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:27:51 -0400
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
 <38d866cf-f7b4-7118-d737-5a5dcd9f3784@amd.com>
 <2d59aa02-f2fa-bd88-1b6c-923117a6ad28@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <17e7bc28-f499-c7f7-f91a-9f6778de5fd3@amd.com>
Date: Fri, 4 May 2018 16:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2d59aa02-f2fa-bd88-1b6c-923117a6ad28@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: DB6PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::24) To DM5PR12MB1722.namprd12.prod.outlook.com
 (2603:10b6:3:10f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1722;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;3:17g8ci1t9T2B7hPR+br6ptTemx6AkZ9tg3qRFZ/ldmrKLs5FPtIwFGNiKSwcfAi97BP4dBVKDNnd/umhtmKTorXmJ0SsdQntDhLheuOwqw2fyMWThGlV+qmhwgWXRLRtQlNaO8ou3Tx1QYuNxTn0BpVgClECLaimDK8DXM4Zg5ZoxPujpPKdIFdPgEzTArdCSYLQYl/Xw/36ftQ7ysQ+vxt0Fxs4gyXwqqqzaLqOhoVOlQSqsu4rkHyb4nGlBCtg;25:wtuW8+TefAiuxGnaIvJ8riJn9SedKCKKgpItn/ILZYJo1u+s/8ULNkQItOkATLeypyNRlvE7dvjxnoJwLGc13bm/qmITQe7xK6tdDIQuP8MYaYxdPEgswCdlGbfwKbsr048D8nFCoavor7DM2vkOpxPvYUi+LGsZxC02a7rl1e9xp2Wde0qZFLPNv+wXhoTJCe2qUpMIXiuHDOCLXZxuIKanGd4mGCmeUMFMs9ciAZbB/D2JH9JW+keEimO5SvFaMS1GIK6hCP5soU30gwb0vNho9WKl5QY6bB3t/P4Ta03KyHubjvfoDN9R8w5B5iRvlJJDqBojVL+4EtwNDJj4DA==;31:wtBOic5urWrlZ/spCxn9R2k0tYWPc7XsDyoMpfBQbcBdGvc1y/jOFYHRaRLo+tHSvVnNDW1hjmw4119jwg2OjS7Aw/Y3iovVw17e5/yr3KByce2csIO1AMSsSnrJBcY0rbcGbZFk8MEHOqRShEnFN7l9Rk6VFdy2t7jgKTl5Jg6xvRVnU6iYzlECGLTZGDEh3doESjIUGnRpfYG2N7V7h1DTjpIM1t8EAQGS2/PgmXE=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1722:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;20:TByqCaR7WF2dpvgPJXY8HYEm0gvhZxBXOxo7qO1gJjgqetitYcsO2iijJm5Y/U6hXJd2xPzC+/zKB9sbN75kZJE/j5k6vdrZUU5876guTqXal3IKI9tbs+Rn2bRc7O5aA3PH1dRSybTFItW+ekGDGPnNDc47wYFfhbpu1y5Gd9gjaXCpGUqXpLtWzcgR8DJH5nCyivte/Ra2QkB/TVQ6kLcWRKbUDn2pEcEMG8AIcRMzW8nZkfojksCinMfp1KJdcoe7ufmdUUF1NPdWPs1sZ4dJLmr/rlfliSYfyhW5CJx6Zw5LLa3uvcMBcSreVlqMjdr3ceXFnovPZ/dRJnAVZWdd9/WkTNKQazOzr1crLyz1DTbaIUhWXzu8uFB02iBUJZKIq7DuBRKGpN+4Pk1i8ARCulAYaeihS/z6GiO8La3pJp1p00Vy995wf8DIGXsr18Lxlxs1GnY66kTNpsZq+eFsM7PwoMz5zTcSMdsTrNfCJXZLNVLEvCxI5pq3PAEH;4:+1gKYzUNnj/ERP6VqLrj5Uos5Kyue/OM4evIUZIP5QLVw85pDHKj/etJ0+mH6A23oZyP79uzCZ8aZaEerfAh2waGPEenUly6goXevKAmOKVp+kbmjB7iQnEwxHXULKdhLR8MAetndqkW3epx3chJMJUH9zVE4BCcimbYH9jmJhJ628KVqku6evyEGMwsJOOqKfkRMy/trUWsvFvi0RLzSEBm2rZHSr0xxnIEUoM5S4yaEMETtg0osq9xwaDWxqLsxImtLMu4iNAz9DD8vpqQPQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB172286F1EA71A42F9D051A0983860@DM5PR12MB1722.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1722;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1722;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39380400002)(396003)(39860400002)(57704003)(189003)(199004)(6666003)(2870700001)(106356001)(7736002)(50466002)(81156014)(8936002)(81166006)(8676002)(229853002)(64126003)(305945005)(53936002)(4326008)(58126008)(54906003)(36756003)(86362001)(47776003)(5660300001)(7416002)(31696002)(1706002)(316002)(93886005)(53546011)(59450400001)(386003)(551934003)(2486003)(23676004)(65956001)(65826007)(6246003)(52396003)(52116002)(16526019)(186003)(52146003)(105586002)(76176011)(31686004)(2906002)(6486002)(65806001)(486006)(68736007)(478600001)(72206003)(11346002)(67846002)(25786009)(97736004)(446003)(2616005)(46003)(6116002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1722;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIyOzIzOjJMWVJGSDlyeDkvSjJwRWtnajd3N1VlcDRh?=
 =?utf-8?B?MTM4MEFxMW5ZNWs4elJvS1JpNGxyL2VqcXNaWFZrOEZ5ZVp1S1UwZ3B4TW5l?=
 =?utf-8?B?dHpFWmFSRHcvOUhka25oSW5kL1BMSW1namRaU0l1NGxVbFAyeXVpQkJVNmxa?=
 =?utf-8?B?RGgxc1FJWEVhZVpqOWowUHdBcC9UekRrQkluMGZNZ1htMXJEcGx6V2lFY0Zo?=
 =?utf-8?B?Ym1vK016ejBoam5nTmxaeHZqeGFPb0ZKVEdCSEtqNEphWmgrOHJJd1RGOTVR?=
 =?utf-8?B?Y0Y5R2hCZU50cVM5cWRYaVk5eXVzRGZzeGxJMkdwZXRHa3MwYmxscmhjUm9C?=
 =?utf-8?B?TlVYVUZnc0o5K1pRNWJ6dkwvQ29ZT1BwNUMwU3h3VkJsbXZ2OE1hdEE0T0NU?=
 =?utf-8?B?eEhsRVhTb2tSWFVzQ3pRZ1MzRmoyM2tiUUZweUtZdFMwQ2pTZDBFQUUweGZp?=
 =?utf-8?B?enJkand2ZWtZcENiR3hITTczem1ZeGZ6cytTN1h4N1RYb2Q3YWt6VXpna2Nm?=
 =?utf-8?B?WUNaVkN1MEJ1elE3Zkc2Z2kxeURMM2F3L3JzWUpidm5lSzE0YjJZb3hWaDRT?=
 =?utf-8?B?V1Y4cC9IelZRMnAzYTluYmgvVFhNQjZGWmFxNXRBdXROQTN0NTY1SzY5NE9x?=
 =?utf-8?B?Q1VkVlRnTmt1ckRZdHVLUkQ1ejREaUNwcFNZSitPeElCa3EyWERTUjAvUE1n?=
 =?utf-8?B?cXhTRUl3RGEydUdTcUpjNFdqTURRMXgxMU1CVXdHM0ZZMGVkWTZCeFdTR0hQ?=
 =?utf-8?B?MnRKV2cxdmYvczNqRGp2emJ5cFlIei85MWRhbEFrUlllNXNxbGYzS0czTDUv?=
 =?utf-8?B?QmM2eVBMcHdtSDMzcFNtUlJEeldrT1pyWTM1dFZwSE1ENFc2eWRiNkdKcytz?=
 =?utf-8?B?QlJyZVU2Zjk3dW42QitJZ3RyQXZETk90NHFudWt1NXRXbTlHdm1RNlJZZUpE?=
 =?utf-8?B?bjRDWUNxbWJRTWpzN3hQWGJYQmw1WlJjZDV0U2JjSUJ1NmtRa05lNVVkTHhr?=
 =?utf-8?B?WXI2SitaTXRnVE0xVjBOaDFSNHRJbVQ5TnUyUTJrb3RiZ204MnozSU94TE9z?=
 =?utf-8?B?V0NjdlpkeTA0dWlHU1dUZy9INnJJVEVpYmhWdFRweklnUktLbmsvcXkyYkZi?=
 =?utf-8?B?cU5NbHVScGUxR014V3FjQnhYaVF4WFI2LzhGaldDU0dRbW9kbXV0Vm5obCs3?=
 =?utf-8?B?S1RqSEs3ckhXODhiYy96QnB1VjJkc3FiaUJyUHBRbDRGV1RRN0JEaEdYY2tT?=
 =?utf-8?B?QUI0TUw3UXlsN3hMUlJoZVdJbEVsc1A2SnBib2NTMmVsRFlQQVg0UnpqK1VG?=
 =?utf-8?B?YVI5aEV5RzR6RjIzYk8rREZjMEIwemJxS2s3NFNlVW5iMmZFYUVBbTdyTVB5?=
 =?utf-8?B?STRNZXU2QzY2THpwcS8zenc5U280R0VEM0pUZCs3ai85dkMvdGFzdzN6Wm1i?=
 =?utf-8?B?dGYxYlJlUzFPSkd2Z2RveDY3S1ppT0NsaTVPbnErNXBnMXpmblVGczlMbzZ2?=
 =?utf-8?B?UEJQS0ZFQjBMVjVObnJ4U2wzaEUxbFNTK05sb3RhTXVzVSt2eEdoS2REUG1U?=
 =?utf-8?B?dWFJK3hGeWZkby8vZ3FrNzZUOGFMYTB6ZWM5eXovNksxVFU0M0hUdG5sbDVk?=
 =?utf-8?B?Y3lZUGJlMVF1TlNmUEJpbUVJVkZiWU9QZ0lNc1BtZ0QrdEl0RE9kbXhqZWFz?=
 =?utf-8?B?dmdPa0FpQXptVGtvak8yUmZFMXBPc1VXaDBlVkZUejYvYVZkaCtOeEJ1TU9s?=
 =?utf-8?B?cnJnRXQ4OVBjdy80djhqSUQ2ekxnYldFR2tSYkhrQkQvY3VqZjN6dndXbjNw?=
 =?utf-8?B?emVCT3ZFc09TUC8rYXRIVUxOSnVoQXNQeU1wYUwvU2FHOFd1S2dmbW0wMm9J?=
 =?utf-8?B?aldJY01ZQVRYUGE3Nm9KaTlQUzNZZEVHQTJRUDYwc2dXUk9GMFhIMFR1VEJB?=
 =?utf-8?B?TFNGRDNKSkNPanhCVHRHa0Nta1p6eXBWOFVDOXdPb29nWHJtb1ZuM3F4Wmhj?=
 =?utf-8?B?TWIvZCtVenJGUWdNblIxL0NBV09tZFM0QXdBZG5zVVh6cTBSMzAwUjFqNVl0?=
 =?utf-8?Q?zG6s=3D?=
X-Microsoft-Antispam-Message-Info: u3HzuYd6FdJOFmE3SOK9P67eWkKnr9G84AHnezXru+syda75PmKA/6PRMz6ruvAu27Dd7ic1Kr347Qwg6vAEi50VtR1RnuOI50VVd4aWBEJz6s/ogiU11CDu2Yrj+YEYP/rLbO9opb4NSNVuNeJvQ3WN5nzW9IfRJbtWz6WAxbNb85lBaSQj1KZaMHdhTgus
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;6:N9FP7AY2d3flzUUCZ76uXsuVGdMx+DZCbhP0Idq+JVSscEKd90BvLCSA/VOpAV5iCj3yDtm8CZRq9K2/T91s4GrB4+3sbQoKzN6EnFt0v8n4pXNt/T05D9YOyXvRnjn2vhx6jTCJ4rLWPBtwGlJoQ5Rb1Rgnv295eAluI16JG4VZ8n+sY+Ih0LCgWo5Psizccf9iv3GELX6rVE3LWqhxC89sNdwYXqM37ajVrcomsP4xUmrDIx437VHYtHrnWtV5osGepZScBhdymIDGyKeQqvgEb3qDaILUcsfbN0Uop9B4tWhtnKDdCk4eqbOqKTQh1LNpvaK6uH/+xwNP+FiwDgLIe7wAFcWCeNT8x0YMj0BxW+ygm/HjYGtAZPQj+dqLttxT4dUKy1m0q75KiobSUKXvLy4amRdcEGX4suCzhCqXdpDJxecOVB1MiOr3YlEzFnCRGUE781n08O5EXd1umg==;5:Ju1kshVmjPBaBbi9L2aw9MxcmCt0p5h8yqq3nywp3n9lMoHG//oP+8G8DyKlofkFYjnqXsZULejFpuVYkiLXE/sB55ofZXrSXvcI6ygSm5hBFXJ6nYw1S83KjPT1+ZTyQsSmfy7wG9nJnZMjnibg2FeZfp0vF4KNER7OQDVhVpA=;24:08SQNYBi5lhD/t06aKqDGJVGdZgs1HL2ycbg2oWodtHe90pLxNb4/DrV7ie40a5j+4Y7rwfnbQ8H3SNeCGRPsia6SzVoBxEqqvgtz6AwnaY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;7:WC0bxDvHr26Ttskds8L57XCqODcCokk8nBAhhK+mbwpw7PA8Fj6Tn6mJgIaJVHbakpR3pURdPWGwx64j1rwRQR9p+dgHCHFpAiZ42oCAmnhYGsByG4/GixiOwzawUZXZ4j1SVNKP/k2JM+ZtivVgqV5jgAFoH9yq5AZqFrVrFSH33jmoj3OnifdC4tePbWJ1i2PJWwzE7EAspmwMKqwUs1gBIu725Oet0yIdn3gmKBrgdDUVxBD8dio5wm/oqUK+;20:lBU04mBkfhy0ze2VvkiMQL5Uw+wjFQNvtVuDamO5jQkyYl3X4CWAKwsQUa82hLw7T0BG42kFChbkWM2G7WX7lCkbsWrUpHDaxxtCsHRWnM93U9DBn3CVFt4XXOEEa2AsWOKA4znCj+MdyY/TayFqU3vzEuESh8LCCoLYzm1sqXf5PZxoLA8a43QBo+iXVzdirSpRNt7i8grJYOCTW2gRFJYPzbA0QmuDuK6OtFqv+ye8zUXatW6OlQuIk0J7By0i
X-MS-Office365-Filtering-Correlation-Id: c28f41db-c445-44d4-4cdd-08d5b1cb35fc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 14:27:44.3223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c28f41db-c445-44d4-4cdd-08d5b1cb35fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1722
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.05.2018 um 20:43 schrieb Logan Gunthorpe:
>
> On 03/05/18 11:29 AM, Christian König wrote:
>> Ok, that is the point where I'm stuck. Why do we need that in one
>> function call in the PCIe subsystem?
>>
>> The problem at least with GPUs is that we seriously don't have that
>> information here, cause the PCI subsystem might not be aware of all the
>> interconnections.
>>
>> For example it isn't uncommon to put multiple GPUs on one board. To the
>> PCI subsystem that looks like separate devices, but in reality all GPUs
>> are interconnected and can access each others memory directly without
>> going over the PCIe bus.
>>
>> I seriously don't want to model that in the PCI subsystem, but rather
>> the driver. That's why it feels like a mistake to me to push all that
>> into the PCI function.
> Huh? I'm lost. If you have a bunch of PCI devices you can send them as a
> list to this API, if you want. If the driver is _sure_ they are all the
> same, you only have to send one. In your terminology, you'd just have to
> call the interface with:
>
> pci_p2pdma_distance(target, [initiator, target])

Ok, I expected that something like that would do it.

So just to confirm: When I have a bunch of GPUs which could be the 
initiator I only need to do "pci_p2pdma_distance(target, [first GPU, 
target]);" and not "pci_p2pdma_distance(target, [first GPU, second GPU, 
third GPU, forth...., target])" ?

>> Why can't we model that as two separate transactions?
> You could, but this is more convenient for users of the API that need to
> deal with multiple devices (and manage devices that may be added or
> removed at any time).

Are you sure that this is more convenient? At least on first glance it 
feels overly complicated.

I mean what's the difference between the two approaches?

     sum = pci_p2pdma_distance(target, [A, B, C, target]);

and

     sum = pci_p2pdma_distance(target, A);
     sum += pci_p2pdma_distance(target, B);
     sum += pci_p2pdma_distance(target, C);

>> Yeah, same for me. If Bjorn is ok with that specialized NVM functions
>> that I'm fine with that as well.
>>
>> I think it would just be more convenient when we can come up with
>> functions which can handle all use cases, cause there still seems to be
>> a lot of similarities.
> The way it's implemented is more general and can handle all use cases.
> You are arguing for a function that can handle your case (albeit with a
> bit more fuss) but can't handle mine and is therefore less general.
> Calling my interface specialized is wrong.

Well at the end of the day you only need to convince Bjorn of the 
interface, so I'm perfectly fine with it as long as it serves my use 
case as well :)

But I still would like to understand your intention, cause that really 
helps not to accidentally break something in the long term.

Now when I take a look at the pure PCI hardware level, what I have is a 
transaction between an initiator and a target, and not multiple devices 
in one operation.

I mean you must have a very good reason that you now want to deal with 
multiple devices in the software layer, but neither from the code nor 
from your explanation that reason becomes obvious to me.

Thanks,
Christian.

>
> Logan
