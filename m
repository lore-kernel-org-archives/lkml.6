Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756618AbeBOXMH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:12:07 -0500
Received: from mail-by2nam03on0047.outbound.protection.outlook.com ([104.47.42.47]:19376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756565AbeBOXME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:12:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 0/2] KVM: MSR-based features
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Date: Thu, 15 Feb 2018 17:11:57 -0600
Message-ID: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR10CA0062.namprd10.prod.outlook.com
 (2603:10b6:300:2c::24) To MWHPR12MB1152.namprd12.prod.outlook.com
 (2603:10b6:300:e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b856e604-04ce-44ca-b725-08d574c984ea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1152;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;3:WhvcCum42glkKxjoO/bGDnsML+KYP3gl5CIAylXfnrXS8pyvtTEwzb6OuE9AVBAmv9/uZz/AYF9Hg9bi++SNMsd1DkoGLz/vwgTSZOAeBR7kKSfUEFCgpqw6iobAG4DrVFnNMOTj0wAAOAriEfJLBtIP7U/d09qeYm8INdXGYO/gPJg/8QyoGx46hecEQGV4Yo66oBMweivqArdT9pIHHTQy1uY2ojRbF1akhu+lHd1AbXIu4ObxwgGV+Z3mKgm1;25:sGJseWoJFjzOxF0nRGv48lgqFrXxaLNAsUe7l1Ma9v1ymY1wnWPkh6NMMow/yneDsR2wndieFk60y7j/aRwsS5Vc4Fsks2X2yUfNq9t71mzTE/NAI50Zuwv3ovuATQjb++H1jPMiWmKPJE3QVCmqL4ypWhRa1uxGvGp1mu5uJz+wO33EoNToOdgFjf4DDzdmP1Ux7KuuD6t9x6MPST8vUd0ZGtGx+msFt7Bw3+Zer9JkV/qacqF6WaQMbYTctzA/FA7mbay+y6KhJmYSa3mwnuE9G3QwyEl5pOfNpeIYVnfAnCoOA3B6i8b313OvPqT8Fxq6ufB8Lt+8f6mzCiR/BA==;31:m/IkwCuuKNQbeefjLE/Db5VPmkB5/rh9GoSWuq+4rww1cfhItDcyPIebxK2XYbp4izj26DiB27rP/ODul2n+/OyV4t2S9cbmq2dODtusoomaDXjMMMkLKvE9/2a2cZHY6pL86FUb5GyVMOeYLEGhRtQeKQfPkOGZkUVt4WwFe9eu814Igsv8jGQ/tLbMBfQwkd/RftKZjGz1ltXEX+KN/SkoIXkDQgTt4AS2J7lNawg=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1152:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:7TmibwNyZjPGH04QkTtcw8tidRLjYo03/LbNZTFOwBhrIL8JHloROwKfcwZ/BRnPb3FoG8dypmEJMIHQ0qB0+ycuuKdrTrfCJsmFYZ5reYEBQu89wqNBNsomE7++Kwf8ww64uwaYDxU4jFCW3sNNJUGD7+Il9proYPY3gnAWSL7+bhEEiw7wxMaYjGs+5YduBl1wqJlP3dKpK6mReKonUd1WZQjTlIGhIE4Hpf7MP95dvQQgb89E4PGSrwz/CcviiryFNX28fY6OM1QtowHCMxNevxVPI9LZWJagGtSzBfvK+GuEi6h8YSUpoT5RYUWKWED68ZJYhj3K0b2OF8TkpjrSuIvLURn4yK39g1wVeQm2ZMr3l7wKUf8tTglb2OAiz+5gYTqGH8xN0mY4OdlQHmrlHlTEhYLIy8vy7u2MlXeuAdna9milXPyBKxySNaGNvjAZ1rILOOtpS3SmArah+PdHJRZHyGsqk6tTIUJJELdRNV7P/4dc2TOkghoBkEyo;4:KwNDsvJ2gzj8GDOYLuQr11zx5hjFNBKoIReXKFVJYGneb2rIFGF/RSjCALwyWK0OOVp5xnoQMce+PebpZ5s62n7likzwL7wQRueRYXKNe8o1t+B/tqRtQpbO9KllSOxCOuoP0n/qWnBBicrQxqjWD7UbD4SMLQPblqJDVXCux6Z3LyatJVauResS9yoCm4fv0eSCPn2/VZBAxmNKY/Uw32Mq4tF1TPkyUtd6KmDrNz7xnnDeES6i882DOf4TnZOwy/Z0SDFG9yJHfMkzuSBKQZXID+VufmWZs0MJ/qq4JyjG7FoVjUpkPnxZDrBpQSzo
X-Microsoft-Antispam-PRVS: <MWHPR12MB11524CD897834A946FBD2DD5ECF40@MWHPR12MB1152.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(944501161)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1152;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1152;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(39380400002)(376002)(366004)(199004)(189003)(230700001)(9686003)(55016002)(47776003)(106356001)(66066001)(50466002)(8676002)(83506002)(25786009)(478600001)(8936002)(4326008)(316002)(103116003)(305945005)(1076002)(54906003)(3846002)(6116002)(72206003)(53416004)(26005)(81156014)(386003)(81166006)(966005)(58126008)(6506007)(16526019)(7696005)(68736007)(105586002)(52116002)(86362001)(97736004)(7736002)(186003)(2906002)(23676004)(6666003)(69596002)(2486003)(97746001)(6306002)(53936002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1152;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTUyOzIzOmNPeU03MHIyc1Qva3paWjlLRmQxdE9hQ2tl?=
 =?utf-8?B?Tnp6WVF2SG9BM1lXMDBNcDJBakpETU1qSkxGTmxMYlViTVZqUEpvSzVEWVY3?=
 =?utf-8?B?aEpTNTFXOFBsOTZyTnU1MlNNWjUwTTcyMHhob1M4VmJkU0FiL3pBNWNYNTZ5?=
 =?utf-8?B?eVZHbTQ2NCtrRjcza2RqcHlPeEdLN1YzbmtpYXlWUkt0OGRaZC91eXlGNEF4?=
 =?utf-8?B?WHFUTlJXbUJlNGJXNjNFZ0RiYmE4cVlvWWdBK1F0dXBaalBHWjArRGtDbk1R?=
 =?utf-8?B?UVlCVjhNWm1kOWxaenl5YzgvVDlKMmYrZHAyWWNzeDlCdzVJazZXVDVrbU1l?=
 =?utf-8?B?YnFYbHNUUmtIbTFqOFhubDNMWDdKRGRNQ0JXOSt1b1UxQmxBQ2JXaDhkbG9N?=
 =?utf-8?B?QmZwVHpySU9tdjBHbld0ajJvNnMwb1FueWxTR1NWYTdmSWthOGpUVGZFMCs3?=
 =?utf-8?B?OGlLRXJDS05KMk1xWEZjSU1kY2k3WitCWXc2bkRJS2MyOFFBK3lQTmo2VDVM?=
 =?utf-8?B?NXN3SFdRZmVpdEs0Ny96eFE1Q3JMeVVnVFF4c09ML1YwZUFXMC80WkJpeUd5?=
 =?utf-8?B?c25XeEVxdWh1Slh2RE1QemczZm4xcUU1T0VSU0w1cWw2VDRMQ1FjTHZ6V3N1?=
 =?utf-8?B?N2JsbzV5M0xBNHMzblp2d2ZCd2JxalNsd1pJeWM4MkRlUHVFNGRiZFV5ZHhq?=
 =?utf-8?B?SjNwLzM2eHR0dG5aNmYxbmh5S1BYTTExYmQ5SWNwVzd3SzdkZitHOXdDL2h4?=
 =?utf-8?B?SDVuM2NnV2pYMktnd2lTQ0hhcE1jWGpkVUsvZko4bXB4TThwNGNyYVl0TXYr?=
 =?utf-8?B?MjFkSkY0dXQ2OTQ3K2tnVUd3WllFNTNKUGJIZm9TRFRQK05ZR1ZraVkySFM1?=
 =?utf-8?B?R2VSYWNFaE9UQU04Nk1KL3duZTd5cWNXWTVoa2tiWTdpeUowQmQvaENsb3pI?=
 =?utf-8?B?SktSN3A5eWNHWWVCbkg2aGtlSURxV1JIcWRQTDJHNkJZSzJvclJsQ0xleGNR?=
 =?utf-8?B?cW1OVUlzSi9ram0zbzRYdlc4QTY3R3NGMVdGMmdreE5JTmtmN0hZZ2lUbGNv?=
 =?utf-8?B?cjMwSlhJL0l6THllSlJrQ2lCa0hrZytwZnpHbU1nUENCM3VhenBEVENXVmM0?=
 =?utf-8?B?SnFuN2F3VFZ3L3hyQWhmd0lXYkFocmhRU1ltalZ4cldLQWxwdGhiVmh3TVZW?=
 =?utf-8?B?SUNFSFhlTkI3Y0ZVVjc1TXI4a3JHdWRTbHVRRVlGQzJjbWwwUWttb29pWUhK?=
 =?utf-8?B?R25ScUI5ZU56Y2tKcjRTLytHZVFoOWQyakZZZk9BK1d6eW1JdHZNeDhTeHBG?=
 =?utf-8?B?Yzc3aHR2bWdhS3pnUklVdVBZSjZKT3pjNnh2V0s2U1pNYm40NGlhWEhxV3BP?=
 =?utf-8?B?WU1hS3U0cWVVdkxRdHBDcnVlcmp5bE9GVlRuV05mbzhDU05lTElnVExVMHZv?=
 =?utf-8?B?U0YveW1iNEZvc0VSYlNZcFczSmJ4OXFFSSs3ZytMaG1SK3IwTVhGOFJTMXRV?=
 =?utf-8?B?UDZnd2VJaXlLcW9GZEhKNFcxUVRTOEJiWXQ2Sm1FSlV1cks3WDFWMXUzMndF?=
 =?utf-8?B?cUlwM2x3dzBOeDdoVVNHTEZVQjZWOTIwY2JzejhEYXRPd1A0Qm1kSTlVK2V4?=
 =?utf-8?B?WG1rV2cyblRoT3AxbzJBQ2k1aHRPN1NST2VnMHhmSkMzS091RysxeDJhQ3pi?=
 =?utf-8?Q?XaGzSR6/8UAWPSUjc0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;6:BGS/QxbR7U//KuSMqM5kEheTxYurXodSNyjqnCFoaUvbTmFYrOO0YNB6sUYnxrbi6VoBJiGCUc/L4MvB2gnc+5yotooW67L3Fy+DupamUX5MipxkTSf2r5xZFuNKt8P5oYkta5sgHmmb5QUjMRQ46APciJLjvueQjowoEwwxdSOiuEEXUXgZD86q8zcX24N2sIyHE5SFl9nCZiAfGCjeer/kwmuCCzyoi0wrtmhaQQLLFblXff4aqQuTItd6UCpaFQ+ZQV/p6mNQyzaJAwy3vvbOxlDMh2uihbOh81EMBIazcRL5PNQb6R0eANjmReI0RjmhrNy2Enp4JtAA0xHX381FidsCtyEXBiHdCEJ2d5w=;5:Sryx5UDf5Z/W+94snhdCUg2Sn5t/r5mg0qCzrLF0WUI5rUTDNv3nL/RxmtdS9wsJRAR4MB9H3CvtZnV6Y5m4cVmeyJkkWcZDsKlG31jAYqoSeUovXiNZBipL/KCtBTvBRSjsykXBrEEojYgLvUZmyRZE8Mv/jPHtl+oJDiKRs7Q=;24:iKRwe4sgcfuhCK00vJ72tUjqJcFvyPcaUZRVewlRWvQh5frFBExhvYPTkzGn+KQoEdrhb52y8kA/pGqnHTQQ12y7rYm1f4qtyiCDLgL4rxo=;7:0mRVH4Xvagje6fvcdHyxxur66ii6qbObSaGH3ZhenSfEA8oaMuthjqi6Zxf3W/hoQBekBo/KcclEp7OxC+GgnuK762fj6WCHwXt/O/pkugLRzsx/MruqvGyJ2wWRBj1nN1T+0L9XMBtZjpUxv9aja1zSMADgdRr0oyiDDWK74mzBCop9pEILcXGOtx2AeS6r9X7TjZXWm3q4MAThKD2k4EiG6j3e043wIWla4XMzxSm7U00JUsv2HPVJJiNHqKmp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1152;20:ODGLMw39LSnjdGdoXGFMsWTy65hzQ1tZZH42dS/IuPiCTK21nFEG98y5b9SXfq0mjwZZ5plj1rDesKjp5ooluYg/IOJnCz1l0yqbrz3uAkXZYk9kxCJsMV8lugnezSSmktcAoHJmG2TmwVuynI3CvsdkcD/IxcGWd6z1rW+wL/FwuZBnRvS3j/ERxlIo0Aal/6BKOAKBW+07pod3z9u3Z/Atk7pJb+R6vR0gnpEHzj6fuy9MWSEgQc0N+RrD8eLf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 23:12:00.4079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b856e604-04ce-44ca-b725-08d574c984ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1152
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

Tom Lendacky (2):
      KVM: x86: Add a framework for supporting MSR-based features
      KVM: SVM: Add MSR-based feature support for serializing LFENCE


 Documentation/virtual/kvm/api.txt |   47 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h   |    2 +
 arch/x86/include/uapi/asm/kvm.h   |    1 +
 arch/x86/kvm/svm.c                |   43 +++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c                |   52 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |    4 +++
 6 files changed, 149 insertions(+)

-- 
Tom Lendacky
