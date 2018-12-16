Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1E3C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D752082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PCysFD8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbeLPWYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:24:19 -0500
Received: from mail-eopbgr750122.outbound.protection.outlook.com ([40.107.75.122]:16256
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730758AbeLPWYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd9BHxQzWhcy2WAEgDD4qVBr0g7qVbZQheT3nuQAlL0=;
 b=PCysFD8uA4UpMSxzA0KZGDwqH97ZDKRUXfrUMlbblegiNG2ez/98sXWjJctuQGfS6B/x9jWjk4wA8enOEV+Kw8aqpgXQZbrA7tIJQ85Ud4DBMEsBC0Q91AWfF78qQRGWCCahBRac4RV8kEPSfqDxW6THl4pdzjjHKMB/UU2p5MI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1375.namprd22.prod.outlook.com (10.174.160.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Sun, 16 Dec 2018 22:24:13 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 22:24:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     Marek Vasut <marex@denx.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Topic: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kqWB0eqAgAAQjYCAAAPdgIAAAhmAgAAIv4A=
Date:   Sun, 16 Dec 2018 22:24:13 +0000
Message-ID: <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
In-Reply-To: <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1375;6:M8W7gdreyQNpddDYvkWuDX6SCaNcKcQanOGY/0ZGl19jm908mVxA7zdzlEzeHRPY1/Ul3vx9W7refQDbPxR2S6nJDyhKmh9MizG6C+P7aEgVRD4exD3gYWZNfZVRG8Zf45MdYz5YYJAtEP3VE9Pgrzs4fLewHaHKPKBUR9sZnHvJHpQD1EYXvOYqK1iibhTe8Pea5uY29hxRz7skPxCyl00mDGlBnpNWsC87zn6DidUj1xb1NRTlvjywJUjQAVOpEqEQMOC/jmU0i0XTz4uX4OI1joWCvEVdgyszkeRUsLiVBSY+T1BZAHkUIrxMF2z8EUs6aQb2+5MgqwLoRx3cD37zM6pasoPztS5A9VtiCcXrOaiOL85bYF0ezkGNiN1H1RSmlAuQoUfPjpRe+SPNIR5e7ocPvS4rrXEyhGIBorfM6qRnqLhXOIlM+zlSpp8kBMwAjszoU2rXdVTb+5u9UA==;5:FqVfYYc71Kjt4YNOOzPOjMt1QIxKAjfUKzOkiD4y2DLAyY0LK1skELDQYX+Xof3978l+m76JE7QyH+NPVz4uYTdITxsuBhB/8bSBmbeCJ1Ol3VUXMI3EhRvJYTW3QEtiqCGbTZZoZo3XMVAC8w6KuCpIrPdbJEiCNKLJVGUHZVQ=;7:uAkoDXbaOPbNwW3fWK3SdLGx0IYx3dDnpNC3qwgb9+s3GB9/TlF1tIfXX62HZpKnMyDMNSZpnce/MAwAIff30DZs8PYHCHFEl7LxNH89W2/Opl9Jmbxzm4SAfC1eRqvJ+xabhPnYZ1DWC3DxWPb+GA==
x-ms-office365-filtering-correlation-id: 30999de4-da37-4231-29ba-08d663a5352c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1375;
x-ms-traffictypediagnostic: MWHPR2201MB1375:
x-microsoft-antispam-prvs: <MWHPR2201MB137538EF07FF0A898132C888C1A30@MWHPR2201MB1375.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1375;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1375;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39830400003)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(14454004)(6436002)(102836004)(229853002)(53936002)(2906002)(6506007)(386003)(33716001)(33896004)(52116002)(42882007)(46003)(71200400001)(6116002)(25786009)(186003)(7736002)(58126008)(305945005)(1076002)(76176011)(6916009)(5660300001)(6486002)(71190400001)(68736007)(4326008)(99286004)(39060400002)(486006)(508600001)(81166006)(54906003)(8936002)(8676002)(81156014)(93886005)(6246003)(97736004)(11346002)(105586002)(106356001)(9686003)(476003)(6512007)(446003)(256004)(44832011)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1375;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d6PwfuBVJUZfZ814JscOkULUGkNPfrHr1iW/ila0K3P2PDqzZdaCZWb0SAVAKL2cqrOMPaTNeq2D6no0Ijnxn+fefHgyf2H6d1RHqj/BFS7iU2GutiBX8wDo971S+rTLcLxPyLZDYDCgIv7wCA0gknxmAgHqe0WoCvpmCLcxKz6SWRJjmfXEZryCnu11TEREE3rhb1OdgQfjaWqKgVbzv8/c0PpsjOliv93DMDI5RYv10ZFz0PK0JQI0sKGxBjiKvusDbcmX2fYMcbA1m6Ksov86qpizSsAFSblMXBbtOWhGAZVg/D9EpeicPyfGbn6O
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <724D18326746444A950683E6C4278B91@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30999de4-da37-4231-29ba-08d663a5352c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 22:24:13.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Sun, Dec 16, 2018 at 06:52:53PM -0300, Ezequiel Garcia wrote:
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index c39482b96111..fac19cbc51d1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2209,10 +2209,11 @@ int serial8250_do_startup(struct uart_port *port)
>         /*
>          * Clear the FIFO buffers and disable them.
>          * (they will be reenabled in set_termios())
>          */
>         serial8250_clear_fifos(up);
> +       serial_out(up, UART_FCR, 0);
>=20
>         /*
>          * Clear the interrupt registers.
>          */
>         serial_port_in(port, UART_LSR);
>=20

This helps, but it only addresses one part of one of the 4 reasons I
listed as motivation for my revert. For example serial8250_do_shutdown()
also clearly intends to disable the FIFOs.

Thanks,
    Paul
