Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E819EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3C221582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Sa9cHcxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3C221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeKLRtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:49:33 -0500
Received: from mail-dm3nam03on0075.outbound.protection.outlook.com ([104.47.41.75]:44930
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbeKLRtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sp6Is+ILbYOC29HboFP5QJFwmmq5BDYpZ0rE9CzmXs=;
 b=Sa9cHcxxec+OzGDFp2fYPS7MVKXCPhtnsUAPT5RPKyRjnESWDP8YY6uGmOneoqW7LnVVogKGhGYWsZK2n+Ror2fQMqIxSbHFRQ7/F5Nu5W5kULFZlyD+3eLor1J/oK1gxdS0qNmDwRTW0yFFN6Qe21+TbBms88NeAI0MMDumhJk=
Received: from BN6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:404:23::14)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.28; Mon, 12 Nov
 2018 07:57:26 +0000
Received: from BL2FFO11FD027.protection.gbl (2a01:111:f400:7c09::111) by
 BN6PR03CA0004.outlook.office365.com (2603:10b6:404:23::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.26 via Frontend Transport; Mon, 12 Nov 2018 07:57:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD027.mail.protection.outlook.com (10.173.161.106) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1339.12 via Frontend Transport; Mon, 12 Nov 2018 07:57:25 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wAC7vOxq025393
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 11 Nov 2018 23:57:24 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0210.002; Mon, 12 Nov 2018 02:57:24 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/2] staging: iio: ad7780: update voltage on read
Thread-Topic: [PATCH v4 1/2] staging: iio: ad7780: update voltage on read
Thread-Index: AQHUdTvejJfp1mcJpU+n2xq+NR6i/KVCznIAgAgxGoCAASR+gA==
Date:   Mon, 12 Nov 2018 07:57:24 +0000
Message-ID: <77b195ff53f05d3a7d98098810c5d2d4af3b2e7a.camel@analog.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
         <4b47bd8f4bac2575b72529b37e5ac90bebae2446.1541444377.git.renatogeh@gmail.com>
         <30c1ff317baefde88a0f4d0a002b19010290d16b.camel@analog.com>
         <20181111142939.316cdd47@archlinux>
