Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELv0YqTTZlcL1FDU5oBiGlcHgG346VS/nNAqedWPcuejqm3Ly5lWHr/25avT9w85XU6mYyID
ARC-Seal: i=1; a=rsa-sha256; t=1520116091; cv=none;
        d=google.com; s=arc-20160816;
        b=cEa69a1uh6m5xYFHdg6lzVXd8dfcg59GDEXoHi185aKm9GjIP3qswvPhMM02/3R0Y/
         sswQG4yk+hEO3RIsPlKvpDPsKYHGPFN+of/laE4wS9oF1ssfew/Vr9kOv4t59ZU8ej08
         50QOaUEAHcKoLX5vCKmZi2bwXazqK+6wy8GIqmBbrxvBhz8oos1OH5UjnKgDo3OUE22o
         U6OiHogZV10wH68JTw0afylw5W5afXEox+1kUONReeSQpVjAWy63KQgLejr+j9Ny6/W8
         JUkVmAkUlBI6SlV5olNmANKCiwpHlbqIAjDo0bSRDn9jjopnay5Of5GeGV+U76raXi+4
         jTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=R2uKdT0scM6V2TFPPDCRwGnG9GNDzmZIgK+H8lL/OAo=;
        b=SXTxTjFLPt3DEdnM9B9VUoJlyDqJIrUoLJM9UggeSHHC5yOsWvvG/oGsXx2eZEqAzv
         hTsLlSWiCz9XcTNtCwIuKXA/JXbC66yK/1f/oMo++9VIv2vIVc924s/ypUDSfy6dGTYm
         LrvdINHcXLMGLPr38uTRztX/Lmv9f1LDnJS0Xq3x+cAXh4Y2cUXTtbz5BdbhUZhupMrY
         4pK5aSSNnxUq203IejS32zVqJ83bXtbOx2KnlG2IIw6EfUHCn+uKR/r/kjCOuDK4Ii/I
         /nPil0DBe4xCFDjVDrcRGtRNKytX7+mnM8BaelK18Pe9YmckNO+kz3aaaigt3PCd9Og3
         bpsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Rf9LOyFI;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Rf9LOyFI;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 12/84] typec: tcpm: fusb302: Resolve out of
 order messaging events
Thread-Topic: [PATCH AUTOSEL for 4.14 12/84] typec: tcpm: fusb302: Resolve out
 of order messaging events
Thread-Index: AQHTsz6fXKKFZyvFa0SBwyRpWGeBQQ==
Date: Sat, 3 Mar 2018 22:26:06 +0000
Message-ID: <20180303222518.26271-12-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:qOcSAzUk9OO8gOR83L8kgjFGc/AdBTdAFNWGpTNK22K9SXaTqWeqzGTDliIM2RX8BKFwrNIiOZT+24ht45F+IeHPe+IguzyPiz7rIFUY1XOB9cjZwXbGn7MotVMz73KUqQ4uBTO33DNa/lIcc9Qb1NCEiyqBH+sc8n95fF5QDSjBje97SqBb1w1IIi50BEvRNdLMCEpmsQaAEfP12mW/fKc1QRrYDAjZ7Zm2V9GpexpRu5aYlH1Xs3cBzQCWn6Hv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30a21b4e-ab3a-4d25-85ba-08d581560a77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1067CCC8914CA2BAC63B53D7FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: FOJPphRfOvnwVR2xgqTS7z+h0e/oE0BT2lqlRwJDJABp4eqPocHuOd0PFQA0qlo5DiSZLW06frmtZ7e3OPVIHOqvFFhWglj7D4fapOGy6nbdPtjJ0V7Old9Y+UVG+sNnTIY60u7cUwcTb4ihV0LfN5pfoUhDId4mHRuRCqmW8AA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a21b4e-ab3a-4d25-85ba-08d581560a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:06.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957033615439792?=
X-GMAIL-MSGID: =?utf-8?q?1593957250232454673?=
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
 drivers/staging/typec/fusb302/fusb302.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/type=
c/fusb302/fusb302.c
index fc6a3cf74eb3..7d9f25db1add 100644
--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -1552,6 +1552,21 @@ static int fusb302_pd_read_message(struct fusb302_ch=
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
@@ -1659,13 +1674,12 @@ static irqreturn_t fusb302_irq_intn(int irq, void *=
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
@@ -1686,7 +1700,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void *de=
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
