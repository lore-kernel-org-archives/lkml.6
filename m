Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeBHW6p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:58:45 -0500
Received: from mail-by2nam01on0080.outbound.protection.outlook.com ([104.47.34.80]:21276
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751424AbeBHW6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:58:43 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH 0/2] KVM: MSR-based features
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Thu, 08 Feb 2018 16:58:33 -0600
Message-ID: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CO1PR15CA0091.namprd15.prod.outlook.com (10.175.177.11) To
 BN6PR12MB1139.namprd12.prod.outlook.com (10.168.226.141)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd6b2736-75c2-4e91-51cd-08d56f477ef4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1139;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1139;3:8ZP/ZLn6eAjzkB3MKwaGtaRtjqpO2OG+3D1iGcfQEkYhXBvSwfoayYZcBZ3FJWCHXcd6KH15lncOLRyCV4wp6JobV7nS8FOoBAGoPaCcyLb181YCh+2gXIF2WQhM13hskiXKTPBEM0m/6AHkxQqRPEJNAynoFmxgEY4PCpbR5DoklMwCoBx/8/EyLQhHCA6HYEUBrG0uRalhuv+X0L+UaGDfZPBZcl5EWsTvA5AjMUCVpgs7HiNiCam/Ld8Nst4t;25:RQT3xe/gXk8UKHSEW+hCTT5kF16Sau9hvmtpwGQXVpwMzapBisG6/HSK9UZXpGnZDmLctGcdUxbG2EF2IDRiNyGj7hOYympWivwH/8M7cap6z/TFjAINwGwBMI1H8Pe/0Ocrf7kFH7FW8BiubUdm6pXdj9qQjea9OhypdQ8Fxu2OljIlU9zjxCAbUfpB9eoP2DZPFa0DKUYvm1TSObyBekZGbOJW8Hbi9CVzzZ9fBrHb4+zUr1KT2HJc08E+6SqesMiwm1A1Fz6qq6E/ZMQ7mnUaAXAMoRjj5BwDFa6jkXVu37TzFTs5na8UK4T4IrMa8u5WJV1N355UsP0Lky+frg==;31:hecsJvJMrgB5jahIAUmnxgeuzbM0Qed6Mmtdu7BDaijEfRNsfN9shHqPLc68uycqdG1nbvP37wWlR4f6Ar+3WtKtviMNoq2ABcuXbiZ6zinzhxfmHUovDWryNGmU2NLThRyU4dlWFEEjqHTJABpYK3lga7ktfYnul87nPcL4k6R1Z+UKhv2k9x1YefBA+tOTn3ZvOFDIHmpReaTg79ygNIOhdS+geRVmFMdV8EnlW2o=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1139:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1139;20:Pwieqq48rZTI09GbKB8XpTs1+sa8VZhHGhWUUL7TAiFUOqAppuH03cZ3bkDylSBhLUE5z/o2/xiOB9BNGB/kIdcxfLm1njzD51SuDacEGFANLeu7TsJWZbm1oFFhLZLjK2Z5KQVImyaTQBrQu/HfKkCb0qgeBE/uIFrn35kYYpeaUD3gXM/ZyhuNwKjHiawTvzgFMMX4r2Vu0Etgo/fFCayGZxxUPCqk4H17xpu4GSn30mMCtXnvtx6AOpatzz9UYnLVVOGc8ZxItI7zgPuqDcKrcY0EZ7oeShcbqi47zF2Syv7oKqZWIqnHKu181XrmYHwfaJ3nhph5N1a2riwRjIQOimPy/4g7VAp5Zn8mcQS0NuCxwtL8T+c8YyWmwST/zhCBSnVpOmX2hYTHgUmGNNdXux6gcKW1i4LKC1IBr0a4ysv1fxYrKFVT73ZLsZr6y6tFGxnF5ZJNDqNYKQf5IpWxO3wJ1Lprt6dnrWSEafYrhwwPneIM8fqfLIUeJXM2;4:eKwyajrAtQ1zdHHhO9+xcv0DqsfoGFbNgJ003oc0OBC/SuIJtZEjhIKZLxKM7sdfX1nc/yvc0ODp98CSmMQu5XIiFn1X02kjiS+EyYf+E3pcqvcqa7KJJHBLLL5xYa1rf2jsHZblZuEBYfYNVptW7wVw4eOzI24ZVi1jRBwFDlxOkgaVvTmfFq3/FpxpXtB1Y1p+915UML6SWcdlNUsMOuW2qv6hanR04gnRspOSe4Hpu1RqI3xY6X2thW4hJNPoa/TTxQacPhH6DukF78OhVg==
