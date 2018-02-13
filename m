Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965562AbeBMTZG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:25:06 -0500
Received: from mail-cys01nam02on0056.outbound.protection.outlook.com ([104.47.37.56]:61952
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965313AbeBMTZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:25:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
To: Joerg Roedel <joro@8bytes.org>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
 <20180213132216.gyhndywyu23cdzbv@8bytes.org>
 <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
 <20180213160018.fg7baclgu5o5rgxc@8bytes.org>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <f7e7e2c2-c83d-9c4a-f3ac-5c351576b567@amd.com>
Date: Tue, 13 Feb 2018 14:24:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213160018.fg7baclgu5o5rgxc@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [66.187.233.206]
X-ClientProxiedBy: BN3PR05CA0010.namprd05.prod.outlook.com (10.174.64.20) To
 BY2PR12MB0694.namprd12.prod.outlook.com (10.163.113.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e501f92-a521-4be1-a44b-08d573177af3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BY2PR12MB0694;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;3:sc2vGjcrid+zJ+Zm94wIUyrDRokXRn72GRkLFI5qz+9CWqjo6p3RF03HsaMF7zDsHC8jHJQzZeKqDGvajMyp1TT7zYSrUdoLuYo9wgFLAhmrMKQdWl2N/8DFR69mlFPSgHepcSZB1A+GGS7ehXuo9lthTzmrHR5txgZxiKHtn3PUC90NjEljTh7STIu+LnKHNi9Pj4DCXu6q3NnK4s0sJwKZnirx1IUPKAueb96SxY4ixt1dr7DiaoZvQlw79/JS;25:8T6PQDfwMtLf2FA+PC4FkGFsWLWgavmbml+ok5Heo0Foc1hPgg8r/RXC0rByJZK9LkBzvL7QyYYO8qmzbfQXWruMysSTdYMi6pUPigLNq/x6KDdnqWGVVKfiTZ8Igk6mIx02IuYhuDcc+RCvTrDfcPXODUB8KBmLf/sBpXrjz2slIklUoSBE8jB00vdGew9dwcPqfqD44gARFMZ9vs4ep05Yz8qK58moaIHWtVRbzDyWAxtXGnY/WeIpdPMz/XY1fMPNlI9XlrXbHei4gCpdsSql4tdQ1mNxV78OjmNQNe6mc7VKnLshLR+JFcTO4+sTcc87UY92MsblKu+vmEWdxA==;31:TNxJdcTZJDeLdWQ4CucBkGFoPIWILy+t6YqSSthBIMjlE/B4RwGAJ4ErHMYhPU2DG7PjkRpk/JMKSv1i9MuoBEuG6p9yDYksPthCmp9r4Im1VKYHSW1QM/HiIlr42neW9gWlb3ww52Ed0ixbkybVKjrWyurNwqeBCsTh2vXsoJAgLN8VH5P+wzBENTEHH+mwHT1tcwOP5pJfApB9hYSvWFSUuliSSOR/V+M5MBDQSXQ=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0694:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:2pcNkp9hgxA8Ud9QyzLl3/4bu4q+aFJ3p4EH/RUeRdfO9+oBAH3kJU+bBdHqGUiXiCLzkWWdEEOrUEq/MXeqnZGtVkP4eza3Oc/htOFQv7HPZcma7OdYnAcvX+3ZvtkZDinJQw8U9QgQ2k6tyumV/yxHarDOrDs/KnBbRngbMILUA/xTpvZ8ojjsi/lQwX45wdIFOvCdD595yjongTehdmNFR9T9KFnmS6GJQ5EHRWVj9BGF/jX8EA9iQJRQ4z6WD6SyZqgciP7CFTUjMMgqsksTJCVoakuLCxU1E0F3in93HPSQs2QTYmES2/yZXm2isLsnbkeb4n1ZyLJaI2lBQUb4tcFMiptFdqOkJ13j5tYPNT0oLNOqWT3/AeUUPfsfgzwV58OmJ9m7EDHBzn4twvTeay+S3ot/fVkdHV55NTf+nHq8p9YVwgI6++Rx8FgC3RFqoxs91+RGX4seYALgeDO/jd/oo5/EZmzCSG0R9PR1Y9Q0w93kUrgdolsnpBob;4:YporNGuLxMAeiWEzg/gD+krs9V49SVOPoKeYdBIdyUg4Eo7oKF7l7AdxpVje7iTCMRQGnEb/7lHvuXP3K1OIC/cAflZwRJC0sNnZVJxjWbP7rEzYIZ8FfKxOVQnv4UV6H3FRmyL82A1vJKwPw0a/fzQnvxS8D69GQ1Jpe0N0fD7HI55JtyHxTDaaqMt4uSJpx+WdroD9FPF4V+LgJSJYbVd0JYqOcU2zBl2HAVT3gJ0iNXZx7HXsLXiOiL8lr8IpYBB9jb2/5kOktjnK6hAEDw==
X-Microsoft-Antispam-PRVS: <BY2PR12MB06948AC1FE2A8305CCD09532FDF60@BY2PR12MB0694.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR12MB0694;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0694;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39860400002)(396003)(39380400002)(366004)(189003)(199004)(316002)(93886005)(65956001)(65806001)(76176011)(106356001)(81166006)(2486003)(52146003)(23676004)(81156014)(66066001)(230700001)(305945005)(16576012)(8936002)(229853002)(83506002)(97736004)(6666003)(58126008)(36756003)(386003)(6916009)(53546011)(2950100002)(47776003)(65826007)(25786009)(67846002)(26005)(7736002)(186003)(6246003)(3260700006)(4326008)(90366009)(6486002)(5660300001)(53936002)(31696002)(3846002)(2906002)(6116002)(77096007)(31686004)(72206003)(16526019)(50466002)(68736007)(105586002)(52116002)(478600001)(64126003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0694;H:[10.18.17.154];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk0OzIzOjZVMGdkWElvZkx5QXNBTzBWelRoM1dydkdu?=
 =?utf-8?B?VG41cXIrK0QwOXI1WTU0eEV6RzhQSzN3SmZRYUMra2dIbGlMQm1MZFA0QWZ5?=
 =?utf-8?B?NWU5blBxV2tKRnBUTDc1bC9iOG12TXczY0t3TnkzbVpvQzVnQk1EdnlpaDZu?=
 =?utf-8?B?N3dEbEZVWlFUakRkemFmbEV2VGZGZExwNmFkeEw4NHVMOENCOTNNMHprb2M0?=
 =?utf-8?B?MWg3MGxHZS9idUd3Sy9rVm52N1JZdHExY0pVLzVHQVJKR3NKQUg3eDFGTlpQ?=
 =?utf-8?B?cnZGb0xwSWw3Uk1BMEk4Ukpqd000cVJETzg3NjVic0haOFdjOGxqbUJ0ajdq?=
 =?utf-8?B?K204S0FJOXI5YVdKL0ZhcnFVdzJyVmU4L3FyQ1lSeXh0T2hnbktnUHRYcHpv?=
 =?utf-8?B?VGdqdUxuUllyem5mUU4zbHJrRlN0SmRSeEIzemlqdHFESWkvVGtZNUsxL0k5?=
 =?utf-8?B?RjFQdFFMY2RiYlZkNkVxY05acC9QdlFwNGluTGFSOGZObGVqWitCTjRZNHlQ?=
 =?utf-8?B?dmlkbG5iWkFYeloySGFOc0haQ1RKTXBpTkdTNGFsam1WeTNad0R6aW1lLytq?=
 =?utf-8?B?SFVmVHlwbU1qeVMwZnlHRWc1NDNUK1k4MW51U3UwTktEN0ZJZ2ZNbnpOTGtI?=
 =?utf-8?B?RStNTC9wTnZnNCtTenZvTDJzNEw1SW82dUFkaWw2VURRcUx2QThUYTlYTGh0?=
 =?utf-8?B?WFdVNGczRFFvQjdHZDBKaXRacDBVaE5Waml2T0pkZVkwL1hFa3NYTGVGdzdP?=
 =?utf-8?B?aTBRUjZHNkFwK242UzEwYmhmQUtrbzZvYkc0dHhncW5aUXl4Z1gzRGVqTE82?=
 =?utf-8?B?bTNBZjkyOERzWjkyNGFqVUcxRUlSYmNwSFcrNGRKKzBoR0RQVVJzRFN4ZWg4?=
 =?utf-8?B?RTlNR0VHWjY4VW96NWtUZ2k4TE80UzE3REFiZkJBM010ZE8yQ1RpL0dJclhx?=
 =?utf-8?B?NGdlQ1dGRXN6dWowUElIUkxTejNNMkQ0Z3FuWHJST1pTTUxJaVBNWjFySkFk?=
 =?utf-8?B?dTJpK1l1OFFSTW8ybCthMWRua2toWkxyTUZ1K1ZZV2RQbFF6cTdUVlU4VVNK?=
 =?utf-8?B?aWtGQ2Yxdnc2cG9McEdxTS9oSUREejhBQmdGZGxWNmpld2wwdXJXYjVFTnpH?=
 =?utf-8?B?VjJpSkZhOHRwMnJrbTZGRkRLZHBZRUZsMzZVOXNzdnVDNTNUZGQrWS9MWXcr?=
 =?utf-8?B?UVRqZE1iS21zaEFyU2FvWFQwUkYwUXRwR0lVM1hQcER1ZjJ4M1FhTDlVQXlU?=
 =?utf-8?B?MlBvVXVNN1hqTDczQ1F5ZUJpNVRuYXo4RWlhZnFRTXlWUkNud0VyaEk0aGpz?=
 =?utf-8?B?QWRUcnZVajJrZEJiK0xmOUExYjZqZElmbWhyMDRGejFDejhyTzhFU3g4WmZO?=
 =?utf-8?B?Zy8vUEpJZG44TFJUVnFPNDNnS0hFQmNob1djUDJtNHdsd3pHMEFZa0pSL0U3?=
 =?utf-8?B?OTBqajRwNGt6NXMyL045OE9Ba3NsMG81bnhwY3p3ei84MzA3UnRseVJ0cWZq?=
 =?utf-8?B?UzUxV2I3VU1PSDl3RWYyak51SFJ2QmFXTm0vczlMZ0J1WHZ2a0JOank4R3BV?=
 =?utf-8?B?dXpmVnJDQ0FhQXVCVG9IVTdpak9LWllSZnlVTDFTeFJmZ3VVVVRUZmZQMzRw?=
 =?utf-8?B?T25RQ0diTTh6OHpoL1E2SytGWEN6czJtL1p5TE0vOTc1ZnViN0dDU3J5ZUlv?=
 =?utf-8?B?OGRHWEltMVlZVlY2VWt1cW1kdUxaTnJ5MUlFNWZPRXN6emg5dWhjd21kSWN4?=
 =?utf-8?B?NStJc3oxcklvSzVnazZCdnF4WXRxbXZhVGVSWHlCNUljUlB3dXBkd1BrUkNZ?=
 =?utf-8?B?R1pLWUYzR045c210dmoySEg3UVNydUtpT0ZaZXhlQTRiaFI2TGhEVHcwVTJs?=
 =?utf-8?B?NWVkVzBIdVNqeVJBVzNMNHhPY3NaZ0U0UzRqbEpnekxlYkpMNjhoczdreWFQ?=
 =?utf-8?Q?6NAJe7nwLv2abEirGhkc1xX1RoRQTc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;6:eAZrenXzi2DNx7NkEyo7Pcw1Sm/1wajMPBq9durRIo3EF5uvjdzeVSL9V0/MbfA6m1dLMhhnJH56Zq+HMxqFf7eSFbrOpclGcfNNtubiURTEhuhcI1m3bhNu/J0U+w4+6z9EsyHgXAkycPiWwWqGsV/9BeZCutvfALkS80k8+pIUs15zZ42Z259xNCTSSCV/XBeGrBA9pFW8gDC26ZCkiJPA4TAg21W1BN5DpYOfjLHJZF/eGJ0ZZefsE5HSEVu2tOuBRoGXeq+uvBvDVbIoIIHeV2b9qnePqRHDMQgBij2FP5nM/+UdXOEr4vtaEVaXlovIu/1NodY3THk+LT397VJBvPvXPbUut+dcc895TW8=;5:/PEszS9TY6WKZ+uFezSiG56ie7kLtYZHt0wQmNtTCJaXhV1ynl27fXNu5W8ysqJ+rmi4Uehy+w3VgZ8hCEk5XG4JeqZiB6puJSDsBJ+1IVTf+w4PvwJL7LPS5VLvUlBlua6peLnkGb0c5Jufa3N1SoO78n5/blDcvflReGQAR54=;24:AIM6/+ZrsfM288HZ6JAH97z91lneUhuHx525cqTJnxNzEcZkYg5sI7i8s9pLHHa/qfTkts64hkSwWy9psZLRNalwBq88biF9AtDgqFgr8s0=;7:VEdwP7NFmihj6x6g4yn4R+FwTJGDuiczrCaI01BLuyUDluxthxyFDOMZxx4ee8JmUkYCzyBq20x+x9FtEPRJmJvjRxNDxnJzJ3/tjCsBAIXkQ5PqztRmaqldKDF8AcWD/0tTtY4Uh2ZzukBbn+n045N1oqoTStEZTnAO8g/Q/sL2GJrW6OlW9LytUI8JHsKhOKQFa2dO8mFy5bKfkdQ9dt4t6UzpZwIxvyP0xM8X6Srb1DZ1/AMUiWLXBabel73F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:Qdkc2SvJ9QVwtrXwu4Z1XhfpapVxwpuhnLq7OUVU4zY+bolgeCaXDr9btY63WrO20A/z6nMk8PesPi4kVMp/hUpdo1iLnhGeus64WvOVmgs29eohCThDm3/kRQdJL9v5sJwsOsLUIDqE4O4ZQ5lIqeCnZUralxUvZSaCSK9EEP66SEME3HqeHd4KuT5IJ659WVCSCkkUYy87P1vxcC13Xk3nyNdwZvvGwAl0C+Bb4BOSmsMOCHLE8PxVAJPMJe/p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 19:25:01.9210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e501f92-a521-4be1-a44b-08d573177af3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0694
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2018 11:00 AM, Joerg Roedel wrote:
> On Tue, Feb 13, 2018 at 10:47:55AM -0500, Hook, Gary wrote:
>>
>>          dev_err(&iommu->dev->dev, "ILLEGAL...
> 
> I think its more something like iommu->iommu->dev.
> 
> 


Without actually running a driver and getting some debug info, I'll just
say that my example compiled, the amd_iommu structure points to a 
pci_dev which contains a device, and the two possibilities are likely 
equivalent.

I'll vet that, of course, but working under the assumption that they are 
equivalent, the question becomes, do you have a preference?

Thanks,
Gary
