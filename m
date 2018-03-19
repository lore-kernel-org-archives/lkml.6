Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497900-2-6287438643030423415
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
    t=1521497900; b=RCF4v18xe1yj0PGl5tRby4yTmxVgJT2px2w1HRGsiI6tuFr
    963I9C2pL86Z6Eh+Mb3aYu+B3EA0z2y+WkYmwnxRqC8lGphsu6T0901hn6dlLTiZ
    Jywvd/xwAyu4xgwCQb9W54P9Wpn9PjA2+n8ecOAb2wQouV814V/TbWITNMS0KJop
    vk9dkRMLe3wokKL8YbnW+U3dJpeiBhoV/s2Xm/M1KVczBy11LRBnikb7Hk4VV/lS
    OuGle/deCf3rfFNSPBNOC44RNOfwk0uXbkDpV4WpRYZoXzHTs4YN6+JeUgxwTKZZ
    o7KPsppUN9BtbNxzdrFn7BaFrwidMjGWs+oCZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497900; bh=o1uq5D
    x0CQm6bE7fIKdFhyqwO3CDbAUB8hhSE4bKgRQ=; b=GKGyL375CPNzrVE/iAC4Jp
    CMWXKfiFKP6KoAJuuTROy4DeW5j0Bg4h9rp/JLU7ekQznRqRMp0jP7sWU0bGfb7I
    +WyVZSZ3CK0oRiseSI5iqy7QUOWxOPkrxg291Sh+H3il+YbKsTQ6n3R27cBKvJZc
    TMvwkWYqiLXjYcYF0+2Fr+pSAMl7yks0Fktlu07L85sAHP0on9xR+hBmK2b+U3ey
    TJfDB7WGvdcYi9flJYq2WrIhWA+URMxvaVNGliNjuNImbxS+F5HbWgRFb+PG2YjW
    F1+ErrOgzrcra9DrN6XUssH+oGgkl4BEjcm2ez587m/O6F4x1BV4tGjOqkvk+0IQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T4DqXvKY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeejtdenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T4DqXvKY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeejtdenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933735AbeCSWRW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:17:22 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:64697
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934006AbeCSPtr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 094/124] serdev: Fix serdev_uevent failure on
 ACPI enumerated serdev-controllers
Thread-Topic: [PATCH AUTOSEL for 4.15 094/124] serdev: Fix serdev_uevent
 failure on ACPI enumerated serdev-controllers
Thread-Index: AQHTv5nD/wtkCbIRvEiH1m5dMI1GEg==
Date: Mon, 19 Mar 2018 15:48:44 +0000
Message-ID: <20180319154645.11350-94-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:stF2aFwLFByq4dVxorlldfGOreUXfd1BDyOcZMkQ4z72chOE0hJFWtqffiTRiuzo1iT7pC8Rxvf3OAv19XTNy5gSEC6WUorZs4CGal2K7/RlNsxbsMPTY4xX4eMo89Sn4/CkcE/mnObOcDfp8rZ0WVOC3J9TTcSfQxvBFdFaUU/flYwqbFNuTnyEDWu3KC7rxkSXtMvK6zQybS5YvpLJ9raP0+CsRoHEwUAoKhbLiCCsZtUODed+/VkjguR/VaXD;20:/mIj2MSHifOjnBJ0LY5rParAC/RGFVRW5zhuW67ZUM/z8SVrXpvPWid9H7lArnV76suskyQJc1WL/0oNJGHPTEZ+rn7H5RyQmcryLa9VHNCr3PTaPV4PzAnBFJ3t35EtzRXZKgRGQUw3p24fMUhwbR8erIya682XqQ9+VM99XI0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccbfc3b6-6681-450d-e0d9-08d58db10584
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09813D33F0905D33C7B7C1E7FBD40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(6486002)(26005)(110136005)(5660300001)(54906003)(3280700002)(6512007)(68736007)(102836004)(6436002)(107886003)(10290500003)(53936002)(186003)(72206003)(14454004)(36756003)(6666003)(2950100002)(316002)(6506007)(22452003)(478600001)(10090500001)(106356001)(105586002)(99286004)(7736002)(3660700001)(86362001)(76176011)(305945005)(86612001)(2501003)(97736004)(5250100002)(4326008)(3846002)(6116002)(1076002)(8936002)(25786009)(81156014)(81166006)(8676002)(2900100001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZvyM7YJrFfhlzEdVv9I1beMrmJkf42hB39N6GAhgbUi0OJWLKJG8wnyNIYFDPRBQLClShm2w3XDPDnAjNxc9d5O9DIySjbuVFLIsxG1PcUJ90LDLMfpxxuPTLeIdp90VY9UmwMdmzRb+fW5CEmgFpHhJ8reFFYCujuC+sAlHARfJpYVa42tLO39hFLckp9qb7T/e17OQusQidgHAZW4p4fS1DjDzX1vnaYXRjQR6aMLl3jP2AzgxlI8gXjfbVcCiohYIMmTDRXpXc66fKJ4CDxpzve2GfkxEo4aKrP2kIviQXHw7lze8FzLqiDoCO8XiYcen2mFk0EGyza7eFrBicw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbfc3b6-6681-450d-e0d9-08d58db10584
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:45.0012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7d09995dcb0577b4a56aad7f2bb56f28604e8f1a ]

ACPI enumerated serdev-controllers do not have an ACPI companion, the ACPI
companion belongs to the serdev-device child of the serdev-controller, not
to the controller itself. This was causing serdev_uevent to always return
-ENODEV when called on a serdev-controller leading to errors like these:

kernel: serial serial0: uevent: failed to send synthetic uevent

being logged. This commit modifies serdev_uevent to directly return 0
when called on an ACPI enumerated serdev-controller fixing this.

Note: I do not think that setting a modalias on a devicetree enumerated
serdev-controller makes sense either. So perhaps the !dev->of_node part of
the check can be dropped too, but I'm not entirely sure that doing this
on devicetree too is correct.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serdev/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 1bef39828ca7..571ce1f69d8d 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -54,6 +54,11 @@ static int serdev_uevent(struct device *dev, struct kobj=
_uevent_env *env)
 	int rc;
=20
 	/* TODO: platform modalias */
+
+	/* ACPI enumerated controllers do not have a modalias */
+	if (!dev->of_node && dev->type =3D=3D &serdev_ctrl_type)
+		return 0;
+
 	rc =3D acpi_device_uevent_modalias(dev, env);
 	if (rc !=3D -ENODEV)
 		return rc;
--=20
2.14.1
