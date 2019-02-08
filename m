Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DCC21919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfBHITH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:19:07 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:36456 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727166AbfBHITH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:19:07 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x188BTSB010616
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 08:19:06 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qh21wsmgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:19:05 +0000
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 02C3782
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 08:19:04 +0000 (UTC)
Received: from G4W9122.americas.hpqcorp.net (2002:10d2:1511::10d2:1511) by
 G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Fri, 8 Feb 2019 08:18:52 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W9122.americas.hpqcorp.net (16.210.21.17) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 8 Feb 2019 08:18:52 +0000
Received: from TU4PR8401MB1168.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.142) by
 TU4PR8401MB1197.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 08:18:50 +0000
Received: from TU4PR8401MB1168.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::21e0:7d57:e370:3da8]) by TU4PR8401MB1168.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::21e0:7d57:e370:3da8%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 08:18:50 +0000
From:   "Abraham, Santosh" <santosh.abraham@hpe.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Missing CR3 switch ?
Thread-Topic: Missing CR3 switch ?
Thread-Index: AdS/htzArBJYCzo8TASr3beYSGm5OA==
Date:   Fri, 8 Feb 2019 08:18:50 +0000
Message-ID: <TU4PR8401MB1168028587E7EB526C332214EE690@TU4PR8401MB1168.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.242.235.143]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TU4PR8401MB1197;6:KNsJSxbrFAlj2FmUcUfZR4hTCt6TLDr0eeCVHbLva+YytypHMKcmr7MLIALN0RM4O4V9i911pymIHaznGfmIDW5yuAJ4Uf7dzUAegMtmt27+Kv8spwrmGP2KNEIO/lqd+3CtN69BNLrBB4fylh/CQynA8qauHhcqudutP/YRpWiRYuIauxr8g5MZVxCPgWCA00b6lXzUeBC8M0Ew2yWfYJiOchhGoVTYcjK9+Aal4VC5BPBjzMU5FrxHrxHT/NqzezqcRToVcGj7UsT/Vt5NCMNusgqAmheaUvqApUwNUxsaiLRDaJIwWdwSoXX8lvp7y94ladXtwLb10hTFwWmDnLoDga1Usx+x27vSpzHoJyji8T2l/TyjiiScwd8ebR9yUd8fvuim1Th6iaIRi3QihIKM9SqK8iGkO8z5rWR0Zch7Ae5xV3+V+uvND/1hrO42JbOpL5lhGLLykHzhp5v8xQ==;5:iWwF6y86eCvyjpg8t1RCPEII5yj4oH11ngCnNXek7vEt3CzEDRfuHbQw65yDfmYPsCjOS0aylFkLNcfswOHzYNfXNXVGlhPar41+7RDpjbbUM4pb2+ahp8VG9FN6wRa1Ru1y6zSeFWVkv4laj4X8rDE043J5DPE++JXSrxg+KJl+StMYyFcilb5Y8enzMFmqCXVrSPImpGOTFVlzVylQ9w==;7:pSuOR91UUv99pOLtG0yPymFwdxdGQ5lx6avTFCwOPgWgcf3Nf83YL5YSXzLa2vd8oJqTAj8PqS/EaHVWVyhTcuDVtk/v8H1j6U9NuGytg06Hw6jaZyszR1hBHnv+oMiND641Tsfx20QybFWbwFvCXQ==
x-ms-office365-filtering-correlation-id: 8926920e-7e30-408b-d23f-08d68d9e0e3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB1197;
x-ms-traffictypediagnostic: TU4PR8401MB1197:
x-microsoft-antispam-prvs: <TU4PR8401MB1197AF7786BCEC7B299E08EBEE690@TU4PR8401MB1197.NAMPRD84.PROD.OUTLOOK.COM>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(3846002)(6506007)(6116002)(102836004)(2351001)(55016002)(33656002)(4744005)(9686003)(99286004)(7116003)(26005)(86362001)(186003)(71190400001)(14454004)(2906002)(71200400001)(106356001)(478600001)(105586002)(97736004)(486006)(6916009)(25786009)(68736007)(256004)(66066001)(316002)(7736002)(305945005)(5640700003)(74316002)(2501003)(6436002)(53936002)(476003)(8936002)(7696005)(8676002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB1197;H:TU4PR8401MB1168.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jILEpCI7nWPOjVN4PfMKfXdpClJl4uePowN4nmbWBEYc+OtsByX89I9GRJccD6d23Bq00oYGiT+ibV6pfcSioui+VqKbQ3hmJcH3fi+gT4EnoYRIs3LeOAJyo6b1pERij16USYPY2cQHGX0Xa46g7LwkPf/qeSHQZMsi6kqbXzvFcWZIM5jqO3n4Y8nbdKbdPLeXbsl60IBrbfPuK1Cn9g3rq+zljl8Ys1zrvuYaP+/BXODIQXr/VlSKQUpkwyBp9cfajooccsxkh3NJdZwKLzQrTRMg5GqwoTyPlYjXKCZqIs+1ZQlrf+LkgLbVogGsDNc8F6Ch/Xjj74A3LGHbFBDKnNfqgFD3/38BmR6Kx+nIInZPuBQC3s60V1WFLAeQMlVjgv18PUZBPnEC+IugtyzO8ZFk2HBunmx7u51U9ec=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8926920e-7e30-408b-d23f-08d68d9e0e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 08:18:50.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1197
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=435 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I am trying to track down a strange application segfault error 15 bug - which is resisting any attempts to be explained by an application bug.

Hypothetically, if for some reason - the KPTI code failed to switch to the user CR3 while returning back, the kernel would presumably kill the application in the first instruction that it executed in user-space.   In this case, would there be any other helpful messages in the kernel syslog other than segfault error 15, or is a completely different error message dumped ?

-santosh

