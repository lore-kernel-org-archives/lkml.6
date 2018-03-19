Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971153AbeCSUKp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:10:45 -0400
Received: from mail-bn3nam01on0079.outbound.protection.outlook.com ([104.47.33.79]:43534
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966634AbeCSUKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:10:33 -0400
From: "Chopra, Manish" <Manish.Chopra@cavium.com>
To: Sinan Kaya <okaya@codeaurora.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Patil, Harish" <Harish.Patil@cavium.com>,
        Dept-GE Linux NIC Dev <Dept-GELinuxNICDev@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 11/18] qlcnic: Eliminate duplicate barriers on
 weakly-ordered archs
Thread-Topic: [PATCH v3 11/18] qlcnic: Eliminate duplicate barriers on
 weakly-ordered archs
Thread-Index: AQHTvUI7EJwVZoTt10KhnY9arO1/KqPYAgng
Date: Mon, 19 Mar 2018 20:10:28 +0000
Message-ID: <DM2PR07MB685740B3E9449FF3B4632E489D40@DM2PR07MB685.namprd07.prod.outlook.com>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-12-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1521216991-28706-12-git-send-email-okaya@codeaurora.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Manish.Chopra@cavium.com;
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR07MB1563;7:47PBvVQl/5MtWWthIgcHYnHs0gvNDy61yJut4/fvKZemx/CWH0iMRFreynuBIVsX8RAWhHlth6z1/2pb1F1DLYa35FEzUoEjecI6LemSK29hQVO7GIi0mZe3SQOGR6+Qm489HctTihOP3xU1RpRQb5kYFQJahatvQ8luZfocClbcTfqAPTmR0v3cLjed5A1qNtmr1i+e00qgslTuOZnZF32Opwpia1lL4dr/G6SO4B0LZmGFzQ9fGAb9tCBGXUkh
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-correlation-id: 4d0b64f7-0710-4154-e32c-08d58dd5762b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR07MB1563;
x-ms-traffictypediagnostic: DM2PR07MB1563:
x-microsoft-antispam-prvs: <DM2PR07MB15633B95B4B6DCD2D0A9EA9789D40@DM2PR07MB1563.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR07MB1563;BCL:0;PCL:0;RULEID:;SRVR:DM2PR07MB1563;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(346002)(376002)(396003)(13464003)(199004)(189003)(25786009)(53936002)(229853002)(9686003)(305945005)(3280700002)(7736002)(105586002)(74316002)(5660300001)(4326008)(54906003)(97736004)(6246003)(8676002)(316002)(68736007)(55016002)(6436002)(2501003)(81166006)(81156014)(66066001)(8936002)(5250100002)(186003)(478600001)(2906002)(72206003)(3846002)(2900100001)(110136005)(6116002)(14454004)(2950100002)(7696005)(26005)(6506007)(53546011)(99286004)(102836004)(59450400001)(33656002)(106356001)(3660700001)(2201001)(86362001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR07MB1563;H:DM2PR07MB685.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: CwwyWbrL+UbACZggk5zkasb/OwDeoQUOfWJsoSG6BegeUWOSXGntD4jhI+LJMKw7R+wWyabFO70QtX1qAtlEUAnNfLbOXqc0TU0+3fXBRBWtCtlEd0jISXtDcHypt0IKdelMcj72FKTJXnwmNHi5EhkjkCfc+D7QvI07zYAtbB4J09xZWMnGIyRCO4H9HyodrsiTw+MqifBxz1Nd3toPqaeWJ3hHHHjIIOucZqA1gqKRRjVeqRuRkDxzeaVEJAMPDc7TSs3HgIiFCRWxmd7z14KdLmjJpfCIgm+6cbvZjaNeaDHs1LJPFe856COslgrCPjSNBbstOmNwbYDs9TYcvA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0b64f7-0710-4154-e32c-08d58dd5762b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 20:10:29.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR07MB1563
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2JKAnIN025138

> -----Original Message-----
> From: Sinan Kaya [mailto:okaya@codeaurora.org]
> Sent: Friday, March 16, 2018 9:46 PM
> To: netdev@vger.kernel.org; timur@codeaurora.org; sulrich@codeaurora.org
> Cc: linux-arm-msm@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Sinan Kaya <okaya@codeaurora.org>; Patil, Harish <Harish.Patil@cavium.com>;
> Chopra, Manish <Manish.Chopra@cavium.com>; Dept-GE Linux NIC Dev <Dept-
> GELinuxNICDev@cavium.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH v3 11/18] qlcnic: Eliminate duplicate barriers on weakly-ordered
> archs
> 
> Code includes wmb() followed by writel(). writel() already has a barrier on some
> architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> index 46b0372..97c146e7 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> @@ -478,7 +478,7 @@ irqreturn_t qlcnic_83xx_clear_legacy_intr(struct
> qlcnic_adapter *adapter)
>  	wmb();
> 
>  	/* clear the interrupt trigger control register */
> -	writel(0, adapter->isr_int_vec);
> +	writel_relaxed(0, adapter->isr_int_vec);
>  	intr_val = readl(adapter->isr_int_vec);
>  	do {
>  		intr_val = readl(adapter->tgt_status_reg);
> --
> 2.7.4

Acked-by: Manish Chopra <manish.chopra@cavium.com>

Thanks.
