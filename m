Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D46D21F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Rfc2ZFXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D46D21F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbeGCUBI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:01:08 -0400
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:23298
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752964AbeGCT63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4twr546UGfe++OUH8PmphTZeVJ72+WiUire1aNDq20=;
 b=Rfc2ZFXABDz86Ma+DxoItrMvOhxjW4Xl65pA4H16EBAPEhZo4uHKex0QO4o7JikII4QlM7+mt+BsAkw0i5TIONyjAg31ks07I/eOpuaAvas2QFnHY751/T1NlzL9e/yIUVexwPHzi7Z3GXkyAYNtTf6aJMDP4kBq4TiatczVAx0=
Received: from SN1PR0701CA0068.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::36) by DM6PR07MB4716.namprd07.prod.outlook.com
 (2603:10b6:5:a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Tue, 3 Jul
 2018 19:58:26 +0000
Received: from DM3NAM05FT003.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by SN1PR0701CA0068.outlook.office365.com
 (2a01:111:e400:52fd::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:26 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT003.mail.protection.outlook.com (10.152.98.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMs4006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:23 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:38 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:38 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwLvA012182;
        Tue, 3 Jul 2018 20:58:21 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwLqk012176;
        Tue, 3 Jul 2018 20:58:21 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 06/15] Introduce Cadence USBSSP DRD Driver - added gadget-ep0 file.
Date:   Tue, 3 Jul 2018 20:57:50 +0100
Message-ID: <1530647879-10007-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(189003)(199004)(36092001)(26005)(14444005)(551934003)(186003)(51416003)(6666003)(4720700003)(5660300001)(26826003)(8676002)(68736007)(87636003)(478600001)(11346002)(446003)(336012)(426003)(69596002)(76176011)(50226002)(305945005)(48376002)(50466002)(356003)(47776003)(126002)(2906002)(106466001)(575784001)(86362001)(8936002)(2616005)(81156014)(81166006)(476003)(316002)(107886003)(97736004)(54906003)(110136005)(36756003)(53936002)(105596002)(16586007)(486006)(4326008)(42186006)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4716;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT003;1:RekRzky3I8KoHOVtR/kA//+hZpO4+lNnrKm407q3otlbRPdH75J7vdwLQwoPLgJxNbIm0+Suz+zDY95Y9s/KkcmphVwLYmx4GL8MWT/DU5ahObNuyQIqj8hZdMg5VnJo
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67051281-07c0-49e3-2e78-08d5e11f56f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;3:oCccfMTLblA1AFiQJu6BC8PK88AXimQMl8k8WOqPqc6buNvNzkwengQqOkKr1tmfCXw6EdyowWNXhc4yvWv1CcExFLp5E++N9ENMr3J2ec3pzbgYR9e/ODgHEdLaZq7innJ+8hRU25W3FX825Bwwjdy7xbgjIme3vFhs+WuT2t07L9e6mqckE/sE1pIJ63hiioo3Ug6kgJrxr9CIDYsTsH91ZU9gPC5bh9Yj56dkMo6rwU2SFLxGUBt6xyRhdWvl3l+KK1M+DN5CrSLdclpd9Kt/m3SFoUstNBHzYC2bk1Q/D5PFx9yO8TShB2xL3iWbgEpgpv4boTo4p+AWtzc0TA==;25:VrrxiiZn4bVCq5FmB7BFAgi5CCT2yphBbDoz3cssVKNQRzl93kqGsi3J3M4auwK7nEV3HxrGOcYV7o1jv6u9rurMrbRnwf///cM6rpp8H1lXxxQ2Hyy3uQy63B8eSE3dFEgBLRNY5UUcaGJuELiE2v420jDnGlQZatYDjHL4dSLO8azc49cuNyXyG6FlwPb7X6xsOWCQjmaoU3k08kKThZWG2kmKjbgNNs0AVemWr4+oCPnYSGoP7noKVpstKMKb2Y6hwICbujoyUUTwn78pkw4LLMtNJHuAUnl0A+QQJX+LoQt273qfEFVhGDAH2lkoe05w99MJqEgHNAQq2a6H5A==;31:Hhy3bLsB8byb1oTShlUKj2vmcLFIcpPrTxdqTK9pZLCDwnifWdxQMpi8djQnpRoO6T0Hjq49GwCSbcT65TtGEoxgHsn+koCZMG4MNY6IG0X1MFV/sQO+vpqcPhvyUmfyXBN+EPiUyftE2La1Ea8FWveyWpw4cr8GQwY0EhOpMSgCvKFbydWRK2znMFeKu1D1gqT1o7kfQ3syXS6CPJ15XNrP7NaYOvAKL34+LpSU0y0=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4716:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;20:E7Hl97WL9fs3YY8k5csSC5lSTVVL9ecGskXXJePjUmoSU+lojPYz5VpAhCFK9UXV6ZD7C21DuOtK6dVT/XSxvSQHVBPeTHQmmYBj/w2W9VsZ4OuFnyvrjOaPMVWAdTwD4jk4wKPZfvVrfoJxkY9Im49Uh7s0eUBm/R9PAbZUxQuQrGz766p2oBwdjZRmBlG5Nxg2RSr3TsGGSDV4txHXd+QvsowvgzukHeRYJxgOcHN/blKUyQhhql2ug8Db0+nLy3RAyjqXgutrPY+zbHlTF4ep9d9Ys1RUZ/lY57FE5cVAs1NJDpbP3V1M7Kg1ySoyIdPp4P5Pw215mL6OtQiBrqqZN91hoVYiTSCPjUYantB/A5GXI1pPATR3yvlc656Ncm1ewG4EU2o/k3fGNhPglBCas+ynUMYJzYbPnQVXjbXg+EguYGhwDSelyRfr9scnZOscibG96sAJLSTGLFEiUO5cMrLKiKSDYZoyW6pSB4fKbnSE6iLf6nnlNkAdTlCg;4:uEDtFfH9tcq0lq4WHH4WqK9vNPFQdun9XBhLHQaWBHIN2/ckX0M8Lg4H4XarMjdHz0KOZXJGW/8eGToNRc4sza3NBcCKVYRvtBaJiuGFz0rLHt9AfVU7T75MqaCm7dUpMdDJdYGs5sGnax8/8veBtXCV32nFuuDncc4qLYJXtFrwc3QBdn1/Uig+BP1AhXDKRVEQn09kFl1ovs7ysxh7uyFyZLwpBrYzTdnZoTLnnda2o8SOVNbvBY9+F0nNTWw8A9vhKqARPCQ0oYOkLdq6sWd/ZBgRmJNufLw6kFjD+R2pveb94Tnq10/ff8x7Od+O
X-Microsoft-Antispam-PRVS: <DM6PR07MB47161B1FC62A74428D2BC539DD420@DM6PR07MB4716.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93003095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4716;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4716;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4716;23:OtG0t6Z62kLE2egyx/iaOjeLPvlCJV7eMVT+ueDcj?=
 =?us-ascii?Q?TUFN4cuHEQtTHfvBeWBkXSWv3Ufm4zPApGH6Q+qu1G78PyYsLKvWv3/DA+Yc?=
 =?us-ascii?Q?e+B5YEvAVfDeKAUXC1X5+beZ+UpCUS/jRuxAo+5rU7M5AfjpEc/i2r30LRCi?=
 =?us-ascii?Q?oGZn/BqeMaG7mUl0lIW3UtSrgoIlf1qDCur7crXN2OSoDnanmsQ/cLOjcoPA?=
 =?us-ascii?Q?P0gk8uwGOJPrNRlFRiTT5qWBwmdrHqAeitNd9s2mDDq3uIEifo71A1wU2Sfy?=
 =?us-ascii?Q?fLhsoCo3sgtSp2IpUapPIeHwlGaYylb7lE7HkyW6388ljiAUPgWrTZm4Sxjw?=
 =?us-ascii?Q?dQhrUobjmatvkOiBbI7sbB94OR31ZeCNt1PQv00EUnwl9iddyvaKcXW/Rb0J?=
 =?us-ascii?Q?VvdIB2iMO63HVxCiTkC4J6QM5a/aFCXkfj/trcgVCg/eMy7ODVuVe1G5qoaH?=
 =?us-ascii?Q?ObdUaUoddRUoT9yhW4aIfD0q+/EImqNAJKOwiEdksNhbo5nkOVmzw+pu3BFX?=
 =?us-ascii?Q?8n43QIGCFddgPPVMvwj8cSyQBayk2h6IKovtT1qXbCpPwZSWFIWNh1Jlhpk3?=
 =?us-ascii?Q?RgrBLzo1Oaf2Y0hRdHL1VBqlmL+mOZneGeEeBzSaO7NEeFzceej0t0TBEgwb?=
 =?us-ascii?Q?gatrgIv/DeJCeZnIgBhH36v75uEmVvFUWgM8DG/z82m4kjyVoKFQGPwSV5Ek?=
 =?us-ascii?Q?L+B5+dAohCRU7LddKkdNIMSoLmPU/Bvf9ryqdw9Iju+ZlMY6MfwZlx+PSody?=
 =?us-ascii?Q?mBC2n/CJAnY6Q9TwZeAEfK9ST9yb8Onr5cmK68YzpSIai7lMd8bT17sfNHs/?=
 =?us-ascii?Q?Mobw+GophkJyH5UVhyxDBPt/DIpa77KsCCfHZNtYyAK4D1G9Nm4HuEGQj2WT?=
 =?us-ascii?Q?JtJqNdNXTb1DJGS5gMSfVYxzBDoPQleF0lseEJH7JWIukziw3mwc+D6U1YtG?=
 =?us-ascii?Q?dYbFu87IPM+GlymxwNjUZ08NnILBEJ+0+lrUNdYObqs/yGM3WcVYTLZXBgiT?=
 =?us-ascii?Q?yJdecfk41ulf51ARxcV+EH+M1oxG34K8xQp1dJJW4Vlvcj9XD5DwlF2qhCIu?=
 =?us-ascii?Q?3yHhRRfC8clLmpj2QUgOaiiKmVSXHX/ymbSJSj4LQZPKyCFTj+tFul6845nP?=
 =?us-ascii?Q?AjGG0pBWR7eT+6ZiFxK8Ve2n29Jrxl9EG2z2SULTbyt1xf4EsH0UAtOY1f1p?=
 =?us-ascii?Q?CX4ycohhExXs8wDsN3x9rBl7l8Vv/BN9xzT8ILapE3U6ONKM1KNM80Ha8Kfw?=
 =?us-ascii?Q?jcIXANcFAjW32U9/1SUc8rVeSrXnesaojjWI7PENtTjvBhhaytyG3LQlym46?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 0IpMUKOcp1q+eIj1C/oYFUbgcgTzV2tBqSHJypSqmtixgWWAxQYnDbG53U8nWPMm/MJk6BWqj/BqRWXGGP+L1cMpkqehR+ATM69TfR2PfZ8qiGrBB1T1KhPx+TNTTj0OT5wrHe2SZI9MQCmepUb9h2us4NVdzBM+MpdakrxhCaSCkikio66wn81+dM10DoXFwfVAfaWpPZiQqbiYloePpeTusrMj0nH3h87mY7Df3UIyDC3QIra8BBY4wTmq+TvLpwQvg40q8umZsumLBAFeRBh0qU3wbd8zrrMzpfdvkYp4Y82likQf+i7dEmtKWG02KnZoqFXe+4maiTES4YmacnBSF2HKs9IFyYUZq6IrT3UeLZGJfJbhbc3+HNyQSZ45e1HGCzsiieV28+eObK5PDg==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;6:NQulVynD5+mnybMgaUQBbYxSwsH9quy9XafixGOrmgrNIhK4Qs3tSA+TzwV3SzVCLpJAvMcpyB0TzFUIGz/mgOvUWGOkNgu/Xssv8Ys1S67QDTRc0Zrp9wji0L0p7awl2O9qErpPJWrd9H9/3ezE4a8CDvRx6pk+gUndkGzWNxKVGYTVjPuOqVrR6qHmcrzVu8ptQuLNc2+DQNdVxvg6pYxSdfl/4VHZjtdFNIAzj6ZFasoi8Gf4z0Gx2XxM49hxOw8QsttHCCud4EW9KqKs+OL4cirAzGXLoLfYeXFslku1AQsvHLAWAOhiHhyBEVx7pF8SqVjRwYfLt38XXLPxWYlM3JfwyJ2mpekaX6mSvgPtYfhxaqiQh73wVzkWxrazIocWKjWpERHXCZxSzrwBterdMdjorF03aHrzesy0VkaD0RPYGqoQxeAfmLrSvHagyyWddT/w1rs/Nbx1kw4+Zg==;5:OHzs06dW9s24pJG7XVPQmsxVxcuFKiQliRu7nE7vHypcA7G4ULZYmgP91BkR3aM+Sw/k0/wMD7hckT6lfhBBLd2trk3W9bw3ndxmTz21uO3KydD4zMShXqvnB3GWrgCGGBLrGPYnlL02e9LldjVXt0loJCSer6tFymgfVVKVcPs=;24:yOcVvwZUR5U71RhQ2FjUxBJtI5Q6svNeCOq3ivyP04gopuXVyJsV3pD5/7namKSxML0+C9EONBV0Wug7/dWrm8phgu04qr3RKNzFhUwC2uU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;7:se35MjtNAh3186JrYXALeSYOkPU6Q2/+ehCtmUhoSFyjS0ABHFki0lvOUMT0TtF7ORz1yQWVCzm3vqU0AIFwhLiXjaS71QXGaxEV4qGCSK+NYIDJJw8RDQh2ArKwWOMtoSW6EElOAc8zef8kl8BLFe960GQpR4CUuCQO+VxhTYAMmzNVFyLN2lMsNRH8MKmztZi+/KOX55cG8/ty4G5BpRq4s2BCoo01nVJNc4F1VTlr91y1HL/4jxGxDX/e+fBh;20:jtAn8haEaI6/uROEqu9MrgElc8sgR0vRa/Eeo2rkT8LcTzyE09gGm42MtXWw42bjR6uSYJE/ZK6+cnNNxwypmiR34on4d9BMt+xlLD/q7WVbvpOKkyVmBexGuD9m1baQ4wAe3bK7eRrh+ImQzQTHV+exHP3poodzsxLdnVOItBWUNUiVWg+qi39DTwLxx/zZVaHuflyznaPaqIClnOm+qYIHl8xH2RqTuhzNQHOvUZyWCPyWubn5quXomZ2JxQiS
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:25.9019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67051281-07c0-49e3-2e78-08d5e11f56f1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ep0.c | 565 ++++++++++++++++++++++++++++++++
 1 file changed, 565 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-ep0.c

diff --git a/drivers/usb/usbssp/gadget-ep0.c b/drivers/usb/usbssp/gadget-ep0.c
new file mode 100644
index 000000000000..8717dabbe496
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-ep0.c
@@ -0,0 +1,565 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * Some code borrowed from the Linux XHCI driver.
+ */
+
+#include <linux/list.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/composite.h>
+#include "gadget-trace.h"
+
+static void usbssp_ep0_stall(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_ep *dep;
+	int ret = 0;
+
+	dep = &usbssp_data->devs.eps[0];
+	if (usbssp_data->three_stage_setup) {
+		usbssp_dbg(usbssp_data, "Send STALL on Data Stage\n");
+		ret =  usbssp_halt_endpoint(usbssp_data, dep, true);
+
+		/*
+		 * Finishing SETUP transfer by removing request
+		 * from pending list
+		 */
+		if (!list_empty(&dep->pending_list)) {
+			struct usbssp_request	*req;
+
+			req = next_request(&dep->pending_list);
+			usbssp_giveback_request_in_irq(usbssp_data,
+					req->td, -ECONNRESET);
+			dep->ep_state = USBSSP_EP_ENABLED;
+		}
+	} else {
+		usbssp_dbg(usbssp_data, "Send STALL on Status Stage\n");
+		dep->ep_state |= EP0_HALTED_STATUS;
+		usbssp_status_stage(usbssp_data);
+	}
+	usbssp_data->delayed_status = false;
+}
+
+static int usbssp_ep0_delegate_req(struct usbssp_udc *usbssp_data,
+				   struct usb_ctrlrequest *ctrl)
+{
+	int ret;
+
+	usbssp_dbg(usbssp_data, "Delagate request to gadget driver\n");
+	spin_unlock(&usbssp_data->irq_thread_lock);
+
+	ret = usbssp_data->gadget_driver->setup(&usbssp_data->gadget, ctrl);
+	spin_lock(&usbssp_data->irq_thread_lock);
+
+	return ret;
+}
+
+static int usbssp_ep0_set_config(struct usbssp_udc *usbssp_data,
+				 struct usb_ctrlrequest *ctrl)
+{
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u32 cfg;
+	int ret;
+
+	cfg = le16_to_cpu(ctrl->wValue);
+	switch (state) {
+	case USB_STATE_DEFAULT:
+		usbssp_err(usbssp_data,
+			"Error: Set Config request from Default state\n");
+		return -EINVAL;
+	case USB_STATE_ADDRESS:
+		usbssp_dbg(usbssp_data,
+			"Set Configuration from addressed state\n");
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		/* if the cfg matches and the cfg is non zero */
+		if (cfg && (!ret || (ret == USB_GADGET_DELAYED_STATUS))) {
+			/*
+			 * only change state if set_config has already
+			 * been processed. If gadget driver returns
+			 * USB_GADGET_DELAYED_STATUS, we will wait
+			 * to change the state on the next usbssp_enqueue()
+			 */
+			if (ret == 0) {
+				usbssp_info(usbssp_data,
+					"Device has been configured\n");
+				usb_gadget_set_state(&usbssp_data->gadget,
+					USB_STATE_CONFIGURED);
+			}
+		}
+		break;
+	case USB_STATE_CONFIGURED:
+		usbssp_dbg(usbssp_data,
+			"Set Configuration from Configured state\n");
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		if (!cfg && !ret) {
+			usbssp_info(usbssp_data, "reconfigured device\n");
+			usb_gadget_set_state(&usbssp_data->gadget,
+					USB_STATE_ADDRESS);
+		}
+		break;
+	default:
+		usbssp_err(usbssp_data,
+			   "Set Configuration - incorrect device state\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int usbssp_ep0_set_address(struct usbssp_udc *usbssp_data,
+				  struct usb_ctrlrequest *ctrl)
+{
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u32 addr;
+	unsigned int slot_state;
+	struct usbssp_slot_ctx *slot_ctx;
+	int dev_state = 0;
+
+	addr = le16_to_cpu(ctrl->wValue);
+	if (addr > 127) {
+		usbssp_err(usbssp_data, "invalid device address %d\n", addr);
+		return -EINVAL;
+	}
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, usbssp_data->devs.out_ctx);
+	dev_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	if (state == USB_STATE_CONFIGURED) {
+		usbssp_err(usbssp_data,
+				"can't SetAddress() from Configured State\n");
+		return -EINVAL;
+	}
+
+	usbssp_data->device_address = le16_to_cpu(ctrl->wValue);
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, usbssp_data->devs.out_ctx);
+	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	if (slot_state == SLOT_STATE_ADDRESSED) {
+		/*Reset Device Command*/
+		usbssp_data->defered_event &= ~EVENT_USB_RESET;
+		queue_work(usbssp_data->bottom_irq_wq,
+			&usbssp_data->bottom_irq);
+		usbssp_reset_device(usbssp_data);
+	}
+	/*set device address*/
+	usbssp_address_device(usbssp_data);
+
+	if (addr)
+		usb_gadget_set_state(&usbssp_data->gadget, USB_STATE_ADDRESS);
+	else
+		usb_gadget_set_state(&usbssp_data->gadget, USB_STATE_DEFAULT);
+	return 0;
+}
+
+int usbssp_status_stage(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_ring *ep_ring;
+	int ret;
+	struct usbssp_ep *dep;
+
+	dep = &usbssp_data->devs.eps[0];
+	ep_ring = usbssp_data->devs.eps[0].ring;
+
+	usbssp_dbg(usbssp_data, "Enqueue Status Stage\n");
+	usbssp_data->ep0state = USBSSP_EP0_STATUS_PHASE;
+	usbssp_data->usb_req_ep0_in.request.length = 0;
+	ret = usbssp_enqueue(usbssp_data->usb_req_ep0_in.dep,
+			&usbssp_data->usb_req_ep0_in);
+	return ret;
+}
+
+
+static int usbssp_ep0_handle_feature_u1(struct usbssp_udc *usbssp_data,
+					enum usb_device_state state, int set)
+{
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (state != USB_STATE_CONFIGURED)
+		usbssp_err(usbssp_data,
+			"Error: can't change U1 - incorrect device state\n");
+		return -EINVAL;
+
+	if ((usbssp_data->gadget.speed  != USB_SPEED_SUPER) &&
+	    (usbssp_data->gadget.speed  != USB_SPEED_SUPER_PLUS))
+		usbssp_err(usbssp_data,
+			"Error: U1 is supported only for SS and SSP\n");
+		return -EINVAL;
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+
+	temp = readl(port_regs+PORTPMSC);
+	temp &= ~PORT_U1_TIMEOUT_MASK;
+
+	if (set)
+		temp |= PORT_U1_TIMEOUT(1);
+	else
+		temp |= PORT_U1_TIMEOUT(0);
+
+	usbssp_info(usbssp_data, "U1 %s\n", set ? "enabled" : "disabled");
+	writel(temp, port_regs+PORTPMSC);
+
+	usbssp_status_stage(usbssp_data);
+	return 0;
+}
+
+static int usbssp_ep0_handle_feature_u2(struct usbssp_udc *usbssp_data,
+					enum usb_device_state state, int set)
+{
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (state != USB_STATE_CONFIGURED) {
+		usbssp_err(usbssp_data,
+			   "Error: can't change U2 - incorrect device state\n");
+		return -EINVAL;
+	}
+	if ((usbssp_data->gadget.speed  != USB_SPEED_SUPER) &&
+	    (usbssp_data->gadget.speed  != USB_SPEED_SUPER_PLUS)) {
+		usbssp_err(usbssp_data,
+			   "Error: U2 is supported only for SS and SSP\n");
+		return -EINVAL;
+	}
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(port_regs+PORTPMSC);
+	temp &= ~PORT_U1_TIMEOUT_MASK;
+
+	if (set)
+		temp |= PORT_U2_TIMEOUT(1);
+	else
+		temp |= PORT_U2_TIMEOUT(0);
+
+	writel(temp, port_regs+PORTPMSC);
+	usbssp_info(usbssp_data, "U2 %s\n", set ? "enabled" : "disabled");
+
+	usbssp_status_stage(usbssp_data);
+	return 0;
+}
+
+static int usbssp_ep0_handle_feature_test(struct usbssp_udc *usbssp_data,
+					  enum usb_device_state state,
+					  u32 wIndex, int set)
+{
+	int test_mode;
+	__le32 __iomem *port_regs;
+	u32 temp;
+	unsigned long flags;
+	int retval;
+
+	if (usbssp_data->port_major_revision == 0x03)
+		return -EINVAL;
+
+	usbssp_info(usbssp_data, "Test mode; %d\n", wIndex);
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+
+
+	test_mode = (wIndex & 0xff00) >> 8;
+
+	temp = readl(port_regs);
+	temp = usbssp_port_state_to_neutral(temp);
+
+	if (test_mode > TEST_FORCE_EN || test_mode < TEST_J) {
+		/* "stall" on error */
+		retval = -EPIPE;
+	}
+
+	usbssp_status_stage(usbssp_data);
+	retval = usbssp_enter_test_mode(usbssp_data, test_mode, &flags);
+	usbssp_exit_test_mode(usbssp_data);
+
+	return 0;
+}
+
+static int usbssp_ep0_handle_feature_device(struct usbssp_udc *usbssp_data,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	enum usb_device_state state;
+	u32 wValue;
+	u32 wIndex;
+	int ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	state = usbssp_data->gadget.state;
+
+	switch (wValue) {
+	case USB_DEVICE_REMOTE_WAKEUP:
+		usbssp_data->remote_wakeup_allowed = (set) ? 1 : 0;
+		break;
+	/*
+	 * 9.4.1 says only only for SS, in AddressState only for
+	 * default control pipe
+	 */
+	case USB_DEVICE_U1_ENABLE:
+		ret = usbssp_ep0_handle_feature_u1(usbssp_data, state, set);
+		break;
+	case USB_DEVICE_U2_ENABLE:
+		ret = usbssp_ep0_handle_feature_u2(usbssp_data, state, set);
+		break;
+	case USB_DEVICE_LTM_ENABLE:
+		ret = -EINVAL;
+		break;
+	case USB_DEVICE_TEST_MODE:
+		ret = usbssp_ep0_handle_feature_test(usbssp_data, state,
+				wIndex, set);
+		break;
+	default:
+		usbssp_err(usbssp_data, "%s Feature Request not supported\n",
+				(set) ? "Set" : "Clear");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_handle_feature_intf(struct usbssp_udc *usbssp_data,
+					  struct usb_ctrlrequest *ctrl,
+					  int set)
+{
+	u32 wValue;
+	int ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+
+	switch (wValue) {
+	case USB_INTRF_FUNC_SUSPEND:
+		/*TODO: suspend device */
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_handle_feature_endpoint(struct usbssp_udc *usbssp_data,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	struct usbssp_ep *dep;
+	u32 wValue, wIndex;
+	unsigned int ep_index = 0;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_td *td;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	ep_index = ((wIndex & USB_ENDPOINT_NUMBER_MASK) << 1);
+
+	if ((wIndex & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT)
+		ep_index -= 1;
+
+	dep =  &usbssp_data->devs.eps[ep_index];
+	ep_ring = dep->ring;
+
+	switch (wValue) {
+	case USB_ENDPOINT_HALT:
+		if (set == 0 && (dep->ep_state & USBSSP_EP_WEDGE))
+			break;
+
+		usbssp_halt_endpoint(usbssp_data, dep,  set);
+
+		td = list_first_entry(&ep_ring->td_list, struct usbssp_td,
+				td_list);
+
+		usbssp_cleanup_halted_endpoint(usbssp_data, ep_index,
+				ep_ring->stream_id, td,
+				EP_HARD_RESET);
+		break;
+	default:
+		usbssp_warn(usbssp_data, "WARN Incorrect wValue %04x\n",
+				wValue);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int usbssp_ep0_handle_feature(struct usbssp_udc *usbssp_data,
+		struct usb_ctrlrequest *ctrl, int set)
+{
+	u32 recip;
+	int ret;
+
+	recip = ctrl->bRequestType & USB_RECIP_MASK;
+
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+		ret = usbssp_ep0_handle_feature_device(usbssp_data, ctrl, set);
+		break;
+	case USB_RECIP_INTERFACE:
+		ret = usbssp_ep0_handle_feature_intf(usbssp_data, ctrl, set);
+		break;
+	case USB_RECIP_ENDPOINT:
+		ret = usbssp_ep0_handle_feature_endpoint(usbssp_data,
+				ctrl, set);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_set_sel(struct usbssp_udc *usbssp_data,
+			      struct usb_ctrlrequest *ctrl)
+{
+	struct usbssp_ep *dep;
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u16 wLength;
+	int ret = 0;
+
+	if (state == USB_STATE_DEFAULT)
+		return -EINVAL;
+
+	wLength = le16_to_cpu(ctrl->wLength);
+
+	if (wLength != 6) {
+		usbssp_err(usbssp_data, "Set SEL should be 6 bytes, got %d\n",
+				wLength);
+		return -EINVAL;
+	}
+
+	/*
+	 * To handle Set SEL we need to receive 6 bytes from Host. So let's
+	 * queue a usb_request for 6 bytes.
+	 */
+	dep = &usbssp_data->devs.eps[0];
+
+	usbssp_data->usb_req_ep0_in.request.length = 0x6;
+	usbssp_data->usb_req_ep0_in.request.buf = usbssp_data->setup_buf;
+
+	ret = usbssp_enqueue(usbssp_data->usb_req_ep0_in.dep,
+			&usbssp_data->usb_req_ep0_in);
+	if (ret) {
+		usbssp_err(usbssp_data, "Error in  Set Sel\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int usbssp_ep0_std_request(struct usbssp_udc *usbssp_data,
+				  struct usb_ctrlrequest *ctrl)
+{
+	int ret = 0;
+
+	usbssp_data->bos_event_detected = 0;
+
+	switch (ctrl->bRequest) {
+	case USB_REQ_GET_STATUS:
+		usbssp_info(usbssp_data, "Request GET_STATUS\n");
+		/*TODO:*/
+		//ret = usbssp_ep0_handle_status(usbssp_data, ctrl);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+		usbssp_info(usbssp_data, "Request CLEAR_FEATURE\n");
+		ret = usbssp_ep0_handle_feature(usbssp_data, ctrl, 0);
+		break;
+	case USB_REQ_SET_FEATURE:
+		usbssp_info(usbssp_data, "Request SET_FEATURE\n");
+		ret = usbssp_ep0_handle_feature(usbssp_data, ctrl, 1);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		usbssp_info(usbssp_data, "Request SET_ADDRESS\n");
+		ret = usbssp_ep0_set_address(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		usbssp_info(usbssp_data, "Request SET_CONFIGURATION\n");
+		ret = usbssp_ep0_set_config(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_SEL:
+		usbssp_info(usbssp_data, "Request SET_SEL\n");
+		ret = usbssp_ep0_set_sel(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_ISOCH_DELAY:
+		usbssp_info(usbssp_data, "Request SET_ISOCH_DELAY\n");
+		/*TODO:*/
+		//ret = usbssp_ep0_set_isoch_delay(usbssp_data, ctrl);
+		break;
+	default:
+		if ((le16_to_cpu(ctrl->wValue) >> 8) == USB_DT_BOS &&
+		    ctrl->bRequest == USB_REQ_GET_DESCRIPTOR) {
+			/*
+			 * It will be handled after Status Stage phase
+			 * in usbssp_gadget_giveback
+			 */
+			usbssp_data->bos_event_detected = true;
+		}
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		break;
+	}
+	return ret;
+}
+
+int usbssp_setup_analyze(struct usbssp_udc *usbssp_data)
+{
+	int ret = -EINVAL;
+	struct usb_ctrlrequest *ctrl = &usbssp_data->setup;
+	u32 len = 0;
+	struct usbssp_device *priv_dev;
+
+	ctrl = &usbssp_data->setup;
+
+	usbssp_info(usbssp_data,
+			"SETUP BRT: %02x BR: %02x V: %04x I: %04x L: %04x\n",
+			ctrl->bRequestType, ctrl->bRequest,
+			le16_to_cpu(ctrl->wValue), le16_to_cpu(ctrl->wIndex),
+			le16_to_cpu(ctrl->wLength));
+
+	if (!usbssp_data->gadget_driver)
+		goto out;
+
+	priv_dev = &usbssp_data->devs;
+
+	/*
+	 * First of all, if endpoint 0 was halted driver has to
+	 * recovery it.
+	 */
+	if (priv_dev->eps[0].ep_state & EP_HALTED) {
+		usbssp_dbg(usbssp_data,
+			"Ep0 Halted - restoring to nomral state\n");
+		usbssp_halt_endpoint(usbssp_data, &priv_dev->eps[0], 0);
+	}
+
+	/*
+	 * Finishing previous SETUP transfer by removing request from
+	 * list and informing upper layer
+	 */
+	if (!list_empty(&priv_dev->eps[0].pending_list)) {
+		struct usbssp_request	*req;
+
+		usbssp_dbg(usbssp_data,
+				"Deleting previous Setup transaction\n");
+		req = next_request(&priv_dev->eps[0].pending_list);
+		usbssp_dequeue(&priv_dev->eps[0], req);
+	}
+
+	len = le16_to_cpu(ctrl->wLength);
+	if (!len) {
+		usbssp_data->three_stage_setup = false;
+		usbssp_data->ep0_expect_in = false;
+	} else {
+		usbssp_data->three_stage_setup = true;
+		usbssp_data->ep0_expect_in =
+				!!(ctrl->bRequestType & USB_DIR_IN);
+	}
+
+	if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
+		ret = usbssp_ep0_std_request(usbssp_data, ctrl);
+	else
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+
+	if (ret == USB_GADGET_DELAYED_STATUS) {
+		usbssp_dbg(usbssp_data, "Status Stage delayed\n");
+		usbssp_data->delayed_status = true;
+	}
+
+out:
+	if (ret < 0)
+		usbssp_ep0_stall(usbssp_data);
+
+	return ret;
+}
-- 
2.17.1

