Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeFAOJL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:09:11 -0400
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:48480
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751465AbeFAOJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:09:07 -0400
Date: Fri, 1 Jun 2018 17:08:51 +0300
From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] qtnfmac: fix NULL pointer dereference
Message-ID: <20180601140848.czb4ws5nixuk4tjb@bars>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180601132408.GA2572@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601132408.GA2572@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [195.182.157.78]
X-ClientProxiedBy: AM6PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::39) To CY1PR05MB1929.namprd05.prod.outlook.com
 (2a01:111:e400:58d0::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR05MB1929;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR05MB1929;3:GrJytJ133MrF1O4pFWBMJeSR/13f61KGjSoz7qkYcpeGQUp+NHNzz6Hyp76n6Z7OIrEvApGp5nS/Hi0g9VpxLaQFVxtVZF2xJzStXJZ/2rpifbuiQhemLgLszNYI6hD+F9uinYF0juGKa/hkQayzFJIKt9ccSqDImPjH9tGLRawTMT4t7e/xsEnOIsqhVR2MpjuxPflU0OGwmvr2d+z4LRlIXwx9GI3qhHgpITipmyaovEl3glv/6nZusMTao9LG;25:0BY7+1lbx8jflOEIY6ZrI6TR95TXSEbYJpn6ncsfZ6k3j/MjsxiCqylKwXMH6HFlmZeHNJZEZ2dbnhmH09+nq17P421rN2fjUtS1ml8lNIdxqosBIKSXlmbkPlN9oFPOVXuej9o9Dqfv0uxTxerERztikGI9cfanMj7gg9bv8TpbiwKWxTNTPqw7YYlTsJqEL+2FTJZUr4jHvPMzr5ABaafZY5+uosUcwP76FMkxaHt42JQYFqrwcQQT6wdqNev9h6fPV63xni4l7V2kkDZpkN17xinBBRvyJ83Q1PVHuz25HhhfRAt2Z8+UFfAIKjR3JCrCNKZ4dfOM5UH7bfKShw==;31:9DEa7sm3F6OgKKos5SjElmcDT6uoTKwSG9YrdxFTN/8w5RbKmEKZhdAn882qONKd3f6qFe+HBwXQXppEG/PkTQJKfl1PzvtdLbotsXaxCkoGpcMS30NQs8XFIh00e+uWG7BZikguDh5gEe2dBFKEUbMGhYl/v39sRGPtoJz24sLLXnUkQvbmTbjWHjFnVz2PH88AT82HUNpW0lO6v75LDJg2DaLoBL1olUJOq2ICF8A=
X-MS-TrafficTypeDiagnostic: CY1PR05MB1929:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sergey.matyukevich.os@quantenna.com;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR05MB1929;20:TmVPBTGfroYbn4RoWqXhNavYuReT/MgqmpkaywaY2zUSB/cmT3yRzQIoS1KGhr9LknlZkBtxYi2QY0qTj28sNcMM2ZwjxRaEnq18L3Q7Ib/mo0fJXPbQOaEgKFYxI+Kra9vFTRLcoci+yMMybF4wwY2FgtafTyseMsmzoEMiyqCFPg4cIWI2r6XHvUgCf/ZKn6vjs0UiobldaVMvcA2RU2wh/tGUvFCS7he+/pM4LZXuUFXe6So4TTWSjNmAnMHlkHRU63YmHYtG07olSC+sTwxBy4i9ZHlUpOFSSWX6KRcs9Swz6B2z3IuQaYK9S1R+Va59L5oDzP46iBAaovLRyUelwfj2Xp2maIVjyyyQ8CbSyW7S5OzM87ze+9bJmZfzYF6NBgHkGvzNxWi2tSMgEJNtmvGDBIWOlPtiF1dDD/ZrYCaNtd2LdO6URRN0Xg/VhN+CLH578hdHzQIqNFVwBwlcMLzdoAnCyPeO1GLGSewRjSku8zoFe2luPJ72aQ+3;4:85PhoOKuwQmTKFMffFIKwN7LP8NaDOft7Ell3DH3OtgyI4kiYXHeXZvPsbK5RpQgi0N2IPmQ5N89USQPZWoHjcx8+A4IcVMY8be6kdKt38vA8agtQzoMWTQ6MHV+5zB/jMwUsjcmhcJUkrs1RkNcg6bV6sW2GAmoaQS7DvkpIMFftLadnR/dgOAbB4hxoIIhKhJ9VjO5SJr052aPGuGjaKkDCvr8ng8xBFKTs+KNmZswuEPEyI5UViRimG2dR6P9zxwjZ9lEhhM2kAE8P56xeg==
X-Microsoft-Antispam-PRVS: <CY1PR05MB19291D5589B9187DFBD755B8A3620@CY1PR05MB1929.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR05MB1929;BCL:0;PCL:0;RULEID:;SRVR:CY1PR05MB1929;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39850400004)(396003)(366004)(376002)(346002)(199004)(51914003)(189003)(6116002)(23726003)(3846002)(33716001)(7736002)(9686003)(68736007)(11346002)(956004)(478600001)(33896004)(446003)(486006)(58126008)(16586007)(316002)(476003)(386003)(50466002)(52116002)(76176011)(25786009)(86362001)(53936002)(54906003)(1076002)(4326008)(26005)(16526019)(575784001)(8936002)(97736004)(81166006)(229853002)(186003)(6496006)(66066001)(6666003)(81156014)(2906002)(6916009)(47776003)(305945005)(8676002)(6246003)(106356001)(105586002)(5660300001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR05MB1929;H:bars;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR05MB1929;23:n0jYA/O0a+itSJ96PV5BDjYmZk+rhXGT3gkey9S8X?=
 =?us-ascii?Q?u/zkeNzw6OqPpVAOIWNQ9YN4PEUavjnwuxhf/Dpa9DI3TAUc55fO2eNJzMmv?=
 =?us-ascii?Q?FETvF2I9J6Ukzzavrp/gwsl9tze56gZJzGK0O5KED7Nk7pAySZxt4Xss7A6j?=
 =?us-ascii?Q?d55IuvQ6nfILQ4pR9XsUB0Ad840KIrSTgE3n8210rvJUbf1ZrLAh59kB9AAf?=
 =?us-ascii?Q?2HSMvL8TOTVPocOMbMVnIwwINQUt7YcOvxGTjziuyzRzmw0ylOFzkavw4e5Z?=
 =?us-ascii?Q?vUpzYM241NNcnUzJwPiP3g/NMYO82tX+1FxWwaknSIVMB0KWi0y3djYPcucF?=
 =?us-ascii?Q?FKTmAZk9BgMsNgESKu6QseJiUArmymy8r7gA8aLCuLZAuFrxHwzK7udSJXn4?=
 =?us-ascii?Q?dPxns+0JnglPUG45NE3NTFQ6r5O689DdwvoIwkGEj+CkjndrYZK1BRn29ZXk?=
 =?us-ascii?Q?YXO3bkb6syP0so+d2XYIONLR70wlCdwY6//MFoMKW/F4IcTYkJ5cjRbP34nE?=
 =?us-ascii?Q?QQrAkYtmo573QrntoSxRLaqOoau1GvSUDozPcHrO+YPXbB4H/561JmkrWm1g?=
 =?us-ascii?Q?bqvBBlGiRIOQ4W+mJNPMh8HwfMJaFvQNn2CSShlWGCFoL8KN1XAZMR3+yDc1?=
 =?us-ascii?Q?9fo+QUjXeMoIZHQSIB5X3v20zmVPQ3Vux6IZC+wM2d3OLX1n7CUgW8b3k5oL?=
 =?us-ascii?Q?1yuKq2e0Gk/mghdaGMl9iHQ2NlWFnBptUjdT165ppxBMwzPY+vtQpNIl+dRA?=
 =?us-ascii?Q?d/Bb5jDszW/venj4194kP8Th9n9MEPT7EFbom7XBLcAT+MlgcnbnY/s+5Gln?=
 =?us-ascii?Q?bsilcC0sjib6i8O4LJltb5dFxvD9T6zAlMXVKFn5z4L42qhtPujOPGVMg3wM?=
 =?us-ascii?Q?FIqfjTQlY79WwZMABh/NRPyNFh/oK61n8olLZtQ0mI9b5dtWu80oTXkxh+Fe?=
 =?us-ascii?Q?Xt0qloNa1mQAWRPUQ7t8WtFQtTMc7xqpnUaw0ZH+95ShpOu8gkjEDHoKRAKp?=
 =?us-ascii?Q?oYKssH/GmtC14oJYXIFVQdRLOwQBZ49060qGc58sVpkPYD2YiViAzJuToMjr?=
 =?us-ascii?Q?OwrzJ5e2wN+rYhSJs0LHrjB1p1XmqgqqZoJJ6b6udkXW484gH4pLLYGy9Shk?=
 =?us-ascii?Q?6lDTkE/igFbVXuIu0VSkcWqaDqhXbniseb63+7GOctgq9LNurwKPot5yWpdF?=
 =?us-ascii?Q?vuWStQ8fS5TSU+MJxvRjXRlDtEl2fagG+bw9pJCQ4cJReQvySX4GEY5bI+uY?=
 =?us-ascii?Q?d0Z8STNU0xnBVqAQxqvMK1xfGSbKUbeoW/nyPsj3L8Bk0S5vKavOVgNFGSz5?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: DvuZkr80Ci+DrP+zPvzzVnuFuXVj1G3Bjx1+dO3KyIOvU70kK9y2ggHkbL7hk9GP9j/r4IQNBCBOUoinJk8VG1Y9/Xa6B4Ab32qQewjZja8D06osUdfJOvERIneXwC2Gr4F8fl37QPeNHy7vENUmptCP+m6cQSbkh0IrpjY6345Uk1hG3gkXPkrzFQAGCheo
X-Microsoft-Exchange-Diagnostics: 1;CY1PR05MB1929;6:9Uo5M7gCayslitU8VUrPWvbwNOCYUNlKHjcCN5p48DkJldrM+B++VqCDraPBa2RmHorbECQw1Yy/sdsWHGvtWFCnHIPYOdFlfXQtsl4kRoeuP0lrx6Pz7tU8nz18tyeJeAF000Ylwc2XFgkgTTKO0ikMFQsU4dmEmyOq6/LTI8I7xqxD+E4C4nA3DLGvWCauw2xJ6tO/+SBWW526jDYd20W+JcQvJ8YjUkNozpn+Iq9WC6Ivh1gso6QC9MbUA0hLbm2MRPx/D3M3ZYQhRsr5LnaFcqzzu6ebjFP9MRAB6Pq3Ilco2P0/DLLUvArsZ/s+yrPbqDSnvBugld4Ut+ytJVj98Kjz3EO5FVdrOEiis0+6SkzXAq+1KPK6NrY9xYT+dfTu5qcfbf5p6+bQ2kwEMV3SJu31vB3uLTUisd9uRJJS6LESZsnCjHBdvlMJwiU3Sk3xmoroj8RWoOCjBzgMoA==;5:vSUyrlvY08gYMoKrLoVwoab9utaupuj6x8SPZMvorNE5TINk5arPyESdAgQQUqmi1olvV9Do+nwOd7UdFoBRZyNlGM8Td9xiUmHfZAKhtnzk3sl6Ppo8c3XHsKwxmq9pp7xJnrPgmZH1oTK7vy2WrX10fixhXuRrPpZKAxgkqDo=;24:HWF+qiIRm5cL9KpFJf/MNKunuIIETS7CYBevkYe25E//o6zEgt0tXy/Nb5scIcmHEjPqu8hfd5U4rdUKF0fyGneLSbDFVv76FQ3d008j2Ac=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR05MB1929;7:vPp5zztUdmeIhF5FbwZeZuMczZJBL5ATp4r4reSM4igI16Jg/X2IMN6x9oShJs0RGt9p/ePsLzeDVixRVb5QxdergBW3bEOVOzhOukrr45Zd3iy4F3ENxHUlrwnyJDBBEnWw3QmOb8qKMJhRE4pdCjMrSj2mIqReFyeOESMSBAMVtQgV28jZmdd/KO5hCgGiUW6cnxF7CAByZXnfgFeTZX6TeCCioj4Ij/VBbF6mXkGx9b1fApGRI4bprp5RJbi7
X-MS-Office365-Filtering-Correlation-Id: 74ceb1b7-e045-4e06-63f2-08d5c7c93c45
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 14:09:01.3822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ceb1b7-e045-4e06-63f2-08d5c7c93c45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR05MB1929
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gustavo,

> diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
> index 220e2b7..ae0ca80 100644
> --- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
> +++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
> @@ -654,8 +654,7 @@ qtnf_disconnect(struct wiphy *wiphy, struct net_device *dev,
>         vif = qtnf_mac_get_base_vif(mac);
>         if (!vif) {
>                 pr_err("MAC%u: primary VIF is not configured\n", mac->macid);
> -               ret = -EFAULT;
> -               goto out;
> +               return -EFAULT;
>         }
> 
>         if (vif->wdev.iftype != NL80211_IFTYPE_STATION) {

That was my fault. Thanks for the fix!

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quanenna.com>

Regards,
Sergey
