Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7C0C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE0F20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ZYe9i7eX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE0F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbeGZTJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:09:02 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:38880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730768AbeGZTJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzw9W8XA2r0OoxhRvOdB0uSAWg72RbeR8KrOpJGnybg=;
 b=ZYe9i7eXlMju/rUHJq89LIvb+lHSSRYNeBORcjGu4drLZrBtnUFao0QFiHbvnwSSHQZxyM5SNcqyXD81JFtLJb3pGjzAOcjbcMpBydW/XM8Xp9a9sc9Z7tjCJN2wtz22Pup/JPgPJ4wPYFTcXDyvCjcG1ozx4Tx8jvWjRLQOZxs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4936.namprd08.prod.outlook.com (2603:10b6:a03:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 17:51:04 +0000
Date:   Thu, 26 Jul 2018 10:51:00 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: configs: remove no longer needed config option
Message-ID: <20180726175100.br5uk2z4aryfx64q@pburton-laptop>
References: <20180626153035.361-1-anders.roxell@linaro.org>
 <CADYN=9+HHA+uFJT+QX9hvM1nunTg6zqwVwBeSuAVFAYjBanhSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9+HHA+uFJT+QX9hvM1nunTg6zqwVwBeSuAVFAYjBanhSg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:320:31::33) To BYAPR08MB4936.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7231cbf8-8926-4b33-7b29-08d5f3205bc2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;3:oxuEGJ0vzUNLcBcKO+Irg9tfEhKMKt81etV5WFDbNkWNWNpxCJLXuh0eeS1T5+AK/vtVEm3EGASROZ81rJwHyfElSNbb/ugPBIuZyq4E4c3u9zz6mf08Z9NXVae1Yidmv5G/wj3BO7pWxKs34f+f5fYcEnXI/VFTdC0T5KNu3ZIfWrWb3LBRSStzxHKrCM+OCbjlVOHt/qKJBv1AjVqs7LszjtG4e6EEqAsVWYQy7V+mVLEixNQeZsGxsAEG7o+t;25:gLloyEoovfsTiV4c+EaRsVJQPO6RBFs/PodALNENZCd3sAQhp0HFerXldhwHLjoYf/61yaLn9Ez9BI1JXJmZwqwHv012AnwwwNapTZGf5150Eb+fAzwGCjBA/EZ7Gi8izoERhL2/wUlKuVee2sI4bUcv2MLMYCNw9QblhsQoDG9P1M65CWOnyupTRVnU2ynG6EVxL0VviFRpS7NKFJRJ+dLRDpNhuDRtZK036//bBhmynr8geQtliz4qQRC0c/XPO849syR8vDJywoeSBH5quQs9Eo/FwZwaG5LKP7WOj95aRcKMJygvlK4Oy1wbhMdkNO8wSBwyCDsKvVSWmzhhEg==;31:5CpCmRZDuK6Dh2Kk/xP6iPyBi0DgpILtaN03yEatEzZaV+E6nMn2awst6dPBmSlBozqDPv0pZ+2vomyeiyJWL3p5X70JxC8G1wavNAenVaSUa+mcYKpODWS3pr/OScbr8R28uonrfULLMDin8quu5SWUlR3QpdYfxQswc+GgRVTAMycqqFneNZd/XHSdpzxwBkW62UJkbYLZ5mapc7RxuhtqH+OSanEpJENL7ECofLA=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4936:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;20:6D5IVyvVX/0y00jDV91uOZvKdkAg3w+AiJZ1mliVjElXiKYusxWlD4qqmOCBj3rchB2QaAi1PnvLfepAW2uOdosH/ypEPwXWggR2Cm/0kxgiFiEC33TUmR0ZIOQf5wQdoEICbGQrdDkZpK3jfG5Q3Sz/3YNdfBj2AWKYLHG65Qs+kzQuwj2DyCcqqwaNf9gylS29eMOi2htanckIAwE3P91jzB+tTONBpiG/guKb/aQCJPorA7yuStPj6LJJY6Y7;4:ltcZEL5GEXpNg4+S2gbaLzcqMyn2IWhGy93YEIh9HT1XrBN3ymDXsIl+YK8becdv9uTdVzxgCweQdC+fjBgRtRbaOOdBuoOlQPeBQAZx70cVz+nOi0U5MgVDc3cugjG8iLP1qDOH808mcgGTGzI3T23m/Ga/nF7oqICSI1YzF3JLQj/fUtLhFbIkBjKvjycscsA4lM5EQhbjWzB/MJs3WoF46yHaMaU5xKyT43a1RRh99gSxbxcQ5bFc3NfwiVITAlU/TnElrUkdALFY/5M6zQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4936FEC87AC5088A984DA86BC12B0@BYAPR08MB4936.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4936;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4936;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(396003)(366004)(39830400003)(136003)(376002)(189003)(199004)(52314003)(52116002)(956004)(6486002)(11346002)(47776003)(76176011)(5660300001)(50466002)(446003)(476003)(229853002)(66066001)(68736007)(33896004)(16586007)(9686003)(2906002)(81166006)(76506005)(8676002)(42882007)(8936002)(6496006)(386003)(81156014)(316002)(58126008)(6916009)(305945005)(106356001)(1076002)(105586002)(186003)(3846002)(6246003)(16526019)(6116002)(33716001)(6666003)(23726003)(478600001)(25786009)(4326008)(97736004)(26005)(486006)(44832011)(7736002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4936;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4936;23:T91cdEHRKggMWdgi2OcJFCg3vcjLh93WLg/y8KXz+?=
 =?us-ascii?Q?XfctbtNzlAnLclqixfB3l5N367CqZysyCYMELvbcY8rlCBv9JJaM0ARcU4JX?=
 =?us-ascii?Q?Br30+GWdutgfVZo3w4oqZwMO1v5YXXqT223ke1tnLF/qPMlAjy9TDRHdbey9?=
 =?us-ascii?Q?B0cXCjUXXWK3mLsE+5S4RjwrkbyKmrgglgu56mJxx2kWU63EQPXkO4v7WQf7?=
 =?us-ascii?Q?8l45/H0aqwDQkvTYM3OHszJHg2bRewO5ls1hxcUBrCG5tU3tlSEfJwDfqcKo?=
 =?us-ascii?Q?p0iqhmdn3m/Ex1ufc+mhMNZrKxzYjH2Z2Xu8KHQlW6DdzuEOUYD9LJ7r4Ijb?=
 =?us-ascii?Q?VfXJ5YXUi/IA1HErCaIu+YCb+3YvkzYd8JBnygAylQBBIgQeeMQjuWFpm1Tn?=
 =?us-ascii?Q?+6t0gSh186+nDd9w0t24W9XbdsZr5LcPZh4byslL1cvJosD6YFX07WVcaBac?=
 =?us-ascii?Q?CxFo/S3/PG/qfL6wFHq3+YlFVUvUNuMeKVp4qN7tL9Snz1ecsR7LjGZqwZzd?=
 =?us-ascii?Q?8ytX9EMWpcHr45ea8zDTb9YvDY9jTu1ZSGV7Jc4XaU/CIazmBXa6c42syOJk?=
 =?us-ascii?Q?tAER08mApTzWdKQk8FBVoFC3hJo+QvgtucJOvg52W3yY56JqA9jbqqqhoq5Z?=
 =?us-ascii?Q?C30rEKVn5l3R5b5UJ21Qgsbsp5xW/ZrCy6qMVIKzCQKb/LjnMxDdMeqSxGJd?=
 =?us-ascii?Q?96V9IHXLjoHe6ejgrte1T/rWrlOdHXT0NkEuMFssyK78pG4TXMudWaOHrgT0?=
 =?us-ascii?Q?CR39RYyrcgWt/6GUJzczpKsZOvot+Ge6doU7s73PwdRjvc2VqYoKhytWv+o/?=
 =?us-ascii?Q?fgEculNrDr48kuHXIykxWgOju3goAgpJY42TUASMTfVtucXOiD0+UOXoYBJC?=
 =?us-ascii?Q?sCJqPThWZeMFU+AX55VQr4OHEA1/CIXnkQjwUV1tSxK4P5mj1H+/2e6mVrE3?=
 =?us-ascii?Q?AkJ2SdZiVIwrgOE5MfwPKYjoqBPQ/Qwta2eKmHLR46DDLFIXJW7D5TmwTpmT?=
 =?us-ascii?Q?s4kr+sCTAqgYlXeOACOmVuPAqXrkuuhDHJshR31d45mhcLFwrI78jdcdlePB?=
 =?us-ascii?Q?F8UCZjOwjSljlPJgWDjU33KCkhFHb+3IV7ZaapZepbSTDRvsxUYFthnX8jcP?=
 =?us-ascii?Q?ju4/zf41pvt+81mvSCcGyk2QwrHX07rj2T0hztm6GMNWjOJrqLLkyRkjZEsA?=
 =?us-ascii?Q?MVdWMKtblNKgfmVCdIQUVKPxakdQu6WW6d6nLWfeHENcLl0jYqsYAkyGP7LF?=
 =?us-ascii?Q?aBGDR4ZAmZF35YZagjDIFT0YkEfhYILaHv55qquGAibt4Jr8RokqpG8FtBFD?=
 =?us-ascii?Q?VzoeYFACbDCTCPokDBzZCc=3D?=
