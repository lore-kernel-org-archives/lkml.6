Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1BDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCAF21479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="J3qGt7kB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBKIU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:20:56 -0500
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:16112
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbfBKIU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2Alb/oGSq4CxwtA8gkZDbXwmf+LDO6M4tjDiHOe8vY=;
 b=J3qGt7kBJqpU7EMOq/m1mRA94PL3bjW3yEJnAdP6fDE2GOVZQ9m1Dcg2X9X2pyeU7fdjynKe1Hwflm5N1V2X/eRvVjsBI/qGn3DGaqCUxhcyRshu4Vx3TabXpqcT2MNwRZ/jXSZhf6gkWqwKV3PsnVogqXdriRfw7ohMd1+fELc=
Received: from AM5PR06CA0033.eurprd06.prod.outlook.com (2603:10a6:206:2::46)
 by AM4PR0601MB2147.eurprd06.prod.outlook.com (2603:10a6:200:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 08:20:52 +0000
Received: from HE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::206) by AM5PR06CA0033.outlook.office365.com
 (2603:10a6:206:2::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 08:20:51 +0000
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT025.mail.protection.outlook.com (10.152.10.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 08:20:51 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:20:33 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 11 Feb 2019 09:20:32 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Andrew Lunn <andrew@lunn.ch>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] i2c:ocores: add polling interface
Date:   Mon, 11 Feb 2019 09:20:32 +0100
Message-ID: <1894984.UOdFTssdus@pcbe13614>
In-Reply-To: <20190209213353.GA9061@lunn.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch> <20190208161201.7860-4-federico.vaga@cern.ch> <20190209213353.GA9061@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2147;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951940c5-5e3b-4481-1e42-08d68ff9d5c8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2147;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2147:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;20:BLDhTh3S4a9ofs4r7AMto/0baUF3w+pWjllW46NYIxEZms4uhH0KnqawdnK1vCpVhH7GYcWc6zbWLUKDMLOndtY4ojTVfAXQezIeV0/JuCdnOg4GpVTKp88WC8qVkQqVKxOOv0accMlTxULq4MquBdAibDsHpxxEAYiIsaQ7adxC05PhFAL2BGmtp1rMt9jQ5yeMfdlHtKh66u65GbWoje3XHQwtILXnyXyusNSM44Q5gU5SXpL8c6bpiAd5Y6gfWZjVbeIO4/Nl553ppbufzzlqcJ/FTsj4/lLeR9B38gSiqL/VtZX7BwFer+b9458vfxVOYS8QokF7BQJ4lcdbwqpO/QEQTCoHX7QuahvmcXmUmUH1mDpdsBwZtr19vc1uf0JrxATRuPrSxvA/Ay5SKHUx5vmvB7ia/qjtLMzkxPqHf7+3iOzBa2g7iJVj5qeAQ6yWJIW5bpVmOo4uXaD0bIMsNFDrK7fFofaoA3bGYvGK3pFtGHtbnLCFF8Rgzi3X;4:WckMpa3eCpNSmQPjxi9XsR0Qr44EZrO5JM8aLyNelusqokhQo0S4JLVAX9dhXwQpmH/vLOnDoRQkH5U0pPX1WY3Jw8UjJPqK9ipuXuMswh2RXtuzcD12TAeCPsxiG6jM3WxZRL836ZBs+OF/KzpqPcSOZ7Fglt0CLpqUoga6iuOmY98yVRDCvW17gSmd0OJmDLt1W97C7rr3MYPwFSeXw2DfcpT2eYweqmewJMIApMC6ePMmcGquD8syDBdZ3UBcOckonotmgDuvLNJyrRcuIaAVrTvf+xVX/NDoYn9ySsI=
X-Microsoft-Antispam-PRVS: <AM4PR0601MB2147006768928AD8C1AF4BE8EF640@AM4PR0601MB2147.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;23:QbnQ566g3T6UrOx7LHZTm6NpYpk+v+0C6Ey2n8M1SCdCQ08NRJc35/g7CvIu5W1GLS+J3NCwvosvC76xMBQ4hBAnlFN44XOrONOXf3O+DRGWAgsmWa1rGSIbp3xmp65E4hA+eoMb8lyRNl4SXtthMVEhA1Ff+MiyWB/5ArhVzj0OZ7sZohpl1gPcZcCaYthd;6:D0grADDOw8OjXo4DVOM1B1TFZSa5KtLpRBZohK8zmMKAnBqb+Gl7gSNsF/pkERyKZZXZPxOELvX33E74wSMigB7Q3zbR5Z2PV8g4P2+/fKITTaDIg052tt8n1RTluvciCCJcmGWOpBjJCrxX6yyNnq5C/Flc0TGtO3nSFbTSZo/mF9Vt5VhGQgADjW+m7IO4FA/UR7+5cHkoHvv/MczwRv53HOqEv55EIXJWunu5xKaCRWekHnRQxfy2lEi/zDjRnndIIqq8Eo0uT9E6Xfa/T3RGR/Crb20SoRXBiz45t1m33e2zq8VjKmTOJmdpAP5qAfL0QJ1fqVeFk994yxdfD010xlEL20kCYKxIQAlibhYfzPbg/+7XIcYt5UFNVkxyNj9OwTzX8Y72sbscWHW+BddVCX0a6xtlG76X5ZAwgGfNU/kvJbt8wPTkHJVvIDVZ5ManafsKsnIqlPP9irQuJQ==;5:LKFHKXRo1oz6e7etW/cV5cw2RaL3Wjo+AGRoglX+GIbogqVxU9+/MCQ5GPDfuvwZTzotstNRlyBABxs7s/Zc2mHp0zTO0DM83mQGG3Mewb1cAuGS1tEvM1I90yla9OIoJr97ALQQX6Qo+SvQ/7Rt3Svv3ADJUWBXT2sSaa04efzCqAtJBl9zrrhPkhiVhgCCObXHpQDeMll5WZeFy4J6SQ==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: V3nxkjyOdzObP5/KZ6Oy7kET8EW8ChSy60lbUMNldDPU86BX+FqW2g2UUTJX36ieYY62DU/W08cd/OwaqduxLW75ZKnxn1P/+MewUHfQ+1WSewzbeXYUAfwzggXWUW84hUpZCYuF+Q9ZB37Z/QyI2e2NmxFBc9Buv1lhNfdqgS00F91x/oEovdXNMsaKtgtKujpm6J7aJ/jJOQJq77YLbSuaZ7bF7Rx7zZHJ+mh3IOGLnir2xj5CsBKMQ2HxrP9nxLhqyHNflR+Ef8x0ilbvyGkUCGzovaQQ6H17UIO3HwHGMSTUgOHqPO66z8U/MFBWAN+A9/oHwZDXzcXZakzEdcBox591XAarKxxQ17B//6M+QYqhcHZSlidW+QxCYDZ5yZSKXqSKFyPclT5IISQCZ9klSrfD5nCMJW8xw0IRnO3JhOAqKFTFNSPzcT6EQz56kiuOAWtGsQSpiAeXHO+NfHlzL1lxfJLhBlHGjSwKQqyyV9LEvJGvXlp1WePaDgmIadq5Hlq7cJrebsIgLxJzv5qnCTyyLmYBvUn+l15kl3M=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;7:JQpjH74u1H29AV3p9q9EHpf9FBI1IwXqzEEfiBv1iQh2SLSdSC1W9PQXgT3vnQ/A1uidhKbJA0zlrX7iPVF1/kYmOnrOj3TSc4dfa20xpLY4Dc3vJWnyvMo03DKG64XiKg+bEyjgdhYeNVG/+Dwh5Q==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 08:20:51.2838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951940c5-5e3b-4481-1e42-08d68ff9d5c8
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 9, 2019 10:33:53 PM CET Andrew Lunn wrote:
> > +static int ocores_poll_wait(struct ocores_i2c *i2c)
> > +{
> > +	u8 mask;
> > +	int err;
> > +
> > +	if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR) {
> > +		/* transfer is over */
> > +		mask = OCI2C_STAT_BUSY;
> > +	} else {
> > +		/* on going transfer */
> > +		mask = OCI2C_STAT_TIP;
> > +		udelay((8 * 1000) / i2c->bus_clock_khz);
> > +	}
> > +
> > +	/*
> > +	 * once we are here we expect to get the expected result immediately
> > +	 * so if after 1ms we timeout then something is broken.
> > +	 */
> > +	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
> 
> Hi Federico
> 
> I did some timing tests for this. On my box, we request a udelay of
> 80uS. The kernel actually delays for about 79uS. We then spin in
> ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.
> 
> There are actually 9 bits on the wire, not 8, since there is an
> ACK/NACK bit after the actual data transfer. So i changed the delay to
> (9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
> not looping at all. But for reading an 4K AT24 EEPROM, it increased
> the read time by 10ms, from 424ms to 434ms. So we should probably keep
> with 8.
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>

I had a similar experience. I will add a comment in the code to explain that 8 
is not a mistake but a conscious decision. Then I will add what you wrote here
in the patch changelog

> 
>     Andrew




