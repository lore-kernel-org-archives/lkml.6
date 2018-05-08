Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932927AbeEHQiM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:38:12 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:15824
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755462AbeEHQiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:38:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Stephen Bates <sbates@raithlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <479F2F93-903B-4A8A-8989-A4BD0E5E1471@raithlin.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <44488fb8-8105-b6f8-3438-720ee39d8520@amd.com>
Date: Tue, 8 May 2018 18:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <479F2F93-903B-4A8A-8989-A4BD0E5E1471@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: PR2P264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::23) To CY4PR12MB1719.namprd12.prod.outlook.com
 (2603:10b6:903:121::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1719;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;3:2RGpLoipld0RPHAdFsCOJTfmnPkctJucE5DmbOXeKD6AqrgPN3Q7Nc2Wg5zWyVnwbRn/4umjeFUU6PeKoglo2UuFyrhzWtsN9EOX75g/hXzBCnsFCbSxnztEmoplWG6GZhl8DK+yg2NMkb96EyNzZWDnCyJ4qPKnxCfrNz+8baUPX/3Csnr2OY55y1fvVgl1oA5Ibc5tFnUFj4jy6lNNTl4NDHwA/HXbbZlhS6hrH5MBqRMAGfhsb4N+gC8B6+Ve;25:LKqMwCjdYsY0YwiqlaOZnM5lMahPaUyChdpreeLJXcI40N4MM5WvDXn7yWOI415/oSnbwMTuDhSIJBuiwrLN0Bj7hBxdWXOA+X6wDyG1YjrHxzj5hHPy8Q5rHiaIzhyT+QmgrsTHzwkMnzYM2+jIck0b2hOvOA27izs6M6DKYYVEFQbX0U6Hw/ou9pJ31biNih7sX7q6OqkvZlYfqaiHVV5gwND67ioVyNnH2unphGRxe/yCi//kWG99G/MUaI13wtnadNt6Ii5Tb7JNPDmmA3iHe3vAz8A0AceNlp4hX/mpOGR++8n+Xyjcoh7eiPk0xDV3sYleMf9aCUnIvx2J0w==;31:zfMuMkJcF2d+Q/6Y/BcnrueJpkmp+C1eiLs6mwcOJ2BXOIskTwmfE3FbKSWmfxWIkndkKQh09p6fUIXiuWeV/0gBrhs8E6FHkPYG0XGDCKhLIT0L8nqQIOi+9kfmJ7HISfniO1Rdu45g3uWa03nAbMfe87Ake28S2AGtz5JzT7E9nUAIJLFWYff8GHazCvT6TZTb8JrBt+tQ93BCOxY6Lv321AunZn7Qy2E3WVuNFTo=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1719:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;20:asyJrlzGoX2wEWDoXDQleq1ahEzI4Z2sX++iDhAdR6o2yrMkta47ryTVhzwDX6XuFzRzdhuQLhpOGwpyqyz4BQmQsd3zgpiutuPmAg67YV5NQXYLyVJonpTKp+qE/s0qoyXhBLWKI+zbELF5QFGILqb7NWBYaD5hpjcNglz6ZIk9np2TBWVyIedXG+vXkTcVw+6nnszZuIOeuhiyGYmUGPe8QJH5fzIvy8rNtBrBXtBPAhE6T7jyTSjbbcIC+7Cuc9oufLalYvz8vYHz2yCuGvp2f2RZba8h4wPz0i8buBeHs7J2uDneN1X8x38bA9maUQNs2DHnBQg7R4IcToMoeoOdcm/hRUn9plEIg//ZAVFGCRXybIrouBKIIrd+TiHu9zqJ+smahn8JdYCVMNgfyE6xdwD8+D03XuKdRdxPZPnt9hxxrGeU0L9NMnWYLKvHb9p+yeJDHfcjEQlUJu0u+ovk8Kd0R4QVloeHqCej2TvNFOwwf2GR7QASYg+m34f+;4:Iwp9Z/g+oQqpFklvVZv3lR+WkIPsYg7Il9MaoBC8KAT2G3uI1LLp9Nkp0TzntUL8omw4XFTwb1e0+P+ZF11qsJ/cLX1J23/eNY+IbjJLO7EcFzJjCQvoCWFEHIjWzEcSHWltsrtTn4k5p0Y1X22cu0hi37LOSxj9CWXdGmxx1waKiMcU/mM/8I0oG4N99SG9JAfFkNRVvE8elBHfV3t1TZk3Q8s6WbxVNMw1723/ORyJ8jWsF5PNjdkjsK3dsh+G2pYP2bq7S/webDgM54N6/XZ0WZjFlmEC4dDfDAd7Wa97usJJgnm9ANW2KZR9qChZrvZif9StQDidcJJliP50LFa7OJSraYXDbJymWoKya2U=
X-Microsoft-Antispam-PRVS: <CY4PR12MB171927FB45F5EAAC4178AF2C839A0@CY4PR12MB1719.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(100405760836317);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1719;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1719;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(39380400002)(346002)(396003)(189003)(199004)(51444003)(59450400001)(52116002)(386003)(105586002)(305945005)(65826007)(31696002)(93886005)(67846002)(23676004)(2486003)(52396003)(52146003)(229853002)(478600001)(76176011)(6666003)(25786009)(72206003)(31686004)(106356001)(86362001)(64126003)(4326008)(8936002)(2906002)(5660300001)(1706002)(16526019)(97736004)(186003)(230700001)(8676002)(53936002)(47776003)(65956001)(65806001)(81166006)(7416002)(11346002)(2616005)(54906003)(476003)(446003)(36756003)(6116002)(81156014)(50466002)(6486002)(7736002)(6246003)(58126008)(68736007)(110136005)(316002)(486006)(46003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1719;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE5OzIzOnM0dkdCVE10Z0dFUWVtbWIrQlZQS1BsZksy?=
 =?utf-8?B?Ull0WXhhQ2FkZmFDUzlFTi95MWtMSGs4VkdWMjVTU2l4b096VU5vdnBjWlJV?=
 =?utf-8?B?c2V3dmxvbW83ZDNoZ2pEcExvUnMxbEt5NlA0bDQwL3l2c2V1c1VqN2hIbmxq?=
 =?utf-8?B?MWtWUjRJNVJuajVIZmZEVmNzeDFkbTArdkYvRXkvVWZCZUVPQ3Y1WVA4bTVV?=
 =?utf-8?B?RzQranFmOUxoMHVZVzQvV3BScDhPNEF4cUtwTWh0NExnSmtybllsVWxyUTZV?=
 =?utf-8?B?Z0h5Z3RJNEtMQ2NvaVRpbllIYlVNYVlVWGtoSUpHTUo5QnZjRVFRZmRSdDZu?=
 =?utf-8?B?UzFEQWlWVTU5Nml4cllkTnRZR2tmWHhtL3RaOGZxcUdJWmxYR2FCRm1HTEF3?=
 =?utf-8?B?RnBiS2E4WEFMZEE1QnZ2NlhYWGJOTmxyaGU5VG9EckpldE1rbFNlb0NPQlo2?=
 =?utf-8?B?bFZDcjZDNEpQb0orNm5KeGsvS1pqcFNGb2lwaUNoQThHTWNNZTJ0RGZHWU1t?=
 =?utf-8?B?QmxmeWJ4bGpNNzQ0RnF0aVJVdDJVWG5LeG5uYzIzSlMzTngwdXllV013c0hG?=
 =?utf-8?B?U2E2dy9XejNZWm1CaVVRVzYxZGZoTlN3T0YvemNoKzFHU2VVYlVOVzY1b2I4?=
 =?utf-8?B?ekkzMkE5NFUrQWJmVGg5SWZTY0ZXRDl0bjNDaWhiSzhtdHhJWW9LbnFGeUlQ?=
 =?utf-8?B?VTVkVXZwa3NxaEpYN1UxSHhYcUlXNVJPSVZNWkdSeWRkT1lKRTRnL1FBTTNl?=
 =?utf-8?B?M2FxTFl4UnFpY3BDRS9yVk5sYjhQeWZ1am9WbExyRlZQbktUQ0FDajNEMExa?=
 =?utf-8?B?Z1B6MVVWVFl3c0NyQVVpMTljTmhoRjBmdnFheVZpbmt2bVdMVGEyakdlaWNY?=
 =?utf-8?B?dWViUGZYS21nZ09tY284STlLcjZTT0VJbGFDN2IxVU54MkkrTGxZRDNrRjFJ?=
 =?utf-8?B?eFdjS0sySVdrbDAvNGE4UUxyeStvVENWQkYzUmdPY004UjFtRUVBdnZ1QW1C?=
 =?utf-8?B?Q2grL2lqSEpvYVdQcUJQYlRQN0FyN2dUK2k5R3VUZmhvYlFjS3lyWEF5Sit0?=
 =?utf-8?B?UnZlQVR2VTNIOXhQV0JtVmxuOEtwMzAzdXdQdnpNQjMrZ2dnU2h1NERza2dM?=
 =?utf-8?B?bzhmTDkvLzNqM0E3U0xldWMxVzhlaEVOWW9Pbmo5bFZNTktaVTZsdGc1QzZ5?=
 =?utf-8?B?NFZVS08zdVVvS2xSSjc4c3N3Z3hzajR2REZkWVFHZUpxLy9OMXRsMnlMd3FE?=
 =?utf-8?B?RnptOFppUmhFWFVkdFlLdzFpSjBnc1hvblZBeU95R1A3TkNrMlVXUE5QZE5l?=
 =?utf-8?B?UUx6OE5ib3J0cnBFTHFjajFGWlVqTGxKR1BmOFp2eGgxbCtGK21LRkRNVlFq?=
 =?utf-8?B?Y01zakpsa2VPVTNsUU1iU1FUUndiSVhTaTVBNTlPTlQ5VjkvaTMwWG9hUkxQ?=
 =?utf-8?B?Q01leXpiN1BjWUVCamNCSW9hL2RYdVJVdWlFY0NFblRGZVFHQTFWejFhRkNz?=
 =?utf-8?B?U0hVazEyVmNFQk4weE1WK3hDY0Rhd0xDUVBOU1ErSjFBT1BhQk5CVkdHUHIr?=
 =?utf-8?B?ZXJoMHhoeGdTZ0RBTnFmVktHbnhMcTUwdllOVU5Dem90UGM5bWZwQlVpVFda?=
 =?utf-8?B?STZ5YnpUS0FSbnlqeHJMK2RwTlZVLzZCVUdTTkFqd2dEWkNtT1hjM1RoanZ1?=
 =?utf-8?B?czd6NUl4bW43YWJ4NWJpdDh4T0R4cXowRHF3RTk3NE5pMytoeGxPcTlZcXln?=
 =?utf-8?B?YXVmTnVZZ1lVdno2ZzBoQ3dTc25LaDBiSmk5ZklvUEJENDNkNDcvd2FkcUxs?=
 =?utf-8?B?NXVReHFtTS9BV1I1RlJlNVpDY1FhWElweEc3N0p1aElTbktEblNnQld3eXN2?=
 =?utf-8?B?RHdKZmw0ejZPQWNKZEhNbnNpZ3BHNEQ5aWcwK2NsY3phMVhuWDVCV3Nxc3Av?=
 =?utf-8?B?Rk15ZmY0NWJjOVl0TDFodkRRY3ZGZ1dOWUdYN3drR3plOUN3VjJkRHV6VUVQ?=
 =?utf-8?Q?ILzwu4?=
X-Microsoft-Antispam-Message-Info: vF+hvO5+MBbEsqRRCX6C+GYD9ssH5WTfw15xE/VRUTEeT8V/dLC9QybW60jJg+lQRdwVLtJEOPDCDaXLcd1hzkxoLxSAdMKJYmN2PTGrJ1ruB+zz4ITSA7DM6f9rs1lo3uaKHinDF7yf2GBVeP03wH7LLewXDYeeRnjKQFv56Ay0GtmRaQoybgzC33y7JcM6
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;6:LxzTKa3PXM6GX+nrnjOVp6xVWCVQgSTLCjM8FDrmCZiAvcIVfeGCih5x4xofIwk/OoNlkCKBNkmsBqQHuMcREySt+qV+cj1IIRMxtHgIaZF93C3/XEjh0Sl2RaC2ZWzR+ThtP7zDEYJrCtduIUwmU3NYkCzQ0Tfih4IO/RJm1OQRxbeRzRIOrad6M94eB5kIKpCyugPvx3lcvtSuKzpFG6UPkPGyC9LhIYOpXhSvl7yabYYvRqkVusavGr7sK5hgigXVoSqqONhlhJ8vtyQ3CR7/8RGJ82BlMs05QkeM/dnx8Wqnqe1PGkJtJOfaAI5KYQtAmyF5gFCuqhLCiFOxBGkVq8h/sNdeSHkwGfSRhfp0YgnfeqR/SvSvFaO7wWrdvz5BDUt6kI51KyOHcxZ+lq96PqSK6b9TnqLgOdQJYwvhAnrGwhPQo0B3PPm97XnFl6JQdXWxa7TQRruOkZRLVQ==;5:VafYb/bNnJ5dqvqwFkwcRLEgyUztSgHb98tTN4cWofEgvsZDp4SK/uiIfk6FuSbXm4Ro18mxcD8MlEQNIQhiA0CGILx3BAqBRegekis2sxKF5n9Zx3vNr+6D6E/itfUKG2BPm5JHmxvNpA410ZZJZb0bWIsExj2425OoA/fytyI=;24:69EqgsmKJ1jgt4a+Af+opCaBbUNNXPieoflKKKdql3tgPdU/+UaDWlyeve3Gd2hSsnnU7vY2IyPGrknRWusJg9rvDibnMZQB/ICRrUZU4C8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;7:N3zq+FNksvBhb9DL7xLX5eR8UqZNHsrZwk2VZvt8SSIkbmPAoEwrvS/S+Bb7HmiiV0E+gsknTnxl/wsD6N7DGRvVX6JakbBn6CDIaIEpNqTKBqEu7nzip0rVjk2KWqSljTUmhrxTopsbba0cOaH8/5ehZHN8550u4QbxDJEC8Vrql0AHM1hXtexhp4TdfvjFGMIosgcsYvmouOgb/qDGRqhatk4JdA8gPLCEq3CtjIV+dcLqY9tuTYtkfdt7xatw;20:KfCY8XSmeCd61wamfu9aeJHGrWWmpIdvgu8yjBLxcdvKI4pOO+HXiUux9v0/kOScKVLwJWPJwWO8gI6tr2mM9YARhqvB3XrOKIZ+b1m6/H4ftcSxgawKnlup3yTbtHF134Ft6DC6NS1yC4vFRaifDkKqWfiW22+OOj+qhZJFCphL7cA8nv8+vTT74dsQrIwLZG5R92AON9/cdZJ3WDapIaMptX7N+lh6WGXdvV+emK8AN8VlNl2ROQ2u2+/PdLO1
X-MS-Office365-Filtering-Correlation-Id: 83b311af-2d32-44b7-10a9-08d5b5021294
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 16:38:01.4829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b311af-2d32-44b7-10a9-08d5b5021294
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1719
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.05.2018 um 16:25 schrieb Stephen Bates:
>      
> Hi Christian
>
>> AMD APUs mandatory need the ACS flag set for the GPU integrated in the
>> CPU when IOMMU is enabled or otherwise you will break SVM.
> OK but in this case aren't you losing (many of) the benefits of P2P since all DMAs will now get routed up to the IOMMU before being passed down to the destination PCIe EP?

Well I'm not an expert on this, but I think that is an incorrect 
assumption you guys use here.

At least in the default configuration even with IOMMU enabled P2P 
transactions does NOT necessary travel up to the root complex for 
translation.

It's already late here, but if nobody beats me I'm going to dig up the 
necessary documentation tomorrow.

Regards,
Christian.

>
>> Similar problems arise when you do this for dedicated GPU, but we
>> haven't upstreamed the support for this yet.
> Hmm, as above. With ACS enabled on all downstream ports any P2P enabled DMA will be routed to the IOMMU which removes a lot of the benefit.
>      
>> So that is a clear NAK from my side for the approach.
> Do you have an alternative? This is the approach we arrived it after a reasonably lengthy discussion on the mailing lists. Alex, are you still comfortable with this approach?
>      
>> And what exactly is the problem here?
>   
> We had a pretty lengthy discussion on this topic on one of the previous revisions. The issue is that currently there is no mechanism in the IOMMU code to inform VMs if IOMMU groupings change. Since p2pdma can dynamically change its topology (due to PCI hotplug) we had to be cognizant of the fact that ACS settings could change. Since there is no way to currently handle changing ACS settings and hence IOMMU groupings the consensus was to simply disable ACS on all ports in a p2pdma domain. This effectively makes all the devices in the p2pdma domain part of the same IOMMU grouping. The plan will be to address this in time and add a mechanism for IOMMU grouping changes and notification to VMs but that's not part of this series. Note you are still allowed to have ACS functioning on other PCI domains so if you do not a plurality of IOMMU groupings you can still achieve it (but you can't do p2pdma across IOMMU groupings, which is safe).
>
>> I'm currently testing P2P with  GPUs in different IOMMU domains and at least with AMD IOMMUs that works perfectly fine.
> Yup that should work though again I have to ask are you disabling ACS on the ports between the two peer devices to get the p2p benefit? If not you are not getting all the performance benefit (due to IOMMU routing), if you are then there are obviously security implications between those IOMMU domains if they are assigned to different VMs. And now the issue is if new devices are added and the p2p topology needed to change there would be no way to inform the VMs of any IOMMU group change.
>
> Cheers
>
> Stephen
>      
>
