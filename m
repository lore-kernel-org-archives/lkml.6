Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755470AbeEaOsm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:48:42 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:61830 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755042AbeEaOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:48:38 -0400
X-IronPort-AV: E=Sophos;i="5.49,463,1520866800";
   d="scan'208";a="281178218"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Hoan Tran <hotran@apm.com>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: fix a signedness bug handling IRQs
Thread-Topic: [PATCH] gpio: dwapb: fix a signedness bug handling IRQs
Thread-Index: AQHT+KgSebWfkfOpxUa8G2sYwj0vlaRJ6yDw
Date: Thu, 31 May 2018 14:48:33 +0000
Message-ID: <TY1PR01MB1769FA633588A28A55A54636F5630@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20180531062424.3pfqikwzxryi6teu@kili.mountain>
In-Reply-To: <20180531062424.3pfqikwzxryi6teu@kili.mountain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0922;7:UCs1IgnPB8r/mDYv6vvCJlhltEs2dDaq8EBHJ86VNwlqGply4HXkce11jkAwn7d/L50J1f/K97rs7vJuCoB9uJp+u+cRNr8+S7FMU2GZm/zeikJWf+zdZ0591gEurLxg+zxBAdFD551WzgzGpv9pdByrzt6prhHT0Ad1dZuwdKWOqSfYj2BzVl2bFHMQKWW8+LkmW0RUhFZWWLpmfL27+fLGGYlYnlPx4n76NQNUqXauxt1BwziSlrhRAQr1dy+l;20:FJvgmreNvLfMQeyda6Xh85cKo5Q7FqSR2wgb0nnBX+SpqV7ziaAhv7cZTiT63nn3ATV8lAk5KDK9Rn6Y0f7udxCEvC8e+sECD4oD0XWbTKr8hHUT8+fFu/G/jr0AR4wbpHE89ln+B82cmuknhh5JyJbP6Rm3JEWqovIDeJ7mT+M=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0922;
x-ms-traffictypediagnostic: TY1PR01MB0922:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-microsoft-antispam-prvs: <TY1PR01MB09223BE9004EC9F54AECE82DF5630@TY1PR01MB0922.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0922;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0922;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(376002)(346002)(366004)(189003)(199004)(51914003)(105586002)(476003)(44832011)(54906003)(53936002)(66066001)(2900100001)(110136005)(2906002)(486006)(97736004)(9686003)(316002)(99286004)(102836004)(3846002)(55016002)(6116002)(6506007)(4326008)(8676002)(7696005)(81156014)(81166006)(26005)(106356001)(76176011)(5250100002)(6246003)(68736007)(8936002)(186003)(229853002)(3660700001)(6436002)(86362001)(14454004)(5660300001)(3280700002)(11346002)(74316002)(25786009)(446003)(7736002)(53546011)(305945005)(33656002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0922;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: y6LxPJCcLqXRQVLvYey0R5C3I+5lq0ftsiy5mwwD86n9Z+uRpBKZN3eb09fjf/nnmssDatPaWlJn/mzCIi+xXnRfAAwATA9QlWcZAjgmbXfHeYBGCqRXe63bw4Pd9KPgNBvtvQXc294ejQs6q4NxXqsni/SfYjiixsG7Y2E6a62kMl8yDCtAGA4FcbDTcFBt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: acc6398b-56c5-4863-c611-08d5c705951c
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc6398b-56c5-4863-c611-08d5c705951c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 14:48:33.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0922
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VEoI4r019772

Hi Dan,

On 31 May 2018 07:24 Dan Carpenter wrote:
> Smatch flags a couple bugs here:
> 
> drivers/gpio/gpio-dwapb.c:447 dwapb_configure_irqs() warn: always true
> condition '(pp->irq[i] >= 0) => (0-u32max >= 0)'
> drivers/gpio/gpio-dwapb.c:627 dwapb_gpio_get_pdata() warn: always true
> condition '(pp->irq[j] >= 0) => (0-u32max >= 0)'
> 
> The problem is that we're storing error codes in pp->irq[] so it needs to be
> signed for the error handling to work correctly.
> 
> Fixes: da069d5d2b81 ("gpio: dwapb: Rework support for 1 interrupt per port
> A GPIO")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for the patch, I had already noticed the mistake and sent a patch.

Thanks
Phil

> diff --git a/include/linux/platform_data/gpio-dwapb.h
> b/include/linux/platform_data/gpio-dwapb.h
> index 5a52d69c13f3..419cfacb4b42 100644
> --- a/include/linux/platform_data/gpio-dwapb.h
> +++ b/include/linux/platform_data/gpio-dwapb.h
> @@ -19,7 +19,7 @@ struct dwapb_port_property {
>  	unsigned int	idx;
>  	unsigned int	ngpio;
>  	unsigned int	gpio_base;
> -	unsigned int	irq[32];
> +	int		irq[32];
>  	bool		has_irq;
>  	bool		irq_shared;
>  };
