Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeEBLvr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:51:47 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:32708
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750936AbeEBLvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:51:41 -0400
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b8acf835-df94-9967-2327-8f0e39d88511@amd.com>
Date: Wed, 2 May 2018 13:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423233046.21476-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR0301CA0015.eurprd03.prod.outlook.com
 (2603:10a6:3:76::25) To DM5PR12MB1721.namprd12.prod.outlook.com
 (2603:10b6:3:10f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1721;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;3:UmzSzqp2yx+fTtrhmdPzhdbtnn8l8JPiGrrmKGOVi2d9Ci0MwoGnNZDdEVG9lgnFv8GkUB5gb11d6ERCfI63frs7i28Zx1EDBqJstamazjHzch4DyaZV3b0uR//L+ta7JWTYjR0rjKN9Wz2lUjboG+/tIvBlnoz1xa67ssq8o7Z2K1Te0yjIYsfmmVfpF9LCY/wZZ8Ol4Reqd4u7KLo30uJAKdR2OUoCCqQ/Zm6XwqO5JHelSD627NDALp8Uerp1;25:oDz3MwcM3TjTy1qc3oU4/x7+fecjydKOuThnV4RmuikyPiyvlLIiF5nz0ItDnM1j5pNGj4/PjfI05OfqYId6Saldx6RzdLYxYWSKHqJyjBfRf1TWpiHvcA02luktklCOYVA/AdrJDwjDp77EMt4QIgc1Lbaa7N7dFY7YMtOZfeMLf8lbm3gm3Hb/5aXk4UdSRm8uxR+I/3yEKkIuBAx4FAi4+JxTfy3gyvP19BhrfB5/9dHhCqArDcXJWQ8hwE3OYvfvC4Ffb2gt1Z5qnASw4hn5ezanBIo05Ylwp64LS0+MYPeTeXT8qO9iGmokJU8aVlT4LCLGVqYusm0gULURLg==;31:U4uBQt60I8DGJ7rxeK2Km4/gSEbM22Ry8pgyUc1N0vOqNmeXkucWJRn47wvCrYDHj4ST5bR7yHQmcR0Z4+5jKb6F/e43t59yWPZ2F0PtiCHkUrhmWWh/lcBcRiWbURX3P/Tj2vXaKQf56Ce1vzE9b6Loc1FnNUd5FwKunWPGp4KaajGb8R/GinkZBPPltR9OI4XO4pR2ZtXuemf6yttknvzRRTA8uIbsD3EnqgBbtto=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;20:t1L0er3BpDKrcOUCJTNFtcxmMHuoctFQoS9rpqltkfdZSENITmBwGzy4qL1qQ1yciyxPXULuE/LME4NwTxpbEh+kmi3GKP/E15yqTgavZ8KRIOvQZrU+E0NWA8w55LorXdW98R+4oB2Lt2fURMRrxU6iHOTTVQykbWKho5LXLyqFVF4PmehV++qYmMHzoRtLln40+oKtR7MvBTroH5carhX+xcuIBGSvZvC4m3VjBOz7CJkIYPtrPq/IBNG8wcWc5pmTnxo9rUm5plnnWbtJhAkI06txaZqUDzfHE66C71aQ3CccUwddZzAz776gtZfVmbFJGmaqFUYEM3ycB66eoYKzCvUErlgpZZFi2AvklSFi6fEkeyO47VTq6rhl76TuVePDbe9jHDxRYWeKIXNiqKPBvjgc8RSCkuQ2P83JyKEekyuwQMcigirV9l7VIfmTRO36UtGWHtUc7LB0lhFa+j3wSC0ZfV8SBV5H344mZAI8uaGFR54slONeok/HWnKb;4:2GMn5J/rTeZjxSeKzXYXfsg6q2dpJFPqktzuGlGzvIHbTHOVGQICUigyW3A+wxq8YRiFsdoo+Uqd7EttcSFJs0CO/bRzFqZ4YLO9PkTj2PhIL5Yh9gWNUoH+cFKwAPhFBy/ANZmEG//vvB4QepSydUop1T7V5/6ZXJBkKxYJ+vUpqSsS1uNJ5mKELz01qrA+emmp/q2VdIm2xBpmteiNO72kQKgZ91/PcfLJqohi1NbqUPG9zBLt48xSByMJlzzoNh2V7KWFk/Otwcymm/zNselYXMZoCrQBKgH9+WXBEyTmLsYifPI+o7kiBkdYQzCYWkeR1A4J23ZI0GXajDj9n21KSDPyqZl/zgP/lD1C8VA=
X-Microsoft-Antispam-PRVS: <DM5PR12MB17218DD4B44CC288ADD1B1B783800@DM5PR12MB1721.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(376002)(396003)(346002)(199004)(53754006)(52084003)(189003)(53936002)(54906003)(86362001)(8676002)(186003)(67846002)(6246003)(52146003)(23676004)(68736007)(52396003)(229853002)(65806001)(16526019)(97736004)(446003)(106356001)(4326008)(81166006)(105586002)(6306002)(76176011)(65956001)(81156014)(31696002)(2906002)(316002)(2486003)(966005)(8936002)(386003)(59450400001)(52116002)(64126003)(7416002)(478600001)(72206003)(65826007)(31686004)(46003)(11346002)(50466002)(58126008)(25786009)(6666003)(47776003)(5660300001)(36756003)(7736002)(6116002)(230700001)(305945005)(486006)(2616005)(6486002)(1706002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIxOzIzOkVqd0tYWExkTitDcUJqeTF2ZzZub0tkM2Ns?=
 =?utf-8?B?V0JDS3ZDSnE0WW5sWEEvakVjaDdYWW05Q2x2SWs3bFZVWkQ4QjZxRW1NaXpO?=
 =?utf-8?B?N3I2d0pXcWkvUGQ0WjVyNEJOdnpIWW1hcXJneGJvWUZYL01OSUg4UVZseDgz?=
 =?utf-8?B?N1A3SXdYNVl4anFiN291L0MxZUZnYzZmVXVwcDVnWjRWNE1BV01NSnRReHA3?=
 =?utf-8?B?K0ltU2ZkS0FHNHFBUUpSVnF6cXlaR2hyT01MOXF5eWtHeXFINHBJTnppWnk2?=
 =?utf-8?B?WlNoWWdQTjg3MFRub3R4UDJwL0k4U0JvNTgxL1NaaE9YVkd3U0xIVEZzN3U5?=
 =?utf-8?B?d3NWa09MbzFzWFVtdGxidXUrZDZiSXF4M053UlZuTmFSdS8rTzh4WDd5Y1Zy?=
 =?utf-8?B?Tk9PbzIyOWhNNWwyVEU2NnR5QTBTMnVaTGRqczFLeVFXL05Va1JZRmsvbHZU?=
 =?utf-8?B?ZFoxRlFndHhqQkdUSExBOUxEMUtGeFIxNStjTEFQS3NXRk4yTmFUbTRiMDB2?=
 =?utf-8?B?NEtGSlZhY2FHSUVQMENzUUh0TEY4NnJmM2tsMnNJYXUwcFRqa3k0bTRhYm5B?=
 =?utf-8?B?OVlaZ013Uy9zdHh3RkFlRU1UcXNiVmx0WVZEUWcvTUEweFZYSlR2QUJnM1pW?=
 =?utf-8?B?UEhabVNrY29qLzVBYjdaQ1JUczN6azNIckwyenFoQVpiVndBR1V1dHNCbXpU?=
 =?utf-8?B?ZUFyR1kxVE5DOVRBWDVqdHBTb1hhM0UyZko4aWpOTzIyTEtSMkJTNFQ3QStm?=
 =?utf-8?B?YzIwcC9GTnNNRkhxV3RxTVcza3hucTRHZzB3djZlcUVjK01SVkZqWDR4c1pU?=
 =?utf-8?B?cHNvcDcwV0I0RFFNa1ZVV2FETVhSV21ZS3JnaGg3NWJBRHVzWVB4K0gyM09x?=
 =?utf-8?B?SzF3dDNnVEJGTVRhVEFYenh3ZXRjWk5BUkFHWG1rQUpoNTZPcVhwT2ZFYWpi?=
 =?utf-8?B?cVdlVXoxb0VKK2U5NkgyY0UzcDV6L1RiUnQveVpwWGFRL1J4OFAzMWlkeXZo?=
 =?utf-8?B?RU9DcXorTklFQ1pibWtuQmdMZXRFbnI4aVVwcmwrc2xHcTM4dmpJdUJjQ3Fp?=
 =?utf-8?B?Z0R4WWdSL3IyazBLT284NlVBYisxMThSbXRraHJzTFFJWDMwV1gxNGNPYW13?=
 =?utf-8?B?OW5kb01GK1hFVGtKbXFnbzJ0cnNLMXR5d1ZaeElhd0RVbm0zSGt2MEx6WDB3?=
 =?utf-8?B?UXJ3UGxEb2FNS0VmQXhRUjRCNkYrOTNnV2RPSGE1WHdnQ3NTZGxqZlMzYjhS?=
 =?utf-8?B?TnJkOFl6UzlOdmJkb253bW40QUdWZUJqR3dCejNXOElzYXVqaDdVNUtZN3l1?=
 =?utf-8?B?RUxBUEZoQWpvQmtpVVFHbytDZE5USFl2UElPbHZCd3pLWnZ4OWxxbFFuSW10?=
 =?utf-8?B?Q0VsN25OWDJKUEllczRTUXhsclZCR1BGdnlYT1BjL1Z3QXgyUWpiclhWN2tJ?=
 =?utf-8?B?eitHOWlWMWVXZHBBODhMdHk3SDRnTGIzZi8rU1RucURVdFllNWdMTVdxZ1B1?=
 =?utf-8?B?T0NSR2Y2VCtwM3JkWHlqYUJDbjhvdEZaKzN5VkYxWXFnRDVYci9MNWRvK3Nr?=
 =?utf-8?B?T1kyczZWSzlmZmxaZlFMc09LdXVVQjk0Z1I0d3FxYXpXRkhoNjBweUdQcDcr?=
 =?utf-8?B?V3I2YXU1bElvSWJEMUxVTzNEa1FqUUp1MHlrQUp3dUhCcy95QkhoY2MyK3ow?=
 =?utf-8?B?amlKYStMU1lwVmgrWFdRaTBhTndGeFRDUmZqK1g2ZXhLVGVnMzcrWkpwWE1u?=
 =?utf-8?B?ZHhUM3I1eWIwNUMzUFYvS0lBcjRMSFFDeUNYVUI0UlZoSW04MTI4N21pdXNM?=
 =?utf-8?B?eGJrQUpESUc0S2h5QzZXa2FyZzVjcmM5c0Y3OW10QmNVd2l4Qkh1Y2pvWGdC?=
 =?utf-8?B?MHdKTGJSMmtqMmVqZW5NMDZBUlYzWnNQSDVmMFk2b25hT1JlZ1U2S3JpSFpW?=
 =?utf-8?B?RE0wcVRjNjFmTlljenhNNjNKSWdZRWNuT3REWWh6bnp6OU55cFBCTHhGVDdY?=
 =?utf-8?B?VnJLYnhLMFN5SnVnajBuenhIdldiZnVzTnRtZz09?=
X-Microsoft-Antispam-Message-Info: oTAQ9Y8dPx0qJiQEZi5CGv2k/bk8U2g+gPZxo4kB3czYnhebc/63UEwfzCeOqsxdTKXrDL5wNtWBJQzhPm8Wg+B2csSwEquUrFtX5lv+lB3w+x+iUaxJMDZFLSr1Hr3zJ5ScaBL+W32tYx9PRAU3ZSufcXLV+6h4X77OEsCVhgfnPsTPPiGNXq0uoUv3CMbm
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;6:SAWxNK2s+JAsCiC4DtrRjhNZ9tOmdAG64cu6X1/kpYmqngvTd/wA71jG4u8fmnNZ/lttj3vU944OpjqmTTeSsVp/WiTsys1cPsTnDsM4gYHy8GHProZjjX0st1lv7y4qEvt9YlwLbtRvAuqOKrXOfed1k3drkv4u76zSxZZP/W42/XnKRsu8/WtRz7lQhVp5me8qRiq4RcqAinjjvF4I3BT+ZJjzR6bEZkl1Kisz8nMwhlH64oP1qdnl73ApXv6DqBU08ECpZyuy35jSUgm2so+ZTAQiqSnTpOsRMKC+XtvCAdroJdKX3f/002j6ZsJ0Zld6zJlmZaI9okmPeNlLfApKJiPrXqGAa4B5ljxXVM3CxrP6EO2Yd8nymFmCdALkKzv+DskYoCTdF4iHZymy/Y0ecnwNeMg7YXB5kb8ErZoSxyxijRQzS0VceVF8POBCLmDWsj2OmxDoCYmSc3fdbg==;5:16jtF3AN5V9ahGjMY20NHKl2Os88EuNLFOjDxup4okv9+JmCVtIHJ5WTVC6qDnmsUbf+UyfQ3Plo1utQnCjNjY1Gna5tXyDHtDMCqqW6TBjlScQlFhxgl6uncr9ms4Da1TBE4UqCRh35h/3Y9084JUm3O+1B6PaB1Pi38dzr4fk=;24:Xjf+SqWVvqL3Fjax8M7Z6KEawzu9NZLO7w7cuL7OD+AtYehGg9wXqs+PiGO8lZryjpKYqOm/8gKQSeAkI8JXZ3T8hXrQYOXybTfb/vwcRrw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;7:7QZ2dBvOJWo+vWLZ3063iKVoaxyPgGXm2NnAl/lT57q16//ha+P9X2bp/PCa15FqQ6o0f5KFv3alpcLIYF/AvG3OTL/8Z98DsBzMNcLRY836n+odq6Foj7yJ0kdgJp6CA06TOVPEWUf0Xv1CZsMFL4D3YuluptRWDVAYnh55mqheW33LjSPaPvpqLsSimyXN7A57qcX473JmxKlcfcJEwYLVonDoYQcnmuYkPBfF1llBrjq2L/HJMYem/UCZHsce;20:83Im9bzw2kjEPVcgVVDU61yrtn2RKCtJzkPCUfowhJGLoPvPTw+31iD7PZo/oFwM8IOwb3qwp9tRcPFUN+SvhUSuU8mN/VkV4QLBJ+8V/nwTaYl+9DWHAI4rxeovM8jgEXsMzKsMp4AsoYwvIf2LJkKQSUwXE1H01mxacWbVwApjyUjdyQ938VhAM2W5JEUJ1LJLwd/j31BnBufJ/04ZN01LbubrIsePMRbFm0Tmln6LQUl1kma/OMK3jRAvL+0S
X-MS-Office365-Filtering-Correlation-Id: 5f58d01f-1bc5-4f9d-25a6-08d5b0230f8d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 11:51:28.4513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f58d01f-1bc5-4f9d-25a6-08d5b0230f8d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

it would be rather nice to have if you could separate out the functions 
to detect if peer2peer is possible between two devices.

That would allow me to reuse the same logic for GPU peer2peer where I 
don't really have ZONE_DEVICE.

Regards,
Christian.

Am 24.04.2018 um 01:30 schrieb Logan Gunthorpe:
> Hi Everyone,
>
> Here's v4 of our series to introduce P2P based copy offload to NVMe
> fabrics. This version has been rebased onto v4.17-rc2. A git repo
> is here:
>
> https://github.com/sbates130272/linux-p2pmem pci-p2p-v4
>
> Thanks,
>
> Logan
>
> Changes in v4:
>
> * Change the original upstream_bridges_match() function to
>    upstream_bridge_distance() which calculates the distance between two
>    devices as long as they are behind the same root port. This should
>    address Bjorn's concerns that the code was to focused on
>    being behind a single switch.
>
> * The disable ACS function now disables ACS for all bridge ports instead
>    of switch ports (ie. those that had two upstream_bridge ports).
>
> * Change the pci_p2pmem_alloc_sgl() and pci_p2pmem_free_sgl()
>    API to be more like sgl_alloc() in that the alloc function returns
>    the allocated scatterlist and nents is not required bythe free
>    function.
>
> * Moved the new documentation into the driver-api tree as requested
>    by Jonathan
>
> * Add SGL alloc and free helpers in the nvmet code so that the
>    individual drivers can share the code that allocates P2P memory.
>    As requested by Christoph.
>
> * Cleanup the nvmet_p2pmem_store() function as Christoph
>    thought my first attempt was ugly.
>
> * Numerous commit message and comment fix-ups
>
> Changes in v3:
>
> * Many more fixes and minor cleanups that were spotted by Bjorn
>
> * Additional explanation of the ACS change in both the commit message
>    and Kconfig doc. Also, the code that disables the ACS bits is surrounded
>    explicitly by an #ifdef
>
> * Removed the flag we added to rdma_rw_ctx() in favour of using
>    is_pci_p2pdma_page(), as suggested by Sagi.
>
> * Adjust pci_p2pmem_find() so that it prefers P2P providers that
>    are closest to (or the same as) the clients using them. In cases
>    of ties, the provider is randomly chosen.
>
> * Modify the NVMe Target code so that the PCI device name of the provider
>    may be explicitly specified, bypassing the logic in pci_p2pmem_find().
>    (Note: it's still enforced that the provider must be behind the
>     same switch as the clients).
>
> * As requested by Bjorn, added documentation for driver writers.
>
>
> Changes in v2:
>
> * Renamed everything to 'p2pdma' per the suggestion from Bjorn as well
>    as a bunch of cleanup and spelling fixes he pointed out in the last
>    series.
>
> * To address Alex's ACS concerns, we change to a simpler method of
>    just disabling ACS behind switches for any kernel that has
>    CONFIG_PCI_P2PDMA.
>
> * We also reject using devices that employ 'dma_virt_ops' which should
>    fairly simply handle Jason's concerns that this work might break with
>    the HFI, QIB and rxe drivers that use the virtual ops to implement
>    their own special DMA operations.
>
> --
>
> This is a continuation of our work to enable using Peer-to-Peer PCI
> memory in the kernel with initial support for the NVMe fabrics target
> subsystem. Many thanks go to Christoph Hellwig who provided valuable
> feedback to get these patches to where they are today.
>
> The concept here is to use memory that's exposed on a PCI BAR as
> data buffers in the NVMe target code such that data can be transferred
> from an RDMA NIC to the special memory and then directly to an NVMe
> device avoiding system memory entirely. The upside of this is better
> QoS for applications running on the CPU utilizing memory and lower
> PCI bandwidth required to the CPU (such that systems could be designed
> with fewer lanes connected to the CPU).
>
> Due to these trade-offs we've designed the system to only enable using
> the PCI memory in cases where the NIC, NVMe devices and memory are all
> behind the same PCI switch hierarchy. This will mean many setups that
> could likely work well will not be supported so that we can be more
> confident it will work and not place any responsibility on the user to
> understand their topology. (We chose to go this route based on feedback
> we received at the last LSF). Future work may enable these transfers
> using a white list of known good root complexes. However, at this time,
> there is no reliable way to ensure that Peer-to-Peer transactions are
> permitted between PCI Root Ports.
>
> In order to enable this functionality, we introduce a few new PCI
> functions such that a driver can register P2P memory with the system.
> Struct pages are created for this memory using devm_memremap_pages()
> and the PCI bus offset is stored in the corresponding pagemap structure.
>
> When the PCI P2PDMA config option is selected the ACS bits in every
> bridge port in the system are turned off to allow traffic to
> pass freely behind the root port. At this time, the bit must be disabled
> at boot so the IOMMU subsystem can correctly create the groups, though
> this could be addressed in the future. There is no way to dynamically
> disable the bit and alter the groups.
>
> Another set of functions allow a client driver to create a list of
> client devices that will be used in a given P2P transactions and then
> use that list to find any P2P memory that is supported by all the
> client devices.
>
> In the block layer, we also introduce a P2P request flag to indicate a
> given request targets P2P memory as well as a flag for a request queue
> to indicate a given queue supports targeting P2P memory. P2P requests
> will only be accepted by queues that support it. Also, P2P requests
> are marked to not be merged seeing a non-homogenous request would
> complicate the DMA mapping requirements.
>
> In the PCI NVMe driver, we modify the existing CMB support to utilize
> the new PCI P2P memory infrastructure and also add support for P2P
> memory in its request queue. When a P2P request is received it uses the
> pci_p2pmem_map_sg() function which applies the necessary transformation
> to get the corrent pci_bus_addr_t for the DMA transactions.
>
> In the RDMA core, we also adjust rdma_rw_ctx_init() and
> rdma_rw_ctx_destroy() to take a flags argument which indicates whether
> to use the PCI P2P mapping functions or not. To avoid odd RDMA devices
> that don't use the proper DMA infrastructure this code rejects using
> any device that employs the virt_dma_ops implementation.
>
> Finally, in the NVMe fabrics target port we introduce a new
> configuration boolean: 'allow_p2pmem'. When set, the port will attempt
> to find P2P memory supported by the RDMA NIC and all namespaces. If
> supported memory is found, it will be used in all IO transfers. And if
> a port is using P2P memory, adding new namespaces that are not supported
> by that memory will fail.
>
> These patches have been tested on a number of Intel based systems and
> for a variety of RDMA NICs (Mellanox, Broadcomm, Chelsio) and NVMe
> SSDs (Intel, Seagate, Samsung) and p2pdma devices (Eideticom,
> Microsemi, Chelsio and Everspin) using switches from both Microsemi
> and Broadcomm.
>
> Logan Gunthorpe (14):
>    PCI/P2PDMA: Support peer-to-peer memory
>    PCI/P2PDMA: Add sysfs group to display p2pmem stats
>    PCI/P2PDMA: Add PCI p2pmem dma mappings to adjust the bus offset
>    PCI/P2PDMA: Clear ACS P2P flags for all devices behind switches
>    docs-rst: Add a new directory for PCI documentation
>    PCI/P2PDMA: Add P2P DMA driver writer's documentation
>    block: Introduce PCI P2P flags for request and request queue
>    IB/core: Ensure we map P2P memory correctly in
>      rdma_rw_ctx_[init|destroy]()
>    nvme-pci: Use PCI p2pmem subsystem to manage the CMB
>    nvme-pci: Add support for P2P memory in requests
>    nvme-pci: Add a quirk for a pseudo CMB
>    nvmet: Introduce helper functions to allocate and free request SGLs
>    nvmet-rdma: Use new SGL alloc/free helper for requests
>    nvmet: Optionally use PCI P2P memory
>
>   Documentation/ABI/testing/sysfs-bus-pci    |  25 +
>   Documentation/PCI/index.rst                |  14 +
>   Documentation/driver-api/index.rst         |   2 +-
>   Documentation/driver-api/pci/index.rst     |  20 +
>   Documentation/driver-api/pci/p2pdma.rst    | 166 ++++++
>   Documentation/driver-api/{ => pci}/pci.rst |   0
>   Documentation/index.rst                    |   3 +-
>   block/blk-core.c                           |   3 +
>   drivers/infiniband/core/rw.c               |  13 +-
>   drivers/nvme/host/core.c                   |   4 +
>   drivers/nvme/host/nvme.h                   |   8 +
>   drivers/nvme/host/pci.c                    | 118 +++--
>   drivers/nvme/target/configfs.c             |  67 +++
>   drivers/nvme/target/core.c                 | 143 ++++-
>   drivers/nvme/target/io-cmd.c               |   3 +
>   drivers/nvme/target/nvmet.h                |  15 +
>   drivers/nvme/target/rdma.c                 |  22 +-
>   drivers/pci/Kconfig                        |  26 +
>   drivers/pci/Makefile                       |   1 +
>   drivers/pci/p2pdma.c                       | 814 +++++++++++++++++++++++++++++
>   drivers/pci/pci.c                          |   6 +
>   include/linux/blk_types.h                  |  18 +-
>   include/linux/blkdev.h                     |   3 +
>   include/linux/memremap.h                   |  19 +
>   include/linux/pci-p2pdma.h                 | 118 +++++
>   include/linux/pci.h                        |   4 +
>   26 files changed, 1579 insertions(+), 56 deletions(-)
>   create mode 100644 Documentation/PCI/index.rst
>   create mode 100644 Documentation/driver-api/pci/index.rst
>   create mode 100644 Documentation/driver-api/pci/p2pdma.rst
>   rename Documentation/driver-api/{ => pci}/pci.rst (100%)
>   create mode 100644 drivers/pci/p2pdma.c
>   create mode 100644 include/linux/pci-p2pdma.h
>
> --
> 2.11.0
