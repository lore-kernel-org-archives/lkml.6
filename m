Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F42C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9897721B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="iEX+18dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfBKQSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:18:42 -0500
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:65026
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726941AbfBKQSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF7OtAn9lY0/p7a4ELx9mrT1F9T/r8RJ2J3gSmvmsoA=;
 b=iEX+18dJjNQEShlN2lsSS/mWAvh0pMd6jSOugh1l6j++He3SiONKjzRfLYt0IsUa8WWFBMyVm8qDJZ3uJUqSC1w7bZ7/jArmgfePh5aczIbwK4kWtEIGrchU+Y/TYniu4+o8fsXXTVbxqhKOYSxX6eqTKSY7ZfBrEkkPdX5gVG8=
Received: from AM5PR0602CA0022.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::32) by HE1PR0601MB2153.eurprd06.prod.outlook.com
 (2603:10a6:3:29::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Mon, 11 Feb
 2019 16:18:32 +0000
Received: from AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::200) by AM5PR0602CA0022.outlook.office365.com
 (2603:10a6:203:a3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 16:18:32 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; axentia.se; dkim=none (message not signed)
 header.d=none;axentia.se; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 AM5EUR02FT056.mail.protection.outlook.com (10.152.9.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:18:31 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:18:13 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 11 Feb 2019 17:18:13 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Rosin <peda@axentia.se>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] i2c:ocores: checkpatch fixes
Date:   Mon, 11 Feb 2019 17:18:13 +0100
Message-ID: <2547581.38QU9fvyYn@pcbe13614>
In-Reply-To: <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
References: <20190211160529.23858-1-federico.vaga@cern.ch> <20190211160529.23858-6-federico.vaga@cern.ch> <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(199004)(189003)(8676002)(9576002)(7636002)(33896004)(47776003)(305945005)(8936002)(46406003)(246002)(230700001)(76176011)(7736002)(33716001)(6916009)(74482002)(316002)(786003)(106002)(106466001)(54906003)(2906002)(4326008)(9686003)(186003)(43066004)(3450700001)(446003)(50466002)(97756001)(11346002)(44832011)(478600001)(426003)(126002)(86362001)(476003)(16526019)(23726003)(336012)(6246003)(6116002)(26005)(229853002)(14444005)(53546011)(486006)(356004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0601MB2153;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46e1211d-63e6-47a7-1f63-08d6903c90c6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0601MB2153;
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2153:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2153;20:lZ6x0/NjjR2+UFSCCn/ivIm04isd6WO/F1tQ6TvinUSOYE/YIr6FxPS3sAIdZgkfHo4QF3alxeyNbevre0OkXhkRzQFCgwnFLCal0N2pBAs5eAQEGrAYKRwjOPBcaEWdqo83G9GmawfRE0cgINtdIidpKS9Me3gy3IuE/NwOV5ysBIOTcfJKxcPMl0PiFmA+fce36IP7Gtku1GKQ0niMvimFdTBMWlwsgo1zS5b+R9b8xaBwRNrCajIFnzeu4jIc4TABQGUXKIX0FC/zG2JQOeH0qblTxDF2UeD76OZO/u6BEQVjDauyTkTpc2qLD1u6pW6yH5HdUKkfIWagqL2PdKL/ZEfhMMzBCcLFvU2ryL0R4/LlZ/31+z9zNICOXvNLbmqC6RSE3Tvcy9DQrfyV5Y4nXVq9TIZh070F2Vw9gFqaHDlJD5kgeSeKIO48tYMhRWQQZ1kKIcpLQgTN/sfB4t1DmGWsHMymM62TZWlNrrNG5hlnr24IZuLJyyjB0v5n;4:a0tZCcwOe+KRAusuqOTZxUKnCef1009cQjjwXjLHoNcMi2bDvPLnKR2c4eiCWH1UVYQaCJArklMNyysgoCI6r60ysGpDsWHmO2ztJT+9djThPXyGG+mFhKXG77/fc0TvnoLpXH939UtA/q4LJ7PHPUSDMyiQKhsA9nForQxxwt3S5sWrhnrYFeqCpqJ8KMUiPCWeiICjTWOrKyMIbDZnQ4T9ccsCztAt8GHWf215CL+HeFp/GkJSFFS2dnuLlMOzfQX8pNHClxuxYASTy6Imixxgyq9dg62iCfnVQCKFUxc=
X-Microsoft-Antispam-PRVS: <HE1PR0601MB215364625D71B3FD22606C29EF640@HE1PR0601MB2153.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0601MB2153;23:wIjCyH1MA3Pr1JqO9KQNluHP2QB4AKMg6JPIIbF?=
 =?us-ascii?Q?YbVoUq9RWB6fHhsTJFjvUxFE0L9i0MmGKoEHOt2wKfwJhLbY/ofYjaqLGrSH?=
 =?us-ascii?Q?b2nsC1Ap/3zhTloLeSezM91o9bNU9EKRTs1z4wO0hb7HVDWxhhtKJvh6AdIf?=
 =?us-ascii?Q?dND5PLYhtbZYD2UJTKKmJaYf1uk4nfAhpuh1rMb5sB3JrHx8mzgovsa04JJ7?=
 =?us-ascii?Q?q1OJnIa+MAXaKwc8ENaRZaGdIaV72pw6jod6rUO+Bngh0ER5eGbPjL+EdPX+?=
 =?us-ascii?Q?CG9DvijoakHy7Ehd54kX8FaIR8urblFGUVHY49VYUZx8MYS4dA/fdf9+zCrj?=
 =?us-ascii?Q?Hu9X9h7LLTLyZ7u7QLHEjvFD7W8+jKh1LU3qkYcRb47TuZMARbIDkJi5Ycnp?=
 =?us-ascii?Q?WcxUz1Mtu4Vy4qxA69KI6YeavES0aOIsAJ5MtxI0QS2A32pOt13zukAjuqMo?=
 =?us-ascii?Q?7EuCD1riRZ2jfKT+qopWeL2sIlh3kWUs1oHANpdKWlJjvoKNRfBFG+cSFbng?=
 =?us-ascii?Q?JVx5hfaL4I603rKyDnM22dsew1jBVceY0oEXI9OjBER+vw60xtYgiUsmYODl?=
 =?us-ascii?Q?QTRDzQsMoZWsOYELJe1lzPIkqlD/RwvfGhjb0R1aJFuaVyZYe8Xs5FsUWQrq?=
 =?us-ascii?Q?KtneeiTRqKKRfK7C73usaKw+uRZQqS2K/5+9BJ0eM9iAJM2CPXXsWVVPpwJP?=
 =?us-ascii?Q?xhF461Z4bdgmrffR135egpZxgW7tSo9y6SDwYFK6Gvzoh8yxzIPa0aPxkV5u?=
 =?us-ascii?Q?E11i5nkbzEcPb77phHEKoCkyLKNsQmroozpvFn4soFA56pg6zrVcouv2igwm?=
 =?us-ascii?Q?xg8Zc6AmrxtjKAc2+4IHB7JhjEEFxt+j5P4n2UuD2+rpSnPwkQGIqhBScnxZ?=
 =?us-ascii?Q?7E1hR17GNyLncQnLqBL98ipLaqAHFXY9YQeX11040iTyY+oggVGyRAceDGLg?=
 =?us-ascii?Q?03Gv6dOusBr3SifzmBJa/9gmKe4MhtrdPJDF2kbfcmgumcVJBmzSSvoqDz1q?=
 =?us-ascii?Q?7ZfNR0MuVPmuGxBuDiT7MUYLFrDikk+dZkjUXCqB+UbtUpECvtiTP5kitIvx?=
 =?us-ascii?Q?UKcW4wHdeHGT+loeN9rGPmloVCcZeZp8A1sj2HfslIm2MWO0BQIWlcvAn88k?=
 =?us-ascii?Q?9Z2zHSc1W4ke7Y8P5+GDEddZUmQK8dGHmuE/uohUjqkc0mNt7azwkbJPiHfs?=
 =?us-ascii?Q?9vhLut3UTecRWG2HODPr4GVeTWGIzl5rcRlSIkwnkv10TnmQE9Wn/cQtvzQ?=
 =?us-ascii?Q?=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XFB78h4KBmax2f83dJsDnH8STA7667u34d1v60qhFz1EdtVYRjnE+O+dTMLrTn25YM8NecuMozN0T3yVfOYxX8PZ2+gV/va+sfsYnDU09/eA/z0ekVU3iLeTQxsjtI6alvQcTPUqyIoPzVC7QG34ypaiYwWhAS99msfsIpJoXvDv6iqEu7zQXACpy3rkQxU65ZIb2uQCQSQeJ8kHKEXAstiTcWXL+LVX5yOVEvKZB2QpHAxRzIIevaCM7WNujN3/wVohMBbshuDGfTudYLK6wLkIv9+J8NX2J3BN+wlQDtquXwkjrwqVBaNEzG/oNEp8dtMbgmAae7C0akNWK8anhPKr/3CXr4a87Tpvtb1C/rrWyZDEu8jIaq/G4gDnyXPEFrw7CxTLEdqbyLNfivsGagdBUsEIw2IFbJmCthd/aAs=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0601MB2153;6:WD75RTmrU898pnU1RHJQPrz3sNhqPkXdmiTNjNUkXA/sEZRb2noLH4fFwezStOJQcxed4Die76tqgr1YdLLqudzddIXpWmHU28TjjWsJCygznkESQAIAc1ICLqBrq9X25BWRVcUbgcOgidld6A1ZDT3mRgiAk4sKahat9pwQEzrvIZKQ+k6KKcCNmZ4jO+0flmnFiJBvojRq0gf7gaTzNqoRh7EJ/l1hWUiueJHVoiQi3jHOttjLKzlA7zXm3bhtZRc3riiwVSUvRwTlG5xPLtC66BGWy98B62YpLmYx5S7syHWiH/79U07kEwFXzxNfV8KQwAgfb4/pNOv5WZv4ML70dHGrROHQR4wGRLBpw+S7y1F6zpRfBcSGqfNwOvJJYLboul/h77Dkclrs2KgA/6e0MHX645MSiQKkSZxDedyKSwmzE/X7sGWNKpQ9AGGcYibf+8tZTXjz6SRydvw04w==;5:5CNNuBnPLeCUzzbsix8fm9EvNh6VL2oAFLCyiDQ8bcO8ArE8cXhchJx3KwWRwXJt0aBifjhaiO34SYo8quxvZjBC/ohrLZYSES4DNQmx3wKTOqjxFNgHEpEYVLhfeCxHRLSlBPWFq1GjlmPqy3FSxO4qyGssL9PLEHcHHQLifoEMqg4CNey97/HeP5M7KHwDPWb19s/vd7RFh8a1w13QdA==;7:j5TTVL1pfPxZbIZBtAWIdMdw2nsu16P5E4zqV939/+LsSRp1QVQjlIfjVloVlxoA1nv4IrdnFq3ViPKKPdyfM+yhl3mVX58mi8B2BHPwG4mkbLqvuS/hRq9TKFFeuLVKS2DoAqagAiCA9hY4pp0MuA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:18:31.8392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e1211d-63e6-47a7-1f63-08d6903c90c6
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 11, 2019 5:12:23 PM CET Peter Rosin wrote:
> On 2019-02-11 17:05, Federico Vaga wrote:
> 
> > Miscellaneous style fixes from checkpatch
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > 
> >  drivers/i2c/busses/i2c-ocores.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> > 
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c
 index 78085a8..54b2156 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -179,8 +179,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8
> > stat)
> 
> >  			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
> >  			goto out;
> >  		
> >  		}
> > 
> > -	} else
> > +	} else {
> > 
> >  		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
> > 
> > +	}
> > 
> >  
> >  
> >  	/* end of msg? */
> >  	if (i2c->pos == msg->len) {
> > 
> > @@ -197,11 +198,11 @@ static void ocores_process(struct ocores_i2c *i2c,
> > u8 stat)
> 
> >  				i2c->state = STATE_START;
> >  
> >  
> >  
> >  				oc_setreg(i2c, OCI2C_DATA, addr);
> > 
> > -				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
> > +				oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
> > 
> >  				goto out;
> > 
> > -			} else
> > -				i2c->state = (msg->flags & I2C_M_RD)
> > -					? STATE_READ : STATE_WRITE;
> > +			}
> > +			i2c->state = (msg->flags & I2C_M_RD)
> > +				? STATE_READ : STATE_WRITE;
> > 
> >  		} else {
> >  		
> >  			i2c->state = STATE_DONE;
> >  			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
> > 
> > @@ -461,13 +462,16 @@ static const struct of_device_id ocores_i2c_match[]
> > = {
> 
> >  MODULE_DEVICE_TABLE(of, ocores_i2c_match);
> >  
> >  #ifdef CONFIG_OF
> > 
> > -/* Read and write functions for the GRLIB port of the controller.
> > Registers are
 +/*
> > + * Read and write functions for the GRLIB port of the controller.
> > Registers are
> 
> >   * 32-bit big endian and the PRELOW and PREHIGH registers are merged into
> >   one
> 
> > - * register. The subsequent registers has their offset decreased
> > accordingly. */
 + * register. The subsequent registers have their
> > offsets decreased accordingly. + */
> > 
> >  static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
> >  {
> >  
> >  	u32 rd;
> >  	int rreg = reg;
> > 
> > +
> > 
> >  	if (reg != OCI2C_PRELOW)
> >  	
> >  		rreg--;
> >  	
> >  	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
> > 
> > @@ -481,6 +485,7 @@ static void oc_setreg_grlib(struct ocores_i2c *i2c,
> > int reg, u8 value)
> 
> >  {
> >  
> >  	u32 curr, wr;
> >  	int rreg = reg;
> > 
> > +
> > 
> >  	if (reg != OCI2C_PRELOW)
> >  	
> >  		rreg--;
> >  	
> >  	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
> > 
> > @@ -569,7 +574,7 @@ static int ocores_i2c_of_probe(struct platform_device
> > *pdev,
> 
> >  	return 0;
> >  
> >  }
> >  #else
> > 
> > -#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
> > +#define ocores_i2c_of_probe(pdev, i2c) -ENODEV
> > 
> >  #endif
> >  
> >  static int ocores_i2c_probe(struct platform_device *pdev)
> > 
> > @@ -686,10 +691,11 @@ err_clk:
> > 
> >  static int ocores_i2c_remove(struct platform_device *pdev)
> >  {
> >  
> >  	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
> > 
> > +	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> > 
> >  
> >  
> >  	/* disable i2c logic */
> > 
> > -	oc_setreg(i2c, OCI2C_CONTROL, oc_getreg(i2c, OCI2C_CONTROL)
> > -		  & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
> > +	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
> > 
> >  
> >  
> >  	/* remove adapter & data */
> >  	i2c_del_adapter(&i2c->adap);
> > 
> > @@ -707,7 +713,9 @@ static int ocores_i2c_suspend(struct device *dev)
> > 
> >  	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> >  
> >  
> >  
> >  	/* make sure the device is disabled */
> > 
> > -	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +	ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> 
> 
> There's a pointless double oc_getreg(i2c, OCI2C_CONTROL).

Very sorry for the waste of time for such a stupid copy&paste error.
V6 is coming.
 
> Cheers,
> Peter
> 
> 
> > +	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
> > +	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
> > 
> >  
> >  
> >  	if (!IS_ERR(i2c->clk))
> >  	
> >  		clk_disable_unprepare(i2c->clk);
> > 
> > 
> 
> 




