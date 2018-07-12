Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A2C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6744520875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="OvtJigev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6744520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeGLF4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:02 -0400
Received: from mail-eopbgr720056.outbound.protection.outlook.com ([40.107.72.56]:28859
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbeGLF4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRUMwVl76Dz5iHBFYIvaowMUkKu2wk9gksZ5/v1taRw=;
 b=OvtJigevSilrkyWhZ/Cb4puPbXQOxvQRSzounurd/UmaJNPqDspSMTR9XxkxWcx1WJ5E45J8NVhUvL9qGlw97NKFmrhaQKpCRAiNxx/8JLnKBes1KuhBwGZturuXhuh+snQ+/wx+bgkXJNX3olcTeb1VfGmgbpTGL31JqijrWFc=
Received: from BYAPR07CA0010.namprd07.prod.outlook.com (2603:10b6:a02:bc::23)
 by BN3PR0701MB1329.namprd07.prod.outlook.com (2a01:111:e400:4019::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Thu, 12 Jul
 2018 05:48:00 +0000
Received: from DM3NAM05FT015.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by BYAPR07CA0010.outlook.office365.com
 (2603:10b6:a02:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:00 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT015.mail.protection.outlook.com (10.152.98.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw9032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:06 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:06 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5loNM029728;
        Thu, 12 Jul 2018 06:47:50 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lnET029708;
        Thu, 12 Jul 2018 06:47:49 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 16/31] usb: usbssp: added connect/disconnect procedures.
Date:   Thu, 12 Jul 2018 06:47:13 +0100
Message-ID: <1531374448-26532-17-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(36092001)(6666003)(8936002)(486006)(336012)(126002)(48376002)(47776003)(186003)(50466002)(575784001)(426003)(86362001)(446003)(42186006)(50226002)(316002)(4720700003)(476003)(11346002)(1671002)(16586007)(26005)(14444005)(54906003)(2616005)(2906002)(76176011)(36756003)(105596002)(478600001)(109986005)(8676002)(4326008)(107886003)(106466001)(51416003)(26826003)(5024004)(356003)(5660300001)(7636002)(305945005)(87636003)(246002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1329;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT015;1:TMHPpNzCiCmE/ph/Y4fyMT7C/j3ZHmuoQUAOXQ/0wFKUKMtg00Hmmpglb1y999yR+kqb4kla81fjyNocCjtm9Ffs1R0XwLdIlGCoKr+RxQ5U111UEVvJvU5ZZZbdDTfE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7bc0296-4f90-4587-a877-08d5e7bb0693
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN3PR0701MB1329;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1329;3:/GhReM5U7dKPuM6/sbreQk4RqpHiRZlnRKgbriWG8G2bJD9dX8HyEEoSDE1Wf2nUz3xiWPUtVAOTHfZJrqS4WI2R73W4d0Nx2+jM7Kus9tZIuoyVBF2S1cMwI9xKv0UhO/1cVnNiYQxHHanfK/oHgw/jgVlrCHg6Np7T/yMVBmfLLH+RYdEMi9iRsvG7uTvAR6uqBAU+pyPzaW+ZSWDBdqqAlSUwWVUBCPggwlx1MfXye83OjbxO+ow7czogTjqU9d9o2ptNZ4VnGs9R7+tRXEji7F/CuSb+soZPhQbQNIJyDsO8iGHkQsjAHtP1aJM7UzbpsHmjRh7OVuBJJPSNRdKFH88neivSkt9/8qTy4Ng=;25:p0wJm+OYSnTKpUT95Y3O5+ub1Wjb0jznALFKP4vhF9F2eUzb1sh/vOIlNvuAPCSNdscCXb+L4e+82ubBbyLZo8xMjEAMUzEUDfEiesakNUcs/TFfxvNz22StWRN/WXhCo/k7pkpz1Txv7P/TmU3w/+GG6fTqt6oYcdhr9KtLkCgn+ZeZ//PKEjIqroXhZxXimRG99Rg+Vybzibsz0Zw2ER6AoLoPDetkGUB4fPzoe7d135M1cJnOqUO+Dym6DKXcyrxOGaud2Y3Qqayz9+ihOnCOLt9d20W44Q4k6vijrGEi3MipVyvhzg1VRlLURV4tKLLh4WlQ+qTe/CcA3G1kBA==
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1329:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1329;31:+Dgs+t2YsADror0+u4V9IazvYaUnhwf5nvzzN0NipdeQg2mAkQH5Nx/23W6itkmOwidXc3FwAnsdlwZC4KIPdwN4IlGGf5ZX69kxCzAtQUzjrNErTBymt5dwCruU4RGtJ5oXSHjn2a0sKPU7BH6NUVcDfHRbba0LGhCzGrQ5Q07ZNkkmTQSVdlcQ/G0mzag3IBFBhGRMwvNe7HdUByVAN08m7XILapMBp6z6iXHbDf8=;20:vQ8USms5CvKeK74Bv9M47jy8050A3GcvI+TaVrrsO2+fMwds+oSRYtWZBxtQNmEUPWZ+RcINO8NBt589hxBlTt7oxVUMV6t07cdT+WEkpib1Yt3e+XFuHKTJ365ToSrVkwR6KCDsEtI+GsJFshqXKswlsZHRgnde9V5rTNsqltMGQHr9DsR/cuvX6LuX3Jlb36fL5PvMu6mKcuNf31UIvJhoM/+9zwYf9W36NXjbGNXOaUMuaoFQNlmImgjQIr8v9L5BPRgQPZxQ89lsls6S/8rF1GQXsM4OBHCozSnze6nCL1xf31L7/jpYH9zIB2CNWq/BbIliu6vId3dzvoUmzqxa2uz9fwbwgi2FBFzMVRqT+q6gBWYvwFUW8/0b6HGhj03BeMNYXiMPsKpdoZigpbc/0G9cQBn0O2v2JI8WkytRWadIIiV8Oyv2DmaQYMmeD7lnmlLh8OFznlX8MKEtq5VVKk0iUBUPFqIs1cKaCIQzBk6FRR29MXyHuzwaAm2o
X-Microsoft-Antispam-PRVS: <BN3PR0701MB13293F804AC1389C7C7085BEDD590@BN3PR0701MB1329.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN3PR0701MB1329;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1329;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1329;4:ocTCPKgYLUMubvlZ7AJkF93ae7EABQpuxHuE4H6gTUPyuZkROUj+n57MIaOltO9Mx8Wy8JFpiw31UTowLzUBO2ZNc8sdPc8PFMWhPrMKRMjD/a39ZbmvzjnS7ieOFTVx+hrLYTtSTlXW1l/u+8t23OWAGHKs389kr4zXorkgojc3dOba3LiciS2U1EZQWSqhS9YPXHc8FCB9GkqmXpah1PgAK2KZ/oyZyJaFD/fuLqsna2+MOCcDqoA8BlQky306UcBlg4aTAAtKtCI4OQTZRdswRKz5AAslOhdL9VZQW25CW6l6kcOqPlKvzB4YeMH5HeLpd8njUmAFf2pldMIBjCeWoRBeNR4BWXntnmuOTsw=
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1329;23:3VJdzQ6skDUgZjrcZWIV88jFum0h8qN1lDzXBcH?=
 =?us-ascii?Q?zQcwi2VeX/vfDgOPT141GvK9thfjLvCv0/6OQNZV3u9TX8ctE1KjBECHQgYm?=
 =?us-ascii?Q?aA2R1yC0Nsht4U2BcQ0TFpX7oEikpZpq3cR0Fek+UmlJT6v9b/8M2OCrfBcT?=
 =?us-ascii?Q?pYSQAe6qngHgklU6nGHAOeM/RhuKkG7f+yu05nuI4urFdFVqv3UcTx0CYVQ5?=
 =?us-ascii?Q?17B0RLvl4QtKpn05vBEfRbmyBJlGu9eFz3Fu1qFHcmDBynfp+JmMghXkGCjw?=
 =?us-ascii?Q?VUqCKBMA+Uh0/4OL3txoqW62xbNg7fQ1BHBmBWOtASye8B1DmWDfQW8J5z+8?=
 =?us-ascii?Q?V8Lx2tqxLjLpQbWvSircUiNlbfSODHiw6WpytjLDWXFsR3yBJF+9gCdIXVWJ?=
 =?us-ascii?Q?zVCGlVtJ6I8qhE+0fUH2PE1mkw7B3AMNVp6XN9/J399ssgzQJOT5C3V+6FZq?=
 =?us-ascii?Q?kt72ilFQU+jIOmD2MBQPE+t75ie64erAUUUGItPBn0Bzhkh+6Ws+RjCTk/QO?=
 =?us-ascii?Q?STwmrHVwk2E2VM4DB1Wz6Q3CRQQqZSLLIN4cWmQhByHhpUnAmwMP6xBM1+7A?=
 =?us-ascii?Q?T+1RPUWB1wJJrJq9Oj7UDv5me8v8huDHs/IW6c+tkh/GH8YNNpcxW4nkD5T3?=
 =?us-ascii?Q?pD4+dkrORnVC6X7vibBL5Xd8X3z4rnxfa5xPesvVBBG73IbaxMhPI4yKo50r?=
 =?us-ascii?Q?tA92SQcoh4TfL5F8foHu8lBu1z625521A9mZsOKvbZfbbwEaztddw17aTNBk?=
 =?us-ascii?Q?rfloda5LUJR23/zwaHPnGOl2LRWLC5dcQBXCkhF7R5KEz1S15FEdPVq24XY8?=
 =?us-ascii?Q?ffMgqsi86/ka0Eclo9+8sH/8jj85sc5Vi+az0aRusfzN6kciok8s7LZ7tr4i?=
 =?us-ascii?Q?mKw/rcwIpP2zozHmpQJTSQGqf9zoMJFULjevAxQIb/mUOSVhy0FblTW+lKtP?=
 =?us-ascii?Q?Acp95PXSBvRYHQ5s3e5/VvWGBz2UyMT87PcXVMVeOJEBTwCrlAs7jw4Hxnlf?=
 =?us-ascii?Q?xHH55FX5qilRSsGHFLF1fs8Q2l7eg3FavX9B3wM/EAUauWj6cgKJWOfiBgLC?=
 =?us-ascii?Q?sPWEX7eBu8fGXfjNQMLDUKB94B+b4B0V3p//wNwkaVhu5J81ak1lJ4/vl+jV?=
 =?us-ascii?Q?NNSNPGMb6CdyVSqoK2PXYpD7hJtrCMF+NuvCR0RLPHesMoZ9T85pLotyi0ZF?=
 =?us-ascii?Q?2HeXeKXVE5XrOt4hQvR0/B30s0l3wLUmmkaXI?=
X-Microsoft-Antispam-Message-Info: usfrKkSItEvcuZUbsDpWgc3KfYsl31s0C2waev9d8pYaqd3FJ+xpU9WTJ1pXCdv1dgLLDiUg+q7QS/RvO0kV1zatIXmfxJMnfB4/13tdBiY/aaw4aa7lDvmbriGGiGl4xON449YC7rha5JlbwyRUXenYMvPrLDXNAaaLojA7NFiBFYT9Lcw/sdvWmyT4XRiRjmYGwnpAu3lCRF7q6MFA7zzjEGt8P0TCJLa5i6HynVzLTo79XsVTHjnDFhTzaCFh2BjwCjrLBBlX3AjyX47Rnfbg2IbBFWfAiF0ucITwcTgqpkzL1eUZRVQENFY7GC25Mjhzom2Id9v0sAbcK9bayshu8kd9xrIWkhniXuDt5nJoZwdy/RPoTtaLlNoFzSEUJu0hP/esTyfzuanwtM4Vfg==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1329;6:Y5HRy7Jfi4KYtOCZQAHJo5li+7vRKwLvKoLqOKWJWMduq7UYfqiAabUU+fkFEPSIuLkrVTX4/sroo1jM05sOURUKYRKR9Yemu5GaWvaAaYIV2j+8LIyDAY4+Aq2O2sqD6O/5fyU5WbEmhaMf/Zyg/HkhGkPGEhzrokplZKAFm7M0CwUlntUr6tESroBJG2/iZUV/YN8xcX8Ol5aKhh689qYYDm8pRamQTrx4OFJYqODmMIF0NRhFnzUHRcZh65Xk7aXbh1//r2G05uXJImUqBHXMp1GfJxlmDM6mP4uNAlibX7iqYUeatVbUKZZlwJd1Rn5eSJvoPzi8mrs65Ln80SrDuKIyQS9sS8xvPS5sJbZK6EaC4AZxBcllKLIqeQbQfiY8VFnSbooCTulYmKpzWvzvaR7fSlwj2m/HV0Qt1KQrYTQUuAMY/6ebQLH53uHr8MJogvyLKvP5ZyvhaidSOw==;5:L0rNU5bPS2YSIHorT5hCB+w2CxB6S6KPC1k/oN2SccT4+/p44sFH7SeyE2gLFKxfYvHnAPGEogtWejoWgwZBtDzMBj+HBTby3FXGy2lHv3P896b0f/5yjuFKa60JSdm1cRoBFKWleWoWuh8yXOzr1eDW/DRiKtg0XJaXIWAGykU=;24:PIHInD6B1u0U0RM1FMaiJZ0juUg2rDI3Aq7EznArnVgWVs6bPz3FuXLi0AsuRWpccn8wtBMGcVmHh8oV8xKqj7JO4N12PvXrFABEzR+B16I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1329;7:18FfIj0YyGYudGzRrx/VJkJ+ZB5V20TDIWb5N6LHVV/5RUpDvyKZyiMvnDknxoBNUIaAgThXSRWMLvHZDDKl67HnrDqsFWYjx6rIp36+B4SAtzirULVQ25DgoG8DilRIwoITQPv1X6iLFjB9P902oxnD25wKAdgFPEc3T+aPllqyUP7QpIrm+95nTbDID2sieKMN29HHL09W3erF02gMFrEByE0haC1kri649AU1ryFFFHhKWX+NY+/rC/J6NZOZ;20:u0+dwxE82DhR/ef6WyfW9cqV34nc1ELMQ01xLtrWmKr9Pq/f5Q7B3n+AwD0b0oYBJOVsdpf3V2y3UNEKHagVc4ujyz+sZuCHP/1ygM0no45gjz2gzwYZezBu/40t+R6Zyb8XspPXpAhueK15lL3o0J9S097g3COJsVn371q6vy6j57mk104GDUsgvoXYROf6yg9mFj/hNW+ygTOFcj+zgRQROlhrAhc+rnBnzYD86B9luMH3Za7H9lP81HChBoKa
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:59.5377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bc0296-4f90-4587-a877-08d5e7bb0693
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1329
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds functionality responsible for handling CONNECT/DISCONNECT
event. This event will be reported after attached/detached USB
device to/from USB port.

To complete this procedure usbssp_halt_endpoint function must to be
implemented. This will be added in next patch.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c   |  16 +++
 drivers/usb/usbssp/gadget-mem.c  |  74 +++++++++++++
 drivers/usb/usbssp/gadget-port.c |  92 ++++++++++++++++
 drivers/usb/usbssp/gadget-ring.c |  12 ++
 drivers/usb/usbssp/gadget.c      | 182 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |  17 +++
 6 files changed, 391 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index 28118c1a0250..9c236fc1149f 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -287,6 +287,16 @@ void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
 	}
 }
 
+static void usbssp_disconnect_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver &&
+	    usbssp_data->gadget_driver->disconnect) {
+		spin_unlock(&usbssp_data->irq_thread_lock);
+		usbssp_data->gadget_driver->disconnect(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->irq_thread_lock);
+	}
+}
+
 void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data)
 {
 	if (usbssp_data->gadget_driver && usbssp_data->gadget_driver->suspend) {
@@ -317,6 +327,12 @@ static void usbssp_reset_gadget(struct usbssp_udc *usbssp_data)
 		spin_lock(&usbssp_data->lock);
 	}
 }
