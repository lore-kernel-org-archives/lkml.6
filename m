Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsb+aJdpN6eCiQE7GdiCFawwP7gTfVii3p7cNTWy15YljsBTDhOVH0e9t8TTsUlKUFIokrU
ARC-Seal: i=1; a=rsa-sha256; t=1521475201; cv=none;
        d=google.com; s=arc-20160816;
        b=XFla0uHOXEyY117F/Y+ypetRdsqSJ0MJ6KrGK/JlkFUTd0vPyVlHHQzP7vIzHTFYE+
         mtql08ku7e6VOerCMeOfBvurl21VxFOXgYojaExk/MtWj4FWWsXtm6aQdqqC7J8rLqp1
         JDymSyoZlh6hKGUQY0l3hLeJ38Lkhip/OTo/F2AWPrMl0eEO7ckGbbu9tzgD27kWbrTY
         YO42v9qplu/ueMtXM6wF5+2Tgq4jodrqO0GP3PD5GR4lY58qYpM0DNAMbwieDVwFkSL6
         XVkQeIM8YJq1oV/Vw6U42la18RYHN04vUacVn4MsHIVegr4en5uiF/FDldPPw2iuRcEf
         37Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=EDIRHVMwhVI+vNQjnfLERFDX206L45bwK8zI1wnLnUY=;
        b=GgVr3ucs5FQpLjY3Y05Y3Pe5wmc4FwGbqPIz8kH1MkYsDt8xRASKCS2kOxI6w5TTHS
         PXuy7ePOTXWC6BJYwUo067ZIWUwwpeVnP0HKgkCp0QcgKhR7doq1z1ZEzhO0PTbbjSfe
         SuHm0rBPaZd3DvkSajxrjfKz1UA8mt70Vhb3IKzmqLUyPX0D7TnIF1wZ70M1MIUIn/Zf
         Yw2SAMFsKl0Ka1VA5IwAHb0Q4QCkj1ORKotVqz2f7ACsWIZefUiEYBzQ2QsyzdPuuoVc
         kiitKvnYLX3P8EqhzqvbsK+gA+DrkZ/qhdn12IoqGjTDNs7gzTpVHD4qCrzpA+Z9aCrb
         kqrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XRLkHBvh;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.130 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XRLkHBvh;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.130 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 071/281] serial: 8250: omap: Disable DMA for
 console UART
Thread-Topic: [PATCH AUTOSEL for 4.9 071/281] serial: 8250: omap: Disable DMA
 for console UART
Thread-Index: AQHTv5s5IyeRPHtT+UCiE2JZOS/duA==
Date: Mon, 19 Mar 2018 15:59:12 +0000
Message-ID: <20180319155742.13731-71-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:JnhVo2Jb9g0ZPRpyrdpgNQofNbWgqb1Tjy6v2ONbrJxZnUB/PbuR/1EZGG32wWuggneSMxHpdf568e0k+3tnwaiCAZYTCMRTUUy/s3gSHehBgR04jsIAelKzHrILhytkXH1qpPZAXIl2GzEtvPYCm+7O46nZdfVEKSGVYPjAMGwNAYmh+jvUq8HsDactfzoGpmxSkh7/dV4e+hAWtpHrCsXwRmI6v8VDK4VaUvUvFKA6sYHp/0qMzM+/pb48EF3z;20:cOSA5VJDNlsvyRi9jCbd/+qHFLRHRXWnWnjoc9hw9tCUQMZw3o6LDHTcxfTsTRs7Xib6QDRdP3Mlv0Um4kRHwArz0QhGGlkaEZ7R2G8mxsrQES4Lzga/GciY2VjOrHk8f14syccH/NaRoF/C/94U1XxDDCFV533UfMPa8SNJvDE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1620f79-337d-4892-32d6-08d58db277d4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869A0F3DE721F2FB834C08AFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: t5QHycriguEftdfL02ghbCqjH9FhHYHnCdTnrTUzrLXClLYc8IgtKA1kwnvTrmzQDQXySn75v0kGzaIB5c537FL/5mPxMjW41DeI/zEUX7d08RsYZ/72qHHiUBnu5eLV0MDbNY1oHW3S+z2XGcXzLXJbm0prJB11V3b68XjIVqyVhH+AzPtThgp1V/89qusiNukUHDJxXTnRKKj3qLabCrJQLBNqFDDcCWOVIxsvOt7ikXf+cFzbaRw3Dg2aQ3KaR6J1WTGFQzXSeai/RVpAzLaiEbrawbH1xk20Jg0w8G/KHyB42PSt7XjboAg33A7BWb2QG0dY444znI5WOhop6w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1620f79-337d-4892-32d6-08d58db277d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:12.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382380868186672?=
X-GMAIL-MSGID: =?utf-8?q?1595382380868186672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit 84b40e3b57eef1417479c00490dd4c9f6e5ffdbc ]

Kernel always writes log messages to console via
serial8250_console_write()->serial8250_console_putchar() which directly
accesses UART_TX register _without_ using DMA.

But, if other processes like systemd using same UART port, then these
writes are handled by a different code flow using 8250_omap driver where
there is provision to use DMA.

It seems that it is possible that both DMA and CPU might simultaneously
put data to UART FIFO and lead to potential loss of data due to FIFO
overflow and weird data corruption. This happens when both kernel
console and userspace tries to write simultaneously to the same UART
port. Therefore, disable DMA on kernel console port to avoid potential
race between CPU and DMA.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/8250_omap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/=
8250_omap.c
index da31159a03ec..e8b34f16ba2c 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -613,6 +613,10 @@ static int omap_8250_startup(struct uart_port *port)
 	up->lsr_saved_flags =3D 0;
 	up->msr_saved_flags =3D 0;
=20
+	/* Disable DMA for console UART */
+	if (uart_console(port))
+		up->dma =3D NULL;
+
 	if (up->dma) {
 		ret =3D serial8250_request_dma(up);
 		if (ret) {
--=20
2.14.1
