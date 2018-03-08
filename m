Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489804-2-5751836016969713073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489803; b=PFoGaML9udNpunICl8s9c/iFrsOLSF+HRZtgWOhyYHivmJw
    TsFO4kpIv6IIhZdNV7PTMkF1aNwO/i4+iVIyvaXlQ6dQWrtX/7xs3754uaBMJjdy
    +5Zi29QFoAjqrhPug6MSEWGpt5EFwpaiiwcISch1DPcvpRFUQgmbUFNZ+MegYP0z
    FnaCG+LMzokm8rDI5HRdUn6fYwgIrv7hHVD/GJcE8xgl+xfDaxRFvQfH+pHx8MSK
    TKX7VU/qT3lmx2Pta9EXdNFkytunyE/ZzTmwBuBeahEn/M72ltiN8cQQtvS2l6tN
    OrIt55HhWnt0OuzazlR+P+PyXdWwPwZx7shht7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489803; bh=4nrk63
    8YsjmNmDp4w+8zT/LAhYYk5JnvlypzEVGzsUU=; b=pX7HVsUvYyBeyoyVs4kL3N
    /S75wn/Bj9eQOR566Yqqy7K2hXhV6w/UCmFxLKsY9YKa+DLXL3jUolLPCyVHzO6+
    3/oBf4E4tCVX+L+XM4Gvllcrt5bk6joNRlWFmdUidNoYrYWURg3xvuALtGfBHMU1
    jUqxpvDfb/ZJh6a5aFNVj5EiZ9fcva8QZKpWRnax6hQiRPR+jDm62VzYlnDIIDCk
    pyjgV6DvlH3Rws5O+VfKG5igEpSgJhw6Nax9psrFRvSU3MU7bNbDnsRlzBpbnvkc
    CVLzpK/GJK5Qs2zegmaT6kqUSWhAf+mgRmfEPjGNkrnJSgjvFzRz9QewfytE+hyw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yn1Xg3bW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yn1Xg3bW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965910AbeCHGQY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:16:24 -0500
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:20160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755334AbeCHFBZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian King <brking@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 070/190] ibmvnic: Disable irq prior to close
Thread-Topic: [PATCH AUTOSEL for 4.9 070/190] ibmvnic: Disable irq prior to
 close
Thread-Index: AQHTtpo5tXbfGaq6W0Ojibmqm7MQXg==
Date: Thu, 8 Mar 2018 04:59:22 +0000
Message-ID: <20180308045810.8041-70-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;20:zeHa6CWkYZoZducQYZ4IYnskiqCxwDsijcSYs3fiNMLKcn0VrWDnlE2GPCb8z4cAWbEv2TouOjZ5/kYbOFvAXsDBkbYgRLfUUFkn/bwyHAsYF4ZtKtILGQMmbP69SgyOkmsSNPNc3Vo19toxwPHsuxFhAGY4Zt2tI3366BJMFCs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7341383e-ed09-4ba4-aaf0-08d584b1a3fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09015198D9F9D8D95CAAE2D8FBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(575784001)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(59450400001)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: /lS3EXSu7xfXhAv8Tw18XHay61xHb/YfAKwjr4EchQz+B8s0DJz6X3nuh/zeAuTXuH05UAqgVMXDaYW6puXavGRTSaWfYk5ADEW9Pc2HpfRt+dlRJ/Yq8dR943NfwDUd2cnMHGZsbNw6QeGaTO8s8w28FBn3ABFlHQIR/3Cu52L2p+tXQvpgz8paC5FnLjfDVpBacbfbiUqCtYjbeuZQfmZPloWKn283LLRLZGReD4wJKCQgDbzs6t1f7pJ/hMP/oyTp/6VyEA8SOMynhfAxnVVlx4FX9W/34wc4jfT1P0sBULsGoTBjxY1q4JXvkUMtnqbFR3stuxrbEK3XX7sf5A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7341383e-ed09-4ba4-aaf0-08d584b1a3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:22.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Brian King <brking@linux.vnet.ibm.com>

