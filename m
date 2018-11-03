Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A6CC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789B720843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DuXyFd9v";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jYab1Izr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789B720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeKDDEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:04:40 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40136 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727497AbeKDDEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:37 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3Hmk9m013634;
        Sat, 3 Nov 2018 10:52:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=xX4FkKnTJIKimISUKgzsLGxvPzih6ZVQqRziR54s+VA=;
 b=DuXyFd9v97tPWMmp09zQ+8OV+Zi0XkoM9NqRliVa4Sr84lT4RU6k86Z5j6q3Dp8HS0rF
 TbtX8peEHUQ8umym1vh4hHwelQZksQ0mbYfrZjIsaaoqw4/1fh/R+A9KjSJs7kIV7yNV
 5mwrb9GJHb3c4X+C68cxwit2qNLsOTqvCL93CaedubB7tNzOj/rDh+zYgaKY2jVYvu4P
 AvG3K61AOxOykJLZcGrEtTaI4lbVqXVCwkuE8xgskYEqWw8KrAu/8kT1oI4Q7Oa3xIPt
 Ibw6PnWIz6QSOgHiLeflAaTkAK/lCnublSgTvjUtLRvervDD+kUC1RaPfmY0XLNhUBv8 lg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0015.outbound.protection.outlook.com [216.32.180.15])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9dn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX4FkKnTJIKimISUKgzsLGxvPzih6ZVQqRziR54s+VA=;
 b=jYab1IzrhOymgyygS0MYIbSUre2EaGBoqfA9Rhw4aRTeQRfgbYc+/2FUJ/vhZMYWfW7uIipk4kRzd18yEj8YyhgTO8cCrX5OVv4DgE65rTCbRbrFh2hqmOmdEj8vuwgTLbPrC9AglOsuq3Lvnhv9ILv3PbCChvALNs53j78c4E0=
