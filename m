Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEKIxN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:53:13 -0400
Received: from mail-by2nam03on0068.outbound.protection.outlook.com ([104.47.42.68]:24068
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752165AbeEKIxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:53:09 -0400
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
 <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
 <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
 <f0101988-cf82-7ffb-2aca-d3b8d2f4b504@deltatee.com>
 <868B49CE-4F0E-4A48-BE78-12149F85F1A4@raithlin.com>
 <8113cba8-62b9-1801-7a77-f82be223b183@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cf2b92c9-7c5b-f19c-b5b1-2f2d435296d1@amd.com>
Date: Fri, 11 May 2018 10:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8113cba8-62b9-1801-7a77-f82be223b183@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR06CA0004.eurprd06.prod.outlook.com
 (2603:10a6:206:2::17) To CY4PR12MB1719.namprd12.prod.outlook.com
 (2603:10b6:903:121::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1719;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;3:QIvnqiiPXnNXMBJdSPYIg6s9nt2rvMOikJEeGxbBpeIVIQEG/3DpNkXxuHab501prSDiKKOv0ipFMrMPe7g8BgKYrFb0imGtrP0sf3jW9z+D4Ld6Dp5Cie9jjftxMJdGyTD6NX//tO6dlM/WSvdR2BQ/oksIyBcp6H8g+vER5ReRTSHpg2VmH0JGWZGKlJWX5iHoO6PWize7HKrclmS6sJm46KaJOYjCsQ9To8i3nOT32C6y5H18ycL+Y3UW2vXs;25:5lnnqxWi+bhhwYvWsTrXQJ0AmwiDy1JJQgpcnsaWQhuPw+hfHNkJxdsiShgKINj1BBLsB762UD88PbSoqFktmJ5517VeaHIdnsy5pnepChf/QShGXNrfy+PlPugixmoU+Y/rfNAOUVAM9V51uwh5e5txhC/FfaSYd7QFtwCxFiNCtJM/fHEotIypuzdCDMiybHFhK8oKBf4hWI+AeBi773k62BnOiKAfRRtiZzxFNjitRlSvgLK/hqjfLEsoI8jhdXq/+DDEEJy95zKob7EFrCUna6FluxZnJKky4Y+8iaXqAHhBke5b3bjhEAIA9J9GFVdpX6phiri1lnr/JhkA3g==;31:vFfSwvhkZJQnoBf3JOOZibdXS2/6TvdqXIHi+L0cGPCb6vRp0+i+YaabeM2UtLBJ3WeEYjfu8JCMbItks3um0E2ab8QGINcjO6eSu7QGRr1Rj6TdiC/FS++0s9cozSefM0krzchW2Uz8ukIp7g7tndmIBui80Uf9KX6l/YRsZOtRuGp45q/2HohCNipaRNB/J8LzkuzyoT5Yq1ATQ3DM0K7r9SbcZpLq6h0E2I+Z5rE=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1719:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;20:9/5942xrMI8K/mrw6O/up8siPWB4nkrriAikpTk/7p2dQeQpKUYGza/sBycH0wSc+nQYPrseAPOLuLFiIwV8mBoc7bhs6b1Y5rGCWMoMCJoC/VJOkUyz9NC1CJpRHm5sPR5yYrST/IsJXdEplh6chUXu5DD5osHaeztnkYZn/sWtm5+irsVau5MHptItx3Ql4B8t7ZaDl8419V28CW5hG+IJf2DuNWvC51ll0VonJaFaGRyq9XGUI06Lnxvpm1EaogjWy8fRE/I66euUFqeWi9QgZOEBE02mP7ribeDjTgIdGhjHr/qqH0K8fIo2BEFnU7ctVKbkrzj+/ymqdfBiW7Zq33yxnbVBSKiKqHI0luMrKfcpUpqzHE6QuNJFeIlapzKiAR2FIchd5YroOVkDvLs9CYCjNWV6mOMIvzvmc58VXjahk7fUct5yTPkaaKzUL3QN3X49REDyrxKqeb2CxUhkEgWpr2iyAfvX4ZXUYnwU2587wQEGXAIyNM4xMkhu;4:k5PBftpZ50giYTjXiBt7OVrh9+kJIDv57JRVUMSkujxHXqh9csSC/bkvQlaTI7Xcyt0Y/9oHca7FEcbcVN+3OvaxU89s8yOCi6FMaekYXMGXz72jAzLOCvb25SIGDQo/epFo05HjgQHSZN+BM/NCDQtgQjWONngYBGkMX/DyLwBEBDBiSHHM3FN/3FdsURy9Tm4AId6f/b3YNoSR/MSdWs9ezmf8WgDOUDfgLkOsLqm9t+Z82lNqPNS8W0ocaoSRlMDbbPsAvHNPuFBPpbcuCg==
X-Microsoft-Antispam-PRVS: <CY4PR12MB17194F75D06B42FB892EFB0E839F0@CY4PR12MB1719.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR12MB1719;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1719;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39380400002)(39850400004)(396003)(199004)(189003)(65956001)(50466002)(53546011)(25786009)(65806001)(52396003)(64126003)(46003)(446003)(551934003)(2616005)(65826007)(106356001)(105586002)(486006)(11346002)(476003)(23676004)(6246003)(16526019)(6666003)(7416002)(31686004)(186003)(76176011)(52146003)(5660300001)(2486003)(52116002)(53936002)(97736004)(386003)(305945005)(8936002)(1706002)(6116002)(2906002)(229853002)(230700001)(36756003)(47776003)(478600001)(316002)(7736002)(54906003)(8676002)(72206003)(86362001)(68736007)(93886005)(6486002)(31696002)(110136005)(81166006)(58126008)(4326008)(67846002)(81156014)(60764002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1719;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE5OzIzOkR3dlN6YUhKZklQMDhaSlhBYVVoZGhudHdv?=
 =?utf-8?B?NzJRUlBIcGE3dGtVRDkwWnBrWDczWEp5ejlUSFhxUFhva1BwS0JOd2F1bTRB?=
 =?utf-8?B?dTh2Y0xOQy96Q21JWkNpRk1DQlh0em1pSU9QSEovQThGZU5Id1FjUWxTNHpI?=
 =?utf-8?B?VkpVU3hWbzEydStiSXFHNlRlZ0NONEdpLzN3YUxHbDA1L2lFeElnQ0ZuK0tJ?=
 =?utf-8?B?UU03OFBKWmZoeldrNjRNS05lMG9NdXEwQ2ZFczFrZWNJc2JUUWNvQ0V5YlNl?=
 =?utf-8?B?SmJzbDJaWjVGb2tvclZOaVNGNTNYYXdSN2tpNXNMUVkrWFQyWWU4V09uOHFo?=
 =?utf-8?B?OCt5SlJZSHVuOSt5V0xNcklEM3NJU3dxbVBQMERFZjB0RU5LOFdXaEpaQ3pl?=
 =?utf-8?B?UnhENEN6YkJpcEJRc3huSmRpK2djWGlZOFArSklyUmQ0TjhiaW5Bb09wQkdi?=
 =?utf-8?B?OWp6bVFFOWpVZDBZSkZSdVZyWldmay8xaVc1OUI1RXdqUWVUb29HemVtU3Fw?=
 =?utf-8?B?Y0ExaVozNGs4dnVULzNXcXdvRWlGamhXc0prQ1ZaYTdzVGxsS0I0Zmh1U0J2?=
 =?utf-8?B?Z0V5ZE11dXEzQm9IMTh3dFFlWjJkejRIUk5aN1ZOQ2grTHVLd3Znc1FRYVND?=
 =?utf-8?B?Um1Tekt4dGdYRTk5R3J2eGNNM2FmTUFpQ0s3eWFsR3YrZy9OOG01R1l6a0Iw?=
 =?utf-8?B?bHQ1Yy8xTWczc0QwNURFUjVZRElXWWoxRUQ2Tnh5bVNCbmUwZjNlQlZmbkVj?=
 =?utf-8?B?VHh5ZStGT1J6TGJVUWNJWE15QlVWS3NyS3V4aVFLTUZ5Ry82OWlTVmErTnhh?=
 =?utf-8?B?MXlxa1h0QmRaWmlTYjBnMW42Ym5XUEFYekVMY0Q0b1hPY0IwR2cxTkV2dUl5?=
 =?utf-8?B?OU1YamUxWDdIUEZJcUt6RGQvMEhTRkpqQ2FHQmFXT0JjT2pNbWNBempVMEY0?=
 =?utf-8?B?SVdmM1Y2RXB3WGpIQjlsNUUxeFprd3RWaXN5NlNnRUZHK2FWTEtjd0VkOElT?=
 =?utf-8?B?ODJPc3podW9nemUrNHhMMVpXS2F1dEdrTGE0OEdLUVdMY2xKcE9jbzJkOUhu?=
 =?utf-8?B?ZUdIcEMzT0hSN0tBd2FPZURSMGNpdWtRbzdLK3VDSUhnbHpqZGsrcnF0VSs2?=
 =?utf-8?B?eERveWIwb0RhQXVkc0MxZXI2bkt1OGozMm00dHFHOW9FRHpkSFVFbTExa2NK?=
 =?utf-8?B?SE4wN0NTTnVGQ1BjVWxOTVVHbGlpU2JhRmUycHc2UkRMUm90S0U0Nno0dEpl?=
 =?utf-8?B?MnBuZUtyK1BDWEFiWHZqdlRoSkY3aHpEUkdpdE11SnYyNEUxbUhyL0hwaFZk?=
 =?utf-8?B?UzgydnJ6Vjk5MWlKWWNPMWVTY1IxMUgzbUNibENKNFYwSHJiVUIveUFMK2h3?=
 =?utf-8?B?YXU1OUVuRUt2MkQ1bkg3UVgycXhYV0MweklwalQ3aGxqci83Rno1TDBxRXFW?=
 =?utf-8?B?ZnViNUlWK3JFa1VlVGY4OWpPNkZjM3hmekpmU0NKVUxGdGVVc1RWOFQ3ZHAz?=
 =?utf-8?B?LzVGY3U5cVFSVUJNb1N3YXhicGdjdzBIOGRCcVFNRlhiVTVCTEFGNEtoT3J3?=
 =?utf-8?B?OWl6bGhCQ3Q2eXowNGJpSFZyWTU0OXdHRWo5alBaQUIxczJ6bWV5dURLY21P?=
 =?utf-8?B?ZWtoeDdSaFZtSTZ3dlV5Y0tWWTY1NGloWVoxZFN2bXVaYXJwdmtXYllyTHNI?=
 =?utf-8?B?THdTRTVSYXI3ei96YWl2QnNpQmNheTFvbnRDczAzbzJXRmc0R21GSnZxN1kx?=
 =?utf-8?B?ekZyRWNWSTRzRys2S2g2RlRYN2dZSjVtTGxLbHBaaU1FQjdKODFBNE1NSmtn?=
 =?utf-8?B?dDhESjlVNG1qa243ZDA2eUY2MXZlMC9rS1pwNXpRemJIUC9GT2JBcWZnVmxQ?=
 =?utf-8?B?dEMvYjdoNDR2OU9ERFJGaXU0cU5zOHU1VWFBdXJGNFFPWXVOYlZySUJPd3M0?=
 =?utf-8?B?aXRhY1pRUTkzeDV1cjB4emJQTFFmWlNReU42OExzVmd6QzZwY1FGb1RxWjZ5?=
 =?utf-8?B?dTlXWFVRVXgvVFFWc21pUDRDV0I4dXlpSnY2Zz09?=
X-Microsoft-Antispam-Message-Info: 7v2jO0BW3AS5UQKHeBwVEWhiK9hQNfn9xk9/baNLewSyNN2/ZRadTkp8oZn5uPODnqmbTUH9Kx3qxcrtsNx9WOMn7n/fIWTultyXzMLRgG1r3JwkNvlPMWY2DRsqVcog4PhrSxp1gPoUmtr/V84/zXkfNbH+TuwNdCg5tSR0yfjG0/30epzjnc3k2JBJ881i
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;6:lE04guHlnSxSsRBLz6qxQckaRy/lklI00uufyIBW8L1RlUWsfX0ad3a6GWFGVUA4HtOm1pwKExkqpi53eUNdtLOOPRNF5OvQDwIzAppZIhKemghDcnhpEcYAbx9iGyxqC50CZwBxOp1vb7hfF1m9u9zMKvztpn1LemNxZgebiYg772gQ9lYDHIgwqkqldjxcjpZw9u0HxpnezMvlahPHmUqndRQb7mmJQvTlEYE29kcc6DkEweDib9rTLWFnoZMfDlZYV/vVGurJn6DHSg+cEFI1CLQRW+0VH3dzvwGxGafBqX9/Gbg9z0Ib70zJD1/CoFWd5miBVGNoA81U/qL9yKPnO5/qYm+BmgU9DPtNGAlzBy4G17gh/U+7Pl+oFjakGJKG9BijG2wtVYEALYYg8MgPn69ViPkvzIYkPaakdGhzKVJemzvK5WASivgpuK+nH4OjumdQElUMZ4kGYgloiA==;5:ynPoWvgdrwstwl+Mu2I87/qk/jfIaW3TgrxJlQHsKkw2E8zXbfiK9xTqc+Eo/+IvbGXBgbNECgBhoRww64ifB2uFgDoBKafM/JX3xxF6bhNSqNh1r1OjiYSfOolr5jEnWxQEWMNZz++33wRsTyAbHVUyi1lEhAYEHYnCrv7gTqg=;24:T6vSHM/jyj1qoMqhr6ndoRjBdKXUOnmWFiff37whfm2l70jATUZd4P9bDUtg6qGJNWHXwAY2XMPiilldE0j01rr+fl21M8Mz6Qo5ShUCGvw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;7:J9JVoOShxANaKPnNs9xZo/0v1z0sy7euNfwVgSlx0owNKYWuNaQz16hNXMWu6qKfqR5XbzmUeO4eQllEuBNsu8fvouxB+eoR8y84Bzfy3gmoyk8VLGeeZBGapBogWyYmHbxRBhA7hc4d8PtlR9ciSVk65geqSisJbX6PSb3k5QgaXHpbRFwPyGSK9/adYuMHu2HF37AOmx9RPGMhtzmNa/+9UiD6fImH17R8vNqPldhJmgnP8jshcUVFhHLHxu0o;20:0eOYA3+XyiVSyRkgqswF74+Ymwo37AyQZgftxwXXW6d78/L6DouFS7NCxibEYg3DDKKyX6MDL+dL2COmwwri3R6nHh/EP5FTQZmuZ1IgFite5u4OTvEZsE40lNWEemAHUt0uM01LTeonecd/zDuaLBqvlzy8oUFBY0/VeL0FDYCwAKSHkzY1Y/vI2PFQDpNmFsUQ3zK0xRZQCdlPd3AWYvggriLK2A+OMXfQUswTVvwLYGAhpjp2q8yK9PONCJYn
X-MS-Office365-Filtering-Correlation-Id: 61e5e8c9-43d8-400a-bea8-08d5b71c9c74
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 08:53:01.5122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e5e8c9-43d8-400a-bea8-08d5b71c9c74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1719
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.05.2018 um 19:15 schrieb Logan Gunthorpe:
>
> On 10/05/18 11:11 AM, Stephen  Bates wrote:
>>> Not to me. In the p2pdma code we specifically program DMA engines with
>>> the PCI bus address.
>> Ah yes of course. Brain fart on my part. We are not programming the P2PDMA initiator with an IOVA but with the PCI bus address...

By disabling the ACS bits on the intermediate bridges you turn their 
address routing from IOVA addresses (which are to be resolved by the 
root complex) back to PCI bus addresses (which are resolved locally in 
the bridge).

This only works when the IOVA and the PCI bus addresses never overlap. 
I'm not sure how the IOVA allocation works but I don't think we 
guarantee that on Linux.

>>
>>> So regardless of whether we are using the IOMMU or
>>> not, the packets will be forwarded directly to the peer. If the ACS
>>>   Redir bits are on they will be forced back to the RC by the switch and
>>>   the transaction will fail. If we clear the ACS bits, the TLPs will go
>>>   where we want and everything will work (but we lose the isolation of ACS).
>> Agreed.

If we really want to enable P2P without ATS and IOMMU enabled I think we 
should probably approach it like this:

a) Make double sure that IOVA in an IOMMU group never overlap with PCI 
BARs in that group.

b) Add configuration options to put a whole PCI branch of devices (e.g. 
a bridge) into a single IOMMU group.

c) Add a configuration option to disable the ACS bit on bridges in the 
same IOMMU group.


I agree that we have a rather special case here, but I still find that 
approach rather brave and would vote for disabling P2P without ATS when 
IOMMU is enabled.


BTW: I can't say anything about other implementations, but at least for 
the AMD-IOMMU the transaction won't fail when it is send to the root 
complex.

Instead the root complex would send it to the correct device. I already 
tested that on an AMD Ryzen with IOMMU enabled and P2P between two GPUs 
(but could be that this only works because of ATS).

Regards,
Christian.

>>>     For EPs that support ATS, we should (but don't necessarily have to)
>>>     program them with the IOVA address so they can go through the
>>>     translation process which will allow P2P without disabling the ACS Redir
>>>     bits -- provided the ACS direct translation bit is set. (And btw, if it
>>>     is, then we lose the benefit of ACS protecting against malicious EPs).
>>>     But, per above, the ATS transaction should involve only the IOVA address
>>>     so the ACS bits not being set should not break ATS.
>>      
>> Well we would still have to clear some ACS bits but now we can clear only for translated addresses.
> We don't have to clear the ACS Redir bits as we did in the first case.
> We just have to make sure the ACS Direct Translated bit is set.
>
> Logan
