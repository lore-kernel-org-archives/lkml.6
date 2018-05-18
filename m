Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeERPUu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:20:50 -0400
Received: from mail-by2nam03on0068.outbound.protection.outlook.com ([104.47.42.68]:60049
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750841AbeERPUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:20:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: Joerg Roedel <joro@8bytes.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
 <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
 <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
 <20180515134603.GD18595@8bytes.org>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <4041cb33-19a2-5542-4211-1dce51de5e40@amd.com>
Date: Fri, 18 May 2018 10:20:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515134603.GD18595@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0801CA0011.namprd08.prod.outlook.com
 (2603:10b6:803:29::21) To BN6PR12MB1441.namprd12.prod.outlook.com
 (2603:10b6:405:10::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1441;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;3:hhOdKwi8UhkvdZgLJ2Dk62tiWzD34318HnKk7ChWuqWi3F9ODqFG6ImH8QD5m4RSH00DnPRmncBDVUTcIP7PXhjXCl/tMqCFeuYeqbO0HBvVQ5ySL4f3jnOhl2Swd5D/gO/nAjUwRNKTNbQLU5EVDaUfbvlbFrL/Ckx7xx3hng6+8y35al/lOav2I3hB9pq4P4s/ji/I4hbfor90ChgeSitxFQnlWTUU49SQ8sBddapB9Wv0yiCTg1z0JTKAab3o;25:aooaDWeDs6jGXN/ox05Crn/68FY5Jm/HwLFbTMCoA7rqprHsDQMYPLMOA/Z+2p9rW97OquN1Mv3sSudsf9rlXwHBfJUVf7SVADaXqMBetupWITZLW84DVmt5Br/pjSnV84CauYxM6NmgJ8p0gSG5dnXKIAU4JvrX1h4ZlSza+uItXqyMJ/gftqymrtQWV1sdZzjk3p/iGEPwQryo4NvlKIj77aKFerqOpbDnA7cOW8VaqZSBoZitMKorisPz+PuFHxBxZDl8h4197ZTYgnhaGcsP62z2gRn9vfbbI/nF9F16wiB5x+XP9w1vnXi36LH0vvn7SVnYXIeG78Uh+C5UBw==;31:RK68vtjMbbu2L8cESxIj8Zr53jKfoqEdmE/Pt6BNZefsWK/YhzWlvF072HFcrqrMR9QBKv62zouEK0D6611Y+lbNcYCylOTamiWTi5B6JlYYizlWzxAQkhJRXmMaYf+6jCxj9FWLhy3gHeAqjZIxrSm8cqfE4RX956uO8GaNo+aLNTNYJM2ENpp63/b9YKDNfXzkbs+2dsPuUdC9qDXNsxVOkYcQbUHr9gIIb6R6ptQ=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1441:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;20:Wd1DvpIEF1LfGonYUrC8w38ZeF+0nS5wy/eDV/d1M2hlSBMk2VdiU2YXjra90XZNRsB9pKHQB4ZJvvwbGAeEhzBdiJPTK66B8R/6xFJ7+P0I8stsfSO143nELfkaK2M7UUyexZ2CBUk5HR0A9GX60/drxOFQ/6coKL6RdrJcmWEN4SxXXd8zTYbbDK8YYlhwPA738qycVTfuLYshXqNou6Z/u6/iWkLSf6hpHJXSvt6To1IcD7jPpjDbGiK+VZ1voASKgbQvVOT6udVXVxJ+6DnVFVQ7mHlcWu1hO7dlIHc57Bjt1/ubXYYIRvmH7G10fRCVXQxfe/trbmz6hvTLKAtHWbD3K0J/pHxgJoR5jWXXxmkgsiVnaPvgfVkAtkpm7qCfo0oZjFSWhFsr5fvexkgR+cfDctnYY99Ep2s/JGuUYK+6BDelMWlyOHAgnZl9OpU/gwFchQeYtXtWpNs2crpxr41kDjsUCvxvqwW1uJc8sGkRSGw7KflL1vS49/Jj;4:3Ce4xq7+Lh0GjN2HJ6nR0Bsju35Wg6KEvtEhZ3MxAzUxTEN5itpkgz36fRZrJqW+WuyXsIaXTIRiBkuxf8ZosUY+t3bXQLhktQfCBd3WUC7dUll4FJhjQryrZvlmJXEdfob26Mhk9ayqh7HRPqF47wbTGiy4QQ666rW6iGfFOQE5wrwWDMCR9IEpfpwXsExERaSFO303Vv/00v0a1DV1toVHZG52t3K5ACeUEEtdYdIPne1/4qTBcpp8ZacvD0gd5Bcr+04PaWMv/3QzHWYtUg==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1441B1DA72D24F51B39B6340FD900@BN6PR12MB1441.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1441;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1441;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(346002)(366004)(39860400002)(376002)(199004)(189003)(478600001)(4326008)(476003)(2616005)(66066001)(11346002)(956004)(65956001)(486006)(5660300001)(186003)(58126008)(6246003)(6486002)(47776003)(50466002)(65806001)(93886005)(36756003)(65826007)(67846002)(31696002)(2906002)(16526019)(446003)(86362001)(8936002)(72206003)(305945005)(6116002)(77096007)(25786009)(26005)(97736004)(106356001)(3846002)(68736007)(53546011)(52146003)(81156014)(81166006)(230700001)(386003)(7736002)(31686004)(105586002)(16576012)(76176011)(53936002)(6916009)(316002)(2486003)(229853002)(6666003)(8676002)(64126003)(23676004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1441;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNDQxOzIzOjA4TkRaV0ZOYllGV2V2dnVZZWtSS2lrUkJ3?=
 =?utf-8?B?K014a1FVclJRWlFlRXV0ckdGd1MycFRlbFkwMnJ2ektENjgxOUlUZVByQUFX?=
 =?utf-8?B?Y0RGNWtiQTdLcytreFJFdnYyZDdMRHc1UWlIQkRpTUlzOEdHUjhHbW4rdENZ?=
 =?utf-8?B?UHhlMHhYcndNc05CLzN2VHZIWFlJNFNrMkxVbXowbXZuK05lTWs3VXZUQXBi?=
 =?utf-8?B?c1RhcFYvNFBsZmJqU2Y5VGtaN3FONUJDOGxEOGV6THdEb2NmUGlxY0p4TTNy?=
 =?utf-8?B?YzV2ZU55dUlnSXI2d3RwVTFiYWhKRFF4elJzZllXTkNyREFVY0JDN2VzVytq?=
 =?utf-8?B?Ym1YaUVVZCsycnNKdzA2YVc1MlVpenh1T3lFVVlpT1ZKNGNTUWk3dlpYdWU5?=
 =?utf-8?B?Q1pCcDJzazdKRzNiMEN5dGQvMTFCeUxPZlVRemt2Nmxlekg2dzN6UFFIdmVL?=
 =?utf-8?B?bW9nYnBPMk1MZzFFR09hekcvZHdWcTJsa29NVjBUYkhFMzZWZ3FaUGhneFFo?=
 =?utf-8?B?QTZ4RjRicFM1UXRKeDBlcGNucTZlYk0rdFlKbVlmNDVHckdUTDFZMCtRak9x?=
 =?utf-8?B?eit5WUxrcHFRTStiNThSdjJmVXcyd3hqS3ZxUGk2ajRJdG9mY3dpVHdFUWg2?=
 =?utf-8?B?SndEZnNYRUhOb1RBZ0hpVW12NUYwWnlYZ1JmTmJ1L3RoUlVVeHhlaVAwajB1?=
 =?utf-8?B?M2NFalNkK05kRkJ4bndaNCtNWk1pZXJXa1Q3TW9LM1I2alRGc1BXWEJ6RDB6?=
 =?utf-8?B?RnArRURmY2lTcUkxMWdpOVlVbGRtc0o5TGtVQ1czWnFEK1ZxTWtiNlA4N1JD?=
 =?utf-8?B?OW83OXpBSktSZzUwcWxHNVFnN2NyRVJLazJtZHRLR3NMQ1F5UE84NXlaV3VM?=
 =?utf-8?B?VmMxNmJPV3pWL0ZBQVluVmZXcHBmTVZqN1BWbHZ0MXVmRGduV0QrMDZjN2Qv?=
 =?utf-8?B?Y3lZeWMwR3g2K3BRUVBiT1ZvTkl4b3lacGV0bVcybTJjdkdzMDQ2NkkrT2ZV?=
 =?utf-8?B?T25hbHpoSDEvS3Q3MnVCQjgxS0xybXEzSlRYcUlSUlJnWTI5WUZDaFlCaEZy?=
 =?utf-8?B?a1RVQVUzVUxqTTlHOGkvWk1EYkU1MTR4VFp4bHdwVmZKOFZzb2oxaFhsY1Rq?=
 =?utf-8?B?bHRReDRFZWgrZm9MeXQ0ZUplTUFjQUloTmxhTk9lTGxuSzQyUE9BeTlTcHZR?=
 =?utf-8?B?cVcyL1BoVkNMc1E0RXVPdVBpK0FLMGhGU2p0S0k2K05xa0tHQlZjTWRjcUpM?=
 =?utf-8?B?NTNLMmVEaGNJSG9rUHlPSW1iMk9SeFdsL2VLVWd1NVJWV05YbTk3ZUErdWpp?=
 =?utf-8?B?WGhMOExDR0tFcWhMU3UvUkNibkhhcXVoNEdqT291ZnlEV0xhSnR6Uk9HQmJU?=
 =?utf-8?B?VnAvTDZ1OXBtM1ZMYkoxODd0c3lvdjFiSnFXQW5tNmpuOWdMOHV1NTZOVjJY?=
 =?utf-8?B?aU5YU1M4c0pnZ1pIMndzSVRXeE9SWDcwRjlmeEpVMEEyZnVQK3JSSVlSSzFD?=
 =?utf-8?B?OTl1TXMySEJrWlVpK0pjWGhNejdVZFNWaGpmRXBkTEttZXYrdVE1WWMwZGV5?=
 =?utf-8?B?azFzR3l5M1RVMjdLa2FHdkF6QXN4Rjh3c29vTERhM1JDcGVXdTU5bHkrVE1P?=
 =?utf-8?B?VVJGcm9XZTBNWUUydGhKc3hFTWZMeFEyN1ZtOTd4SGVMbWF0amY2NG5uK2pp?=
 =?utf-8?B?ckhiZTRtaEpjSks0WlB3dzZKNmNvNzAzT3dqL3k0VEhGUDJKSGRLdDBpTGVa?=
 =?utf-8?B?d2RkV2pCUS9oTHdMYjlXY2t0ZXhCbTBoRCttSmV1Zng5V1R2cTFpV3pWaGFo?=
 =?utf-8?B?d2J2QzM5QTRnOHBDRllESlI1ejJXTG9FbWhpYXYwSllBeUZJd2lOMTNoOEYx?=
 =?utf-8?B?TzlzVUxvRjhGNlg5MDNhQ2RWdHVVMkZ5ZkZKNllkbXp3ZmphcGxWU0h5bDht?=
 =?utf-8?B?YTE0N2Z1bk5peVI5d1I4N29jdGI1aExVSjM3TzJVTmptTTVVdzB2NENqTjhm?=
 =?utf-8?B?eENIVFhYM1RvNXVVMnZzaXNLZ3Uxd0RyWHZJZz09?=
X-Microsoft-Antispam-Message-Info: rgJpA0aDl7aCMAEwwMzuR55cNa6mBnAiAfsG27YxlRDPIL5ITkNdM8bZOmn381FzsF8Egm6qKI7Z/IeAo5FrwEJh+8iA8+0s0aka2IEeSSXtUY82IRGOtkV6hUmiMf5FKFlWUVqNnzULKmUdoS5Ik7uMWj6H2jIy5/WiPr/cNKDZ3Fl3vtaICKtwmfJHviWA
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;6:o8sYtdPY7TLnmWHh5qdvDemm6GpPyq3yJQ7083bWb2+Uf6tB2iqD5VejOjMzuwqlaINzF5KYRC98S8ARRVxQvveTJJindL18DU5s7rnrImOfqPo0YpI/40aVzOrVEpO8u8ebZrZatI92vtSOUddDI/eRrNJa4dTKD6JFLSC9yFYSauwO89FDLYY6NvEINzuY6Xd489nFl8Q3W7sG6tEDDlDob0i/fB7sKIiUW3A51Uos3JckRSPT3Zfk9iDdNJl5nJpQqVpcT18HTKjkt1u7mS5mtTxOLq+yqR+dumlRJ5hH8QRJ/YlwSYdT5A/9OuVrZ+Wwx7NrEF5hFS2gGKIUHKH6QAZ9s26MdS/rf+PgQs2vxJ6Lu9CuNVw9uXkDGJlVFFUWBP3Zi/UF2aJ6EMLGEKijMFqIifANZ29LuMxTKC5NKNUwXLHNWCddxWO69VyRELPqNpqIl0e56xEK91bHkg==;5:fWes25YCxRidlFHIyciXgovEdEVe20k3zkUFSGWwEkFMe5ptkghN9BqObhrS4slM/XpwcRmGF76dYiD+k+oBpNV7UiJ+IF03oIakqMqae0UVPUmu1ay6ZMdkXlBBlg4h6ipneZbstddAIs66NRUsAUboT9ubTBG/m5U5fytE9hA=;24:yzhsahHFBOW7mosjJpMevsPe5hmzlzaH91/4S/BCzP0rMkcXpu0m8sfrJphNeSq6y/azX2a2H16CucXMAEvxJI/Z5Ylp7YC2WFx3PiqCdTY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;7:eDfo41VBY/Fb+HflzOP6eULOfFtbmw3t/O1t3+GbieZKFr14RJquwRQjAo2k8+JkRFS6TqCS/HxPlOC2C6VRs0Kwgt3lPaAV+vnuXkjaxlJKBTmKsEpNbsRqsgueRB3Ho7EtMBdCVfirxTeYf4bRtSpr9fD/qosfspoZUv3M1sfwR/rq7RC9joZlWMGkpnUQN0wDQ2N3Rw1ZDG5m5endgRE3UwpED4zJarjL+s6DSt61lIqX2oIJL8EMRF73f+J5;20:o65dAmxVv7tjbL066hKEV3zWpzUrsJC4QXqQJFUd4CydxilrmaqFxWlqLauW0AtAn8/+t3l2q6MQkQ9ewwao4YVWNdvyJdU94NZF2yeUwYN8KS1Cph3lIbeqoCJlLvXg8FwDzgqRN/ugBK40TV1m6qJK/jrLh1PFuU/RRoiysp6w7xdCpPf4I9EZi9cNx2TP/jgXEpT8qY4p34vE+B9LIQDsLmkNYF7E4g9YyiA5hyuaipDGjCI+KolH4fn8QDdW
X-MS-Office365-Filtering-Correlation-Id: c5f7dc49-1248-4404-2bb9-08d5bcd2edc7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 15:20:45.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f7dc49-1248-4404-2bb9-08d5bcd2edc7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1441
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 08:46 AM, Joerg Roedel wrote:
> On Mon, May 14, 2018 at 03:00:50PM -0500, Gary R Hook wrote:
>> This was brought up a few weeks ago in, I believe, version 3 of this patch.
>> That question was discussed (because that's what I did the first time out),
>> and _someone_ _else_ asked about why I didn't just do it the way I've done
>> it here.
> 
> You don't have this problem if you put the code in amd_iommu.c in an
> IOMMU_DEBUGFS ifdef.

Of course. My preference, however, is a separate file to avoid size 
creep. That's why I've done it this way.

To whit: there have been threads discussing the 
advisability/acceptability of using #ifdefs for debug code. My take-away 
was to avoid them. Perhaps I misunderstood.

So: I don't understand your comment. Is this an observation, or is it an 
imperative statement? I'd like for a maintainer to clearly indicate what 
is acceptable, and I'll do it.
