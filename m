Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518FEC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FC220892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L1tXyYtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FC220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeLFJkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:40:43 -0500
Received: from mail-eopbgr790040.outbound.protection.outlook.com ([40.107.79.40]:62640
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFJkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avm82R7e6NiMcx9Co8QQquakBSXE+/JkND83hE+feRc=;
 b=L1tXyYtNWnZ91n8QLPw6ySP69Z2R2272Zd5i2NePY9EP7q9YBzIM/+7IADjmwYIRiflMA5WEJoLM5pRz07PIGqwsQwKsVxfNuvvYJi+CSD81vZCQY6LKKIlkLQtEKRMuGeKsfXCjjEE9jOIbYN8VeJ+JXpKlgpHqHP6jYuLKegU=
Received: from MWHPR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:301:4a::21) by CY1PR12MB0058.namprd12.prod.outlook.com
 (2a01:111:e400:4c2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.22; Thu, 6 Dec
 2018 09:39:58 +0000
Received: from DM3NAM03FT028.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::203) by MWHPR1201CA0011.outlook.office365.com
 (2603:10b6:301:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17 via Frontend
 Transport; Thu, 6 Dec 2018 09:39:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 DM3NAM03FT028.mail.protection.outlook.com (10.152.82.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Thu, 6 Dec 2018 09:39:57 +0000
Received: from [10.237.40.91] (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 6 Dec
 2018 03:39:56 -0600
Subject: Re: [PATCH 2/2] drm/ttm: Use pr_debug for all output from
 ttm_bo_evict
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20181205165621.5805-1-michel@daenzer.net>
 <20181205165621.5805-2-michel@daenzer.net>
 <b0b57acb-7152-ab1a-855a-3de8c77fa425@amd.com>
 <3198051c-c09d-5bf9-e177-3a90b10b4149@daenzer.net>
 <d0990059-24bb-3f21-8b9d-85761f0be409@amd.com>
From:   "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>
Message-ID: <357b0045-d2a2-2246-b69d-19e657f6e843@amd.com>
Date:   Thu, 6 Dec 2018 17:39:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d0990059-24bb-3f21-8b9d-85761f0be409@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(428003)(199004)(189003)(81166006)(316002)(6116002)(65806001)(65956001)(53936002)(97736004)(105586002)(14444005)(64126003)(305945005)(7736002)(65826007)(6246003)(26005)(5660300001)(16526019)(486006)(186003)(77096007)(16576012)(446003)(31686004)(2616005)(476003)(11346002)(336012)(47776003)(104016004)(53546011)(54906003)(6666004)(106466001)(36756003)(58126008)(2486003)(67846002)(2870700001)(76176011)(126002)(93886005)(2906002)(110136005)(23676004)(356004)(8936002)(229853002)(66574009)(86362001)(478600001)(81156014)(68736007)(426003)(8676002)(50466002)(72206003)(4326008)(3846002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0058;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT028;1:WGqItN0JepmF1xKBwkiP08tF8fJ9tmqKMOv01mJVljQg8KazD/4rOG3La2Sz/bxFFF3r+ZZyvgMENcNdAVk+mNebq9pxmHWUx68DNIwulqbkrpmFoOj6mv/fu1DS5JOS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96ddaead-26f1-4568-8db9-08d65b5ec91c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0058;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0058;3:zqM9kHhPQ0gCLbAf1eSTMXHYZ5cH7w09QYZ6zH5Q72YmVlgt3UVSFQQKRi0JP/1GAtmMeKXi1TELQPrZBzA9wCYJzKveSLUpH7xdkHJeJMPkfMedKgaHXCU+woV8VgnL8OSSF92oi2Z8ZdCVVrlQ8fTxfpc8NMjUDNlhNCln+voBDnxpAtF1RqzvW+eH63XrbOqbSsDCdYi2drJBGvq9sbVI0nW98mLZYWbkro9XUPRZWRhJM27vvTRpl/v297LUCWHD+JV05KCJvzgWrQOYeNyKdc4OoNYropkoS8n4ACqhk+1DHr5Gdki/GMPdLNKD4devSqp/9MykIQdvhFJfK2F0n8Wr3EcBHPrzoU8wNQo=;25:+au+jqDu6cCy6Wzb1TyRGBtWIUGmSHmB59Q/HOc2Nit7XE1klwcicfLLmwh2UENh7aTj8UcN6NymoG58BQvMfYYGqc+wLnTkxBe/fwvHYvKzDezURiMeopDjZNHJX2CZ3yQC5nPbL8IhaAo3GUZ88zvfQ+A+j9RnR1fx+11X9+R+r1QpTYfbMq6Bp+wu50NfUtPDhUbUBljOnBFVSzCtO/qVtc1HytRC1PNFTFzXwyimjjfM+IrGzSaQ7lU7d2mEaqO1ZhxkH/e2XpL2jYI0QEv2OwKJjd281+B/1iLHRCJ9KuSsa1tTqAubgNqM6J9i1vWB25OYrQJwOMgwX3XkBw==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0058:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0058;31:U1t3aqeAb4MXUFb386MWzY75ZM2xM4PgRw6QW6oeb3GE5IiX1j+QE3yERsTdAJT75SjxD5d+BD8jQ0CluxJKdSCRsxO9M76Ba7FxMWOXRh93iH2vnQlYZNJcC5H7XyfBbdWd97mYRKAXru5l2f1dJcQNsIw9ffSQn6rGByOvnTW0MLezL0jFriCTk1AY+bxrGAaY1ka+EKY27AEiviw7eqQitkickQEUcmqAAwuVSxQ=;20:SZvaVDjGQ9AkiurZtnsHvVZsGE4xSeEIwEaW0a8TNBVdsNwmXPgjaw8TVXlaRzywADWXBH4Kgaz1UwbII/y0k8s5Y7uTGZ2qxJd2NiFBuopBxmcDhlxmVocKRZiJk3aerUcExaU0jFVJVY0769xXCkh7zM1Q+kClw0X3MGysWBholiIMcausyM9RcWx6wAtZn5M1nJDHf/7Zhkdw1Mk/B0X6P7Xz2WUZUiOkLhUc1TWJ1Yf7T4jos46fRMwfWceVypi0DTaXS9U9tz26kodbkPQAUnu9x3To42OT+i8Knf1nPXHdbdhOMZnLwVcfzv0juXpUjp0T0mwU1bgVJJdYE4c44nu2EZ6hQh2eVsoitAZATJiOf/rokHad6RS2V6diotUdDpQG8xjH1CITwtc1i3CbkgNgD3fquKcFPzsLZfCjNIAQxGA5tiHG6uhZ/fSlCCGluD694AuD/A8Cmw/YkkIbpmVRpsfP26cHE8E9A8n24v5ojfaaW2IfKkBRAQky
X-Microsoft-Antispam-PRVS: <CY1PR12MB005812B772FBDBBA58D18D03FFA90@CY1PR12MB0058.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY1PR12MB0058;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0058;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0058;4:tOex5/CDwPc2+/mVIIQVlvBlROe2KZQFkE7vWWYSY4SKXeau2N+iq49TryJ3DQZxmHRVDllVLgPWQekjGIBBRJfW91R1KRJahSEx0V6HFrXZteobnEcGxASKryXcoAEmO3REEv73PcLSiOuwkMDFYQhjAyBY8Gb6afOQaPHCIE3vXLLdlRPCRJaHND0upe7by3P/HDKxsABcwXh1jN0obw1saFL1B29DnJdcNiWEWLSInDugRpGgxIKoM5l9j/8VeI9NtLXuVc3uTGr9YH/wCQ==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMDU4OzIzOjRHNjlYeTIzR1puZ0ZMeVNkVWl3YnJLd3BB?=
 =?utf-8?B?dGU1L0xxcHZWSU8zdVQ5YnQ2blU2Wm5TcU40dWJQYit5WlB2b3RNNEV2SVZH?=
 =?utf-8?B?SVhYVUdhZWZJYmhPcmp4ZDNVTEsvNVovc2E0RjhtQzZJdSt6WGxER0VNZWlY?=
 =?utf-8?B?SDU2ZHVaNkxwd3k2TkwxMkRaRTFNNFp0RGxmd3JjTmVQTGgrTDRGdXJmNVdD?=
 =?utf-8?B?QXpxS0FEaEdtcnpIOE16NERRTGxDZWlCMUFPRlNpRWhEd2NLRlZldmFhL3Bi?=
 =?utf-8?B?N3hiY1hEbWE1ZmIvbzYrQVFzTnJtbWlwWFQ1eVQ0SEV5S3ZSYUFtbDVNU2dR?=
 =?utf-8?B?ZTc1SEM0SHVzYlJhalNidXFzTllOcG9rUUhzSWR4K3poZzgvWDNyRkxIMFZJ?=
 =?utf-8?B?ZDNWeEhXOUc2dGNUY2htdU02V1Y1Nmw2dWpTcFppTTZpWlN3Y2xkMktXSDg3?=
 =?utf-8?B?MEk4eHhFOURIa2FLSkw1YWVwZ0lldjM3cDVTczlBN2pZaUNwdEF6RU83SVJX?=
 =?utf-8?B?bDJhNUh1YTRBS0laZFJPUndFUzZPdlZGSHNIdEs4WTU0bFFqVDFpdGJXZVFC?=
 =?utf-8?B?b2E4aWNEMHVlZlhZaW41ZStTRERzcmlzcUVPS2JYUi9QblhiOVdjcEFjczBw?=
 =?utf-8?B?b01ZcnVRd09JRU42THpUY1JndFdzbVNna013VGZPYkZhZ0cwUlErTkhUWTJI?=
 =?utf-8?B?OXJac2oyUXJGU0ZOL2ZSUnhLSjBOdUYwOFVCWFpDdUlZcUxQSHlWalQwNlor?=
 =?utf-8?B?RENEcU0xeVgyeWV1cm9XSlZtdExKSFNnWkNaczhOb1FYdzhXUWxKeTJNRktC?=
 =?utf-8?B?alZyTXpISjF4RG5pSFlSaExaZ1FmQlE2eEhPYVdHR0I2aytUV1JQdkl6VklI?=
 =?utf-8?B?NGp0RENIVnFxTE9PNG9ocTM0TGpQazdheDlrMFdFYnJ2NXllaGtROEpNQ2FM?=
 =?utf-8?B?NWdORGpIR2ZMY0Y0SExQVjNlbXNHaDRVc0JuWjdtek9aWlVjVlJ3eXRPZ2d0?=
 =?utf-8?B?aU1XNndSQ2ljWEYyWHV6S2J1emhtMkFIaXVXcURlQkpoWkJyNVdXc3dxUXlT?=
 =?utf-8?B?Vk9vMTg3NzFBUGRyR3VBV0FSdTRCY2htT0ZFdGNzUUtpTDZ0QTMrTHJjRjZm?=
 =?utf-8?B?R1dtemtnY0o3T0lyTkJGbEVBVHErcEFtby9LK1Q4aXJONXNWZDdWZmtlM3ZM?=
 =?utf-8?B?YzUzT1pNTlhQOUNhSXFaSVJIc3RCd2FDWDRRUFVvTXE4Um5RYmRMWjU4UTFr?=
 =?utf-8?B?VGtLUXJGMUFMdy9nelpjUGNQWUNnbGxma1ZwdzZnTjBOeGhQZkZqMC82S0J6?=
 =?utf-8?B?ejVaMk1XYW9DWEZ0czdRM1JLT3VYL1NNWWFsM3A0QWN2SkZaa3dlcHc4MTUw?=
 =?utf-8?B?MVE2OXo3U1B2SytzamNqcXJPR21ONE9hWHY0S2NTaTErem9LTlVlZ1NJbVZz?=
 =?utf-8?B?ZGdZZ1hhV1RPRXNSTnNoZzFXVXFVQmNXRU03MUQzU0Y3SGUyWWo5aHNBQzlE?=
 =?utf-8?B?b3pPQm9wQnZBTFNwMGh3SldXY0t2ZkkzbFdtTWk5NEx6THYrSktuSC9vTzc3?=
 =?utf-8?B?MUsxWGFja3VMTFI3MFJZL2FHWXAzTUlybXoyZStYRXdGdkh6NlNCL3JQaXFT?=
 =?utf-8?B?Q0hXQkpDRUVlWTZjd1h5ZHFpc1E0QkQ5enk3d0dnQzdZMlFPbythdGlFL2N3?=
 =?utf-8?B?WFUyN3h6VWp0akcraXF1enZTQTVlYUc3eXB4MEw4YnVJWTlYSkwzTzNRNjMy?=
 =?utf-8?B?cVBJb1BHalkxSzByaWU3RUdqZURDdzFRektxUGpSNlNEMzZmNHU0cFlkc2pn?=
 =?utf-8?B?SVh2N1RPVXRYYU50akI4QlRRNmFZTitTZ1hveS9tZ2ZldGVrV3RQWGdWOHpS?=
 =?utf-8?B?eWhkUWxPK0MrWEhtVWNIMGUwbVpJaFFUOEtxSTVuVWpibC9QVzdVQ2hqM0ZD?=
 =?utf-8?B?eU9mK3VQczNMZWhSVkVVSzJ4REoxdjlEZ2JiNHNrdnlTNnJVUFg2OTcxdVhQ?=
 =?utf-8?B?VjhaTDNHeGV1TDN3MVhIcVpnNXdsbzBLelUrdz09?=
X-Microsoft-Antispam-Message-Info: AHpp9w1fF5xLh/YXk8wTUw3fczS4JxU9oHqGdI3EuKJEPh0Rjkk8PBEbOWyMj7rvwIsb7h5O49gqFbWXMnDVBxNe/ym0IrRohwPWVCQry9L8lS9kzjzNJ93ULR2mGcoFUxhgyxljoKFdjCRHuVIqaYhZiL0fFxwc2Mzj+3nLGgOB21KzGj43Aa9rjNwr7sXKDCtdbJn2AY+XUWgphp/OKVtA2GfeYdzzPnjNDAqyGUpTRAacJTTBVYqhNY9QXN+oCTxtA4lxECfBcfZa6cvU+zp1KYmoW8p/+xFE2ddETTxY/QHHCXIO1coEY8/PX3teCeszMqpIQ8n8EqIKh5BrWQ3rb7GqQi68m9/H+6iuhn4=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0058;6:0qYdz+8tUfm3oFUpOVyIAX9xRQI1zS0CYyTcK8HDLz/xB0SQwURYUDq1HtXsHjVHvRViRAfUwSKp6S1dm9nU20p1BFFtz3f54OuBxOSh2dTAdYfjbvoliZ23hfZD9AAKnJXGp+xkYZipuZJg7xATZVoGOgJT01I1xgJpzaxiMrKgx+dOR0kXKpee8jTmXlvqRi2m+QAIbFsmSxsZ7VczXmGVt8KkGZQCcKcGmFVQcUOBFEQjQwKkqFzdAsqyold529dzF3ehkOmvr5/V5old/E3OJe5uUE+mrIHc7HDOyfWs8zf0ADTMdiHAaXvcvctcaBfuHHZN5RysbOun+xXY5dD9phQ1OgsZ3JfXNmUKtDo13dyy8yJ3LlrFsiuZhZffzXYSYyOqXy64rNVBW+ok9MKbWrUm1thMBZtW+Uw8PP64E8b4GEqHMxcFQB66LW/dt2nu+UKc1ifuzi5Z3sQAzQ==;5:PkNHPiP+L7Vd/5iH7vWWDNfpQbNrcsr02Vb8AFvK9j3scQy6rNq0gAoIVBykBKdPVzJxpOHsmlcFxKy2/NNuiMxM2+sNMLuHnNmC9UxpGmKkqwjJpD9XLeeeoZcBjnGreGiUVjmEkgjLnCpI4BSp6Rj4/KrRynJsxuy+SS7tQXQ=;7:K9k82KoN8WoB1z5ziEjRqtEM6c21dcaCmho1kmayvgMX1crUuY2Qvse6iSl5MFm99rIwz32zq2Op4dY1VYE+fY85ADkDaE2VvFuH8csOwOvws4V7Dsus5TdtwkLf91maSmpXK84U5jTdiYrFTuH7zQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0058;20:p+2lckgN/vv44yhxRuNCiC+NxflsnhAVr63ZJhKrwuU5Dba8AiMq1Z0DSH5wzRuJB00eFo5X7YfL+5h07BbklsqGeHGuOX/nO5+R5yYFwK/Z365LBZ+ba9VfhRQdQlj+OCHSYV0n3VuRpPpcxUVwOgwwERv2U0/jU1QvCUgFpbo2rIcboCDUB+tXF0FBQnuaJncbHin0mEPrSGE2pY/0CFaCy4SIccDQWuBzB2nJuBKDoaYfF0hpKhHaVdAgqSF/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 09:39:57.4273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ddaead-26f1-4568-8db9-08d65b5ec91c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 5:33 PM, Koenig, Christian wrote:
> Am 06.12.18 um 10:09 schrieb Michel Dänzer:
>> On 2018-12-06 3:43 a.m., Zhang, Jerry(Junwei) wrote:
>>> On 12/6/18 12:56 AM, Michel Dänzer wrote:
>>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>>
>>>> All the output is related, so it should all be printed the same way.
>>>> Some of it was using pr_debug, but some of it appeared in dmesg by
>>>> default. The caller should handle failure, so there's no need to spam
>>>> dmesg with potentially quite a lot of output by default.
>>>>
>>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>>> Sounds reasonable, but personally prefer to show error when some
>>> vital incident happens, e.g. no memory on eviction.
>> The amdgpu driver still prints these in that case:
>>
>>    [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs_list_validate(validated) failed.
>>    [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Not enough memory for command submission!

That's from cs submit, perhaps it may come from other places by 
ttm_bo_evict_mm().
Is that right? Christian.

Regards,
Jerry
>>
>> That's plenty as far as I'm concerned. :)
> Yeah, but in this case I would rather make the amdgpu messages debug
> level and leave the TTM meassages on error level.
>
> Christian.

