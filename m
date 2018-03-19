Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtFxr1ufIsMNziEsB03k6LWf2TgtpcXTih9sfGkQ4Mieqb4jll4W6YN1FGF1erxZlHSnr61
ARC-Seal: i=1; a=rsa-sha256; t=1521475435; cv=none;
        d=google.com; s=arc-20160816;
        b=i3wkXi5yZGudjCyATzqDD4C7++qncb+2b/jvmSH9trqFxkV2Ss1W1dgGukot2aYA1t
         LFA1bDuIcJFuVt6DNIfamOLiZeVPDYVGZT+YX41Ljb+uA6Sj6mZPYHKv0BOMsATDmk4Y
         BGOIJdDpFxEptcPH4Q+Avlw0btFRxDwhB/RUEZ6qW3WhUZI1ghAuOMTVD76nA7tdGnPP
         cVZ/RmlNM0MbXGsuBEU3Mr9WffQju0323VyrgyM6xIc9QdM5JgdjvYECvreU2Er1JHB1
         vMVzKKr/ZS1IbtBv6rjlDT7wwmt7lKdRs5GgE7qKSg2QMPepWxQ60JGQUdSCKWO8BRlt
         YaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=fFgb9UOPy72c6DPHq/4NhoTwipqdmus0Cv4Omm92jRw=;
        b=tQKWizCvjca2A39RWI3eTT2xtnP8e2Sifl9UZFyypPRUifRq20ftM3NT/2f9cT8htE
         VBG+rOerPyCsEkdCyxuqrzXzV/dYNDEiimXpBwm4FbmKk/chHB9DDjpAIQZjxqn/sic5
         0G+fu+Gekiu5+vayxcQakm8qrP70b5kbZc12v6FJcv+qHClIntkRb8RL5xlW1fxsnbao
         4XY4kIl46Qi3i2yzC7u6tddQJ+gRaBU3a+jCkhRYLLOMZPTpE0wJOfbHLb4GpByywsLM
         BNC3XMgWVSEshnReakjUYFUQnYjbEZ87DZCc5y+IYHA1Fm8whGjQjQr3986Du42KHOw3
         1ujQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=ot8PKjtU;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.116 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=ot8PKjtU;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.116 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 192/281] Fix serial console on SNI RM400
 machines
Thread-Topic: [PATCH AUTOSEL for 4.9 192/281] Fix serial console on SNI RM400
 machines
Thread-Index: AQHTv5uRQDX+p76UEEm3TB7sBVGAFQ==
Date: Mon, 19 Mar 2018 16:01:40 +0000
Message-ID: <20180319155742.13731-192-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:MVu8lyKtwIXzzfPQ0aHxA9c/CrD+RO9x8tdGgywLBHupoj/GA+yagusNziR/X2SeDyFQsc6Y7uQN3glxmhRcLxILr8/UMtr9qSFnxbY2s7gEFbYiuWRXMw/Vz2roxqrTIqx2LLol70l+BSIj5ccN6Rq/bVDn7gKEDTKEWCfLlL/SR3PL1Mp+doERifsP1zAVytUmJsn6uQr5e/vXWV+776dommX4F6pd6bpZIHbAVrbEDgBrAoN+ynVo/RHrjx9q;20:5JllWjuaS2szJzD+Ao6FTnxIm37zqHOTgaouNth9jsXvSQA1JSXCbNjJ6MGgg2N9alMabvgLYxOTD5JfcLf4Qv49SWYawwQLH/Q3yaOBRhNaMmWjBd4KWOIVmf3w/uOkv3i2kcQiQWTyqRC3Yk5UvVsdFbYlO/vyOz0vaLCTV/Y=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4ef23e0-47cf-48b1-c891-08d58db30346
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727437CF6C58FDCA8E19605FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xRK4qz3OpRsv1ATxb9+ld8qWaRkiSbK8zz2OEa5TvwOyDnKVhs1QH1gPMSREJFdN2lvq6rBALL145d3szhYXOPDiN8TRMmNwbAOKY3XvrBZUu7FgQW6b0nZyKo7+yamZxkJVEejhkt0Z6ztjhev7/ay0bv23jytWAgLqOzxfj8kRxV9RPKGSA3qdWXI+dRRSDTpWDJnvdSq5Cr7uYVp9CSyHNa2RjxHXi48Zm2gEYxxrWvzChByUKAeTn4Yef617l16CEaap+1lmGJPB/7+ljycTzZzNaj6vAE5kEWo0G+Ogjg9ZuEg/ttkPRGobhaTx3Y9aDfcb6r0bSxv7Je6GBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ef23e0-47cf-48b1-c891-08d58db30346
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:40.2616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382626228264600?=
X-GMAIL-MSGID: =?utf-8?q?1595382626228264600?=
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
