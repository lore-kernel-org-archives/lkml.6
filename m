Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215D7C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EB220675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="hBOkPgVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfAOQhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:32 -0500
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:19900
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731791AbfAOQh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixdzpBbmQkYOEsplTMjFYDhOVhuRQPZpOHeM7AtQ8X0=;
 b=hBOkPgVuYxSEqvjnHmKutACZ9NklVj7YCImV8w8xfY0MSdDCH+RCsOfIpi1gqLgXtSJFLoXmKAOpoRZ0YaRIOF2UrsiGeBzkAlHzS8r52fqbebM6Yow8QAmMU+o8gg+1YO5xJuFA4uMMR/0eXAt8Kw7F8vR/hYVgEkFxovIdJqg=
Received: from VI1PR0602CA0022.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::32) by DB6PR06MB4008.eurprd06.prod.outlook.com
 (2603:10a6:6:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.24; Tue, 15 Jan
 2019 16:37:25 +0000
Received: from HE1EUR02FT019.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::206) by VI1PR0602CA0022.outlook.office365.com
 (2603:10a6:800:bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.24 via Frontend
 Transport; Tue, 15 Jan 2019 16:37:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT019.mail.protection.outlook.com (10.152.10.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Tue, 15 Jan 2019 16:37:25 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 15 Jan
 2019 17:37:08 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Tue, 15 Jan 2019 17:37:07 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Wolfram Sang <wsa@the-dreams.de>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 0/5] i2c:ocores: improvements
Date:   Tue, 15 Jan 2019 17:37:07 +0100
Message-ID: <14601911.GrvbWtgO0l@pcbe13614>
In-Reply-To: <20181127113821.GB1107@kunai>
References: <20181029145051.31984-1-federico.vaga@cern.ch> <20181127113821.GB1107@kunai>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(199004)(189003)(97756001)(8936002)(230700001)(6346003)(186003)(86362001)(4744005)(11346002)(446003)(336012)(229853002)(246002)(106466001)(106002)(7636002)(7736002)(54906003)(786003)(316002)(305945005)(426003)(16526019)(26005)(43066004)(8676002)(9576002)(33896004)(53546011)(23726003)(6116002)(9686003)(76176011)(4326008)(33716001)(3450700001)(486006)(14444005)(6916009)(46406003)(50466002)(476003)(126002)(6246003)(44832011)(5660300001)(47776003)(74482002)(478600001)(2906002)(356004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR06MB4008;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4cfec20-029c-4061-e28a-08d67b07bb12
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB6PR06MB4008;
X-MS-TrafficTypeDiagnostic: DB6PR06MB4008:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR06MB4008;20:Wh+YL8dMyFrslxmVWEFHUor0owENKcz+LkHNYvI00O7CYvzOLF6gh7VAINtn/xmR45WyUhGbhDxLNBJU7wfX5Rsj0tL5KIlHuoKJF4naOD226IAawFCD/+ES0tfLwqlrKV0pS4uWzEjE2QrcePqyDdUqfIwaP8ksYJhphfQGWG+Mgge19iiKC2dSwN5UMhfg22vg0lIzQR8DGYrsAWEKDmkT5mULG6zakWOyEV8CE2k9rL930raRjyGr/FDWzk9qs+onKuXtIohU2/zZA9Oblgfa9Ih1S+r+NJa6skkyigMI0tBhhK8/Xi/W2ccBJp3Ch319Mpn8Yu+pl1e6aJacfxRrVWnZ+9Z4rd54fInevUtBtuhiYMr7hnoB3veuxkBk8yEdoAIXDm2SwMbZ5gDz/bYR3LFAA3K9D7mEOvwo4Of4XMxkEfp8yw1LyE2MlQV2bKc7xmZBUYJ5zBTdPn4Q/Zzp6Neuk3Yq+QCsQz5cdfIOK18//MeZKTbX5GgkPwZr;4:KXd8lYXKWsRvKr3mm5XcWik4aJQMOBEOExV5hJonNz32yBiE8MhnEtliMKHTHvQDAM3FjWhhm9CuVCgKd9BC1WMumfoFeJT5Mn5jjMV32kyrOfNm+N4Q+bTUL+kimv4pUXQ05bSqWdh+iUdUbodyfERx0NDxzUulRbJA1elgO/26Q/5tx7Assal+Du8zvOAWAWVofCQk56UmqXKo6JUNrFE0E6su6+wa/BNVVs6iwgv69OoRpGCzvz+XqdWvh8+iGMhJiVEI6mUza8owzWTbo1zz4nru3eT5tW1+GPXIY0HC0op9TTAOKIOuVzgL+Ouv
X-Microsoft-Antispam-PRVS: <DB6PR06MB4008F6DAC58180A8CFBC5051EF810@DB6PR06MB4008.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0918748D70
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR06MB4008;23:kI2VPEa8kcWLEagZRxQVlPQykYKNl8sActAGDvt8/?=
 =?us-ascii?Q?SBI8kvWmDap9GQFVAtf5W+fKXI9NuJ5torO1DpkPnDt2OMtTxCPkLfq1G2k3?=
 =?us-ascii?Q?AJqdGgbLQSRFnTpVvEJO/Q4QjIkU+4uPM1eKRP2OZ6cV/kuLd11qUX1Xk2D1?=
 =?us-ascii?Q?wQne5F52oiHTQifyl/Fpsnk1Ii6QgdMLOa+Q11gJXGienS4odgQ50rtpbjcz?=
 =?us-ascii?Q?oKZUbafD/WbUwaR5oNP6e0EvlRKe13+g7RaSuA1JR0ui3qeB8iTtVIqc2pVv?=
 =?us-ascii?Q?aML892577ztN7US3WVvV4mplMKrPjByQcCXuQEHRSGKgCn/5cbNBWW+qUA6w?=
 =?us-ascii?Q?/rwtKVA7dDpSQ9AljCjEnzsVQufNNX7mJw4N/Kc5BLnVmZP2nBNs83CP1Y8g?=
 =?us-ascii?Q?o22WkKXSPbS4cX3umROhpTQd5LbAKYbp2NHifdetwMGFGHU5NFJFgR4EweSu?=
 =?us-ascii?Q?Ob1W/2h9u8sqaubrv9i0TegKglBxQU6DrIq9AEsAtnSJcUXYVisZ4v22MXaR?=
 =?us-ascii?Q?IYiUkKEPWQSeYF7LHQF3g0Vqb4QpnsF7PnLioduL2jMj3pmp7mmQktH27XBx?=
 =?us-ascii?Q?jptiN2OUKzeoSL+AC96ctRNikfHlIfgeVRJFNxaXuIW2nUrzstmSo4JTj19a?=
 =?us-ascii?Q?tnlfnKML3GpgWNlTzLZ9mC33P0cdpno1CZ6MDcWOz0euXK1d/eD8aNDI6bn6?=
 =?us-ascii?Q?mTrWjOxN6r2BJliOf7exj0pStquQkkR5IdC9APNd4YglT7TGRNiGq6L9l61p?=
 =?us-ascii?Q?+uWdRuhS5hmpaQCjSbsWKqUKYnK5lDKecTpOK9wH9/P7du8L79vO8crIYdFz?=
 =?us-ascii?Q?GOjPr3BJaPoLLyfqTU2C8eIbl+FkR4+NHAa1l3A1TjEb5pvoN9KXI87Mi1Lq?=
 =?us-ascii?Q?wJGsm9WeqwrplmtSvzciTbjYFsGv6niu17yW/1VYOA0PckTPEeIxIrrvGcpT?=
 =?us-ascii?Q?/z2+4852n2iGp5fS5XsmgYW9AdCeexoI0wt0WGB7JFX/nnUiaWUoFSK40/hA?=
 =?us-ascii?Q?YUv7BtctYXr8rmc2AYy5DqM+VSkNnlXrkAuQNMXy5loAsbRocTfcX1jyITU4?=
 =?us-ascii?Q?lhm4xllTJj657ERxhJbauJO3D0rS9+/F3p6dJzjiCyMHPOaXDaCDb7GqMpEC?=
 =?us-ascii?Q?zCT7ZIeLE+8uY07DYb3HlZyM9F3IpEl6gi/C9DT7axF65J7xws+cVWoQCMAu?=
 =?us-ascii?Q?hW63yAasesr/xAWS6iYTV0PAtA7O2Xe2Cc5+ZAaP5cYJwslfMbqt5AQhyLmG?=
 =?us-ascii?Q?N6Uv+Ui0cWTQmfebGkXgWnAZ7sWwtTvJT469nBHLFq7i7YTFU+maiJ7NBqf3?=
 =?us-ascii?B?UT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: p23dRFfHi2wGs/KSDUg4ri6JjDwGFZWGnwLPGp+CDOh1usi7Kv9LFrqRgyl6nz4zPTbVhsqwmT2DsLqQruwA6gXRRunwpePi2mDn+WA5/z8cTTyLeEA/JuvhonINBvgN+FXq1nYmvCcxVlsG1Y/Y0VgZAmsYN3qNyB4z2B3GWAwdxsi92Gtn5QNjL/P7eF54gngE/T+65jo33LlPbCCEAFOnHqx+74eBe92jjXq59iFBKkPUYaVwgFBIruNQR8N2I38JC9X8jN02SwK+d3fth4/7yUy5wftZWfetYSIIlFFyBbL4d95FfBXbst6cYSf8MdGNyldR4x8SF35OhApBc/0x+bbbKpNfH2udvghbo/pveBNVNqRlxzQ0ZY4ZZ7BF1+RipA4IvjFL7ORdYiqRM9PDT9CrFH819QDDXgkAJzs=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR06MB4008;6:O3CTzHkrTb07iv5u7m7G6WMhL7ZFK1gJta02gfUWQv6QrF0J4jrUMIb+QiMWiLbJfaXe5wvvhYyn0j5kk6TDwEKjp1a9jfO/yuZAqAnknk54TUTwDapFbLHAky+AABzxcDJPhEGjIlQOlXtMSf5gCW82i2Ud1uhVlF2qq/nrDq5JTiCWoEVUj+T3AP9sAiSrExz9gaZ9FDZrRKg3fjOnZUz9gAwLUfTG4Mw3kXK95HUuImPV5kM5+Ic8yTBNZbiDTck76ViwvCUl/vpGLi37vJ7nlLpfwAABx3d+rBE6t1Ks/8kk6VgK2qed432yyhMIrix/IrEcq3Zpa7dPEw9IdzbqrQ4IfyjuXFfMx7FLeyzuZK/5THv+gNIIWzD1jwkKt8KOA5CH2oSVpxqaYmc0kgdoVdIL2hHFr0SorylAaVEI7cPAmMDEgInTmDpcCa9kFKNocavTfJuB1Xp7eP0YzQ==;5:XAMJW7VLfrjVY+5Gvyvc6wnBGILKgbTfixTyDFfIx4SGDTb/yOs3aFSksUXus+0xT5+vHhmLfq11e7SgPBEZ9UhSLQyGE55tIE0YhUHEKb/Lc3IfqBqMoKR8/6tDT4HGRMFCDAFjy31OkkpMqi5owlseLJdu9cbKp9CyaskxvP7pQhrsSnnS5xT5QUFNdLvRD65VdDlFqYl7XilIF6UHtw==;7:D2iQwiUJ2TLztE2xyiZVz3cmL7Twju6X5kv254lELjH4vxzbJfZCA+Xcq+toJViyhrDX1ROJk/5Qev73PAdVONZq3ZcDSxMtVkQpFUg5yDL7o/Azv6uNenrhGQpUYK8sA6U+iRr/p5B4NMWqr1Z7tA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2019 16:37:25.0099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cfec20-029c-4061-e28a-08d67b07bb12
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR06MB4008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I just want to ask if there has been any update about this patchset that I'm 
not aware off. Thanks

On Tuesday, November 27, 2018 12:38:22 PM CET Wolfram Sang wrote:
> > This patch set provides improvements to the i2c-ocore driver.
> > 
> > [V1 -> V2]
> > - replaced usleep_range() with udelay() so that the polling version can be
> > 
> >   used in atomic context.
> > 
> > - added dedicated patch for minor style issues
> > - fixed delay computation
> > - use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is
> > always> 
> >   necessary and a trylock would generate an extra interrupt for nothing
> > 
> > - make the driver ready for an eventual master_xfer_irqless()
> 
> Peter, do you have a time slot to review this?




