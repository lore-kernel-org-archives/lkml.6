Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA22208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L2lWjRCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA22208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeHWAj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:39:26 -0400
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:11770
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbeHWAjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ3s7s/Oz3vuQGUbSpvIeoQi0evSlxWfzgZQ94srmB8=;
 b=L2lWjRCM+KQJkKm126yQPxZlKNHDKI3G0RYK4A/1dK7matY94tIkmPiBix5LQ9hiToehNgQJuMeXN1hO36r1LlPhVhjaMI0ie4fJF6KjQp486btjBgU3GCwDds2/OY+49ZakEIWQuPBDpNbgArlZlOQvin7B/KECvhwtLRDGQNg=
Received: from [10.236.11.106] (165.204.77.1) by
 CY4PR1201MB2532.namprd12.prod.outlook.com (2603:10b6:903:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Wed, 22 Aug
 2018 20:57:45 +0000
Subject: Re: [PATCH 1/1] drm/ttm: Set memory as decrypted for ttm framebuffer
 mappings
To:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org, ray.huang@amd.com,
        Jerry.Zhang@amd.com
References: <20180822185754.104729-1-jiandi.an@amd.com>
 <d22f2dce-7229-aac8-036b-5312927632e4@gmail.com>
From:   Jiandi An <Jiandi.An@amd.com>
Message-ID: <2eeaae95-181c-b856-09ae-4ee2423fe3fd@amd.com>
Date:   Wed, 22 Aug 2018 15:57:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d22f2dce-7229-aac8-036b-5312927632e4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:903:33::25) To CY4PR1201MB2532.namprd12.prod.outlook.com
 (2603:10b6:903:d8::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf590071-d946-4430-9962-08d60871e948
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB2532;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;3:AvTdTt6s3aQSw29WUnzWIONcxrHkEi6cC9ST7ZR/Ypp41dHD3D5dgGs8FFcxBxG2S58UhGEOHEyOrHAFHETUyk1JTC2TajezLLdHhGXGgm8mwYvcoyxUe7bktVR1/R5KybvSbw7CoaIZkzudfZNufgH7RhRDmLShv/huC36QKcxhGpSlPfC7Ti4xn/1Ds9cU4Obl9pQiSKg4LqFf5zP3jOo/XdLkFYFwlFWNodI74+1ZyL57eYdwEhZhIMA1kg9h;25:zGVGVlO8C+VULaor0dKqiCoJbmm3T39PQfHF1vTBfO8XCm2kmlmB/6wNSCSePZtokI7PIwCzvEkbG8+oZBDwAwWXADW181qJp5lV6dVUAHsDTtnmItbGg4QCLIYxO5X9Q/gEgIfs/ri2SkiNP057aztZpD9OPPcWuJ4trBmr2lyU+VKjLfmY7xbAfDyZao8r631Xk7ubn0NWJCIAi31GXlW3azBw6vqeRRyznDMcGO11x2R+0hjkKmWdf/ZwFTLnM2R/efnpic6iHSIbwsV9I0G5Q7FQGCnXMN3fsQrgQc2YtSjKN1XzJyUYON3zJQs5iJAAMfFKuHiFRVZ0z4HSdg==;31:kSoVx+Zw5NAobwJjdJ5eW4WW6wLdjBMy8/iNXeTX78TGqDD2veMyHkFIDEL7E9GHtF2DEZgGqz8llqMJdSuXI/O0Xs6eZwVBaY7c2BUmjpG1Axs9EUMYR99BK6UXzL9nlDaugtDK0m1ds//Z2IXW+h8XhnuOWdy0S4RdKdzmAuYSow+QDt7ZX4eclkm0DsRi1p7oKQfP40sXBDTqe63ElwHaeDvNL22RAJeRnOC/3Qs=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2532:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;20:Zbm1sY/mnYHjP8EIc1XGR47ypjAtBJD2DwZnoDbGbxhu30fhoqtxwzuTgoIlbrFyW5aav/ZHH0pgOf7zOV6Yhg4XRp7DQNDS4pp86VJEJquHGmb/4r5JXFy0zNekrAcP3NmoZEm/RtfUmULt7UOPyh7HS4bY0dbhDOdNgD6HSBHXPInrCwQgllu1kLPrTboj/pYzxazjxQSnJfshKNxHWd+/Qdw6RHLbEie6o15SG8c/R81mlcARb5gkTMgbb9copWjoBqWMwMPqo43rYodF6O+DaBfk2180zEF8BxPi6KBPoUAvdryjRvVcVo6p7FNvHpIrtQIyt1urDLr7D93pP3OzEY2nIF5+FUPURnlS35TySQtdPYV+KDVo/khdIg58ayt7drs8oesf+fWRFpe7Ka94cQgwxGYj8ES2DR3VxFyO7I8ih+4ECSf8rEbLkNofw4wSpiSswJulEcbljjt8Kn2AP/97mTeRfUcf7qb+5xF8NWSzbpfh7KSSYYMKqwHP;4:5we6H7Xc0k9lj2fWki5LV8repIuhNlrUAqtDkwaPTM9jW4S5oQ61NwZyYsnsAPFlHotBShZMN50713E2BK4X+RVIQQQlWwfTo4tRuGiCpnEigmsGCha1Kz5jqLwcukDuPk35KkR1HNHUimcUaSTdHDHfngGbujDQEN4ERPZzPgfIYMmqXrDqeKcOTkeZGlaSMMCI1r++gzietQJm7RZEy7T2wf26o7UySOGPdEdBPGT96spPxK77+V4zdBXbyFio51XXcDf8LYJxUra1NyCUUOCoL3ixMkqKpZdci0mJ0y+O3L+++SwkNcXF7XaFzUXJ
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25322AF8E9E6634B36183D10FD300@CY4PR1201MB2532.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY4PR1201MB2532;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB2532;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(43544003)(189003)(47776003)(66066001)(386003)(53546011)(2870700001)(65956001)(53936002)(97736004)(6346003)(2906002)(446003)(305945005)(50466002)(65806001)(11346002)(956004)(81156014)(64126003)(81166006)(26005)(77096007)(8676002)(25786009)(2616005)(16576012)(6486002)(476003)(58126008)(229853002)(316002)(5660300001)(6116002)(3846002)(86362001)(106356001)(16526019)(105586002)(486006)(31696002)(478600001)(68736007)(6666003)(76176011)(72206003)(31686004)(8936002)(23676004)(14444005)(2486003)(5024004)(52146003)(6246003)(52116002)(65826007)(36756003)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB2532;H:[10.236.11.106];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjI1MzI7MjM6bkozM2piTHdlMUMzbldwbnJPVnpnSExB?=
 =?utf-8?B?enR2czA1cklNL0VFL3pGQ0lTUXNBZXRPbzFvN05SREFvT2x3NDVaZHVZYlp2?=
 =?utf-8?B?S0dpWk9HZzI3a1RzRVQrdXQxYVYrNjg0Qjl2UlBleElHTzZyQ0gydTBNRndn?=
 =?utf-8?B?WDA5UlZodWRsVUdPQTZRQmkyblc3Yzh3Y20zaENHV05hOUg0Qk9na2EySWJZ?=
 =?utf-8?B?Ni9pYks1US9EVlY3R1p1UVJwQWNzVG5kRjl4Wkx4S3BsTXdaK0RlNkJKMFRF?=
 =?utf-8?B?NEpTZEdRclFmaE12V01vWGl5aGxOU05aVzlETEFGbFcxOGo5cXdiQit2eDEr?=
 =?utf-8?B?U3V5b2Y3bTg1MWdwN1FTakVlcGkrV3pER1BYZ1RPWWVNM2FvalpkU1VmVG9Y?=
 =?utf-8?B?QUNvT0c2MDgxRTliUjkzTkE3a3RBQkVFcFlyMnFMNDVRKytrS29nUHlaZDJC?=
 =?utf-8?B?UHcxOEo0Y0o1bWJzUnUrbEllTTlkNVppcm85QUQ3U2ZNZlA2Q3d0c201eDhj?=
 =?utf-8?B?MHgraVBSQjg5YXAvY1d3Z2ZkOGdFUEVleGNKYmhHU1dONk5OdlZVYXkzTk02?=
 =?utf-8?B?b1hpdUJrMit1b2l4UFFkVENVMDhwenJDbTdVTnhHTE1CWHJYUDdseDNmM0M0?=
 =?utf-8?B?dnNJNjEvRmN2MXhrR24wVE15SGQ0MkNLRjgvVGQ5MzloOUdKZi9nZ1BPa0dJ?=
 =?utf-8?B?SVN4eDIwVzNSdTNYWlV2d2NQWGhna0p5dXVyWG5vbHRXa2pmclRuUWw3SFY3?=
 =?utf-8?B?ZGdjYjdmR3ZveGVQd21iRWVnUHdLQXhHYnRqNXc4aWlPTHpKNFNxdzBpY2VJ?=
 =?utf-8?B?YjdYeEg2Vm9kemgydnhIVHhCQWJFZXdKUGlxUmxrV1dOZ2RMMEJjNGMyY2tM?=
 =?utf-8?B?dk5YaUF5a1Y3QkI2aDVieDlRSWRWaEZRNWlvVjNWc2xKQ3QwUVNzc1NTWWRx?=
 =?utf-8?B?UXFoWVpXL0VubTdSaTl6WmxqekFBMHhnV2hQUG0wNVVzejdwWXM5NFBibkJn?=
 =?utf-8?B?L3MwNzZsemI1QkI3UU40bzMwYU42Vzd1cFRibExGdzk3SVU4QXpBeTZoVEsx?=
 =?utf-8?B?Sk4wZzdtUVBNUk9KZGlsZnQ5Ym84Y2ZKTk5ZUld3T3M2MExETU1FRUZqaWZr?=
 =?utf-8?B?SEc0eFJ0ZFV6RVp3ZEIvakpuTDMxUXJXdlZ0ZjZQblVlVWZUU0ZubGJSbU5E?=
 =?utf-8?B?clpUZmdub2QwS1lkT2tTNHBBQXAxdzNkeG1WbCtYUzJXTWM3cHVDZElyckk3?=
 =?utf-8?B?QmRzK3JuY2pGZldvaFo4SFNESzNXMUwySmxvNWdTSU0xWmdIbmt6QWkvVTBy?=
 =?utf-8?B?ZlpUQ09sNG5RSnZtK3BsOHlMQWRORU5nTVVvM3RiSDEyeXVSNCsyeGRsNURF?=
 =?utf-8?B?bmoybzZJbGppU3hxai9GTlZBejhVdnRWdjhLQVEra1ZHM1NvdWJVQWFsS29W?=
 =?utf-8?B?YUgvU0c1VWhNeXZ6YTRSdG1kR1VIQ0d5TDlOOW9LWkpvNG1vS0QyRVRJaUl5?=
 =?utf-8?B?MGZ6V2x4QTNJSXBPSGpVNDNGV28yeGZYQjBoWGl3dXVjVkhNRjJtOVllU1A3?=
 =?utf-8?B?aTQvRUQvZWZUekowRmMxQU82VklMVHRPazBBUVRjNi9ERTdiSE9LZEJCNEF6?=
 =?utf-8?B?WkxULzVnOVFwenozcG1jQ0RoNFJyWVJhaFdTRTNacW9OODlrOGRJN0ZRajNs?=
 =?utf-8?B?V0JScDgvUW1IZDI3cWF3OFh6dk9LVTJnc0tocGN5VzlYb21VNGloeEN6L05Y?=
 =?utf-8?B?OHVaNUhLT3AxUVNIcWlsTW1KREFMM0RwTXpOUW0rb2c3ZFk3NHcvSGNKYVgz?=
 =?utf-8?B?eDBMOFZrMmNNQy9ERHVYS09xZ0ZMaU9XbW1uY1hqcHdRendOcEt5NGdLQ0di?=
 =?utf-8?B?d1JiWEowZ3dGaUhpY2ppSDN1NEpaVGUrM1J2ZlArUHdkMGluMjBtMXZMOVdD?=
 =?utf-8?B?dmplRUtNT2RJTm5hWjdHRFFZSmJJN2RsSVpmMzhWK2Ywb0tybE5VU3phUHll?=
 =?utf-8?Q?CCMXOoK9?=
X-Microsoft-Antispam-Message-Info: jQg2gx2U4sltfI2Qi+cuqGmKrWyXcV+EEhFE/wgbxnM7Hn9+y2q31hBnxam7lhLtCLn/p3htWiHO7c5Nthddrq/szinYbg0l+Gfk8qL6phmhqBbWdtMxjkZw/u94xMD+EKGds5STbM0DkgKDJkfN+v/7bzLqPN4rNYSfKMiyL7yYnS3ZtPZ+qs+eYzX9PTGNZ/L6uX/cnOkLTbxxUhO0WO8aBFtAxxt88x08araIP+tTOsqIlcFsqgl+w2BqE397ZdIarzksFlBjb5bC/dCEIyfB/7i7i7EmI47i5G4zrUEPuR4f1bpaY9WTWWd1vx9MEpfkc2AWOwrIMJjpuy2VLsEhdUOmkc1vqpHYnJUKjAI=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;6:LuP3CHgUTAeiNZRuEsx9cRF82ZN8U9kzN7+F+ufDDW/6cP2NAnM2gEbAXA9fG7UQRMW3zaWt7zEJFqXE86xX3EcWD7OAfFUEdbqMhESjuOAUQEYqLvFNrRZPkh0enEnp/+NvrRZCQRh2FLTvqkftb1WEw292icrurX49D6G+WBMLylRkZ0ElMOCsFYbammoCDUD4WWY1Ux4J290JOrNdrK09HKDD/vItXjcK5/nBHp8NJcJbq73xQ9K5sbSRCQAwY/FIwzOws454vTZioVWOZet/sE6DLd/lmakR0BsHbVTzS50aSpmk7KaoIC3eKV9djg7mLU8xOtHPIxRuEX68NfkCOEdtDKedDd13DoSnHoqcKo7HQ+KA+EOzEFYAitm3nqgdj3TdOoZg4MheubRkqzelEswgPe1GE6Bu7YunA24ltHdQmtytAbXLXL8xg+Om61dAX8P+jT8jFqKGuXEgYg==;5:enhlekauqCGGc5SmxqOXTENR1t9XENXKicbg0eAgefcBozcXVR39dnKGtmNUaF4RJ7TxOoqMm01Sx5QlVKaL56WfcqEPvIboD1q7bJxflmXWy5DKuU+jb8TqsV9hUm5FWQh/XC0SoRw0uGM3TdfOsB6jCxhqPA8U+uYYZNaKqBQ=;7:DtX52fPJDFRCQvyUSGHTvStaUvyZ5JTnOTK8zrnboSfsG/F6VcJBChs3D9k5LbHrir/EL5Y9y7mZkN54NYsFxq7oiwLQ8e8J0eN4ikx+b7xVKfk3tqV52lXJ00zJvowVUu5LiF9kycEAe0aipOxLfuwzMhYn785eQ2CQuEbiAwDhcMJnqVTO5Hd6ZUxv4F/HBcjjK5RLUQvLQTiIkkmAS5BzzfOBeO5lmUo1zYXp6stv7yxtlxeZ8CSQ0wux5n8s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;20:1AditunsGwvmNxdD2TuOS7tCmS1r18uHBs3ftgQ43jFN6zKldWEjxXd/XQbl00E+MH8mnnSCekla+FmJvZ7SY7aND8tkfSQcQ5CJ5iew4QGdRJkbHKSeI/AZsKav67A/j/AxuY6ml/vwnUF+vSi+RiZ35rn7p54VifCxBJkBOfu01fUQTkcIrn2N/QZBOn+z88NGROgWYxjnDGmtpjjhC7zNbjMzHl8zGhYfebLACWCOylbR1JUWz74p8rccQYfF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 20:57:45.4577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf590071-d946-4430-9962-08d60871e948
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/22/2018 02:09 PM, Christian König wrote:
> Am 22.08.2018 um 20:57 schrieb Jiandi An:
>> Framebuffer memory needs to be accessed decrypted.  Ensure the
>> memory encryption mask is not set for the ttm framebuffer mappings.
> 
> NAK, the memory not only needs to be decrypted while CPU accessed but all the time.
> 
> ttm_page_alloc.c and ttm_page_alloc_dma.c should already take care of that while mapping the pages.
> 
> Regards,
> Christian.
> 

The path where the issue comes in is booting guest with AMD SEV enabled while using virtio-vga device.
The ttm->pages doesn't go through ttm_populate_and_map_pages().

In the kernel path, the virtio_gpu driver calls virtio_gpu_alloc_object() and goes down to ttm to
allocate pages in ttm_pool_populate().  Driver in guest then does virtio_gpu_vmap_fb() which goes
down to ttm_bo_kmap_ttm() and does a vmap() for GVA to GPA for those pages.  If SEV is enabled,
decryption should be set in this GVA to GPA mapping.  Guest then sends object attach command to host
via virtio_gpu_object_attach() which stuffs the pages' physical addresses (guest physical address)
in a scatter list and send them to host QEMU. Host QEMU maps those guest pages GPA to HPA and access
via HVA while guest write stuff in those pages via GVA.

virtio_gpu_alloc_object()
   virtio_gpu_object_create()
      sturct virtio_gpu_object bo kzalloc()
         ttm_bo_init()
         ...
            ttm_tt_create()
               bo->ttm = bdev->driver->ttm_tt_create()
                   virtio_gpu_ttm_tt_create()
                   ...
                      ttm_tt_populate()
                         ttm_pool_populate()
                            ttm_get_pages(ttm->pages, ttm->num_pages)

virtio_gpu_vmap_fb()
   virtio_gpu_object_kmap(obj, NULL)
      ttm_bo_kmap
         ttm_mem_io_reserve()
            ttm_bo_kmap_ttm()
               vmap()
            struct virtio_gpu_object bo->vmap = ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);


