Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeDLJmx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:42:53 -0400
Received: from mail-cys01nam02on0045.outbound.protection.outlook.com ([104.47.37.45]:63872
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751589AbeDLJmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:42:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, amd-gfx@lists.freedesktop.org,
        timur@codeaurora.org, sulrich@codeaurora.org,
        Tom St Denis <tom.stdenis@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Emily Deng <Emily.Deng@amd.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Panariti <David.Panariti@amd.com>, Jim Qu <Jim.Qu@amd.com>,
        Huang Rui <ray.huang@amd.com>, Roger He <Hongbo.He@amd.com>,
        Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
 <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
 <20180412062600.GB30499@lst.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6802bd0c-7da6-659a-7e34-8f05d7c6422c@amd.com>
Date: Thu, 12 Apr 2018 11:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412062600.GB30499@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0701CA0005.eurprd07.prod.outlook.com
 (2603:10a6:203:51::15) To BN6PR12MB1713.namprd12.prod.outlook.com
 (2603:10b6:404:106::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1713;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;3:h6uw3MXz9F+FjQqjIOQ3Fl8Ntj5C7cBPxcVhJ3DayTzpr5iCi/g99TIPVmSE58dP+TXZE8rTNiq87H0s3yijQhZUyofxqQwQblwQgjAutXCqMI2O9s/2PqG30ycwguNryLS6/5+87+O+OZfH5ZHGr/GNgh/mHb+ITjHTHSbbot7YyFakoWMFbu2A+k6EOZwDbzJDBnytSQHN0m7VJ5r6DmM5uvp0KsVibFUfREOxK7ms3zHUuLWfZ4zX6ob4EMCn;25:YL4jNkPGApbdt6Xp/6ZrwvysgfwLb2r4+9vrZwPt7G6tRDVqKe+6B/ttZZPUqcPRlP/rnkR0m2tB78ZflL+pFGJpVEQ2+BbMeetWyKWjiIrCrHpaSaBnzRV2ZI7Zrgn02S8ScwlAtJqYYT3o28ziuRbz/y8xC9It66TjdqbrcEuw9pNFMlBP8I/lYEI6zt+0XgqNj1aN22XHFDziXFEP05OfPx/rPv67AJyDlSmNLXIdHnUCrJ2w++JPvkJdOZS8CQQpDVi9SNq9iOug0WomRT2QzRxuuO3BYktj5KagcTA/cTb/Ym91NK19mBGGT4DBeJVVVrj5HCtbKFvE0I9qJQ==;31:owwhFi3usj0bojGkF/Mkkd9pSx3o12YP9FEFcO6iuHy52i4R6PEzu54GmCCbM2Ntl1k5UpDfumGruOwCpe8Ahi1UtrQbnmn8tOUX4QKDbzUg1jItSufJeIo/TR3RDBHk4Id4tgo163nAQ6ZNEk806+MTW0bspMY8BuhKR7xVPAGZ63w4tKHGXyTnIJuxhZT2AV74TeDmmxxiRY5lx6zQw1Fx0QxznqhNCnV+xCevJkc=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;20:ZqiDqvxEvaomUHLSs/aQENZ91lOjQU3Gz9djsRFw6FdHD9+Ha9M8mw8Jfq7B9vFpOMZrnPMoamIWkT1l+arYGBPpy7zBLqw1HS9I1ClXz0ZHa4m9NWFmAljRT1Js0HHZXMNpvDbTaYbRqHlbfrJmsYYW0ZvFYj6SAJo/UDEyPAsnbfVfaIRt0Q1T+D7xjtJcOrMKsr0V7XOPsJydem7HB5XywHDXaTcDh6ubM7hIRrgtccUsXKkIEWtmHBeOH/PzWEKh/yGVjbeqIQ3u1xL1/pSFHfqlpWQyMLyAlXjfHhhe2EHcRusPjIfZhbj5FAJCAepYWarT9uq01aKzuqKExj4k5gBWwi2rFIvQ8T1S2nowIOx7hqSP86LsYp0epvlG9Rfr2mMmTYzjbOQphswLJBTFKRBEm4EOPRfN7dLDCfcWOnf7kTvZJUsRfpKQz5Ff/5G0BvDaIiVzmH2lx0RAQE69Ydnd3HKbBpNzZVxEE9KeoZEsDxrZklAsyQl8kero;4:tearl0i6qEDt3MrDGQQvh56Ndg7IsZPG5+MzG8YAqdmoIcZWE/nqGpXO1/6/owdq583/9LaysfR7fMKsuGWg3ap2hSbfPGoELOlPPaXoUKIQcIvlADU4aVqkH0/58hFjSn43pT/xgCCNW09ZY8QthhOBCcoBN2MewqQ+9JxhXKYnW8N2Hku4z0f2Yl3y4zGNx50McC+OoVsb+17n8qYdBgK8QJahSLa18dvvc9OdZjr7bj0ccVu8q8xBa1xRxV0lQPC1VyBJMHV1xFBLT93hWVenTDSLtC1v+YYrTL5r0kROPPawwyJpzzS3Egui0Tq5
X-Microsoft-Antispam-PRVS: <BN6PR12MB1713EB6ED27D3D335390F07583BC0@BN6PR12MB1713.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1713;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1713;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(346002)(39860400002)(396003)(189003)(199004)(86362001)(478600001)(50466002)(53546011)(6246003)(2906002)(65826007)(25786009)(386003)(31696002)(68736007)(8676002)(65956001)(6666003)(65806001)(230700001)(59450400001)(6116002)(229853002)(5660300001)(106356001)(64126003)(7416002)(6486002)(47776003)(76176011)(105586002)(11346002)(23676004)(52146003)(36756003)(2486003)(31686004)(97736004)(54906003)(4326008)(305945005)(186003)(52116002)(52396003)(53936002)(7736002)(81166006)(72206003)(81156014)(110136005)(46003)(446003)(476003)(486006)(316002)(58126008)(67846002)(8936002)(2616005)(1706002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1713;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzEzOzIzOkpzWW4zNk9lTzJEZ1NYeWIvZWZCRklwZFZX?=
 =?utf-8?B?WW1RbFpzQW1VYVo2ejI1dzJSWS9GaVBFM3NNNHh3SnVvVmRWdHB4UVhRd3R4?=
 =?utf-8?B?NlZjUE55dTNoZmZZYkkvVHRxS2JHQkcyVXk2aDZzcnpqcjNEMU9wclZNN2d2?=
 =?utf-8?B?SHdZc2JoTmVEU1FYeEwrM2duUHB6bHFUU3ZoRzVkZ2kxREhZblhjQzhNM01K?=
 =?utf-8?B?TDBmSTNHTUEyVTVRb0dnUnVJMnlzdWQyMmFmZFU3RjZDOE5MWmlmNVhSVzM5?=
 =?utf-8?B?a0NKbThxdXVKYUMrUnFBVU4vaVJrb29zUHpiK1NPbmRMdGx0MHVxdWxabnFt?=
 =?utf-8?B?QjFEWlRJVmxJbnV3OVU4enNyTkJsNko1WXZXMFl0M2FEeEZHVEREMkwxV2h5?=
 =?utf-8?B?QjR6UkVZckxnUEE4UkFITjJkQzZnWVBaTnR5WDFCNmhwZ1RSNCtZaDduTWoz?=
 =?utf-8?B?TFFKMU03ZEFSL0NUVHlRU2NzWmhPVWZqbkhIdlUwbjllZWZXSmd2Rmd3SHI1?=
 =?utf-8?B?ZmkxZjFGQ2J0QW9tVFF3VWRmSHgvdEs4UlQxbHpCWjVJbFFCWlhhWTQ4V29i?=
 =?utf-8?B?akZjZGlTNENTUmpzcTA5OEExTEdOdG1UNlh0VW9Ua0Z6Z09sZFJicjk3bW1T?=
 =?utf-8?B?aGZpR1d2QVFhSWJSSEt3NmlCSU9rNnRkVVVnQlE3bGxPMmY0Z0xETHlkbE5F?=
 =?utf-8?B?NVFaOU54YjFLOE9vcU1HOG5wNlRqemJJZ294enZ2UHprdHphY25aR1VzY3RX?=
 =?utf-8?B?NWpNQ3NDeHdjWE42S0o2YW5ZZHFZRVgvUHYxalpRcGtVNkJQalVXZmI5K1Fv?=
 =?utf-8?B?eEd3alZPSy82VFJlZTFxQ0RqTzY4dTVYRWtBQVNuNnY2Rk5ldFRNOWROOTF2?=
 =?utf-8?B?V3RTOGwxM0kzLzJzLzR0bDcyUXNkTUY1QzRDSnllcFQvbHpYdFBYSW5rOWZn?=
 =?utf-8?B?Zm9hcVp1Zks2U1NYSlg1R1JZdytoTGZwUjBLeFBtQkEyV09VeTFOd3dXM1RH?=
 =?utf-8?B?OEh1OHprcFRBR2FjNEVSZDZhZFRIeVBpTXlrZzhJUlJ5SjBGV0dNL0kzT3hP?=
 =?utf-8?B?MWZOVERvaG12dG05QlE3S1pFTzdoYXovU2lGTDNuckJWV2g2WVR5NGl3ZEFT?=
 =?utf-8?B?TGVPd0szazB1WndRL3ZIV3d5bGFBTitxODJ5REVJSVpXWEF6U2dhbzY2VGQv?=
 =?utf-8?B?ZUlVdnFWOG9oQjFxdStDNjBhaUR3ekpnKzVWMXVXZC9DMFdUL2lObEFkbERi?=
 =?utf-8?B?cGs5OE1QN3oxb0ltcEp3VWVNR0pZcEZaS01YQmdoYWxHTHRSQjd0TWJYcFRP?=
 =?utf-8?B?cWlaVy93NEFXTlVMb0hYNkY4TEY4RlNQTTlmaC9PdHhwSkV2Q3ZWUEYzczk4?=
 =?utf-8?B?YmZWYkRYK25HUm1ubUViMXkzcDdqUEM4bCtKVzhJSys2eXNGdTNtTEFQb0xR?=
 =?utf-8?B?Mm5rdlhJdk9QV0hGcjBSWFA3NU5XVnhVWUVBWC9UaWV6L0wxR1BpZWtlb0NB?=
 =?utf-8?B?RHh5SXQrem5VOVNUU2J2QkxWUnVBTDBhU1l4Z1ZleW5xbGNrc05hMVRYYVl6?=
 =?utf-8?B?UDZzVHBvNEpOSXUreDdYY2FOWG9wa3dINjVpRSs4V2lLajZIOEZyYjVGZ3Bz?=
 =?utf-8?B?S1NvT2tiZTZxQ3pHQWFhdldjOHNNR1hzQTJrcTEyNDlQNlQvWWQvWXJVT29v?=
 =?utf-8?B?d2FPNnhlSUZNTTMvRU52YjVPeGd2L0k4VTNQZTRDbFBYNkRZVzczZUh1ZVdm?=
 =?utf-8?B?eVQ1NzlsVUJpZHZYTEtLZGZQcVlacTRHN1ljSGF3UGgzTEZ3TVFjWkF3L3Br?=
 =?utf-8?B?UC9USG9QZ1R3T2YranVVVmVBUjJ6anZHNEJYUU5pQ3c4QUdaS1dSaEh3MW9s?=
 =?utf-8?B?MnhCdHF6aTdhU3loRmV4eWprN1k1MFRKQlRwQ0huWXpnR1lGYUJzcHljNHdn?=
 =?utf-8?Q?oMRAcL33KMp9bjhaOyor/fpy/koyaQ=3D?=
X-Microsoft-Antispam-Message-Info: MSf2sReY7d3Z9H1qBiONjwn7iHbKJSrbHmFo+u/cxyjhycceS0lEfwYYDkgLsOAYOpAB3kibcUDg2GGoA7WovXpFo0okmppsiCz+fkIr9IybUMXu8CBrGjwaVgZVBE3/hr0iyBEnpVK+bF/S/9VrCM9HLffQZ5qO8aPJxcdrUvOOV3JqLt+/HCwhldjgiPDc
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;6:mcX/tm48ce6hz0F4ccL+IziGqSLFLne6FGE3VCOJk3FMaCYbZVRb6xdfmAPlTjiKu0+LfUJXAzGrkci34pQcu4r3lLy2Y27JR1m0aPuOqW4/9zcTMVHxqTT3CcsMrWDhO0y2gUhrO4tviJibdk6Ob/Sj2+dRtOuUuuxFyzvYX5dPM/oK3FKgmMakEKrl3uwlB0MQ7C4ix4ckOyHOtkE0xd6d83WKhgRDoL0uvJPXlX/tKtqhym8FDKWz06QuN5zKuHxdeB2JyUrEB/Z/+/IY2v2LOR9yjlOvULk5kAuO9DygbUj91m7bEsuf4Db5JnPx3cGIkZlzXst/85YyjwDScvzN3Fr4Yt7g13DcrWTF9DoDVpl8v/eWXUzQe4AOBmEUSg14GQwg519sygtD93zQ16AE5+tsYfT0iKwxQDkZNC3/Eoo8vgA19vyYO5D4r4XRz2uuYhEFQaDHRLH7Gd6tPQ==;5:ZmQqFbUzB5TISBv4kWPQTUQ2/11Z8t0o/aCnQQHxuR9Mmg/RQFGQnrf2iJgqvBWBAao18PVmq/zQP9c9QDBn31A7jpQGEw8bfeFss0biA2BTQfvmhCQDVrhdCwWSBm2Wye74bw/EWQOoUazuioxWa+pAprHWXvwxXFoJ76gM8PY=;24:whYjZMam3ScevgB7tz9xO64P82R+3h6yzP47tcf8VIR1yiq8QYHUx58AZpdxmYnzvBAZd3Jio4z2mzC/xAk59ZiUu57p2g/8/w7XXWOv1f0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;7:RfJsCB60PRkOdwdVPEpE1dolqiGPDk/I/+pD549ylXWaVz21fxMLM4wAUL0MzavGuCWh9DLo173YfjmyggAvU8Jq9fTEqOaQ/Ig0GsUAnHYz1a38d/c1YNaCpjqZ+G5t6dd1GfgfUBr2v7ssdfpqhDkHJcgBMKNnR8xRmDKRczf9l+2BlFiG+koYu9BOG/tYUDPIo7t3yLJddGrdTGeQ8QgeBbBgBt52VEiigvuboGaoSB79LadbiVzX+HBW2O+p;20:4i7ZRAWMM7v2fh/CuLs0/d103hS0a90n5jc5UoVVgMuqGhN3XC6Ll8nLMAgcv9kQTiGecVLYV/6Nuep+T58uFbO72+bFSW7soFeOFPRDdBPSyBZHU5PMUPdB9/cgN0UoZmUh9ztB9TnF/ew8z6GtUwL/0rHvqlE7cMKx8qizvP2Tu00vQ8H+5ycNL/HHvLVY89kdEVlKiHgCtTIUwK9vvDa8REPphp+6SeVVthcfRCoqaEa1UPOtiFM9XpeYlr+a
X-MS-Office365-Filtering-Correlation-Id: 700a9435-d8b9-4e13-db90-08d5a059bffc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 09:42:44.8377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a9435-d8b9-4e13-db90-08d5a059bffc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.04.2018 um 08:26 schrieb Christoph Hellwig:
> On Wed, Apr 11, 2018 at 01:03:59PM +0100, Robin Murphy wrote:
>> On 10/04/18 21:59, Sinan Kaya wrote:
>>> Code is expecing to observe the same number of buffers returned from
>>> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
>>> doesn't hold true universally especially for systems with IOMMU.
>> So why not fix said code? It's clearly not a real hardware limitation, and
>> the map_sg() APIs have potentially returned fewer than nents since forever,
>> so there's really no excuse.
> Yes, relying on dma_map_sg returning the same number of entries as passed
> it is completely bogus.

I agree that the common DRM functions should be able to deal with both, 
but we should let the driver side decide if it wants multiple addresses 
combined or not.

>
>>> IOMMU driver tries to combine buffers into a single DMA address as much
>>> as it can. The right thing is to tell the DMA layer how much combining
>>> IOMMU can do.
>> Disagree; this is a dodgy hack, since you'll now end up passing
>> scatterlists into dma_map_sg() which already violate max_seg_size to begin
>> with, and I think a conscientious DMA API implementation would be at rights
>> to fail the mapping for that reason (I know arm64 happens not to, but that
>> was a deliberate design decision to make my life easier at the time).
> Agreed.

Sounds like my understanding of max_seg_size is incorrect, what exactly 
should that describe?

Thanks,
Christian.
