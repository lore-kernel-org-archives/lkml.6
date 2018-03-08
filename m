Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtBprT8arf8RzgeMYPKuEVPYk38dgS9fJwlU93yqkDo9eBNUduZVthjEa0gXkbvOc+NGvkr
ARC-Seal: i=1; a=rsa-sha256; t=1520485441; cv=none;
        d=google.com; s=arc-20160816;
        b=l5RR9ENRsM7n9Rp4kFwNLiElzjielXlbASPe6yq4Q3QphcA0JmOS7Kn0/yGxXar0mw
         AR8eES4FF5xaz5KC9qhDZk34ny3gL63+o29MvPOFOZZI3UZ4ThexfRQHIhwbFVe18tgG
         TlTNa24ivVnDiOqFc8zu4/3nKm9RfblRRkaa59X/VKb8ZtBpcj5MGYnBZJDedklswdWO
         YpXllIFSF7kxpauVvE7LokUr39Riz/R6fnh7iOhfeD3iiwvdC1aazg/mOhS36oRHJChi
         aZfscRfPozt3uULqdPMaO2bOGyFAX+CeQEzuiscJeiCZx4BmxeGHZv1Uxwngr9ziGDKL
         cyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=namkY0V/Ug9sQoJ/6yW5Jq1yQ9OSq3yugwlaMl7nvKY=;
        b=J6tnf6sqfwskH1YuQL64h9+0El88s6wb3TVftTzWCa3ERd+pus+WJ4R7qTTUXXXkTH
         Kzk83qHIYeqfYpBFx+YK9jWlvoGyP+oqSph4NAeXgxKC0IWb7FYImxawGHWh3E3XQKjn
         S475K53Fv36oD5YR0glGs7G7SEN68KurGWXiWH/hcT94+eb0/G0suCAGs897ZX7j1zp3
         2CjjNQd6mphYHVcM+ggFheux+acNzFU6HadRQ7NY17dB6p4b0JGb+DifSDFR+7lIXTeD
         jJpy1cYAWjQEXhrt/y4+pEkClS9MrmsMEBAmIUOe5VvBqcN1IkBMRxnIx3KJsH0LVWxx
         t9eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=TSgpl/FA;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=TSgpl/FA;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Potyra <Stefan.Potyra@elektrobit.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 163/190] serial: 8250_dw: Disable clock on
 error
Thread-Topic: [PATCH AUTOSEL for 4.9 163/190] serial: 8250_dw: Disable clock
 on error
Thread-Index: AQHTtppS56piZoo72Uu5mi7OUr8obw==
Date: Thu, 8 Mar 2018 05:00:04 +0000
Message-ID: <20180308045810.8041-163-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:O8Szm+6g6pEAmfQMIBFkXr77JOIlGdekPWoirqVGBU60fEZUh+0ulc+AYWnjywqvSk8By7tR7cjPY7MEkwFN6fSDdsypaH2g158qb3mpeGMxKEdiVgWezzygOuOar8DSixteBvurmpaTqiNogv4X3f+6tEE/d9ieyJZWn4HfjwzP7eRjcQs2eTc3Busy0PvvWVZX6kxK20a2UoqDLUbSUxXTiGzRYA1sFnfBd5FSavIWaqQ1TWUocTv+LqI/Nguf;20:JD9KVjnvh/nDuQi1MCAQTSeit2RWXBhH53YHsF5wD9fu2HFlA5xCirGO1xE2kLHUAwUaQibOlPDKAMNU/Kcf1o1DXaJ0iotfnxgrpQpfQYacuRqSFRbovdyhst4MvsejI0BnixXNp2b5au1ySAF7yRK9Z9AEO5GeDk7oizIDCJg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50b2dcdd-a1dd-410d-ddf8-08d584b200bd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0872CEEFF2A0CB96F2913C0EFBDF0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(5660300001)(186003)(5250100002)(26005)(316002)(1076002)(4326008)(2501003)(2906002)(25786009)(76176011)(99286004)(6436002)(6486002)(6116002)(36756003)(3846002)(22452003)(3280700002)(6666003)(2950100002)(86362001)(97736004)(8676002)(10090500001)(305945005)(2900100001)(66066001)(102836004)(68736007)(3660700001)(14454004)(7736002)(53936002)(6512007)(86612001)(110136005)(54906003)(6506007)(106356001)(59450400001)(478600001)(107886003)(105586002)(81156014)(81166006)(72206003)(8936002)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: V828BqZ+8Syqo60jfgymgcGnfyqGXGTOXLzfmG8JWVRwb2wNcBaR5hyiHrbbn7TaX900lbzJ2V6qqMdyDuzrkDT5nQMLWa+jTo+s5lMseHaIdCxTLOIVxX22QvX3TeTlTazllBuJQbjloaLzxnWBeT+ksJRh1R+g4B+EMkrru8NR/iO3TDHIMc2pKwjAj4rk0SmiMe9Zjjrd+oiKT0a6CaJQRoKktaAXCjmpgx32EFBVh7Z2YIYPbE5Lz0Fe1oJvsRKbj3oRSagw38Rdj8bFKIEh72vVjMvG2goXKkPsXleRX/Oq4BL50MME5R4NmBlR7wVvaEMxf/1QWllUUVRqZg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b2dcdd-a1dd-410d-ddf8-08d584b200bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:04.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344069250068768?=
X-GMAIL-MSGID: =?utf-8?q?1594344542296779386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>

[ Upstream commit 8af016aa5a27c6a2505460eb4d83f1e70c38dc43 ]

If there is no clock rate for uartclk defined, disable the previously
enabled clock again.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 23f5b3fdd04e serial: 8250_dw: only get the clock rate in one place
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/82=
50_dw.c
index 459d726f9d59..3eb01a719d22 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -464,7 +464,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
+		err =3D -EINVAL;
+		goto err_clk;
 	}
=20
 	data->pclk =3D devm_clk_get(dev, "apb_pclk");
--=20
2.14.1
