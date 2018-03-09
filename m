Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeCIAuq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:50:46 -0500
Received: from mail-by2nam01on0043.outbound.protection.outlook.com ([104.47.34.43]:4096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750885AbeCIAuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:50:44 -0500
Subject: [PATCH v2 0/5] Add debugfs info for the AMD IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 18:50:37 -0600
Message-ID: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:404:8e::12) To SN1PR12MB0701.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7fa9241-500c-4516-c0be-08d58557c8c7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0701;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;3:C/1ztTa9k+/ghOdaGcF0BgzVIHTffXk/9VeLyj66ilIxobKGRJp9nTWPG64Q7eNWTVPsLibYgtOyiTBM0pt2SiHtKoizby59ndMQ/w7V74gfZhPBJGOn2AemW9uqyjx8HNmPI7ovv/Z3e3JBwurOpHNFsdKEXoXlbOq42xTI9oTMlt+tFqSYabEQDDwaW5RbRy3VENnjGZMMdrrudfmAcdsyZugxF/EIt9g0cNY1PUrXTlE2t6pryyPvR5+mQc5c;25:+YVyfhHpl9WMiJOq+DwPtFWwUiVMHTQ5FHlqjbEIhYIDqs0h7yNIhKOBCCq2mLlvgr34XHTTFH7lQG9AMh1YK1Gbcq9c5o/FKm4htPdls1aujOCoIOr1aoi8kc+3NG+T8i2j+kqwiLgLdKrmlRBQZk3tPPLSUnp9+rJ3eoBVt6EAv6ZhsyDsDl9LcwXkULJZ5sH/guISAYSWBiGLJr9Q8iduVN5fnHm7WbsjxgCV0MVSQtgw9TBWonyReCXU8fVz5MDiWxlSyI31JZcDVz5SaUDxdnNLSbmFco6KahnczLpfVCTg136WSZvRutxR+aEOdc9LXviRXAHbNvUy+2hARg==;31:koX61nmuDMJ24IdDmxhVXCqzoqudQB1bQJjl+2FSR/AtLUOz4scCq+4n9AuvVmPNgXNbL+t9p1weYRpvTe7tsRrSuVHtdWxgo/D5y3JUEwtd0BQ2SmPkMyxrsVr4IkE5QCLXNi5dWqRLyk7+ZwYch5TQzwPZVJ0yjZPKmNJ16nH7EjZEOSOst6/KG7Vz5UjHeVtwE4pik+A1Xwxu9Ut1bzpH54npVsnGQJZW2vCzy7I=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0701:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;20:zhbNXXqZvRTbeLyqxrsgcZDErpDWDFbtevbp4DKPdqEBHdP56ynqRL1yryjsM5txNAsDuu0iTJqVtUGSZS77dTuMdf2L5kc13eUFO3hx5DH9yxGpLujMiyJ+nsQ6vOLh1Srl+mG2Qip7lgSbEv0SpNZZuv+BRUjHWVF6KNT4oIIhxSg71Fvy4yiBb0TtmoTfkoAlrpCIt4isKQ1fJFUNkeTnbETLKHpVb4ss1v27x4mmukAJ0BgEWWmQtx0BewlmHeOxppXxFiIZZgjzqkgxte5rBhelvgb8dFgBFPTindeLZcTIZPE7ld+I1nJwUeHgktk/1ndoMRfzuynm4efEaT5axP9rgwRlrF45JOVRVAKLsNzRP00K9eO8A/aApoP7ErqkorfvJmsXlp/Gl3FF4CUYrcVn/oWqUDMntfY8roQeWbfwVimLN9koKOGyvf6D8z0pYdKemr+9/at5u3x1831ZTVt143oo9TGErn2jUvA54zZQvrwVI1pAziODZiQH;4:KMlYSBjdzAab7qvtL7eWGa0mw4fUNBqoVQjYbjZ686KkqQtWs/Z81hkmJRaIO7bPvwkeNLJTJWtN5XY5xMeZ+pL6/Dhwr9YRpkf4Okqinffe8BPkArsw2eFUJ3rGDk8Bj01bFigHOVaOPuqIj/Fgch9pKXcyMgAtVZU+PjjqjEI0ycB9S8qudQc2X7cDZvePI09hZWaCMr1af1jZRr5mYQnMIh8fhJWQR15tpak96Rtcj90MwORKlkeoJdLhzxZaj+IiqXrJXg/idj38WOElGEEjcEO5yJc3k6MHxpWUm7XCTTX5VnU6GYGHWdU77YAl
X-Microsoft-Antispam-PRVS: <SN1PR12MB070160A931A48F8F0391954FFDDE0@SN1PR12MB0701.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040521)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041309)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB0701;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0701;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(396003)(346002)(39860400002)(199004)(189003)(5660300001)(72206003)(55016002)(6916009)(53936002)(68736007)(86362001)(2486003)(58126008)(23676004)(230700001)(7696005)(52116002)(6666003)(3846002)(6116002)(316002)(7736002)(305945005)(26005)(386003)(66066001)(103116003)(105586002)(47776003)(478600001)(106356001)(2361001)(97736004)(8936002)(4326008)(2351001)(2906002)(53416004)(81166006)(25786009)(81156014)(16526019)(50466002)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0701;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAxOzIzOkFmMzZVQWNRTWhKdHNtQlZvaUJOcDVnY1d2?=
 =?utf-8?B?YXU4ZHBkcXhPVU9TOEFvQmhxbm9ZUE9BV29GNjFEakl4Wi9LYVBlQ0Uzei9E?=
 =?utf-8?B?bXVndDFmcTlPdGlvbUpmeWRIY1NDZ1FzWnhIME94QnNRM01KM1NTMmFqNnlu?=
 =?utf-8?B?VklZa1ZmR3UzMEdieVhDb05lT0NEMXF3bThacGZSMGtOMk1BQzZtZU1nQ3lU?=
 =?utf-8?B?T1UycjM4RTAvN1VCTE1zK2xtcXBYcTU1RVQ5Zk5vYkZvcURtR0J0N3hwbEdx?=
 =?utf-8?B?Zk93NUtSLzYxWjYremtOa25oWCswOXE0S3dyaWNIRk83TTVYVDNuMGRWR2xq?=
 =?utf-8?B?cEhicHUvUWxzRCtSMFhXUDZzWVdpemlpb0JER2k1NCtRTG1jWnFVRlZabW9q?=
 =?utf-8?B?L2ZScTV3elJidXZNK2I5eWM2eVhXWUxiWHhKSDk0dDU4YnV3VWVDWTZTNTFM?=
 =?utf-8?B?VVRXRksrN1RLWlpmRnZtb0xSMm5aNkhHczVjTXJDRWZ2N2Z4QnFyV2ZjbW5s?=
 =?utf-8?B?SU5ac2Q0UVN3TE1uZjJ0VFdjdW93K3ZsU3gyRWVjejhLQUdYZ3BGdytQM282?=
 =?utf-8?B?VTJyYmFVRVA1WGRmaTNsbXdNTTByV2FqR3cwRW16OFhSNDYvQWJXVWF6ajlK?=
 =?utf-8?B?WTZ4aS8xV0JoWWVDbUxOMkVGQXZJSjNCeklma3pNSDQ1Wmk1cTllRzRxMmM5?=
 =?utf-8?B?NjZBNVFJbk1FYWVjYzBjdFphb3ZZbWNEZEI4QjhSeHZFZm9jb0pFTjRGTGdq?=
 =?utf-8?B?WWxycTEzRnNXYmdQUThhcWV2VUp2MG1EM2pqdWRRQm0zaURYMHRhTTRwMnpL?=
 =?utf-8?B?elVKTGNTMkRHSkRTN1R6aHVZaGw5TWpSVGdZNmV0QllwMFNGaUk1eWU5cjZV?=
 =?utf-8?B?a1VzR3VWVmQyZXJTcEtHelhWaHNkZC82MFBaemNmSCtlVkowYmpvYUQ3T3VN?=
 =?utf-8?B?WVdrdjVEZzJhNHZ2d2U3bTFvZnFaZmN6WGJ5TjViSGdxSWRyUTZleXY2VGt0?=
 =?utf-8?B?cnoyblZaK0pJNzRJSU83ZXNrb3BIWGpnSzUxa0YvR2FmeGVOTjQrYUZUWklM?=
 =?utf-8?B?Z08rYUhUcE85MDc4WTEyb1lwOUZCNjhFNXppdXdMYVZQd0NLakRTbFpIYTZG?=
 =?utf-8?B?WldKa3VVZEhsbGpKQnE1T0pUbVlqWmlublJvYzY0SjhxVzFGSW1Nd0s1bFpR?=
 =?utf-8?B?N0ZydGxsZkozODFNVldoblZaaTJnWk80NTNXRnFicUlUUXVRSFMzQlRob3dG?=
 =?utf-8?B?MlFTanZyTmtXME1jbXBla041ZThlMXBpSmVxbnVoQXFXUjY2OFNwMnhBQ2ln?=
 =?utf-8?B?eTRpdzI1VW1BVHRMWkIvOFo2d3BrbTdPSTlGTWZDZ3Fudmk4T2NrNk5MQ0hi?=
 =?utf-8?B?WjlEcDF2YW5zcEVHM0JSZXllSEZpVm54TnM5bUgrSndlWkp3OUpqekF1d3lE?=
 =?utf-8?B?cVM5WldQbHlvOWpBQzlid05GUThXby9CSTFZWkRndGZ4cS80RU5jVlZlLy9V?=
 =?utf-8?Q?iQWSkbJ7pUcXGQ8pYvsCwIMxI=3D?=