[ Upstream commit dd9c20fa07ba5cfb5a0ab3181d68530506610605 ]

    Add some code to call disable_irq on all the vnic interface's irqs.
    This fixes a crash observed when closing an active interface, as
    seen in the oops below when we try to access a buffer in the interrupt
    handler which we've already freed.

    Unable to handle kernel paging request for data at address 0x00000001
    Faulting instruction address: 0xd000000003886824
    Oops: Kernel access of bad area, sig: 11 [#1]
    SMP NR_CPUS=3D2048 NUMA pSeries
    Modules linked in: ibmvnic(OEN) rpadlpar_io(X) rpaphp(X) tcp_diag udp_d=
iag inet_diag unix_diag af_packet_diag netlink_diag rpcsec_
    Supported: No, Unsupported modules are loaded
    CPU: 8 PID: 0 Comm: swapper/8 Tainted: G           OE   NX 4.4.49-92.11=
-default #1
    task: c00000007f990110 ti: c0000000fffa0000 task.ti: c00000007f9b8000
    NIP: d000000003886824 LR: d000000003886824 CTR: c0000000007eff60
    REGS: c0000000fffa3a70 TRAP: 0300   Tainted: G           OE   NX  (4.4.=
49-92.11-default)
    MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22008042  XER: 200000=
08
    CFAR: c000000000008468 DAR: 0000000000000001 DSISR: 40000000 SOFTE: 0
    GPR00: d000000003886824 c0000000fffa3cf0 d000000003894118 0000000000000=
000
    GPR04: 0000000000000000 0000000000000000 c000000001249da0 0000000000000=
000
    GPR08: 000000000000000e 0000000000000000 c0000000ccb00000 d000000003889=
180
    GPR12: c0000000007eff60 c000000007af4c00 0000000000000001 c0000000010de=
f30
    GPR16: c00000007f9b8000 c000000000b98c30 c00000007f9b8080 c000000000bab=
858
    GPR20: 0000000000000005 0000000000000000 c0000000ff5d7e80 c0000000f809f=
648
    GPR24: c0000000ff5d7ec8 0000000000000000 0000000000000000 c0000000ccb00=
1a0
    GPR28: 000000000000000a c0000000f809f600 c0000000fd4cd900 c0000000f9cd5=
b00
    NIP [d000000003886824] ibmvnic_interrupt_tx+0x114/0x380 [ibmvnic]
    LR [d000000003886824] ibmvnic_interrupt_tx+0x114/0x380 [ibmvnic]
    Call Trace:
    [c0000000fffa3cf0] [d000000003886824] ibmvnic_interrupt_tx+0x114/0x380 =
[ibmvnic] (unreliable)
    [c0000000fffa3dd0] [c000000000132940] __handle_irq_event_percpu+0x90/0x=
2e0
    [c0000000fffa3e90] [c000000000132bcc] handle_irq_event_percpu+0x3c/0x90
    [c0000000fffa3ed0] [c000000000132c88] handle_irq_event+0x68/0xc0
    [c0000000fffa3f00] [c000000000137edc] handle_fasteoi_irq+0xec/0x250
    [c0000000fffa3f30] [c000000000131b04] generic_handle_irq+0x54/0x80
    [c0000000fffa3f60] [c000000000011190] __do_irq+0x80/0x1d0
    [c0000000fffa3f90] [c0000000000248d8] call_do_irq+0x14/0x24
    [c00000007f9bb9e0] [c000000000011380] do_IRQ+0xa0/0x120
    [c00000007f9bba40] [c000000000002594] hardware_interrupt_common+0x114/0=
x180

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/=
ibmvnic.c
index 7c6c1468628b..49094c965697 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -511,6 +511,23 @@ static int ibmvnic_open(struct net_device *netdev)
 	return -ENOMEM;
 }
=20
+static void disable_sub_crqs(struct ibmvnic_adapter *adapter)
+{
+	int i;
+
+	if (adapter->tx_scrq) {
+		for (i =3D 0; i < adapter->req_tx_queues; i++)
+			if (adapter->tx_scrq[i])
+				disable_irq(adapter->tx_scrq[i]->irq);
+	}
+
+	if (adapter->rx_scrq) {
+		for (i =3D 0; i < adapter->req_rx_queues; i++)
+			if (adapter->rx_scrq[i])
+				disable_irq(adapter->rx_scrq[i]->irq);
+	}
+}
+
 static int ibmvnic_close(struct net_device *netdev)
 {
 	struct ibmvnic_adapter *adapter =3D netdev_priv(netdev);
@@ -519,6 +536,7 @@ static int ibmvnic_close(struct net_device *netdev)
 	int i;
=20
 	adapter->closing =3D true;
+	disable_sub_crqs(adapter);
=20
 	for (i =3D 0; i < adapter->req_rx_queues; i++)
 		napi_disable(&adapter->napi[i]);
--=20
2.14.1
