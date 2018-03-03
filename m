Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELv9QIV0MqCg9TrUIChTUSvP9S3PlMWS2gpI2wo0r1We0+y/w5Sz00prV8xvD0lQdVVqjFRy
ARC-Seal: i=1; a=rsa-sha256; t=1520116502; cv=none;
        d=google.com; s=arc-20160816;
        b=0oj2glmd7+hR5ZIvebjXOGQGRSreMJY9/z258XiCje3STe6k3Pu/hDSio6wB7yAC9/
         RzPGEO7j5HTIUCXgRhoAUGPVG9voJfyYWpXopgqbhfDh4zdpYYiwnm2YLEL2Jg7ArXFd
         lC+CwTSY7q5cL6aOUBPBZKTNB1gfflfjMhaNRrlfmXdNTR5h10JOUbo7T2EIKhiqXWUZ
         bFN4I+K0r7wJi95wHmOoJzyxajHNogjns8JzxpORTcIjq2WmkEyqvWbh5c7Ua/Qvsdc/
         TJzWZ/3okepDQOVE1CW1S1aUisFB/Nk8om7yGEufWtl5CWQwGHNNyAe7Nn7M1hTQsEZX
         EJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=UeNFVzNLnGAZT8iKZ99wlrgkFPz9MTFU/KtoJSv8POs=;
        b=ADGwh0dreUeCo2cYRV4Kh72i5HYUjOmJzVuIlyU18J7dbvvndjGUxRpdhVuk0+SxrF
         LcAw3sXcz5QRrypFUMV4M7V6o2rAfh1bwWW3ae5MOh4rWi68N4ZjcbkgydyQoNCmshz1
         RIH0yFCjuazoz4hDRgkf7T+d3YvdSZJY2SYDwx/pT8RbKKJXheSP+Alexv23p+TwKLJn
         3CXm3Eq5y98CQKvTAA+PoxFGMHbsgD7B3rDs8yDfSj6GzXXG0wrH0Y6rCDIv8TrwhQ/n
         zsefnrAtHiO66YKZhHGBowyOMLbT5pKWexQmBgJ1nXtgCVQmq8V/jfY9HEiYqFL434+2
         lj4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=J1oP0icd;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=J1oP0icd;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.115 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
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
Subject: [PATCH AUTOSEL for 4.9 146/219] usb: dwc2: Make sure we disconnect
 the gadget state
Thread-Topic: [PATCH AUTOSEL for 4.9 146/219] usb: dwc2: Make sure we
 disconnect the gadget state
Thread-Index: AQHTsz8To43Ryqg2UUKTVqM7ngpDkA==
Date: Sat, 3 Mar 2018 22:29:21 +0000
Message-ID: <20180303222716.26640-146-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:XvUHE/DciNnp+gjNvfXbgJTk6YOzDuzwROK+wi+nSurSDfLnfCLEs/XSDlQN2Ru8Vuk83DDU/Lxhqq+mKuVB4ogovnOFIre59LXqfS52uOk73mcqXKBTxdqCuiBnw1EchjS8r74p+7sHmBKGIl4JCvdiGtvPkC8sW3I7akB7uipQqSZZH2RjPl5cPifnVI3icg0tVZd4Whncqiek1jpmUvfsuJEIgKw4stAO0xhDQAefVMyU2J/KokUnK49kFeSKEjr62l28EQYR8cEVGOPALALqIOwpSX/tO1UIcyRvjQhn3bp2mi0r9I16Du5qGyHJP5LHVLF+4xZCZK41AI0Dp5hhdMkKMihgZ7yqnVkHiuA=;5:LYIQg3/lVDW5lWKlelx4J9yX10Lc9dS8sIL5rsWj8nFlklWvd8fa8rc+UKKgri8eyAvfXDvkaV3azM6+a5olHggVk35oH+as9inz6YnHq7tba9lFYUMx+4cb8qSweIbDqp8l0KtuJz+vrh4DJhUSecIDzUVfsWIDuKfPAFt2mno=;24:K6kMP0zbckk1LyQayqIZjYyvy7stLR7gK2rHTh1hu9d3KxY6PdPwO876csWmMLW9qAkYtEzz8nwb6iiXTazlfMfl+pxj3tx2R/Q8BC3ZrKI=;7:GabDHMjIqA3jNHy4IJ8BAexAFjMS7geESMZg1/qvOXA5GweCOHDeVNmt7BguAvm3mo5hqMFqClLXEVelX1urbcKOBG0quy251iRxLMuaUJPPyuSNl85VVsXsyObyngOhdynpVka/ZsEG3/f5gUUBen95OIxwL5yw61T4k4iCpOkZmHOiACCg6KQJB8c8xShD75YvzGmMrmzmIaam4KPNqIsdYV0Ylpk+R9nzVecw/KImtpetcsXkfMXPibSz8lPM
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3539a92d-98c8-4b9c-560d-08d58156fffc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB092473BDDEB42753B26D79AAFBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(50582790962513)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(7416002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3539a92d-98c8-4b9c-560d-08d58156fffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:21.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957681971356062?=
X-GMAIL-MSGID: =?utf-8?q?1593957681971356062?=
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
