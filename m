Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244146-2-4585224196966204386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244145; b=qZ14HSi6DAoj9wedlKNKdnbR9+aqDhIjPOtRVM0aicaoS/RC44
    fgVLYvycbDqDu63zp4QFjHnVR6FfbfXdZv0sDaBEYNI7m+yALn1rqyTizPKTfcZO
    DeVD8OOh3IluzIwrpJoVM9JtdJeNEcyu0r49N3PkgFXxaNeN0Y/EH+5dk4gRDgqo
    LE5g0QKDAB94EBX1xEdP+Aa7nEVYkNCQ8A/LoVequBk9SM+Z5PHSfbFRC6ewTVZU
    EvVAWYETfVJVJLE7fJPOtF5sEGMN9sF9bt3mag17GaPPJ70cGZtEf4YXctLFb0Yg
    yKt0bK3oig7R2YtgJ4uoQDYkpGGxvQrpm9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244145; bh=nm9bJ4A1Ws
    nFUejPNtYvF2Sx5gDpkDE6HjYaBGqKyKM=; b=Xa4mhXWbx1oKO8AnODjNETTlbS
    EyvELut6A9F4Hv3eKak1WtoUxNCc/7abKYGcwSgFKK/Bfts+26SlQ3cmFZpwmlSI
    bugx9lBm/LqU/lfibzO3oq2lGbxe7MHiPf1tJcgA0NzMQJhqbzvfShFlgtQI1jND
    HpFXfjTcIPktxRcF8UDLEiAvkmlJkI9mKXgDiXO32VrOZPiSqabQTldCcFwvLSOw
    h+GEk4WBbdqESwvjp36wY4C3kdSB4FVmV1dIXh1t6ZnQs7xlQZGkiWumohss/svb
    uWgmn+Pk9CoXe0Rw8DoleWcDpccmFbp4H23sBkxVlodQPngzSxd/tPR//oZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BICHZ/jF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BICHZ/jF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEm/qmk8CBnDAeJW2aCCZboJwGs5eSd4yLpdvmYsqw/of4g4gQBta2jEmPH41ErDmNI3paZQglaYlh1feoT9yuWITT02ixb9WupzxblxmVrxmxsVHSnJ
    SdEI6pH0NgCFSpPfjbvrIwgfvuGPLFThbz3F1zne9Ysiwj75vKuDLSWaOPqpoHCIAhllWYWodrUNo/lv5PMMxUC8X6Q1S9qBgp6hgIgwuEXWi8NWo9Off6yM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=XtRuH-coHMkd7l1ki0sA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbeDIAWy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:54 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754726AbeDIAWs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 031/161] iommu/vt-d: Use domain instead of
 cache fetching
Thread-Topic: [PATCH AUTOSEL for 4.14 031/161] iommu/vt-d: Use domain instead
 of cache fetching
Thread-Index: AQHTz5iD6b67OjwHNESCNoTmcm53wA==
Date: Mon, 9 Apr 2018 00:20:07 +0000
Message-ID: <20180409001936.162706-31-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:Fv/bfK2OW035A/7O+NL/MByxe9zwE1DL5myUMI7wfLx/hziyNUzKSJMCuRzOxeErhm8bLME6TDnldy3FBq6SwJM7NEOOwmi4KepGgEaSyVSLrq+GVjxdZecU6wKJo4OXabfQsePYXvLkRips41DUvsGKAQnLHsTiOnZFk07kGLn4ssRvslu3GMw4YFk0J0lE/qzPrBhbUo3TI/K1JOf0SB9+tzpiGmdKk1dyTzkZacxolIOEMq6BkMTmg32mlrek;20:obrLWiFLzL8hVA32Sr/vfOQAKDDjzooQ4pXiUrh2jeHQ7HLb4lkKep3nvuzjOY+LXXD20FyhZqqcJ9BmALRDy3RJMzQzbkYfUMq5Hho8CDhLxF+dORTbaGq8Sdt/YyGIg/xg7bVJt3F1ndXDRuVPXmAG/Phu0qvHtWBVneSqVHU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 796ad28c-e51e-4908-a02a-08d59db00399
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966BA3D659F24C4F214D5B8FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(83566789882024);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(51234002)(199004)(189003)(377424004)(6512007)(316002)(59450400001)(6436002)(186003)(6306002)(6666003)(2900100001)(966005)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9kT8tcT6rpviQBw47xT25lGGkf79gF5RIXV5IvvesS5pKICnMoigGznm2zhtNJrxIK0cgDOdmD4aQ9vBpPQh3pRFnqEKtR0TG/Y7LV07/QWGlEChJllaBSTzLDjJgYiaGfN2AwlowWcqC69yDlxi4aAFl+atwoWdOQXjrwunsHeYbJlN4/J4eNWhczf3ULm2mG75AC7KNylhJ0dPnbhVOqoZ0Rt8axHNhscFyjvHkPT7RnircUvGCs8NoRHVU5JrPO0wBKMKp5jwEC3IOHtKlVh/LXT9eFKl09+d2w4aGvDrpMR391grXK/zigEeJsQN4+459tbRwwWwpFNlh03dW6em9jIucFmZa75S2NQnQ16/dQcIz16UkdMyAGCOVDvHs4kZ3OF6R3d838p31a9eLXpv1l2BWbIi3H1IoHhVHsc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796ad28c-e51e-4908-a02a-08d59db00399
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:07.7228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Xu <peterx@redhat.com>

[ Upstream commit 9d2e6505f6d6934e681aed502f566198cb25c74a ]

