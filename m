Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EBD21852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="CiZCCDjy";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CxmtwTXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfA2QLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:11:23 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54082 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727246AbfA2QLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:11:22 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TG3qFr011852;
        Tue, 29 Jan 2019 08:11:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=dfRplkXefM/jteoLrzUWB6081VwjJvZ4gcJQE2eDMDw=;
 b=CiZCCDjyDDpSyqUPThI5K7bWReQ1oS+DlcblhvbFXfnozIZcmadPaD+IEYS+3CjHTrax
 01Ip+lkjvigmPA/otk81WEdSGM5dhYO1WRjBB9WP6HNBgmv9QwvCdPXdN9/Qbgyql7Qp
 1Yuf1yQdW8PzzL6D/bzzyq0KvQGRcH1MswZ6ObmGalpnvuKTrbx53TwGfHVoBXjO4ReC
 RYISEXzs1s95651nXylAzpqc1sXOjTBPW5gWtXL9LJ3YNSXhX3bZ/mR/XKUKovshqYrg
 cfAgs9phLhzC3NvRnbo0sA8dJJFZu0gg6PZi8+ptyiAwscI0SsuQRQpJzWFkNDv2BXi4 ng== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qa81749sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Jan 2019 08:11:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfRplkXefM/jteoLrzUWB6081VwjJvZ4gcJQE2eDMDw=;
 b=CxmtwTXlcdPGli6/YtW0lIFfB6GPk9YcYF4+sLHo8RqajM+lMgWmxbQ7jRFGfliRYyRsY05WFDKjgQkGbXJlke45zjju/8pS01qnwaQj6S1TRnRMsXCt8nbs1/rkLdEAIjeb21KAwufM4JV5SPZHxW+UhUm6ctG4zSU0KqlHssA=
