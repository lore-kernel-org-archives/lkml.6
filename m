Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB627C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE5A2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JHXljSNA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NHgOL77t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfAaLy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:54:27 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37170 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728687AbfAaLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:54:26 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VBqLP1024071;
        Thu, 31 Jan 2019 03:53:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=NoPhSqEgPnIUSReI4ia6iPjR6onZzJYND9QEd046QBs=;
 b=JHXljSNAeq6BAg8vzAkhuvtBi0z9zs31ZqEllcPNDl/ZSiURgxZ/iOPD6Z8FVQl8Deeo
 /2lEfkAB3HhyyFy9Bj/ZwvXR3+Ivmk0/A+xZSL2EECBQ0XuTVKFfdo4sEiZEfWbqZrtd
 l1PVwSBrerz5HTxxHx728y7jmiFWBl6tHEJ4eAeRUGbDYqctZYuhEKq5Bj9kew/jeeuF
 Cz2ZbN28E9Eesxt4ooDOP0SgqlC0UNJFB6cw7WKV2XpajLImQba3my12xBnXPCeb6yrX
 /z6UwDpBB4MeduvaB5fXP88oV+Ga6M6uQwj2NvRPQ0QI1SrRQutRULtKEPF9hrIsL/Ag Ig== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qbjukkbuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 31 Jan 2019 03:53:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoPhSqEgPnIUSReI4ia6iPjR6onZzJYND9QEd046QBs=;
 b=NHgOL77tImYAQPHpYx8P2HFtRpuf/oh68U7xhgeMbr2wPNHwqoWlKUprTvRN57+qUkk+4rHZCRNMcwA7Eyk9CWLqbmpo7EV8b4VcIDWT0wKUYtDJ8Jyb6r8MnApq4h9m/VnWTXzgU/vB5z+tmE1TBMdrUAYn+q3GI0O6lg1mxOw=