virtio_gpu_object_attach() <<== Sending attach backing command
   virtio_gpu_object_get_sg_table()
      if (bo->tbo.ttm->state == tt_unpopulated)
         virtio_gpu_object  bo.ttm->bdev->driver->ttm_tt_populate(bo->tbo.ttm, &ctx);
            bo->pages = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
            sg_alloc_table_from_pages(bo->tbo.ttm->pages)  //Getfrom ttm->pages and put in sg
               __sg_alloc_table_from_pages()


There is a separate userspace path for example when displace manager kicks in, 
virtio_gpu_alloc_object() followed by virtio_gpu_object_attach() are called through
the ioctl virtio_gpu_resource_create_ioctl().  The mapping of the pages created in this
page are handled in the do_page_fault() path in ttm_bo_vm_ops's ttm_bo_vm_fault() handler.

do_page_fault()
   handle_mm_fault()
      __do_page_fault()
         ttm_bo_vm_fault()
            ttm_bo_reserve()
               __ttm_bo_reserve()

            ttm_mem_io_reserve_vm()
               ttm_mem_io_reserve()
                  bdev->driver->io_mem_reserve()
                     virtio_gpu_ttm_io_mem_reserve()
                        mem->bus.is_iomem = false
                        mem->mem_type == TTM_PL_TT