+
+void usbssp_gadget_disconnect_interrupt(struct usbssp_udc *usbssp_data)
+{
+	usbssp_disconnect_gadget(usbssp_data);
+}
+
 void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data)
 {
 	usbssp_reset_gadget(usbssp_data);
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 3e39db25f9ef..fd3c0557feef 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -645,6 +645,71 @@ void usbssp_free_priv_device(struct usbssp_udc *usbssp_data)
 
 	usbssp_data->slot_id = 0;
 }
+
+int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags)
+{
+	struct usbssp_device *priv_dev;
+
+	/* Slot ID 0 is reserved */
+	if (usbssp_data->slot_id == 0) {
+		usbssp_warn(usbssp_data, "Bad Slot ID %d\n",
+				usbssp_data->slot_id);
+		return 0;
+	}
+
+	priv_dev = &usbssp_data->devs;
+
+	/* Allocate the (output) device context that will be
+	 * used in the USBSSP.
+	 */
+	priv_dev->out_ctx = usbssp_alloc_container_ctx(usbssp_data,
+			USBSSP_CTX_TYPE_DEVICE, flags);
+
+	if (!priv_dev->out_ctx)
+		goto fail;
+
+	usbssp_dbg(usbssp_data, "Slot %d output ctx = 0x%llx (dma)\n",
+			usbssp_data->slot_id,
+			(unsigned long long)priv_dev->out_ctx->dma);
+
+	/* Allocate the (input) device context for address device command */
+	priv_dev->in_ctx = usbssp_alloc_container_ctx(usbssp_data,
+			USBSSP_CTX_TYPE_INPUT, flags);
+
+	if (!priv_dev->in_ctx)
+		goto fail;
+
+	usbssp_dbg(usbssp_data, "Slot %d input ctx = 0x%llx (dma)\n",
+			usbssp_data->slot_id,
+			(unsigned long long)priv_dev->in_ctx->dma);
+
+	/* Allocate endpoint 0 ring */
+	priv_dev->eps[0].ring = usbssp_ring_alloc(usbssp_data, 2, 1,
+			TYPE_CTRL, 0, flags);
+	if (!priv_dev->eps[0].ring)
+		goto fail;
+
+	priv_dev->gadget = &usbssp_data->gadget;
+
+	/* Point to output device context in dcbaa. */
+	usbssp_data->dcbaa->dev_context_ptrs[usbssp_data->slot_id] =
+		cpu_to_le64(priv_dev->out_ctx->dma);
+	usbssp_dbg(usbssp_data, "Set slot id %d dcbaa entry %p to 0x%llx\n",
+		usbssp_data->slot_id,
+		&usbssp_data->dcbaa->dev_context_ptrs[usbssp_data->slot_id],
+		le64_to_cpu(usbssp_data->dcbaa->dev_context_ptrs[usbssp_data->slot_id]));
+
+	trace_usbssp_alloc_priv_device(priv_dev);
+	return 1;
+fail:
+	if (priv_dev->in_ctx)
+		usbssp_free_container_ctx(usbssp_data, priv_dev->in_ctx);
+	if (priv_dev->out_ctx)
+		usbssp_free_container_ctx(usbssp_data, priv_dev->out_ctx);
+
+	return 0;
+}
+
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
@@ -756,6 +821,7 @@ void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data)
 
 	cancel_delayed_work_sync(&usbssp_data->cmd_timer);
 	cancel_work_sync(&usbssp_data->bottom_irq);
