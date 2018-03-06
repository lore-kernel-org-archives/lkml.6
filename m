Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-984164-1520360631-2-9480465583660499358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520360630; b=R9zkDoC+QxyqB+ud1SBy7B0hvnAYLw+nJ8gqbx4KXndp/XR
    g9kskcUGk3hiYgHFwy7YgLY6DOFXt+GY7j8bC+VKybzh7OEv6YlgSjdCk9EkwdIC
    tFCD0IK+tBFfqKL3H9yBd1LS6VLpS4Y61Vb0YrkyRtEFK2N/sPqrfVZU9Yoz5itX
    HlhpnHGRXccBWIG+Mhgbv5pQvKe1Wy3u7XiLU5COo68uSTEpdlJ87p34uDCbxrd1
    CZ2krFr8bZ90T6lvLq/jLMrMpKYriuhyrSlBnMFGKzRY9HVYkkKz6txXCwWUl7DJ
    YEyHEk6RaF4NXvYaFuq1oHk4ldOXAKWAVipnJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520360630; bh=+Hhm9N
    3q2CK6Hm61XPJ+Ffw7pjJ9voBSDqTWohRxk+M=; b=l/bQvXYQH4ChJX+smYlgd6
    Sl3PPDAX5K4MVdL5abcpWRR2gw3ZNOzYONPrrZdxc4s5pnbDzbyZtFhRhvjNNB+2
    9hAnxW477o9SA0Pv+08DyAa2dXQ0DnZ+Q9ngUnzmm115YkTODuxOrL826bsN/wEX
    fc+uwnA+VJkFy5JRmnue4/VGp+vYjW8lCwCw4tSfDkWzklLVYU1spbgYKQ87yVHY
    vApiQM5Bmt3uXQBZkBoisUX481oiVTBz84rWsSqHOU+KcHYXkJCj3VKF18ULq6Kv
    CB1QHELRNEwAUexWqvpmGU3yqBGj2W40XyJhlG3UN6+kWxkGAcr/sSOYBBfn7ISg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=We5s/Ae+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=We5s/Ae+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeCFSXc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:23:32 -0500
Received: from mail-sg2apc01on0120.outbound.protection.outlook.com ([104.47.125.120]:45036
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753837AbeCFSV6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:21:58 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus test
Thread-Topic: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus
 test
Thread-Index: AQHTtXf+ZtRiOS3OX0GDg2oNP2dLfQ==
Date: Tue, 6 Mar 2018 18:21:49 +0000
Message-ID: <20180306182128.23281-3-decui@microsoft.com>
References: <20180306182128.23281-1-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0021;7:5F5KyCw0LVnNMvnTDw4ii7VK3iFfa57r8dOe80azc9338BXTpqKehMrdTA55o22WcybMf1e4vSSSM7yZVUzUrcub+Kc1DV5f4PnNjJDWoltCMTKOSfrokErGENTDNIQWXDP+dh5Cx7EBEzh8xixW39sbwFQUtaUNLakwSAt9yGmp2jBPDWZErl6noYR3Y0AzBoMl1BHFEOMZPxcKo4qaCXP3ad5c71T7yYJOi68LdgG7YE9L51EzZUqFSF+606m/;20:WNhKS2JJ/41e8QbtH/SBQkmU0HUwXKXCSZDexqdM/276xZgGaHdq9C68sIo/v0ZjXmfkEUhVBapjzM+OO0LUxqfS43rXKWHeQzo+V0n6zC1ib8G/xM9xAVUKhU5UrVQy3aQlUjJMZP9dzdt3EEEx+H23QrCzcHFTlOBtkDVt6aI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e527aa9d-4807-4675-480b-08d5838f20fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB0021863AAB2BB601A9AA46D0BFD90@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0021;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0021;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(199004)(189003)(5660300001)(36756003)(22452003)(1511001)(10090500001)(2501003)(66066001)(316002)(7736002)(14454004)(10290500003)(2201001)(99286004)(305945005)(7416002)(478600001)(76176011)(25786009)(4326008)(86362001)(102836004)(106356001)(6506007)(105586002)(186003)(77096007)(26005)(3660700001)(110136005)(2900100001)(54906003)(68736007)(50226002)(97736004)(8676002)(81156014)(81166006)(8936002)(53936002)(3280700002)(6116002)(86612001)(6436002)(6512007)(2906002)(1076002)(6486002)(2950100002)(3846002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0021;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: uP+i4INQGxnqR55IglNFA0YyUS1YkUw+aUOVOVkqt45lkBbQ8gliln+Iyrf6vKOWk9125Z+Vxvm/rOtRjo05+94mV/pkUaG2++f8AyAI3vX1Z3rIw/tzB/x4yohwK1GzalkCSm7a2lVLmdQVyUZW/ASNuGr2u/32el5pL0UMcqrMsIgBb0B4PTqobXnMADyEZUL2BUw806UmFa4jtjUrBZvU/D5vNkNDdsZ9dIT2cMPr3AaURG6mJFk6k1rOhFXFVE+k1q2jOydzCy7vk0OLQ5JjD3qUPXaA+lw4Q4JF6csQsknlZaB/HHleYwbSibEy+g/88cClyoxosYo9W2/gEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e527aa9d-4807-4675-480b-08d5838f20fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:21:49.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When we're in the function, hpdev->state must be hv_pcichild_ejecting:
see hv_pci_eject_device().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 1233300f41c6..04edb24c92ee 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1796,10 +1796,7 @@ static void hv_eject_device_work(struct work_struct =
*work)
=20
 	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
=20
-	if (hpdev->state !=3D hv_pcichild_ejecting) {
-		put_pcichild(hpdev, hv_pcidev_ref_pnp);
-		return;
-	}
+	WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);
=20
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
--=20
2.7.4