I originally handled setting pages decrypted for the kernel path for GVA to GPA mapping in guest
in virtio_gpu_vmap_fb() at the virtio_gpu driver layer.  But for the user space path
virtio_gpu_vmap_fb() is not called.  Mapping is handled in the page_fault handler.  So I moved it
to the ttm layer.

What layer do you recommend as more appropriate to handle setting memory decrypted for GVA to GPA
mapping for thos ttm->pages?

Thanks
Jiandi

>>
>> Signed-off-by: Jiandi An <jiandi.an@amd.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo_util.c | 12 +++++++++++-
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c   |  6 ++++--
>>   2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> index 046a6dda690a..b3f5d26f571e 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> @@ -29,6 +29,7 @@
>>    * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
>>    */
>>   +#include <asm/set_memory.h>
>>   #include <drm/ttm/ttm_bo_driver.h>
>>   #include <drm/ttm/ttm_placement.h>
>>   #include <drm/drm_vma_manager.h>
>> @@ -639,7 +640,11 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
>>       if (ret)
>>           return ret;
>>       if (!bo->mem.bus.is_iomem) {
>> -        return ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
>> +        ret = ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
>> +        if (!ret && sev_active())
>> +            set_memory_decrypted((unsigned long) map->virtual,
>> +                         num_pages);
>> +        return ret;
>>       } else {
>>           offset = start_page << PAGE_SHIFT;
>>           size = num_pages << PAGE_SHIFT;
>> @@ -661,9 +666,14 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
>>           iounmap(map->virtual);
>>           break;
>>       case ttm_bo_map_vmap:
>> +        if (sev_active())
>> +            set_memory_encrypted((unsigned long) map->virtual,
>> +                         bo->num_pages);
>>           vunmap(map->virtual);
>>           break;
>>       case ttm_bo_map_kmap:
>> +        if (sev_active())
>> +            set_memory_encrypted((unsigned long) map->virtual, 1);
>>           kunmap(map->page);
>>           break;
>>       case ttm_bo_map_premapped:
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> index 6fe91c1b692d..211d3549fd9f 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> @@ -249,10 +249,12 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>>        * Speculatively prefault a number of pages. Only error on
>>        * first page.
>>        */
>> +
>> +    /* Mark framebuffer pages decrypted */
>> +    cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>> +
>>       for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
>>           if (bo->mem.bus.is_iomem) {
>> -            /* Iomem should not be marked encrypted */
>> -            cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>>               pfn = ttm_bo_io_mem_pfn(bo, page_offset);
>>           } else {
>>               page = ttm->pages[page_offset];
> 