Received: from DM5PR07CA0025.namprd07.prod.outlook.com (2603:10b6:3:16::11) by
 BYAPR07MB5175.namprd07.prod.outlook.com (2603:10b6:a03:6d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Sat, 3 Nov 2018 17:52:30 +0000
Received: from CO1NAM05FT019.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by DM5PR07CA0025.outlook.office365.com
 (2603:10b6:3:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:30 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT019.mail.protection.outlook.com (10.152.96.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 17:52:29 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqR4F027388
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:33 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:33 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9xC000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:27 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:18 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:18 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqDn1006594;
        Sat, 3 Nov 2018 17:52:13 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqDjc006589;
        Sat, 3 Nov 2018 17:52:13 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 14/14] usb:cdns3: Feature for changing role
Date:   Sat, 3 Nov 2018 17:51:27 +0000
Message-ID: <1541267487-3664-15-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(199004)(189003)(36092001)(87636003)(2906002)(50226002)(8676002)(217873002)(47776003)(246002)(8936002)(36756003)(478600001)(26826003)(107886003)(2351001)(7636002)(106466001)(105596002)(4326008)(6666004)(356004)(305945005)(26005)(186003)(336012)(426003)(54906003)(86362001)(51416003)(14444005)(4720700003)(48376002)(76176011)(5660300001)(446003)(126002)(50466002)(6916009)(476003)(486006)(2616005)(11346002)(16586007)(316002)(42186006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5175;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT019;1:/psv2iC9e+s9FvN0PV+OkWbLLySnI/lt0IWc0JLf1jfhl4uO4Z71T7SGLkRZHoy6P6qGreMioRqPeb1/u15ku41qqi8wydSo48HtznfFkbLLuoze5iMf2xFb3AZlZzAP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93499cfa-7412-48a6-be20-08d641b51fc3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR07MB5175;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;3:d5JV8h4or2kdt12W+ObjDshpyyt0d0Kk3Zh/EJO9H9uDM91MLVMsiEv5TdOeVfoJBaMlCB+B5PHT2VAZZ9LYJpdxrPEPNo8gA5Fp+0ACM4FytZ0Q0j4NNnyAGHbkUCBMeiTxUsqPZO4bif7zLsJh8F/iDrRUjyS+o7vfCMxmsXUlJOi27BU2KPd4ouHXcIkXr+7A3yvDkx5kWTwiQff2vtlk9OpHjPfBGiFwJhyGoQCBJHEJzoh6BDZj8ORkczfSMn8Y2/mrmV9N+rJHA3iRTx+s7NejvW+0Doa55DlMvi70NNglUjtb4VstfKMYjoZIIyxW5Nhtd/W7E0angwF/yekB7WUObcg0bY6rUkS2Eq4=;25:q+hcOcpTYdcG8LZn8Esn4m8gDVYABS3eTdHPy8a4kem6XaUCjysOwEIIKyTiaomoXtnmT5pOyngl3xn7CMh4mJVuOgNCEZyjWsPy6cfe/yms8FnimT2KEB9SYjEFPTN2n4KDWmpMxf7tWYj0T4vR5E2vBtzTflod/QRdmyiEmjqv5fpTmxVWnJUX6QVjzwkP16IPio07omoSsZkVUrQS/2vSQuWc0+zc0Zc7R6/eoqjsa9oZCbjFq1/puT6xHSPV5ja6GPai54D56UIqPOgnxtBckQrVX9MAsEMwit5l+mXZ769zgQyMtdHyNmGnikzdMTxlgNnsatSLdG7r++NwBA==
X-MS-TrafficTypeDiagnostic: BYAPR07MB5175:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;31:hwqPvaeIKVcxyx+QCiuZtQ/nCFsbngVCX/zBzGfa8kPU6vIlghOlsFxQ6m6UWqmwqQKF9/9LqLnVECAsqQrfwbEVcxGuFiBbgCj8+TsDwquG3cZNyTrwo/UeG4xkOffQllpcuzHWLkMsEtzl0BNLpViN1mtgxQ5+ptwCAShj/pIU3H1zKHn38AR3u6+sDbS4dEFa93wpiyF83HYVCNREpoy9xLYZukBWKvObPda4rHk=;20:cQ+AQeD3I9B0CTa5n2dz9+OFpayjHaYyfVJV2cNMJq+9m/j6HGVkRvaH6DIMz9F3WiU8VBSUfQABpM32nj3XJqrSsP0MgAHaSxU0a/Gsg0IPs2CddifYdkwNhHxBZffoW2cMUS3s3cBRKIeRjAd2xjPZ/p+N7lEJXf6XRmz/rE4i4Svx32kufMmuuKFdgAHePR3XH+jK2cxtAUJ7kDcx79o7t+rfNDTRVnkHEBqSIiohNvWcR4cn9+DaFquC0+l2Kk+TBpsrWV4caoNRADnTbk9ku4DrgFeSOtBkgWiPjDlh1Fj4Q7mjbEIHgAp4ul9ZGfpxXdWGoO7fC1G02bP0HWHKlZZTLHklzEKshuNO6tUU2k78tgc7iLcgxMRuU5REd9joPdha02sha2B6wE5yQY5bCrlRVqTGioaUQEWkOpEx3VuEetOyEXLb/gPNoXc67d1P2EHSw4URCszd3EsSFJy87OxIvmEOEha4OBs1iOv/TCRLpbYXfFJCFWqSXtAd
X-Microsoft-Antispam-PRVS: <BYAPR07MB51754D73E0A63210639C3ACEDDC80@BYAPR07MB5175.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5175;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5175;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;4:OaHs/Ed+Tk3tl+F7dXcL0ayqFdJ8bizCfPVdXqbs8M/wEQO32P5/m3aoH4uF9lHCwERFcyN+73g0Cw95QhcDJuVxcvWvya64Z0T6dJuG6zIaUqbaS8cwH3U5kPYVbUE6b8XI6R9wMqFV4OOjTj40odk0OqqPMhEiIMaIF2xPbGikQFzmdUsdhxM/x3r3L8TGPGVaiJdVANra59nor9H5PZdRXAHrKW2ltstd3YjHBTaQlwsgpUEqFD/bHsq6W7CK4e1mH05p940LJ54jVV6gMsSjf+dLD8fpL4SDwD/nFkZKtLjPXFdVPTcWX8nFqSj9
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB5175;23:aTL+Cog9uEd1DpjtKgRAjFY05X70gDZ7YPIP6nP70?=
 =?us-ascii?Q?UvfPKQPp2nwgdoQ51PuYfR4tIES3NY2iECIaxQ0j0jkcAIzfQXpAl35H1mym?=
 =?us-ascii?Q?HZPhUhEQdQMUSDda4XDocg0Gs6nelaaCjBlnakG3s/VVVoO4bQhGV8REEIZ6?=
 =?us-ascii?Q?lqskJaWl01870KDZgdTp9YUuBX0AWBw7Iq9CbEqlohI2B6s6S6XliDS0NwQP?=
 =?us-ascii?Q?YWIcv9EDf57x2J62HpEAruZhsYZHDevv8IIBSbe8nks/iAXjbMGwDWVazpS/?=
 =?us-ascii?Q?YhR1WeGaQXGES3eEisfIKH1iXRuF+W6T2dtMHfP3tnTjKSeFEWc+BM5XWcf2?=
 =?us-ascii?Q?mVH5synjuCATwVezdzYA9FKoJ5+o+LoEhzjeV9Mm2lZrYSisfZ15vtvTMkoP?=
 =?us-ascii?Q?OtXqNDu4VrYMy1QWSx7GkqO+iV4Xp1iaQ8/t22ffoCdlSP3P/2MYQ/uO/ixo?=
 =?us-ascii?Q?fMcO1+ElnF14iXX6Ap8K62wDyNCvr75Rze6VzYpUvbeTfRI6U2kHAdPuash4?=
 =?us-ascii?Q?Qz7usScBJghOIBolvMRLHf19WSi00zHPE8jYk3F+5Vdm4dO3YXa+H7eExaaL?=
 =?us-ascii?Q?mrw8mKWvlB3CW+hGrCBswq5W3fl9Rb1lp65E6KIUe+GoT+xl1jS8JNvkkthB?=
 =?us-ascii?Q?L8m2Oa6HAueMeM+ezqsisY1VSR2nsOIUp6ilYVX49VavKohMxVYEgMQF6PxV?=
 =?us-ascii?Q?/cXJPU1t+cmWqIn5wJkmVO78NwXmKQ0D758703/Xh1m+MGLKIqCTTAjqwKr+?=
 =?us-ascii?Q?9F1fjrnjLWT6kBmZF9qwwDIxuY1xoDhBSJxXWh5XaC+dwPoII6iQsmoymm3v?=
 =?us-ascii?Q?HimoeKK/b8+673GRtmk4G+/On0/artLv6hXvINjd++IcaNPpWVzXuAXQJVrI?=
 =?us-ascii?Q?2sB81Ht682H4pn/sqrBgZA9XdKWheU5KbOzxtHWjDcmm/CEFqGQQfUKra3Pm?=
 =?us-ascii?Q?3Oyqx50oxhxEfdn9SHYYDfVD5rs80PxjIdIyrf9Zn6ckskhhdKwwbQ6/naIs?=
 =?us-ascii?Q?m5ivyjJgHW7HH18xur+eGaXVEKVsyexvmXVr4rxqS2y/zRj4vGT3ZkAVtXts?=
 =?us-ascii?Q?IOZyg9hlJnyWPSqkLjAG4bCu1nUyqAQ6PZuG142BBuMmwFHvsipKNBM9eqbg?=
 =?us-ascii?Q?Y6XG6hEwm0p3vl67u7z9g87lv6XdCIV5gkhpzIYaHIpNXN9NcjMLw=3D=3D?=
X-Microsoft-Antispam-Message-Info: smr1wtFph8hBwrSsML+ZZqYssPFK+/jAWiAkTqzBRRHMxILaKM3cJJE+RZs8y7KWPS54LR5jHvxbMnZ37CqJZFONVJFMm80j6t+3jIFW/SshwKvIntrbsHhAY8RktD1MyzzfyJwRuTuTKeEJuoC+U+AMxJkL6pxFXb+DR0VohvsfBQcazUtEdG1ALI+rIU10dxgfy6vYu6MYA7N5JxXLfvh3O6WDm3IVIIwMB/6syXb9FZPFQ5mnUmBGDwB+iHgeTnUMqR0ttRg3G3tadHrYtPm7daaLiXJwajRqs7dvoF+3B5WGqw/Nm9mXNFqCax/JIzP99WKmZbTQlRbiHzI5l3UDRIJxZIpOJghUOKVdoSw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;6:B4Rg55HN5IQ8/4rLGiz85SHjaVsVpKN8KMmvEzyvrPmcgIixAaanavVyaJqFagZIMVBqbkNrFz/UqIVHO/Kw8vuXdaEsK89YTYLOmhEgDmlHDJueECFVTHUv5lVgGg2Nlw1jwdiCohW8Rsx3iTHfIHr3D0cxUIj3KU7uWWf8Gh4eoEbY3Zg2LW7rBnCq1p6HZDtmsj2dHVkMAbqb9KGQ4REayOl7HKcZfzShjmYADpwIHhnrH/rXcfM5BuO/kjKO8XLlBIoL6SbfFunirwW22ddeUDQ72MPdHylC+YldSD85nQ3OQmoto+Vf1XJG/LnSzqDxQ8k/Izj27uxa7u04fOc9Ne4rfO++pH05T/4hvjHnxRU+IE3O0wCJ1yCV1e1GzsDbPYMm3HDUTl7bADfMZBGflMY231NG9ADQSniZ1WDX/DS8pMBWAsBCc7HywyFxtq0LSEMbiSeWSnFVw0T0XA==;5:Gpq3Nl7GS5lRyHMpyyo4VhFa6kraArrr5v3R62RdrncaQ8l5ECUbOWCq+hpTFy8z2WEkTphDTV4ibCNfuQjCb3ENcV3qGaT3KSwctmOCbOXTZcQzuUhnsZoC9b9oM862/rr+DOLaWNQ2R3npuGAxUFlHZYIKruDWvk3J+j+Z/g4=;7:dVExokFoGivnQ00juFVBmbdB5J8UwCNatPQWqRMtoLWkU/3C2jdxzj3zoGd3zNnDSZieULY1jQ00swvWyFXF5Thh7ZsPVU398GVP0zeFu0qtCDLjZkj0YA5A8BRCELk/pzteRC5azytW4cNn2XlM6w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;20:Yhb8O597F5+AE6HwcKnq+QdDE/++ecJPkF5dgSX4PMh6FlbZAnxUyNYIa9zbYZv6rSC9B6cDWRds0y8k1f+C9j2hrLU/mhH1tLtrqGwD7PUUMMP7525kkR+l9V9wq9Dfi1QBGq2UkZ5iHxTIfn2WNamdPI1B6jSiY70kkSOfVbKEneP2TDclawfi8qR9KlLUUD0/PQr4tETjscsyUdXBd+a1ZkEwn/GgmUAXJGYsNfq6CcgQqNsRRXC1c8waewGx
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:29.4811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93499cfa-7412-48a6-be20-08d641b51fc3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5175
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=933 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds feature that allow to change role from user space.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Makefile  |  2 +-
 drivers/usb/cdns3/core.c    |  2 +
 drivers/usb/cdns3/debugfs.c | 94 +++++++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/drd.h     |  3 ++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/cdns3/debugfs.c

diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index 34e60d03c4ec..08e6cdbebd46 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
 
-cdns3-y					:= core.o drd.o
+cdns3-y					:= core.o drd.o debugfs.o
 cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o debug.o
 cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
 cdns3-pci-y		 		:= cdns3-pci-wrap.o
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 20ae9e76940e..4012f1007da9 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -309,6 +309,7 @@ static int cdns3_probe(struct platform_device *pdev)
 	if (ret)
 		goto err4;
 
+	cdns3_debugfs_init(cdns);
 	device_set_wakeup_capable(dev, true);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -346,6 +347,7 @@ static int cdns3_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	cdns3_debugfs_exit(cdns);
 	cdns3_remove_roles(cdns);
 	usb_phy_shutdown(cdns->usbphy);
 
diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
new file mode 100644
index 000000000000..d4871bc1a69d
--- /dev/null
+++ b/drivers/usb/cdns3/debugfs.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Controller DebugFS filer.
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ */
+
+#include <linux/types.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+
+#include "core.h"
+#include "gadget.h"
+
+static int cdns3_mode_show(struct seq_file *s, void *unused)
+{
+	struct cdns3		*cdns = s->private;
+
+	switch (cdns->role) {
+	case CDNS3_ROLE_HOST:
+		seq_puts(s, "host\n");
+		break;
+	case CDNS3_ROLE_GADGET:
+		seq_puts(s, "device\n");
+		break;
+	case CDNS3_ROLE_OTG:
+	case CDNS3_ROLE_END:
+		seq_puts(s, "otg\n");
+		break;
+	default:
+		seq_puts(s, "UNKNOWN mode\n");
+	}
+
+	return 0;
+}
+
+static int cdns3_mode_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cdns3_mode_show, inode->i_private);
+}
+
+static ssize_t cdns3_mode_write(struct file *file,
+				const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	struct seq_file		*s = file->private_data;
+	struct cdns3		*cdns = s->private;
+	u32			mode = 0;
+	char			buf[32];
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (!strncmp(buf, "host", 4))
+		mode = USB_DR_MODE_HOST;
+
+	if (!strncmp(buf, "device", 6))
+		mode = USB_DR_MODE_PERIPHERAL;
+
+	if (!strncmp(buf, "otg", 3))
+		mode = USB_DR_MODE_OTG;
+
+	cdns->desired_role = mode;
+	queue_work(system_freezable_wq, &cdns->role_switch_wq);
+	return count;
+}
+
+static const struct file_operations cdns3_mode_fops = {
+	.open			= cdns3_mode_open,
+	.write			= cdns3_mode_write,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+void cdns3_debugfs_init(struct cdns3 *cdns)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir(dev_name(cdns->dev), NULL);
+	cdns->root = root;
+	if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
+	    IS_ENABLED(CONFIG_USB_CDNS3_HOST))
+		debugfs_create_file("mode", 0644, root, cdns,
+				    &cdns3_mode_fops);
+}
+
+void cdns3_debugfs_exit(struct cdns3 *cdns)
+{
+	debugfs_remove_recursive(cdns->root);
+}
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index 85731f3b693c..5344290c76f2 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -119,4 +119,7 @@ int cdns3_drd_probe(struct cdns3 *cdns);
 void cdns3_set_hw_mode(struct cdns3 *cdns, u32 mode);
 irqreturn_t cdns3_drd_irq(struct cdns3 *cdns);
 
+void cdns3_debugfs_init(struct cdns3 *cdns);
+void cdns3_debugfs_exit(struct cdns3 *cdns);
+
 #endif /* __LINUX_CDNS3_DRD */
-- 
2.17.1

