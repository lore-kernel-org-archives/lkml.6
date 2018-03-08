Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELs/hmxwQRNTd6Td9cC3M3yLGl2+s2mGNdMAZrDB8FSzPE6GLc6CJoM9eejl4kdtaIGrpq8k
ARC-Seal: i=1; a=rsa-sha256; t=1520485505; cv=none;
        d=google.com; s=arc-20160816;
        b=QUMpx+28pzDpZyrqZotlOdb4TKRJ8f5qE8rWtHra287D8dBrqczaPE1iw3/7kHgHog
         NatXKR+0UJ3cWxCPrAzabP/N+UFZ8nnglUQBbqQt+SA7u5Ox4Oeis6VMVpxhehvm6suq
         wm3kFRiYzpIeG7IuAnx6KGkMnfSpsybnCRV4ZSls89x+6SSaHMeDMgGOnWrpXiYzd/zL
         oRghuQV1GK9U90p2FiyFGPGN7GLeJVo+ljfWMFtjal4+ZGs8rxJ0qnOabTdtQeBavcTr
         eIa8eCdJ/FJBJQfsopSgPwNMCpzRvjWKeKn2T5nfWWCbSt22Up8m/piAK6Aq/VFnrJEk
         /0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=TzAPGmNKMMGBvJ9+kDIZDy6948Pq1oUGymC0IPsj4WI=;
        b=EkkqGshqKMT/iGUyN/XZ5Tvup3rjFW18pXhdjI1ARCjGvDlmijxJvRXuOvLBJ8rEUi
         OCp2KK2iMW4YJLLBlYtANhzUSFsHJhVxEs9jta96xFws1KI2qshb+XSRoVsBWCO1ZLNN
         g4mUwOfNBqnVKwqi9ejjxBrG45A3FqakwdtSKG8Tn8YT742lNHVvI0OrpIMFyTMuRm4o
         Wybz6Ugqz+n4jGdEZ8k+drTWJEeG9XC0AiyTCAmZuQdnTGIDatiWU8D57gEgcW1YdpmM
         5/NS0euSZXNACQD1zX4dNqAcQ683ZxYh1TZbpew0JLKPL2628JWkVbWfRNqvDh8Qyn8L
         gbiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Cnn4ffEf;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.93 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Cnn4ffEf;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.93 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
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
Subject: [PATCH AUTOSEL for 4.4 001/101] usb: dwc2: Make sure we disconnect
 the gadget state
Thread-Topic: [PATCH AUTOSEL for 4.4 001/101] usb: dwc2: Make sure we
 disconnect the gadget state
Thread-Index: AQHTtpp4PSxFJnxF0UW0CSuxCwf8TA==
Date: Thu, 8 Mar 2018 05:01:07 +0000
Message-ID: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:ub9P3eiK5uXSXgM9DlsnTPVVQ5sjfdT9abj4dY75+ELAMvL8aewIQj5NO9BGfNb1IxHHYPAfxaVVAEMje+gKzytgmpWIw5x/zzEN99dIno3kq1TEbk8X1uC9T7bTkseisnU5v2+cjd0yuaZyxkXVMBIllTH40nkPX06QJwkwbcuaJDcuU/5DHBDcSZkQ9bV6GD18k+z25lQOQNgqnL8fyQz66ja0dmgIUk5lZ2eeYcaShpo4RDvJDgMEfqNF+bcS;20:4JnEC2v3MTUZoGHloYrRXnFjdlpVdNPm4G7IsDoe8KT1/qKc7NyWMxdCPPyD4qoQ43Q82v3RTFpkp+/QGp3VjLOgSW0fhsP/9jZaWE4H+cKA7tvPYtU3nIlC8EuS19eFeApgpskO6iIV37NtysJglpB2iTqMJUJpBkAWgGSramk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85094276-87fc-4d81-f433-08d584b2268e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981FFE4061BB0A7694F8178FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(50582790962513)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(7416002)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(575784001)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: OcLlqJ6fLdQbrparQjP7bZMfI3dz2YE8uZvLsQkbRiDaRHkZ6dCZmaMbXFAFWq1sFkJiGwflapAgDfr3AQBKefkX0+316U0Qp85V0H9GjkSNhh0S4bP3a1DPlEY309a74B71u/ExxOJxs5iuZgk/JGR0Kv13WxIilhsmxKMQ0/jkh9p7h4Wme+fckbPcLnA3DUQcMJGvsGxkwSkiL+VgQFMEBOIA4jdqhKcxR0H1KXxo6PM3EZrHLP6UVzAUzCC7Inv+N/qxdaIzIkgt14BjpL0AGY58pRwx3JlKjLOiikUIKHxCLJ8tGWT2jCm8QAq4kuXtBuMb5xvtUTNeoL+B+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85094276-87fc-4d81-f433-08d584b2268e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:07.9344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344282249070978?=
X-GMAIL-MSGID: =?utf-8?q?1594344609612639520?=
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
