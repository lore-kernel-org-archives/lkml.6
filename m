Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03570C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9879A20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="FXgniA3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9879A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeGJEME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 00:12:04 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:59008
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750866AbeGJEL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 00:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gui3xAS8tOVZp1ijouxu9jCBM3FM53r2JYw3GVW0n4s=;
 b=FXgniA3BmZkds8wKat/5hmArqd3yRcuvQrJ9YEeiX4kH8OR8VXSmeUIjNv0uXT/NZWYaNb7LvZ3n6GxgEwyzwgr6stAPTTi24ubN6oMLo1xqfsjwM+1hDqO3g6q9iOlf/lwnBzaioU/bMgs523YCX3NQzWwqdCs4v4RCTADxMjE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 DB7PR05MB4458.eurprd05.prod.outlook.com (2603:10a6:5:1b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 04:11:54 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fck07-0006WI-Uk; Mon, 09 Jul 2018 22:11:43 -0600
Date:   Mon, 9 Jul 2018 22:11:43 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: linux-next: build warnings after merge of the rdma tree
Message-ID: <20180710041143.GD17400@mellanox.com>
References: <20180710113342.605e53e8@canb.auug.org.au>
 <20180710034157.GA17400@mellanox.com>
 <20180710140512.53d67d40@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710140512.53d67d40@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YQBPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::32) To DB7PR05MB4458.eurprd05.prod.outlook.com
 (2603:10a6:5:1b::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51cd42b5-8c0c-425a-3dae-08d5e61b45c3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4458;3:Y7NVMhLtu0j4UsibUZaenSoeRjGmg1IB3dCA+qwAGBiuehQ1IJwz6SnL0foRMZzmR6j4gyGEewtNLwRfXi/BCT6BjRUMn2kuF/Hmoh3l1DllHK0uflBlaufCtcuLC9p3QQGhStGAgQlh4raNDD31hWiU+2kbM5yth232Oh9/jc2qtKUFrtNpm5b1XyGHK4tQtaS4jAvdl8ELfzY6iN19q7dpnHsblDKkDy7E7pudEs2yv9HS+BpC99LJEZbRUiTi;25:s/hZgcTfzv2qG3uHr3lyqNttTiPWoNY+3ENUp1MDm1wZ9g8bG+ckjX1xUU69E2yK07IVBE43DfjMWH21qPkJlSY2OkfjUIZ6HHt+spf+CPnwJ2+7VLRZp4CBo4tn3g26n3OW5Te5eUVSi9LdvwlaiC6vLKxQxfKeGJujST44J2EaElupkVjK7uxqkyRLUik/lRarUxAk44fVLgUP5HAez5JupjPaIwDO2ixzC++PNF7XsIPzoINEjqjpuRY1L8u7R+WhT9aWbpBUEaOBD6jn7KxyZL/pAAkFC2WakPMQoeJ2xDe+H215evefZXb4uIOAzyWSzwSArnjKt9NIsTPXKg==;31:qsgo419bnWd1kvsjv3OnfrVm4V6SxXikYn+9BccpXlAfh73/wr3EeKF85RGyTuDGNhpsCkDCY/YQyAQpax+RTB9nV6zbN2RnoIPhvWgSQN7pezqlH+sSafBjPgoLuyQm4cc4qPqELRrz3Q49rPLULdnuQ1ZlCED0ILQVC5vTZ7HY/wpbsM1xFpVki9UwmTEz3Pn613UdMzcLj925nVgbdh/lnYI+Y5KFG0AtflsIFZY=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4458;20:2/aamiqEibh/Yl3eNTBfp5JoEm0bBTUC4+Sgydz/RS3gR2fWPmW6V/VkKEipRVr2jy2DHxvZY8F1AJNXIeJeQ/xcsT0Ucdtfrp73YB4UfvJGAv3dZ0u/guHvTsGlgm8fmVblePW6Iq2mQh2S6knhGHliStygPSRFjm97qQLYWGP2Dxo3V7LGFkaZFjt3g0j0py1wcC/DMO+OZUEbp7CiAV9ttUXdb2T4t5KmzNua4StLfyazD8naym5d8eD3lG0TThbtaedRaij8JWOzqA8tqpA0I9UNVWGxKEkQiMpWKoOk5oSswcRNp+uiBRLgrpU0Aul/3B1pTPas8uzvQVfW5iOQbUbAz/2jAZKWbeA6iOesJFIy0PAlEf2rVG4M7kWcniPL9j1Ll6n0xXfmUzq8WyfD8nSY9bce3H7XPtISN69emdGjhtRVqYAnk/+3U/gDvxY22kvvWBpMoFkitWhwZ+PetgeJb1ZqNPzAGffY2j/m4Y4By1nwKveyFdalVEVn;4:rQIBG0Wb5awkt2zjmDmUWxwdKubfYoNpAlyYCKZM8yPI6yJZZT9Lf23nZcVlKpibKEy/Vu99TWrRxB9dcsMZdsDSVaNF5QLZUBlMu+yGLYqYnBxa/M0idqaBF1zsu68BsBoXnrzJJCmRWtKQhfFY+M6qoK1oGYoZdGaww0wPf1biV0WlOZjKCAiNHgR/LkLUkTjVVV7sIxqyp4a8JSST1N/53P9KcJGlgV4jBx1hvXjX2lbSMBTrL1uSI+YUcK+g7K70CZTQo9nE4MPrpKWC+Q==
X-Microsoft-Antispam-PRVS: <DB7PR05MB44586050D9CD568C7658C711CF5B0@DB7PR05MB4458.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB7PR05MB4458;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4458;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(386003)(5660300001)(69596002)(105586002)(106356001)(86362001)(97736004)(6916009)(4326008)(6246003)(76176011)(11346002)(122856001)(486006)(2616005)(476003)(446003)(186003)(54906003)(58126008)(83796002)(57986006)(50466002)(316002)(16586007)(26005)(33656002)(7736002)(3846002)(23726003)(6116002)(8936002)(81166006)(81156014)(68736007)(8676002)(53936002)(1076002)(229853002)(47776003)(52116002)(36756003)(46656002)(66066001)(478600001)(305945005)(9786002)(2906002)(9746002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4458;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4458;23:4EtajoJArUtwAnnSDJK5wDVVvjtXYUlT4rknnNFFG?=
 =?us-ascii?Q?ZvDVUu9J/aPNEvB9Yv3zEmW/eBGulZbEFMjneCVhprkGKONvXBZ6ciz6ATnZ?=
 =?us-ascii?Q?AMriuEKDaulP8jLPpI5dWzPRinyWzwVhn/K+Ma16aHOxcLeoWWnD0JF49KzR?=
 =?us-ascii?Q?0I39/fZj8es4UC2ib/M+3B2pAfL1zGk+lyyiz7wNRcLKg4bRp4EAB5aB8zex?=
 =?us-ascii?Q?QdzFXPUww/cGWRGQZPOlFBTL4FzdGgtewYu8LTCU0f9tPVsDCVkqE6jT2b6d?=
 =?us-ascii?Q?s/9chfMztVYLL1yvmGUX4yQhZl4sw0dSayHv/BLSN5aV1NZddBrsTeKbAV9C?=
 =?us-ascii?Q?GyGR6oiG77ACSq3ybQlIkR+zbVpALnPdELDcqgoJPWaWNzRJdQpacv6/6GGu?=
 =?us-ascii?Q?4wcHxbgIjfST9taa4HUuy7lz59R7buQAiNP73SQYiotCU2FYyYkmaABTVW6d?=
 =?us-ascii?Q?N4OhTqi9ik42aQczxUEgLP/ybjDotIhhYPmpzYb+u3AyAj/demk1qn1krVGD?=
 =?us-ascii?Q?1/PpJ8XIsCi84X/fwZXq/P/QFHxdDvdPFtseQdxJZt+C/a1lRlgldrGBnGw5?=
 =?us-ascii?Q?8L7QLh+3H1YJ5qqwCVUm7QJwWv+hofLKsZVIF8GbsQb97TZPqqq0aXD0lmeN?=
 =?us-ascii?Q?ooWj6jpZaSizpYebhlREoWD5ZuDv5n7BIrFBuhokzP9XPzuzZfvafS/u47l7?=
 =?us-ascii?Q?h7mF3SFMWoMdqCAL6D4+ODpgfxVbTtg84DRiWiwQFP7dy/bGGkX/pPzYOOCL?=
 =?us-ascii?Q?6nWS1kPsKcgFLrG6Y7rg/CCA5FMeLAbFPE28dI5fXhoX9uq2WeGDsAP1731k?=
 =?us-ascii?Q?XAdwV+Qwd/uA/FCv5oMPYoMUVlZMOWR/DUrI0TGNxcFPrbQk2RioYZcSbTpI?=
 =?us-ascii?Q?2+I/IIM8Dh26Tk9jgahtwsCX6tO0KcvAEfGHmN1YV3oFsj/yeTQj0NTdbrW/?=
 =?us-ascii?Q?zmTxgUGYibMFORWGu6Qqbvjzndp8yTe+v8JIO7p+wZOs9ANY6WSMZvzAGQnu?=
 =?us-ascii?Q?NCgtYhiCRpXt77cD0Fik2eK5IjYCpw8Bu0PIwtYmwaHdrSVsxezvkY5at+Wc?=
 =?us-ascii?Q?OfrC/RFLF+N1BG7GC1Cvd2+fH/ht2Sn1xkDgaNY9eYJThqkHV9wTVTry/jfX?=
 =?us-ascii?Q?Eai64tvnQ4SeHURDdNhLEkZPYze70nEkldLCyGLqELdO7VWSb9aFlkCUeATO?=
 =?us-ascii?Q?lnUphDxQFlJdvNTrSOxkzs6heClC9bF92jzfHW3zqXTyIJIgIvfKuWXKa4SO?=
 =?us-ascii?Q?cYRRwG+N2uqhzjToK1EYjfLhUJPDicXKoCU4fV4ghOb2VVXo7AUEb3jn5O50?=
 =?us-ascii?Q?j76yR0asVKcYLJJRZZP9+4Tjk7KvZqVJCyRzO1HyooO?=
X-Microsoft-Antispam-Message-Info: gy9QSq2jbaYTb/XPDckC60DR+eKhgAxWR2mxGOtV2EDSHvxTgCLVMPEJexyoso9N9fGMaMlo3RSnlg2BBv4AWfBEFq/x2qg8cjLJYZx49J/1VX+jjwf+hXFDqF9X3jTzd4E7kdxyO90uNRD19pNX3suH1eyoye1NcEOjcCi3OPsgjxJ0K+W/+ksC9yHBQsKG7FIeqTob9u6mE6jzMb98fpzOOaYVyEMrHaK7S69QX1A3z+kMDUbdYcBR1QMR4mApZYWMamc5xDVdih/cS/ZcowwvHFBV28mBb4Suod+ZXq0zxPzmE7KGdJ6smH9oZBNnxhk8ZbO1tlHnQkReBAUfnjKVmL3Dc1iPR/MnKSJc+pA=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4458;6:a7XZIJQgdGb9+6s7pecWvAuH/b0IKveSilpuKMjr6rZLNN/SQXTR/NHk1/BMZWFeNgZa5txi6PCo3x5m/hUw2zRtFAMmY6qKbvT4zfgK+7Hm3Yg4JHZDbAJpUOJCUcxG82T4CNaVhsgOxG4TbneVLIL9nAUIhW0ZIoYCjDwU1gEA7bnih/TiojL4vef67yaNcjYlJ0A25ivBZi4TOyniqP2z62tkhBX8GRGqofNCELIJbhm1fEbMzJbnzAnQLn/sGCxYCMM5ZdGUmyuFTEJeMknZiPP6PtIfQ/yQ0mPhLrR25sVcYh9u9bpXKFpGBxtF3dXu+klftPjUgz12vqfTimbhIJIlE2XF5d0XYUziZSI5yqJK4GkUguBzOxmBb8Uc1M+ZBl+CAUIsm6XxMKZW0uvcHe/nJJDDPjaWGbaxdCvFknuHbaUVc8U3V9jSKeemNpZrWIX79rFNPrKkh+Qcvw==;5:ZsGMZSggpPvt0FI1Mb0h5zrBzw6H6Lnu2GKTrzX2mCCSksZYPmusQrP8GpwSEiwXMR7FHF9qAiILoAaigqHdMACS/eqHFOEMWmi47oScmsbLRaCJKRIJFdwUavKJWxakrjsacUmDIOkfS3F28ZSyYsWKTd88nUYdz+br7AmcZYI=;24:FidKyYLE01covkyGnUlhxDRmT64xkiyQZOG4JWGmdK/4/FVlAzQkwxhzqZVlPZB+7QlThbANuFxqk7Q7B80l9wBwTZRoTRR/wIp/6m+7RGU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4458;7:bictCjDBAy3eH4KZn3Onh4tevtgvU6WD4Jpy+grwf31IAdub4dnr1Uwf4blZe8c0vscnp6JtCxpHSjW39G4snX6yPPS8kAZnxl0CX++9mfRytnTbXHZ64RehKzV9QqPmxCJUzMr9et2Bf3I3jUoEdj6PaBIX8cWKnhiNukXmp/eBkfNRKme6I92QV2ZUn0K2HKIJYPDDilVq5VsBg3S94E2mjEvAUXR78mUwt5QWWsnG759Dnyb8ORnRb0kxeHFM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 04:11:54.9960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cd42b5-8c0c-425a-3dae-08d5e61b45c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:05:12PM +1000, Stephen Rothwell wrote:
> Hi Jason,
> 
> On Mon, 9 Jul 2018 21:41:57 -0600 Jason Gunthorpe <jgg@mellanox.com> wrote:
> > 
> > What compiler is producing these? I got nothing from 0-day build
> > service or my local gcc-7..
> 
> The x86 compiler is a v7.3.1 cross compiler hosted on PowerPC LE and
> built from sources.

Curiouser and curiouser.. Mine is

gcc version 7.3.0 (Ubuntu 7.3.0-21ubuntu1~16.04) 

> > They are false positives and I guess we need to put the
> > uninitialized_var back that was hiding them.
> 
> Rats.  :-(

Indeed.. I dislike that macro.

Jason