+	destroy_workqueue(usbssp_data->bottom_irq_wq);
 
 	/* Free the Event Ring Segment Table and the actual Event Ring */
 	usbssp_free_erst(usbssp_data, &usbssp_data->erst);
@@ -1260,6 +1326,14 @@ int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags)
 			usbssp_handle_command_timeout);
 	init_completion(&usbssp_data->cmd_ring_stop_completion);
 
+	usbssp_data->bottom_irq_wq =
+		create_singlethread_workqueue(dev_name(usbssp_data->dev));
+
+	if (!usbssp_data->bottom_irq_wq)
+		goto fail;
+
+	INIT_WORK(&usbssp_data->bottom_irq, usbssp_bottom_irq);
+
 	page_size = readl(&usbssp_data->op_regs->page_size);
 	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
 			"Supported page size register = 0x%x", page_size);
diff --git a/drivers/usb/usbssp/gadget-port.c b/drivers/usb/usbssp/gadget-port.c
index c9c8aae369ba..fc76139468d5 100644
--- a/drivers/usb/usbssp/gadget-port.c
+++ b/drivers/usb/usbssp/gadget-port.c
@@ -64,6 +64,98 @@ u32 usbssp_port_state_to_neutral(u32 state)
 	/* Save read-only status and port state */
 	return (state & USBSSP_PORT_RO) | (state & USBSSP_PORT_RWS);
 }
