Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368A1C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A0620684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AUO0nRZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A0620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbeGSSo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:44:58 -0400
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:20513
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387897AbeGSSny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1rUujA7kcIkIFj8dDIouTDDUtslkUCjvMOWq949s4I=;
 b=AUO0nRZG94IqpHzTr0vCcaOZCkcCtQkYBB/YU9YpmsJZjusPW9FiGlGdvxZrWTkLTzPS5Fh3HIbfYOdfMIrLB6p+DDUg/bO4ccB5puh5MJh9aPedYxhgIkaDdOGS1D6s04rQv6FfXuopmHT/KkXdka9CYtW2ZpgkXH+uW7rFbMg=
Received: from SN1PR0701CA0077.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::45) by BN7PR07MB4708.namprd07.prod.outlook.com
 (2603:10b6:406:f0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 19 Jul
 2018 17:59:34 +0000
Received: from DM3NAM05FT005.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by SN1PR0701CA0077.outlook.office365.com
 (2a01:111:e400:52fd::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:34 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT005.mail.protection.outlook.com (10.152.98.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgJ025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:32 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:32 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxHQA006092;
        Thu, 19 Jul 2018 18:59:17 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxHn3006091;
        Thu, 19 Jul 2018 18:59:17 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 29/31] usb: usbssp: added support for LPM.
Date:   Thu, 19 Jul 2018 18:58:02 +0100
Message-ID: <1532023084-28083-30-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(2980300002)(36092001)(189003)(199004)(1671002)(478600001)(2616005)(126002)(26826003)(476003)(446003)(11346002)(48376002)(50466002)(14444005)(87636003)(486006)(106466001)(105596002)(51416003)(7636002)(4720700003)(305945005)(356003)(8676002)(246002)(5660300001)(336012)(16586007)(6666003)(76176011)(186003)(26005)(36756003)(316002)(426003)(8936002)(54906003)(42186006)(107886003)(4326008)(2906002)(109986005)(50226002)(47776003)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4708;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT005;1:LMywMMtBZoFBFqJU7LCP0ku3g6p9ryMGoHz/Y2J/r0x1tf1uvukRLnU+gJTwRq+GO+AMesHdFZ4zH6OZ7aaqE7QwVJwATFvvqEflc/QI1am89mKdOo4W1FhNrfk8ql/C
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1558f9a6-2d24-4383-7bc6-08d5eda16231
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4708;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;3:NbzzOH5vrFfY3S/WX3Gp3dJ1IzOGlNZJPx8/7ygLYQ/QCSAu/sME4z3D2poHPx2k3CkHnLATuguHe5uE6KNbGRWolQpDcG3Dbv3IvSx/JqmHU62yZ8/LtfbWPeEhG7IPTuEP6wMC7gcWaeRJJ+FZNQFpXzbWe/kNCK3no6xJ0Bzp7SF4oC7WdqAtZ/jhz9MASHKIbLGa+6HnQjw5xXs1RdG1CEQh/sOvRPYLz0J25DG4u20agTEHj20S/xPaSpzJAVa6WQaw5pXItQ6XCtWmqHauMI6HA/a8zvmGWMlr6QXJidsnnKCawgTnANIO1QCkh+3U62RAOIudmbC1sXfHNpbwzB/oUFphVHR3DHicUjM=;25:7U9Y8mP47I5JTspGK3yTKaARh6A4VHBndqq710BDUL0igs/HiTnxwmrleeb7KinmVIoIFGnwFzZq+4U+CVTXJwif1jz6OSzEHocKy7Z5NajpuYzI+9dzkYuecJZ6NLfMylhTfDTSVAelIS1J+lXUhLZuiOciwWxelRzcrdEPKfDyELFCNLjImbVn0R0rlgf6qOWXc4v6W6M9KNiI8/B7dny/1zUHZRSeW4+3CNInPNxRfs80h/Hd+x61I6lvspgsEppjN5hv3Wf6X2auj4Xvgk9L8p1b0MIPVbxMAmFX9H3ZD9yepk/DUM/jlhmLJFOZpQoSZ2ywbc0/KC9QmNTTHw==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4708:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;31:n27r9/Hjm/IWLAcb/c3R5cpy9lJ0Ce2bvCo5cz2HuWVNywHkMUK52jr7UeD6Vk8fIzS/07Mmh4WtpTiVFu/kbP/ELqhBESixMah44JcF2T7DRGMNpBPpk+IfpvFkKOYZosoLKqVlBwrzHFZ0t97UIOgAw8H4A0/nU5XGPejCwjzsFrTxLFfRk8CDRiJ4uWOmp7boZ+VLop1RfHTewjP9r7LZl4D1gpsyJagtFbJjFxU=;20:FxpZu99MhRYVJLJ7B/UwYt4ctawi0nFfwDtTdOxG2wDsHduC76dYoh/DvS876MJhOGgb3eDCF66yUTrbLKpBQn9A86vdMbGeEeUJlyU/8qv4ZMW9U9iw4RIn8+jxqrNCWxd6etHt5CJ2RL2/6SD/gq4b4VdKPZ6N1mPnkX5osj4wNpAlEgGzj/ELlGH4mZ9uhAle15YAKxQwmvhFB3RsYJoqIDK3g+Y9rGwL+cvNuCawVzK5/VMQtaqKxslyVnSRBFqL/kky5os7fEWp19Cq7+b+i1T6mXfEjmJQqs5/PxgrsbtSK3WJDrGF65vUCdDrXGrVvwR3PFFyUAaVDcLkm9veKo4ygFjqGQrBE4Anp4u3RX1waYzhqqUT3dzPk5hHaxVLPfAjZ6bLLNCuE8VcDCV+3si1qrWU+P4w5H/1Hl/X5LBMa2bKhRuKfsOg2tDIViwaylDrFzuH5Nsy8TKD1Ygcr0G0R6O8zCjQgDt0xY1k9bhlz8W4IvPf7LJrobXz
X-Microsoft-Antispam-PRVS: <BN7PR07MB4708AD0A48C44D5DDC61D42DDD520@BN7PR07MB4708.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4708;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4708;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;4:8c57wSCAaHcOPQ+w6m2455SP46ftPafxbCF9Y623h+W4iH5TCeh4i/vjD/0KNTlHuqT872s8joqGqoXkhLAbWgKquBIEhwS/tMTHGIbH1uuTWNvpqows+Ndq8r3713mYbp2oVRpBQtYnVCneZeyFL1Atr5ayJAJHezuqIBBF4mRv2KG9seRMZc7fCiWen/ZBLfsnU9oLNRqrmEfjU6pgA5e3++g3Fqd5ipKheod13EG6UfaxtdZtF2coS1yMzN4GHsfJokdZAAR9+1objllu55vB2wDpjWWGryeuF4g+FxJgwEs6nE3YUeiZsQu/4EBD
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4708;23:U3XZUn3zemgjpSDrLUekz8o8o50bRvTi7F091+UFA?=
 =?us-ascii?Q?SNs0iudr1GLv4ZXJBpMANOK+WJ0uEsCT8VvMQpmhxwMfELWv1Pawuh5s5UW3?=
 =?us-ascii?Q?aDVdocA90EqDZ4G5J2AL/cSFxo1znED7I+X4AN02M0ukppyIorbsoSWwjfKq?=
 =?us-ascii?Q?VMy4J9ZvGPVfrqZm7Vieuf75VMOwZaj3+xEMJ4qPXrPepO/5g1kRR8t9l+5Y?=
 =?us-ascii?Q?Hjhkur/gxql3BeTNJrJ1atBqFhZTk0aTUIsNDysuQKJNeAGS8zhUZ2kvZi+K?=
 =?us-ascii?Q?XdjOtQy8sxTk7gwSTq1PHry2pgPW4Mp1zWX+FO3YlCpEzmHus4df18sA+XIZ?=
 =?us-ascii?Q?TFXXg9x5ktyo3f5HLM+74bAbuQ9mgxgMAezU5hrI+Gb0vKEIFXgSAGL1rIxX?=
 =?us-ascii?Q?VR8fycbBRpibD1NDsyqqhIPLtSpx/dqnCQjAOVrasGFxu5ctJTI/zUNCTfSZ?=
 =?us-ascii?Q?Y/ek1NCE9kBFuG2PteXaIJmlttj8oMxCovIhAfB0nYCpJLZW5Fi0AqJUbcwi?=
 =?us-ascii?Q?tSYbEXP/sL9pEGIJTm1qaMKFLklks4RdcVnR5l9w/xS9SgtOSMEaaT2jKtVR?=
 =?us-ascii?Q?9yNmw0EPumwWfsbmJ1km++/8zUxJfpQIzttS50L8sd0sIPfzbdN3z3zhauyt?=
 =?us-ascii?Q?evx1gXtK8mAhH1FECT9Y8Y0HtPfoQt4QZ+j/TIsCHmhbaLpEOd1lzvKjohNh?=
 =?us-ascii?Q?ZDY971KBNpD03Ot8kYZhryxFBkaz4DTEAx5TttglptaU2+UWnnLfle2lWcAh?=
 =?us-ascii?Q?mdwCwRadB6GSZ7VWQqCVX+ZnEvqOe9O9b7KDWUJYEHjxjcqcoQ6VubRwHgpd?=
 =?us-ascii?Q?s7GgYBTOwQb2rgj4p8bSN1EDG1RKmXjCFnT+RCpevDq4bLPF3n9cEz6Jg/rd?=
 =?us-ascii?Q?zmmHEkqb9Djw3cVtJcua9aLgQEvTFCjdyDuKzn5N+r2j8P01lZpoTHx9gtVY?=
 =?us-ascii?Q?jOztM/tE0O6BPE9FzoO76ZjjuQqqGTj0aYsqV+7WL13cwr0MtidJO+MxRA3p?=
 =?us-ascii?Q?l5WmmffVWVeY0yzoQXhDXqwOIDn52LVgxP695m03Yfci+iASehJwH4DVPQl1?=
 =?us-ascii?Q?6I0IUke22Y06Oj3hG2yr39pYRk3girvWwEEjm9UoVsewprvGDpQegaT19TvD?=
 =?us-ascii?Q?ssWvpH+yAZ0S7lDx52bJks+IKoTA/LplUoNcTQYKuJ64LNWeGjcUg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9hh/0z32rPKQFJ0d7j8ip80SYb+KH1FTK2Ngcftgm+oP9IL8VKyV4so9d1sfrWQBl1fSzGGTmECESx3Q+UV0melUX45vGabyJtQXna+zGsQPrX2EHSvj/7JmtqssVLymob0eHnlMDjqwA4u7e34vAP92ZUHLKrtPLil2fx0DhMYsj5ATKnaDHOkaJXL2Z4w9/7HduqdGx8QrCJWXTy7AqlowDKmVAT2BCGs0t7zT3ZzMUJwmA4Dac1/EjIGm3YnsSB+IifhjB9G23uBr3CObSYRqHH/B1HM40Rj0t6KLOlrWEWbiveJa7yfYPhFdi80G5J652s6nlvcU9UAX233rKzONerCrzXAmn2X3Dosy1Ap0xuXwLAo9S68OXJ1T4oTy5trtH2U68QrCALaLcuSxkA==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;6:vsgObgJVL+scSvDqB5eNuCCWoQn4i9FnvgtfKQfeoRsGthE1Yj9Y/P6TMhxP3SdUPDNQaxQZRjduYkRGiS28ljb0dqCNN/hZA4ZiBXcaVVO0avCukbBfUGQZv2eKFQ0CracwdvtoIbCQ7heEqpgu1A4+p3/ouFFiZq7c6LOoSUbez3aEKjwTT4sQ2xLGE5V5rR9q1W/yfMoL7rxP9WDcKr0sFiyNKkE1b3HhqSGc3W5/xRxd25SQGsBBtEYk6lEfoVPRBl1kz7kXfyK3QfMFnSR80kxHEo4i3s3UCPhBbGY0+elIq8OJSDRvJBO7CGMl5UMLEdYpxWqooNOQWtrJChT3/p2SP8EO6bLYn3rwYddvgKsOMDO4O1tjKqqSz6+Qylgu5DBXBehwJFoMmFSgSdLFmlpIvHb2ikGNDkNN60nL1gIlF8u1yfuTaxKEuKeWGcIOE8u1iZJ6GaMsrHtl1Q==;5:3loqDy+O9AHMxKLW/jTuf2V/AKi4HJf7g6QfhiRPF2PlX7Zjn2Qk5sGidZ7VVaUCizU3pWT6aNdC+Ju1eg/e/Fr/grLvzvwovcI58cIB5OWkn484DKf5QRdb7mvQi/wkjlKhGutADHpIwmg08qzBIPpk1DY+Da/NgDXhmUskoRU=;24:PWuvpnV4wzKJjWHrdl1BaFOSxaZ2tAlQACdYyfyj12SaaIgnPQT1ht+gENu8HKb3BIb7yXUlCZdbeGNBSkQXp1ZEZouxeHaaklI6rqEoru8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;7:ooqiwT6wffl/JyYgdfL6iGtcQtMO3lI8ij9RX/MpXH8ls6ncNs+F8ItEnUUnwmxg7h2qow+sfdNFUNyhVXZQJGD7HuGvOA4RKyCgFoOIELbcUSwauELtIV3591Ub+8fngxXprUgz1iS2U7ZraEBwA2VmCvvdgnROCZFIHaq/ZouOv82t3ev6QVA1AJE6Pva9b+Qhv6jOFkKM/Gg7WWQXHgwj+Q0gKTKq4xZzrjJCwtQZmt+twe7zpbnfXVTRB8+C;20:AniznxPVkiRVAQX6kvMiZEzsrwsn/b+lYjyzXJevc+7JC92QgkRM+y8Ew/5g7bBoFafns+bg1w21ZpO1bnQjcNdizfddjkBZDo125p1vJ5I5adM87uxN8VoiTmWZdkZpglCl15oQO1gfO85yikngm6MgeUTnKX4o4uXS078BaNCF6NmQurAdE/ZDgfz+fhE5ExTeAaxaprlpU4QdjDSikTTgAwro7IwQAyefIwtXGHkAcqPXiqK1MCdPSZfTqgG9
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:33.2752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1558f9a6-2d24-4383-7bc6-08d5eda16231
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4708
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements LPM functionality for port working in HS mode.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-port.c |  2 +-
 drivers/usb/usbssp/gadget-ring.c | 11 +++++++
 drivers/usb/usbssp/gadget.c      | 49 ++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h      |  4 +++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-port.c b/drivers/usb/usbssp/gadget-port.c
index 2c4d28070cab..05a4eb2fd8bf 100644
--- a/drivers/usb/usbssp/gadget-port.c
+++ b/drivers/usb/usbssp/gadget-port.c
@@ -10,9 +10,9 @@
  * Origin: Copyright (C) 2008 Intel Corp
  */
 
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
-
 #include "gadget-trace.h"
 #include "gadget.h"
 
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index e7afd185d4ad..4abc2293f249 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -3018,6 +3018,17 @@ int usbssp_queue_ctrl_tx(struct usbssp_udc *usbssp_data,
 				USB_STATE_CONFIGURED);
 	}
 
+	if (usbssp_data->bos_event_detected) {
+		usbssp_data->bos_event_detected = 0;
+		usb_gadget_unmap_request_by_dev(usbssp_data->dev,
+						&req_priv->request,
+						dep->direction);
+		usbssp_set_usb2_hardware_lpm(usbssp_data,
+					&req_priv->request, 1);
+		ret = usb_gadget_map_request_by_dev(usbssp_data->dev,
+						&req_priv->request, dep->direction);
+	}
+
 	/* 1 TRB for data, 1 for status */
 	if (usbssp_data->three_stage_setup)
 		num_trbs = 2;
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 378828d10a2e..029d6313d94c 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -1702,6 +1702,55 @@ int usbssp_enable_device(struct usbssp_udc *usbssp_data)
 	return usbssp_setup_device(usbssp_data, SETUP_CONTEXT_ONLY);
 }
 
