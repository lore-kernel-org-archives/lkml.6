Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C97C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A10217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A10217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeHVBiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:38:18 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:16724 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeHVBiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:38:17 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id B395661485
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 22:16:17 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 2FEB58B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 22:16:17 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 1216537
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 22:16:17 +0000 (UTC)
Received: from AT5PR8401MB0323.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:804:2::41)
 by TU4PR8401MB0334.NAMPRD84.PROD.OUTLOOK.COM with HTTPS via
 SN2PR01CA0031.PROD.EXCHANGELABS.COM; Tue, 21 Aug 2018 15:23:32 +0000
Received: from TU4PR8401CA0006.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7704::16) by AT5PR8401MB0323.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:741d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23; Tue, 21 Aug
 2018 15:23:31 +0000
Received: from DM3NAM03FT042.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::200) by TU4PR8401CA0006.outlook.office365.com
 (2a01:111:e400:7704::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.21 via Frontend
 Transport; Tue, 21 Aug 2018 15:23:31 +0000
Authentication-Results: spf=none (sender IP is 15.219.147.17)
 smtp.mailfrom=sgi.com; hpenterprise.mail.onmicrosoft.com; dkim=none (message
 not signed) header.d=none;hpenterprise.mail.onmicrosoft.com; dmarc=none
 action=none header.from=hpe.com;
Received-SPF: None (protection.outlook.com: sgi.com does not designate
 permitted sender hosts)
Received: from G1W8106.americas.hpqcorp.net (15.219.147.17) by
 DM3NAM03FT042.mail.protection.outlook.com (10.152.83.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1080.9 via Frontend Transport; Tue, 21 Aug 2018 15:23:30 +0000
Received: from G9W8667.americas.hpqcorp.net (16.220.49.26) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 Aug 2018 15:23:19 +0000
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G9W8667.americas.hpqcorp.net (2002:10dc:311a::10dc:311a) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 21 Aug 2018 15:23:18 +0000
Received: from g2t2356.austin.hpe.com (15.233.44.29) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 21 Aug 2018 15:23:18 +0000
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2356.austin.hpe.com (Postfix) with ESMTPS id 29BE996;
        Tue, 21 Aug 2018 15:23:18 +0000 (UTC)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LFGCUo021388;
        Tue, 21 Aug 2018 15:23:17 GMT
Authentication-Results-Original: ppops.net;     spf=none
 smtp.mailfrom=ernstj@sgi.com;  dmarc=none
Received: from relay.sgi.com (relay2.sgi.com [192.48.180.65])
        by mx0b-002e3701.pphosted.com with ESMTP id 2m0k451555-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Aug 2018 15:23:17 +0000
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay2.corp.sgi.com (Postfix) with ESMTP id 478C3304043;
        Tue, 21 Aug 2018 08:23:16 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 605001)
        id 0E3712006D2DA; Tue, 21 Aug 2018 10:25:50 -0500 (CDT)
From:   Justin Ernst <justin.ernst@hpe.com>
To:     Corey Minyard <minyard@acm.org>
CC:     Justin Ernst <justin.ernst@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH] Remove redundant cleanup in ipmi_register_smi
Date:   Tue, 21 Aug 2018 10:25:34 -0500
Message-ID: <20180821152534.30367-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.12.3
X-CLX-Shades: MLX
X-CLX-Response: 1TFkXGB4cEQpMehcaEQpZTRdnZnIRCllJFxpxGhAadwYYGBxxGxIZEBp3Bhg aBhoRClleF2NjZhEKSUYXQlpPdUJFWV5PThEKQ04XTH5haGFSWhsfXF9lbWVgT3h7GVASQhNbbU FfYmN8Rx4RClhcFx8EGgQbHh8HHxpJTElOEhoFGxoEGxoaBB4SBB8QGx4aHxoRCl5ZF3lZTmdrE
 QpNXBcfEhIRCkxaF2lobWhNXREKTU4XaBEKQ1oXGxMYBB4SBBsSGgQcHxEKQl4XGxEKRFgXGBEK REkXHREKQkYXZxNtYBtbZUIffn0RCkJcFxoRCkJFF2xOGn9zW19fQXxdEQpCThdsbH1NGUhrZ2V aaREKQkwXZ20cWxlAWnNEcmURCkJsF2tceGxSU0dtE2hdEQpCQBdpH39nbVJiTX9jfBEKWlgXGx
 EKcGcXa295ZUZmbUtvb2sQGhEKcGgXYmZaHGVbYXpwb1gQGhEKcGgXbGABZG5oZUN9UEEQGhEKc GgXenAZQk1GQHtcW1AQGhEKcGgXaRN8cwFNYmxBW1gQGhEKcGgXZ2N/RmB9TUkBUmMQGhEKcGcX Y1xGHUVubGVHRGkQGxoSEQpwZxdnW34Tfh1sZxtaARAaEQpwbBdpWl5ibmlGRhMBeRAaEQpwTBd
 pSE0ZXFlTXHgdYBAaEQpwQxdvSFlFRW4ZU0V+QhAaEQptfhcaEQpYTRdLESA=
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_notspam policy=inbound score=0 priorityscore=0 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=246
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=631 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808210160
X-HPE-EXTERNAL: 1
Content-Type: text/plain
X-OrganizationHeadersPreserved: G1W8106.americas.hpqcorp.net
X-MS-Exchange-Organization-ExpirationStartTime: 21 Aug 2018 15:23:30.8389
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: Original Submit
X-MS-Exchange-Organization-ExpirationInterval: 2:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: Original Submit
X-MS-Exchange-Organization-Network-Message-Id: e4644b04-920f-416c-89d9-08d6077a0d33
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-Organization-AuthSource: G4W10205.americas.hpqcorp.net
X-MS-Exchange-Organization-AuthAs: External
X-MS-Exchange-Organization-AuthMechanism: 10
X-CrossPremisesHeadersPromoted: DM3NAM03FT042.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: DM3NAM03FT042.eop-NAM03.prod.protection.outlook.com
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:15.219.147.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(366004)(2980300002)(428003)(3190300001)(199004)(189003)(42186006)(575784001)(486006)(26005)(1857600001)(336012)(42882007)(5660300001)(126002)(116002)(6666003)(476003)(2616005)(103686004)(16586007)(36756003)(305945005)(1076002)(53936002)(156004)(54906003)(52956003)(356003)(68736007)(14444005)(44832011)(8936002)(50466002)(48376002)(1096003)(105586002)(6266002)(81166006)(6862004)(51416003)(8676002)(81156014)(106466001)(50226002)(4326008)(47776003)(97736004)(450100002);DIR:INB;SFP:;SCL:1;SRVR:AT5PR8401MB0323;H:G1W8106.americas.hpqcorp.net;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT042;1:Tkzp15gHvFV8WwQUHi+0ZK57cRfm/2bjJPf33SCk43coH9MPyOc4FmXqstoEorrzFEhLMvOMCCBIeDtwbqPnkHNipuJynm6Sk/S6qh0A8qfTKaHnGnj3hSFC7HpvJn2z
X-OriginatorOrg: hpe.onmicrosoft.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4644b04-920f-416c-89d9-08d6077a0d33
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060);SRVR:AT5PR8401MB0323;
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0323;3:ZPdP+rMspQjX9zUm85pl5y6z19lznaeuOAOplkK32rg4IKfsDQFQ4I547Utn7Tl7rOzbn6R/nVh/wlBcJPeuQvDwUNVxeS4DAeCploEmXuyWcbB4oYNmQUr+SUAOmruWIRcg4nEVVifpUUMRIdkDcgNWsxzLD/xnzTWeBU30QZhpJmpqJkw+BAoN9acyiTsBQFYa4WVYuLlJLUeyazPs4OSAA84W0afcTPYxqivEmN6W8wJlr+ET5kZo1Il9cmXyBZOm/R9xp2IdnvgBs/JqbHL0LestDnIsZ8GEO/9Ts159Q46QCAY0yVgjgq098XX3R73mk30hfgM4x7QF6/JmWzK10qg0N3y/GuQTPGvhpo4=;25:duTK26V0Ffw533cPblmvEsRPJiWfQXE+PLtME0eHzOY01UPBtZtDH2w0KEm3hnFfbu7QtlZAKBLi++3/6uJXlIKtexBpNN3ALLEIwcRK0CVrQkiqq/Mbzfve6THHOEtTB98g4Gws4AHRYj0NHMh4GJ5hH/SA7p7sl/dxP4HSEpAap75ycDEL1lfNc7K6E2ICQTdxKd9kK0Az5q7waOKLenBJ32UJWH6ap8PUaXivP045mO8jVfKy6JRuPsYmJFmW39S8yF2wXpKq5tjnq4AhSBMoOfX0fQDuPjaYFFTc3t8k8h5La53K1m5UNoOBEq123eQVACzS5yI9KQ5AAHBipw==
X-MS-TrafficTypeDiagnostic: AT5PR8401MB0323:
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0323;31:sW+9R8dnTVviSpBS9yWdfbyVHb6hU523t4+v5isoW2hybU1W6n8O9ZXfnDdsS3ANNIebkvo7qH+lA1GMSa0NWB+MSwOADiorWoluTdj7n6NT/dy5/MYXvUNaBJpUdjrLOHYbRO2GqWGF/1wOZSRH2eFXkNHeN2bbfFQzZlSseb5mzUy15ZqAjtVTb8BZvr01yaV4waUqHXMx4Y1t3fzzmlqkLF3Rdphi+ql5RHS4DV0=;20:WgzzI9MwqXzEvW0iO/SekjbzP3hgrEl4ybahS82nXPR2e9eckTRJFeDQve3uqGjiEToZPb+mNKZ9TDnPsEF091eZ/aCFa4Hw8U5zZHIxUhb2TW1Snt+1AxSvt1iHHFLTLqOpoumGmXeiT6l4zFQoRqqw3OvsgDgLUgb88OVMSnUlfo72uQqVYsK4G0BE+uCY+rqn4dXg5/cHL89v648eUyXzrIaGToTS+0eUwWAA+LxqFC6fEH3+qYCPlLoj5TclOBlT0ClQze3UrmpYZ0JpoZY9xJ3b1OEHLzBW8QnMm/Wk82xdlfR6v+ra93O9Y7X+yKPJTuQSLJOHaKaKQ/KS8bBw80dPp38w0CE+z9xORlSNs3lWERb45LKxU4ns8goaTc+RuogFurd83H8Ywu2DW8ZP/Hny6XG/FpTBVLqAMfdycGvYpcBvAW1rvO0VC2VQflupdfqfBmqtU7uv9JZC/5XNZ4XOy7sETEdCaru5hdgdizW8Cl5z6HjqF83iDhjq
X-Exchange-Antispam-Report-Test: UriScan:(143289334528602)(227479698468861)(9452136761055)(42262312472803)(213716511872227)(222181515654134);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(2018062399030)(2018011200283)(2401047)(8121501046)(823300264)(823350442)(823411253)(3002001)(93006095)(93003095)(12181509095)(12181506113)(10201501046)(3231311)(901025)(902075)(913088)(7045084)(944501410)(9300000166)(9301004277)(52103095)(52105095)(52106170)(52401285)(52601095)(52505095)(52406095)(52305095)(52206095)(1610001)(8301001075)(8301003183)(201708071742011)(7699016);SRVR:AT5PR8401MB0323;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0323;
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0323;4:SdJA1ZXnkDId9pXqTp7To57BFxW6w19wPDyljMGncyzCqZ3ztoN9zmYyvmp4Pt6G+KcPu6YFgkxOOixgUw0FahuX8eX3Y8grGQAPyu9btg7BC3AB7U8Ac8qfNLRm6VFAqgFfv4DNhOtL7tyARgcmladSfJxoESIyUSQEJ7eH8EJdqL9+nVFbrKwydSkAQOeFjpbYcZh9QYnKE1zRjYYpjGyWd/0EABUXM8EZRxeRxmBhW4eqILww9kfLwSBeStvOqY/Z18J1b3Zt9kc1JXD/EmIIGq19SAm04A0qyWm2lX89ExxZ/FeMbPzaW0W3XqxDe6JSZV63kWoV3Y4TBF4XiH24mS9jwMtIc8WDosVrGB9hbBSJzwxNdD6eHBVsptvswBw6HuDKZqFjjaKYOz54iRKwH1jVlR4koIseOubCw9t/zzdWtFyf+Fa54nkfyGx/auBDB1ss2UFFh5DV+zMtCJHKPNKoRExqNNzoWlIZrm0=
X-MS-Exchange-Organization-SCL: 1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AT5PR8401MB0323;23:1pCv69dJVl6j/ZGtPgJL4HMpKcmiKN0y0CPssPY?=
 =?us-ascii?Q?bi1fOoKYUDBNPILmiDMXvRrjN82FhuIBq+fKKet/bHleTFcvrj5nSRFzoP0u?=
 =?us-ascii?Q?jRQl+qp25L/HBjHKmT8KTCCFJ10T8y0jiBix4BDbwQvEDhf7xOOkK6T4943V?=
 =?us-ascii?Q?xTLSziBkxVe6Vo75ev+7ZVHyMhjinKQnCY2F7qZxFm9x7gh8ppy9/GMk3L58?=
 =?us-ascii?Q?FayU12HD26OexA2lgnujcJ6Eo5YPu1vsdfmH1IHiwUH2qYAmYD23d4gF/PZl?=
 =?us-ascii?Q?DDshRFk7Kj65QW5Qzh0TowBwxi6Y6l4Y/oD71++4MN9rG2G76yce4LRq77iv?=
 =?us-ascii?Q?3ZJAikNjqLYShN+RuSLeI8kTxPP9vCVs4p6kXex/vdEf8EhgpGVZ+cm2A3hP?=
 =?us-ascii?Q?b9eWfwRr+jBNgLp0TyiiGiCXpWRBhczkW7QijqUtJSDnL6+C3OykuZHXYOh5?=
 =?us-ascii?Q?8cozp5WGKaVVPOVuHjtToECX3O+0t8iWVxLS7C5RJKTGYD9krpfvHdqSBsdt?=
 =?us-ascii?Q?uGwBjYvYW83sCDzCx3YPE5Otb/pE/V7iLNcSUcVI/CQkLdX/98gP1yXiaqz+?=
 =?us-ascii?Q?+EPVZK7xelwsuAMyXuIEAFvNwhcmjVn75jEbuYmztvrQCXShtXpxHGB8odWU?=
 =?us-ascii?Q?aSrhOVU8BbUVD60qRs+tw8eeZMacwBgs5U5IZ5H0WAtBJQEug/jtRdJ22edp?=
 =?us-ascii?Q?+Dnw/U0vr4dGD6hmm1BQ21h/2sGr8P6hJR9Fen/Gopbiw9wZL5URhk6F6CqO?=
 =?us-ascii?Q?V1HK5efbTi9BcMsVI5Bz4G+x4bWhPdzfVksky0lAAAKW7mYGpq+yIJS5lD7g?=
 =?us-ascii?Q?IRB2pw/8Wa5ArM2TAIJP5dQrnoYUutz7DeJw44ftUUT0JbklNQgaQf/I4GaH?=
 =?us-ascii?Q?fSCLfcv6+4KGn7eMkXkgWoKBCC/TJrduWJlBJQEUTBxxe8JpMFSh58hHlPDp?=
 =?us-ascii?Q?5fbasGkLoRPU4LfC7OBkd8P9UVnguJvy36TqB4QlRWEbCRgVvs/4lDBvJhWs?=
 =?us-ascii?Q?IBfTJhrNGCp9Cyr7IaTknlyBhf4L3hQy49+Q6weuy+6vezAvoUhOUWInp/+0?=
 =?us-ascii?Q?qi3qmx5oKB0nXb0UgzZINuoLTqShr7tcl7fZ7H+E8ihlpPSLDn0EKqrcqhgE?=
 =?us-ascii?Q?ZVw5OhKZPTCQ=3D?=