X-Microsoft-Antispam-Message-Info: Hz6+5NY6ctzihr0edxXgjFBsLoMIkilR/dXg9VZcYA7TUwXlbTXuwUjh9vdZe9Jda9FyOaE/mYVq/eHmzSFVQaztcMDvhnnbrfepkgWqNPbrvyf0g/pP+hvJztpdG27KjxkSP67fNPmAlT/RQ2g6HJRAMJaSR2YQxwbWBFIsOAPCFuHPuArm6qQld8B2artR
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;6:0dKI9Xkku0HzTaSvMerWQQre/EBeUU3ecIu6M0dwHd3Yb7X+kT1UVdPIOv7O1yAHtnkhA5AAtLSe48HMGVDjK3zrPODjzASQQ5KQV3yFPxE3tgjur5ZLi2QduC8P4t7FoXb050PMcREGCg64SJ+3B5eHjppF30taUoL/4SNeNP1sctDYvavJdrYDJQ9p6o+JoZiO+m95gskETR2XwocdVre7BltvIvXUBC6Lm2Gp1PD2ff/fniIdivoqRZhFBZD3raJR/RhhzsL0/cjMgR+qMTyJD2oQ8/aP0smmlnycCd4ZmCzkRpfS01XxAVfKTth10gjuTNvmAxOLXoq4K7Y4GHVx8qx5dUqKg9e1m0FeVBY=;5:U1c0YYeNLvBevgouwjo201jUx64tBEei05EDkWqs4VoEbDW5yMTJoPPFZPt7ZANgfuu1NEXstOUsG2qcyBfsh9He48+HEemRWZ75aq1fNillQbOPNRjdkCKkjPrR6bHR6aKYW8hBzp8Lp9XY2AWYwFxCs4eeGULdajP4YqA+ZV4=;24:eJpb8Jy1clQ1uKYO4MAf+4zXYChTPZHDEonZ/9O/wCvvlPeqYdVlp4W6TqBn/xr0yU/BEWZE1hlM0cCbqQu2ehMpKKdtJbBNoCWvz/aSUuU=;7:fx0f2XGuQ8t4W28dV0djYHjpHkO2tSJOMYMMJVbHnHZwHeVcm82VSbmqxbMGJNsT6hO1WGCQT3lRScShX09817UpSVp8/fTCVq3PywHzdllMes5o6Y1L7g/6ElwvxvuJ52XGmL/0EuiT40cB58PiFguZ0Fg5kPdyg3VSYZPi138NEDVR1hM2PQ+51QIcg6MWzpIIhiD36oP+3liLOEzzjaXHcXgeBKh45hTQyW2I9hF2frCnsurt08NU5TZsewno
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0701;20:SirSCrdGkFKiZ3tupop7sJyPHY4Ik6BxGa3qqaDow2ZWWdJTuAC14yzzW8SXzwPfcJUdMebGIONvDVNfVd0LMmjmq2Vv9EYW7FZGQmLTsiNfFrX5AnQeBVTtKStoIXk9c+WPwUBsZK53d91RZYG3Kc7bk/lBTFIq7YOwj3W9jiPjsZtlBj0tPvZI5xV6U9mocpwJCmrJQL2pj7fmSkirEWTvyQQIcpQcjDpgmOS6QbAm4cvcSMSntoqZtPPzBxvg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 00:50:41.4976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fa9241-500c-4516-c0be-08d58557c8c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0701
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series creates a debugfs directory for AMD IOMMUs,
constructs a framework for additional entries, an online README,
and a method for dumping device table entries. Data is reported
in a default concise mode, but a verbose mode is enabled via a
filesystem entry.

This is the first of three patch series that will expose a number
of IOMMU registers.

Changes since v1:
- Correctly use CONFIG_AMD_IOMMU_DEBUG in Makefile and header file

---

Gary R Hook (5):
      iommu/amd - Add debugfs support
      iommu/amd - Add a 'verbose' switch for IOMMU debugfs
      iommu/amd - Add a README variable for the IOMMU debugfs
      iommu/amd - Expose the active IOMMU device table entries
      iommu/amd - Add a debugfs entry to specify a IOMMU device table entry


 drivers/iommu/Kconfig             |    8 +
 drivers/iommu/Makefile            |    1 
 drivers/iommu/amd_iommu_debugfs.c |  310 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    7 +
 drivers/iommu/amd_iommu_proto.h   |    7 +
 drivers/iommu/amd_iommu_types.h   |    3 
 6 files changed, 334 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

--