In-Reply-To: <20181111142939.316cdd47@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B6523D794A857408A65C65531EE49E4@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(438002)(189003)(199004)(52314003)(4326008)(23676004)(5640700003)(118296001)(6246003)(39060400002)(26005)(7416002)(6116002)(14444005)(14454004)(2486003)(4001150100001)(6346003)(76176011)(15650500001)(47776003)(102836004)(478600001)(106002)(7696005)(2501003)(7636002)(7736002)(246002)(50466002)(106466001)(86362001)(2351001)(2900100001)(356004)(36756003)(305945005)(316002)(5660300001)(6916009)(126002)(11346002)(486006)(446003)(476003)(3846002)(2616005)(336012)(8676002)(186003)(54906003)(426003)(8936002)(229853002)(2906002)(436003)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD027;1:2FF7e4Jro1VE1GICqMHhIMOdWmEH4rOuWW0Z0x3M8r9I0kiRPAO3OTjOferq83bUgRty4rHy4bTl65l3w9QA8H/6NR0i3BacLW1pxqdYDtgsAXz0IjcxXUApbDjWkplh
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d71c3244-21da-404c-0b6f-08d648747c1c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;3:v6hAKqnZmpnSnlH890uUAIO3Yq4x6ElhAuu95pDrkysKV7KR8X84AZwoJussGBGi9zTrQ76RG5fZkti6nAOvt8QPU44qVQGhhgSwDROqr5iaWhr7n3KUI7ziY1OCFBNwdL0wa+BGRuyv9MMqyyPvPhZDw7FXK3hmR5I13s/GqORrMF9WYWPETgHQMBbNKNLOM2rBGN5NqR94WcPLZ7HUkQ9dy+AJ+O3BQmoMepCRGPgBDgwFEiJ7yha7EKvWSR/wQvm/Mr6vCNeaOhuSNX3CqNDTRkh7zgIrfMc82ESxJIUoyZ0fCpnv4OxD30APrRIjuzXWeNrp3eHP3qDOR+gWud1Z+/VQUEidxjLsoOQVjKo=;25:lMHwODYmNwZtzcEVtZ9VizYARuRJzr3KJND3FyGn8OGyhEN8NfBAI7fnTnPbTf+ZSvktuqleZCy94EpUOEBN/KYQZddYhSJwU1RewCLfjJ6x0HHkrNu8wh4V9G74XEecsc+fvwqHxwD2po1MsWjb8qXJAY6mVN37NLKb9uzVNxIIi9VBDLJXYBzyR19LiYhsh1uf9JzpkJ80Op5jvSogP54e9ASl4JtxQkWe3q2XA52skesVVcge2ZzufGgLjJDMKKcPHIhDvlbvM6k/Yy0AWE78COymhVJZYBqcQxEfMicI3rkgbq/cXg1EGoYlsmSRonBuKp/O5K5P5ByUn1oKIyDnYlL1bxEolEsm0W0mkq4=
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;31:pge/GnP3gPAXL165+WVfK0oJ6PT6DUoR5++rTYrlP0B5avbk+A2oDxA26n47QmjtpR7fAsM09y/2NFWy3wqIRyoeAEiicbrkH7DSAnMi836cRh5lvGrB359U2JNqzRJgz7spwauK+KfnaEnttz8CS9/mlp5UmkQBd9UmE8mXQQtbWSI3kg55Z9euo8nopbnCCPkzBQ1M2WuLiyCzJYa2MhSxd6LXoK47qGt3YH6r1qM=;20:dpL0r5WqXlxT3+61UZRf/AkRdw0ZnHHHa/vtr2dyfSoJwfpTW498FTgKD5GAfbcZrKipwjvrw/SZGCau0H9FeB7oqQhBnvpdiKVHxBjKeubRGCp0//JwDCXHOp1PyaZaDQ/hPT5txmRW7qm7CGKx9CrlqulSb9E3fbSGWul87ciBTfUiRn9BamDgA2vPeYjm5ZIDBcg5wZ/v4zAg+0iwA1eejytGfrBVjyv0gKkqQiY2WV56SCV46LHNHUVZD5K1SQA36a2lMyVPHOwhTs18oDheuaTBjt3cRlTN6+iF3QWSuhfjJQf1rz6yplepjPbUH7j5siuS0+rQFfJLuoP/xjBIKZMBDhmm16Lc3NwOfEbnmIRSeFgfCz2MflFps02tcSdnHP+60QFoDqIvWiCspk4EW4asZofDGIzlD+xf9Opol3YiCqj5ZPKxFypWfgx1mqmhw3Orc1ZRqeB7LdJPtvAFbLuepICoPyaQ4b1/Y1fuI+5WKZGTQBgjw/fe05VT
X-Microsoft-Antispam-PRVS: <BL2PR03MB54692AFA4F8D8585E767B57F9C10@BL2PR03MB546.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231402)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL2PR03MB546;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB546;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;4:GMWUL3xBTPzf0k/48gwFUKC8K4vDznuAplF3su6UafEQGpVIluE6GvFv+mcvI9XG9J+BBnPhHbFUTYkgtNAS3hLvo9GbCSMP6z3Vo4LsBovU0o0aEsE0g8C9599a8qLNtlEfvU34zGKhFx7hIaAaQb/Ptt2G8gfejsjVsAQX6NGy9oBeQOHTUszJN4xCCn0UrtPvVT7lTejbwTzngjjefAKS4LXyUmuNJ1o+DStKcPCserRDp7kN9EHu402J9WjQGXL+uZmlfyJNcDayz5PB2gPOWVNdg9ebHuLZR4U8d9pweEwI8Am32BmJMhZuKTjz0McBtxsYExAMJZNs4RYwHtKn00ifT8WxwGMD7GBP5yk=
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDY7MjM6eURWZUd4ajlFYlY5MmpabUk3NkNpOWE2ZXRG?=
 =?utf-8?B?M2lXY215TW9FTUtob3o1WGhYdGI0T1dtL2F5bHdVaUJsUUpnZ1N5bGNhRG5G?=
 =?utf-8?B?eUNOd3FtWTlWcVpPYTZwT2FkYzhpYWxyQ3RVcDZNZ3N5WmZwYS9IRFJ5bFJ0?=
 =?utf-8?B?cVBoeXpsb0hhWkw2U2l5NWpXdEozYW0xN3BOWUZINXpGUEd0aUlmVWVxVk5p?=
 =?utf-8?B?TzFkSEt2ejFlMlAwZzR4N3B6YW4wdVJYbFcrL0xiNEd6bWFKaTFjcGoyQXVR?=
 =?utf-8?B?SThkaDJ5aExTUDhvRU1sNUREU1QyNFNMVkRNVkVxdnpVU2l3UmYwRTNZcElT?=
 =?utf-8?B?NWFMTWplZUxTSkc0M3A5ZFdMRzlkNzl3allkalJHd3Z4S2ZML1I3eTgxdnlJ?=
 =?utf-8?B?TDZpak1mWW9YdXU4UlNIRVpvSXFWMHYxRzBjM2MzMVpBeFdUbzZTV0Z3QXE5?=
 =?utf-8?B?TFRmQmlycWVFeUVxd3RRczdZdGdJZmdZWk1hdXdHeSsxMlFVM3JRUEZsOWxO?=
 =?utf-8?B?QlNWSitNajhsSTd0bjB2dVkvNk5vZGN4dHJJN3JxaEZ5NXVLMjNvYXJnNjNG?=
 =?utf-8?B?T1JneVQ2U0VPQitZNENWWDZMOGJtZEV4anM4dmdWUXZ6eTMvak16cjRieW02?=
 =?utf-8?B?MmpZUzB6L2JFUSs2NXV5TjRUZmVlYXFJdTV6cWJmSFF2bDVYS2t2TmdTL0Z6?=
 =?utf-8?B?ZlpTWGFZMUMreWxraUUrb0JTNU9vS0JheXhaZDMreDdqUXBmMndIOVB6Qk1k?=
 =?utf-8?B?M2hhcVdtNXpWYS9XMVhIeXBZc1U4NDZoVlJ3RG1kSWZTd1kzdUs0aUpRcGVy?=
 =?utf-8?B?TmRpRDdOWmFNRUJXZjNIaWxiMEwwcDVlSG5WRUhmaDF1b2ovU2JsVHF2aDlS?=
 =?utf-8?B?SG5OL2ZDTUhvMCtyZENzTVJra1pRdUVNNHhJby8zK3hLOUNkeWdWNXhpK3g0?=
 =?utf-8?B?SjJvbTJTY1FWdU4rRW5ZOVRkUEZyQk9QaXduMzBJL2dlbGlUMFRQKzMyUTZF?=
 =?utf-8?B?V1BxS0xOZTAyck5ocFZyeGlsTUYxR3VVeXVLQzJEUGxzc2NGbjluMUJNOXVN?=
 =?utf-8?B?V3ZZc2JtVXZqcGx1eDB2SUk4NS9ndWlXcFk1OUhkRVVXWjNUcVZ1WWkydGVD?=
 =?utf-8?B?Y2lQbDN5dTVERnFDejNaQkhuK2VzNlNtY3VkOVZZRTI2SlhYcUdXbXRpZ0RG?=
 =?utf-8?B?WkpLZEQ4bWtzbnlqdUtTeDVsRGkxTTBxU2F1TDFEbkVPY3RYeUV5N3dKQVps?=
 =?utf-8?B?Zkk4aGU3NStiekZrTWhjZnk4VXMzYUowMytSVS9SYzFKZnl2cFY5eUE3Z2hE?=
 =?utf-8?B?TThrR2czYVZzZ3RXdW9sY2VmV3VtT0pqNmt2bVlrazBGM3dmWHdoZTl5b3RF?=
 =?utf-8?B?eFdNMDl3cEhXYzlFVU5CU3gvUFQ3TFFHalI0YklqVzdvdVZ5eXlYWUpLL25q?=
 =?utf-8?B?cVZuYXY3Ym5CWGI0enhyNjJlNCtTKy9BcXNpOE05bENMdGNBN0Z5T3RXa3BH?=
 =?utf-8?B?bENrOVlPMTVFSktmU3RBMyttOW5RVEltUGJJdExZcS9GRXFpUks3T0VGWlJm?=
 =?utf-8?B?NkN1NkNVV0o3Si9xdmhLY0llOFAxd3kyRHR3akZKN2RKaVI4d0EzWERFOGNP?=
 =?utf-8?B?elluV3doclBNNDVjaGp2QjdXV0pJeTRwbUlNRHpQdmYxbHE4NEtaem5ybFBF?=
 =?utf-8?B?cEVBeSt2Z3djWmNDRDlhRzlFLzNLODViNVFoT2Q3MzlxSk04TGtyRGcxNisy?=
 =?utf-8?B?bjZLdHlsa2h1clZlVEpETXA1R3VDMXJBZzJtY09GSHlqTThLQjNvTGdOajJZ?=
 =?utf-8?B?VENjYXM0SDNOeHhhN1BzdVRUZm56WG9uQTdwMUkyN2NMQjJLWG5YaEJmVE96?=
 =?utf-8?Q?64IH8pNAJY=3D?=