Received: from BYAPR07CA0055.namprd07.prod.outlook.com (2603:10b6:a03:60::32)
 by SN1PR07MB2255.namprd07.prod.outlook.com (2a01:111:e400:c456::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Tue, 29 Jan
 2019 16:11:04 +0000
Received: from BY2NAM05FT047.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::204) by BYAPR07CA0055.outlook.office365.com
 (2603:10b6:a03:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.17 via Frontend
 Transport; Tue, 29 Jan 2019 16:11:03 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT047.mail.protection.outlook.com (10.152.100.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Tue, 29 Jan 2019 16:11:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0TGAuAe007778
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Jan 2019 11:10:58 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 29 Jan 2019 17:10:55 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 29 Jan 2019 17:10:55 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x0TGAtbc021268;
        Tue, 29 Jan 2019 16:10:55 GMT
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x0TGAtgf021170;
        Tue, 29 Jan 2019 16:10:55 GMT
From:   Piotr Sroka <piotrs@cadence.com>
To:     <linux-kernel@vger.kernel.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Piotr Sroka <piotrs@cadence.com>
Subject: [PATCH 2/2] dt-bindings: nand: Add Cadence NAND controller driver
Date:   Tue, 29 Jan 2019 16:10:40 +0000
Message-ID: <20190129161040.20299-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190129160337.24350-1-piotrs@cadence.com>
References: <20190129160337.24350-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(189003)(199004)(36092001)(1076003)(6916009)(105596002)(11346002)(2351001)(106466001)(107886003)(7416002)(356004)(6666004)(336012)(36756003)(97736004)(2616005)(476003)(126002)(86362001)(2906002)(63370400001)(486006)(50466002)(426003)(48376002)(8936002)(81166006)(81156014)(8676002)(50226002)(39060400002)(4326008)(305945005)(16586007)(446003)(316002)(54906003)(53936002)(42186006)(51416003)(76176011)(478600001)(26826003)(26005)(47776003)(87636003)(69596002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2255;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT047;1:2Zs+dQcoeNfdDHFcNUMejDVDZTIbkGGdZKeht0/BOsRkMXs1wzqBwDhegceV579rUzu0tZK0xS/AaIbOBGsRtyVmiO2UNoVvKWGc4XAExakCk1dNLhxFY3TnJgvVKmv92tdrNVrFqUNlutvmYwcLkw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18a5379f-d4d2-4a62-237e-08d686045d24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:SN1PR07MB2255;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;3:4GPB1ndYQrMLif4dVJuOA7vMxTg9j9LeVeQfZITrn0sYydBQ0ciPQDSDv3EI+VK5De6hpY7OlpCWtej4wEeR2gh3Ar1AeL4hEmv+qp+L6djeiWJiHI7H+rwZDlEo+uUIrlgOFxs35FRitc51UtYjesehWl9wigFeGileiYIctdGmr34zt+pFXRdKMGHcFZ7mCoVbYs7ndpd2O9ZMWbSjWvGDB/pg+0W0X5KoePEa0BkWSRYulw3XR8XAs0Zy9q7/nYghe0CbAhffGuVPhAaZYcMdP5dvQP78mO2bRZhkrMfXiRIDgZRnKFVtYHpwTNjuB32XYAP1xZtZSJ2Gpudspe2umqBQxSEcNPwNow4G4l0VH1YGjK6Ueosv4FRwB7Px;25:E/SaYwVW+yBxoClP/Y7mlTrmgr35AAAi05bg8CQOJ6OtH5WaCsCM9+mMEf06sr9t49yfpiluiVBbYWdQn7NOqylZLEpMGh5XCh51AcxtamZ3WciWiKP0KyFpDkryskow28BIs3O/6oGY4UVSV/74ZGQ+QAr7vMZHFErmTwfD+AE3NljnOMI/XX/azlzChUrKc2rLIrgX84yzBlkuWmmdkE90RJ57hwZyn1kNFyT8Q1ApAY1zK8NSt5EzG/Z86hL+Cds1H+gEw8UWmGb1vn4RRMI1jySvHgZzmeDHUT+IEOK6unb2I2L2raLQP03hW/AVCIH/5RBM+m3c/Ox29ilnuA==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2255:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;31:nYcmbcVIDQysV54YG3/Hir7MUMtizour60TmtLD3HuTAhr288mUy1rrwE9OV65c3SHv7EM1Z7gToDsQ+Kcyf/xL97jMnei2Fek+txgvzM8LeIjVlkiX0jcYLlvh4KKjZQ34V1NJOEBqFMpsIZQbePEBRZVlMHVhVlGBM96tQUgQrQOVJJS/JGBR3ImS6X/twtipm9MgdCV5XwT5Jch7PZowk1cbMNVW9a52nTgH5Nh8=;20:kjJ+cnOSjFHHeP45LIdqNbupUvCSfapFLHoUpa8z2wRLzsetrFmSpBYnteDKvEuMci6vbpGgJCjiB9UZmOCZEFzWFwTJGNVeDYDJahSYDS2YFvM3TMxUdowFxlLjZqeIExu2XG91SVMCPhwpY/9ssNXeoEEBsTft5UFSeBoNk5LB4KPiXAxrGZOFoPgs/rtiwuT1PpR9XgJWUcoRkijrNseLiptlU9GN+QExI5DBa1NJGedABtBInOKbV6Qafyfu4n1IajeGrUtmOHaY4N09nDauuuBOuEtv865fJ57ujSF6QTeRJUsLCkjLw6IrRBBgIrF4SKK22cgojIwJh5yHiVkmtBrqsvB5jFNy+3T86/Zd4h3gSLXA1GRStXlzJUoG1L/PUf3wWPOANSPfO4C5omMN/cuepX9Mckjg6w3oBRXjZxqOVaFutew2BEN9MXUc6gKj1kef6bEZQ31Rh4j4G1FzxA7S+mmZItrVKfzXgiZNO0iel+XOdbO3W7iS9OlG
X-Microsoft-Antispam-PRVS: <SN1PR07MB22557A1F309096F408F3BAF0DD970@SN1PR07MB2255.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;4:B3VkRdFiqWaMhOH1YqOGHlAIjgJvGtl9fBzuGF7Yrzg+oo0Kpbdx8QEujU6hD5+g8SoUUIiPSHvHiStmZCocrPKoa9pxSBOFUMzc+WtFGSR1f23ALMiomF8BrHVg8gSD8DVweSJrkrf4uRqVM4fQU1aN/7TPywsahZCEqiBINgyTtaEFPzESstUTsMpm4hXj++EtT3ghxOVTF0C0L3NPHV+wSjRhYa42Byt774Kt6p/6KbApyx41SGvmQNYrtLtdrNE6yyi7drc7hfgcFCzIBSzNXO4n6+YvliQkSFPyCO8=
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2255;23:xDmu+reXKvl22qP1SZaYmBbrSpXPiBVUbHI/DXf8J?=
 =?us-ascii?Q?++MJnjkTEKSfAGZQXnRlF7M/5LrCgQYQ8SyPmRfGS2h9rZIklWroIbbHLjLc?=
 =?us-ascii?Q?DbZW87P6J3uOh2jYU0HxF8+LFzMlbfa1e5vHFsrL1JzMIW+WDE23qSARY/aU?=
 =?us-ascii?Q?Nvuo7xED9TU/M01IqeUWSHsTdgsh55m5imuvDdYAAYtHdIcrTspvNSpgUpdI?=
 =?us-ascii?Q?4PFT6v0bD4nJ1Gnp2pkoYojrgXuNycjJ7mGZSEbHDmBhzRoHqRemjGx5C/od?=
 =?us-ascii?Q?SC8eRZFGcLHGpBuVjS2HvFr5K6VAOi4SFIXpHnnDpAuML9WjVupV4AAOWdCZ?=
 =?us-ascii?Q?UFyseTBK7z0P8rOjeizWEdIg3csVBKplPbmldc6ljpukbqvfpFszzqoJ3V+Y?=
 =?us-ascii?Q?URrKHq6PiuGAkToo/SrDZeZYBcq2fyRLO0oVdwT2nOFf8fUMrH/Rd8kFXUmi?=
 =?us-ascii?Q?dU4M9XDFOjLpRrESk0Lq65BkmiG3tgJUusaz/tMXr45DzTvnlTPgMRFNAZPQ?=
 =?us-ascii?Q?qrmJZX8PH9oOhWR85zM+WhYiW5OQUFo7d5nauxL5O8EL++LrYBhvcDaLuaqt?=
 =?us-ascii?Q?u96tbnnVyDWOH0YLbhNCMSNyc319t/Cqe4/BXWgJTmTbbsAXAoOShoV38tc3?=
 =?us-ascii?Q?AIlmUmygYR/f4UvVwqf+llwpHeAFAucEjLkiAKeXc+UmEFhlnvbNOjZ3gsvN?=
 =?us-ascii?Q?guQWOopE39BzJlN8osaPWJeZeRmhsSc4rb9LhiQKcGxKnLl1TZdcck79rwTg?=
 =?us-ascii?Q?pybwYRiwLlDtbGvQiS96pWv6n41Nr5KLNQE8JZ187TGnQDoUUDyqs0ijSJwJ?=
 =?us-ascii?Q?TJQt/XqO9q8ROex0Pwms+cQdw21Bos2FidT7EVXK+oLdchyeQ1zbvCFGT+DU?=
 =?us-ascii?Q?u6XCCXNN/LGMM4L4Yv4WEFWwdFBO8Tkh3FzTLUBIpg47y8gwNFbb8g+jd+yr?=
 =?us-ascii?Q?u6YMts3Hr+qZefBqODul+B9T9zEAAoWVfOTmnVOQGAg2NTaW53T9OhcBfqkZ?=
 =?us-ascii?Q?wg4VGXt/GnVFUonSl4YDrxDFBNmiDeEKysQl4BibcUHaApP+5LH50ASiYNMW?=
 =?us-ascii?Q?2DoMBgr/yr7/HGMeAciBs+i9PTHddDscqQDCZwMvYiZouMd5/OuKav6YBYnF?=
 =?us-ascii?Q?Ct/fM/9UFAi4i8+VzVLdm9HfBc2nAIjCauslvZId3tgda4wFG8eMhlNoRgZe?=
 =?us-ascii?Q?Ohxgg92Oy9fACVg+0Gttk6XjQiog8HAaRn5WA0E5WVcEWIPt8lDKJvt5g=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lY5xBwzGknaJyV2Fr4YXVmOaetMywVCqnGuGtuAfBJtsziK04oP941PDMxwC6FHXSsAACqlSKbNAxmKcrdocxtFNa2sOLtGv/Nd+O8QF1pxnyYD5IQ0fjEBvLD3RwgPPuvxpR2zpFRqBla7+nl6RLEkf/rwp5ogGDPPPFmKLlrQ2zecRmBQVHqa9q9eNdIikk20CLsNEeOLMx5RlY7IDdEjW8lcbGOGLtXRaNK4q05dxqDP3pKW55+Tsl9i/kMAabHuUWxzLgVGTFGTRen+FP8cY0PZlulFl43r+NcGcKzoshTT3ojl5zT2TDTBSlE+peqKHuSUVJXrAurueJGWQibaglGds4Ubcf849dBT5soX+40ygDD6DZFbT9NgjrboWhdnvgM1cThx+Z0ACvOJNxTOEiBc20OVrJiWmrcg6lgE=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;6:ohQ46NavDPPZvklzKxBKlDCWFPzdrF0sz9ur9fr3syEKapL/1SzECYZ8Q5gtFmI/HZ7prR4fUyxdrj5sFRHVQ0xakCNUFsWFXWpEK2qFkozfBtZDAHlm5f5z2eoxx/EyHAazvoYfHbtBH9uzbtHV1b9dzTACHyqZdjDCD4gyXU+i/gW3SLmddtxpHS4GmVOUrlQZxvsfjYsSI5rDhjzkvmOaTTNBrC9Is96kGd7pQW9EbWDu8d8h9hovPCZddkQPXlXiYf6/Z/EWPMJbbwlgXaKROkl0gRia3EVLTCcc8yfu98M3qGOVFjnp9jNXIa02QD2QkPm5GXaejD2R0LWtG5OjKC3Ow5b6BtfAOozeLVVODYH2LXMZBWDwGWkUtr23esg9NljM92kk4aCnvw9vv/KUrKOroSv1TmNY+WZ6EBtwsPSSVIQcqSeJJDhstgo+M1U87tBdF5yTCecqwnWBHg==;5:+liPymEBhCxer1vAvjRnOSlnLaGQckL6kpOOGYsoPOXrKLGPgahKISolGWCHlg/SM7CblSqYTt/zactMJ1HWqPk/mggHbDIgypLAwX4V6YrxngqEQ5gKxveWtaeXWv7hrDP4BCpL5hz61lUEcFKFH22G/OyFhX9pP2g3Pn7RH31sH7ICiSuygUzj+QrIyTV/VBwUyhAbst7YqIAlPvLJEg==;7:RAjaBxgGYx1PIG4i2yohTezC/S+y0aU3FrXS4+EIxe4IHgFs2e0KrWP7/iayccaFfaM0EPVgVureCeoxkn0UlLjB74sCRn0QD4KLffrFVzyNhSc5mThcXlCU5T+KskG5MYfmus2AC5HD9o/69CaR8g==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;20:KqvzKh7UssVOEyKUVnjxdLCNDpTL98Vs4M5UF1OXHtXvc4bUfMbtSzpP+URELl4G7M7c/YR8HdRqCpFnzosdpTD8akTeHIcL44DCrDJUvk3K8Ft03sVQ/kH7HwVElAItLzfgmm7r7razAGJjvhBj1rDPQDjEYL/8HD4L6LDDseGudX1uNCEN9lvvG/xb0SgxFIhAZoaD3VL3PuS4Ukd+mkOmT6CYySYSOUXwnEXx5+hrY4vKSfDTKSIs6TxMmx9N
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 16:11:01.7622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a5379f-d4d2-4a62-237e-08d686045d24
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2255
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=643 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
 .../devicetree/bindings/mtd/cadence-nand.txt       | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand.txt b/Documentation/devicetree/bindings/mtd/cadence-nand.txt
new file mode 100644
index 000000000000..82afa34d5652
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cadence-nand.txt
@@ -0,0 +1,35 @@
+* Cadence NAND controller
+
+Required properties:
+  - compatible : "cdns,hpnfc-nand"
+  - reg : Contains two entries, each of which is a tuple consisting of a
+	  physical address and length. The first entry is the address and
+	  length of the controller register set. The second entry is the
+	  address and length of the Slave DMA data port.
+  - interrupts : The interrupt number.
+  - clocks: phandle of the controller core clock (nf_clk).
+
+Optional properties:
+Driver calculates controller timings base on NAND flash memory timings and
+the following delays in picoseconds.
+  - cdns,if-skew : Skew value of the output signals of the NAND Flash interface
+  - cdns,nand2-delay : Delay value of one NAND2 gate from which
+    the delay element is build
+  - cdns,board-delay : Estimated Board delay. The value includes the total
+    round trip delay for the signals and is used for deciding on values
+    associated with data read capture. The example formula for SDR mode is
+    the following:
+    board_delay = RE#PAD_delay + PCB trace to device + PCB trace from device
+    + DQ PAD delay
+
+Example
+
+nand: nand@60000000 {
+	  compatible = "cdns,hpnfc-nand";
+	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
+	  clocks = <&nf_clk>;
+	  cdns,if-skew = <50>;
+	  cdns,nand2-delay = <37>;
+	  cdns,board-delay = <4830>;
+	  interrupts = <2 0>;
+};
-- 
2.15.0

