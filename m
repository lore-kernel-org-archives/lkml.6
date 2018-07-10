Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F77BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28162089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="oQPiMx9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28162089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeGJDmS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:42:18 -0400
Received: from mail-ve1eur01on0088.outbound.protection.outlook.com ([104.47.1.88]:61354
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932939AbeGJDmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWmsE0cKkW/MbCqkr5FQBL3DECk5a7Anj2OZxE8Pik0=;
 b=oQPiMx9kAcJkQmk5XHLcV6NXXN41k+npHFDme1Jjak/b6V0Jl99QWFbrfRd/i13aPdoF3D9RkPNOg7wqKjaqjZ5VUiMW4y6Dk943DpZ+eTucsvYdJNONIIZAKDknjEhpkPQ8t3Ss4uuvuGoAJHox51G8mGcpqlfNwIplj9C5fkE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4454.eurprd05.prod.outlook.com (2603:10a6:209:43::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Tue, 10 Jul 2018 03:42:08 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fcjXJ-0004Yl-VH; Mon, 09 Jul 2018 21:41:57 -0600
Date:   Mon, 9 Jul 2018 21:41:57 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: linux-next: build warnings after merge of the rdma tree
Message-ID: <20180710034157.GA17400@mellanox.com>
References: <20180710113342.605e53e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710113342.605e53e8@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::28) To AM6PR05MB4454.eurprd05.prod.outlook.com
 (2603:10a6:209:43::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15af0fc4-86e8-4436-2d2a-08d5e6171ceb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4454;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;3:b7P3w7OCgP+6pcy1nVat0/me4lPMYV0/KCcdNH+OtizSUCjUkZXbJl34SWFPJJLTxU9Hkq4kgPViHWGUYOSH6MjdADEdTOgwsAMcbeIyl3rjm+e553uaX7Mr11q3nWsg6Iu8xSe1SXes5KbwrALUGy9WKLgUB2hy+DSUAjbSmwY6gWEDnf/yh9Fh3TB3DjR1Mr6FwCmWeAKwCZtbsuxeBhMfAUnnfJXdW6jp37IK91FGUt5P3dREfJFkdJgY7GMj;25:d+jKip4BbFkg+NIkrBHzLZrx7pg3gvRoLdCgys+RZSu2s+y0Hn1sizXlAm5TYuGbmO74OQXTzAsPAyHh1qe4fztpUenMoqVEPA774XfhffN1Aln6stcvYeqpKgp9DZFycrVwb0YqXpGSSQox2dUfssqLsEh5kJG65BBMVfXQ+y1J3++kLO19Lw/vGAQvGFfa4Uc29vbpwc/dVAswfB5D1TxzWhCrv5Rgp59cX/uwhSyzbtnnTderGvaGuG7rxXo+gHHR/3MOvoMw+Lxgw3UEkYL2kuYwuy5Nj5agtOR3F3y9kIIuA4GkW+m7iRiD3YgbJwTDJP6n2Ju7rGGJLMd1fA==;31:4TV1CSKA8bcc4MSDU0pkL/bTewRGXnh9rtSddGKBmkjKM++yBWS0/igaOcEsbyL4ClrzGbzynfppQ/pKc0p6kyrWWCX6KItBlBNRGe6vOs5bQRDM3l7V6ydwL25iG8fOBF3WrukbY6jXqoEUHgk/Wq2YRjMYeI5CENucksFHN42uexIoNDQiU2L+01MDIG4rpw/5ff0cYnKVxWsEIEea+M1VAb2ekIcxFnKsBTr1PrA=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4454:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;20:9HsvH9mSvwss3Z/9PCnSmpFoy1RUDPNUaHjZ36czmTVnKlNaW904kv3F7ogqJNe4VCxK+BhurlqoA+V9vabnf7ix/fkiOHapeuqItFKyvq3EF5O4azxBvc4kuRizwRuVY3A5Rql4aPxGZF0YFgQLidM6XDPTp3qzuWGPaI+Fx5CS7y1pLsHPhsTvY6XW703y+Le4Sp7BdmWAuW/01RDbPpVDUVGHhSb7huOhw5b0k8H/I1MY4PvjflSAZdQ0FaJlKYF5e/+rF99z04WVpJb+F7wsAf5Bu4xwYo7ljXy78VBKjlwXXI+Xr4NAOTWFg/iOHRK2CyCxCJkwfqq7EMhqkW7ok/6g3jvOxREeFjIT9CYBzXNgsKxtJSN3ppzawn4GvvzxfZeWvO3Zz75Gurg7ledzEEHZqA6QxrhV3Xf0Ib2R90BgnMBAgGtFJdzYu3kwInEBFZwFwEIBC6XrSuKnBnvL8dPRRl8nFH/7lK+d/KYqvopafy4tt+KzYBQCW5lw;4:si7LIAWl3sxTZLTnszjvuvVw3B8hsoh729eb9aygYPPEnf8JC9mbTLPCsLBjzwkK2K7pSZWQha6yproAxjjsoW6MrCTrQynSODeMOLhjw2t4nsmhYhyHkqXSCENj7Ao5UrwvnhqrKSH3/JLztOs7aYW1wJ7uLpXmhY4p2Xiuq8BNw1g7nCnk7XNUqono5nWltRB6xt0DsfyEqbX50MjO5G/yUyldjIoPOfcduEYcxfL37M8jxvoyNBaH/IV1eJuFUPJuR4ojgP1JeP2k8hd/2A==
X-Microsoft-Antispam-PRVS: <AM6PR05MB44548951B6F359F43B931F61CF5B0@AM6PR05MB4454.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4454;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4454;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(189003)(199004)(53754006)(46656002)(52116002)(83796002)(97736004)(386003)(68736007)(1076002)(9786002)(446003)(2616005)(53936002)(5660300001)(6116002)(7736002)(33656002)(69596002)(3846002)(23726003)(50466002)(6916009)(11346002)(122856001)(478600001)(9746002)(57986006)(305945005)(76176011)(47776003)(36756003)(14444005)(66066001)(8676002)(8936002)(81156014)(81166006)(229853002)(316002)(54906003)(6246003)(86362001)(106356001)(186003)(476003)(26005)(486006)(105586002)(4326008)(2906002)(58126008)(16586007)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4454;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4454;23:wONbVBt4oSdLywRqgjG5CZgovRsrKTVxz/Rjo2ODa?=
 =?us-ascii?Q?VyF5MAuaMq8T0yQBRftNaV8piQYbvf9MFM0Kz3Uq7ywPL41kvzbLeLk0Bdkv?=
 =?us-ascii?Q?x33VWd24iiEmtaVsax/A0LVr/axQ5nxqMyIuIlTysPYMQiNapaZE9HSoMlam?=
 =?us-ascii?Q?SxBsZa/I8WQztJdinqkR+oB6JHMp7C3oRtTz/UE0kkyeWuXMlu7yGIGS3a5S?=
 =?us-ascii?Q?YXmA2/oBqBLA/Vi/bYPR4RoXOC4B5kBpnRY7DjMlT73ircyKGzIPLN0/j5yH?=
 =?us-ascii?Q?m1w6ovE8iHlnWW0vXY3Nc3jVAaFJNZjIH9/JMO8A5RkXuISv1BCIIM/yoerK?=
 =?us-ascii?Q?WNBtcSaiK9+011Wq6q+nzCDhBwRwDGbWgWsnETHcEAkrFxOpdeikVKlmg1un?=
 =?us-ascii?Q?TllHnXiQWrIFxpTt1TB1Y3mQjLnpZe01RMzZnt6+mq7V3tgVMpE33Ut5B0ab?=
 =?us-ascii?Q?v0DuUez9EW24PLc4Zs0NKGma5g9hWSMWsRWqf8kZJuVPlF2pobIwa8Y+RbsB?=
 =?us-ascii?Q?8r5wNsipllLh3bCK31Suf4or+ZfpkTE07OqWM0j4ufy7V8s/6SuyRKH5XJFW?=
 =?us-ascii?Q?kPgPmVXymQKGkaAxJUuStl3h8lZ4aZcfK3cwGJnMucZtfeXZk5HYlHRMpSyU?=
 =?us-ascii?Q?8tws5D8ionPLqRYbZ7IhuukXD3/SdgBOjgIIsEK8vNENvfUyESi7vj85aif6?=
 =?us-ascii?Q?1osdrNrh3atQx1hYcTJkxed/qJl90QdIvMzZhanMfDTC7MoDYLY/zOdmO1za?=
 =?us-ascii?Q?lFoeE3NZ134tlCE7fl9Hd6hm/wTkVO2XV1kZJeoOzj1Ywarw7Z5YKLEvHXUz?=
 =?us-ascii?Q?wTWD5oOE/NzKcL9g1Z67o2K967KnivXXEsqVjX1V2SIF81dD+Djng7MeYtDA?=
 =?us-ascii?Q?mMK8soS7RB0G2uLbAKfO629lP7oJuejtlzCXMBiTdAQFVgmZ4BS/gSS799Fq?=
 =?us-ascii?Q?NIKIjuZCw60ytQ57TAq2QLl4OCWc/88+qAkO+0wpZYeR1cieqzmgM+ZP3hK+?=
 =?us-ascii?Q?QO/HNj8XSMp4qtaO4EoIRj5p85Oa7R7hIlDBbIcnNYnWwp0PaTPPnBZ7ete3?=
 =?us-ascii?Q?UojJVSKieIJ/srLF3TAVZL6nQoitp2ZVSZyTqxq89wUI1MDioOm98ZNOvVCD?=
 =?us-ascii?Q?Mm49CX3wwzjhHNQlI2iEF32Hsvr9hcU2EqgFh+DxPL79hgHFpzZd1n/2zuOk?=
 =?us-ascii?Q?DXHmKaj1PRxml5Z9uLOI2MKjIg0z/xuoqLJQM7reUmyfI1mtD9k1E9KoKb7H?=
 =?us-ascii?Q?kEke+UQurgAGn4Kc5JP5ad0T7c476OGLFdWyRpCii4L8vNDqzUINPPVbpiQj?=
 =?us-ascii?Q?S8H8SE3HNrBkT2BUi9AM2uXqJvz2QTFqGLorGzvR/K2BTWlyG0M8idWlEwtI?=
 =?us-ascii?Q?vv4o/xxBRUs1jDWaYjwVFZT6do=3D?=
X-Microsoft-Antispam-Message-Info: N6gzvI3yRU2BQWZdE25cSAFNwLl+REkrc7coAEBJ8gCbF6fDNwyPw1snU1oXBNqPjTLzs6GOsSgWSkQIQ+ZfFrbJoyqp3WaVELv+UjFTHDLtM2yWPxwWnXHeThD6anZdelzUuq0/JD7CawpHN1EdW6Oz4tdfIqk/tQHLvDEciZSn2RD2VAG4qGsVrhQCxWn3pPnrmLz6Y5/vyjrQIYy3PizYeu5jfX8U1TlnTCR9fSjAXvWf0D54I2HNSR3FF/6aRblie46Cddl74CZbROjk+7FmB1g39eiDkcsocrQ2fvhPG9tuIS2u+wmzr3c8Q/ZNPlN36t5krsQsEaKvDRJEiXkyc7xWgdIfmEX8Owsxers=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;6:Gcps2032m4wl8RGInHMnKwpctgmnJtkkSKE8hAoTS6ESyUfbLJjZDei2jWlpw2KOWpF+hPHM7ZjSZZSTFgFd/AUFzi6G7lylAqw5fsPcZ5l2V85Zag/eZxHbLRf/pFUfVdihJe4LeI/jEbLxWCl1YrQt2w7ComNNvtpCeXRxfXJpLtW5QfSgEZKtXuIqjok4J4rduC055NJ2WXjGHd7Xdh649z1cPWed3uxoT2JzH2GStynT+V2Py9/wX2/lwt8GPfrB/9Fx0mEscsV8voJkfokO7bosSU3WC7Z0ib9Ez7saANe575pwQ4cRsuRbSXNM/ygfe2S+wSJyn5Jz5KRcPosRdPPL0HvBf9PsoB60ZsCqr++mtoENoI+Ul77T5Ua6tZ7fyxqnE0oBuoK0ybFjIlxj1xp9bVDC3WzG1F389HqfWF/QIGO9/4K4mhFU13tOsrLk/iFTxx99XMOHB5eflg==;5:czcLEQwfP9mzLayeK2RU1QLkn7lclfklvnyMXn6IRpli2/RXAV6QzzkuY8aTZf962fXrDhgO1FvofF/26zXJrEj0Ry3e1iQtSyNWETRgv85uVQlA/BUWa+n54cpVD4InJPgin2+YT2i+w9nBVJYtpOF4RgcNNn6OIMbrt6TrTdk=;24:nDYBwXcWFQ8A2nTOHaYRBVVZzg0UYoufnq/bxuZ1BA0XvN8q0xxO7rCHVEOccYWi4bVv+cnaB4KcXjyBpihgHnXNobKWZoWZFlD1yz13geA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4454;7:4aOOVcCPclIO2NeTxGoGaRJkg0EX2fJfHcOExWHcF5nkXyad/7z4unhSWDlfEWqf6e/eqUHU9248TCRvp9mz/Jxt1uJH5KZT1TgmGlgFDBqFiKJ4Iiu101PIp7XRWMw+4VlzrdQmsUNqGWjURFx2N7ohiUf6dqNwnz7mj6bLBE8TKnyW/XOuBtMarI0JO1uA07vlWlV/QxZNRlcvv+gbzqZaNjEpYJpF812Oj+HFozYPm4dpXWEnhq1H7XeI0NsJ
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 03:42:08.4885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15af0fc4-86e8-4436-2d2a-08d5e6171ceb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:33:42AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) produced these warnings:
> 
> In file included from include/linux/printk.h:336:0,
>                  from include/linux/kernel.h:14,
>                  from arch/x86/include/asm/percpu.h:45,
>                  from arch/x86/include/asm/current.h:6,
>                  from include/linux/mutex.h:14,
>                  from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:34,
>                  from drivers/infiniband/hw/cxgb4/cq.c:33:
> drivers/infiniband/hw/cxgb4/cq.c: In function '__c4iw_poll_cq_one':
> include/linux/dynamic_debug.h:127:3: warning: 'cqe.u.gen.wrid_hi' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    __dynamic_pr_debug(&descriptor, pr_fmt(fmt), \
>    ^~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/cxgb4/cq.c:674:16: note: 'cqe.u.gen.wrid_hi' was declared here
>   struct t4_cqe cqe;
>                 ^~~
> In file included from include/linux/printk.h:336:0,
>                  from include/linux/kernel.h:14,
>                  from arch/x86/include/asm/percpu.h:45,
>                  from arch/x86/include/asm/current.h:6,
>                  from include/linux/mutex.h:14,
>                  from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:34,
>                  from drivers/infiniband/hw/cxgb4/cq.c:33:
> include/linux/dynamic_debug.h:127:3: warning: 'cqe.u.gen.wrid_low' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    __dynamic_pr_debug(&descriptor, pr_fmt(fmt), \
>    ^~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/cxgb4/cq.c:674:16: note: 'cqe.u.gen.wrid_low' was declared here
>   struct t4_cqe cqe;
>                 ^~~
> In file included from include/linux/printk.h:336:0,
>                  from include/linux/kernel.h:14,
>                  from arch/x86/include/asm/percpu.h:45,
>                  from arch/x86/include/asm/current.h:6,
>                  from include/linux/mutex.h:14,
>                  from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:34,
>                  from drivers/infiniband/hw/cxgb4/cq.c:33:
> include/linux/dynamic_debug.h:127:3: warning: 'cqe.len' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    __dynamic_pr_debug(&descriptor, pr_fmt(fmt), \
>    ^~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/cxgb4/cq.c:674:16: note: 'cqe.len' was declared here
>   struct t4_cqe cqe;
>                 ^~~
> 
> Introduced by commit
> 
>   4ab39e2f98f2 ("RDMA/cxgb4: Make c4iw_poll_cq_one() easier to analyze")
> 
> Again, I can't easily tell if these are false positives or not.

What compiler is producing these? I got nothing from 0-day build
service or my local gcc-7..

They are false positives and I guess we need to put the
uninitialized_var back that was hiding them.

Also curious that the powerpc compiler gets a different set..

Thanks,
Jason
