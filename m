Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE15C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6858620823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="d5jAOS9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438911AbfBNPEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:04:50 -0500
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:16512
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388075AbfBNPEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PGC9VH4jsn0Onrx7bbTL2jOWOtUdDQu6jzvFbq+B/U=;
 b=d5jAOS9pMp3e4jwDUA/uJmPQGFKiMDxdufqHf1bMpTe+uDDaXfAkkZUxso+ZsYYv2dgiRPOhRPg3UIKY5tggBKyQgteDQPNN4i9Q1AvECQqMcjIyTl3/N8JIbKTG7Lkpo1WblNWTmR0C5X2kPE+DAUGmJ9qP4Hyc2rkhOxy+XQU=
Received: from AM6PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:20b:14::15)
 by DB7PR06MB4725.eurprd06.prod.outlook.com (2603:10a6:10:56::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 15:04:02 +0000
Received: from VE1EUR02FT059.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::204) by AM6PR06CA0002.outlook.office365.com
 (2603:10a6:20b:14::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 15:04:02 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT059.mail.protection.outlook.com (10.152.13.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 14 Feb 2019 15:04:01 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 16:03:48 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Thu, 14 Feb 2019 16:03:45 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Joe Perches <joe@perches.com>
Reply-To: <federico.vaga@cern.ch>
CC:     Andy Whitcroft <apw@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: Re: report: scripts: checkpatch: Spell Checker Does Not Run with '-f'
Date:   Thu, 14 Feb 2019 16:03:47 +0100
Message-ID: <2899994.xJFnvJAAA5@pcbe13614>
In-Reply-To: <4a6844c41d187d113e0c54dd156ba91c2635c361.camel@perches.com>
References: <3030138.e1gdHPWlgN@pcbe13614> <4a6844c41d187d113e0c54dd156ba91c2635c361.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(33896004)(186003)(23726003)(16526019)(74482002)(229853002)(8936002)(43066004)(46406003)(478600001)(246002)(106002)(8676002)(97756001)(76176011)(6116002)(26005)(14444005)(305945005)(54906003)(7636002)(6916009)(7736002)(44832011)(126002)(476003)(2906002)(106466001)(33716001)(786003)(9576002)(4326008)(316002)(53546011)(86362001)(230700001)(336012)(3450700001)(356004)(426003)(9686003)(11346002)(47776003)(446003)(6246003)(486006)(50466002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4725;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b138ad1-08b3-4d65-6f4d-08d6928da7a0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB7PR06MB4725;
X-MS-TrafficTypeDiagnostic: DB7PR06MB4725:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR06MB4725;20:3HSO5vVKtCKHcmiPuAix2VatQaYUwl/rNT8n/ph+vN6Ya96+bVnaLoI0p5TaY0utC1b8660WkAbYaFZRoKB2l5/YmGTFefN6SPAEYvDxe7Ntd5NhivWYDrMczRs70couiDJWpAGPqFMKDfmn6kPjE3UMC1FUpfLDdLmqmlcRzx5npy70OQo04QmvnKWVIPQWvCL5AqA+QA6G4fVhKa86qo3jgL4UQyd0NVrLEbxfbiuYOl08z0cZBG2ueFb91G0+x5Dck1k6eMqm8j5rIMWU56tG4Kfb4saMqpw/zEvxUF3aIPx4/uiWYBgEs//7XtNxwcoAHx46C5qhDQLOBTUzl0CzWGHn0+Nw11ATcLz99FUJzjh7DipTDUOSwuvNbXgVwnXM1/Anckoe33OQyU8GvxQtjRfDq5VTea74+cd7BY1pDRNgzjOJlXSb2YTOOTF5+rPjBaHUTuNoPO9dT5ZAVpILE0Mxh2V6r27P/8OaCE2BL+OWNGdJIBsvP6e5+Yxy
X-Microsoft-Antispam-PRVS: <DB7PR06MB47258DC4932483139127C842EF670@DB7PR06MB4725.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR06MB4725;23:sIRp4QV+IKoTOeGSFe2f9nzvMTr8ybvLLtnzni/u8?=
 =?us-ascii?Q?EL3mwZjShSOwaWDTM0HrTesPmOK1+087zszVNv4cqhBH+vS+oMH31yYm7AH0?=
 =?us-ascii?Q?1B60uhgTxVPHYEutJh7MMrg/vMTnNYAJV6llHrVn010zUi++dmJckEiKIaex?=
 =?us-ascii?Q?Za+YWpIlHGmTdkU52XcTRdxe4RPuApnc2Bgeqq9CgQXsExIpgcRKz20XoAlh?=
 =?us-ascii?Q?5C8CxKUWQYEhf/u+xwxpZfTu2kMmc/ZO2ohWwnjomgcNccv/xlbRCd+sTdm8?=
 =?us-ascii?Q?3zewnoZotHhu2nS3kum4aShB4oo0801wyqUx/FGmq4qNqYMtRYNbW1OrDpae?=
 =?us-ascii?Q?rN9ot0nQjGeChipT/BU/uAkFSEdLNuQI2u7miSEKvXkVR5IDsZFTzJX+YTZF?=
 =?us-ascii?Q?Go5IuqpimOkgzhHNz2gYXDnQevkSYyBrSNRYn57DwHJTof+OGvQQxIT+v4D/?=
 =?us-ascii?Q?+ywBnMURA/Wgg4fyF5Zv8Iud5QUuEQPu2zknfJj6C6w+qnyo6/Yn+7N/pCWw?=
 =?us-ascii?Q?mP32HqHwzuQQL57pM/C+hQJeU88NBgp7MU/32/3LR3vnZaN8IatoQdVaBJDR?=
 =?us-ascii?Q?H4YCd/SIs0UtrzQjwdNGIuwDqQquk/U+yIx1dy93p9iFY8ehxbfbZvR8SZ+R?=
 =?us-ascii?Q?yAJJ38VFdT3/UdZ+ECh4rx3t7wglqvGHi983lYfkYSCrbRM2xAtbepMGQZyv?=
 =?us-ascii?Q?IZY7Sk9/s2z0I/tsfcxUfnx0jw+cc+kNb+onHIDL5IYIQxkK0dCBT9uuMepk?=
 =?us-ascii?Q?l2FzOGOzf8iLCQFHTexSb//0raBTJIoLirj1yb/JBSF5hlCqrhQxoX1V2RLk?=
 =?us-ascii?Q?yMK7H8j1Yn9jGTFiPRKkb9eUrGg2t6uFy+45SeFw0PovnpRGCDlztlk3/FxK?=
 =?us-ascii?Q?ZIWJ1Maq3fIR+5LeBfRA654n/1l7vDfGiUHwAXAzJ5pr44FX05KsaezbTyIP?=
 =?us-ascii?Q?K5g/hrjnQYKIsezN6nPZdSKQOwEkHQ74nURuvRlwmb28wPqBRnrHKVLmLR4f?=
 =?us-ascii?Q?NkDi8HX25+LUBDMVAGOtjrQs5N9PQV/VTmptLvmk6BpYdsaBxH0Ma4WyABtm?=
 =?us-ascii?Q?f67afxwXevHGqD/ivkI9RISlHJD5D5NZ5jJk8JmJTK2qFCc0xMpEDW8aSMKt?=
 =?us-ascii?Q?ALdznhsoOfG4jgQ4Fd+qR8GTqLVd3c2ohUas7TTWxth4O8fJKaDxEMctn/A6?=
 =?us-ascii?Q?weBbMTaCBQxsW41rbnDzjlPa/I6iIwYiao2manBODNryPngkbRiIpNQGA=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TU0Li5/XHkDmOaNPX4P1S5TBCt99sHhX7yJ7730sh0MJAO1IueuUDY4WWzttaQnGAuvfozRar3c9Hyuv9thr0dn5gG1UBaIndf9UQz7vOw0wUxdK4ig1+LR+jbIAp2CDbiCarv1wMOuzv82Gk0nYqf4yn3iV6c+OHBw4uMrDywaH6wlrtYgC/gWI2kJkDW70erBFMX9mM+61t24nA7qPydmNEMuZGkqwTEOlT6stK+kT6GDQjq/yPndfMK2Id02KGpc5oDHTfImA/n3Nzyus7Wl027A739yJujutoNUoBlfjS8wj7WY/7nHlbrQ6HnU6379utYVnAXxtgiZe2o+7ExQXJvpawg0oFhQg98LgnVVqN3BU/EtjxIa1N2j0thbqixwVbWpkqkKXJOXhA3r23q4v1q/ozHODzX34IhR1zIs=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 15:04:01.7275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b138ad1-08b3-4d65-6f4d-08d6928da7a0
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 14, 2019 3:44:55 PM CET Joe Perches wrote:
> On Thu, 2019-02-14 at 13:48 +0100, Federico Vaga wrote:
> > Hello,
> > 
> > Recently I have produce a couple of patches but I get different warnings
> > if I run checkpatch on the file (-f) or if I run it of a patch file. In
> > particular, the problem I found is with the spell checker which seems to
> > run only when the option '-f' is not used. I am wandering if there are
> > other similar cases.
> > 
> > I do not know Perl, so I cannot investigate more, but I have a practical
> > example. I have this simple patch applied on my tree that introduces a
> > spell
> > error:
> If you want spelling fixes on files you have to use --strict

Thanks

Is it a design choice to have different checks enabled with '-f'? 
 
> > From: Federico Vaga <federico.vaga@cern.ch>
> > Date: Thu, 14 Feb 2019 13:29:39 +0100
> > Subject: [PATCH] script: checkpatch: buggy(?) output with -f option
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > 
> >  drivers/i2c/busses/i2c-ocores.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c index b32d67c..f4deb90 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -301,7 +301,7 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
> > 
> >  		/* on going transfer */
> >  		mask = OCI2C_STAT_TIP;
> >  		/*
> > 
> > -		 * We wait for the data to be transferred (8bit),
> > +		 * We wait for the data to be transfered (8bit),
> > 
> >  		 * then we start polling on the ACK/NACK bit
> >  		 */
> >  		
> >  		udelay((8 * 1000) / i2c->bus_clock_khz);




