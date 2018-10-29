Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5703BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1092080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="l1bPfB6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1092080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeJ2WAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:00:21 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:48411
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbeJ2WAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWEvoLYnEyRmA+zQfoP5+yJ+AHdUr0dBRi7BiPJ0hPA=;
 b=l1bPfB6ymoVIpaMEJKXaYOW0BGlt/gOGYeP05KHAlXJRMdaK/2xsXOmlWggsbX0V7pXelcl3aEZmDKm3Uo5R0yCY8jbGntqrdklI5w+tigY8/mI8MbEEh8RG5OiMkmQTbxZ/QSbhyHLkhnd8S+Ct5LYKmr//urEFj234dQT7Zp8=
Received: from AM0PR06CA0060.eurprd06.prod.outlook.com (2603:10a6:208:aa::37)
 by AM0PR0602MB3523.eurprd06.prod.outlook.com (2603:10a6:208:22::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18; Mon, 29 Oct
 2018 13:11:39 +0000
Received: from HE1EUR02FT039.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::204) by AM0PR06CA0060.outlook.office365.com
 (2603:10a6:208:aa::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.20 via Frontend
 Transport; Mon, 29 Oct 2018 13:11:39 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT039.mail.protection.outlook.com (10.152.11.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 13:11:38 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 14:11:15 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 29 Oct 2018 14:11:14 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date:   Mon, 29 Oct 2018 14:11:14 +0100
Message-ID: <5709014.JH4KZFlPMP@pcbe13614>
In-Reply-To: <87muqwzyya.fsf@dell.be.48ers.dk>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <5352289.A0jT2G1FDH@pcbe13614> <87muqwzyya.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0602MB3523;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ccc7dfe-a015-4662-d7d9-08d63da00ffb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(5565046)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR0602MB3523;
X-MS-TrafficTypeDiagnostic: AM0PR0602MB3523:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0602MB3523;20:Dt3l6oocKie7AePBSOe4R9sfab0m1fo1oo5mjkFEzTnEmWz3oGpDr8U5wx5ACXxcVNaciIPQdOX5KJ0qRIbIHHdGAuI28J7QsnckmgVeIvzEdehVwyfrj15/udEwYmjUpfo1rLAK7sdKAmH9wqdevl+lqF4pxIsoXpBpAX4HotT0Xjzttjs1eY7zwaA8qt4yHRjU3Qd598XqKfHkLbeD3FgLYYOsorrDwoG72uLVSb+y6gRb7Yt9IcRoJe5DTre2I87t+3IkQAxuxJN24xLoW2guOOM4wvuLEpA4cIjuULm3tLmNw6ocH65I5Ag+RQJ5dHiYTqZqvvwa0YFXafJbaoSmcewhJ/5L21dDSDAVsadDMM5u7KMhQjhxa2ITzu+rC23kGs7xkDZqv+pXLm/DAOJluklPYYD49kyQQDmtLbQ6RFjgtkOrsjRMtDqoo1sH3PRAlGYfQVF3UVOT/K7ZJ5GPVvk2I3ZK/ZUw0fZZu8YAEkkpQKmoO23V9hlPrlBH;4:VVW7Gfl25WyqEb/xGrYb1in7lhyY1N57CeCfLHcm+j0CeSy2Kqdm8obFYwnwWfz3Ldtn4cY9LDEfEQBUh1jja1ap1/8R8txF4/wPFQ+ocQuZa5la+eXF66cUQ8km0MtmTfT+3zqVYrLpFCmLm7ljnbxjPg1APG2AIV7QIdOtX87IfzlAO8q9BTybkW8HZQ9VbQO/AeUHQrVucUho36p0DtPGQz1ocqx+269Bx70xRKsyB6/Be85/ZwI5XWB0PyQZ/+pjZqVQwrm4TiYZG21xng==
X-Microsoft-Antispam-PRVS: <AM0PR0602MB3523A3663AD1DC408A1C3131EFF30@AM0PR0602MB3523.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(7700054)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095)(7701012);SRVR:AM0PR0602MB3523;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0602MB3523;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0602MB3523;23:d0HVfs4gVcVkh6S45VlHbKWgWH4I5c2641MjUV6bs54k2HeV7NvRk91IycSOuhqlmPYBA/O7x08cinaef0E2nGcRB1BPM3680fznhG/E6Kq5Dei2gKem665eUzS9FxVq/kSkEFK6aUpaiLdMjmIvhukI1aeL8EAJEiQHS54VMGC5pOQ+3YTj0VyoSr3sZGuD;6:kAS0oxKFjUusTr2lewJvEAvjmUF3U8Ax1DatxkXA0vtCnV3KrqNf0h9joPoM2DBl927eaNPA6GgTONuil6e2vLaRX7qE7BIKx6nIwTYl905bJ0qproF3XcYLiTiYerqC+9wxj/mvVW6arPfss85sMcTOXpFCNJmHA0xm7VHjv2UyBnNT8I5rPbKa6JlRaY21OUaE54TVsQHJO5klxAy0tDDcuMjaAIxAtTqxd2hl642/0GVgDC7iOt7AOHfgtHH5GluP/AOJZtYx3U0Fu+fXAwcRuB7X5QFHySDmuSj289GMz5X4hegyeciiAA0oJt88EjgGqQkfcjVvQGohl85D5tZvlMVYar9KBdmSh8gkSq7tefPweKpZXd04/H7uxgI/TY7IllGUCa9DAo17QWyDZgR9H+zn2Ly8mETLxkEZtX5MeWErvQeLehburr/SPdiOTeehD9XvGNmQ3402lL04pQdQHIXqTVnygSu+6kI/KQp+5T0Yes9zkCVkx4Ekt+ey;5:Tezn4ZBRW3qNpBIdgXiEVKlVIBXDoV51k/WjUrIzZrlOrQhPrF6P8ckhWXSOpkztFfghulsS55lADfK+hmjfTiZjdHoVC/MLG6TsjOzdnMby3OHHGmI6D/3sAddahFn66zba8kPGFLMeiPdZixItSuz2YcXvc+/0U/Uq4Nbt/Mg=
X-Microsoft-Antispam-Message-Info: Zp+pUTjOmE6GqHwWKpNCbn0AuXld8rKOESHJCcDhGZve2T7C/RB4mi1ekYgLUnPagz/GLOUUqS8cYwMN5o4am15WP2wnwSJQAIFWdDCz7tAKS/E/YP0VE3rWtR4hsJZQHaL4XGRmQ/VkbeYYwGi5P9SVCiLPgS7LAmU/joZqCYk4hjfLw6RW6q+joY/F/NzPOWO7Tn5O2BizkDq6RxiCEOdmuTGZHgpjyGufyN/Ltobomf53dI6WCv1RvO1Bu0t7FXaQtV7dkCOxebDLg+9U3yX7UedbYoLFwNByIUnarLQFGThaotJNORQuemoYhTh3aQx1uwuEeXChC3jbISl15Z2emb3I9aSdDl6ct6CVZc/6slXKomynI/r5dn1ujYZHoGb8vfj5leIzfWW8LCmh0FSrofXE26sk9AAFCgKcwrQLFiLxWsfWrm0oWAjttUx5btsptbzWEFa3i3kUTw1q276RgFmnimtqi//kvVsgukw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0602MB3523;7:3a7MsdTmIhMnq5iiVQPN8/GJth72NucwLthwDk9GWwWxV6Tb39ejr742bkJb0E99SS78eUDHs8c8l4RfpJ+hDERAsE5nYh+wkybJ+ZNiAJ7S1/rPbY8T9FeU6O52RSq0QakMk0upHuR0plZoqPJACQ==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 13:11:38.8759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccc7dfe-a015-4662-d7d9-08d63da00ffb
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0602MB3523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 29, 2018 2:04:13 PM CET Peter Korsgaard wrote:
>  > I think that something like this could be better
>  > 
>  > (2) usleep_range(sleep_min, sleep_min * XXX);
>  > 
>  > But.
>  > Since it is better to make this patch ready for xfer_irqless, then I will
>  > definitively go for udelay(). The reason is that, xfer_irqless may run in
>  > atomic context where we can't sleep at all.
> 
> Great! BTW I noticed that your sleep_min calculation looked odd:
> 
> int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits
> 
> bus_clock_khz almost certainly will be bigger than 8 (E.G. likely
> 100KHz), so the above set sleep_min to 0. Please move the * 1000 before
> the division.

True, oops




