Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELu0xzSwKKU+zZBWl5gAnD2XzhebB/68JvPzBphFwpvq/nKIWO0QvqjFZpSMGREfbCIfPaiG
ARC-Seal: i=1; a=rsa-sha256; t=1520485193; cv=none;
        d=google.com; s=arc-20160816;
        b=C0U3lCS7venu6YSidqioDGLP1bfe2a29xS4wQfoTRtHDgy8W/i8Z/X8sL2yenD2hRs
         4jLIFT53xmNzY1OdY3YI6BJd9AVtt/0P2exU6wNvHi0m5riN+w1r5jqJJaRZcGy4dmwR
         ev58GU8l1qtrX9I8ytEudGfDs3tp7kUoOchDuA/sI5F+NkNyqiKEZUk76V84kvlrxnQu
         X0TBv+5p50SsKBKmt6f9h/2QNDq5WEYNFwSxcd2zYGWLQ6vPCYm5+BQrAR4XUTLoJ/lz
         /TUsPRIqFgU7S8x0LMifcuWkT7KyAKWvgyInSSVLB0WX0hqJX1kEQUHObAYNOiayE+cq
         GO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=UeNFVzNLnGAZT8iKZ99wlrgkFPz9MTFU/KtoJSv8POs=;
        b=s+hf0Vm3+lS3ncPqwGNSv4EEEoStJmSNtUquZ5PPMA2xSc0sh1nNTiTkPmuEhbjZh6
         rzVEYV8tRCL2/38FVaFrtYh4G3t5pmbM2aPKdBsddD7YxfOXNfE1YwmHRoa0azoTo9Zc
         7q3VJ0huH+L6bxVJr70hs7ZZ+z2ShM6sXLNzJJyEtWKOhI5bZi+5CFpPQxHXB/DxbnSL
         Tj5xO9GXPD6U8hkbNEIHQUPOwOGvqwHqZ/sIr4g1xgUKeMO5pFjpPUeZYliTh0sw/0er
         +phXezhzmZov3yTSuFsJA+dNoXB6MfBOjN61R+9/MV8A7caJmKAO7aTeon/C0N5U3axK
         POyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=k/4akz5h;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.105 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=k/4akz5h;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.105 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
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
Subject: [PATCH AUTOSEL for 4.9 002/190] usb: dwc2: Make sure we disconnect
 the gadget state
Thread-Topic: [PATCH AUTOSEL for 4.9 002/190] usb: dwc2: Make sure we
 disconnect the gadget state
Thread-Index: AQHTtpokoLy+kagVSka7vFFKiMmORg==
Date: Thu, 8 Mar 2018 04:58:47 +0000
Message-ID: <20180308045810.8041-2-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:J1O5R6pBAUR2LwBXsqlDUUoFByWY/fzkPHzAZ7Lgdg09k3UyH+2Nc4DYKjp28C88ZK4EKNFOODKVqC3PUv39snvQjCa+GZUY4UNjP7ZNcd+zs0+uHxvk59HGNGKOMLRl38b799Q5y17tH6umJoFFJMuiLRv2aYFbO1LPRYuek/jh2JQx75wsSP1f7Q4eqCEwTXQH+Pv59+GtIMy28eldXYEMjugWATE8WbxLPakDatuqjFA7LPzp4/KxFlb0TAuW;20:TfsfLdx9vxIqgLIyd1KpNFhojnKN9inP2yRi9VsHTGNs/PH8JKQ8+Z9Cpu43xno9dS/jUTSZuJwA8wAm+ff60KkzGbZbYWSqyYDyxUAS0bZKAbPcYD3/cOkUubTJXnRSUx3s4uKKuJmvJXPscfyFTeo4+7zfnSJy6UAKggIx+qo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb0b05f5-0e91-4718-4b69-08d584b16d05
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920A872FDC3375396073E52FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(50582790962513)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(7416002)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: vRcjc97Sv/1Js7Qz5CG3OF+0V6tLrwz8XPy3N8f0b2SYOI+dIJTu1Q+Xekim8WkWrqF/ottDxsJpEjRnK69InXQijYD3JeFMNOojvp1jYAUPLJpUwPrHJXWQQspAATRl6XFXwg++S6ruLdffUN/EXn7DUtO1rPsHJzxKlgiN+O4TLYve/ojE5W0V7GdSjXZvjW2XVvKu8Vw8n5JTEYDoECXruLrnfA8aXxo4u6jirH80CpaRVWS6mAVcHHAn215FSAuY0omvU0zuTndVJ/gfQHIarkjtuySzRCoBEjFHwKAdEDRzZVIGpMORraCqbxDJ/61V7O5JveExf3VVAYFEbw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0b05f5-0e91-4718-4b69-08d584b16d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:47.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344282249070978?=
X-GMAIL-MSGID: =?utf-8?q?1594344282249070978?=
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
index df5a06578005..dfc0566bb155 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3220,6 +3220,7 @@ static void dwc2_conn_id_status_change(struct work_st=
ruct *work)
 		dwc2_core_init(hsotg, false);
 		dwc2_enable_global_interrupts(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
+		dwc2_hsotg_disconnect(hsotg);
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_hsotg_core_connect(hsotg);
--=20
2.14.1