after commit a1ddcbe93010 ("iommu/vt-d: Pass dmar_domain directly into
iommu_flush_iotlb_psi", 2015-08-12), we have domain pointer as parameter
to iommu_flush_iotlb_psi(), so no need to fetch it from cache again.

More importantly, a NULL reference pointer bug is reported on RHEL7 (and
it can be reproduced on some old upstream kernels too, e.g., v4.13) by
unplugging an 40g nic from a VM (hard to test unplug on real host, but
it should be the same):

https://bugzilla.redhat.com/show_bug.cgi?id=3D1531367

[   24.391863] pciehp 0000:00:03.0:pcie004: Slot(0): Attention button press=
ed
[   24.393442] pciehp 0000:00:03.0:pcie004: Slot(0): Powering off due to bu=
tton press
[   29.721068] i40evf 0000:01:00.0: Unable to send opcode 2 to PF, err I40E=
_ERR_QUEUE_EMPTY, aq_err OK
[   29.783557] iommu: Removing device 0000:01:00.0 from group 3
[   29.784662] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000304
[   29.785817] IP: iommu_flush_iotlb_psi+0xcf/0x120
[   29.786486] PGD 0
[   29.786487] P4D 0
[   29.786812]
[   29.787390] Oops: 0000 [#1] SMP
[   29.787876] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6=
table_ng
[   29.795371] CPU: 0 PID: 156 Comm: kworker/0:2 Not tainted 4.13.0 #14
[   29.796366] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
1.0-1.el7 04/01/2014
[   29.797593] Workqueue: pciehp-0 pciehp_power_thread
[   29.798328] task: ffff94f5745b4a00 task.stack: ffffb326805ac000
[   29.799178] RIP: 0010:iommu_flush_iotlb_psi+0xcf/0x120
[   29.799919] RSP: 0018:ffffb326805afbd0 EFLAGS: 00010086
[   29.800666] RAX: ffff94f5bc56e800 RBX: 0000000000000000 RCX: 00000002000=
00025
[   29.801667] RDX: ffff94f5bc56e000 RSI: 0000000000000082 RDI: 00000000000=
00000
[   29.802755] RBP: ffffb326805afbf8 R08: 0000000000000000 R09: ffff94f5bc8=
6bbf0
[   29.803772] R10: ffffb326805afba8 R11: 00000000000ffdc4 R12: ffff94f5bc8=
6a400
[   29.804789] R13: 0000000000000000 R14: 00000000ffdc4000 R15: 00000000000=
00000
[   29.805792] FS:  0000000000000000(0000) GS:ffff94f5bfc00000(0000) knlGS:=
0000000000000000
[   29.806923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.807736] CR2: 0000000000000304 CR3: 000000003499d000 CR4: 00000000000=
006f0
[   29.808747] Call Trace:
[   29.809156]  flush_unmaps_timeout+0x126/0x1c0
[   29.809800]  domain_exit+0xd6/0x100
[   29.810322]  device_notifier+0x6b/0x70
[   29.810902]  notifier_call_chain+0x4a/0x70
[   29.812822]  __blocking_notifier_call_chain+0x47/0x60
[   29.814499]  blocking_notifier_call_chain+0x16/0x20
[   29.816137]  device_del+0x233/0x320
[   29.817588]  pci_remove_bus_device+0x6f/0x110
[   29.819133]  pci_stop_and_remove_bus_device+0x1a/0x20
[   29.820817]  pciehp_unconfigure_device+0x7a/0x1d0
[   29.822434]  pciehp_disable_slot+0x52/0xe0
[   29.823931]  pciehp_power_thread+0x8a/0xa0
[   29.825411]  process_one_work+0x18c/0x3a0
[   29.826875]  worker_thread+0x4e/0x3b0
[   29.828263]  kthread+0x109/0x140
[   29.829564]  ? process_one_work+0x3a0/0x3a0
[   29.831081]  ? kthread_park+0x60/0x60
[   29.832464]  ret_from_fork+0x25/0x30
[   29.833794] Code: 85 ed 74 0b 5b 41 5c 41 5d 41 5e 41 5f 5d c3 49 8b 54 =
24 60 44 89 f8 0f b6 c4 48 8b 04 c2 48 85 c0 74 49 45 0f b6 ff 4a 8b 3c f8 =
<80> bf
[   29.838514] RIP: iommu_flush_iotlb_psi+0xcf/0x120 RSP: ffffb326805afbd0
[   29.840362] CR2: 0000000000000304
[   29.841716] ---[ end trace b10ec0d6900868d3 ]---

This patch fixes that problem if applied to v4.13 kernel.

The bug does not exist on latest upstream kernel since it's fixed as a
side effect of commit 13cf01744608 ("iommu/vt-d: Make use of iova
deferred flushing", 2017-08-15).  But IMHO it's still good to have this
patch upstream.

CC: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Fixes: a1ddcbe93010 ("iommu/vt-d: Pass dmar_domain directly into iommu_flus=
h_iotlb_psi")
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/intel-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 83f3d4831f94..e8414bcf8390 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1603,8 +1603,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu =
*iommu,
 	 * flush. However, device IOTLB doesn't need to be flushed in this case.
 	 */
 	if (!cap_caching_mode(iommu->cap) || !map)
-		iommu_flush_dev_iotlb(get_iommu_domain(iommu, did),
-				      addr, mask);
+		iommu_flush_dev_iotlb(domain, addr, mask);
 }
=20
 static void iommu_flush_iova(struct iova_domain *iovad)
--=20
2.15.1
