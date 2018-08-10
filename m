Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF87C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA4217C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UpuuGATd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEA4217C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeHJRx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:53:56 -0400
Received: from mail-ve1eur01on0077.outbound.protection.outlook.com ([104.47.1.77]:11293
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbeHJRx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lYcYCyFkEVjLoK94DfHjyFNxEz+mpKOBpekEEiex4Y=;
 b=UpuuGATd+lUTSWl8+b7BDBcYhqxpvpGqplAjG+SkD9nCNx1mh+Xo7xifoqpnvv/Q8JmcPW4Cm55JIlccN4Or9UQ57waNdChJnhhMIBtifqhtcN7bDwmLi1qluhpvEeqDNPhhFFTqRP9I/hRKOtC041cMjru53b2Lr/H8wRsAhkI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
Received: from localhost (79.181.90.23) by
 DB7PR05MB4985.eurprd05.prod.outlook.com (2603:10a6:10:22::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 10 Aug 2018 15:23:32 +0000
Date:   Fri, 10 Aug 2018 18:23:21 +0300
From:   Ido Schimmel <idosch@mellanox.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: remove unused arrays mlxsw_i2c_driver_name and
 mlxsw_pci_driver_name
Message-ID: <20180810152321.GA11917@splinter.mtl.com>
References: <20180810075328.26400-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810075328.26400-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [79.181.90.23]
X-ClientProxiedBy: AM0PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::40) To DB7PR05MB4985.eurprd05.prod.outlook.com
 (2603:10a6:10:22::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55eb8e89-ea0e-4089-059d-08d5fed53c1a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4985;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4985;3:ktCrJuUb/DF540B7t/lVITThXK2Z5kgci/meTBHjKclKfTXdoRAxYhlD1WBAxvr6k2F6qmUm/RxzM+o+pyNh+0Trb4WZu7zZZ6IogwmU17nMAK80dKS9t/WvOXPmFRqQtURhA8o7uvw/D4+mh9TCYuLxtrH/dGwy8N0/kalbtKSZqmPrkMvkNp/g+mXPoZTAzI8u/DZtA43AN2jPgOWkjITZHWYP52i/9U+dYkl06zez9xLdRYIcHLzpH8L2dn7F;25:2YwQO77RFAUWgDBcH/S5IfhtEZfJhl6+IwpHNi+zGDuEFB5I0wM1jx673L3+swUogeUR7yYh1lnT99xx2aKio846sEYrPyceR2hBXhZy0PEscATGqzQHyu/RaIsP/McXbjwAAN6aumPrBgSTRiviYvBxu7UOE5AUiILaQzmynTT5GVzvUUHvTpQlvEPAW5SpK1+fcVi8g/6oyCNmctl6Sp1Lv5h55YbMEcecCTm0tHKJck8D7G0aLKLmqXItKZ7VWoZzfbBFiANOcbCaf5hC/eOiu79op1publ5NDbuJ9IM+MYSabKg8bgioBTnjn6jPqTXHpxi9PkvM2rN3qqHDKw==;31:Hv/vFdyOnjl9rnTJuyQFTbAAILYTcC9DFC2Gyq6Piyo246LEaqvBnvSKOAsrtk56posfwYYQFdjZtg+TooUyDVluDmVyIpTYWBHAmkphU7Gq8oL1BHblj9JW7hHFI3DIwAjsPupfUUdbr5TRkTHSQ6xKZy0gN14L+490going1xzpdxswyMu4iW+OwsQXchuocc5wu2eA23ADE8IjXt2HvkK9YkuoMjj+SapYZRknoA=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4985:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4985;20:OK5T04RypGb+/rjbYwVFN4UCgqGznx6JDNDNQTbDNilHpQf05la7GkYGbPZRsIygif0slRiPhZzeZVriwAdqDHSOlqVKJmHVEHZCnkC/X07VCb5agLt8vITbubAuDsR2+NuNsje8ahPilY2n4Hq/3wvr5BLZIHTmQbzfjhLwYnFo0P7udVaQGADkgT7XR9XPwABgYfderp+CjzGFQ5HU62PH+FW88XG/hdR4tBb8l+9upFrmktWPZWkfNVHakXlCARyKbAmRxzFjyD8Cvd/Lj0bzI5MgQLe//YigByY2n82PAIHBAbYHSQi+WnZDKWjlYpcQ2Y7C8BYEbGBe8CO8RDwRY3nz3iCMXRY5IGn8IrqcEFl03vAJDyLKLCmmYNyCCA1qBHFRHpVPf/NLyKVA5AHTWBhkjLHJLgzpI0w3FrHodkxYzWIB2AcAggqC+5dYGBYcnQ6Bl9NUtE4+r+JlW2nN3eEfbDb0OS2X8TYGuvq+el5/Z4zy/HIZU3zw3Mwc;4:1VnE9tUUq0PEY8G7t1bSwSUi5HL+QZn4qm+QdKi9gipwvOU/0TqjNdg2O2ouUj2P2y7DJtxShfhCM4+TrcydGSxUUl3e59SORDtUX44qjn8UcaphCdBhlW2x/cIjC4rXk6Vo/Nf8BQ528JP9bSgZSm6KvGZpHjGjnItFdOYEeASPFvB2bF/YuKp6tE5QvKvi8M+pJ+4X2N4WAAByZz/9yjxdpXMy0UXikp+4hrgC7e2EUGIioRrR9o1tuwn7e0GpGVCeDOEJseG6Ofi9f3F2H+IpL6ozb48rqSawWxl+4S9TZHrjRUmAa2+SyHvF6vZP
X-Microsoft-Antispam-PRVS: <DB7PR05MB49858EC4001716E7AD94616ABF240@DB7PR05MB4985.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR05MB4985;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4985;
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(81156014)(97736004)(81166006)(5660300001)(33656002)(76506005)(8676002)(2906002)(68736007)(4326008)(106356001)(105586002)(58126008)(6666003)(54906003)(229853002)(316002)(9686003)(6916009)(16586007)(478600001)(6486002)(47776003)(66066001)(8936002)(7736002)(53936002)(446003)(6116002)(3846002)(1076002)(25786009)(33896004)(86362001)(14444005)(23726003)(50466002)(26005)(16526019)(186003)(476003)(956004)(76176011)(15760500003)(305945005)(6496006)(386003)(52116002)(486006)(6246003)(11346002)(70780200001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4985;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4985;23:vuHPEQn5dG3fmcSUQjWS9X0pDjl0XKsjXWQk986so?=
 =?us-ascii?Q?fTXknmFXrkkSa01Ny0ivZ4X2t8Ffr5mdkIE6h2k5qe1sPdM8Ck6DIExvomDR?=
 =?us-ascii?Q?AZsoRVtJHWg+/j4S0uqcpTNh9vTb9hYOE+HFIhZVM9UlCo5KBxqCwEV/IAZ7?=
 =?us-ascii?Q?cfrmyUf97LnXd1rDaU0Y16xp70ANFuSkUDHA43kl3wqqXmII3vePP1X5WPrE?=
 =?us-ascii?Q?PyNmVxlPKRWFTyociOFPTyf6Fx521UXozz3olOeh6vyatdlWpWyvY7pJbBgb?=
 =?us-ascii?Q?Rh3i3HBJPxirRcLt/HfYOGdK4cLRxBw9DgebkWWW8XDpHKHPmGvL3O2rCqIp?=
 =?us-ascii?Q?CvoZnijUM7otwg4R8LS6XfZZmySokJsaTUqzShCwAuxUbTs7C0olRRIXQ84i?=
 =?us-ascii?Q?awSRGh8fbM3U1n/9hW6FsbWZCBZQ9mxl5XlBsANYlM/rjehpVn78xbB76ceQ?=
 =?us-ascii?Q?yHqUph62RgCq2+a4s1BgmbV4aQ1GPDGyrDKlip2nUkrzUrxfQG92g3S1Gadq?=
 =?us-ascii?Q?NT3Es+miJ16RecjuEGTybqxW2XHDzDZWY8XmEQ2km4BUX1tNzmrdar5WxVPd?=
 =?us-ascii?Q?gJIRn+gENQOViCTZCh47EU6slc8tENcOxILBUGPSnNBZDNruvYU8yXpg53v4?=
 =?us-ascii?Q?XeHumbhpm51MqeZG2MxOwbFtAKssfVdSm1Ll0qNzWknOkZIs3pAGVD/skK0T?=
 =?us-ascii?Q?MzZFk1zcgF8IKUj00sC2HoW4uzOk7YpQRB9qL1ZZ9VFE8OD/NuX4QNKWZ5nm?=
 =?us-ascii?Q?ECclX1qSNFDjXDC4yGmTHL2p0GHG4VkIRnGFhsOGrb7BVEY3xmib6VzBvNyW?=
 =?us-ascii?Q?RwkmBe7ip8YbAz2azZUINbOZVFziOGvkAwtWUygEo/mZMUbDOnNzM36jgM6o?=
 =?us-ascii?Q?AvaW4xSouXLJ6W8B8N11uKtAZ73fdAPrG4wH/LVNk/jQkQMGxWgvGKNkSEd7?=
 =?us-ascii?Q?JhK4HQrSbI3Ck5t8tHmyXXhf8Gm56T6vzgyiK5q2CO2mSQXCCbSGsPFWbqCd?=
 =?us-ascii?Q?PNgVKQayFFV7/0d16to1qnLtTAO6rqPHteaAuR5yobltDi7WDnMwq0SCsOjD?=
 =?us-ascii?Q?xTbmv3P/0wFJfNw9Dl7FlbXlnFQiO0EpEL5Tu4T0EJG7F6ZYbEZax7D3tquj?=
 =?us-ascii?Q?0uus0a9XUGpvUSscRdYWGYDIWTMIc+idzexPGx3GNfjZmTo31Efr/38fRlM9?=
 =?us-ascii?Q?lNyMFtmiZNbxA8I9JcXvwYbhFDpzReQw6cNL6bG1HUW3ezDcajixcyUZ2GGg?=
 =?us-ascii?Q?KnIjVOUmLjm6IPN3fZZDI31KrO9rJ30jaFzyb1RvCiOD08k/BOpWbPrYOGFS?=
 =?us-ascii?Q?OtNhRjuj+DJ3dUPQrnqn8N/113EmXTmVlwZXqXelx1jWVNOp751TawVuOeeE?=
 =?us-ascii?Q?+SMX3P2f8gbMOjcSvME/bQlVO0=3D?=
X-Microsoft-Antispam-Message-Info: abKlm351HZXSxeSH8htqHUhmAPiq4Dn6ozIJzwhz9MS+Nely33C4x+OAf/XuMZaUw6JAoaKiqwKiPN5EKli5JK6rv9exTE2QnipxODUhEqS5eZb6Bt0WV8Bi1JoCwaYOhGEwbLiFbbYAXni4EG++4MwcpDssno8V8KFGuO2ec8l3lWLGVP0wmQXTFF8qwFUeZZ53Gqx/eM/O8XrUP3bklIISkjSbevbGEz39GQ9imiE0luZ7YolyiJa0wecTxcRGFWepBHU3ZGPseeMYVgiBHcF+PA1gaMY3wa2r758Pr10pmXQmvIA+/jSfnRRMUbCqz3Gam/qpbP2F2hnUwT686zytNkrzNwMjxuBYUwgpAmI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4985;6:r0BNnBA2+M+9EjkI4YiLi6DLFPkcocAP7Xx6YAg6wNp8onwGQmBSEOt1UBZIj71N5ON9ZnXn7s/p/ppmyw0hxDEsz67xAiUJUzPN8s8tM8jMabqW0pFyNYL2a3/Mx6CNZ8b6RnVL3E+5uL8xe7ffa2vN7w5y2NIJQvJRtOgRwIC3t8sbgiM6ufKkPYFNmgJSVLYEkWCvvzD3BWXVMmKgYf1IVxAqeltxDQD/UJPLe6dMKkZD+qZ+o8aiaMHeqFoLzA3n+wivankgZG6t07S933Ah3FOxte0E0/wyAnlqHYoaDldkIpUYLuOTiycW9xVnBGZpI/Ua3mCwCR/NiEFEb0WtqqDzsd+iYiuJd8vtIE7qUgSglDxfo4DkB3KQYfeZetyCjYrGGBcaj8OvRt5YamOMgoI4IFraKbkODdHeXq5jNDV6jZ6StNUMQd4knfiLYkYGI9wGlaW2psDHscCW3w==;5:NrbLC3Ygv7qkKRmkYNmDuDcFK620IVirCqqGadohqWL1xMr89sWvi1N2QcvoY1UfOJHunVWnE6TxgEYcZ/3s8yNiuTK/FdSt/IAddYpr9P93v7YExZMN9/0nsVma+lNsH6ZDehqkoX8gg92ppsyNzRlDsnJ/M5RI2SvnqTwxXdw=;7:5vjJGgSb4NCxCoyB6yeH/YtjjMf3jS5V78o9FGVmF35Iyc4s4fAMVSsWqzbNS59xHTQRBbc1QCGhpf7ZykvCSjdnJzV8aLoU2gxLzGcVf4Ez9Nflr5Sp76eYsVFZ37wrrzVO1Ffqr2jpLcfBsF2NDovDJCI2UiOwT87oBHvFbC0wLXFY+6J8oW5ygD5IAYs3TLWpyUnwg9HnJi8r6OcmzlT+aEQWF20/ssJ37phV9+Ahi5cBdt7whKzDqpmdyiju
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 15:23:32.8787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eb8e89-ea0e-4089-059d-08d5fed53c1a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 08:53:28AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Arrays mlxsw_i2c_driver_name and mlxsw_pci_driver_name are defined
> but never used hence they are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: 'mlxsw_i2c_driver_name' defined but not used
> warning: 'mlxsw_pci_driver_name' defined but not used
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Thanks!
