Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12871ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A538A20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Nf+2s7ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A538A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbeGSSo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:44:58 -0400
Received: from mail-eopbgr730040.outbound.protection.outlook.com ([40.107.73.40]:46688
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732030AbeGSSny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqAf0VdzGEMczWvbz5OQP5fM6fXEo7UF1jth7KmFRyA=;
 b=Nf+2s7ZAWG//1xYuEhRvqBWDx4dQc7rRRZ/qnVqKPy5OdEuoMvgj+xxII5PJLIyQ1oGLI1IfzKj2AuCoCdFOryZ0tLf7bBTJGsp9FFr47ZLOqxCegCEqeJTGeidRAKYB2xrZvPoJqDydnF5YtfXIJbVcP6nZZhVG2oWEACiODAA=
Received: from CO2PR07CA0071.namprd07.prod.outlook.com (2603:10b6:100::39) by
 BL2PR07MB2290.namprd07.prod.outlook.com (2a01:111:e400:c752::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Thu, 19 Jul
 2018 17:59:18 +0000
Received: from DM3NAM05FT037.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by CO2PR07CA0071.outlook.office365.com
 (2603:10b6:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:18 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT037.mail.protection.outlook.com (10.152.98.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:17 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxARx019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:16 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:27 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:27 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxBHU005727;
        Thu, 19 Jul 2018 18:59:11 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxBve005726;
        Thu, 19 Jul 2018 18:59:11 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 09/31] usb: usbssp: add implementation of usbssp_mem_cleanup
Date:   Thu, 19 Jul 2018 18:57:42 +0100
Message-ID: <1532023084-28083-10-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(189003)(199004)(36092001)(26826003)(105596002)(76176011)(87636003)(478600001)(246002)(51416003)(7636002)(42186006)(5660300001)(16586007)(106466001)(356003)(316002)(4326008)(305945005)(11346002)(446003)(14444005)(186003)(26005)(8676002)(336012)(426003)(50226002)(8936002)(107886003)(109986005)(54906003)(36756003)(1671002)(48376002)(126002)(50466002)(476003)(486006)(2616005)(47776003)(86362001)(575784001)(2906002)(6666003)(4720700003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2290;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT037;1:SzCF2XtNthP57I9cnYZ6cvxk+iNOHmJP8/2NamUwTeYphOTc1fZOreI4FIxf6xuzp5bKqBsD4jVnoyx0LasoMe8d/48zzwr7rQs3fppNcML6aiZNaxGXTcwgyzRdUBLQ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4539f8e7-711e-4ba8-ba88-08d5eda158ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL2PR07MB2290;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2290;3:pmP11AMtYylEF5yvM+ZMu/WaUZxMPpnKtIDwrMSqiIp57AAiDcLaFuA2srImCuvf4+xcjQhsNmdU7yIZLMGux9uvzkgq6WHu3DkomIoV3JdvlT1qvpaK1cPruIAbPsxx+bzKWOkQXFUXW6mHO5SkTKtohq/iWg5x4T2zgnxX1D2nPJGPIKAjR9DvJdlIyDa1j4upHvWnmBc8hTJCSaN+ttwd7cqtBbg1mMIAIGn4M+QWXVpekv01ywj6QALKDqdPYDlJSFe0cI6l2YPPjhAj4mN0p8BJwIq2+yNTYENfghlLcdbcNAMtR6ptxHZIUgA79rB30U/zYNFBld8YeuFjLwmZTkfGtOAJuhpGu+mUJmQ=;25:qZUvvbsdlCF9NEdonugxlWZGQ3HtY4R3PAziq2+4AWWIzdt8/iWZiHrnP8CGd1RCKMtTZsyWhDDvNsg539+z6pwkboToVvs+qeJSu5qW71vl6RblCCiNKC4sn4gnHmD6mAQ+yeZ0kcG+mWU8qjIIfbVT6gO+BSumeG5umGYG/heJZ2H5IxaQYFNhPjLuJdx/aW7H9pHV5DZG+MDF/2xD4lR1QRudNuGjsnQDvD804BHoLJQaoKdSYmN0G34AjMdSnaUqBEANmYP1xd3tBXeJPOOO1dlUgSZlPAc2j59+kHUpyaqvNVsrVsGopMH3amIymyB8i1GUmJuyw1d5vrYMZw==
X-MS-TrafficTypeDiagnostic: BL2PR07MB2290:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2290;31:8DZtu1fUDCulUnDU250+yjmeZxDeaY5v/niKljtsPD/7FQT+tgPivCGcIfsX1DZhP4fbrD/pePX1Z4jqBMuVJK/zlXoet98jYBLHE7T7eyEgOPh7wgKxEhtTlGBgXWz83jf/XzdsMZS7auTqYGKw5DZsUf2BwFPAXuCn5qc23WV2+6avyGdr0xDiT1ooIGNTzQPV+T3hqcfxd2mj0mqffrXcwQxBRGHnelsxEbjcxKA=;20:xVu1M2lDhWfs/rlBVxbMWzp34SGxkoBqhTnpGEmAp8IxVkx2OFyNQLoe1MqqtiDQPHyECIoLKZ+5yaA8ir58zm+fYPsJRD9fA8MpuGjffOipWxgKtkITFqF1k7z0IP+sLrjGkeBx8oRge4W2zJ92mx/I/rU0Ee+aD2VOIr8SDIdO+upWUmv8S7UijCLfBfn4yzpWy5Xa2BtxMnysahI7jZcv8w3xklUp3fDKE4SgkV447mZ0+qPR641MPDwK24jJchS5qWGuwLU8y2FL4Jvvg207Pg7j93qx5qSqqFD4k8S4g2oqnOAofHSbk7WeLCTZkNMdqLI1+CPCgn4HaFbuPcyV0S39+zdQ2Qla8LIloi57hyEsSSL90qULLXAPMzufe7bN73iqJiagDoOSXxiW11h7OIUbkMIFV1NzsDT8pKebRmtV5dC5vbhrt8TL8pbJQo1miorgfVsZpB7zmynhHKnMMxqUz3Km0HLHf5Xbs3n/ilZiYdlr3xKCWfkWBW9u
X-Microsoft-Antispam-PRVS: <BL2PR07MB22901EA7122B21F9F29A13FEDD520@BL2PR07MB2290.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL2PR07MB2290;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2290;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2290;4:L6UiYpgMajqFXeBAegPPI9QZ7u9LFjGtwoCyyP8cJbl/wWKWOXStFq+oVW3+nzBGxmkQj9wK2WW+5FRnwfJ/BXK9uGjU+/gVy3sjnLpp//5tQKG5dCXMMnXjicV9WK9lkIbN1xa/HJCzfrz3IbKkbmk7HDQfAADyWpzSgiroYjoY/2WyXBZpWPmewHkhIHJNnMezRqwAdnPNqh4eQKHlv96m0TCV3gN8kVpXF7ct31NhCGzYCBzd6AIBBgdQ4bIcOkRrZ15fkV7xAz5pBsLttKyoVbdS55uJ80TC/IIw/gMeX0CucixcduyR7mNnPCHq
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR07MB2290;23:e4iMAIG8pP46S+qtIvxLRMDQ5eMK3058s5XY+PcRw?=
 =?us-ascii?Q?kcp7F04dA2WIoFitcI6+zEcCxP7bbtZmp0UsCydGV2XVjFPHhGxj36TsgzHx?=
 =?us-ascii?Q?TJCtwX0F58wie5MNHlXm56ugR8JlSLAGClibUg7G7Wu2NGD+Dpb6aQnhd/c+?=
 =?us-ascii?Q?fwRIYUzqpPAnouR+miGS9WyD8l8OvzeFcEMTqwON/DOKekUrDqnbqywholQ2?=
 =?us-ascii?Q?6UEHDoZU1yCtlpwAf/a/z3qkLascjlF0JtnIHDPRloep2+wUuDfkw5Ydgra0?=
 =?us-ascii?Q?WfCz4dfi9E6CUyTdftJ9lUXqDu2UYVo8bpsJeoQ7lBDYjKzvrcGshjP5aypI?=
 =?us-ascii?Q?wdGOo61wqFKt4mFNiLfxZ7Sk9Z/t90uASc5w2KfBKFfJ2pTrTK0/nxGKFaNC?=
 =?us-ascii?Q?Uo43pmfR0xYtlKJwi3oJqp0jfcLNx44EsOFzMljWiMg6BwbHNXxSoJHphAnj?=
 =?us-ascii?Q?3L1ri7fU+2x/r6ZpJTs0tocRvvbCpWM+cTAQKfyAmOCqcArIN4vbS7wR/5eD?=
 =?us-ascii?Q?xYqwGLGo73hMSiePSJvMN1gxsiHrmvLBW0mLZlzcztz+D+OmTSi+wxSjmOOp?=
 =?us-ascii?Q?f1/eUC1jjP6ZbaP1at0MwZZS3l0k9af/Y4JNbesuMxBqnrnt0Y8VxrxKOGb0?=
 =?us-ascii?Q?cgvzRGeTdXvvwV+9+IrxcUJa7HkMxyGuvyuht+2JHyfgUuEwh4rkbajZGLQ+?=
 =?us-ascii?Q?4pdpkBaN4U6tY080I5+w0wkq8/bwVDwnPEIFDYdrO3slu5wr62vGqDyW2+Cd?=
 =?us-ascii?Q?2BhZj6EMvHRYB85kKNG6H0mTqBkTy6wzH9dMysiYYSgaS8sPaK6u2ksLBfpu?=
 =?us-ascii?Q?W+NMVin4ADhtw7+WzBdq15SJa+24pkS3Qwzfnhw3jgT6h+RGGXOxWYQOaqjF?=
 =?us-ascii?Q?igOCRLRBN9giAv598VW1esocW6Njn9zZkm2iGMYkvg5tADtHpsSx6a8il9dH?=
 =?us-ascii?Q?be+UvP+NBx5Eqf0lVkfynrQSp1J11o8n7QAksmyL6DJ3YPtXiSBhFIIx5haS?=
 =?us-ascii?Q?kXzsN8+I/sZYEp0ld66Hgd8Ogp5Q7tIupOG9am3mRBU+yty+537Ot8KffJ7N?=
 =?us-ascii?Q?2R6BUFeBwmgK3xfLDpgHNxWkNlkj0YD9kPzzpCN6g5IrAehDkLYAz3M4mMwp?=
 =?us-ascii?Q?Kc2LqgH7owP/et5YQf3Jkjni36RrR8gUtrv1CEoBX1IHjNivhOOzCdxpkG7w?=
 =?us-ascii?Q?IRqX40wFP3Mu7Q=3D?=
X-Microsoft-Antispam-Message-Info: Lkh5HXYJsKzkL4jBR0Ag8AxUdBG7wC5Lw4hcRcq7ZOAasQhOhO4pNMKjstE7Bos28ctyBEEOrg0/jjS1oVqqu1iV/M3uBt30kNOvLEdj/uJXUFE17/yWUqhhgLQaUjDFpsr+5UpwwokaDSVmuZvGey2FXrdOeO1GcnfL3oGZM1F7fAb9rmDfvu/xFk4ZomBQMWvYB+sFvPIEtXB51o+4UFg8djAFUj8xDw6zWkNKphuEtpzv6I1nVgAevxHcgs8mqO/4lr1FZqxcZOnB3zq+rbwq4XZFZ7S73s0+CWG/X2XXjehJzVmHg0NgvzN0qFv6gL0EP04FDvWZZM86EpJr1uFj+ouuJ/OoEf/GVxfL5fbZ5jpDSKG7Vbnmpa38ThlqhloNwGTF9yWYL8jsIOeKeA==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2290;6:QBKjeOITYaWYDT+uDmMDBrwUwhdfFWfKGW6iTT4ezg8Md7fimBI3EeHHHpygDL+RSLBbaV7ePREQunBG8FVnttdtoY/itOpI/ZB4lF41pu8IZficTc774Uz7Cc+Z4WfEmuzZTzgIDxTzxWuiM/YEIFjGf2jI7lAidn/9MxiPP3kWGwAYpgOU2NrgzoE4gLXfR91pqFNQR8s1lkc2ci6aMSdSn41t4btdXlFglMOZUwJ/5LlvJVcRPx+DPE5QhHvsOEoipRe5lRTPFcfjaDNSrkvMQf9MweltiizNh3SvHPZ/t/BS8JKlQgUinSkLUFGdT3ZRYvQaD45h1Z7wk/JQXDppqdwnzzSfNmJTPXLEE3RHR3fmII74TH2hXMegoSCjQtuZ1MvFtR59/aeYr3+z2yDgeEmiSzg66/ofTcR+++oDydTkI0OHs11XciFxpHeLlT1JYRtdG9M6giPzsxjH5w==;5:Y5O6Urz2blu+KGSoLrXVRaicEqKzjkooX14lkd81hAOBGsrcsXeqmRMdS3c3eK7aAWsBzec6jjUsRjSiktp1J+WW/wF+8QnInh/ZVQGxrb0aMm8/Gsva+uYuz7knQYQLcrOeVRPD4u4KO+X7ws4wZvWPVzDin5OyE9v6krZTp1s=;7:iarPjmw4TGJvqKbOQB/hABjQhg8EomN4xguoOcX6ivio1ybJw6xYdjOfRiqsUSEhjxr4L8oNPXFsCFk0KHzHQJfrkzWgsQ5IKndQMB+ApEEURQntlWuF2LxuoyphyCvrwp6X5mV1Z4W8hJ33mZ8E4posh9YE/eqs7bMXit2p//xcF9WSIXOkjnrYof6APEu86zChhGF7zgtBLsdQCv8eq8cvCo8R2JllKyfvsR0YiBXZEqbWgBI5bm9Xi32lToDb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2290;20:SYttyBG7Q2e2a04xru+RLDbIA2VFl1ZCHBkXY8oIYN3IoMzfHCBnszHEF8OT/FbTtQVujbV0whOi0Lq0sA5t0IG4o/qSOOxaqPJ18wIKyPwjwQ4wE/qHiabHmJdvCo8Dfvq4W5ohks+aaiEid6Y47I8DoBOD8fv05o3GqQ1C2vUDpVf1+9Eg6+vfJkb+B2deAeA9EFTXWcQygXvPyF6FgvWSBexGUd+QuZR4Pg2mUpdxy0yGJrf/c/cCqWGxpcak
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:17.3878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4539f8e7-711e-4ba8-ba88-08d5eda158ce
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2290
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add implementation of usbssp_mem_cleanup and
all other functions used during cleaning driver during
unloading module.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c  | 182 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget-ring.c |  21 ++++
 drivers/usb/usbssp/gadget.c      |   3 +-
 drivers/usb/usbssp/gadget.h      |  10 ++
 4 files changed, 213 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 06a59febbff2..ecb6e1bbd212 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -495,6 +495,105 @@ struct usbssp_container_ctx *usbssp_alloc_container_ctx(
 	return ctx;
 }
 
+void usbssp_free_container_ctx(struct usbssp_udc *usbssp_data,
+			       struct usbssp_container_ctx *ctx)
+{
+	if (!ctx)
+		return;
+	dma_pool_free(usbssp_data->device_pool, ctx->bytes, ctx->dma);
+	kfree(ctx);
+}
+
+/***************** Streams structures manipulation *************************/
+static void usbssp_free_stream_ctx(struct usbssp_udc *usbssp_data,
+				   unsigned int num_stream_ctxs,
+				   struct usbssp_stream_ctx *stream_ctx,
+				   dma_addr_t dma)
+{
+	struct device *dev = usbssp_data->dev;
+	size_t size = sizeof(struct usbssp_stream_ctx) * num_stream_ctxs;
+
+	if (size > MEDIUM_STREAM_ARRAY_SIZE)
+		dma_free_coherent(dev, size, stream_ctx, dma);
+	else if (size <= SMALL_STREAM_ARRAY_SIZE)
+		return dma_pool_free(usbssp_data->small_streams_pool,
+				stream_ctx, dma);
+	else
+		return dma_pool_free(usbssp_data->medium_streams_pool,
+				stream_ctx, dma);
+}
+
+/**
+ * Frees all stream contexts associated with the endpoint,
+ *
+ * Caller should fix the endpoint context streams fields.
+ */
+void usbssp_free_stream_info(struct usbssp_udc *usbssp_data,
+			     struct usbssp_stream_info *stream_info)
+{
+	int cur_stream;
+	struct usbssp_ring *cur_ring;
+
+	if (!stream_info)
+		return;
+
+	for (cur_stream = 1; cur_stream < stream_info->num_streams;
+		cur_stream++) {
+		cur_ring = stream_info->stream_rings[cur_stream];
+		if (cur_ring) {
+			usbssp_ring_free(usbssp_data, cur_ring);
+			stream_info->stream_rings[cur_stream] = NULL;
+		}
+	}
+
+	usbssp_free_command(usbssp_data, stream_info->free_streams_command);
+	usbssp_data->cmd_ring_reserved_trbs--;
+	if (stream_info->stream_ctx_array)
+		usbssp_free_stream_ctx(usbssp_data,
+				stream_info->num_stream_ctxs,
+				stream_info->stream_ctx_array,
+				stream_info->ctx_array_dma);
+
+	kfree(stream_info->stream_rings);
+	kfree(stream_info);
+}
+
+/***************** Device context manipulation *************************/
+
+/* All the usbssp_tds in the ring's TD list should be freed at this point.*/
+void usbssp_free_priv_device(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *dev;
+	int i;
+
+	/* if slot_id = 0 then no device slot is used */
+	if (usbssp_data->slot_id == 0)
+		return;
+
+	dev = &usbssp_data->devs;
+	trace_usbssp_free_priv_device(dev);
+
+	usbssp_data->dcbaa->dev_context_ptrs[usbssp_data->slot_id] = 0;
+	if (!dev)
+		return;
+
+	for (i = 0; i < 31; ++i) {
+		if (dev->eps[i].ring)
+			usbssp_ring_free(usbssp_data, dev->eps[i].ring);
+
+		if (dev->eps[i].stream_info)
+			usbssp_free_stream_info(usbssp_data,
+					dev->eps[i].stream_info);
+	}
+
+	if (dev->in_ctx)
+		usbssp_free_container_ctx(usbssp_data, dev->in_ctx);
+	if (dev->out_ctx)
+		usbssp_free_container_ctx(usbssp_data, dev->out_ctx);
+
+	usbssp_data->slot_id = 0;
+}
+
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
@@ -549,6 +648,13 @@ void usbssp_request_free_priv(struct usbssp_request *priv_req)
 		kfree(priv_req->td);
 }
 
+void usbssp_free_command(struct usbssp_udc *usbssp_data,
+			 struct usbssp_command *command)
+{
+	usbssp_free_container_ctx(usbssp_data, command->in_ctx);
+	kfree(command->completion);
+	kfree(command);
+}
 
 int usbssp_alloc_erst(struct usbssp_udc *usbssp_data,
 		      struct usbssp_ring *evt_ring,
@@ -580,9 +686,83 @@ int usbssp_alloc_erst(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+void usbssp_free_erst(struct usbssp_udc *usbssp_data, struct usbssp_erst *erst)
+{
+	size_t size;
+	struct device *dev = usbssp_data->dev;
+
+	size = sizeof(struct usbssp_erst_entry) * (erst->num_entries);
+	if (erst->entries)
+		dma_free_coherent(dev, size, erst->entries,
+				erst->erst_dma_addr);
+	erst->entries = NULL;
+}
+
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data)
 {
-	/*TODO: implements functions*/
+	struct device *dev = usbssp_data->dev;
+	int num_ports;
+
+	cancel_delayed_work_sync(&usbssp_data->cmd_timer);
+	cancel_work_sync(&usbssp_data->bottom_irq);
+
+	/* Free the Event Ring Segment Table and the actual Event Ring */
+	usbssp_free_erst(usbssp_data, &usbssp_data->erst);
+
+	if (usbssp_data->event_ring)
+		usbssp_ring_free(usbssp_data, usbssp_data->event_ring);
+	usbssp_data->event_ring = NULL;
+	usbssp_dbg_trace(usbssp_data,
+			trace_usbssp_dbg_init, "Freed event ring");
+
+	if (usbssp_data->cmd_ring)
+		usbssp_ring_free(usbssp_data, usbssp_data->cmd_ring);
+	usbssp_data->cmd_ring = NULL;
+	usbssp_dbg_trace(usbssp_data,
+			trace_usbssp_dbg_init, "Freed command ring");
+	usbssp_cleanup_command_queue(usbssp_data);
+
+	num_ports = HCS_MAX_PORTS(usbssp_data->hcs_params1);
+
+	usbssp_free_priv_device(usbssp_data);
+
+	dma_pool_destroy(usbssp_data->segment_pool);
+	usbssp_data->segment_pool = NULL;
+	usbssp_dbg_trace(usbssp_data,
+			trace_usbssp_dbg_init, "Freed segment pool");
+	dma_pool_destroy(usbssp_data->device_pool);
+	usbssp_data->device_pool = NULL;
+	usbssp_dbg_trace(usbssp_data,
+			trace_usbssp_dbg_init, "Freed device context pool");
+	dma_pool_destroy(usbssp_data->small_streams_pool);
+	usbssp_data->small_streams_pool = NULL;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Freed small stream array pool");
+
+	dma_pool_destroy(usbssp_data->medium_streams_pool);
+	usbssp_data->medium_streams_pool = NULL;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Freed medium stream array pool");
+
+	if (usbssp_data->dcbaa)
+		dma_free_coherent(dev, sizeof(*usbssp_data->dcbaa),
+				usbssp_data->dcbaa, usbssp_data->dcbaa->dma);
+
+	usbssp_data->dcbaa = NULL;
+
+	usbssp_data->cmd_ring_reserved_trbs = 0;
+	usbssp_data->num_usb2_ports = 0;
+	usbssp_data->num_usb3_ports = 0;
+	usbssp_data->num_active_eps = 0;
+	kfree(usbssp_data->port_array);
+	kfree(usbssp_data->ext_caps);
+	usbssp_data->usb2_ports = NULL;
+	usbssp_data->usb3_ports = NULL;
+	usbssp_data->port_array = NULL;
+	usbssp_data->ext_caps = NULL;
+
+	usbssp_data->page_size = 0;
+	usbssp_data->page_shift = 0;
 }
 
 
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 69cf478c222b..7c4b6b7b7b0a 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -52,3 +52,24 @@ void usbssp_handle_command_timeout(struct work_struct *work)
 {
 	/*TODO: implements function*/
 }
+
+static void usbssp_complete_del_and_free_cmd(struct usbssp_command *cmd,
+					     u32 status)
+{
+	list_del(&cmd->cmd_list);
+
+	if (cmd->completion) {
+		cmd->status = status;
+		complete(cmd->completion);
+	} else {
+		kfree(cmd);
+	}
+}
+
+void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_command *cur_cmd, *tmp_cmd;
+
+	list_for_each_entry_safe(cur_cmd, tmp_cmd, &usbssp_data->cmd_list, cmd_list)
+		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
+}
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 534fb75740f7..915983bc400f 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -363,8 +363,7 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
 	/*TODO add implementation of usbssp_reset function*/
 	//usbssp_reset(usbssp_data);
 	usbssp_reset(usbssp_data);
-	/*TODO add implementation of freeing memory*/
-	//usbssp_mem_cleanup(usbssp_data);
+	usbssp_mem_cleanup(usbssp_data);
 err3:
 	return ret;
 }
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 4a9a1ca2e9b5..9dba86a0274a 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1685,6 +1685,15 @@ void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 /* USBSSP memory management */
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
+
+void usbssp_free_command(struct usbssp_udc *usbssp_data,
+			struct usbssp_command *command);
+
+struct usbssp_container_ctx *usbssp_alloc_container_ctx(
+			struct usbssp_udc *usbssp_data,
+			int type, gfp_t flags);
+void usbssp_free_container_ctx(struct usbssp_udc *usbssp_data,
+			struct usbssp_container_ctx *ctx);
 /* USBSSP Device controller glue */
 void usbssp_bottom_irq(struct work_struct *work);
 int usbssp_init(struct usbssp_udc *usbssp_data);
@@ -1704,6 +1713,7 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 				union usbssp_trb *trb);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
+void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
 /* USBSSP gadget interface*/
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
-- 
2.17.1