Received: from DM5PR07CA0036.namprd07.prod.outlook.com (2603:10b6:3:16::22) by
 SN1PR07MB2253.namprd07.prod.outlook.com (2a01:111:e400:c456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Thu, 31 Jan
 2019 11:53:11 +0000
Received: from DM3NAM05FT021.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by DM5PR07CA0036.outlook.office365.com
 (2603:10b6:3:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Thu, 31 Jan 2019 11:53:10 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT021.mail.protection.outlook.com (10.152.98.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 31 Jan 2019 11:53:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr4Sj028139
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 31 Jan 2019 03:53:08 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 31 Jan 2019 12:53:04 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 31 Jan 2019 12:53:04 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr4ZU002269;
        Thu, 31 Jan 2019 11:53:04 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x0VBr4mt002268;
        Thu, 31 Jan 2019 11:53:04 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3 driver.
Date:   Thu, 31 Jan 2019 11:52:29 +0000
Message-ID: <1548935553-452-3-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1548935553-452-1-git-send-email-pawell@cadence.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(189003)(36092001)(199004)(305945005)(26826003)(966005)(486006)(54906003)(316002)(11346002)(7636002)(76176011)(7416002)(4720700003)(86362001)(47776003)(446003)(126002)(16586007)(476003)(42186006)(426003)(336012)(2616005)(30864003)(6916009)(51416003)(105596002)(106466001)(26005)(6666004)(356004)(186003)(36756003)(2351001)(14444005)(50226002)(50466002)(2906002)(246002)(8676002)(48376002)(8936002)(53386004)(107886003)(4326008)(6306002)(87636003)(478600001)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2253;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT021;1:j9X6ixc871yMdDHBhNYVS5/8jgRNr0dUrl3HkoHcFriqjuwj4cN/YV2z0+HLQvqCXxaMi9YwDuQpO2oc7LjN4a1fBTO1uR9+hOooHfaxwaes40Vj+9oNnxViLM86zTgdlbDwxrZ/edGV0x16hQZI3gAUWfX3byQac43S0UVFONU=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063e3025-9833-4c43-98c5-08d68772ac31
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:SN1PR07MB2253;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2253;3:wFwwNSfJAK+mC2S2IpbBCqQiRdPygXa788scd6E7F9Q8nGE6216omtiDoT8VHb1F8Xk3og1GBb6vKqbiqEulKDtYvxewgH4MASjCt0ZyNsmxCqpb5QsiDmD7RKCHjvfZUnqJV40prtYcScmCaZO9JFiQjTQIBsW4oDPmlkkfIIHcgBTxQaXT8PA8wTVGiiMFdS4wfXJIp5sp+zmbiSwcUWRElnE2iUX5R0tGZeNf1Z7bLMOD5ytOpjNPDRUbNsfSHmG7cYVqKaAU9usuoDeSTGDtB//5Y7/qb9JIY9g+cDsfW2Ef1AKtVqsUu/jGMXEr4VkdfFyQWtl/+xS7eb01e8wt6ocQCKw5rteWLzkYdxHh1jwH74qo28NacGgmPem6;25:U9XOVbInyQRAbT1oz+0A7CUleboEDoYemE8w9Ki8UTgKI43eBFP3RQXgOWsyk2RDY9X6fD8ZozKzx/l3pdMtyXqVt9306wXWK8yuK+yKVQtAT7YQydxrGWX6P4H1jq5W5nEM631wPLcpS361c7XFTSTjJj8zCW8GB8ZhNtJzscNreRroC8s97aZBgXd3zgpGW+b+7fAvLXB1xbGSJzAjBlSnIkgx99qISIHH/Pwv2DrF0TgQixEOBBKfpH7DUqGXakikIsBbELkMN3Hb5eUZAYG6Kyh/LKw3zYc5tgVFy3qbCUN+CLqpja3YwIda6RTVRlcm/88Y2TGyw3Dc3btf8xLxexzAiEQkZVx6iqb3DlA=
X-MS-TrafficTypeDiagnostic: SN1PR07MB2253:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2253;31:qGUCIfpiPfOj4T5WeEg+mn8KsvzxvdhlMo9b2Ln260jXnp0Bc1Lr2yudBk/3FsMfDCQPpKkP92irrjx07SFluxJf62Gg21JNSc05s4uoD/1+w0Hb9wFRlUHmgh3UklhLLBuQikbS2uFcM0QLbp8CKyGVSoILIJH9EJox+jSt+OWwM3vzddwnk3vlhFnD3ccskzMxBYcZFwBMhmejVzKkTbNJSzEee0iR6eCZPBHIy0M=;20:zA1P2wb33Im2tfBj7LGWi/+RC+W5SoCct3w6KBYP307hOON9MlBuz1gXvjKjI2MmkJiGU9ggXncDYLu0q8kfuzkC+vfoit9sPh48BoqyOTYmvDhaS48Vp0FD6uT4iGKkFNYfUwPIT96KSZqKNBvh12dn/fDWTmptI1mPMfvw862Qdlxl0AlaNTcD1dKuUgZwDEy/4jp2wGPHX28tLgUSSZH79coUQYZ3TfwsfYuobNveR6j3e5hTv9PipaJYylMjuSInpOEiCelAOgmyKrg0KYYZtAAwEJ7nda/lPLSFjrJdDGBr8nFmTRXq2pVmAfc+uoZjA03ZrtI6Sirvj3pRv8iG2iPReSLXoSe5W4XQngm22nuUEidaOKy1esOS1KmPaXe8t2wUuNM09xfIq/2DA5/VTCtMclinBEvp1A2AZasOu56nJ9SbueYnbiPLQL5HMmfr4He96zVkmlCyQttk4mzXcqxNQ6+CLLWS4BbE8T8mYUmTBtcmWzmdNlTwuf9Y
X-Microsoft-Antispam-PRVS: <SN1PR07MB22531E422E6C96C2D3F8909BDD910@SN1PR07MB2253.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2253;4:6kk0MdOOBBxN+50rdUTRJ4kniimBiQNTqspU6tUKt4xhFtyvpaVfCNEVMqr0v6EA4mSLCv6xrjVqQgf6TDqFDB2Z0JPfdtEF7LNnJo/H82MbcU+KnzC8tnPJ4vFuRwly3LS4qjDcIGEqRFK61t+p/OWo5OHCi2fBFxwWETBq9lhPiwVEqiPAb+X0Ojlr6KK1UDXdJocAvztZR74mP60XPk2NXjNPVtMtkkdaPIQ/oFQ5LfMuhdvJAOFolvdLhitW8ryBEyDmkeEd9TqpAZy6lfApcDFdawWkb49lzvWpZ7I=
X-Forefront-PRVS: 09347618C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2253;23:MrBtZPIyZG0omMuaCOzRkq5V889w4Iy1uYTaEbT7F?=
 =?us-ascii?Q?BCLNYrKNUQ1mS7ylypx8/4c+7zPvfuU+zPYfv+rOG7CBsXq1TFsZfdKwm8qc?=
 =?us-ascii?Q?SqrV2RQhgdIdO1ZH7nChpVHm6TO4zi09vAURBEsTGWBxB8adycIk7ge3p8or?=
 =?us-ascii?Q?C0qip3PeP3c1aA5yQ6vKPunMq0LQkFTgfH0cA6WVCB/doD0EYHqGk8mmohEH?=
 =?us-ascii?Q?G0gOMyfqJoFbC5UTeC4UQT9BH95m22LqnvniX4kYnBJewvr+iGWxzc/eQOAF?=
 =?us-ascii?Q?RWfpSaSdlMjjYcebXVCSfz6j8vo5f6WNJY6J6fcxzkhpjBgQ7lPNHpdo9Djz?=
 =?us-ascii?Q?xZrvbuBVOTH1V0JMom9nXdQaRib86h//RTPwNKowdKRI/6IE3KqoJ3u9RrX8?=
 =?us-ascii?Q?7NWNyiuUO47PbOIho3z6kpPL5XRuYz8xMVT1on0Ul8Ny7tcWjB6qasM7ng/3?=
 =?us-ascii?Q?kOK3meTn2rRVRqgQs89PhFM+Fj7RA3HFRmvIPyOSbvX32r6D4kt7jmQnVEfB?=
 =?us-ascii?Q?dHgyl2z/i7X8x6kt+BPbBr2VHPNOjFjt3Kq6H+LZk/zYfz8p1oQu4GzCW9yI?=
 =?us-ascii?Q?q6TZkP06hPpQhuponJZRZ3BCMIRnX58cxooTpuAhVNkSgZVHaAmuLjWUTyXF?=
 =?us-ascii?Q?umkCXg17GzUCLFYoJezxr+9Zp0W9l2GYE1d3EccsM+j2EVR7wIqjHoi28lC0?=
 =?us-ascii?Q?Td7SRZJhu8AzDqtWgnscIgNQYq7Xl9yIJcTMPbwYotC8Vm/NjPDjYtx9snSn?=
 =?us-ascii?Q?jDTloElkaRbmzt0pjpVOHMzuTMSSZCMdGFwjAEFha2DMLFfzfsS9flBMiWuF?=
 =?us-ascii?Q?ilf5zBkUZQe+BiKLOalaqHXF7rwJpzCvq3K+NLOes7/ZHbbOJrkGDTpNA1t5?=
 =?us-ascii?Q?DPvVJ5180JBSTls/2QGAE5LJ85OuQAUYpK3ofAo+fQDtIkZLkKCyP8pM6wt/?=
 =?us-ascii?Q?1E5Z897mITlZJf/CiFXcmo9YBsa9EFHjjtjAJWQP0LHD26y1v+a99IZ91V8M?=
 =?us-ascii?Q?XRn1EA/7kLuKFwmnzP3iYJj40uyGe6+8/ts9mT4Cl2xamQTBxvY7zTy7n4/M?=
 =?us-ascii?Q?kmOPJJW/xnO/5ll+i1tCC6NIhVUJcD5Kwto8XuMth2c/B82nvbQKoFNn5Y4/?=
 =?us-ascii?Q?fSpGpolcPbS2Qlu5yQCRmfgj7+BswqvnA0ycB/F4tDQHc0yZypubGKIyxqGd?=
 =?us-ascii?Q?0Dw2DbKFua9O7Kd8TeX4/gTopTZOFWpJ6KXsUfQeEr8WixPxW8DAxtSSQ=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bIYIe9kdxLU00ATvRviLjyt+JBCek4QZxOoo9XAep2J34T3vceeq6JheWcXAlCz1OrLEWjgclVzw5Mn10itQCO60Jj4U9yH6Q+jx7HaF6EnGdQP20Kv+ukluReOAnt5pc0Jvwp4KRnr1hkOW9ey5gtWiPWlnqZN6klhPjyCgQ3ITRBaboelrN2Jj6OD9jVf6xDjTYcvoWGsevQWa0A4Xrk20DagkAuvB7uYcna//yI8HebPRADbFWbBPlbjSKHgFese7bV6lrSKKi9tdSt5/3VW5K+ys8e65J589zElpRF7iXjm6aGicLn727vlhPwe6vRxGjvq/hGP1Q3a8dLxGp6opC5TP5vlGn42PlweE83tKwn/IrvgrKT0HSYoyaebJ5cbxGI9a8/u/yYdpFcodhY+jQ5k2y9taZaMT3mom4F4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2253;6:csbxCa1uU8XimROAN0k2+Udu8LwXBAuG3olq59JYLOmGb8spqL4PifLP8n+//x1Hr8yNLRL5nSf5wJnor8evTgwJ0jGX393USOdEAywNM3sxiqwQmeSWeQ+F9daBAzgUAKLODqUqzEahskKagNDyAvJb9eAGt68vfXx4ZLA1xJlLGsDWpBLkvpytrS6XR433WbApewYRDS/jodRQsnI5qtfgYZV+2XZt0gzjkW7TGQ96I5KFNr7Gzp9r989/H19HIC6cleG+BKrY+PhfXTWXqPxiM2xqvRsldz+c7exyNkQPvrYhOCZFJTy6HmSca+6IbCrR3iCiZaM3rc63XilMZ2KSTK4VXc20iB2pGu9CZb1SzockkS1NIFvkrk735hzqr4V9Qqobo9H8GpE7K9uBG787GqMdbIh2fYcRRDh8Fr/HGKQK/U60IS7wwcVh5/2wVx3flZrgaKmT6AAfwKi5bQ==;5:eLK6qE20ODGfZHaqVgq20GqgxzFybCJxgz4Fv1lYfFbKAU4yEaE/hAGuGJI28XQFGh7VSTGJ6xRk6TFrUtikYBgs6DTwmbgH5wwk8ielAuUQug09XUAgmachPYtqZrT07Ym8FBd2b+wyGLTVjcQli3q0dNTuB2xGPx2qii9NHOgxMTSQTZgWYYOKYfCahpajetePp1hwkLhNIewxTzZjEQ==;7:229H8cvmSjZRCE+nFIeK9AAUsLy+kR5+IhHXQRCakv6dAr9LR6Ca0hOyVPxVAFLhHkMJ6FBsnKKaYL2kijAyU+e8tAxOy+QHFXxHocsf5jJVD1XKOgwlgsU8GaDDoCgwFiUUuJgbwjFs6Ca7mKsGOw==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2253;20:/zwoBS079MghgEzqZl6AbA6l6G6PRO6BShg5YMvZpZk4vtPP9AOnv+9lrh0eRZErHXvpybrOQoZWtS4roQHZ7vhPtQmvN1dP9HVf68zCuEMCvTxyccGMVdX9AWYWe1xNVpcwhK5LCy/5Disfbr2nuNFVBNuJbRMm7wakkR+hqUwuJoOrAktL3QAtJ/kXUEwcozhYE0VSk2Hc9ZPNvqqwtn3yRuuQ8KX6y90L/+QQNF/NgC4KNzkp1MAZEKBGyMf3
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2019 11:53:09.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063e3025-9833-4c43-98c5-08d68772ac31
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2253
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
to driver/usb/common/debug.c file. These moved functions include:
    dwc3_decode_get_status
    dwc3_decode_set_clear_feature
    dwc3_decode_set_address
    dwc3_decode_get_set_descriptor
    dwc3_decode_get_configuration
    dwc3_decode_set_configuration
    dwc3_decode_get_intf
    dwc3_decode_set_intf
    dwc3_decode_synch_frame
    dwc3_decode_set_sel
    dwc3_decode_set_isoch_delay
    dwc3_decode_ctrl

These functions are used also in inroduced cdns3 driver.

All functions prefixes were changed from dwc3 to usb.
Also, function's parameters has been extended according to the name
of fields in standard SETUP packet.
Additionally, patch adds usb_decode_ctrl function to
include/linux/usb/ch9.h file.

mend

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/Makefile |   2 +-
 drivers/usb/common/debug.c  | 265 ++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/debug.h    | 243 ---------------------------------
 drivers/usb/dwc3/trace.h    |   2 +-
 include/linux/usb/ch9.h     |  19 +++
 5 files changed, 286 insertions(+), 245 deletions(-)
 create mode 100644 drivers/usb/common/debug.c

diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index fb4d5ef4165c..3d3d2962ea4b 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_USB_COMMON)	  += usb-common.o
-usb-common-y			  += common.o
+usb-common-y			  += common.o debug.o
 usb-common-$(CONFIG_USB_LED_TRIG) += led.o
 
 obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
new file mode 100644
index 000000000000..824b3d793745
--- /dev/null
+++ b/drivers/usb/common/debug.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Common USB debugging functions
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Authors: Felipe Balbi <balbi@ti.com>,
+ *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ */
+
+#ifndef __LINUX_USB_COMMON_DEBUG
+#define __LINUX_USB_COMMON_DEBUG
+
+#include <linux/usb/ch9.h>
+
+static void usb_decode_get_status(__u8 bRequestType, __u16 wIndex,
+				  __u16 wLength, char *str)
+{
+	switch (bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_INTERFACE:
+		sprintf(str, "Get Interface Status(Intf = %d, Length = %d)",
+			wIndex, wLength);
+		break;
+	case USB_RECIP_ENDPOINT:
+		sprintf(str, "Get Endpoint Status(ep%d%s)",
+			wIndex & ~USB_DIR_IN,
+			wIndex & USB_DIR_IN ? "in" : "out");
+		break;
+	}
+}
+
+static void usb_decode_set_clear_feature(__u8 bRequestType,
+					 __u8 bRequest, __u16 wValue,
+					 __u16 wIndex, char *str)
+{
+	switch (bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		sprintf(str, "%s Device Feature(%s%s)",
+			bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			({char *s;
+				switch (wValue) {
+				case USB_DEVICE_SELF_POWERED:
+					s = "Self Powered";
+					break;
+				case USB_DEVICE_REMOTE_WAKEUP:
+					s = "Remote Wakeup";
+					break;
+				case USB_DEVICE_TEST_MODE:
+					s = "Test Mode";
+					break;
+				case USB_DEVICE_U1_ENABLE:
+					s = "U1 Enable";
+					break;
+				case USB_DEVICE_U2_ENABLE:
+					s = "U2 Enable";
+					break;
+				case USB_DEVICE_LTM_ENABLE:
+					s = "LTM Enable";
+					break;
+				default:
+					s = "UNKNOWN";
+				} s; }),
+			wValue == USB_DEVICE_TEST_MODE ?
+			({ char *s;
+				switch (wIndex) {
+				case TEST_J:
+					s = ": TEST_J";
+					break;
+				case TEST_K:
+					s = ": TEST_K";
+					break;
+				case TEST_SE0_NAK:
+					s = ": TEST_SE0_NAK";
+					break;
+				case TEST_PACKET:
+					s = ": TEST_PACKET";
+					break;
+				case TEST_FORCE_EN:
+					s = ": TEST_FORCE_EN";
+					break;
+				default:
+					s = ": UNKNOWN";
+				} s; }) : "");
+		break;
+	case USB_RECIP_INTERFACE:
+		sprintf(str, "%s Interface Feature(%s)",
+			bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			wValue == USB_INTRF_FUNC_SUSPEND ?
+			"Function Suspend" : "UNKNOWN");
+		break;
+	case USB_RECIP_ENDPOINT:
+		sprintf(str, "%s Endpoint Feature(%s ep%d%s)",
+			bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			wValue == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
+			wIndex & ~USB_DIR_IN,
+			wIndex & USB_DIR_IN ? "in" : "out");
+		break;
+	}
+}
+
+static void usb_decode_set_address(__u16 wValue, char *str)
+{
+	sprintf(str, "Set Address(Addr = %02x)", wValue);
+}
+
+static void usb_decode_get_set_descriptor(__u8 bRequestType, __u8 bRequest,
+					  __u16 wValue, __u16 wIndex,
+					  __u16 wLength, char *str)
+{
+	sprintf(str, "%s %s Descriptor(Index = %d, Length = %d)",
+		bRequest == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
+		({ char *s;
+			switch (wValue >> 8) {
+			case USB_DT_DEVICE:
+				s = "Device";
+				break;
+			case USB_DT_CONFIG:
+				s = "Configuration";
+				break;
+			case USB_DT_STRING:
+				s = "String";
+				break;
+			case USB_DT_INTERFACE:
+				s = "Interface";
+				break;
+			case USB_DT_ENDPOINT:
+				s = "Endpoint";
+				break;
+			case USB_DT_DEVICE_QUALIFIER:
+				s = "Device Qualifier";
+				break;
+			case USB_DT_OTHER_SPEED_CONFIG:
+				s = "Other Speed Config";
+				break;
+			case USB_DT_INTERFACE_POWER:
+				s = "Interface Power";
+				break;
+			case USB_DT_OTG:
+				s = "OTG";
+				break;
+			case USB_DT_DEBUG:
+				s = "Debug";
+				break;
+			case USB_DT_INTERFACE_ASSOCIATION:
+				s = "Interface Association";
+				break;
+			case USB_DT_BOS:
+				s = "BOS";
+				break;
+			case USB_DT_DEVICE_CAPABILITY:
+				s = "Device Capability";
+				break;
+			case USB_DT_PIPE_USAGE:
+				s = "Pipe Usage";
+				break;
+			case USB_DT_SS_ENDPOINT_COMP:
+				s = "SS Endpoint Companion";
+				break;
+			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
+				s = "SSP Isochronous Endpoint Companion";
+				break;
+			default:
+				s = "UNKNOWN";
+				break;
+			} s; }), wValue & 0xff, wLength);
+}
+
+static void usb_decode_get_configuration(__u16 wLength, char *str)
+{
+	sprintf(str, "Get Configuration(Length = %d)", wLength);
+}
+
+static inline void usb_decode_set_configuration(__u8 wValue, char *str)
+{
+	sprintf(str, "Set Configuration(Config = %d)", wValue);
+}
+
+static void usb_decode_get_intf(__u16 wIndex, __u16 wLength, char *str)
+{
+	sprintf(str, "Get Interface(Intf = %d, Length = %d)", wIndex, wLength);
+}
+
+static void usb_decode_set_intf(__u8 wValue, __u16 wIndex, char *str)
+{
+	sprintf(str, "Set Interface(Intf = %d, Alt.Setting = %d)",
+		wIndex, wValue);
+}
+
+static void usb_decode_synch_frame(__u16 wIndex, __u16 wLength,
+				   char *str)
+{
+	sprintf(str, "Synch Frame(Endpoint = %d, Length = %d)",
+		wIndex, wLength);
+}
+
+static void usb_decode_set_sel(__u16 wLength, char *str)
+{
+	sprintf(str, "Set SEL(Length = %d)", wLength);
+}
+
+static void usb_decode_set_isoch_delay(__u8 wValue, char *str)
+{
+	sprintf(str, "Set Isochronous Delay(Delay = %d ns)", wValue);
+}
+
+/**
+ * usb_decode_ctrl - returns a string representation of ctrl request
+ */
+const char *usb_decode_ctrl(char *str, __u8 bRequestType, __u8 bRequest,
+			    __u16 wValue,  __u16 wIndex, __u16 wLength)
+{
+	switch (bRequest) {
+	case USB_REQ_GET_STATUS:
+		usb_decode_get_status(bRequestType, wIndex, wLength, str);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+	case USB_REQ_SET_FEATURE:
+		usb_decode_set_clear_feature(bRequestType, bRequest, wValue,
+					     wIndex, str);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		usb_decode_set_address(wValue, str);
+		break;
+	case USB_REQ_GET_DESCRIPTOR:
+	case USB_REQ_SET_DESCRIPTOR:
+		usb_decode_get_set_descriptor(bRequestType, bRequest, wValue,
+					      wIndex, wLength, str);
+		break;
+	case USB_REQ_GET_CONFIGURATION:
+		usb_decode_get_configuration(wLength, str);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		usb_decode_set_configuration(wValue, str);
+		break;
+	case USB_REQ_GET_INTERFACE:
+		usb_decode_get_intf(wIndex, wLength, str);
+		break;
+	case USB_REQ_SET_INTERFACE:
+		usb_decode_set_intf(wValue, wIndex, str);
+		break;
+	case USB_REQ_SYNCH_FRAME:
+		usb_decode_synch_frame(wIndex, wLength, str);
+		break;
+	case USB_REQ_SET_SEL:
+		usb_decode_set_sel(wLength, str);
+		break;
+	case USB_REQ_SET_ISOCH_DELAY:
+		usb_decode_set_isoch_delay(wValue, str);
+		break;
+	default:
+		sprintf(str, "%02x %02x %02x %02x %02x %02x %02x %02x",
+			bRequestType, bRequest,
+			(u8)(cpu_to_le16(wValue) & 0xff),
+			(u8)(cpu_to_le16(wValue) >> 8),
+			(u8)(cpu_to_le16(wIndex) & 0xff),
+			(u8)(cpu_to_le16(wIndex) >> 8),
+			(u8)(cpu_to_le16(wLength) & 0xff),
+			(u8)(cpu_to_le16(wLength) >> 8));
+	}
+
+	return str;
+}
+EXPORT_SYMBOL_GPL(usb_decode_ctrl);
+
+#endif /* __LINUX_USB_COMMON_DEBUG */
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index c66d216dcc30..9db2b0fb8f22 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -214,249 +214,6 @@ dwc3_gadget_event_string(char *str, const struct dwc3_event_devt *event)
 	return str;
 }
 
-static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_INTERFACE:
-		sprintf(str, "Get Interface Status(Intf = %d, Length = %d)",
-			i, l);
-		break;
-	case USB_RECIP_ENDPOINT:
-		sprintf(str, "Get Endpoint Status(ep%d%s)",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
-						 __u16 i, char *str)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_DEVICE:
-		sprintf(str, "%s Device Feature(%s%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			({char *s;
-				switch (v) {
-				case USB_DEVICE_SELF_POWERED:
-					s = "Self Powered";
-					break;
-				case USB_DEVICE_REMOTE_WAKEUP:
-					s = "Remote Wakeup";
-					break;
-				case USB_DEVICE_TEST_MODE:
-					s = "Test Mode";
-					break;
-				case USB_DEVICE_U1_ENABLE:
-					s = "U1 Enable";
-					break;
-				case USB_DEVICE_U2_ENABLE:
-					s = "U2 Enable";
-					break;
-				case USB_DEVICE_LTM_ENABLE:
-					s = "LTM Enable";
-					break;
-				default:
-					s = "UNKNOWN";
-				} s; }),
-			v == USB_DEVICE_TEST_MODE ?
-			({ char *s;
-				switch (i) {
-				case TEST_J:
-					s = ": TEST_J";
-					break;
-				case TEST_K:
-					s = ": TEST_K";
-					break;
-				case TEST_SE0_NAK:
-					s = ": TEST_SE0_NAK";
-					break;
-				case TEST_PACKET:
-					s = ": TEST_PACKET";
-					break;
-				case TEST_FORCE_EN:
-					s = ": TEST_FORCE_EN";
-					break;
-				default:
-					s = ": UNKNOWN";
-				} s; }) : "");
-		break;
-	case USB_RECIP_INTERFACE:
-		sprintf(str, "%s Interface Feature(%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_INTRF_FUNC_SUSPEND ?
-			"Function Suspend" : "UNKNOWN");
-		break;
-	case USB_RECIP_ENDPOINT:
-		sprintf(str, "%s Endpoint Feature(%s ep%d%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_address(__u16 v, char *str)
-{
-	sprintf(str, "Set Address(Addr = %02x)", v);
-}
-
-static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
-						  __u16 i, __u16 l, char *str)
-{
-	sprintf(str, "%s %s Descriptor(Index = %d, Length = %d)",
-		b == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
-		({ char *s;
-			switch (v >> 8) {
-			case USB_DT_DEVICE:
-				s = "Device";
-				break;
-			case USB_DT_CONFIG:
-				s = "Configuration";
-				break;
-			case USB_DT_STRING:
-				s = "String";
-				break;
-			case USB_DT_INTERFACE:
-				s = "Interface";
-				break;
-			case USB_DT_ENDPOINT:
-				s = "Endpoint";
-				break;
-			case USB_DT_DEVICE_QUALIFIER:
-				s = "Device Qualifier";
-				break;
-			case USB_DT_OTHER_SPEED_CONFIG:
-				s = "Other Speed Config";
-				break;
-			case USB_DT_INTERFACE_POWER:
-				s = "Interface Power";
-				break;
-			case USB_DT_OTG:
-				s = "OTG";
-				break;
-			case USB_DT_DEBUG:
-				s = "Debug";
-				break;
-			case USB_DT_INTERFACE_ASSOCIATION:
-				s = "Interface Association";
-				break;
-			case USB_DT_BOS:
-				s = "BOS";
-				break;
-			case USB_DT_DEVICE_CAPABILITY:
-				s = "Device Capability";
-				break;
-			case USB_DT_PIPE_USAGE:
-				s = "Pipe Usage";
-				break;
-			case USB_DT_SS_ENDPOINT_COMP:
-				s = "SS Endpoint Companion";
-				break;
-			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
-				s = "SSP Isochronous Endpoint Companion";
-				break;
-			default:
-				s = "UNKNOWN";
-				break;
-			} s; }), v & 0xff, l);
-}
-
-
-static inline void dwc3_decode_get_configuration(__u16 l, char *str)
-{
-	sprintf(str, "Get Configuration(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_configuration(__u8 v, char *str)
-{
-	sprintf(str, "Set Configuration(Config = %d)", v);
-}
-
-static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str)
-{
-	sprintf(str, "Get Interface(Intf = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str)
-{
-	sprintf(str, "Set Interface(Intf = %d, Alt.Setting = %d)", i, v);
-}
-
-static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str)
-{
-	sprintf(str, "Synch Frame(Endpoint = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_sel(__u16 l, char *str)
-{
-	sprintf(str, "Set SEL(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_isoch_delay(__u8 v, char *str)
-{
-	sprintf(str, "Set Isochronous Delay(Delay = %d ns)", v);
-}
-
-/**
- * dwc3_decode_ctrl - returns a string represetion of ctrl request
- */
-static inline const char *dwc3_decode_ctrl(char *str, __u8 bRequestType,
-		__u8 bRequest, __u16 wValue, __u16 wIndex, __u16 wLength)
-{
-	switch (bRequest) {
-	case USB_REQ_GET_STATUS:
-		dwc3_decode_get_status(bRequestType, wIndex, wLength, str);
-		break;
-	case USB_REQ_CLEAR_FEATURE:
-	case USB_REQ_SET_FEATURE:
-		dwc3_decode_set_clear_feature(bRequestType, bRequest, wValue,
-					      wIndex, str);
-		break;
-	case USB_REQ_SET_ADDRESS:
-		dwc3_decode_set_address(wValue, str);
-		break;
-	case USB_REQ_GET_DESCRIPTOR:
-	case USB_REQ_SET_DESCRIPTOR:
-		dwc3_decode_get_set_descriptor(bRequestType, bRequest, wValue,
-					       wIndex, wLength, str);
-		break;
-	case USB_REQ_GET_CONFIGURATION:
-		dwc3_decode_get_configuration(wLength, str);
-		break;
-	case USB_REQ_SET_CONFIGURATION:
-		dwc3_decode_set_configuration(wValue, str);
-		break;
-	case USB_REQ_GET_INTERFACE:
-		dwc3_decode_get_intf(wIndex, wLength, str);
-		break;
-	case USB_REQ_SET_INTERFACE:
-		dwc3_decode_set_intf(wValue, wIndex, str);
-		break;
-	case USB_REQ_SYNCH_FRAME:
-		dwc3_decode_synch_frame(wIndex, wLength, str);
-		break;
-	case USB_REQ_SET_SEL:
-		dwc3_decode_set_sel(wLength, str);
-		break;
-	case USB_REQ_SET_ISOCH_DELAY:
-		dwc3_decode_set_isoch_delay(wValue, str);
-		break;
-	default:
-		sprintf(str, "%02x %02x %02x %02x %02x %02x %02x %02x",
-			bRequestType, bRequest,
-			cpu_to_le16(wValue) & 0xff,
-			cpu_to_le16(wValue) >> 8,
-			cpu_to_le16(wIndex) & 0xff,
-			cpu_to_le16(wIndex) >> 8,
-			cpu_to_le16(wLength) & 0xff,
-			cpu_to_le16(wLength) >> 8);
-	}
-
-	return str;
-}
-
 /**
  * dwc3_ep_event_string - returns event name
  * @event: then event code
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index f22714cce070..6236f0657583 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -86,7 +86,7 @@ DECLARE_EVENT_CLASS(dwc3_log_ctrl,
 		__entry->wIndex = le16_to_cpu(ctrl->wIndex);
 		__entry->wLength = le16_to_cpu(ctrl->wLength);
 	),
-	TP_printk("%s", dwc3_decode_ctrl(__get_str(str), __entry->bRequestType,
+	TP_printk("%s", usb_decode_ctrl(__get_str(str), __entry->bRequestType,
 					__entry->bRequest, __entry->wValue,
 					__entry->wIndex, __entry->wLength)
 	)
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 523aa088f6ab..a33cd2b9fbba 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -62,4 +62,23 @@ extern enum usb_device_speed usb_get_maximum_speed(struct device *dev);
  */
 extern const char *usb_state_string(enum usb_device_state state);
 
+/**
+ * usb_decode_ctrl - Returns human readable representation of control request.
+ * @str: buffer to return a human-readable representation of control request.
+ *       This buffer should have about 200 bytes.
+ * @bRequestType: matches the USB bmRequestType field
+ * @bRequest: matches the USB bRequest field
+ * @wValue: matches the USB wValue field (CPU byte order)
+ * @wIndex: matches the USB wIndex field (CPU byte order)
+ * @wLength: matches the USB wLength field (CPU byte order)
+ *
+ * Function returns decoded, formatted and human-readable description of
+ * control request packet.
+ *
+ * Important: wValue, wIndex, wLength parameters before invoking this function
+ * should be processed by le16_to_cpu macro.
+ */
+const char *usb_decode_ctrl(char *str, __u8 bRequestType, __u8 bRequest,
+			    __u16 wValue,  __u16 wIndex, __u16 wLength);
+
 #endif /* __LINUX_USB_CH9_H */
-- 
2.17.1

