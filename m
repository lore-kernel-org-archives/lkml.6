Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bT9fAzchGVv0OgAAmS7hNA
	; Thu, 07 Jun 2018 12:12:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 95D1D608B8; Thu,  7 Jun 2018 12:12:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fpFUbGPk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1F6C5608B8;
	Thu,  7 Jun 2018 12:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F6C5608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeFGMMP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:12:15 -0400
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:4650
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752972AbeFGMML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPC//pb694LzxMhg01NYoo8BrzX2DCPKfT4UO7ptpws=;
 b=fpFUbGPkSZj72s+fgu3Suiln8U2GYrh1HgTkW63lroIKFZx+NqyDZzJnEZ+Q0tzYMyviF2lrTcQpwI1IyKqoYUuoEGRqqIbXmpU1y8MoT1HXGV9c3QOWaxQWgrmYKlszsmc69Xx3XfFUduesT/m2nI+Nt/sWKIqkcGr9o0BN/ng=
Received: from DM6PR02CA0028.namprd02.prod.outlook.com (2603:10b6:5:1c::41) by
 BN6PR02MB2354.namprd02.prod.outlook.com (2603:10b6:404:2a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 7 Jun 2018 12:12:09 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by DM6PR02CA0028.outlook.office365.com
 (2603:10b6:5:1c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.14 via Frontend
 Transport; Thu, 7 Jun 2018 12:12:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.841.10
 via Frontend Transport; Thu, 7 Jun 2018 12:12:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fQtlv-0006Lj-KB; Thu, 07 Jun 2018 05:12:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fQtlq-0001FQ-GZ; Thu, 07 Jun 2018 05:12:02 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w57CBuS6006539;
        Thu, 7 Jun 2018 05:11:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fQtlk-0001EO-4B; Thu, 07 Jun 2018 05:11:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 4256D1214C7; Thu,  7 Jun 2018 17:41:55 +0530 (IST)
From: Manish Narani <manish.narani@xilinx.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>, <mdf@kernel.org>,
        <stefan.krsmanovic@aggios.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, <ulf.hansson@linaro.org>
CC: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 1/3] arm64: zynqmp: dt: Add support for setting SD tap delays
Date: Thu, 7 Jun 2018 17:41:38 +0530
Message-ID: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(36756003)(186003)(103686004)(107886003)(6266002)(478600001)(72206003)(44832011)(50466002)(52956003)(2616005)(486006)(90966002)(48376002)(26005)(426003)(476003)(2906002)(2201001)(126002)(36386004)(7416002)(106002)(5660300001)(51416003)(81156014)(5890100001)(356003)(6666003)(8936002)(8746002)(63266004)(8676002)(106466001)(59450400001)(81166006)(4326008)(42186006)(336012)(110136005)(305945005)(316002)(50226002)(47776003)(107986001)(921003)(1121003)(2101003)(83996005)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2354;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT004;1:DzPQlZpYit8u/+nOi305ImyAA5T1GDuJkz64wWMoeIQuh19Xh4lclCNQYtzSTltEk3ID/GQNr0b4g3seI1WzSaTalVXcy5DqqniYIP5S+A6ejrbavYWPeHezV7++OJbw
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2354;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2354;3:8xXKazpk3b2MEypXo1IDthxGgfutpeXcOWQqF4seorUE+vnqTWDAM6JnwGOW38f/p+Dodj3RWDD6BqgfAgiBBuxvfz5vwY7+8siLZqSHtO1gWRegB1zOM9tkvEnlkXmKPAZIA1q3hhVRjrmo+Q5FFNR0akmZiXC66mFUoJG1UpDfUtnXuQTJxxaHNIRKPu4Zh06zSqqGai7upOi71T0xp+aX4tit6xGJ57jrGN2C2lv1Gdr55hF+HvNshUXt1pbkSf9WuZa0C7Fqlhwo31h+xTGIrtIimzwoLMoW1NfFB27LeBXmuaX2RwjHOMp4gdDppKznvMpKgAy0kigsKlfTWMVvjoh5ONQfnP3HGTCNHM4=;25:q2Lp+SaQG+TAV8mZrGbgaqAgXqjsSjo6NljTLu3Qw1JEyiJ9dqaRwnkWuzkaUnvs0Ed7K6KYNndu4gPqGBWgxCjrNEO5O8KV9lPZ17fH5o7MDrwMVQbtswp0JGG52EHRSApNHnarABgyXtBJecvOtAMr3TSJnvftI3g8hYprw++Qfpm6hPw7E37Gru7bTlApHz3iFzAo1dba16usuDh5THAtD5kd1w+DzGLlixyJMLyH7wFXlm1kZQ+yeU3UGOu3H5cqwEubNAtWqhA80w0u99mCJEb+dao0CKBHrC3Dqab8auYb6jObV24aD9DhbCzTlsiGsMgDc/kCrOUgSIGXXA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2354:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2354;31:YQhtk7Kj6Hbjj3lOcyseXogh4eRBA+dY9Kuo5uuuoH1fb1j+dqBIevbwR37qx82PjnmU3LTsBEo7Wrb9fisVJpz4Mxrg4drXtWkpVZMCzhpM5myVveESBkGxdbwT6lDhdV8vdGULo9tyKhfKhY3trfQLCcfn5ehnSGBkQn0mLamZ9ZsexcgRJTTOUwJvYr6gw5PwRVt8F1Kbd37D5t20lF1ODsLuUxxArCebZa4m2zg=;20:r5G3lZOIDmj5y02a49xJ+494fcrW+5KJPhyNGAmKmBgYrG1EqNkncUT9Y011wF1AcWkijsmPLDQ+m7BqoqA/4PU6W/UIofbjcFTIMEI78dEqm0agRUk8OaP6j7gd44l6ftZ+IKOJhGnJx6bY75x0UWAjwgv1OZ8g/KT5umRCUQe0l5IO+trB19dfDdioR6RttVSzHOn9cz+BWU6P1SceeR7rUOOG1J0BqEaTB3DgIR2XGFB9fq+GuDVj5E0XLF8N7cQbwZ7ieJEmjluJ5yuO9AwnuvYiv8SNMuT5yBz+QAX6XybrbterOJ0VLHi+dp/96OdOM0HWOCRKPsFYSpiP6yaBR0ZuYN5Ylt0BYzg6ZIPhl7sTdhBbYtIOv6wpJ5n6Y840eIDD17VTPbPvrl1ZMcXL42ega2/Zn6L1fXLMFIwAvd6ieMiOOh7W4CGKJ7K6JyxopFIaDEAIx5b8zkj2SFnAETgKWITsfBj6ehqrhbwPNdfDZ9K/ZF8A5a7Cu2PV
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB23543B0D238465EA790D5BEFC1640@BN6PR02MB2354.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR02MB2354;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2354;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2354;4:QhoKM7yGTp4tXaT+mwP2akPuE03NNV4Fg4hXT+tuJDin25Ka9rGpcCu+MIGF+JK7ZcyB0ekQY47SENRUS9KXOO4v/8eQfoSHtiwBLaRATLQnYq5pGj423BzyaegTCwc3+JFiVFovT0duP+lX82DHPt1XLCGluwUA82HO89Zf2loKZw+Re89Uq1chCS5QuXqWYH3Zwz2KPnIRiDuaUeCyAe2adkC8nQod7gjE0iBp4kddFBHs7GwujHZR31XdqPY1qDm3V5gH5tuHQmw9SY5yrO4qkHeP8sVgdkG47gGVzlQJhRKk7FxeJRu2qlHnYAgvsh+n68BDPVXIvGUKtEQdbq8yOjMTnQ95gBgmc+xK2pA=
X-Forefront-PRVS: 06968FD8C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2354;23:S1wkNI3juFmnv9GoX2Q5kXLsFmKA31YjRzNOcl02z?=
 =?us-ascii?Q?ftLenmlCP4ST5TFm05sjPqIoxB3AJBICR5Sv3dJ/vVLht52h+YTmmM8sv+BQ?=
 =?us-ascii?Q?Y23Cyk92aDH4MgIqvecFkeEeoVDkQzxy3Tl6vrMlrt68fTv2eAYrdUgFXav2?=
 =?us-ascii?Q?Y8+60BHmWFQESL3tzIYbWlpwVNCQqCUlE34P41UlGAP/Wt19aKyKx12x7p1I?=
 =?us-ascii?Q?1uelzrMb+f6IG3rsbTXGtiob8GzAXMszi0Q8jFj2YxHdleEWqoo3XyxtiIuw?=
 =?us-ascii?Q?Y3hWE2fk7WFq9q9HXJySSnVcU2JzzsZSlGdMuBbAdyO0fQcV+LcJeYj5zzb3?=
 =?us-ascii?Q?7bYt89M8ddhlpNWDVqFLEEXuV1INm2MTb1mDpOcDaGU083tRvRUEUtws0XP4?=
 =?us-ascii?Q?bzoMndPaM01w98uNCBZm6YYktC6UfI954q9drhS5SRg2/kuho3NPCrfny/EL?=
 =?us-ascii?Q?oek7I3wB9g+yGmPBbrswVNJD8AnIDmSr3+KDof96YmMzMoPg+dwA2NSTA4wC?=
 =?us-ascii?Q?88JvgiMA+NeRnZecsJtvKU995YGXlwoP96GiScV9kwZvtwQMGvX61N2PWEEf?=
 =?us-ascii?Q?ViHKTcyaOpDrOTHy7oEyOdfSZiGx59IZK+VfuSWPXXQefvbiQX3rAODRwanK?=
 =?us-ascii?Q?Ym4i8GF7OYaft+Ri+oaJvNGajJnmnEZzxs4nnh8Xx8cfEgprNfg0Do915v/6?=
 =?us-ascii?Q?Eui01Siy335lySHAoPFB+kOdAEZosaEZnAq5fmxIrcRUVC79rlD2Go+RruVo?=
 =?us-ascii?Q?6dBdLxaHuC6u7jiqma9c0m5KginriIPIIfXuikNd4tZlsnQUhGTzvvFUUA/x?=
 =?us-ascii?Q?gAn+2ABSQ8FxkBmou3UWZdhGEuM7H8RWVvbJcpov58lZ+wWaTtuuGvnMfjQM?=
 =?us-ascii?Q?sco3GDTB8jdmunx0sd4+U1oOwhQXVlUc5cTRATplP7Tz3sWev0KIih8nb3wi?=
 =?us-ascii?Q?gAWyuRQl0KzclEuZgA82+CkzU7MQ7qHZVVP9GB00B6v0Wr2q32m22+UHWawR?=
 =?us-ascii?Q?pPYy0rwSqmmkHBbwySOjPDY6Y5Kczi8Q9dJMkKoQT41aBLuc0ua+3Xiq6zvJ?=
 =?us-ascii?Q?ND4mb+X/dIOK49/HLDquhq0hdgYbVAFaBTJmB3URIQumiocqaB6hrT/bg961?=
 =?us-ascii?Q?DGjS9HFp928A+T4WpBe/j9SaoHKLE648qp5QNQRZRtvJqswnu5wW8SG6Inen?=
 =?us-ascii?Q?VrMljiNEz8nOXp4seyqU/K5zgNxJqTrZ4MkEMvZuzM6mpMq4q8G/v08+m3yM?=
 =?us-ascii?Q?rfQpgfWuxI755VehhFpYlEjUMJHQyjTyGTB3lHC4woA3KRkzJBy3X75k5MUV?=
 =?us-ascii?Q?8M++MraMcwgOJwQwqkBkRU=3D?=
X-Microsoft-Antispam-Message-Info: W43Qj83ROah5PU2zJO4bTwjN0B4K2XpwDryjp5ns0cz2wIAimOj4gk639/axrpHUcGbhBxXEUsrliUO0vBNAh7ZafA3UZAf/wc3Vi/BNCFdKB7f8n/yoG5D5Jt62Jz71jg2UZw8jA3OT6SXEb6ZUuDASEamm3S+KC2EogoG5duHz5OZiYqdO6II+HFo9mFcL
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2354;6:5Ulg2RNFyCLCad/SZq7nJQernXCzi/Remnit2KJs22D0xzvkHFa/hMQ6E81BIi+We9A76YsadSzVQRUxj/Rll33wmVb/2pRQloFgsJPFznaCLBVdYeZ+fGnLb0WyckPvUsrx3c7azv4+z+4UI3fBVagIir2Z+lFcV2b4NdZbeUVnOYnuC7D2LyR7lZ+/c/P1V8LzGyUrWEEOHH3rNDWx6TZMUFCcQmE4h2tJeSl7hba3EajYnG2uc/Y/Y674toi9AAabgvZaRn5OcElLXZR9jgwSl/1Xdjyde4Qya958xMXqJ0C+zRle+4e9xnW1SXAfQW68miJZUJnUpKsYSuGzQTQbGUkWcX/JeEZYXq9cIXbuTamhcFid1HEbcmo7NrbmOdlijt0/vgY1t9TGlKvPkldBhqhhI5SIHtYX60YQHUxuJwMXqkwEAgongV5Dsn0p57baIgdVyIQqLEQHw8V/SQ==;5:/qVVrqpWHPPK3YGnN3I/K0DyJV6zYxZ0t5Us2xPvDD3zBuIjp+ySAwQT76w/YZuLVkrgiodRNWYmZY+RFPMhK+xzF1dK68ibsHJxcEk/Ydlm0/oXKY4GU+OpJAOLL+ADkO0A3pbEfAEjXvsUmW3qXV+pIk3nUGmbEHfjQUTR2pY=;24:ZgoNh6bS7U0hpMrs9J14jAl2j2VdC9aFVvEY05xuNJj6jMCRqB5n2S2YubMmCpSs45KHhvc4mFl7Fb6fLEUGvpRpK6F47IZSkqD0QY6DvuA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2354;7:jIVyYq4Z4CNFimbDAw3SIb2ZnVjB4/j5D4da+PD0WYJkIlBQeGIX0jqiiL2EjtApqWtNXjWHEGuHw3coUX8dGzzLj1nfF2BdurO/RIVblOV5ZXcE//krGZ2jHIlschTqIepawxkH5sJ/HvWNlt1u7hk00MzMKKW/CYMHPHPRKTcZpFJ3LHa7QUsmC/TeNWaxW32c810vnLNP8eHZXtE23ktxnMBW3dLkLIWJeA0sN9SlF+YSX37rB0tqRZqrNuT4
X-MS-Office365-Filtering-Correlation-Id: 2898003c-7bb6-44d2-fb5c-08d5cc6fe433
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 12:12:07.9997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2898003c-7bb6-44d2-fb5c-08d5cc6fe433
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for setting SD tap delays from Device Tree.
Earlier, these tap values were made static via macros in the driver.
So changing the tap values in the device tree makes the driver free
from handling different tap values inside it.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 40 ++++++++++++++++++++++++++++++=
++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/x=
ilinx/zynqmp.dtsi
index a091e6f..696aac8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -491,6 +491,26 @@
                        interrupts =3D <0 48 4>;
                        reg =3D <0x0 0xff160000 0x0 0x1000>;
                        clock-names =3D "clk_xin", "clk_ahb";
+                       xlnx,itap_delay_sd_hsd =3D <0x15>;
+                       xlnx,otap_delay_sd_hsd =3D <0x5>;
+                       xlnx,itap_delay_sdr25 =3D <0x15>;
+                       xlnx,otap_delay_sdr25 =3D <0x5>;
+                       xlnx,itap_delay_sdr50 =3D <0>;
+                       xlnx,otap_delay_sdr50 =3D <0x3>;
+                       xlnx,itap_delay_sd_ddr50 =3D <0x3D>;
+                       xlnx,otap_delay_sd_ddr50 =3D <0x4>;
+                       xlnx,itap_delay_mmc_hsd =3D <0x15>;
+                       xlnx,otap_delay_mmc_hsd =3D <0x6>;
+                       xlnx,itap_delay_mmc_ddr50 =3D <0x12>;
+                       xlnx,otap_delay_mmc_ddr50 =3D <0x6>;
+                       xlnx,itap_delay_sdr104_b0 =3D <0>;
+                       xlnx,otap_delay_sdr104_b0 =3D <0x3>;
+                       xlnx,itap_delay_sdr104_b2 =3D <0>;
+                       xlnx,otap_delay_sdr104_b2 =3D <0x2>;
+                       xlnx,itap_delay_mmc_hs200_b0 =3D <0>;
+                       xlnx,otap_delay_mmc_hs200_b0 =3D <0x3>;
+                       xlnx,itap_delay_mmc_hs200_b2 =3D <0>;
+                       xlnx,otap_delay_mmc_hs200_b2 =3D <0x2>;
                };

                sdhci1: sdhci@ff170000 {
@@ -500,6 +520,26 @@
                        interrupts =3D <0 49 4>;
                        reg =3D <0x0 0xff170000 0x0 0x1000>;
                        clock-names =3D "clk_xin", "clk_ahb";
+                       xlnx,itap_delay_sd_hsd =3D <0x15>;
+                       xlnx,otap_delay_sd_hsd =3D <0x5>;
+                       xlnx,itap_delay_sdr25 =3D <0x15>;
+                       xlnx,otap_delay_sdr25 =3D <0x5>;
+                       xlnx,itap_delay_sdr50 =3D <0>;
+                       xlnx,otap_delay_sdr50 =3D <0x3>;
+                       xlnx,itap_delay_sd_ddr50 =3D <0x3D>;
+                       xlnx,otap_delay_sd_ddr50 =3D <0x4>;
+                       xlnx,itap_delay_mmc_hsd =3D <0x15>;
+                       xlnx,otap_delay_mmc_hsd =3D <0x6>;
+                       xlnx,itap_delay_mmc_ddr50 =3D <0x12>;
+                       xlnx,otap_delay_mmc_ddr50 =3D <0x6>;
+                       xlnx,itap_delay_sdr104_b0 =3D <0>;
+                       xlnx,otap_delay_sdr104_b0 =3D <0x3>;
+                       xlnx,itap_delay_sdr104_b2 =3D <0>;
+                       xlnx,otap_delay_sdr104_b2 =3D <0x2>;
+                       xlnx,itap_delay_mmc_hs200_b0 =3D <0>;
+                       xlnx,otap_delay_mmc_hs200_b0 =3D <0x3>;
+                       xlnx,itap_delay_mmc_hs200_b2 =3D <0>;
+                       xlnx,otap_delay_mmc_hs200_b2 =3D <0x2>;
                };

                smmu: smmu@fd800000 {
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
