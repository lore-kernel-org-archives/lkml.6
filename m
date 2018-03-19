Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474461-2-10155714057405661542
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
    t=1521474460; b=NOzFbDmkbE6p8QCyUqEM8mb0MuG08erb2fWzpazSXxBLvcE
    2KGtOWc3JMlvyH6tVJ966pyUwWxszg3ujahedDjTrmVdES5DZ9Wr0NV+roWs5hnD
    YJxvRmwHSVDGsgVJr5mjokeYYCctPdje/jP2BRN61EQ1qNu10LjfZKR6+inqnR1m
    EQySigeXYKlxcJwgYxat5stF511vDa3P43ViF6mERpukVBl1LXVpS3vGzRtjzY7w
    c91jVx8VXriJ9stgQBKnCOm3VWUejaizgq4zKW4DI5V2VxfX0RMg6A1GQAShvHUO
    aJ1VZbjedtINHirPtmDLKjFzjYLNqhIa4ivbjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474460; bh=wJg7os
    ykXt8sUfo3KLXzmuWZN1ocujbo1uFvsmjxeG8=; b=mIf5BeqpXzxUgioU3J1UXq
    4byQmYUIdifZRds5v9MiC9xwiJ/zo9W1GZzaxbX+EMST4fQTkeiV0QYmQMWc0hGd
    manytJYPDFDqsENPj5rs85F972hOEkQl3fUb8EX+GW0OHIdGkes0NzkaoGyHAb3S
    r+8VrQ0L5k4Pf5XGhRA1JgwL3xxdLIAZ7S8L+dlMQcJYZCDXygP0LBWNcJH1bIGY
    ahz3CBfa44EfI37DMN+ERnXy5spR78Uj/+xJQFER+IRQHXIONQZCfEE4ZwoqS69m
    /PtBmB0RRMGYSJtLS0HbGUl3UT8LsGnMPAxI22YcguEvAYENdLisofPilLGKrZMQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dUwgeDa+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekudelnecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dUwgeDa+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekudelnecuvehluhhsthgvrhfuihiivgepudeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbeCSPrh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:37 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:61852
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933449AbeCSPrd (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Al Cooper <al.cooper@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 024/124] phy: phy-brcm-usb-init: DRD mode can
 cause crash on startup
Thread-Topic: [PATCH AUTOSEL for 4.15 024/124] phy: phy-brcm-usb-init: DRD
 mode can cause crash on startup
Thread-Index: AQHTv5mS86eRPuMt2UisdWdJfqS3aQ==
Date: Mon, 19 Mar 2018 15:47:23 +0000
Message-ID: <20180319154645.11350-24-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:QelKr0+fZ6mAox0Q30HvvFN58Cr+CkgbmNRKmeNo8p/ApmRjHruKHej2BylFgvwDZhPeXCall5NN41e/EDv1YqI/IJNpjXrbuFsK8TTNqdzck6+E4iRkr6EGjnhyrT/96F9Ijgu9nLZS/PU5JRrF3TJ7QErp+YND17u0dXIMyZc9qokH2mGvSsMmIRvkhV8jVZvk/D+LQV4LhPA0hNxGNUAOg/6+IoLElk77dhPjOY4ihVjniiFiLpISH5fHDOuQ;20:JZtsI1YpzOG+btChAVMt5po7dKJXcmbsdEoQs/4v1A24NPMlJqQQMNaKw6aIZnnlVPlKF8szct0hU5PiKvID2EXkiW+Q6aWsx+x3i82FMrPd15hc979H7is1LWbHKOYKITQwl6WI1KSVxsucelMY8phT7P3uEMavcBiKUp2Djv0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4f38203-0991-4f16-60ce-08d58db0b7d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09988C81674A56FB109C23C4FBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(575784001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(39060400002)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3cC/hVifQRSDpYwFdKva4oXqHvQ1bpGgDmqKu+eUCpoD0YilOFA3tO29fp+pPb/F7Irkd++2XuTsdOwpVGkQ7CsNvuyROauHHtDWDL/eH+McwiYsX+w4Rt/rCCCeX2EqXKYr1NvFqrz1FTzTiWaRKkYvydl1ZwhwSu08G6G/msB4xq0V9515+4356q9UpnOuMaaQ0I4We3kJ3TxUIieGNdklERASIDnD5darzbpytvVuhrwgI/r6s6nzAsHCKORto/LMerkAOLnGusZvrMPlWqS+gtrxFL8iayOuytcPbwjV4uZ+b5mZdQjTxdazr329Eh4hMYl+cWxkgAlB/O4i6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f38203-0991-4f16-60ce-08d58db0b7d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:23.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Al Cooper <al.cooper@broadcom.com>

[ Upstream commit 0aa0c12262fd848c48448c39ff6c1c097be00dd4 ]

This is caused by a bug in the BDC core. When the BDC core comes
out of reset and it's not selected, it gets a backup clock. When
the BDC core is selected, it get's the main clock. If HOST mode
is then selected the BDC core has the main clock shut off but
the backup clock is not restored.

The failure scenario and cause are as follows:
- DRD mode is active
- Device mode is selected first in bootloader
- When host mode is now selected, the clock to the BDC is cut off.
- BDC registers are inaccessible and therefore the BDC driver
  crashes upon Linux boot.

The fix is to have the phy driver always force a BDC reset on
startup.

Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driv=
er")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadco=
m/phy-brcm-usb-init.c
index 1e7ce0b6f299..96370e61a000 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -926,6 +926,7 @@ void brcm_usb_init_common(struct brcm_usb_init_params *=
params)
 			USB_CTRL_UNSET_FAMILY(params, USB_PM, BDC_SOFT_RESETB);
 			break;
 		default:
+			USB_CTRL_UNSET_FAMILY(params, USB_PM, BDC_SOFT_RESETB);
 			USB_CTRL_SET_FAMILY(params, USB_PM, BDC_SOFT_RESETB);
 		break;
 		}
--=20
2.14.1
