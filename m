Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeA3RdB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:33:01 -0500
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:33552
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752518AbeA3Rc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:32:57 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, Len Brown <len.brown@intel.com>,
        Kyle Huey <me@kylehuey.com>, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v4 0/3] Support Perf Extensions on AMD KVM guests
Date: Tue, 30 Jan 2018 11:32:40 -0600
Message-Id: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR10CA0015.namprd10.prod.outlook.com (10.172.33.25) To
 BN6PR12MB1362.namprd12.prod.outlook.com (10.168.228.20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fe7fe15-07b9-441b-9688-08d568077e12
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1362;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;3:zpzRO3kkjsmZsGFUzpTvxPzzD6XvPHT8F/7JFe4GUO8iOldSq2DIMH6tCqFNWOeilBpFmMHJWMdZFFQ5727W082c/cVuC7P0Vwf3BtI+Fd5wfUHHE63HBu3niegaQvBzHTaGKLvFbk+AJc8KKcvzoAr6BTXcphoWwV93i9e2ZcJOVyKMbF3LAwB+try+9d10ClfL6WHmsDEs8qyzvaJgjaPsIRJZJrTSzSoRKUCfQWbn+eyFxlNQCRTZ+aUnWJuE;25:o5b1wGoJENSyez4H1UM3N+iaUoS36BHszZrpGRD3Hio+UliRJ2L7QWz7B8fPhJV1sFGZNlWLfc/UINesik9FdypB1EsJ9xoWzFFemvmE3qQ/N1vtBRPoLbNVr0ws+5SbDJuCe9k7XCEJxCpJlvwTZdbhAkxs3QFhE2RU4cREvDnWTG/eZf3Spzs4O3WEWse1qGJWsXJen6sd9rhl8w5jfHF/8bPPa1++1TJxCqd6cHDMw+TxaY430UzCjelmyoOp8XmVTW5sSszne32zDueDMGVoQuXnPrEogsAZFk2F1yjRdhsR24zZ931RPBDJAW4QDodUPsNou/JPY3TYhA27xQ==;31:4AW1/klQBaFzOryZr+4IJt0FdGpC/Gvz2jfKy+isl0p+RW7IOPDtNai7+RfwUYWXFs5eZ+1RXKOv3vpEhcfaEip6a6NX5T1U1xkMloU0QNSBeaFdGO3+o+qC3sJ6pflgmg6kCxxwfD3v8n1jWFTHgLmOtzrvMVMzMMFt8jWCc82F4ZoxUyTyZA8T7vSnEuNPvIyvtWsafc9ftWFV8rI1nSvO52sv1tvJWffToM6u9aA=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;20:bd9voF+6h0KWWl3wFOY+WF7yk/SgCoTC0nFMJPceGUWbdoTMkSZofal6Mnsz+ZLZYRUlNqBSqM5eQbpAUfzMfLVktl+RSALuRAMDI6ccjX0oU9PL4F40iDy7kERoNdMsdJ00wodc1MvdxmmGIQ/Pc48DnotL2kh2vWpJwV1hHdqgvZXCGt7VQ6bVpZ8NFhY90Kqe7mXzOZqc8lTcazvJ4hjfeN13YXp6l8x2QtFhgNxC5FRTn6MWe/aLk2ZPom0YXv8Icz38AkNP8lgIIARX9/dgF5he8OiGwucJeyT6ET7X8FpC8mnH6EPY2oYsnr/l4dgJOKzawQ/YKCS+IS6795IjvmsFjhr5zteaxAwMZOMPi//DR6RQFtapvZt+vpyoBAmeF4MXDXDcN70vxmb0qfeR6nESdWDqndE3IDQaxnSJuiWn63t+xWa3gq8DZBhRQ7iaD7vyNPofHj33IDxcAMwaYTHrmfLReCxrCeCTApMFwYXCKndExGJo03AMpj9o;4:8vF4dF6SZ+i7J7jjkTY67s2lX4B+GhqVV/ZPRWh57/gnwjXS9tGwmtnqxBo9o7AN2YLxdjPqfYEaOnlj3Dx22ViXAo0RkZiNE67FIRi4wKvO9CQSClA9AY7qFPAfyqMIK/N//NT2feX8IzrV/MwAWrTj5l8waq4nBGR7xj7q/94Ybf0llzafaD0zezdxozVPaMpn/2mRRkOLuRyE3SpSYoFyYdM2mW3uJiwiO5JrataraxRJ9nsxaLxRkLmnuhtUGMOzGdThGa0m+yIQXwuh/Q==
X-Microsoft-Antispam-PRVS: <BN6PR12MB13629988CF03BC8434B56301E7E40@BN6PR12MB1362.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1362;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1362;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(6116002)(47776003)(53936002)(66066001)(316002)(2906002)(7416002)(54906003)(386003)(72206003)(52116002)(478600001)(16586007)(25786009)(305945005)(5660300001)(26005)(3846002)(7696005)(6666003)(7736002)(97736004)(4326008)(51416003)(53416004)(36756003)(6486002)(68736007)(50226002)(106356001)(8676002)(8936002)(81156014)(186003)(81166006)(105586002)(48376002)(16526019)(86362001)(50466002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1362;H:gi-joe.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1362;23:ror+HvQLI38rJ7rbKEMMIUj1JhXD4wlmI0DSJEIHg?=
 =?us-ascii?Q?iZdq83G7sXAhRdmZnRcBZWlOix4nEAWdhX+j0r8CVA4WmOQbXYrbBJZVrx4v?=
 =?us-ascii?Q?kk+dBsLSK3hUpG2VNDLl7JmJWZp8zF9BIatTOT1HSJmFJELa/CHhMrcjlwze?=
 =?us-ascii?Q?TLGnsjHOrBSfRO5GXxTuwc7O2fAfe4L9IAxfBW2DcohY82RXTxkyOiwiu6wS?=
 =?us-ascii?Q?ADcC84y6cnT0+2foXJvpFZAN5zm+nx0+9a6rUOSW0aMTj5uK7v3q235foaMO?=
 =?us-ascii?Q?RUrgphQdBwivOF4aKFwzENKcDNTb3+B3nzT8bn93Nyd8SfuC1E8zQmV+jUyc?=
 =?us-ascii?Q?8k7WEhaGvnYJ2EjtUe8gmfiBLneyZNGUhXIgX6Vd3rs+QhTIKJ3RHDxanYh/?=
 =?us-ascii?Q?Yt1cI0SmH9+CCzwxbxOhjJz0Jx+DPdxaV+luhgwrRrZylvsQBjESBl3yns+5?=
 =?us-ascii?Q?PO6qumhHIOvbD95r75lPFdiwfrLSCRYTxnRPDCjckvtgm2zPd+eUFyjBQTMo?=
 =?us-ascii?Q?B75ErwqKRyYC7/8mdd1yN58S0OIeeJehmnfCfsJYP3wgIap2qc6lIEpzz75Q?=
 =?us-ascii?Q?QexsCPq5STndbyfA258iYwnp1BNJxgFS0fDN8zjDM77QHbVFCe0ZEs8+JgYs?=
 =?us-ascii?Q?OeCEr3QOWuh5Ip8pF95W4wqeYEegZXEbRZ+gEMByIBnThoLozasUvH3dZrln?=
 =?us-ascii?Q?RAbvQoexWL4FaiPYbRhVWvZxHWtMNQsti/XCxPY7sIHuUGvj7KUhgCNMTH8y?=
 =?us-ascii?Q?kXDgi13BuN9UGKN6f/zvI7D9kIVBBaL0kvR0ZCpGoYE/ZcsDZgW8gT6v5t+L?=
 =?us-ascii?Q?c/1mFVlAsKQLpM6kfqx3/LU9yn7uerwwFUiT0s+nP3v+83Em/alywaADE6Pc?=
 =?us-ascii?Q?ofrrjiSRDS4DNgfYM0NdHgzBqjGTEWZx/6yOuIetgDsVYaE7OcKX/Vj+QIx4?=
 =?us-ascii?Q?kfAd2fNACZfALUgoeOd7Xwsmy43pDIRV9jJ/ZLOyjjyxzrNUiDnewlUmi/4t?=
 =?us-ascii?Q?IIU3isIc7p92/eNMdCNSZlkKzYQS2aWHRiCtp7R+rbhcr5YyXKCngp+PUF54?=
 =?us-ascii?Q?FzgnIb4IIiMvMQuPMzjqAnX8lWeKoNGRS0qNrYfj0oJLKgrrhT1dRKaaBvDH?=
 =?us-ascii?Q?cp4QBIHuew=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;6:4KdVP6dTBzY/lzQSIK0tq/tTysQQ5Oz2oBw0voVVsmulEJCEFSdF9nk/CmBl0XBHqykAFaVYmrFMgvWpMjQMBOAaM/MjhNV5X88bLHjWnVuqbYdASPTZsbJZKlPBE9cR+wj4SQj5Ob6ZVVEGRY4/1YoI0wDZ4XeflHR79UwD+BiWcGyrfAo2BcwGJXFvYs3fqdZjCzv4GXYCtwj9CtPRwFoW/HvuYg6Ht/tDNjzbaJ/WZyVHeKp4KH/sIWMsyLbkmkRMJZ7UAOestOud0CamK/9EObEie4uOnORtah9TObmcmcocADMic1ktZ40F/R3NRdzDDgqLVzj/XjcAdrKRGaJE5F41jAfke2Vbht5odkY=;5:GD8s8UMxcHLJMsn3xPlDOVrWyTwH512ZeCc772f3THq9NyNT/Hf2BMUC6+OS6Ol3boz9swG3idb1TcmVFghYxDgmdZRDgIbLQJxZCSbHlOmIdo3znAIk6I89QDHZbcqWoLkxJYzXjUpAEGmbQTOASslSC24J/4GHHJnqTlVsK28=;24:IiSPqnsof58oI4MWRyjsLrvWS+E6sp5RmpsyjBkhLOULVAJoA4DAaYkWKZsf+YlmSN5vCYPa/yFLhdBqra//5KaVojlG9G6HF5YGTX2uwgk=;7:vm6Miwen9z0HuJdRcbuurkGvYI6ZEm1wVx4ImW0/bSHei5Ov8Rc6WqTvQRLJ4hOzmhxzshrzWbLuidxrFPFLBPfE5lNTrQZ77hedqX72oNjfIUlVLRMtLwyc2OxkXRfNAfncj3uGBcKJR/T6noP9/nP81ECPS4n5BcsxSrmLipzs5uBBY7s35J31+Ng/h4G1FmI3XOMN5Cl1lu0ShbpbiCJ1Ob6p4T0RrMDpIpAnBIufwOm9lWmFyQINR7x2S0Hl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;20:DIfR3IiKKjWcV0rOSdAEBgB6Y5TKu4dr1A0R6A9iJQvAsPwTzFc1Uz0RMTkqtHryKdge2oDFFZwsKGJ2bPTh8QY9efyIDq7aR+n4ydk/jLP/adgaNks6rAwY4lc6855I5+IP7hNzw50ztL8STy1ab/N2lNyzEMFSdj0Dtpk0zi2PsoQ8ZqJ9aAI3o0Qhve1/skpwc/ZBhsZUOVKo2w5GwIKDfDcflWe3ydZ1nEJDL3bsrEvK6bXNzCNdWllYIbzG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 17:32:52.0125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe7fe15-07b9-441b-9688-08d568077e12
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Perf Extension on AMD KVM guests.

When perf runs on a guest with family = 15h || 17h, the MSRs that are
accessed, when the Perf Extension flag is made available, differ from
the existing K7 MSRs. The accesses are to the AMD Core Performance
Extension counters which provide 2 extra counters and new MSRs for both
the event select and counter registers.

Since the new event select and counter MSRs are interleaved and K7 MSRs
are contiguous, the logic to map them to the gp_counters[] is changed.

This patchset has been tested with Family 17h and Opteron G1 guests.

v1->v2:
* Rearranged MSR #defines based on Boris's suggestion.

v2->v3:
* Changed the logic of mapping MSR to gp_counters[] index based on
  Boris's feedback.
* Removed use of family checks based on Radim's feedback.
* Removed KVM bugfix patch since it is already applied.

v3->v4:
* Rebased to latest KVM tree.

Janakarajan Natarajan (3):
  x86/msr: Add AMD Core Perf Extension MSRs
  x86/kvm: Add support for AMD Core Perf Extension in guest
  x86/kvm: Expose AMD Core Perf Extension flag to guests

 arch/x86/include/asm/msr-index.h |  14 ++++
 arch/x86/kvm/cpuid.c             |   8 ++-
 arch/x86/kvm/pmu_amd.c           | 140 +++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/x86.c               |   1 +
 4 files changed, 148 insertions(+), 15 deletions(-)

-- 
2.7.4
