Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuXTLsSRcsOWvqEAWE+Z0PClUn4RbPRHjRQ4IwbSuiUuLE6W+yFebQnzMcK2jV9yc9Ie+y2
ARC-Seal: i=1; a=rsa-sha256; t=1520116321; cv=none;
        d=google.com; s=arc-20160816;
        b=q3Q51kjDwsDQGb7kgzwa9yluonKlWUhDllNjhLbLihytrmsVicBHtEzctLX2/nzgpt
         qGqwIIlAglbQlmXBNuRzSvjmjAQmOtgYXGCQTdPqy00+xq6BbHx1GccokJS5zyf4oeYH
         6gxTaCV5m2v7X9+VfJ2JvXJRZiWRIBQ0KyHV54LLQQLbIjJL0TeO7AH2vze9w3Ngoj8d
         oBHwX8excEksfqHniiYXGBhWWnO3Wo+aHI5+Mn0L0Ahbk3k7bBMXNPg2lvsV6R9xCHKK
         wO6oUCzH5WfYZhi5oNQ9nM1Onrr2o/kUrE8VRqkHEP4ukMzxTpKXnwpoI7E9Dz4w32QH
         +Gdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=s6dAP9hG+P2HMsg3j2bLM3fvF+/n1B6XB++o+wDBJzU=;
        b=tcVCqJ9Y5Mgbv1Zy7OmXHLWuO4r5XLdXRLlFLWJ32z0xhEqg8YBT3xXnlDA47GLnxZ
         hTOaN3p4aPOAorYojPuMD/JFgKsOYRsPVxj0XHoxD1UKSkprcAPolPlMt/PFzm14H9rL
         JYdqIdcePL/yhh2os1H8w+P6LtExIrPuuOTwOtB7OBlsEEbPt4d7pPNl/Nb1TLhmIau7
         rZi4qFzK2IKKriExZV33a2uQ2JNP0Sz3ftzgaz2GolM5vRSsnydRxd/781kOBEeQ6qAL
         JFWrMHe0cWmu/ubaGDIXWBiBHu+CBbA4/fQmHV0UC0dI/AXnPk1UeInmLPvKZVZeaPgv
         ZVjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Pia+mdQR;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.102 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Pia+mdQR;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.102 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 037/219] usb: misc: lvs: fix race condition in
 disconnect handling
Thread-Topic: [PATCH AUTOSEL for 4.9 037/219] usb: misc: lvs: fix race
 condition in disconnect handling
Thread-Index: AQHTsz7tu90qNEAX70+11JG9xgJMiw==
Date: Sat, 3 Mar 2018 22:28:17 +0000
Message-ID: <20180303222716.26640-37-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:/qySnuNL+PPaARtOO+1ycuy6fxcLVDHw53k3yLGfsVoikjpZ5aSAiuMFap3jYne3TUzyTD2F4kedgVxQPFnuNa3Cl1sqtV1ETADrnDb1t3YqAy2Xg2byZscAlONUVmDMN1grgRbO/Ks8cyuPZSMzCJbEEy5KyQLL/0t9nkgMEvizGueh1PyQalwNZRfdvUHUZuFPpnMSTrNR9qM37GlPxqW6hMje9FRWWGD9w+FXqbe+6p6u0x0zOnFYHNhpSovq
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de6b8d06-2659-4bf2-c669-08d581569422
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB108331FD61FAFFC1EA794B6CFBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(1076002)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cjUl/4dN91QyCPpbhSS7NWOQrH8Te4ttPxmsxe5x2JLIpwWz7/p0C400bcZT2IVDILKE9i5hmnyTpUvp1vCO0BOyh44YiZkJVFetE5yEebBvFWJlyLj2+rSpkzOM78bZYvcNhsMJ9apT8B3PwPiBTgl+7EYFDjCokfWpUUvi+BY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6b8d06-2659-4bf2-c669-08d581569422
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:17.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957491260419814?=
X-GMAIL-MSGID: =?utf-8?q?1593957491260419814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit c4ba329cabca7c839ab48fb58b5bcc2582951a48 ]

There is a small window during which the an URB may
remain active after disconnect has returned. If in that case
already freed memory may be accessed and executed.

The fix is to poison the URB befotre the work is flushed.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/misc/lvstest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/lvstest.c b/drivers/usb/misc/lvstest.c
index d3d124753266..bd6e06ef88ac 100644
--- a/drivers/usb/misc/lvstest.c
+++ b/drivers/usb/misc/lvstest.c
@@ -433,6 +433,7 @@ static void lvs_rh_disconnect(struct usb_interface *int=
f)
 	struct lvs_rh *lvs =3D usb_get_intfdata(intf);
=20
 	sysfs_remove_group(&intf->dev.kobj, &lvs_attr_group);
+	usb_poison_urb(lvs->urb); /* used in scheduled work */
 	flush_work(&lvs->rh_work);
 	usb_free_urb(lvs->urb);
 }
--=20
2.14.1
