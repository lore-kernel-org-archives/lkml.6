Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDDFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D452073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="o43eLWtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D452073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeH3H4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:56:46 -0400
Received: from mail-eopbgr730071.outbound.protection.outlook.com ([40.107.73.71]:46400
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727438AbeH3H4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdBjiBEDj+GMS4UwuI/enGq+G3G/huQ5tF0AX7QNTMk=;
 b=o43eLWtGm71ms9im+G6mJDAfqvVMOALs7dg9tzrQt4+nnGbUTrI/Hj/8rAWSx6yfYs9pFnkQJnfUSI0gbuucjJxJ/Y1tmAaS0uQ1e9tUKY110wZSCpcul65k/SVcKPRjtzteEaOlIu9tjhhzNUQNycKo6qeGAqXzUO+MTL9sV2I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1570.namprd03.prod.outlook.com (2a01:111:e400:52a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Thu, 30 Aug
 2018 03:56:33 +0000
Date:   Thu, 30 Aug 2018 11:53:29 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] net: mvneta: some bug fix and trivial improvement
Message-ID: <20180830115329.280943ef@xhacker.debian>
In-Reply-To: <20180829165131.52798cd6@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829162932.6015e89d@xhacker.debian>
        <20180829130836.GD1955@lunn.ch>
        <20180829165131.52798cd6@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0161.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::29) To BLUPR0301MB1570.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d9cf1c1-662d-4713-df1a-08d60e2c94c8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1570;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;3:QMHrFrNw9FNp+ZAhg6a0oB13cL6hvndRXNW6oyNLfdL/NniQYt5Cfxy5kIWMwd+Cygj1m7eE75ZFTf9Qr7BGNuE6AG64HYJyZmSrC82jV3auI0clVveptm5xOgAiU4B55XUg4oRiBtHI++8sin+jvURpEp225wUywosxsABNptAiM3ZaXHhIVOclPdV3fq8u+WuwAuJSYRinYOiogSFdx7MGSC7/PU6jX+/UE1pFn268BEZFZ7nss5HASvja8Im0;25:Q+3f3vsuj6y7+aDzVzPTLyOAyend2DtABtwY69LuDE9powK/+S1vA96GI0Jb8wh2sF9M+0qAZxcT5XTBl1HKFcuB/0EYBmzbUSyaTLi1gasNtUejix9A1jBvxc11dllQjr+WL64K59+kFXBGeFJXIrrMr+dJsqGQchdazfFm8xOu/KwbHrDC03t3axxzy4NjlLINTOQk6G7z4YS+fm2+8rptrdA/MamrX67+T+xZdPxraeB5r/gC2RP7mqRrPbjNxULT1WYXD0PUuJK0fXnLpyslbMqQHNKFIo9Ei+8DTWWui1FyB48daiGZHnsNiEtWdNzO7UItIHvf+gQjiy7VaQ==;31:qD9jhD7gvC0ZTu4ABez9NLBxKzEaHzVTahKjw2kUrBHFTzlGntjlpmzHN44lg2e4+N5OLa8WkWzwIPGKwcaP4BOUa4gwX08bPyBys8hyZPK1zTaRZErrqESYNCeDS0ZdtVEOYDHPSyD4e7ME3vnwO7w1dqd08YnsGunTdj/GrjxIzlxhdSnPl1esOLgFqKj2taFkGfYMDCvDdXl2uxnBZPJ7Vn5JCCmUjJNWnH1s0pI=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1570:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;20:AbgBcDTP0cahxBt+wFHXOGv8IhABe27SzP7mHxvX3Qgxl9moYKWQY54t3ynHclYdmUmEsrFPbz9b3b5tgwFYGWz3i994uZ2ji72KMt34Jmb9EKUeOhpYCgm9A47RohGYytzhgSmANXBC8zRpOhdXZaed3CrNGoPSSaFfSgvx6GQm2jWIOytlTwBj+QVB7YJloNZNA5iAWWSdjPLsiY3ulDjvU9/kH70vQOxwdx7quIE1LgwNRWiGVinNrQMUK7iAY83MY6N7jaqNT4jWXjevDOOLvdDLh3bK8rca9WzDn3u8uq9CeHMztqsBe7iCQKdMQ6TxUylrfxVJMZbH0C/K0HbnkiDXCCcdBoUEgN2dpi3L6EEBySodqMss3UY0Vj8JslFi18S+69Wn02x0QnqdZHxHLctiMFDe/UW7hxoE8iNI54B1oUfWuc6i+bLSkzSIR8uFckwX922kMZHRVpHMERMKZIcsGZwmHRFX2CYanOBCbDKjbMp6wk1ek0dZ5weY;4:2OY/RgzqSNF2v03Oa9LWuzrSJff5VUJQXdN6r23LLLjB4J8OTOyz8u1TxmZi+JvdP45+204ZK9yZKbDlTZk8/T9dslgLXCBfEMcK6ucUWHoemXwek5xxRgNQC1nZt1voriBX67ZxSOXoI4CvziMO8drm+VRPG2Zbr0USCfsfufgSZ1P6ZFyy5bnRJ9t4Lw7Uln4M17u/HGWPigr7KzJrqcilvIefCvJcntA0KrbRqrTHKIYvTAEPkG2RLQsiKPDFS8ZfxE63m5jDaC/9eXu45Q==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1570894172C8D115984476A2ED080@BLUPR0301MB1570.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BLUPR0301MB1570;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1570;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(136003)(52314003)(199004)(189003)(1076002)(3846002)(8936002)(6116002)(23726003)(76176011)(8676002)(72206003)(86362001)(81166006)(81156014)(4326008)(33896004)(105586002)(229853002)(50226002)(68736007)(55016002)(2906002)(106356001)(230700001)(53936002)(9686003)(6666003)(66066001)(47776003)(5660300001)(110136005)(478600001)(50466002)(486006)(386003)(6506007)(305945005)(14444005)(7736002)(97736004)(6246003)(7696005)(25786009)(93886005)(16526019)(26005)(186003)(956004)(316002)(476003)(11346002)(446003)(52116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1570;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1570;23:SOJXOVdc38AUXhwDX8IxFe2oABFb+w2epZLHzz+?=
 =?us-ascii?Q?8eWIggVcvDtVgCN0Opni7bkYCPOoo296nRF01GjsDZ32flwwkg9T2D+e12Lx?=
 =?us-ascii?Q?D8UNwA93K4S4L1TlNMmmmWWD0+AvJilZw7UW4voXvvrXjOO9a7eZA1QszDkk?=
 =?us-ascii?Q?9SmkxS8GYrigdSdpemcuRJkt7bHiDiV5McRLNCMdH1CAH8tKIxFTjwYrrza+?=
 =?us-ascii?Q?EsO/HqMbG8TpUDaDcfScydY5f4Lg5jds8A1UhxWM8R/v7xsKoA6CFuiusLYX?=
 =?us-ascii?Q?bNE5xss+HXBBD2/DdL/9ji3GZZbN9J7wMZETn9Pge2OUriPaOzGyjKIxOdF8?=
 =?us-ascii?Q?Fyj7z+wP8XoZyeYLkFSGkvFnYIthml2eznueG4XJOTGfdB7Cpj7+3DJ8pLfu?=
 =?us-ascii?Q?GYtjed6dz9fcTNg6iN7Lo+lS0HrbLGCmuTYGjXOk2K3j1caJLSbiOJR/tqaq?=
 =?us-ascii?Q?+pzbMokNbZ/a//7gn6XJo0MCnM94Wv5mZbSIjCWNgYiUZSm2LeJjKvbiPGHh?=
 =?us-ascii?Q?pMwkKZtCDVCBnRterbqh8QwNtaULgFrn1ffJOOZi1fmPM6iP5f+hm8P6ZtCa?=
 =?us-ascii?Q?NgUIC1+qd3RbCERNmHPeqDIPauaHKuMSDXohCSHspp1ZzOWSOK0eAsr7eQIM?=
 =?us-ascii?Q?kRBPQoNYjYFFNXQz1cVSeAuH4/I64Ux/sPmjWcIXc8pquQ5Qs/IqezFyg4Zy?=
 =?us-ascii?Q?qrC7UUbwEI9/KQg5hp/8QjiKdXjf1ejjkUvUDLpe9k6E4SzatQdvh1xGjrkq?=
 =?us-ascii?Q?3x97MfAmBF1xbj9FdnOKTTZCksn8IaWnEhpRuewgN6+p6uy3WSG1FP62pH05?=
 =?us-ascii?Q?83p+PTTczwNmGT4Xiy2Vf89BGzYeApfQgHzFzkhvwbwFNNsj+DSMc4GpVx9I?=
 =?us-ascii?Q?9jo/nE6KnVj6p+vd3i7E57ir4BrpZpY0f5so4P66u30qJWPzFVelPrg/Mxeb?=
 =?us-ascii?Q?ZoMuMdV/2wpA6F6ZJIaVBRc9dhVv2YaOLWRA65mGuGkFYYfaUwp49pVKQPmY?=
 =?us-ascii?Q?jfwt7av92pnzLLHCp7jhz7hlx2FoTYHfPS7vh7QOKqgUimVV0OqstPMM24oc?=
 =?us-ascii?Q?nJPAHA+hMeVb1gwWfjM5PPo4NKmKDegRnqMp0+RRAO5TmWwzoOQXKtkNRsru?=
 =?us-ascii?Q?4S3+LW6/lVLzQp9VLMM6zrAqs2JVVQkQ8QUdkLsPsglRrbgIW5Q+dNgJ0enu?=
 =?us-ascii?Q?LOBoTedxzQ/3CRX98qdFwbpfqkR/7tu98C5M484cnUsXzGaSrXQl/deuHRJW?=
 =?us-ascii?Q?VJ25rcKqJk0LAVvLfm/hETVKL+WqrvVblnUM1pm0cXbvdv4Jwpwu0UxyCWz1?=
 =?us-ascii?Q?WWaVgeaTuWFwdi2PZp2r9Lhg=3D?=
X-Microsoft-Antispam-Message-Info: D1yHZ2iPvJ55cuhL3GS12fClBLfQ9xFU09tyNvOg4fngNL2R1OuPeJmNvkeYH8HNulVtOVJFFjBElsJIESPOwRHh6clCLFQSgGPh7CLZho/attftnVIpmvumf5vUjFfENulA8Zz124AEyR0pHVbkxX++9GuXUGGmRmpKulGs7K2fBkBeaoPoP3HsPu1sGSo0loKplT9gr4xmZKRlrdtrrMGPFQ2qg7gPUGUpF28e2KZczWd8bTMuKIVYCv3aAzoYMo1BQiSh3GzJo/rFmRItTk9Rb8A9Plc6imcO5QKDTZn+3rbXptD8CXHDkiDX07LH0Eug8W+FY8J9EYqF4PUNRLcClV0Tn+XUk6uRaoVR13E=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;6:/9goM8ek7thAX6uar0M3/ruraOnPumYAc3ee1pyuj9VLRejGP+1s1jDRJ4e4UWaPK/uKAfnXCsNyKB0hDwd5AD+97ULjYvlzJ/pCWC8YL3MHCpVc7lgQUww+BiOf50D9RtiWkY4QStbnpMMKKfIS8II8r1zUTHyY7Xsa0/G4LWWZrvfLqnYDQoc5CbLx8q1oXc1/BXPElNaDa7Ka0xGcwrGcr5m/UMfQ7vj3J0MgCNyLZJ3+x/iC99tcP21xOBaeGfAkzOIxom+ZWsrKXT81K8uWSzVqWazQfWwSaT24oOtEnQlUma0aZqBFZYiOnlqw0pyYHr/h2G1dW3MoBKiDFkOfy1xZaKVyDzzjWdaz9kM8mfmTKsCuRqyvOq9IyQCt/ywXgZEwUOLKoBQ5Xlh4K9ZJuknfrn1ucSYtGbarkJsWc/YeMGxCxGgyInAinLYhv1UF7rfOMjjbLDNfs1uEjg==;5:vjh7z1DUTV3eF1VccchJManO7GbTJLzxvfkA55kwtXbwGj0fThnKX2KQstLes0v9ZOD9X1+gyskBA8VBz8XhFe1KKxOWJJ8g40uTpvR3PqWvQqeVFQaF2SlWxloo9o/40oXYgcAAPz/sBWhKvp7KbsI0icoBUnfcF93e8Dokr0s=;7:j8vmlQZj+P0QUYovtmDDAjY9LFISnUu/ApCSE0kSaXuRDZfrQXCdqYoQMT0qcmpXzVJROttzsWiO4TWWk8KvPu3KtroSGozOvYuSCWpqXToJEEtD2sFkvzNCnvg5N+brU9pCItH7bEdZh2hCC4KqCNJY1RjqmvuOyNWvixQI/oqBOobLhxZsGnWgERvI8dPLW51anuKbmuvZ8vlCfnt389OR4HBXbP3Q/9yaZRwvfhSVpG8W4bGeEawf2Fx5TknZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 03:56:33.6997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9cf1c1-662d-4713-df1a-08d60e2c94c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 16:51:31 +0800 Jisheng Zhang wrote:

> On Wed, 29 Aug 2018 16:40:24 +0800 Jisheng Zhang wrote:
> 
> > On Wed, 29 Aug 2018 16:25:57 +0800
> > Jisheng Zhang wrote:
> >   
> > > patch1 fixes rx_offset_correction set and usage. Because the
> > > rx_offset_correction is RX packet offset correction for platforms,
> > > it's not related with SW BM, instead, it's only related with the
> > > platform's NET_SKB_PAD.
> > > 
> > > patch2 fixes the wrong function to unmap rx buf    
> > 
> > I have question about the following two commits:
> > 
> > 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor"), it cause
> > a waste, for normal 1500 MTU, before this patch we allocate 1920Bytes for rx
> > after this patch, we always allocate PAGE_SIZE bytes, if PAGE_SIZE=4096, we
> > waste 53% memory for each rx buf. I'm not sure whether the performance
> > improvement deserve the pay.
> > 
> > 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> > mentions that "With system having a small memory (around 256MB), the state
> > "cannot allocate memory to refill with new buffer" is reach pretty quickly"
> > is it due to the memory waste as said above? Anyway, by this commit, we
> > want to improve the situation on a small memory system, so should we firstly
> > revert commit 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")?

Any comments? 

Now I believe the situation is due to the memory waste introduced by 7e47fd84b56b
With linux 4.18, I tried to limit berlin platforms available memory to 256MB,
I didn't see "cannot allocate memory to refill with new buffer".

Thanks

> >   
> 
> If maintainers decide to revert the two commits: 7e47fd84b56b and 562e2f467e71
> then, patch1,2,3 are useless, we can drop them. Only patch4 and patch5 are
> still useful.
> 
> Thanks
> 
> > Any comments are welcome!
> > 
> > Thanks
> > 
> >   
> > > 
> > > patch3 removes the NETIF_F_GRO check ourself, because the net subsystem
> > > will handle it for us.
> > > 
> > > patch4 enables NETIF_F_RXCSUM by default, since the driver and HW
> > > supports the feature.
> > > 
> > > patch5 is a trivial optimization, to reduce smp_processor_id() calling
> > > in mvneta_tx_done_gbe.
> > > 
> > > Jisheng Zhang (5):
> > >   net: mvneta: fix rx_offset_correction set and usage
> > >   net: mvneta: fix the wrong function to unmap rx buf
> > >   net: mvneta: Don't check NETIF_F_GRO ourself
> > >   net: mvneta: enable NETIF_F_RXCSUM by default
> > >   net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe
> > > 
> > >  drivers/net/ethernet/marvell/mvneta.c | 49 ++++++++++++---------------
> > >  1 file changed, 22 insertions(+), 27 deletions(-)
> > >     
> >   
> 