X-Microsoft-Antispam-PRVS: <BN6PR12MB11397AD1CDEC3538798681EAECF30@BN6PR12MB1139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1139;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1139;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(39860400002)(376002)(346002)(189003)(199004)(316002)(5660300001)(53416004)(2906002)(72206003)(66066001)(105586002)(230700001)(8936002)(68736007)(81166006)(478600001)(386003)(8676002)(83506002)(6506007)(81156014)(6666003)(69596002)(50466002)(16526019)(4326008)(26005)(53936002)(52116002)(23676004)(186003)(2486003)(106356001)(25786009)(47776003)(7696005)(97746001)(7736002)(55016002)(58126008)(97736004)(9686003)(54906003)(3846002)(6116002)(1076002)(86362001)(305945005)(103116003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1139;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMTM5OzIzOklMZmlsNFZ6NENwUVVXSXNLT3RNRDJPcEg2?=
 =?utf-8?B?S2x5Mk9HOS8wOW9CMG5UdHlaSmxDditBWnpjR0wvdzNDY3J0dVgzVm9rWWo5?=
 =?utf-8?B?bnprdS9vTkI3R3Rib0RMcFNBWGZ4TUlLK29kdkNSTkxOMTRFYU5SNDJJUU5N?=
 =?utf-8?B?b1J6SFlIazdycExwNzNBbkdzRCt3MWdUM3ZKMWF3YW1CQ05XaFQ5WW01RUY4?=
 =?utf-8?B?RmNtUXpjd3JBNmRmMXFueHFRQnJzS0hFM3U1a3krTHNFY0p0T3JJRmhTdzhv?=
 =?utf-8?B?R1RpNkhJbTZVNnhlQU9lUWVFWnVFQnF6Tm5Nc0Nha0YxT2xRR2p6T2FhNEU3?=
 =?utf-8?B?Zzc1azN6TjNHQjE5Z1Y5SGx0NThLK2E1TVNQY2lQVTV2aTJoRWExT1lUbG4y?=
 =?utf-8?B?cVZmeWhNZDJnWEJTL1JDbENDdWw4czFQcEpNM1Z0REVoR3g2RDVyVTBOZzJv?=
 =?utf-8?B?VVpsbGRiT0hCY3Jwc25WVzgrbkIvN3VQNnZPUVcwQWZ6UkM4SEFTUnJEWHhJ?=
 =?utf-8?B?cityMEsyb3NjQXF0TkxpT0VnTlFQYjk4VGlSY3YwZkE0dzJna1Q2Vkw3clNR?=
 =?utf-8?B?Z2ZkaEcwZTBHZEdyZkRoWVJKYzdsUlNIUVhibWVHZVhad2NHbXA1czJMbVhU?=
 =?utf-8?B?RmVsVC9UUlQ2OVJIK3lnVW12OUMrTDFBT3VKdmVPcmdhTU03YksxZCtCTTJQ?=
 =?utf-8?B?T2J6aGprYVhTdzlvbUwrb1RsNVJoN3p6SUFuVE13M0FnNnIxa0ZpZGJ0c2ZT?=
 =?utf-8?B?RlR5K2NsSVNsaVRBUUtPRWFWM3oxY1Z5YUtlajZhWS9wL0VuL1g4S0lmVVZu?=
 =?utf-8?B?SVRxYzdDdnVDbjVTYjEzekRjWitpWmVkR0t2WC9nQnZwN3FkcENyUWt6dkh4?=
 =?utf-8?B?b3cwQWxmVjJtdlJLajV3V1ZZU3lkWWVPVFV3R0sweldsaU1FM2lGOFRLQWc2?=
 =?utf-8?B?a3ZTQW9ZNzJheVJlUHlFTENGY3BheTRZSWIrb3pVTk5ScEdOZkxmTEkwZk5Y?=
 =?utf-8?B?V0JyZGVERkk2TGVGV1FtZTdSY1h3UUdtL2lVcmk1OCtiZXo5QzVyZVcxU29S?=
 =?utf-8?B?aCtaTzFUTHkvN1h0dTBqdUw1bGR6elFETW1SV0I4SHZDQ3VGdXZNK3llWXQz?=
 =?utf-8?B?SFU0Rk1Cdnlpc2FsaDhmR1lEaVRlNEY4Y0VESFpnMkJraUpsRmZLeTNmUWtR?=
 =?utf-8?B?K3FhazlVSVUzTGU4QzJNWk95dkRPaXB6RUhGZXVIUE82dzZWNHVtL0hVU2Vw?=
 =?utf-8?B?RG9nRm1GeUkzRFBxRWgxN0RwZUZJTjdCaDhRb1NRck1xaU0xR2VZc25kNkJK?=
 =?utf-8?B?cmpyQi9nYUd6VjBGanl4Z0VVcE44UFo0RE5BM3BUWGZHb3RIbDMwU2prM0RT?=
 =?utf-8?B?OVNDRGNIeDVxSTNNMlAySlhQZkNOaDErdUFFTG5CbUlFZWZmOEdjN3BZdVda?=
 =?utf-8?B?bEwwWHBQVmJJOVQyRTI0MHhVY3ZQMitHOTVFTkt5NVl4WU9KWi9tdm94ZDdq?=
 =?utf-8?B?VHZkMHdDT2FQMmFXL3hmUi9LSDdPZUhBeFo4QnRuTGl0TVhNRWJ1aWxvQ0ly?=
 =?utf-8?B?QW9xdmUrSjl4OVpTR2Vnd1lwZm9waHhGRDNTZEcvdHpDTGZpWDFKUWtmYTls?=
 =?utf-8?B?aUNUUE0wdG13RWZSV1d2SlN6SHRRcXFPaDBhVmJXRno1MFIrSVkxVjdRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1139;6:qh0FOkP/0/gBx7Xw2kGO2coTN8uLSv+s8vAHkMUZwZmJ9LyNsXHPiXv1ay7UT4iZVxn6pM8Xf91DIxzFlFnFbgWxS9KTzRFIVKI1U3owfjasGtDo05zFvBuXVrnr5vlCrWzvIZ3t7SkcAGtqYzGMXO1ju1oqa5pVtTP06tdvtY81yNxQ0vB9VPq+Mt+jHRMTuw0bd17yHyufgBOn0yiI6hSlYRVypPssPvgJfq6h/NX3PXFygIMyk17NV8oCK662JXrOT3JnSdcqbwh48D+ZqVoRaaZZ7++4EV+ZO/2HO+gnAmTCPYx9cLsJXdStZ1XeGS1uegG7dSfseO8XgSrmbMSLZIPGi2OxuFKMojd0z+w=;5:L7OZWU7EAKDmTp+/Qz1uovkHhiqGTaISrjFWy3Nda4opmaQP5ffFLckkUvcNH2JD3g/NZMsXgNulms7zNZ3Uk/FGn7h2A2EfxFHttVUjBvpG3MskaPXIPIbQ8Z8mwTyhwyoSVAi4LOoIFFXXmld+adRHNcTSHU0tEs8l40m/w0s=;24:23BkbrEFV1nwQUMzqeaxBCsI+NjhxT/HAaq4ooIRFfEV8mD/6xUFSab8fw9KRsL0i1HEendHGpb7x9Tz297wgSAMAKa8XsDBolvV+fIpX34=;7:oDs5sxNonE5yHOgl88QiP4g8BQgcIH6YmSKMVmQ1YgBFaHPM3+eaGrfVpKLIFNotMm/WkNmrZT8P4xcdxRcjci3aAJiwKo4fHzUDQkdvQqWB9mPXMapnAXpYLsQv2Sl2s7sYh708Oz/v58BLf9kymUFKBtgkE5URdbhUQu9npKNthsmgu2P5TJKdnRzm+vI/RARbIZvkzRCXiu+8qAjGyWsXryi6fb222fuSDSPOWnCPZWvtoaJg3O2zD5B/awps
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1139;20:aMN8IMsVfZoSHOk0lqFuuYz+WX1muDaMEo6tzYI0U6iZgCB4AVfMpiZfAoyahB/nujB2NN6ycQA/Mkv8eVdyh0WZFVmNAM/JwSyMzyAMYfeltvJ0lQkBNse5OgxmDhKpC508cgs4HZXhZAC2Juw5VQWbuW2DMLMY4soGOSTZyJVUVuK+2bic57jf1nsiM1hrdMRaBe8lJpmRaz6h7Xs3cps/+Sww3CdwojV3KVsiRMJjhfFmfjaTLmdspQmX3Eah
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 22:58:39.1564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6b2736-75c2-4e91-51cd-08d56f477ef4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series implements support within KVM for MSR-based features.
The first patch creates the MSR-based feature framework used to initialize
and retrieve the MSR-based features.  The second patch adds support that
will allow a guest to determine if the LFENCE instruction is serializing
on AMD processors.

This series is based on the next branch.

---

Tom Lendacky (2):
      KVM: x86: Add a framework for supporting MSR-based features
      KVM: SVM: Add MSR feature support for serializing LFENCE


 arch/x86/include/asm/kvm_host.h |    1 
 arch/x86/kvm/svm.c              |   16 +++++
 arch/x86/kvm/x86.c              |  114 ++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h        |    1 
 4 files changed, 130 insertions(+), 2 deletions(-)

-- 
Tom Lendacky