+
+/*
+ * Stop device
+ * It issues stop endpoint command for EP 0 to 30. And wait the last command
+ * to complete.
+ */
+int usbssp_stop_device(struct usbssp_udc *usbssp_data, int suspend)
+{
+	struct usbssp_device *priv_dev;
+	struct usbssp_ep_ctx *ep_ctx;
+	int ret = 0;
+	int i;
+
+	ret = 0;
+	priv_dev = &usbssp_data->devs;
+
+	trace_usbssp_stop_device(priv_dev);
+
+	if (usbssp_data->gadget.state < USB_STATE_ADDRESS) {
+		usbssp_dbg(usbssp_data,
+			"Device is not yet in  USB_STATE_ADDRESS state\n");
+		goto stop_ep0;
+	}
+
+	for (i = LAST_EP_INDEX; i > 0; i--) {
+		if (priv_dev->eps[i].ring && priv_dev->eps[i].ring->dequeue) {
+			struct usbssp_command *command;
+
+			if (priv_dev->eps[i].ep_state & EP_HALTED) {
+				usbssp_dbg(usbssp_data,
+					"ep_index %d is in halted state "
+					"- ep state: %x\n",
+					i, priv_dev->eps[i].ep_state);
+				usbssp_halt_endpoint(usbssp_data,
+						&priv_dev->eps[i], 0);
+			}
+
+			ep_ctx = usbssp_get_ep_ctx(usbssp_data,
+					priv_dev->out_ctx, i);
+
+			/* Check ep is running, required by AMD SNPS 3.1 xHC */
+			if (GET_EP_CTX_STATE(ep_ctx) != EP_STATE_RUNNING) {
+				usbssp_dbg(usbssp_data,
+					"ep_index %d is already stopped.\n", i);
+				continue;
+			}
+
+			if (priv_dev->eps[i].ep_state & EP_STOP_CMD_PENDING) {
+				usbssp_dbg(usbssp_data,
+					"Stop endpoint command is pending "
+					"for ep_index %d.\n", i);
+				continue;
+			}
+
+			/*device was disconnected so endpoint should be disabled
+			 * and transfer ring stopped.
+			 */
+			priv_dev->eps[i].ep_state |= EP_STOP_CMD_PENDING |
+					USBSSP_EP_DISABLE_PENDING;
+
+			command = usbssp_alloc_command(usbssp_data, false,
+					GFP_ATOMIC);
+			if (!command)
+				return -ENOMEM;
+
+			ret = usbssp_queue_stop_endpoint(usbssp_data,
+					command, i, suspend);
+			if (ret) {
+				usbssp_free_command(usbssp_data, command);
+				return ret;
+			}
+		}
+	}
+
+stop_ep0:
+	if (priv_dev->eps[0].ep_state & EP_HALTED) {
+		usbssp_dbg(usbssp_data,
+			"ep_index 0 is in halted state - ep state: %x\n",
+			priv_dev->eps[i].ep_state);
+		ret = usbssp_halt_endpoint(usbssp_data, &priv_dev->eps[0], 0);
+	} else {
+		/*device was disconnected so endpoint should be disabled
+		 * and transfer ring stopped.
+		 */
+		priv_dev->eps[0].ep_state &= ~USBSSP_EP_ENABLED;
+		ret = usbssp_cmd_stop_ep(usbssp_data, &usbssp_data->gadget,
+				&priv_dev->eps[0]);
+	}
+
+	return ret;
+}
+
 __le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data)
 {
 	if (usbssp_data->port_major_revision == 0x03)
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 28b807fbbc64..32bf7a4cae34 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -217,6 +217,18 @@ static inline int room_on_ring(struct usbssp_udc *usbssp_data,
 	return 1;
 }
 
+/* Ring the device controller doorbell after placing a command on the ring */
+void usbssp_ring_cmd_db(struct usbssp_udc *usbssp_data)
+{
+	if (!(usbssp_data->cmd_ring_state & CMD_RING_STATE_RUNNING))
+		return;
+
+	usbssp_dbg(usbssp_data, "// Ding dong command ring!\n");
+	writel(DB_VALUE_CMD, &usbssp_data->dba->doorbell[0]);
+	/* Flush PCI posted writes */
+	readl(&usbssp_data->dba->doorbell[0]);
+}
+
 static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
 				  unsigned long delay)
 {
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 2ddb449765b6..6637fa010b39 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -23,6 +23,68 @@
 #include "gadget-trace.h"
 #include "gadget.h"
 
+void usbssp_bottom_irq(struct work_struct *work)
+{
+	struct usbssp_udc *usbssp_data = container_of(work, struct usbssp_udc,
+						bottom_irq);
+
+	usbssp_dbg(usbssp_data, "===== Bottom IRQ handler start ====\n");
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING) {
+		usbssp_err(usbssp_data, "Device controller dying\n");
+		return;
+	}
+
+	mutex_lock(&usbssp_data->mutex);
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	if (usbssp_data->defered_event & EVENT_DEV_DISCONECTED) {
+		usbssp_dbg(usbssp_data, "Disconnecting device sequence\n");
+		usbssp_data->defered_event &= ~EVENT_DEV_DISCONECTED;
+		usbssp_data->usbssp_state |= USBSSP_STATE_DISCONNECT_PENDING;
+		usbssp_stop_device(usbssp_data, 0);
+
+		//time needed for disconnect
+		usbssp_gadget_disconnect_interrupt(usbssp_data);
+		usbssp_data->gadget.speed = USB_SPEED_UNKNOWN;
+		usb_gadget_set_state(&usbssp_data->gadget, USB_STATE_NOTATTACHED);
+
+		usbssp_dbg(usbssp_data, "Wait for disconnect\n");
+
+		spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+					usbssp_data->irq_thread_flag);
+		/*fixme: should be replaced by wait_for_completion*/
+		msleep(200);
+		spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+	}
+
+	if (usbssp_data->defered_event & EVENT_DEV_CONNECTED) {
+		usbssp_dbg(usbssp_data, "Connecting device sequence\n");
+		if (usbssp_data->usbssp_state & USBSSP_STATE_DISCONNECT_PENDING) {
+			usbssp_free_dev(usbssp_data);
+			usbssp_data->usbssp_state &= ~USBSSP_STATE_DISCONNECT_PENDING;
+		}
+
+		usbssp_data->defered_event &= ~EVENT_DEV_CONNECTED;
+			usbssp_alloc_dev(usbssp_data);
+	}
+
+	if (usbssp_data->defered_event & EVENT_USB_RESET) {
+		/*TODO: implement handling of USB_RESET*/
+	}
+
+	/*handle setup packet*/
+	if (usbssp_data->defered_event & EVENT_SETUP_PACKET) {
+		/*TODO: implement handling of SETUP packet*/
+	}
+
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+	mutex_unlock(&usbssp_data->mutex);
+	usbssp_dbg(usbssp_data, "===== Bottom IRQ handler end ====\n");
+}
 
 /*
  * usbssp_handshake - spin reading dc until handshake completes or fails
@@ -277,6 +339,123 @@ unsigned int usbssp_last_valid_endpoint(u32 added_ctxs)
 	return fls(added_ctxs) - 1;
 }
 
+int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
+			 int value)
+{
+	/*TODO: implement this function*/
+	return 0;
+}
+
+/*
+ * At this point, the struct usb_device is about to go away, the device has
+ * disconnected, and all traffic has been stopped and the endpoints have been
+ * disabled. Free any DC data structures associated with that device.
+ */
+void usbssp_free_dev(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *priv_dev;
+	int i, ret;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	priv_dev = &usbssp_data->devs;
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, priv_dev->out_ctx);
+	trace_usbssp_free_dev(slot_ctx);
+
+	for (i = 0; i < 31; ++i)
+		priv_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
+
+	ret = usbssp_disable_slot(usbssp_data);
+	if (ret)
+		usbssp_free_priv_device(usbssp_data);
+}
+
+int usbssp_disable_slot(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_command *command;
+	u32 state;
+	int ret = 0;
+
+	command = usbssp_alloc_command(usbssp_data, false, GFP_ATOMIC);
+	if (!command)
+		return -ENOMEM;
+
+	/* Don't disable the slot if the device controller is dead. */
+	state = readl(&usbssp_data->op_regs->status);
+	if (state == 0xffffffff ||
+	    (usbssp_data->usbssp_state & USBSSP_STATE_DYING) ||
+	    (usbssp_data->usbssp_state & USBSSP_STATE_HALTED)) {
+		kfree(command);
+		return -ENODEV;
+	}
+
+	ret = usbssp_queue_slot_control(usbssp_data, command, TRB_DISABLE_SLOT);
+	if (ret) {
+		kfree(command);
+		return ret;
+	}
+	usbssp_ring_cmd_db(usbssp_data);
+	return ret;
+}
+
+/*
+ * Returns 0 if the DC n out of device slots, the Enable Slot command
+ * timed out, or allocating memory failed. Returns 1 on success.
+ */
+int usbssp_alloc_dev(struct usbssp_udc *usbssp_data)
+{
+	int ret, slot_id;
+	struct usbssp_command *command;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+
+	if (!command)
+		return -ENOMEM;
+
+	ret = usbssp_queue_slot_control(usbssp_data, command, TRB_ENABLE_SLOT);
+
+	if (ret) {
+		usbssp_free_command(usbssp_data, command);
+		return ret;
+	}
+
+	usbssp_ring_cmd_db(usbssp_data);
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+	wait_for_completion(command->completion);
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	slot_id = usbssp_data->slot_id;
+
+	if (!slot_id || command->status != COMP_SUCCESS) {
+		usbssp_err(usbssp_data,
+			"Error while assigning device slot ID\n");
+		usbssp_free_command(usbssp_data, command);
+		return 0;
+	}
+
+	usbssp_free_command(usbssp_data, command);
+
+	if (!usbssp_alloc_priv_device(usbssp_data, GFP_ATOMIC)) {
+		usbssp_warn(usbssp_data,
+			"Could not allocate usbssp_device data structures\n");
+		goto disable_slot;
+	}
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, usbssp_data->devs.out_ctx);
+	trace_usbssp_alloc_dev(slot_ctx);
+
+	return 1;
+
+disable_slot:
+	ret = usbssp_disable_slot(usbssp_data);
+	if (ret)
+		usbssp_free_priv_device(usbssp_data);
+
+	return 0;
+}
+
 int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 {
 	int	retval;
@@ -424,7 +603,6 @@ int usbssp_gadget_exit(struct usbssp_udc *usbssp_data)
 
 	usb_del_gadget_udc(&usbssp_data->gadget);
 	usbssp_gadget_free_endpoint(usbssp_data);
-	/*TODO: add usbssp_stop implementation*/
-	//usbssp_stop(usbssp_data);
+	usbssp_stop(usbssp_data);
 	return ret;
 }
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index d0c9548a39ca..38e9b80faf2a 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1679,6 +1679,8 @@ void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 /* USBSSP memory management */
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
+void usbssp_free_priv_device(struct usbssp_udc *usbssp_data);
+int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 		struct usbssp_ring *ring, unsigned int num_trbs, gfp_t flags);
@@ -1705,12 +1707,15 @@ int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void usbssp_quiesce(struct usbssp_udc *usbssp_data);
 int usbssp_halt(struct usbssp_udc *usbssp_data);
 extern int usbssp_reset(struct usbssp_udc *usbssp_data);
