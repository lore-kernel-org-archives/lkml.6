Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeEHHSR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:18:17 -0400
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com ([104.47.36.61]:37040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754377AbeEHHSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:18:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
Date: Tue, 8 May 2018 09:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: PR0P264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::32) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:JaECHmMBO792wkrQepCNvEaRw2cMY+Huw57y6VeaitbxBFLibgAsGggt7dHdIo7IQJW4pE1l/6SDG0TLxZ/Lrtq586h4yUxdTKe18yyQ0Ty8n0gOKhA1eu4sbSRZF+CuGr7Lsr4gKczdpAeGi5BjZ3sEtQbMcxspTri0WqxRITHtNR6Pj6cj2LBDJmeg3zDlLGhbdy2rLivpsIgxYd3sLNTSoBd6vaEPAl2tT7zGd5AQn95fc4hgKLOII71MATn+;25:xz+nuqXx07X+lce/RTMP0L6oni6dpDXh1wOo9gBLSdy+AVL93bLbBicXiqnYpoVhwY3iDYZer3mB2jSW4rqAjzZ9+qU6zC5FsVk+iqEHCYL1YVHngMOTMMDdYcJzaxz+mquf3KjdlnP0Eo20ncuWrXJR6Lp2nt3DcRvRmg5pQhllWKTST4gMjSV/jya91N2ntTrH9qOv5BWSCf1yRK++dJfPjMXJoF2bXKVSw8PKvJdyD+ipCra9ItlGXr4Sy4dbElB7R9Hpptj5N1lxQ5/yc6+gqwxMSuzMo2Nyf7XifWI/sBFyd4BS85I5dsHS2fls4rn6I2pRO4m8DksbWJQHKA==;31:CD4lX9uESkPy7W1p4yFiYaf4U9fu1ZoQJcVsJskvD3uMleZqvR3ngIa8+OVbF2G5/d14YdjDmZF5Q+p6fduLdp3eVq9W/w5d0MYE3u1/MAJkZil9uwGnlfSscscDaKufmEnqG8NitYDXF+Tl6os6I7R4a+gGFtyQ7tXhYRufe4eIxLJ6sk4EYli4Znkw8bikH3d323tYavgw3LTM5RdENDpHfWktEyN8OUWglqeCIVQ=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:Dn1dX4glpScbxGApWofmsIcmtylFp2VN3Oa4tbQTV7cGNAGTqNfe8i33nC9RoKTGLJ94LUONdO0bl9qho5g8FAWhFCHW+yRp9OPTGD4TyGn1iF7k5yrkb2QXzp+hiua5xQLxY0Rb0rDztgceGp5nRv2tecVLdkM9hDcDW+byAx7oMoZYd6o7RTi9MQlfyasmE6mdueIWS3V/x7FO3Zph1ryR7DTgxAubXhFt4Mty0BnXGdKVmiQrluF9u2KzlJfypVImG0MZvf3PC4nZNRUarROc9i4eachEH+xDYenUR2/gxKUQ9S6Ly0Jupz/0jjQ/U4kuNjzRKk3FUrbC/R9wf2cmFCPQ/IGMUfYuapZA5vpD8fklM9JuuC94R5kfM5hL79L3P85BB92D5lQvr5sJ3ATyQXQ3jy8NvRvyGs052xUeRjlLI7cLS1pjURuW+LePg/X+PhjyfEv5zQVLadg9riGVEtZiPLUigIwnlG5m3QU+AIWN+1KuIHSHIVf4f76z;4:KOfbK1PQbXTqrenck+CpOW2Eu1q45tvExNdi/XAHrK2iIlqRENMrSGpa7uzYK+PcvMeFAa4oiCxEZVJuRreLLbLVPxaO210G8DF12yL2voJqvZyH1JxNEO0I8umDTyfr0Mn9YTEUWiPATA4CB2qpPHrQQ1ACACctv6bYYsRj6sddyIhORgBAGYmS33TwORwCv++ytgOQI4+7iGn0nXsxiTdyzbwFrC6y5lHzuOW0ZaLlkeGf+R3YezJHoODTT9N721LaTDknK4iR/OVTrM4rtQ==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1714222B1ADF469308257DB2839A0@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(39380400002)(199004)(189003)(54534003)(97736004)(65806001)(65956001)(2906002)(230700001)(6116002)(1706002)(7416002)(52116002)(52146003)(31696002)(52396003)(386003)(186003)(2486003)(67846002)(86362001)(59450400001)(50466002)(64126003)(23676004)(16526019)(7736002)(305945005)(68736007)(8936002)(81166006)(8676002)(81156014)(76176011)(54906003)(46003)(5660300001)(65826007)(105586002)(106356001)(31686004)(446003)(47776003)(11346002)(316002)(2616005)(476003)(486006)(36756003)(478600001)(6246003)(4326008)(72206003)(58126008)(110136005)(25786009)(6666003)(53936002)(6486002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOkhTODl4MFFmMG13SEpkZVk4Q1pVN1BOYjVI?=
 =?utf-8?B?VFIvSkw5eU00Lzg4cEYrY2NhbDJTQTYxNUk4Z3dUeXVZZUhBVjZYY21oWHdK?=
 =?utf-8?B?UFhoSTNBNnZDTUhqa3hxVEFsUTlsRGF6all0Q0pQc1E0Z2dHOTlHQzRTTTZa?=
 =?utf-8?B?bGJodk1mRm1TNFNHNk5rREg0QmVwai9MVXRtWFFuMkZHaDZBU0phUURzWG40?=
 =?utf-8?B?N3RMS3hSR3lmU1BoQmxkUGFZNGpRUzgrdWxybktxdUszNFAxZkg1cE42ODZk?=
 =?utf-8?B?dklGNzBLQXNLUHNNU3pPb2UxeWdUb3p4OTRvOElFT1hGOFZlTHJvWU9SaU5W?=
 =?utf-8?B?R3hhVlA4bDkvR1RWcXVNS0dNNEt5c0cwaHFSdVd1aU9xMW9TWnVVc1R4dUxZ?=
 =?utf-8?B?VmpSTFRKQUQwb1p1ZWxnT05yRFBSMVVsd3EvQW1EZzdxNVV0MXJzcHdFSk9D?=
 =?utf-8?B?d01Ta21TMFloSThHN3BLNWZ1aWVvcE94RmZTN0xzdyt1L08rQ0ZGQURiRVBZ?=
 =?utf-8?B?bjErb1Rma2Q2U1pLVjhBVzlEQjJHd3N1dllyYkN2WGtvbG42UzRKNXZtbk0y?=
 =?utf-8?B?RTZaSEM1L0pUcEJHZFJZZW1ZVVNzSU1WWkRhWEdaZXpPTXZaQTdQSEVZSkZr?=
 =?utf-8?B?bEZ6RkNJUGhqY0JZaHNGc01EQkpUVGNlbDhEOFVodThISU5TWDBybE45Mis4?=
 =?utf-8?B?UUZIeWtncVAwa2ZuWVVTT24zVFdCekpLTTRFMWF0b0FzMHhRMVp0UTFMdFBQ?=
 =?utf-8?B?V3NFU3BneW1zcnRzSjJseTlTNW5IckhhbHVIWktVV1FSZTFBc0MwczdMM3VR?=
 =?utf-8?B?bk9GRGsvc3BtQ3pCQm5oOHovQldaTnNFVmp1dURpVFdRemNNTFRwZUlReXhT?=
 =?utf-8?B?RVYxK013YXY0V2N6QWFsczZxd0lNS3ZhMFlNYkdnbHJ5a3pSRzI3V3RqS3R5?=
 =?utf-8?B?bXVOYlFYWkZzSVVYNExOSWZzNFpwNFRncnU1SG1EREN1ZmhmZzJFc1JPMFF3?=
 =?utf-8?B?dVg2dGNLM0RMbDVSMm53S2RlbGg1VVhDK0NSRjZGSjY3aEFpOHdFekVoRkNX?=
 =?utf-8?B?OTdwSEJ4cDJnMWZ2bVRXL3JpOTJkM3kvU2tMcGduTU9LeDAzMW5nV1FDZWx3?=
 =?utf-8?B?R0FoSDNyL2RNVUlnZzlubGZGTjNGN3BzSU0wamo2aUxHUEdsRy9kb2xUUkNp?=
 =?utf-8?B?S1pYSzRQVFdVb2lEUzFsQVF4NEFic1UzMlNsNDBrc1BqOXQwdFkxWlJKVVUw?=
 =?utf-8?B?NUswcUFESXRpN1k1aXIvS0U5MWVVNFhpU0I4UjRVUC9VaG1ndXU3cFZ2K2Q1?=
 =?utf-8?B?N2ZTa2dVMEVqY3QwK1dpaFVzcEQ0V1ArOW1qRnVzbjlOb0V5Q0RVbDVEVy92?=
 =?utf-8?B?RzYwbFkxT29mMlN3aU92K3R4aldrYXBwbXZYdXBuZ1JFTGNrWlo3WmFWaHJJ?=
 =?utf-8?B?MWp3NWU3TDVsM1UyQmdqalV1QW8zTi9oWjNOM3p3U1VUaW1malRBcU5GaW9q?=
 =?utf-8?B?aStDbDFUUmMyRGNXV3JrTWF2THRndVJoU3dYYUYySHlXS3UvREE1NVRGTGZ3?=
 =?utf-8?B?ZGxTV0cwVXZ3TjdDMWVhMFFXQlZOLzd5M2pDaEx3OEdQWkdUNUh0OU9yYXFK?=
 =?utf-8?B?Tk43d2taNmk1RVNOWGZHSmtkbE9LbW0yOTVkVFhaTU14YlRzNTVZdUloZHpT?=
 =?utf-8?B?NkllK3ZPRU11a1NGRlA3RVNmQ2NMK3JTdGhCQndxVHZhNDFHdUtuS1N3azhD?=
 =?utf-8?B?MGp4N1BrK3FZc2JacUR5SmhqY0REOEZmdDl0eXUvSE02UXlqV0I2YzU5KzRq?=
 =?utf-8?B?NGRmcStleHVjeE81amE2MWNoQmljL2Z2bldHVy9EcG5sZ3JUbGYzOEZUSklB?=
 =?utf-8?B?OXZJSDl3c0hnMXhNR05mNTh6c0l5ZEtJR2xFbnArbTlIN2RsMEVOaVhlODZJ?=
 =?utf-8?Q?reDIN1aRRaHpCon0xS4ZGUmfUWB0pE=3D?=
X-Microsoft-Antispam-Message-Info: +9GiKPK6VRgW0x0JqSbBRLNCi0Xs23o+Iv9OYTcXVIA5lqhv245Uuy68THGd1l1axZvTooOFa7dQopFOShp4BP8P+ztWOkTDuj64o9fFxUYKY64HSwjGnrNlQe7bstLIeMXB/+SZ+5Amx5ihMFSWLilfLTv1KH0D/5mqJLpDwU2yqHw7EQXvoUCLkEMqdsD5
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:ja4qzF6G1uMEOKMSBOE8NXT/4gdoLpPgnsCu6VXLmliv/iWrqUQRlRMi756MFd6xYf5RL+FL2qiUCo66kskUnngifGO4QdhH6WrrgZMam48u73T0ceEFibotahOFef2qAkPbzMk6qOuRolrOpseEGJ8YjdWFHzgOfrML7KUcoRYEhlhEsJHKFdIQ+Idp4kG8gQ3bPa3/fIznDF1aq3c064+X0zNVKW1e8jAk5C7yyYqe/DZgNHl4SHmRQ1fSwnbjRhgCXcXPG8hf3ko1a5731t4sVL3ozQWaWbg01wzWL7MEt219R9fwgPoREan8Z/uzx8FQ+Pvjhe6u5p7gx7r1GEPnq7hhDwXLAAjO9nKXrHPl7BPAsvAC+rW8ohrXsCIAK6LMbNZxe4O02hE0QriZ8PUJrJe6eOHoZxO3YKHwEfXE4bc6f3guTXzH2YmyZFvCeSWfUS5bisWYeLIDf/1zvg==;5:aLerR6xgif45F0Sm3EPSR5B9R35Fu6r0wqiQrI+cKay3rrrL02oOcW7nxbgoF3wFJpO8bXL6BOXMauywo5LNKp+MeQl5G4y4EOtF+8f9wMlZEoT4TxwA8bhGCO1gJCdNZDWDIZ7p+2NeKukkRDNAnWMect3Yt9y6GOaLhNo/USE=;24:xeAtJgkV/w6jEnopdz3vbCQTnpZ4Dos4Yl6HgtGc5D0e4T8rsjy+XERTY/+os/eIjwDcp6qHLsI7ZcqxrqAewhkhnPg3eG56QWpbmOAmlg0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:OmfcTl5aV23p9B6tdERgldYYgwjzBNynA08U5NWCaxcFk1rT7WtDvXLEtR/bQbgUoXDaW2SUz2NzKHqK/+jBN98GAnvotpmcejnzNze//IeSgE/fZmDOYjq+HjMcq0VOOBF0asllXEyaq0Vw2V/F1uUVqVNN0jQkxqVD4ClDy7A5+WoPZC8PlbEWh2NLwPQYlOOJk03SG68NsOImV+s2enc/UDXr6T7p/j9Uv3ma87FSTTCRB2kR6UszlYjqlNkv;20:AefRQhRCqfllD6+SoIzFbDtPrBFacp7ktjuuFECf6MwpNVFdny+8sYSFfmW7zM3zPtMCLYR1/lQXuzANesia0KQL8AQfGrot4aNBlimZTbZq51wmBAEE+0eEqRsxvV06LGGCUBFAg1DgVwxqR578C7SJFlXTbni/oQqQpiLuyPjjEgaZBlUY7Rbw7meF/g+gVPxSojPptLUdVikOufIdnhOS6c07L3n8oRWsSGLI3qazh3xhxtD2UBJEcmSwvHDC
X-MS-Office365-Filtering-Correlation-Id: 1c669102-cf6b-4b73-2e58-08d5b4b3d7e7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 07:18:02.5315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c669102-cf6b-4b73-2e58-08d5b4b3d7e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Am 08.05.2018 um 01:13 schrieb Bjorn Helgaas:
> [+to Alex]
>
> Alex,
>
> Are you happy with this strategy of turning off ACS based on
> CONFIG_PCI_P2PDMA?  We only check this at enumeration-time and
> I don't know if there are other places we would care?

thanks for pointing this out, I totally missed this hack.

AMD APUs mandatory need the ACS flag set for the GPU integrated in the 
CPU when IOMMU is enabled or otherwise you will break SVM.

Similar problems arise when you do this for dedicated GPU, but we 
haven't upstreamed the support for this yet.

So that is a clear NAK from my side for the approach.

And what exactly is the problem here? I'm currently testing P2P with 
GPUs in different IOMMU domains and at least with AMD IOMMUs that works 
perfectly fine.

Regards,
Christian.

>
> On Mon, Apr 23, 2018 at 05:30:36PM -0600, Logan Gunthorpe wrote:
>> For peer-to-peer transactions to work the downstream ports in each
>> switch must not have the ACS flags set. At this time there is no way
>> to dynamically change the flags and update the corresponding IOMMU
>> groups so this is done at enumeration time before the groups are
>> assigned.
>>
>> This effectively means that if CONFIG_PCI_P2PDMA is selected then
>> all devices behind any PCIe switch heirarchy will be in the same IOMMU
>> group. Which implies that individual devices behind any switch
>> heirarchy will not be able to be assigned to separate VMs because
>> there is no isolation between them. Additionally, any malicious PCIe
>> devices will be able to DMA to memory exposed by other EPs in the same
>> domain as TLPs will not be checked by the IOMMU.
>>
>> Given that the intended use case of P2P Memory is for users with
>> custom hardware designed for purpose, we do not expect distributors
>> to ever need to enable this option. Users that want to use P2P
>> must have compiled a custom kernel with this configuration option
>> and understand the implications regarding ACS. They will either
>> not require ACS or will have design the system in such a way that
>> devices that require isolation will be separate from those using P2P
>> transactions.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/pci/Kconfig        |  9 +++++++++
>>   drivers/pci/p2pdma.c       | 45 ++++++++++++++++++++++++++++++---------------
>>   drivers/pci/pci.c          |  6 ++++++
>>   include/linux/pci-p2pdma.h |  5 +++++
>>   4 files changed, 50 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index b2396c22b53e..b6db41d4b708 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -139,6 +139,15 @@ config PCI_P2PDMA
>>   	  transations must be between devices behind the same root port.
>>   	  (Typically behind a network of PCIe switches).
>>   
>> +	  Enabling this option will also disable ACS on all ports behind
>> +	  any PCIe switch. This effectively puts all devices behind any
>> +	  switch heirarchy into the same IOMMU group. Which implies that
> s/heirarchy/hierarchy/ (also above in changelog)
>
>> +	  individual devices behind any switch will not be able to be
>> +	  assigned to separate VMs because there is no isolation between
>> +	  them. Additionally, any malicious PCIe devices will be able to
>> +	  DMA to memory exposed by other EPs in the same domain as TLPs
>> +	  will not be checked by the IOMMU.
>> +
>>   	  If unsure, say N.
>>   
>>   config PCI_LABEL
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index ed9dce8552a2..e9f43b43acac 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -240,27 +240,42 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
>>   }
>>   
>>   /*
>> - * If a device is behind a switch, we try to find the upstream bridge
>> - * port of the switch. This requires two calls to pci_upstream_bridge():
>> - * one for the upstream port on the switch, one on the upstream port
>> - * for the next level in the hierarchy. Because of this, devices connected
>> - * to the root port will be rejected.
>> + * pci_p2pdma_disable_acs - disable ACS flags for all PCI bridges
>> + * @pdev: device to disable ACS flags for
>> + *
>> + * The ACS flags for P2P Request Redirect and P2P Completion Redirect need
>> + * to be disabled on any PCI bridge in order for the TLPS to not be forwarded
>> + * up to the RC which is not what we want for P2P.
> s/PCI bridge/PCIe switch/ (ACS doesn't apply to conventional PCI)
>
>> + *
>> + * This function is called when the devices are first enumerated and
>> + * will result in all devices behind any bridge to be in the same IOMMU
>> + * group. At this time, there is no way to "hotplug" IOMMU groups so we rely
>> + * on this largish hammer. If you need the devices to be in separate groups
>> + * don't enable CONFIG_PCI_P2PDMA.
>> + *
>> + * Returns 1 if the ACS bits for this device was cleared, otherwise 0.
>>    */
>> -static struct pci_dev *get_upstream_bridge_port(struct pci_dev *pdev)
>> +int pci_p2pdma_disable_acs(struct pci_dev *pdev)
>>   {
>> -	struct pci_dev *up1, *up2;
>> +	int pos;
>> +	u16 ctrl;
>>   
>> -	if (!pdev)
>> -		return NULL;
>> +	if (!pci_is_bridge(pdev))
>> +		return 0;
>>   
>> -	up1 = pci_dev_get(pci_upstream_bridge(pdev));
>> -	if (!up1)
>> -		return NULL;
>> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
>> +	if (!pos)
>> +		return 0;
>> +
>> +	pci_info(pdev, "disabling ACS flags for peer-to-peer DMA\n");
>> +
>> +	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
>> +
>> +	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR);
>>   
>> -	up2 = pci_dev_get(pci_upstream_bridge(up1));
>> -	pci_dev_put(up1);
>> +	pci_write_config_word(pdev, pos + PCI_ACS_CTRL, ctrl);
>>   
>> -	return up2;
>> +	return 1;
>>   }
>>   
>>   /*
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e597655a5643..7e2f5724ba22 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_pci.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-p2pdma.h>
>>   #include <linux/pm.h>
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>> @@ -2835,6 +2836,11 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>>    */
>>   void pci_enable_acs(struct pci_dev *dev)
>>   {
>> +#ifdef CONFIG_PCI_P2PDMA
>> +	if (pci_p2pdma_disable_acs(dev))
>> +		return;
>> +#endif
>> +
>>   	if (!pci_acs_enable)
>>   		return;
>>   
>> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
>> index 0cde88341eeb..fcb3437a2f3c 100644
>> --- a/include/linux/pci-p2pdma.h
>> +++ b/include/linux/pci-p2pdma.h
>> @@ -18,6 +18,7 @@ struct block_device;
>>   struct scatterlist;
>>   
>>   #ifdef CONFIG_PCI_P2PDMA
>> +int pci_p2pdma_disable_acs(struct pci_dev *pdev);
>>   int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>>   		u64 offset);
>>   int pci_p2pdma_add_client(struct list_head *head, struct device *dev);
>> @@ -40,6 +41,10 @@ int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>   void pci_p2pdma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>>   			 enum dma_data_direction dir);
>>   #else /* CONFIG_PCI_P2PDMA */
>> +static inline int pci_p2pdma_disable_acs(struct pci_dev *pdev)
>> +{
>> +	return 0;
>> +}
>>   static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
>>   		size_t size, u64 offset)
>>   {
>> -- 
>> 2.11.0
>>