+int usbssp_set_usb2_hardware_lpm(struct usbssp_udc *usbssp_data,
+				 struct usb_request *req, int enable)
+{
+	__le32 __iomem *pm_addr;
+	u32 pm_val, field;
+	int besl;
+
+	struct usb_ext_cap_descriptor *usb_ext = req->buf + USB_DT_BOS_SIZE;
+
+	if (usbssp_data->port_major_revision >= 3 ||
+	   !usbssp_data->hw_lpm_support ||
+	   !usbssp_data->gadget.lpm_capable)
+		return -EPERM;
+
+	if (usb_ext->bDescriptorType != USB_DT_DEVICE_CAPABILITY ||
+	    usb_ext->bDevCapabilityType != USB_CAP_TYPE_EXT) {
+		return -EPERM;
+	}
+	pm_addr = usbssp_data->usb2_ports + PORTPMSC;
+	pm_val = readl(pm_addr);
+	field = le32_to_cpu(usb_ext->bmAttributes);
+
+	dev_dbg(usbssp_data->dev, "%s port %d USB2 hardware LPM\n",
+		enable ? "enable" : "disable", usbssp_data->devs.port_num);
+
+	if (enable) {
+		/*
+		 * If device doesn't have a preferred BESL value use a
+		 * default one . See USBSSP_DEFAULT_BESL definition in gadget.h
+		 */
+		if ((field & USB_BESL_SUPPORT) &&
+		    (field & USB_BESL_BASELINE_VALID))
+			besl = USB_GET_BESL_BASELINE(field);
+		else
+			besl = USBSSP_DEFAULT_BESL;
+
+		pm_val &= ~(PORT_BESL_MASK | PORT_HLE_MASK);
+		pm_val |= PORT_RBESL(besl) | PORT_HLE | 3 /*L1S set to 3*/;
+		pr_err("usbssp_set_usb2_hardware_lpm7 %08x\n", pm_val);
+		writel(pm_val, pm_addr);
+		/* flush write */
+		readl(pm_addr);
+	} else {
+		pm_val &= ~(PORT_HLE | PORT_BESL_MASK | PORT_L1S_MASK);
+		pm_val |= PORT_L1S_HLE0_STALL;
+		writel(pm_val, pm_addr);
+	}
+	return 0;
+}
 
 int usbssp_get_frame(struct usbssp_udc *usbssp_data)
 {
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 3a223b89efe6..59d7ef573d96 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1756,6 +1756,10 @@ int usbssp_alloc_dev(struct usbssp_udc *usbssp_data);
 void usbssp_free_dev(struct usbssp_udc *usbssp_data);
 int usbssp_address_device(struct usbssp_udc *usbssp_data);
 int usbssp_enable_device(struct usbssp_udc *usbssp_data);
+
+int usbssp_set_usb2_hardware_lpm(struct usbssp_udc *usbsssp_data,
+				struct usb_request *req, int enable);
+
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 				union usbssp_trb *trb);
-- 
2.17.1

