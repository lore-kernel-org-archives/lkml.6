Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtrqyutxRrBtpkcOXxMg9TJpjr+veY3ImCkBR+8JlqdKjTNWJGsOiVGQdM+njiokWMxO6o0
ARC-Seal: i=1; a=rsa-sha256; t=1521475804; cv=none;
        d=google.com; s=arc-20160816;
        b=Sn5lprVDbDmTbDVJvEIDQZRS2WxGW93LimeSohhC1uVrbBH/VsWlaBZAOA2BWGw5Uv
         DKMU6QY/Mdv+UMeTazVwDRXLMag2h6OWNubXTvX9q9fH42XBFEVHKuB6sn4ar8vix3hs
         dvJCrbLfJabTUz7ahLrnNfX319Peu7m+10CHn6iIs2hZn4e1S/82WPXF/0G7FbZmwOXA
         +AiQTLL30D+TTOMGrdvYqGXMbGglUziZBViHPnK9tNvLXhj3zbmv66M2zo3EOjcdSzAq
         oW4TjLlcraWIhkIIpNCYiA4+KdytxJ4p6N44AFbFG6rs1fmIkUNUsNN1dgDud2Gwan0z
         A4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=fFgb9UOPy72c6DPHq/4NhoTwipqdmus0Cv4Omm92jRw=;
        b=ts/HvZ85OkGLlXy7RPhW7JH9inmphE/B1TlyIwYCXVNiVqChq6A/pXV4FWUD8HOCvK
         yY8FSfuEyDyRJZnu/4uHmMBb7dFnZSDDfziRtzHTxgjzAjsSNwuxwtyK1W2mE1yYL5s6
         GWAm3CBgqqLiXeGWB9uMhSNwmmSAgVmcri6WLFkcJvifvp3h7dMRXOncFpa9awsSVg0M
         dXzhVotqaOfhe1HOdXKAgheQqpYKjvRA5nvktIjtoufGk2Dqmo7op3zf/uKMpVYV4J3Q
         NUkkxw9ut7GBvuAa8rr4B11NudMKnj+zhyw9f8jFRvsVpzCfTD+kzUYoqX0yHnoZZRr3
         9wQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=VvxoNJpC;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.128 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=VvxoNJpC;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.128 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 119/167] Fix serial console on SNI RM400
 machines
Thread-Topic: [PATCH AUTOSEL for 4.4 119/167] Fix serial console on SNI RM400
 machines
Thread-Index: AQHTv5xuAlYumOkc1kOEgtBzJ4EB0A==
Date: Mon, 19 Mar 2018 16:07:51 +0000
Message-ID: <20180319160513.16384-119-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:ZogAv2VLsydwdara/r+QlmriFQaF1vSDQMyT7uj+3QlMKDakUioy90fBNEWhR6VhvB9UQJID5BCCegEGN29GjKmxFrW/qigtm1UcvxvdCj++25lW5Jf+nEooDrGnZ2phEEacXuPN2+x/QWMQ8EXHyzkOKPMdWF8uskunyy1ioXfZCEVZZ4z+R7czmdkwu7Ee+v2WbpjTDkOmuP7RRHE72oSp7Kt0nkKloSSBiRE5BLyWMiSCdKFkEoz2UCLECdHE;20:bD4tGwT1MVAwwQNtAP7VnmSXAFsZZXwlB6vFHPBirXnsCduBeGqU1R7euiBURU1YT9CRSkXhE/xi2Zv7g8JEebRrja1mglKxIJQpkOzIbh7R1//eiIk97gHmshiqa/OY8pnTnsY18IK/1Aftp5BgDrida87K4hnz9c8x6SlaP+o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21cb5980-6706-45cc-7c88-08d58db3df73
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919A21765E29A2D1CDBC7F9FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: n2FLNhOsUD404rxARi4fJSl/31W6zFALSsXtz0e5Y3/he2s6K7d4+ZbCfEM8XMtL8IJd65gMaW4rJymy9LlY+G7F69/C5FBACAPwAVULiIAepiyMXudm/fgs/11rc6HTtlRxEmffnbkF+R0u62tSVohQsTELuatNN9625lx9+w9hugif708QxdQJJgZsOfoHAP9Eib6MFCt6nJYei33bpF+68vemqFVBNwM8lDSVcFbn5m/F9wdD+Ffj4QgfR82ikfCIwBUQ36yR9B2q2N4zl6EZuZCtrtVK69bjKgauU7uvkNGenPSkf8B18Xy9Rc5/SMDIW+oXs1CxdeNniO7b5A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cb5980-6706-45cc-7c88-08d58db3df73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:51.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382626228264600?=
X-GMAIL-MSGID: =?utf-8?q?1595383013132343780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

[ Upstream commit e279e6d98e0cf2c2fe008b3c29042b92f0e17b1d ]

sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
is disabled. Correct usage of clk API to make it work with/without it.

Fixes: 90efa75f7ab0 (serial: sccnxp: Using CLK API for getting UART clock)

Suggested-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/sccnxp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index fcf803ffad19..cdd2f942317c 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -884,14 +884,19 @@ static int sccnxp_probe(struct platform_device *pdev)
=20
 	clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		if (PTR_ERR(clk) =3D=3D -EPROBE_DEFER) {
-			ret =3D -EPROBE_DEFER;
+		ret =3D PTR_ERR(clk);
+		if (ret =3D=3D -EPROBE_DEFER)
 			goto err_out;
-		}
+		uartclk =3D 0;
+	} else {
+		clk_prepare_enable(clk);
+		uartclk =3D clk_get_rate(clk);
+	}
+
+	if (!uartclk) {
 		dev_notice(&pdev->dev, "Using default clock frequency\n");
 		uartclk =3D s->chip->freq_std;
-	} else
-		uartclk =3D clk_get_rate(clk);
+	}
=20
 	/* Check input frequency */
 	if ((uartclk < s->chip->freq_min) || (uartclk > s->chip->freq_max)) {
--=20
2.14.1