X-Microsoft-Antispam-Message-Info: ZKH5V0KwA60tQW0IqU3sZsUtRsDT9HBgp8QElrR+NAtBjyA1j6r6oG3aG5Lbcs2BE2VJNpIAL+6KklqovfINU1qoLWk4xbfLdZa6UWUvtKSEln3aVy4T9ZqQudxhN8hIhybcVJTU/HwivibkXLGFqrpImCZc/ix7HEKlsmWUv5bIzedoAZkqa8QvToXmIC83q4DWcPHx+Ln/gJ2hwn0p6CSma/q/PGpBT597bd27wE25S3Z9h3mA5E4BMlRpxih5tAm3DgeJC/FjNhbeEpIgUh6vcPmR69chpeVpuWBFpAf+E0QfNcmGcL+aUunjjm5E2FQTaI2JHsKi1D0abRWiQCK8Fr2bbNzcObZq/10R+AE=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;6:zb8OMRD5tHgVjpCXaRrJnG/dwN3JKHp16jNdc06rlYGOogL/x5cKo9nlbX+1y6qx1OGS3LP9nBS4ekwj3FuReL9KOWy2GSuy5gD+d7aBzSsOeqLh2Dbp4U4CBBpJACNLdns5volXHGwCsfZXvUvZ+4BeZ7qd1iPPNLRHNMcOb2JRg30VH25e5ZxKvdW4WX3tBviBifg3E796qivo1sa07k2lQudzUGi0Z4dZO85p58UjfKIDLgtwswKnxjWjmcaSc/RT+FRq0ruagBCpt3nPirh4SjD4Um2G/ryoXZgaa6mh84kezm+mbfaTXKXGSvwMz7p7VTnHCnr0XhC9moCIQY9rYmKaz7/g4thdo7YGo/r8sQzrNhTOhtqqt0sOUecCZQJpBr/GkSvYJxUb4/tzBen9jZLI8+N106LFnu8JwDNNYu/vRZZbZUKnusku1XJumOZ0S8bLbSChHm5JX8vixQ==;5:/nC9/2zDtJdEmIAMK0WwfuGLkJWRoRRYA78GCn/v4KNh9SzIZxWzWA85Il512jENGd2dna5sVHXj0GXYvQMm3dt138z0/8CZ9pL/EQ70bD2f6Hmo8v/ysEm96PzfrDP3qnn3w0gXU/aukHZlRPiIzlX4HcsjB6K/E6WJ6hVXAqQ=;7:KHRCygECByiNGpu87hYaNyL/MZGyYrOp46k6yYIV3bHIeCD+cDlm1N6oxwF3/ek79Er818ShaIZ9/g2MWLHIvybI90OR6h5sh+fyvz0mrzjTKs5iO84AlHIcTHkvxUzL+3eUR+rSN9D4olxpEZH2OmiqXPvJzuZTLf4lHJtI9X+wlHW8KX69VUXRyaDengfmOE/e7LlqMBbHXniWwxGzbaHcEjVIMvVlLdWxQlHth86YLZT1AN3ypwNPqhkmAv2y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 17:51:04.5427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7231cbf8-8926-4b33-7b29-08d5f3205bc2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On Thu, Jul 26, 2018 at 09:04:57AM +0200, Anders Roxell wrote:
> > Since commit eedf265aa003 ("devpts: Make each mount of devpts an
> > independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
> > in the defconfig anymore.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/mips/configs/ip27_defconfig    | 1 -
> >  arch/mips/configs/nlm_xlp_defconfig | 1 -
> >  arch/mips/configs/nlm_xlr_defconfig | 1 -
> >  3 files changed, 3 deletions(-)
> 
> Ping.

Apologies - this was forgotten because it stopped showing up as
requiring action in patchwork after Ralf marked it as accepted, but it
has never been applied to the shared mips-next branch.

I do question whether it's worthwhile making these one-line changes to
configs, because:

  1) The no presence of CONFIG_DEVPTS_MULTIPLE_INSTANCES is harmless
     anyway, it'll just be ignored.

  2) The configs in question will still not be up to date with a lot of
     other changes since they were added.

Together these 2 things lead me to think that we'd be better to either:

  a) Leave the defconfigs as-is, since the changes won't make them work
     any better or worse.

  b) Regenerate them entirely, such that they're up to date with not
     just this Kconfig change but all of them.

Thanks,
    Paul