X-Microsoft-Antispam-Message-Info: FfY6/GRUcotXuOeRJws20rVlBOzzsPTH4hm/aTvaAkmcFHVqAWH8XIUP81xaz1yfDJ8vEmO2QtzHfGQFw8iIjyEmmxNs+2XLBGoF5XKyIyLYL0907JsbEG7WBSRtjeRefkiSeuoYwNG91zGsHUAlyLSPD/MYkN0prm6W7vxl8BixgIZ/zNYP0StZo5BJBkD0+5dXeoPyXhNtN/2Vf+TzRTkU7YPwecESYX5q1D8BKZuIl4ADOs3lD75C2CtsSm2wNFTXmXg4q4Ss9bRCPY8lAE0JVi8NZy8zWudsaRCVTGqmB6scRmvDVwdaGtvK7wVBAErS1+N2SgQX4coOoSWxQSieQGgzdliewGHnY1XYQwcIoNpm/0kWM2E/Mxa8tX8OA0egHeTZfEMkVBmDeKesyQBdzZrD7RlRyJYpbHRORplo25dvQ7OvkwgciEt920bpTNfDjBMOH3PvIrBQM4imihefOwTLrfV57tuio9qYJgbSRI1IIzOwsqdgYUdrLNK7YumICi9lLECGN7cO0U4PXGHVWjV9kNlw232e/Inm8K/c2i032sHh6mS7iCA36Y8qS4XItY06QVNvFjrZMz/Oqg==
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0323;6:Czo/BWdkCjcSo9riRycltq8bsCIo2D1HCVAgDAanHEiEELMQxsmxla0QRZXpXGUaf6rJZ7BGd7opRD2hUWt/SIT8WkmgJS9NZbDvyxSObQBLgKFep8zqS84QTGtx64PwByk8FGGqDBg3XTF9PbCvMeyFGhiFlOgjCcx3TpksNoqEhBJkpDkbzyGDdp7MJpgSCMFBUpQWyn/m90ea20BOoSHYV8ODo+e73N5LsfFMx3ISEqVvYsBl6Czss7Y5pQ/nblpu8a2k/L7DPDh9+o55b5hgFRaaRwwS49qseAyd9WguTHtf6LPt6ZI76JIVpKrBpR60FQg2AWHHw2FH+D17Ji3jspdT/87PGZWT4Z44sf5asS0muFwZKL0LFVHP2WPhZfS0sBTZP1bUO7KlFNlaDOpAKU2g4gklgGrf274SXeY+2Gvz+LCfuuaC6vhzKkzxOB/eIs6vDQxwhZycSgLYjw==;5:xXGIV/bSdfXR/nHrASABkQYP5JTSqvmWel8x/WX8U3bZEMdp+Eqfds2cByIwc3goIE7/AgzBwEOx1uVoPkDFYfChqQMyve9/s62vVUzPF1GUL8MifPmlXt0/7tRH0lAkhBZsv8x90MDE9PHRUluwaPNVGnkqFONLU1XvmAbzGU4=;7:zyzxZ3aPAVwv2mOS54giMA2N9GoeVQCztyRErbB3sey9SCfSsq0WPcit7DbgordhEqI8aI51N6T9Yo8NQD+XT+ESBLmEW46XK6wQBB0x+fofExk7s3OsEtMoPqzsjsltY8OX1a7ed7noOsS7tIS2y3QcOYH/J9WsUCpLzU6qCwBED4FlDD/l6MwwFegUVLCgZcH49NDyHYMBwA+NbH+HhqAgSog+7nFepUAcobunKE1UVWvdSgKiWMn/LPG8FGBU
X-MS-Exchange-ABP-GUID: 02950aeb-3c14-4da5-8c60-ccbcc3967284
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 15:23:30.7452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4644b04-920f-416c-89d9-08d6077a0d33
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=105b2061-b669-4b31-92ac-24d304d195dc;Ip=[15.219.147.17];Helo=[G1W8106.americas.hpqcorp.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0323
X-MS-Exchange-Transport-EndToEndLatency: 00:00:02.0065726
X-MS-Exchange-Processed-By-BccFoldering: 15.20.1080.010
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0334;27:eiK23FeiHKvujolgdUXjSdavqqZuHDYGHlyLzTSdPEfc0g1U0OUJ97ylLEYOGVY2trtdi8FRAdPnio7e7y5haLA6EWysRfCXBZ08XK0Vla7sxuH0bo0iUPjmOgHDVSIRgGBk1hP1UmtGYAzNcKEfFQ2Dmg6ozn4xzf4WSClggag2llodRvBIjMIZOm6Le1Hu9PgnIyX69+6h8Cbo1AsCx0KtdqUWLlwiUdFMjI0RgMtMNwGFnoEUNFhYidLXlR4HnOrbJlHz7z2gs8fhZ/dmPNYg08d/P/L5u9yR807sRtRk+Xu0Db2AMo8WupFMmGS3MVCGMBYDipPcXYG4q1gNx9ZoI27xz3MjkMcM7cDP0Ac06Prtl3EgghoZFuQ+qDBse7tr0gA0jm4FcLPn6Xv98A==
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(20160514016)(750119)(520011016)(944506220)(944626516);
X-Microsoft-Antispam-Message-Info: /0bnEV/qZMGkzbgbpULM0dmBOZJanDNaR7TJsHPj8NxDdmzKMYU9+T9ZEaqkJXltm2aD4RM3ffvkXL9NwVBpSe1dEafs2P/TiYUkk9D8NvXlXiBxShlwjb9SfOGAUV5OCJ75d73c2NWeecg+ObB/lIwbQ5ElhjnOyB0QgLisY/W0UxlLJDj1f9fZWoLnjXQNYEIDQ8GGceI6effUmC/hOJNu6CxPGtm9qx05ADTXyiigFLrNkjKyooZD4NRWxt5u9U8Mbj5IqRpZZNHbmcb84pkmYeoh1rApWsa4GK99NHTngz2ZeZSVUbuXAen4YFfGPyVbP76PtzrGL/j7Hei0GO9zh8bHq0C7Tuu+24w8QMlwXs1guDvTBYI/5aoXHQVxRymhQ+VNonRNZRYcEZFYy/diK9agzpLd+zLNiohKCS+Z+r/FkTm46gkqO9TG4jeMLoERvwU6RCeNhi/J2KEoZ9GCndQgZUuZ4vpOic+AzB6qFx4r5BceD+YrRwIqddCyPJO7go6+yLiMSJQ9iYPUoF9CNdb9uVFc/WZWMOZHRRubFOxarP1H/WzKFN7RlbY/8UFb08W2HOE4jXbPvxRX35LNAOtvkrETrLSB0FOLOFg7rwd7Ep2ZFH//9yzIRJWW601rMwDEkPjgggXAg1ohSw==
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ipmi_register_smi fails, it performs a small cleanup routine
before returning its error value. In try_smi_init, on the condition that
ipmi_register_smi fails, ipmi_unregister_smi is called. ipmi_unregister_smi
performs the same cleanup routine as ipmi_register_smi. This results in
a kernel NULL pointer dereference. Removing the cleanup routine in
ipmi_register_smi results in proper cleanup of a ipmi_register_smi failure.

Cc: Corey Minyard <minyard@acm.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: openipmi-developer@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Cc: Russ Anderson <russ.anderson@hpe.com>
Acked-by: Andrew Banman <abanman@hpe.com>
Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 51832b8a2c62..3b0b50c4f064 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3395,12 +3395,12 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
 
  out:
 	if (rv) {
-		ipmi_bmc_unregister(intf);
-		list_del_rcu(&intf->link);
+		/*
+		 * ipmi_unregister_smi must be called to clean up after
+		 * failure. We unlock the mutex to allow ipmi_unregister_smi
+		 * to lock it and perform cleanup.
+		 */
 		mutex_unlock(&ipmi_interfaces_mutex);
-		synchronize_srcu(&ipmi_interfaces_srcu);
-		cleanup_srcu_struct(&intf->users_srcu);
-		kref_put(&intf->refcount, intf_free);
 	} else {
 		/*
 		 * Keep memory order straight for RCU readers.  Make
-- 
2.12.3

