Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeFDJIU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:08:20 -0400
Received: from mail-pu1apc01on0098.outbound.protection.outlook.com ([104.47.126.98]:37934
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750866AbeFDJIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:08:18 -0400
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [RFC Patch 0/3] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support  
Thread-Topic: [RFC Patch 0/3] KVM/x86/hyper-V: Introduce PV guest address
 space mapping flush support  
Thread-Index: AQHT++OO/K3ZfUGclEGqBAY0Kg6dmw==
Date: Mon, 4 Jun 2018 09:08:09 +0000
Message-ID: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0014;7:nbDc8VytzgS/MCp8j980HbPjy4rhE6Pq3qxun1P1EXOPwu67FAdQO49bVXf5PMwH8xWUC0SWTZJ/lZB7BLEZUeJNfbZMcGnxbxlSqlk7DqgYiZ1MTRtkXq1+O3bORyrtHMlA0CDMCQ5kwku/zxlC5E5LnNK1dI1ykeNhh21lJI+/Vod92KzzU55HJJfk1b2C9HepbfIgK6oHdz3WLohhYORVk6GRpQnEcpMLL43U7B3+Gz1QxAt8AgeVbLdD4wYB;20:Ym/H/ydW54zvh7GBYWH61E9EkNpMHjqI0jdEUG045hyaZ/4AKhpHxF9ftzEoQNNIRYVdCnYxIRNcrMnYkhncGxz9Ns3wiHsqBK80bW9rWit18bFaiCEGYEa4Z3QnM/rSZwyKeBAycrK40zYedepVkegA02hrOscC5X3GnB5i89k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:SG2P15301MB0014;
x-ms-traffictypediagnostic: SG2P15301MB0014:
x-microsoft-antispam-prvs: <SG2P15301MB001446DCECAB1CF822F0A34F92670@SG2P15301MB0014.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0014;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0014;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(36756003)(305945005)(5660300001)(10090500001)(97736004)(6436002)(7416002)(2900100001)(68736007)(3846002)(6116002)(7736002)(25786009)(1076002)(476003)(486006)(5250100002)(2616005)(1671002)(478600001)(72206003)(26005)(105586002)(106356001)(86612001)(86362001)(2906002)(99286004)(22452003)(316002)(54906003)(3280700002)(102836004)(6512007)(3660700001)(59246006)(14454004)(6506007)(53936002)(8936002)(6486002)(66066001)(81166006)(81156014)(8676002)(10290500003)(4326008)(109986005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0014;H:SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YJIeqjN+VQ0hG/9MgQGiuG0TiPQPwjYOdpxL20FCZXYlOcXnpWOzJaJLBSO+enbeXLIBsu+2cQeHW5OeWKxlMP7JO4Y3xT5JAI3AOjESiba0SQUNuxtaszz+FjUAsm+ebGDRdPryWuArZRlWSi1V13iV5OLPPFAMCXQ4uZc00tpOBMFIUfnIY85+t+/1/cJy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 543177ae-7c9f-4ca7-1faa-08d5c9fab1e5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543177ae-7c9f-4ca7-1faa-08d5c9fab1e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 09:08:10.1227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0014
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w5498QIk032346

Hyper-V provides a para-virtualization hypercall HvFlushGuestPhysicalAddressSpace
to flush nested VM address space mapping in l1 hypervisor and it's to reduce overhead
of flushing ept tlb among vcpus. The tradition way is to send IPIs to all affected
vcpus and executes INVEPT on each vcpus. It will trigger several vmexits for IPI and
INVEPT emulation. The pv hypercall can help to flush specified ept table on all vcpus
via one single hypercall.

Lan Tianyu (3):
  X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
    support
  KVM: Add tlb remote flush callback in kvm_x86_ops.
  KVM/x86: Add tlb_remote_flush callback support for vmcs

 arch/x86/hyperv/Makefile           |  2 +-
 arch/x86/hyperv/nested.c           | 64 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  8 +++++
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/include/asm/mshyperv.h    |  2 ++
 arch/x86/kvm/vmx.c                 | 15 +++++++++
 virt/kvm/kvm_main.c                | 12 ++++++-
 7 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/hyperv/nested.c

-- 
2.14.3