X-Microsoft-Antispam-Message-Info: JDFL5GJQPOgmhjX3tENGGAtjfMurkOZlSKbzIz2vcU79M/u+AUojfpOF9kGyMD0gdVp6NP32VodJOKTx35dEfnpPppBW3IcnWWU2KTscu0hbNdrB0K0U3fUsOEv7kElYWX1YZva80aOB5hYcv2G3oHjGunymvLbO9t4RK4aJFGFo5VLzWjX5RioBz7VgNMibiBDN8yu7ZZo2P7VpphN8kUHRpGe4Pqcqn/paPPbhmVA9mxMTOGx75rFIUHnB6Ym0Pqqy/tuvagupgOQnl8HMfDr3zFkma78vuV/EyTJer79zmi6tCNvgEW57hE2EKJOBKUGJIL76Rhd9MoCkVdD7+s4svyo8v1GJHEr7xVBqAc0=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB546;6:hRUFOOFONbyYaWP1/jx1J1rZZRd+B9lLKvgLYnLPtMicKgL1pOPUgzTySPN14fcersKjaDtcfWN/FzzrbyvNIyYStdxbAM8Nl9oyOMe0xokzrsiyYCmqQONfUk/N4YlT81NERlkZLIDLf8/F7py46LDp7vKL5jD/K2I8e0wqVgaxfFJUGTLFGWuzv8iEB2i+whIUSeekU6ZdhHmSYPE726d2EXxO8R5/Qxe7kiBxiuESv5uCOn6NkebrGTkHi/9gaZ8A1aWiTO4fq4SL18WUPPh32Ih1q1jPD+O7R+l+5/pzMx4trneMVoMcMFQ/D/9ZFoRA4rfwWeZXCjoLbNBqYaWQqtar6D5Gtpc+Bp/8yY17oTnJVq+YrmA1rXQ/EB+nkzbSdLETxtG/bds4u5VoiiU4LvX2wGet9mrSczUj9azLCJutAJZJrD+nLQaaEF1NBIoPri5ySErT7vqXGvdPGA==;5:fM2YK5PLkZdogNfpSgYLETxJkBPAJVUrqBJcft74GXLCaxLR9iI8CHhYrq1F1nnAgV5eOHwq/MSWzuJRDA/JSBPT2vtzGh4sTCPClhnRMZek1eGfsAvyfGnMBMlxJxitdN8jxVT6CJ/fPxypyj8gCzdR+8GelZNXQ0spjab926s=;7:5t1SVgzQQ9THOR02xM+aGLWPTk771V3VbeLIBljB+JslF5mt+H7XiR38UjOEnWuXGiaDUC7nmjAhpht/97FHLHMVJQZYw7YVirQ92SL5mMvzd63VoHMJCXbVhI+O9MnJ2BFqW9FYZkw9i0xMzsOW5w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 07:57:25.4185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71c3244-21da-404c-0b6f-08d648747c1c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTExLTExIGF0IDE0OjMwICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDYgTm92IDIwMTggMDk6MjQ6NDQgKzAwMDANCj4gIkFyZGVsZWFuLCBBbGV4
YW5kcnUiIDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9u
IE1vbiwgMjAxOC0xMS0wNSBhdCAxNzoxNCAtMDIwMCwgUmVuYXRvIEx1aSBHZWggd3JvdGU6DQo+
ID4gPiBUaGUgYWQ3NzgwIGRyaXZlciBwcmV2aW91c2x5IGRpZCBub3QgcmVhZCB0aGUgY29ycmVj
dCBkZXZpY2Ugb3V0cHV0LA0KPiA+ID4gYXMNCj4gPiA+IGl0IHJlYWQgYW4gb3V0ZGF0ZWQgdmFs
dWUgc2V0IGF0IGluaXRpYWxpemF0aW9uLiBJdCBub3cgdXBkYXRlcyBpdHMNCj4gPiA+IHZvbHRh
Z2Ugb24gcmVhZC4NCj4gPiA+ICAgDQo+IA0KPiBBcHBsaWVkIHRvIHRoZSB0b2dyZWcgYnJhbmNo
IG9mIGlpby5naXQgYW5kIHB1c2hlZCBvdXQgYXMgdGVzdGluZyBmb3INCj4gdGhlIGF1dG9idWls
ZGVycyB0byBjaGVjayBpdC4gIEknbSBub3QgdGhhdCBmdXNzZWQgYWJvdXQgcHVzaGluZyB0aGlz
DQo+IG9uZSBhcyBhIGZpeCwgYXMgbW9zdCBvZiB0aGUgdGltZSB0aGVzZSB0aGluZ3MgYXJlIG9u
IGZpeGVkIHJlZ3VsYXRvcnMNCj4gYW55d2F5LCBidXQgaXQgaXMgbmljZSB0byBkbyBpdCByaWdo
dC4NCj4gDQo+ID4gTG9va3MgZ29vZCBmcm9tIG15IHNpZGUuDQo+IA0KPiBBY2s/DQoNCkFja2Vk
LWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0K
DQo+IA0KPiBNdWNoIHByZWZlcnJlZCBpZiB5b3UgYXJlIHdpbGxpbmcgdG8gZ2l2ZSBhIGZvcm1h
bCBhY2tub3dsZWRnZW1lbnQuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4g
DQo+ID4gDQo+ID4gQWxleA0KPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmVuYXRvIEx1aSBH
ZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgaW4gdjM6
DQo+ID4gPiAJLSByZW1vdmVkIGluaXRpYWxpemF0aW9uIChpbnQgdm9sdGFnZV91diA9IDApDQo+
ID4gPiAJLSByZXR1cm5zIGVycm9yIHdoZW4gdm9sdGFnZV91diBpcyBudWxsDQo+ID4gPiBDaGFu
Z2VzIGluIHY0Og0KPiA+ID4gCS0gcmV0dXJucyBlcnJvciB3aGVuIHZvbHRhZ2VfdXYgaXMgbmVn
YXRpdmUNCj4gPiA+IA0KPiA+ID4gIGRyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jIHwg
NiArKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2Fk
Yy9hZDc3ODAuYw0KPiA+ID4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiA+
ID4gaW5kZXggYjY3NDEyZGIwMzE4Li5jN2NiMDVjZWRiYmMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9zdGFn
aW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gPiA+IEBAIC04NywxMiArODcsMTYgQEAgc3RhdGljIGlu
dCBhZDc3ODBfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYNCj4gPiA+ICppbmRpb19kZXYsDQo+ID4g
PiAgCQkJICAgbG9uZyBtKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IGFkNzc4MF9zdGF0ZSAq
c3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ID4gKwlpbnQgdm9sdGFnZV91djsNCj4gPiA+
ICANCj4gPiA+ICAJc3dpdGNoIChtKSB7DQo+ID4gPiAgCWNhc2UgSUlPX0NIQU5fSU5GT19SQVc6
DQo+ID4gPiAgCQlyZXR1cm4gYWRfc2lnbWFfZGVsdGFfc2luZ2xlX2NvbnZlcnNpb24oaW5kaW9f
ZGV2LCBjaGFuLA0KPiA+ID4gdmFsKTsNCj4gPiA+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX1NDQUxF
Og0KPiA+ID4gLQkJKnZhbCA9IHN0LT5pbnRfdnJlZl9tdiAqIHN0LT5nYWluOw0KPiA+ID4gKwkJ
dm9sdGFnZV91diA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShzdC0+cmVnKTsNCj4gPiA+ICsJCWlm
ICh2b2x0YWdlX3V2IDwgMCkNCj4gPiA+ICsJCQlyZXR1cm4gdm9sdGFnZV91djsNCj4gPiA+ICsJ
CSp2YWwgPSAodm9sdGFnZV91diAvIDEwMDApICogc3QtPmdhaW47DQo+ID4gPiAgCQkqdmFsMiA9
IGNoYW4tPnNjYW5fdHlwZS5yZWFsYml0cyAtIDE7DQo+ID4gPiAgCQlyZXR1cm4gSUlPX1ZBTF9G
UkFDVElPTkFMX0xPRzI7DQo+ID4gPiAgCWNhc2UgSUlPX0NIQU5fSU5GT19PRkZTRVQ6ICANCj4g
DQo+IA0K
