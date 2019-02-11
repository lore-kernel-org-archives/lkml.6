Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A0C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CDF222A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="X3POL1Jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfBKNqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:46:49 -0500
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:19872
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbfBKNqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcojRS26VhyNwDpPRr6Afn9YsDW0jyKKoTUtENA0Uw0=;
 b=X3POL1Jj+/Q0D6Ne2wyIS2kJbiiAmQ3n2lzoF+AviauAPnXu6sRfvNJjRGwaZE92wH+1YP3Vvze02B8Xed+EjRiVh47C0arnzWIUkshWuQvJdDlQjpPMdDaFFHvdUKtnJJ0t+EE41FUWPNmY8045iOm5F5Q1uvV3HKTsc3nGbcs=
Received: from HE1PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:7:16::25) by
 AM4PR0601MB2146.eurprd06.prod.outlook.com (2603:10a6:200:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 13:46:42 +0000
Received: from AM5EUR02FT038.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::204) by HE1PR06CA0138.outlook.office365.com
 (2603:10a6:7:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 13:46:42 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; axentia.se; dkim=none (message not signed)
 header.d=none;axentia.se; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT038.mail.protection.outlook.com (10.152.9.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 13:46:42 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 14:46:28 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 11 Feb 2019 14:46:27 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Rosin <peda@axentia.se>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] i2c:ocores: add polling interface
Date:   Mon, 11 Feb 2019 14:46:28 +0100
Message-ID: <14487566.fPVnE3aI26@pcbe13614>
In-Reply-To: <5bc1757a-3b74-5c77-7c39-00c2513683a1@axentia.se>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <1845501.4feNL5aF6H@pcbe13614> <5bc1757a-3b74-5c77-7c39-00c2513683a1@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(46406003)(86362001)(356004)(230700001)(50466002)(6916009)(6246003)(16526019)(26005)(14444005)(186003)(43066004)(9576002)(3450700001)(478600001)(54906003)(9686003)(476003)(106002)(126002)(8936002)(97756001)(486006)(426003)(4326008)(11346002)(33896004)(316002)(53546011)(6116002)(74482002)(786003)(33716001)(23726003)(305945005)(7636002)(7736002)(2906002)(76176011)(106466001)(336012)(229853002)(246002)(44832011)(8676002)(446003)(47776003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2146;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eea3ffc-9cdd-4bbe-0e7e-08d690275b00
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2146;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2146:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;20:Vj74o8OMilUrTuCbyhdE6o+Ffn0Ef5FEdofV3C/9fHOA1klSKTbpLccuIKDhc3XIAphwLHYgDNPz59cfJ9lSv2SLPbHddJ2SO6vGFTSpSN12Mcn6narww9cekzKxgrfoJVrreldaEi2SNJwHvM+NNgP0alWcZQG9tzd0wUOQOE26EOoJNzHvtXP9hBYK9rLH1JUo2iVyQi4C4f4wEdd/zVoRKT6JILr3zBWtD0YO0BvXZakgZ9xihUXBOz6jFFTrh82kdT7terJlwoLf3o3df0RoNCYKxNbVWCn5JGYpn0DX5GK5iCtl31SOOkbEVzkYdxpVc/gj6KeyhfO+LrJsA83GO7oiQfLWhns5miIqV25wG8oXEpQ4crh+LSM6DGpJujZdz6kU9gXVIBIO2RhJ9iCxmxPAyg7a6MqTazQi4aTCRfHa6wQ76ePp7eJOhSvLJa7aHb2MRHFuVTTX/oxWE2doweiOg+vXEG1sQ70cm7hKQccUqaKApm3Yz9u8XGZO;4:Jyn5ba77FBi+H6nnzXTwslycRVe7J1C7trHhQUBkImqdv4xoYYS9kvatgP40KjF6zsDkpRM1KiugpqHYjcTyQXK6L7iZu1g5c5OXOD5JwkBk6UEh6EH2mz5v1Ait8ok19g8oySmJ694rb4DP/25Zoa1xwGprs96l7qh2ogFmYVjl23CsChmJBDXD1sGrN8HOY1eIlc9FKdUWdoWgDynOfHtpmAeFFx5tT5PpBb7DFGgXeaqNpMMpqHO/9XMf1JvQFSFTobr0KZMDRRlH2wkbHDTDO8aQ0Zw19Ssr72pHUAGoDQeiFQ/8VAnLDyUwnbl6
X-Microsoft-Antispam-PRVS: <AM4PR0601MB21463899A63C614404876801EF640@AM4PR0601MB2146.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0601MB2146;23:JotQhr1ct0XyX9QqPFKLzE7MDKnXChxTauG3unR?=
 =?us-ascii?Q?slYRgWVe/W0Py9WQxIa4BPFGv+QbgRtj3+2v+X4XkrOzRqZTQlcOQiUpSncU?=
 =?us-ascii?Q?dnQWHEbMD9AlrtFPtKmgut5O8GYlznGvdwxHL/aIytJ4eZzEe/wdhvUWKNT/?=
 =?us-ascii?Q?mVRCKpqmQP/WG/pOZYZzUsPb5UbE5Uz8UOoNEzcvzSW1Wo1jKy7MrOeTZv6h?=
 =?us-ascii?Q?tr21LtEr8lFmNftHAUKAxthZsXMsYwvxOBBhgQbgyR3MbGO9gIMEcXk5VtYg?=
 =?us-ascii?Q?Kylt+2S2VectGv5vUonEGAMltJPj74cZHH5nfwx7PeA2fSps2IG+muF2VdV+?=
 =?us-ascii?Q?PaYYCEacRqcap65NZtNe1kiDFEG2WJ6tVnFY4GjtVJ9QZCtreBGSAm86xUHZ?=
 =?us-ascii?Q?cmsnZCAV4k1u5WtJc2pR+CuDPG9pYoRtGYOqB4xsw8W3gypGxW8yQ1P22MrI?=
 =?us-ascii?Q?nGrevp7pfvfHM0qUmsfHCDT5dhxV+C2RP01szj34o96JcvVCC0V2ANmGf/FI?=
 =?us-ascii?Q?09nN0L2PIG//rp+WuIISYJRZ3o2EIQBCZvr5toL8siYhKWvJXH7KOadUXW2L?=
 =?us-ascii?Q?2XkaQ6YWvb5+Ih7uzP4OQ0DErY7RQhJ4hg91yDJMtAkjUR4MV7jwhc7cXuIW?=
 =?us-ascii?Q?S5r3QhNdHC4+YngqJfQb2C/qpselIJ+KZrrv8u/JaBI2Bj9zu7SgGAquGo0+?=
 =?us-ascii?Q?3+yVtS6o6ffOygP7AVGPG27jgdi3BhjWzXryX3aGGVsFPt8sYW/JgubGHH6Z?=
 =?us-ascii?Q?QVjO5wDOyENE3lQn6EPff8B4uKKC4nH32/nWaiuM7aASNdIt1WCzKqw+v16Q?=
 =?us-ascii?Q?64KG4MIw/BW/WptcmnqcC+55nx5UZFrcW0+/HlL/qNervnKHdMjf+8h93ItF?=
 =?us-ascii?Q?6yqS1/5chg6+LXKyjOMhrIVtTefi/HqVzVCRxb9/t3q1zH01CXyUbSXWonRd?=
 =?us-ascii?Q?a2lnayr45a1fsaH1ciByryA8PxlaEsdRKdr8FILzHAutHXiYplfDnurCdoBk?=
 =?us-ascii?Q?po1qviHDkJZ7Db5M4eEE89S2Iu1pLqOdA8FexGBCURYzKV3L/axKKxciCQcP?=
 =?us-ascii?Q?vPLYij+qGTUDddiZXj6+E6K2pAY4yQSfAVgoK6yDPGkSgEO2FjwNqbfRul2w?=
 =?us-ascii?Q?tfssb4nDAcQVKZfENwiUadEZeslkQ4WgVb8KsPvxesjie4pxajxmrkmDU4AE?=
 =?us-ascii?Q?vdA6WC14NJOnpQafxElThkKWizYMlmNk1FR8fP4Fvgu7gRR1J6mEwV/17Vg?=
 =?us-ascii?Q?=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /3Zt9SFDQSGWM3YJlRw6fDqCjLocAmN/jxQis6eGjyT0aRATaThuP2kzemiXg/WLzdXrp6wA+xTu0gpdY+0QpA7jjeRj1yhjyPPo0AXAOA9gAbDRQ7Gyu2F+h7YYWv3RXcLS6CJWXSCqqK5CsnUd8FZOB62P2263SH0L5+KACM6cWzF2kO7g48LT8zmX4GX0nHHtke+L+wtHSCfdUxkkdBU5Rml2y1IWb1v1g6DOQh2qor16nMsAhjI+E+rd4mPbA8jp1OqZqkwHbRp0Pc07lkDyndIXr3gTnUd+KgYbZGSM5UU9Qlu83m2AqVUUDDEXXLAOsfMQ2vTJrAOHWLP0TiLkfeEiABuHQxuKlDdnnWGCpHUUjKFczknYVsySGN9NX71HEgfE5BecG/2SkBpOEu5OB12Vywzy2s/r2kIoyNI=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2146;6:zMxwurwzd9EjCMl2jYGjNZPNV9JIBhCL5s+1BgBTLLDJSK7lmHlRVBi8Guh9d4rC/G9OdQgtXgDp0shE8fFtCZ4pGH2p6oSO90vuCQ4L9eNzyvtxuUeNGzEs3RztJWe6mD37P+mBae+Uu3UdyFl3g9JNMxQgA6ADWwGbNMeSXX2einKD1a2y2vzqR3zAHpUouFERDauAnYMP9rm7DW5bqB8Td+08ZWApdxJtXXLFsUerqTP2BNl6kWoMxhFdARPasHGKuEExqyfhR21WM2UFVWHViKxtHdkkewvOJjz+YQzfh7LMIcj8BIMhBJ7VM99j90Zwlq5XbU1EQm1g3w0RqnGfc4fhHqVoi3lIutCbugEa/k7hm2+5WV9GrCPE3BMWFFnWDW08eE+id4xHtAfD103Z/sJFeTfNhBgoLW1JwNdyJjP8vwQ5MYUnaaYsw24ukR3MYIm9z5S5xFidbe0huA==;5:gOHKL14E63qCOuhAoLSmQTkQY3xexlboFObwD9HY8O6mOa80O6PQiLNxQQnizevcb3A+dmtc6TgFTvjX1L+m3nBlsP3DwfESwvONamuSiiwU4+tiKXtG4cvngNIUhVfJZEGZv+GPeLozzCOcqO1G7OFauh30yT02GcG1GiuzWB3sQfiJLLUIySR0D/OtJVWpqazzK11ztvsIUI7xt4eVsg==;7:Jabv5Hpw7P/yF5N729Y19ofmH97Q4yNtchyp0GErqfRnT0NkgxdFhG0CvokfDwqqBx9O8jhXMkSx9lxxkXi/06aAhtvWAcUWsqbehgyuYuyH3sOu1ZuTo9Ux+Z3xsqhkYMOJIP35xtEjKi3MLbwTtw==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 13:46:42.1616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eea3ffc-9cdd-4bbe-0e7e-08d690275b00
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 11, 2019 2:35:15 PM CET Peter Rosin wrote:
> >>> @@ -294,7 +427,7 @@ static int ocores_init(struct device *dev, struct
> >>> ocores_i2c *i2c)
> >>
> >>
> >>
> >>>  
> >>>  
> >>>  
> >>>  	/* Init the device */
> >>>  	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
> >>>
> >>>
> >>>
> >>> -	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
> >>> +	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN);
> >>
> >>
> >>
> >>
> >> You fix this up in patch 5 (in what is perhaps carelessly marketed as
> >> fixes for minor checkpatch issues), but for this patch you are actually
> >> no longer making sure that you clear the OCI2C_CTRL_IEN bit as the code
> >> used to before this patch. I think you intended to preserve that
> >> behavior, no?
> > 
> > 
> > I think you got confused by the two patches because those lines look very
> > 
> > similar.
> > 
> > In PATCH 5 what you see is the "style fix" to clear EN and IEN before
> > clock 
 configuration
> > 
> > in PATCH 3 (this one) what you see is when later (same function, after
> > clock 
 configuration) the device is re-enabled (EN), but without
> > enabling the interrupt because on polling configuration we do not want to
> > see interrupt flowing.
> > 
> > So, the behavior is preserved for what concern clearing the IEN bit before
> > 
 clock configuration.
> > 
> > am I wrong?
> 
> 
> No, I don't think I'm confused and I think you are wrong. Current code does
> this:
> 
> 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> 
> 	/* make sure the device is disabled */
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_IEN|OCI2C_CTRL_EN));
> 	...
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN));
> 
> Here, the final oc_setreg always sets OCI2C_CTRL_IEN.
> 
> Patch 3 changes it to:
> 
> 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> 
> 	/* make sure the device is disabled */
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_IEN|OCI2C_CTRL_EN));
> 	...
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN));
> 
> Here, the final oc_setreg restores OCI2C_CTRL_IEN to whatever it was
> at function entry.
> 
> 
> And patch 5 changes it again to:
> 
> 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> 
> 	/* make sure the device is disabled */
> 	ctrl &= ~(OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
> 	...
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN));
> 
> Here, the final oc_setreg keeps OCI2C_CTRL_IEN cleared. I think you wanted
> this deterministic behavior for patch 3 as well.

Now I see what you mean and I agree. I will move the fix from PATCH 5 to PATCH 
3, so that bit IEN is clearly cleared.


thanks

> 
> Cheers,
> Peter




