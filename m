Return-Path: <horia.geanta@nxp.com>
X-Google-Smtp-Source: AG47ELuYvvdbyK/36Tni4NAI17NwOBtZWnYg3mn/iczpoaEotEvsyI55OzZEg/c+q3li5q8CVKZs
ARC-Seal: i=1; a=rsa-sha256; t=1520339852; cv=none;
        d=google.com; s=arc-20160816;
        b=xZM5Uzov1zZ00HU18NmmISHT9X/4hrshsrWQiInEIMouVVNC2/vTTz8nxlyc+yJqN0
         gDcO4Nr/X6RYU8bbg8bTGw3jgkhU+rlduG7B8mifkkh+3JBZg/GJbKbnAgYi7VPL3oE0
         QWApzUdC3FIt6/VJJs33XxAPrxN4Sk/Lt8TxaC6Pz+TSyoIjxIKfNdooYs9c1fKo5cnU
         xQB9aASOX2Fe0hWIhn6fy0f10bSnFax9FETCxB33xQpZTF0wHma59k58ECoxPievQaKk
         hqcezNYM7hOrsoIJdAwwVeQAn9Di+d8O3wptvjUkC7TebdmodE3hIBEoGQpVqqQWABHb
         HyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=UO4D2zHcn0Y9OZbqScr+y8bn8I7Fum/o9wVPDZPASPY=;
        b=bzT3PTxv6ARiiqdM0qDvqAFnLtx8RN1PEETJYYGiHoVxTMDI7y8B5nia+iUGqbVESP
         +30zWm400zov8P/siYH0xuXFGIMOkRiUqZnplJnbHB2aQPp0Ey6ejGPdlOUDuxZLGUQ0
         bkrXAqGw3UgvTYQZpv5bGYSI7o+g/Vhxi4wH2T+qsd00sUB6mksh0RIOaM2K45BdAfjR
         2aYeahnZx8gaMDOSa1kW9yeATQaYihr4ovd25bZSskKkZq2XXEaVq393HcC9mBUp/eab
         KmBYLvqLMtF/79LRjNFpQTJO5XIwVj8jU9twWXXWeq9yJe4vqiqBO6Cs3w6HDkOZHrDv
         nkyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=XzU0TXzO;
       spf=pass (google.com: domain of horia.geanta@nxp.com designates 104.47.2.88 as permitted sender) smtp.mailfrom=horia.geanta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=XzU0TXzO;
       spf=pass (google.com: domain of horia.geanta@nxp.com designates 104.47.2.88 as permitted sender) smtp.mailfrom=horia.geanta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-ntb@googlegroups.com"
	<linux-ntb@googlegroups.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Dan Douglass <dan.douglass@nxp.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v11 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Thread-Topic: [PATCH v11 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Thread-Index: AQHTtLVorSqHVlNOk0KjO1LHHx/OIQ==
Date: Tue, 6 Mar 2018 12:37:27 +0000
Message-ID: <VI1PR0402MB33422D83AE168D84FDED974698D90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <20180305190824.847-1-logang@deltatee.com>
 <20180305190824.847-7-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3375;6:NpbjcUHXuLOijaT/8tQf81dPYzZbyVSElOJuU4L6v1nH77ydTMUg3g0JQKLY2z742aalos6Z7P5A2SuUOtNPqrV8NPr4CCB4rqjhkrMzBdF0wEyiSKrjSvbfzOIJGSmY9+q1oiDtxSSXR2z4hb0D4ZIfF7JzcFk1GzZ9ktwCWqOPSWHhTyNQjrphacWE+KDwz/1fkdWfE3DiJDple9k7B0AUudOLPLJZMIWDBjhbIlB7k7S2WIsqIFLpPWZ1OD2ClCHBIuO7eYTlbzpQTXrZZnPN3GuJpSruFuES9yiYdCh0Npw9yK15fUGop/WWk9UFud4T1VofAe46nA12NrcvODaP1+GFKe//oz2Segs2I3pvMvPhvehBUkse9a2RlFfS;5:WOAcqLkt6NLOp+lE0qROuht4ajHsQVTeNKypYXZHCRYNh1D6RezG6Ekas5sBhdGU93K4qcaOCko62WuedjX1u9dcnTNKjuCNo/OrlJukhFD8+6vw4dvvGZA9YKC/hPXJb48JxfGQgKnE6f9bP2f5cV7hI6c8YBg2MnbRvjt4d+I=;24:GEERgAQjWqYfQgMbyeIRmMPSzblDOVSi4T5Uv/MmpMAYGXNROoTz8n5DPuX4hfZNe/ZhHhjGsqibgq6LHMFpmXX1NmHdD0bF0aehP/cTJ6A=;7:45+Gv/jU3lyfJeGYVkKdkaqXdQ4WycGQF2dyiH8qAH+EYceG1MwlJLwVuN1GvOvkp08HHftwofZ8pq7hVTYoKGjMAGZqs5hxRviePfhXPnYIpb9XuXnbc1bpeqXHNgE6Ag946MM3MPKUtYStdHN5ZKU4fz4zbt51WxurlgRUokZcmKDMkEbiqd8hCGGCoT3mFkFU+Cda/h54YvfgEUom3URt2nHDoBlVXis+ANxZ1m61DXRlQgVt4E4I749EHqhW
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(81156014)(8676002)(81166006)(6506007)(39060400002)(33656002)(26005)(7416002)(53546011)(74316002)(102836004)(3280700002)(25786009)(4326008)(7736002)(8936002)(305945005)(97736004)(6116002)(5660300001)(3660700001)(186003)(3846002)(2906002)(86362001)(575784001)(99286004)(106356001)(7696005)(76176011)(66066001)(316002)(54906003)(110136005)(14454004)(966005)(229853002)(478600001)(45080400002)(2501003)(6436002)(53936002)(2201001)(5250100002)(68736007)(2900100001)(105586002)(9686003)(6306002)(55016002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3375;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3181cbc-b3da-4796-1e4f-08d5835f0567
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3375;
x-ms-traffictypediagnostic: VI1PR0402MB3375:
x-microsoft-antispam-prvs: <VI1PR0402MB3375F6D2723166FE08920E2898D90@VI1PR0402MB3375.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(8636395112948)(189930954265078)(185117386973197)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0402MB3375;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3375;
x-forefront-prvs: 06036BD506
x-microsoft-antispam-message-info: agDePpwZzz2HaEhSIzNvOFBEVqk3jM15IHvBv+1EL2Wl9lyQQlVZ0hRPBEAdqsXeaWkEV/67vLKunfgfRMu/0MpAGg4Of8jzQ/1Svi9nCX2rz7AjCWCP5Z4YxvRRrRChTGFGAS085faBRWfzR9fiWu7CcvNhwWprGR3+d3Q5RzUKUTGtVpJtkZsoRwSvKPI3sh0PhwNTKo/FppntsL2tle86/dPfUYJdq+qi9UUWmRZfmbBW0ltzEB5BFWGuAm09cFMVbvAUgLPQAQvwbDAfgTYBio2+7tm9/9LeGdoXR8TltBdjX2NI3oHMMg3gKvHb4LsfCILhhH5QxwG+PqwzBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3181cbc-b3da-4796-1e4f-08d5835f0567
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 12:37:27.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3375
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125902706060258?=
X-GMAIL-MSGID: =?utf-8?q?1594191880846672989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/5/2018 9:08 PM, Logan Gunthorpe wrote:=0A=
> Clean up the extra ifdefs which defined the wr_reg64 and rd_reg64=0A=
> functions in non-64bit cases in favour of the new common=0A=
> io-64-nonatomic-lo-hi header.=0A=
> =0A=
> To be consistent with CAAM engine HW spec: in case of 64-bit registers,=
=0A=
> irrespective of device endianness, the lower address should be read from=
=0A=
> / written to first, followed by the upper address. Indeed the I/O=0A=
> accessors in CAAM driver currently don't follow the spec, however this=0A=
> is a good opportunity to fix the code.=0A=
> =0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
> Cc: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
> Cc: Dan Douglass <dan.douglass@nxp.com>=0A=
> Cc: Herbert Xu <herbert@gondor.apana.org.au>=0A=
> Cc: "David S. Miller" <davem@davemloft.net>=0A=
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Please get used to carrying Reviewed-bys from previous iterations when patc=
hes=0A=
stay the same:=0A=
https://lkml.kernel.org/r/VI1PR0402MB334282217BC0AE1F8DA8BFC3981C0@VI1PR040=
2MB3342.eurprd04.prod.outlook.com=0A=
=0A=
Thanks,=0A=
Horia=0A=
=0A=