+int usbssp_disable_slot(struct usbssp_udc *usbssp_data);
 
 int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
 int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
 
 irqreturn_t usbssp_irq(int irq, void *priv);
 
+int usbssp_alloc_dev(struct usbssp_udc *usbssp_data);
+void usbssp_free_dev(struct usbssp_udc *usbssp_data);
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 		union usbssp_trb *trb);
@@ -1718,6 +1723,12 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 		struct usbssp_segment *start_seg,
 		union usbssp_trb *start_trb, union usbssp_trb *end_trb,
 		dma_addr_t suspect_dma, bool debug);
+void usbssp_ring_cmd_db(struct usbssp_udc *usbssp_data);
+int usbssp_queue_slot_control(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *cmd, u32 trb_type);
+int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *cmd,
+		unsigned int ep_index, int suspend);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
@@ -1744,6 +1755,12 @@ void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_port_speed(unsigned int port_status);
 void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data);
+void usbssp_gadget_disconnect_interrupt(struct usbssp_udc *usbssp_data);
+int usbssp_stop_device(struct usbssp_udc *usbssp_data, int suspend);
+int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data,
+		struct usbssp_ep *dep, int value);
+int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
+		struct usbssp_ep *ep_priv);
 
 static inline char *usbssp_slot_state_string(u32 state)
 {
-- 
2.17.1

