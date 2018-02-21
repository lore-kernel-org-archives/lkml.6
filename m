Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeBUTkj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:40:39 -0500
Received: from mail-dm3nam03on0047.outbound.protection.outlook.com ([104.47.41.47]:26031
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751699AbeBUTjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:39:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 0/2] KVM: MSR-based features
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Wed, 21 Feb 2018 13:39:41 -0600
Message-ID: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:3:ed::16) To MWHPR12MB1149.namprd12.prod.outlook.com
 (2603:10b6:300:e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d34a8e5-ed72-4595-9105-08d57962dcd6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1149;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;3:Z5MMrPOzRSGAYJ43EEayfQcahPCArJbLYEOmIjHi7OpMcSFg6s/hpS+bQRHe0nIfNVm1WB1Vj19Ub1xsZdkimZRh4md9qwFC0ekVRLokoWgOBrsmOYVSchvyD5GhXssAKjoYYo73DmClWTuiPEEKqOthyrcRdU6uME61eMlx0oSLzb5x9BA93+yJEX+9BYVXw5H0z81j3VBcLFIg8bYVCl//2mgpnssH2FfM1+h5EWxlmTYxVCJt7w3TX75WWSl7;25:wjiq26fgTcOQgU8hHzRYb0KZGOm2Y456aBb6LNOw+hbqtdtf8onfilZGT+sMpa4FzBxgVYVyOqzmCrnF7q1Hiw8MabjTcm204ZAO002PFcIC0mB/BCiHneRl75nXxwKoABSXqaDIzXs8aGO8KdfTjOO7s9xI0SzdSXBuvYgQYVqC8BJuLgSG0mKC4RDgRuKlMdye5WXsc9U6/GIH+o7KqGE7QRGme5voBtl+xk+a5POcoYCwkFvcEGEl/B3jdxyEiQZo0RBndQwk424K3LEorP3pblrmYqnMZazp8eXxe++kaoju69pLCl5sRjPO3K/ZZAeA5E3TA7FVWsOchrSw/g==;31:9qg5yoiruJO7n7dEoW10kwcqYXp1CIgpCPz+tofiRvPjfUV7CO9ArDICve9JF1p/5xSyyx3PkZYnx/VtV0L8qdzaK0v0kwTBMDJYskUnsMS3ezHKmeVAtUt56qeNOh5RFiKM5vhCYQ2jvePNQRgQVN04Lnh97NL8kQ7/u6lCTnclJ93m8w+9NGmz0Qu1njN4mKdkqPu+bQDOrukrS22wNyPAZrc6QAj3Z17hy+HZeLw=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1149:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:K8GZSsY6kYaTRFckPY4Rpe3C7xsk08po0d5Eh7gHRcDpVVavL5UuQr2VlWBu1EKB6D/ptmxbBp+/6ptjcm4H616ksAwn3IhXJolIq/DKa02b7vN2UNvKZHwCXwVKyWJWnRYVWSfqdAfTJNO/7V27PRp3RryPzuCQS8KLW+TsLabBhdlrS+P0FEL3uwJrizyCSzO988Jv5FFADwkjgkYb9vb6Imb+RX6KDdwn+MFOpQaig6rkO1r/tKrHF6p7VI5yE82mjSLBu533hU7Lv3uCJRl5+KO/4qFfIDziZH3jjAucvRfF2XVRWsPvTtU6pWcbOJv4h2NiFR8ehjlik/sAQoRR5ke+1zNs+0ACAPXsIvdKr2LWVkPhNyQP/G9lE/Fuf/9Y8OoVEZHvK6w7ZNlxP+7q0ALIUT/d1tOPjVAzwrnpBl8N5iLEoqvpeYhfiliPYN+Fm04S5AZURUFm9C1CJqkBEvaRWBscioiSpcFr7fBzNEGtjGVAW57C5Uep+Yrv;4:sC1JVF/iI+hPorcZe19Tnw5RcO3GEFnUSE7QKo9FURjz9XpW2qFQ2JLdJH1ypaVGJFvVIcKEr0mQn+MF3g5hv2mKMrLt57XbckMdUoSo8V3fBowYTKNW9McrzIKVxcJzkHxEns0lZRk4NvJPOUGOK0kGyBgEupmPte1y7aMS+CTyGgdtEb04DI3nJZizCeKChyM1BzeIr90h43x+PLVfpMceYCS0bRaxo9zlcsyJiKLgkY1LHYjjm1mvfoBYESJxreaqmKzaOfsMW1vkfNVjDdkv/iJttauKSdhdxDT0euztp+9Tpbv8r7NeomOnuoIW
X-Microsoft-Antispam-PRVS: <MWHPR12MB11498647287780989A5C68B4ECCE0@MWHPR12MB1149.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001070)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR12MB1149;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1149;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39840400004)(366004)(346002)(376002)(189003)(199004)(3846002)(86362001)(16526019)(6116002)(9686003)(55016002)(386003)(26005)(6506007)(47776003)(72206003)(186003)(53936002)(50466002)(6306002)(66066001)(68736007)(2906002)(966005)(1076002)(230700001)(103116003)(69596002)(478600001)(97746001)(8936002)(58126008)(54906003)(316002)(6666003)(4326008)(53416004)(7736002)(305945005)(8676002)(105586002)(106356001)(81166006)(5660300001)(23676004)(25786009)(2486003)(81156014)(97736004)(7696005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1149;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTQ5OzIzOjZSblF1RnR1MEhSc21yOVdzajhYVG5PVHBu?=
 =?utf-8?B?L3pYb2lUc3ZZTHdic3lMRXdNYUNRNXdYbXEzb2dqYXBvNmVVTFpnL3g4UG5U?=
 =?utf-8?B?bGdvQ3htcHB2a2VvbzlaZExMNU9GNjlGb2pIUDFRNitpK1h0QW5lUnRkYmlp?=
 =?utf-8?B?OUx4cE5NSVg3Q0JBd3Q2ZFE0NVVQdk4vVEM3ak9iN1RzV1JFQkVEMXpsbk1v?=
 =?utf-8?B?dm85MkEwKzZDRlZEUHh5L2RiZ3g5TmI3VFhPZFJEK29IcC9OMlZXNTFmRTUw?=
 =?utf-8?B?NDltUUlkQVdpMStKRk5FN1hacTlBdFVoZXp1QU5PRmRVVXQraUtOM3NTQmxY?=
 =?utf-8?B?U05SUi9nUlEzTXpwTklJRkdsV29mSE1oRStMZWE3bUdlVFVINUVTVUVIQkJJ?=
 =?utf-8?B?YjhKYXhWUTREN3lyQy9QMTBkQTJDRVJFbmx0OTFCYmdJMjBQTDhyZ3Q4Vkpu?=
 =?utf-8?B?Ym10R1pTS3ZmcFVySS91dE5ZbnZuaGYwTUdkV3RZTXpmNnYyVjM2L05Sa1A1?=
 =?utf-8?B?T3BmY1MzVUQyZkRncEMwUFZFR3VwOW5DSzM1MXJwb3Q0dVBDVGlQd01PTkJO?=
 =?utf-8?B?cUpnekRQeVE4S1JhZmVJU1UyOGRNak5ETEJWUjFrR3FwMTBuUVkvUU9sUDZh?=
 =?utf-8?B?TSsrNkNDWW91QlVNTFFDWnRoeEx0cEFpdkduNWdqNTNVNUUremhqU3QydFdU?=
 =?utf-8?B?MzhMeUx4QWE0NCsza2VxR2xoTmI0NG9oZEtPOVB6N0I3YndJWWx5dE1rbkZj?=
 =?utf-8?B?cWZNU3hIZnd5ekFYZXBLbUpoMzdjQ2JhOWVMdHFWRkdhQ0FIUHRVaGdzS0Fa?=
 =?utf-8?B?YnlKUEhXdWNmanM3MUVvWXdGbzZRY0VGOHdoUHhETXdKRFZGMGF6N2htSzkz?=
 =?utf-8?B?UTdyNEhGS0RwSnBGZ2FURVFRbmVGSUFpOG02L0Q5c1Rhcmtma0dBLzRMSXNa?=
 =?utf-8?B?dm92YS9SZ0t4V2QxVE9zU0hTYUtHdU00TEEyR0NSczBYcFhvd2s5amQ4Sncv?=
 =?utf-8?B?b2tibXdrRW9VTnB2a2QyNWRlOWlKcTZHL3FiRHdZa284dHNnMzVjbE42ZU9J?=
 =?utf-8?B?WUordWlxSW1TcWl5dlEreTFod0JHK0t0d2hSS0VwenUwUmF2MU1JMGswbVUz?=
 =?utf-8?B?anhPdlBVOVc3ZThuNlhDa3JXbzRnbHpIL2J6MEZEZ0xIZEl1RGRKZzJnNXYx?=
 =?utf-8?B?MnRqVUxQS2luU3VnWHJQME0zTUNEQmJVWGpidWpIQnFDbW5FOEFORW16V0Rz?=
 =?utf-8?B?YncvWEdacFhpWDhCeEVESFErRTRXcmNVZDJ5dUY1RVlmMzlPNzlCNGZxWEVX?=
 =?utf-8?B?ZHo2c1ZmeFlyaThCdHlQbUhVMUR6RGROdWNMN1NOOS9zWnRpemdreGFpaXoy?=
 =?utf-8?B?WFlIY0NIL2YyamRZcmt5YVB3aWJXMUNXcUlBQlk5S253dFdCOEppN2lTS0s3?=
 =?utf-8?B?bWdNa2RDNVVXLzVudzBNRWdLOTQ1anp0ZlgrYytGZ1J6aTk1cXQ3Z2t6aFh4?=
 =?utf-8?B?UlNrUEpEcWk0RTZiUWxabWpqUEZjR254RUZFSnFVbytrQW9TQndQSmUwc2V4?=
 =?utf-8?B?eFBaemROVjluWms1bUorcDRWTkUxYTNrUU1LQmRweDNyZGhjSUd2bjdKOGMz?=
 =?utf-8?B?aE1wdWwyQ2s4OEVLdGZlN3lSSFdQTWk3V1U3Wnd0QVd5ekxodU82T3ZRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;6:TZzKl++fdzVTj1KZ/mPmgpsBsaRLmkehfDkYA2GuPO1DETLA94KKfidMJwlnEn/3G8dkChWdvtzi87Z2TYvIgvesqbGV7HigigkDc+Q0z93E1rAT8l6j8GtDB/OoSbkOMAvQm30CLhcS7uA3+yMPDTFVrJCHJXXMQl8YlJTc2LK0tMWD1AVHiAWS1wz0JKE57iwkglS+e+DJ14Hx5jJxtjl2eTyvQS2zKksB+fpZKkoTMToFA0gw1s7WJMo7XhRpRcKfLEDNIj7FOsH2Fa5f8wAN1+6552f5PiSsYLQUKMTC+WW6cFcsoAszEF2Q49s7xHxKVdPWA2mWyt9NG3tb/gHgErODlNq3BqHFLbNePZo=;5:BKmYCAe7f+uZ54oyIDFtKuYgz+bkwAC4+HANVWLtAxl5rv+Ov0dzRsJvClhLJNDV/2NOqQkevMhPKrTsIf9kPgKzqyG31N7TLK/r6pz5hGRw4Tvsu0aWpY0B7ThWk0/oPEDC2o4vvOau96IDGpK/KHq5AXIJ2IVZpuxuSwJYoOo=;24:Pi8kGFGkLAi/0naFwbVg5qmsVh2M7n37mgFnRwCjNDqQWabDJx284L6mYp8UjqAMs5riJfZKBVodWOimmExOT3XyjkpJsXDGudL1epm4jAU=;7:YLhL3CuLdQ0hodn2vHv21StpSb3wnIqiWb/hydzPG+znpoH5NmeX9mMKJ+iESL2f93aqax1mhm99qBeey+H7Onf3/u3rMAfYTHjrVp0uQsOKNUSITeDdz1HzbInFYILQy9oEkh7D6qkfChA2WoUuukjbCG/HzPz20LZPZRhMB3vfZXgnFLyuOY9oSoyr6QTriGuZGfcGwFsThLGpgbjh2km2B9HdHUg41TPkMCofbjFqrPlsTDCaBFXLj8dFQUVX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:mYN1ZBI2giDANM8jMasbzzAsj70XLO/RkntQVBA90c3he5795bfSZFFlaihICy5ovVM0vymHj2R6FvnRdRQVGY8AjB+MAum5FN9RhuPPkAHPfUniUhc/OKo1dMPY2tlbpeScEfzGKNBR1RRY3asBXDXeWJRCV0qstOlaNES3Qw4njmztKVRONivwOVm4Yf+PXc5BPTnPoVPgfA46go/EgCG+mGTCPemRpWONJdGs123+mQ9zkasOBow43Y2sJgKn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 19:39:45.5348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d34a8e5-ed72-4595-9105-08d57962dcd6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series implements support within KVM for MSR-based features.
The first patch creates the MSR-based feature framework used to retrieve
the available MSR-based features.  The second patch makes use of the
framework to allow a guest to determine if the LFENCE instruction is
serializing on AMD processors.

This series is based on the master branch of the KVM git tree.

https://git.kernel.org/pub/scm/virt/kvm/kvm.git

---

Changes from v2:
- Moved back to initializing the MSR-based feature list in kvm_init_msr_list()
  (based on the kvm_x86_ops callback return code)
- Removed the definition of KVM_GET_MSR and switched back to using KVM_GET_MSRS
- Consolidated the documentation to group the ioctl usage and describe the usage
  specific to the version of the ioctl used.

Tom Lendacky (2):
      KVM: x86: Add a framework for supporting MSR-based features
      KVM: SVM: Add MSR-based feature support for serializing LFENCE


 Documentation/virtual/kvm/api.txt |   29 +++++++++++----
 arch/x86/include/asm/kvm_host.h   |    2 +
 arch/x86/kvm/svm.c                |   43 ++++++++++++++++++++++
 arch/x86/kvm/x86.c                |   72 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/kvm.h          |    1 +
 5 files changed, 136 insertions(+), 11 deletions(-)

-- 
Tom Lendacky
