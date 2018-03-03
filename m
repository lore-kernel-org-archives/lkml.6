Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124303-8-5352810583094893903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124303; b=NLKAD3i7nqtvTa/R9xaeNj5QUnReXYgH9YddZivDPreYgL6
    Js/Fwlqjy8P4Rly3meFhjLpzVKUtpn6/EKzWHX4/oW9KdpGi8pkrubdlbSmkBWRa
    wYlqE4qHd4ia1giO5CsrJ9F8OAyHyqm5ozmSWjA+tztkbQjaBZgoYbmhsnp/2L8m
    xc1/aXf8DYBhWq3Y2uw6EhasOyxJ5tT9+3gJpmG81ACmahaAFgrOYdSEZyIYqUak
    8IYzvb14J4ymHzuR0U+RX5m9yiSGELL17Ax45uFzMPwbbGItf0hF+rHFJOO9DJHZ
    rRadzfK2Gg7uf2PfgrxGnvFvmR85qf8/uYsqFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124303; bh=MDHLov
    KBx8rDhZ3tyLCfM6PshzyJseha6NaaiGE2pr8=; b=f+ExQPakB+E3MbS1p4R+9a
    FXex4AMNh9p0esbGDOpld3NXJd+93/W1DBVs32IBjrLO+jR/5XACyYtefsrmtX3R
    ymXmBTHAJZl8f5B2EVYGetsVa976eqEEE5IyDKiGtJHqt7lEzN7wZLn+vAW18cxk
    KHLaOUbqrc4nez6ub1iRGsFvk8PJ3Pfo9I3wEYOv8XuR89p8wLtEdrVnQd7kwZOJ
    PinanD7NpcXQdUWCLWOVbgjnoXKoh8tJY3z0r3zREmCnGJVxFa1p0+PzVQAHJMbu
    2vqZlR7XpXatKK1nucezxSZca6BpC562TPG576O/B8zM7hnsHGaPV9gIL9wBPxrQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aSDDPdHs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aSDDPdHs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbeCCW0E (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:04 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932524AbeCCW0B (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sunil Goutham <sgoutham@cavium.com>,
        cjacob <cjacob@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 034/102] net: thunderx: Set max queue count
 taking XDP_TX into account
Thread-Topic: [PATCH AUTOSEL for 4.15 034/102] net: thunderx: Set max queue
 count taking XDP_TX into account
Thread-Index: AQHTsz5l2P3B4sRL50qBh+7julWnrA==
Date: Sat, 3 Mar 2018 22:24:29 +0000
Message-ID: <20180303222318.26006-34-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;6:9c/PC9ZhtsCsp/cZzy1f1cwDt0mRuixeBtHcjEFwdrV6C++qbg+HV5JxAIus91Qivjjy5HdsGJxV8PSnVppYTrO/+LCDcwPAotSPeCMpk3S8BiqHVsU6vdI6GmHetlNsW++7m0pb5B1IPfOsHYKldIPxGvYuj6h1WbxVAf2D5JgjU9WyqNyZV/g5lsxlTcdQmqpwNzV3aqTevSr+9z80SqCafBQwg99LmzQCsA0Z1XLbHeBqOC6X0HGfd0h/JE9j1GzYJK/mMHuquEx+Y3dhhmyLxiv3bHg8aC2teF7ifCIQF4OVaLisAhGZsApTx4lKfCjZR5m8pZtb7tQMXtMhtwQWlP45OpP0sdzlrjtGwTXwgh30LSIu99XDmrUmGNpH;5:9m64PisRKWMuw5yMv+s+JXH56IsjunTzyekfGpcRZwjBoJwYxSvxvnPLCNGCnryuEd3+TMymRHMvdTW8Ta4yhUHInZYD0iGicJ3O45gbu3/v1Ec3t0VwJ40jiYdB3Yza+TmZbyJWD7Cu9HKcWT9rz+fXPfO0baYWmE69mtDs/GU=;24:TJigcdR26gSComlCT1/EjhZMCLBpbnArJ52+Xe5m9qTsa1WQck5ID+CKGQchPz5Gb/wWY2oN01hGzfbETRRSK3floVw8rQPn/qMh1/fTvhA=;7:24nIdvoDkl2Y8Fi6q63muJjpubO1ahIABx3UkKXdEjo9Fh8aIDfjHbopakqT4Rrs0bwix3OFixsdTRIJ5aGr/mS9LCcaw/H//0VMGsEL1lqUQXOUGT0bjQ7G5TZRUH46bjD0LMWZ7w51+9254fBprBY3Sq0wqNt12BBVSpCNb4mgQITL0lZSXgAqXiSRdnbDkYVrGNbgFwn4c4f+Ig0o+T7uGrClPTTXeSakGV+APGSoXqjXnn+1Tjb0gULQugMx
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c888cd0-6e01-4eb2-0e0b-08d58155bd39
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353B6789FFFEC0C31F0C064FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(8936002)(575784001)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +kfZeX/94IbHGZ0ZLlk0Xf45C5FdAl+Flyfd51QXLU2tYqdx8bAbtG1jZ22xCKUZ6rlw2pIU/EePuFAaPOtmXRsDY96ABQzkpIxiK6ywtc6R6gNBIOdMvYIe/kXnsnMY9NqCJrUuPHe+59tfaErjV9jFlLW4+YK8YULR4e7W3YI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c888cd0-6e01-4eb2-0e0b-08d58155bd39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:29.3221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sunil Goutham <sgoutham@cavium.com>

[ Upstream commit 87de083857aa269fb171ef0b39696b2888361c58 ]

on T81 there are only 4 cores, hence setting max queue count to 4
would leave nothing for XDP_TX. This patch fixes this by doubling
max queue count in above scenarios.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: cjacob <cjacob@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index a063c36c4c58..3e6286d402ef 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1833,6 +1833,11 @@ static int nicvf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 	nic->pdev =3D pdev;
 	nic->pnicvf =3D nic;
 	nic->max_queues =3D qcount;
+	/* If no of CPUs are too low, there won't be any queues left
+	 * for XDP_TX, hence double it.
+	 */
+	if (!nic->t88)
+		nic->max_queues *=3D 2;
=20
 	/* MAP VF's configuration registers */
 	nic->reg_base =3D pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
--=20
2.14.1
