Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELv5cAWThJcEx3ZZMgogUPbqEFs+rJQBYVM6MT3VjPjwZWFjh3p5fqIzww2rLyNJDriQTqAj
ARC-Seal: i=1; a=rsa-sha256; t=1520116803; cv=none;
        d=google.com; s=arc-20160816;
        b=SXApF+jSmZ7AAkp9GuZlLBu7xpsHDTzrhuBYx9eDq6axYQ6OzPz/yx5xPwZauSNANv
         t4cX2K1XaICcQgpNZK2Sdl+h3zU0Pftnx57RGCJ6j3wOWMMlBaEfnHTiqxM2vfQQ75Rk
         luquGs7r8eZH24bzrLyKURmwTvAA/wcWT04kQcqyvkC8o4xR99+VZSCpzmxvM++Gupgm
         UKh1UGtRJ/p/VMs0KhPgDbUIzyoOkp1VhtPNWn+AyVQLx53jewm3MVjbVoaq4vX796EW
         PNuhmHAL3FQY6gDV3KReblg8r3jEVCdFPVu9tX/GMuZGfU/M5jObTceHghp+ympw2yYM
         XZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=TzAPGmNKMMGBvJ9+kDIZDy6948Pq1oUGymC0IPsj4WI=;
        b=NMYESssroWZKBFH+Uk0ka7WVaK2xB/zdD5UEvZVD6AAxMntOK2dk/WuzN3mOQ0uykk
         ph6gLd7fpzthurMtRl//pbfXa8b/yyItJsbTBJiS346bVfP/f7FS580aTc3ZhQradeRD
         LYO3zmXLyhgmJLpJ42LPpdYwP7HLUnTFGxFgnTqRGbs1ppQOLHWYP4NTpVgsItgnK0dJ
         oAV/YPLsfEJetGlh3IOx6U1leNOmkcCpvxldvPMyLIJWd+qBC78/bWd9Vu4citCRIg76
         9etJoB5GhHy/7cPpgjQpErmbWhmu9Nu6RnLKtdvNoNfgpprqR06W1t/2nDpwPMzQAamc
         ZheQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=IOBdTu7w;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.94 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=IOBdTu7w;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.94 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: John Stultz <john.stultz@linaro.org>, Wei Xu <xuwei5@hisilicon.com>,
	Guodong Xu <guodong.xu@linaro.org>, Amit Pundir <amit.pundir@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, John Youn <johnyoun@synopsys.com>, Douglas
 Anderson <dianders@chromium.org>, Chen Yu <chenyu56@huawei.com>, Felipe Balbi
	<felipe.balbi@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 073/115] usb: dwc2: Make sure we disconnect
 the gadget state
Thread-Topic: [PATCH AUTOSEL for 4.4 073/115] usb: dwc2: Make sure we
 disconnect the gadget state
Thread-Index: AQHTsz9hy/Z6R3PvHkiHHXeka1Ap+Q==
Date: Sat, 3 Mar 2018 22:31:32 +0000
Message-ID: <20180303223010.27106-73-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:73JIeeyrMm+kmpvXy44P4ZCjRBE9MqZ/fWQYAnQQjvoQQh2F093BqPtb45/KxYEgA7tubCDjBppMpqkgjac6+3+uI6xNUmfVKIH7uJPgQcNhE58Chvt9U0eIS4o/bFIUYGy293pfSNlk05Df03sDcIDQ98LHi1HwA8vyuNMxHUrg8AzBbla/Nd4Sif/UHSwrDJtW2g44VarfxByGtDcnLbm7P94jn1IptYQNFJgHa3pt5kbvdbHEm9Qdw+nZWnNv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a11f144-12c4-4aeb-79f7-08d58157b213
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1033104191F1F5404984B784FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(50582790962513)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(7416002)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7wobwU38L8Gx6jKtAxvoq3ScRLAL9czV981wvhBdk/X4YVF1LQsoSK7nFsiQFXjySqT4hmptkBfJFPeMIIyN/IpKyng+6hq5xgdNYC9Ar+ai8xRTHQLUGZTyUT6X06MQFC3kHGqMZYn1Hi9c6aQvX9oA0MqowfHYl/flhPv7Q4s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a11f144-12c4-4aeb-79f7-08d58157b213
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:32.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957681971356062?=
X-GMAIL-MSGID: =?utf-8?q?1593957997423416241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Stultz <john.stultz@linaro.org>

[ Upstream commit dad3f793f20fbb5c0c342f0f5a0bdf69a4d76089 ]

I had seen some odd behavior with HiKey's usb-gadget interface
that I finally seemed to have chased down. Basically every other
time I plugged in the OTG port, the gadget interface would
properly initialize. The other times, I'd get a big WARN_ON
in dwc2_hsotg_init_fifo() about the fifo_map not being clear.

Ends up if we don't disconnect the gadget state, the fifo-map
doesn't get cleared properly, which causes WARN_ON messages and
also results in the device not properly being setup as a gadget
every other time the OTG port is connected.

So this patch adds a call to dwc2_hsotg_disconnect() in the
reset path so the state is properly cleared.

With it, the gadget interface initializes properly on every
plug in.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: John Youn <johnyoun@synopsys.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Chen Yu <chenyu56@huawei.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Acked-by: John Youn <johnyoun@synopsys.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/dwc2/hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 571c21727ff9..88bd950665fa 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1385,6 +1385,7 @@ static void dwc2_conn_id_status_change(struct work_st=
ruct *work)
 		dwc2_core_init(hsotg, false, -1);
 		dwc2_enable_global_interrupts(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
+		dwc2_hsotg_disconnect(hsotg);
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_hsotg_core_connect(hsotg);
--=20
2.14.1
