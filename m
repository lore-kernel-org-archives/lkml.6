Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELt5elbEIO9dM9Uu6Qm9qb5u7jw7Syx0yXjPxfhLi192Ms3eUlPgVsK92xaR0QFprstYDJ8Z
ARC-Seal: i=1; a=rsa-sha256; t=1520115884; cv=none;
        d=google.com; s=arc-20160816;
        b=KhYz3axD/w2AQfokoiNbep4ci0UMTRhwuyNyadEOL1kr+OSVVk4SPU78qw0lJ3StmN
         K4qkTsA61ppWguksH3/FXZoncAourR+xeNd5bPpWyRJ9SW1TeStZ8eNs9VTWaN6uTdSQ
         tsnaJ90xyqWUuYBKZR/w85d2SsGmlK/WZWzOSsvDmtq7MCo8wQovyXmzT/68CqF0v0wj
         or3g1DPjLVpGa84DYsd9CS6b6t2f+YRNq81D60fGc0Pd/cb4cnL07Z/oiDWqsLwgmh55
         4xZK8S1E0W6TYAyAun+cdFmaa5UfNOcZF+V1YZTqhpJ3vfeMBJemT4JkhWcihCqehVhQ
         ES9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=ZHp3Yx7QFTAq8/8JoAHlkhkxm2CxfHY7q91C4FU8kNs=;
        b=hPCL4ER3UXMMLl8Y6zchV61ZSPaCNFsVgzU1fvfDG1Cb76kmCA+BWraYqCQZqJ0cnQ
         4CivbzFaOjRXclLVDnV2NlGdjOpFTN90XkOrRg1jWPkXF2DnZPP9TStpk//X0lSfWzpL
         obFDAyfaHiBNfZmUsCqOokD4/syGAXlWYeX7i3DxDO5jlTaI7JP+WbYgVIz9/X+xZBXx
         Y0U0zG/q2lE4ZoUR0ry6nLqkKRJlPAeSV/1R94TyHqCP3MLVe/AUVqCPAruxSUnuMoCq
         65ElYy+ZNo3GdL9Z92gjHtEeGqbYKGGXUsQvFX/Ff1llM8Kk3DbVqnCCOzkWo533ml+U
         rXVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=UUr9QUff;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=UUr9QUff;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 016/102] typec: tcpm: fusb302: Resolve out of
 order messaging events
Thread-Topic: [PATCH AUTOSEL for 4.15 016/102] typec: tcpm: fusb302: Resolve
 out of order messaging events
Thread-Index: AQHTsz5egAOEbVMGSkeFD45WhIS4dw==
Date: Sat, 3 Mar 2018 22:24:18 +0000
Message-ID: <20180303222318.26006-16-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:jpyeqFttOH9rxjnVPXjf5QslhTJunvg3ajMhBkhLmPIDyAzCRvrVtYhcjWhD6BcuQiNTpceRYE+F4sZfnWxeYNHcMNetyfPQmVVruEm3oFBUqOFa285iyJeKkxBRpAB78VpAbWsQ1h/MMYdWm9gNbFCiKURRR2FVuV4KY00QLEQT2evFmcAzjosJRfIUocZx0Bt47mCGHa8SbaVSOZyJKz+txiFvvO8GkqVtiajhyJ8ljgwnDZ9Or+cLNGFtv5+4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38f5a3d7-3832-42ee-c238-08d581558f91
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0890DAA087928FE9F6F0D097FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(59450400001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PVQ3m6amU2NX7PMisMEtYcCI406B+RW1wTKgz9j70fRQAr7ouwKcRuxO+Yov2kkI4kVMzTaeRby6D+uwxL5oHrNXOAwOISOwz9mpvoICcWNhGqlY4H3y3Q/rZMv6zBCPSniMn9MZKDyvDoiRU7Mv/L8NH8k8rQgK4n1iuYJ0Jvc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f5a3d7-3832-42ee-c238-08d581558f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:18.4159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957033615439792?=
X-GMAIL-MSGID: =?utf-8?q?1593957033615439792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

[ Upstream commit ab69f61321140ff632d560775bc226259a78dfa2 ]

The expectation in the FUSB302 driver is that a TX_SUCCESS event
should occur after a message has been sent, but before a GCRCSENT
event is raised to indicate successful receipt of a message from
the partner. However in some circumstances it is possible to see
the hardware raise a GCRCSENT event before a TX_SUCCESS event
is raised. The upshot of this is that the GCRCSENT handling portion
of code ends up reporting the GoodCRC message to TCPM because the
TX_SUCCESS event hasn't yet arrived to trigger a consumption of it.
When TX_SUCCESS is then raised by the chip it ends up consuming the
actual message that was meant for TCPM, and this incorrect sequence
results in a hard reset from TCPM.

To avoid this problem, this commit updates the message reading
code to check whether a GoodCRC message was received or not. Based
on this check it will either report that the previous transmission
has completed or it will pass the msg data to TCPM for futher
processing. This way the incorrect ordering of the events no longer
matters.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/typec/fusb302/fusb302.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb30=
2/fusb302.c
index 72cb060b3fca..d20008576b8f 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -1543,6 +1543,21 @@ static int fusb302_pd_read_message(struct fusb302_ch=
ip *chip,
 	fusb302_log(chip, "PD message header: %x", msg->header);
 	fusb302_log(chip, "PD message len: %d", len);
=20
+	/*
+	 * Check if we've read off a GoodCRC message. If so then indicate to
+	 * TCPM that the previous transmission has completed. Otherwise we pass
+	 * the received message over to TCPM for processing.
+	 *
+	 * We make this check here instead of basing the reporting decision on
+	 * the IRQ event type, as it's possible for the chip to report the
+	 * TX_SUCCESS and GCRCSENT events out of order on occasion, so we need
+	 * to check the message type to ensure correct reporting to TCPM.
+	 */
+	if ((!len) && (pd_header_type_le(msg->header) =3D=3D PD_CTRL_GOOD_CRC))
+		tcpm_pd_transmit_complete(chip->tcpm_port, TCPC_TX_SUCCESS);
+	else
+		tcpm_pd_receive(chip->tcpm_port, msg);
+
 	return ret;
 }
=20
@@ -1650,13 +1665,12 @@ static irqreturn_t fusb302_irq_intn(int irq, void *=
dev_id)
=20
 	if (interrupta & FUSB_REG_INTERRUPTA_TX_SUCCESS) {
 		fusb302_log(chip, "IRQ: PD tx success");
-		/* read out the received good CRC */
 		ret =3D fusb302_pd_read_message(chip, &pd_msg);
 		if (ret < 0) {
-			fusb302_log(chip, "cannot read in GCRC, ret=3D%d", ret);
+			fusb302_log(chip,
+				    "cannot read in PD message, ret=3D%d", ret);
 			goto done;
 		}
-		tcpm_pd_transmit_complete(chip->tcpm_port, TCPC_TX_SUCCESS);
 	}
=20
 	if (interrupta & FUSB_REG_INTERRUPTA_HARDRESET) {
@@ -1677,7 +1691,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void *de=
v_id)
 				    "cannot read in PD message, ret=3D%d", ret);
 			goto done;
 		}
-		tcpm_pd_receive(chip->tcpm_port, &pd_msg);
 	}
 done:
 	mutex_unlock(&chip->lock);
--=20
2.14.1
