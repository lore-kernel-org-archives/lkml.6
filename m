Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeDFNRo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:17:44 -0400
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com ([104.47.41.83]:34992
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752988AbeDFNRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:17:42 -0400
Subject: [PATCH v3 0/2] Base enablement of IOMMU debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Fri, 06 Apr 2018 08:17:21 -0500
Message-ID: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR11CA0031.namprd11.prod.outlook.com
 (2603:10b6:404:4b::17) To SN1PR12MB0701.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28bfd7b3-02aa-4195-ee7b-08d59bc0c543
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0701;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;3:F4R3FGjpki8eGTiOoLF1pj3RySFPznSbI0M7uMLrznfqZ9Vpo5CR1KZmTfIcEQT89jujG/ZYx6XWkjX5aZW/VqJMstAP5Lpm5KBgeHyxIiRAIUP0PFHRtToW+/UcrZ9XvRIGTJcM7W/pmxXGGXMHLRTvzDHcjZTkXQ0khSpDFjZiyy46krOxrG00b3f9+pEUa/ZwcQ+AbC7BSHPlVY3qPQEW5CS1kB5WZQ1RxFq/cdgD7QnCkXTJdHxsB4sm7cba;25:o5Yes7jwir0vezhS8oUqRG5N8MfH+NTBNzcdP+f8uDKQLjgyPP1NWEJ+lM1hDbCyUJPRDiV4x7lGzxjnX4tmwwBAx/e5ZP7OXTmyX3OqPLFxKSXmdQcZfH6Qk1x20xP5U95jrZVaqehDSJDz+8T1ABXgel8HBR/kjGhW6yM2qyln3g9THRsGPZjAZNudOBxCW2RDR+vAKT7GihM6PMpoul+1KRKsHvQIkzG9qnW60W/HQUiEb12dSdsSV1EqeCfytrqYCxGHLE0JqkP5TB6ndr/E45Ub7pgMKhLSnT0JZkyRAslRM6baRVZXB5cgp+bsPvnemTI8tNWysoQiGWR7oQ==;31:MBkoyQz5bcaGGSMKWUP9ZoiABZwWnEcipvGAa0PZYEYkQHbw1EREIuIduLzBYQfKkoK37zCs7sOeDKvOiWe044Dzd91EdZmnJFC6TYhzqJU+UaE2iMyx74PZTZlu6GeL9fwTpBaAYamF9qiRkk7eXr0sPMK+41LYip3w4xM9LEleQnAq9A3mcP/KqfAyoQmdwYd40vclRtHTD7Q404RrxquKyii69TYJJIPlzgVus14=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0701:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;20:kk93xCdYojt+4KBO6eH6Tqefz+7n7S+55EdjT3KIsTDflmwK0RWuURZ5107R3xC1Gact04YrFOSnrnXd3klnS8dwFcNhKNVaR/nT8hkHnNhHkxPzNZa2DKxBqrTI2jyYcCaQ0hB5WfiuN5AlsRKjD6xvO6Z0FCfc/HX1jr7ND7K98Ut6xgudLxdmAHxNt4GVuY17GJoktJ0XV0PIKbXIsyonHAsEWsVw3NmC0bQIAjXLsyaItSaCTBV1hQeW1MRNRlty6IruOQCNbv5zKbbhHGZdtVHh111Nft0hsl8Lv5F8gOzUsYH/tqPKnCKUbK8isw4bHlk9I45+lUCxd3Wad1jtpqRDE8aFG2U6P+tK30cr1kBeZwqEPQ/2adcXGCpuPiSlU3JGId6jO+D6Cwi6vqpaSFckFN92YyZaLVqQxtv7zTPfKAxokzVIlgjSN+0J87KaVE3omsDHfEyW+X+AsvsjmX81qCV2XghcD+nBYVjTw++awJzUtHXGH8VuSqaV;4:HVkG2NB6Ep67nss4IlPY069KvGG+IR2iNdiMQ4BUSTIzBdiWFGqFjzRuXZ5BoVDqXmztFv3T5QwENvxFCyOEapYewX7/hHiGyyRRxCf3FedTacQrSkoSX6pMNhehVEmqtNOidtw92+skmxxPFRVjrQwyWc6LS7c0Db/L2DvwbPTkG6vvK5lhmwQf+hVz/4zLwzMpkBl4Azo7g2NUNr0RhS3T4xATCxT8Vy8+qFRE1a+iKXqgp8raXolkaHhHBp9yZ6I63Nnoq1y7jOmAiJ1XsQ==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0701E28DA216598284D7E69CFDBA0@SN1PR12MB0701.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB0701;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0701;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(23676004)(58126008)(59450400001)(386003)(68736007)(2906002)(476003)(316002)(6916009)(72206003)(25786009)(230700001)(106356001)(66066001)(2351001)(97736004)(956004)(86362001)(6666003)(6116002)(2486003)(26005)(186003)(53416004)(7696005)(105586002)(50466002)(53936002)(2361001)(81166006)(55016002)(81156014)(3846002)(478600001)(8936002)(8676002)(47776003)(16526019)(103116003)(6346003)(7736002)(4326008)(486006)(305945005)(52116002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0701;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAxOzIzOkVZdXJhQzFqdldRUkVFODVvaW4raktVQVhT?=
 =?utf-8?B?VkRVZEg4OVFoWlRPWjA3RUZBUjZTK2dWdDZGa1czQ3dhNjZteG9URVE1dyth?=
 =?utf-8?B?VHdqaE9lbWpWT01VNVloYjJpL25jZlRrL0hGSHdvY201RnBTUVNkN0g5Tnpl?=
 =?utf-8?B?UzZzOXlmdkQyaGMyZ3ZKaWF4MURkTFBHMVR3RUFEM0t1V1ZZM2JCckh5aVNo?=
 =?utf-8?B?eDBRa1hlVTJDMGd0UzR2OHhKOHlXRndwSTh3MERDUDUwNldJL25EaURCRHkr?=
 =?utf-8?B?SGR2S1lZeG5pSDVoNVFyNXArTnpGSUhaTXFFaEMyNytqNW43NTgyZUF0VS9l?=
 =?utf-8?B?M29FaWd3Szk3MW5iQ0k5eDJhNEQvMXJoSW1hWFYvRjZyNkg2UFlRRUxwOE9S?=
 =?utf-8?B?blVSc2o4S2orT3MzTE13R3lnblJrV1NVSXIxLy90NWVqRytJbC9iOEpqZEhn?=
 =?utf-8?B?VnFndkFZTnhuTktjemtyK3B0dStLSDFYN3ZRQm5yQ2JGMEdaWG5YRkFSZUtt?=
 =?utf-8?B?UDB5WHVrdnZiM0Y1V1d4c05ZL0g4cTNGdzZkZlEvQkU1UXlYUFVLM2dBdE02?=
 =?utf-8?B?dms3UUtGYm5lNm4zMExGZ3M4NjA5MnNudlU2aG1DNUNzcWpiZ2ZqYWlxWHFJ?=
 =?utf-8?B?VjFXeXc3RkF1bWRVWXFaSk5nd3N2SzdxbzVDQlJ6cWY0dE5QRjJyb3FkVXlq?=
 =?utf-8?B?eW5KaXh0NWN2dEhET2dQdnJLeWdCNHhiYUhMdlFPWjl1R0YrSmtKdlA5OXpP?=
 =?utf-8?B?alo4eFJuZGcyUE5CQjFROTFaNDBaRkx4T1I4MjJyNkl4cWN5ditzUnpKNUpR?=
 =?utf-8?B?eXBma0VOSDVleER4VW9jOHNzRDRsY1U2ODVFNzlVb1Q2NXZyTk5jVEpVR2xt?=
 =?utf-8?B?Tm1TSUNiLzE2TTBWd3Fzd0xrTm5FOTJkS04yNzlicm8rZmhXVDhFWHg3bjk1?=
 =?utf-8?B?d1pUVjhFK0ROemJwcU04UTM0V2pyVCtNQ29EbkRSbnltZUhVajNRWlNjU1A2?=
 =?utf-8?B?bWtZVlZJc0NVQWMxaWY5dExTRXd2cFpBNmRIQTlNNnk1U1J5cHhKK3N6eGtq?=
 =?utf-8?B?TFVKeStsUDA5eWQ5QnQ5WE9xMW1oMHNMRjBqR2VQQTZLUUYvTTFVcFM3RlIx?=
 =?utf-8?B?QmFMNEYyWHJQeUFBWVQ3TXIyUU9rS20rVHpETHB3NHNSakJFMkJOWWxLVU5k?=
 =?utf-8?B?S283Wk5VQzhEQTRWb0JDTWIwTXhiYmZKMnVobFJ1YXEvU1BmNnlCK1l0OHpJ?=
 =?utf-8?B?NWZKQnd6M3ErSmNRcVE1THN4V2VCeGNEVXlTdzFwMisxSzBzbUwvbGNBUU91?=
 =?utf-8?B?bW9DRVdkSW9MWVdyamhPMjlwWm5EUGpYUkgrM2dubXFmTjU0NmtYVEwwZ015?=
 =?utf-8?B?ZWtwRGNBampEakJYUStUczV6OWtjZW9xeWVJc1d1WnYyREc5a3lzcDZpU2lI?=
 =?utf-8?B?R00zelYwa21Rc2RUbE5jL3ZZQXBpSlRSMVRvR3NqbHg4VXE1TnlaVzFpTE1z?=
 =?utf-8?B?SXBXYWZXSmFoOElCQ3VmSjJ1eStpQkU2WXpwbitobVFoNXh2MS9PS1p6and1?=
 =?utf-8?B?cWhxOFg3SUxkT29Mb1dqR3BKUjNocmhOakJDUUFUVHZmR2ZHcHh3QlpXU1ll?=
 =?utf-8?Q?gacAmgBj/2ln+1t4ktYZ?=
X-Microsoft-Antispam-Message-Info: V973zC2oYtY6mDcLCmTjz/tGCnVdnWLrB/dGSUa9LcM8BgcWXBKRsrNZh+dSDu35LedfMDvu8c1eiDXJoPzA+78BBUAsml/ILOCVGiMpRZPqr+bmP4kFyjXQd3bEqiZ+RFLgl5PUV2LJaXJGvoQp+LodCLV38w9uKsyhzseZi/IKXCU+PkTGPvE8/FoDsH4H
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;6:rWyLdU0fQ0saLTsqJ3e8wzjRPrADG2ltu4CeMZYxVU7Jjbf53/fDkerGjAUrFichLdSdQ7rlIDwi/6MwDAGzldEpS9yCuMahhgFm0Y7amrxrOZMYlIsiaRyfg4Ga+U7+V0Zlzq+5cmzGhumGLIB6eoUzsJmvCc3BaVs9rYthchAm7IhPdyre4ogYvgGMs+QQgxnhT0DgPJ0HXjsfc5udefNgYRuL1/JMrlh1kHM5VvktzjyKgc5Fyx4rIny5tc+MMcxAqgdhDCs4jwTiLueEtGNsj55vzKtGUFu36b+FODP38RM29JEJ84D/+OvseDfysef0zfKqqp1QzBMvbqjFQHC42G3im/sahuw3pkGZgPL4e1wBsHV6NLbjqNW+4sDJD5p5U+lhsmFuT8/5yoVUsXdfhCn2rJZOHR7TLauPVaABv9NEillwAKOIiP1D3H47owtLVdc9MebHXsUbeA3xFA==;5:K+AWSljFuUqBh7ZzkS6zoobN02ovym0wfSPGYXV8bWU7fUwSkG7jJCwppCpwU9lImqkeI3msIC0YGncfSMGXjwfCfrEl4HaCwweAfU+jhAymnC0HYguZYxdfbY5xvfmnNeuXnFNKzJ2XDgqU7Dv25mqomZioA0N/2ufmqorZI8I=;24:1njdrer0KcDVeRMizQjY72LEF4mQGe7kIi8+6F7kz9iEgdNEziyDNWl1HmhWNmHk2WSRfb5Ire3/3Qr+W/v6nkPDAMKGug6qg5Z9ovSJfyE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;7:BKI/ZDpoqsrTfsVYflw02tjST0OQV5fS8CD1vvHI08lDfgyLTHppUhGSjbmsbopuQKKDyBNVzjwQWQ+Uu1naa4rl7/eI7pQbbNpGz8mH3P2hvEqv4TQy+ws3GS0tC4iQiGCYqgpAuTrCwraMSME5mwR2PWTdqFXfC6J2+oAhfeHA55M5G5RovJM73+zgxIJ6jKFCt8RDb00JfZ4nyuBJAmtWYZ0NefJAzjxOQUucfSbfF0z9pKwmRnUiYTQyMnjN;20:YOQjnsp4zi+NWbl/wXC8Y0yVwck9yQyIi5VizzWtZhzb6xsvtXE0puLo+ZpEc9BUeptCXsfu0+dU95T+GtH8LJw0u1PS0kEQzCtjq1SdM6ohH4i/7nrO7C6SJtmGgpptPY2SKx8SKJEEV09ORNpkQ8jUeq//rwZfXXtG+yaeVu3F1rXDFiP4fvUZTgkK53t21jHWxeJEz+yPEnHB3gpFs2wipkPoi68mfGPBwZ9bmpgWkOMiTrVHq55Z3yFZr5ee
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 13:17:38.3695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bfd7b3-02aa-4195-ee7b-08d59bc0c543
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0701
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches create a top-level function to create a debugfs directory
for the IOMMU, under which drivers may create and populate-specific
directories for their device internals.

Patch 1: general IOMMU enablement
Patch 2: basic AMD enablement to demonstrate linkage with patch 1

Introduce a new Kconfig parameter IOMMU_DEBUG to globally allow or
disallow debugfs code to be built.

Changes since v2:
 - Move a declaration to outside an ifdef
 - Remove a spurious blank line

Changes since v1:
 - Remove debug cruft
 - Remove cruft produced by design change
 - Change the lock to a mutex
 - Coding style fixes
 - Add a comment to document the framework

---

Gary R Hook (2):
      iommu - Enable debugfs exposure of the IOMMU
      iommu/amd: Add basic debugfs infrastructure for AMD IOMMU


 drivers/iommu/Kconfig             |   11 +++++++
 drivers/iommu/Makefile            |    2 +
 drivers/iommu/amd_iommu_debugfs.c |   45 +++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 +++-
 drivers/iommu/amd_iommu_proto.h   |    6 ++++
 drivers/iommu/amd_iommu_types.h   |    3 ++
 drivers/iommu/iommu-debugfs.c     |   58 +++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h             |    4 +++
 8 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
Effective helpfulness requires thoroughness
