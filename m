Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4+4pBUrj8lo+krPANza1mT6gzyjuqcVoZdCEt5+rHBpupZO6oFyiuds3w/1DoqkJZC8+06w
ARC-Seal: i=1; a=rsa-sha256; t=1523233654; cv=none;
        d=google.com; s=arc-20160816;
        b=QC2C2GQylJLMPNVhaykB6Dz5rz0CbjloVtjRjWup9+j1ulHZf3sRQKmMXu/W9DntS9
         MwHHkNuJGHEZt3abT/eSG8qmRckWUYmhClZcziO1B/tYA0B3pWzsXPldrjbddOtIa261
         KYL+xwhhjoUiMPzqurqADW/7KLiBGyK+ZWATp51zPHyWwfUMWRFxJM/Ip5ks3ygVhmN4
         J/E6zzmoZpvlZU7PSJrF56lIcVxlXxkKE5561QLejle80PejcVmrPfqV+qvdI+kDpVAX
         hdo3BR14pS1ID2hQU6LLmhuD1MznDQm21acAXDcsXAer4YIW3fQRChvvRNubSSRrGOJC
         g2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=i3Uct/sO1dm0VUJIpY76zyNh1CMAt7uU2Iw/G7AwWuA=;
        b=AfMInboKOqFEWjFQbbSjZIdhgv1wQPVvWLBK22tvhe4/kkVjsZGS57aRSICKUQQRMZ
         WWAgRw68U+GWJ4d/P2qhf3Sa2An71v2YD3JJfR5T0JJiUn+J/RWKdZ2OSBO4sZkkSCfu
         YuLIj5CPHIRup53GyyZbmCkd3eispzP774FuMbjtDe250NimfDkIdA4wqTVbEioV8kGF
         NUrkqHYX6o6FzvUdESG383N7COndrvp55s10sSCeoTbeI+CBMQdC8Cfd3o1596nAF9yp
         swQSRoZ5v/j2WfweAO9YxaiibQYoWlCEKZvlU9+KcnK65Tetk+sfH1QoK4Ml3RIbjuHZ
         q1yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Pdq2mqTf;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.110 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Pdq2mqTf;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.110 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 053/293] usb: usbip tool: Check the return of
 get_nports()
Thread-Topic: [PATCH AUTOSEL for 4.9 053/293] usb: usbip tool: Check the
 return of get_nports()
Thread-Index: AQHTz5j9qltw5EjE6E6sSPvK6FrM+g==
Date: Mon, 9 Apr 2018 00:23:31 +0000
Message-ID: <20180409002239.163177-53-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:D4YmKZU4/EGF3US2uryNXI6tGV1sA0Wpfunnyysjn58Q9+vIf8PBBxOhGBwvaagNlbAPGKKNUDnzCmOY+qKLQEsKSMp06NjkhziJZn4Td1qx5z95BjDb9eASQ6UaDM8Hy4L+TxQz7ZeqReP8qZq8w1CJRdfUcqic30ldIjiv+8ogzPMNDFiFmcG39M1tUabbO1RVCyvAgVlZks1veDdem/AzHud2eLs5mIlXPw8bpdPVuoctf89vLlYwMiK3G3P5;20:+bEEzsPwpLJB6acWlaMZwVLspdg+L6kzphNvcevyYeKpgkkMwu370K8NTBMK5GuiEiVTq+zuaPblZTr2st6DrvBq6F/LcW4QLh6LYrogvqlXBTZD2P91IybmTysrxKe1W8msC1Cht4+TfI+N63auylIcjoi61vi6AFG8V//78pc=
X-MS-Office365-Filtering-Correlation-Id: 37de367e-2d58-4684-469d-08d59db0af18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08710C778D8840F60DD932CCFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iJX13IXwScBCe6VBTxrIfmIDCbyvucoB9SPoW8EaaPMKx4aAj1a1g2OvPmrIglVWnDzJTFWJ/7vaNuC4XKOmPO7lZ0EWPxsPaj7htpElsKEIivYB3ZD7OIzoCSb6hPo4nOGLD9zGumHI/4yBypNZqJUEyN4/t1o5AIuIVuAZcfBdtRXfk/7ybS57wqKiy7LsT148D/0aYpnqFFCd/DH5agQ2I0gRSHt5Obsboe6bW7en4mIxK3zFJUEeo51JKygsl15Cp84TV+aiHmNOFjLfbEquv4p8v4MlvlgTxN+lklkd0UDz6UfyKopsUYC++YmuKdEhBuTG5Uifucz0TVB717k+n+2bLt/ZWAdZMa+J00XoZxhuwgqsO0HJD3/GkB3RIthuBtL5i/hO7xghT+8CowlVuv3SQ80/uX+8BBIZk6E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37de367e-2d58-4684-469d-08d59db0af18
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:31.4717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226252461156417?=
X-GMAIL-MSGID: =?utf-8?q?1597226252461156417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yuyang Du <yuyang.du@intel.com>

[ Upstream commit c3509715fc9484a48b69a9f0196b728c960840c9 ]

If we get nonpositive number of ports, there is no sense to
continue, then fail gracefully.

In addition, the commit 0775a9cbc694e8c72 ("usbip: vhci extension:
modifications to vhci driver") introduced configurable numbers of
controllers and ports, but we have a static port number maximum,
MAXNPORT. If exceeded, the idev array will be overflown. We fix
it by validating the nports to make sure the port number max is
not exceeded.

Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: Yuyang Du <yuyang.du@intel.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/usb/usbip/libsrc/vhci_driver.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/=
vhci_driver.c
index 1274f326242c..c589cfbd1cfe 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -238,9 +238,16 @@ int usbip_vhci_driver_open(void)
 	}
=20
 	vhci_driver->nports =3D get_nports();
-
 	dbg("available ports: %d", vhci_driver->nports);
=20
+	if (vhci_driver->nports <=3D 0) {
+		err("no available ports");
+		goto err;
+	} else if (vhci_driver->nports > MAXNPORT) {
+		err("port number exceeds %d", MAXNPORT);
+		goto err;
+	}
+
 	if (refresh_imported_device_list())
 		goto err;
=20
--=20
2.15.1
