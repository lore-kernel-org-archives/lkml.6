Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BozdBmppGVvrMgAAmS7hNA
	; Thu, 07 Jun 2018 17:21:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9E533605A2; Thu,  7 Jun 2018 17:21:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uw6CCLM5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F0623608B8;
	Thu,  7 Jun 2018 17:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0623608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933407AbeFGRU6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:20:58 -0400
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:41184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932804AbeFGRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5fda7enM++fymCekgRErSboLRnBPaQpyvEZl7JZId8=;
 b=Uw6CCLM5kKHhGXHFo8dzROFeJcmjdxGslTqfMnOI5Tn+1OOaZx2+Xh3MsOgBEYT+qLaeMUwXlqV/iu/Gb/PSUQcTbj8RoWOHE9c1xVwpfbRFScuJqV8E53h8B9YWrfHDjcPYH//DWIUPSoeGrGrp0IwpCWGRwPM+rKVLbo8/Tuo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 MWHPR12MB1728.namprd12.prod.outlook.com (2603:10b6:300:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.16; Thu, 7 Jun
 2018 17:20:48 +0000
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: Gabriel C <nix.or.die@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com>
 <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net>
 <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
 <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com>
 <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com>
 <CAEJqkghgkDeZheZsFC3rJ3W5Z-5DYdqA0U+zas0voDp7kSdORg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f3ae499f-c78f-4d65-ddfe-b74468b0fd81@amd.com>
Date: Thu, 7 Jun 2018 19:20:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkghgkDeZheZsFC3rJ3W5Z-5DYdqA0U+zas0voDp7kSdORg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM6PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::39) To MWHPR12MB1728.namprd12.prod.outlook.com
 (2603:10b6:300:112::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1728;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;3:9UeoS8Gb93Q8rIY7EzPsRLHmChStVZVSRDnK+nKdYKu0w50mogkH4/NBS+cp7ZbJpM/zgpqfWzIccqEbD6y5I2zJ7X+eB+r1Ssrqi7IK4xUfOiWSSAkwShmc6dgnVo0Glt2T/9Ed6aTnUePRAv+U0ED+BLpHrkbMsQHmq5ynFJ6k+GJozxZuwI7uA2qMWvPwN0TTrrAKViwV0oB9VhbPXKJG6qgZo2ufHSMJ0VeEGwOZ9aOngbFpfBR0JurKRago;25:o7IYXH5p49Zw3bMBnQV6URlOdVPNrxiYlAZ9hiYaDrUPWwmGipGoeuk1Lklb+9NlSxM6/EFxMb/olCeh0BprQR9gbpwPwnYZ9vuKpuBMTe2wZ31DhtSf8hqWS8EqcmZuaZA4UgnQizeOipBYG61GP2OVIUzWPnzQnoSWy2X6/4+mXr2UYHjpQNerthCK/+r0tUNMzXHklguQotr+eA/zq/eRo0dk2SICUjPuJCpjyM1pyG4N0xLERxwYGSc+wv5s61IWX4URBRvIWU2dobyWsrcT3++NLoJzdP48CSnTi0Yo5TSGjDq520jhjruzal8vBky+5EN9Thh6nkIwZKprig==;31:cm4xWgPUJm0u8penx9doYhUBLZ7AgFA7G8xSqOXAs7ZFel8/5ihRrjVI1bTFmwdvIUO2+pWXSorBbaC0hfwZCwYDG+w4eUOjcixUFTMle2zIaeLN35IqbIKuNFVb5WFqE+9ColLXFETxkkbTvQu+Cgx5abE4VVjai1E6r1j/I3MZumCx33AK2795wKLomMCTe9nwqnQ2yH3/uSmAbjGQKkjw+GGN6ySIrIOGDZJYEoE=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1728:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;20:g5DtXbCplU2r2kUxeEV/Y3Z9J4zsuRAwfu+uk+asyLXCkYbjRh7xqdud67x9z5Hx8gySzJl/BNTRD8CGZwWiLxzCpAI1/mRfAZod9+PILzj8e/Hj+aSXoIr3Sj7TxmwVTKUa/cJEYzACo4bMzXzHa1e8luA/CJSiap0VlBZgQYeS2Zu9jWAaaLDjPOpsauyhPL/ysySUZxpgbkoNtObIt0vZn60VHZVLsiSgmu5x8tMr5KgArnBhkk+qjsiXffgtZytnye/Ya8caebOEFY9qOal4gOst8Zw0skmBqToEi0HfeBDGySC2mR6m1oX7A8Y3UCFtOnx8EtZhfa3aJTEKsEHnFP0uaqvnIwnEBB1FIb79OxviZbkA6MugOyIcT6mNfQ6a93bpPGYppDZvjZHWRhZ5DqePMoS/SSDMs5Cf3zGKNI2eBn1hV4ALxzAQi8HyDnWSHEwvCkebm4scB3wxXLd9KetUj/iQq8o7Jvs3SL170mrN0YSmxo9aXP/godD1;4:qFkL4NknRbLiQ/qT6gA7Ek/z6jGXuz2fIRdRVxUMPxpHjQuxGZRStfXnbsNux5McJW+1PcsPilJ3vWo5hMd2RG4OVdUTnpNYQKKcnufet2wydy01XCdskDJYvXCGQ9uxJaLnak7h0nS1OlkM0K43av/Rc7BKF7NfqjMjXu98qytVNll+Rv5UQAdvlYqPQ3zRHC3wGFZQVcLQIx0mUZUHKFP8LTAgtZ7nBenVhvLp9UJCG+nU5CFfJ1PsuMcvWQmcVR08EOzonDyVE2113/0hhiR6UNVvzwV856+KuL43aEu1M1KP3c34dCesOmV8KNQTE0kvbuqIsvxmUHNOwsKlPstlfBwm8CIc6Dkzbj8hOsZX7lLXHMrKMSaNj1oDYtS4
X-Microsoft-Antispam-PRVS: <MWHPR12MB172825C1825861E1411D2F0D83640@MWHPR12MB1728.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1728;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1728;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(386003)(59450400001)(8936002)(105586002)(229853002)(8676002)(186003)(76176011)(25786009)(2486003)(52146003)(23676004)(81156014)(81166006)(52396003)(52116002)(53936002)(39060400002)(50466002)(46003)(16526019)(6246003)(97736004)(4326008)(966005)(5660300001)(7416002)(6486002)(106356001)(65806001)(478600001)(65956001)(6666003)(68736007)(47776003)(72206003)(305945005)(7736002)(6306002)(65826007)(31686004)(11346002)(230700001)(446003)(31696002)(2616005)(93886005)(86362001)(36756003)(476003)(58126008)(316002)(1706002)(486006)(2906002)(110136005)(6116002)(64126003)(54906003)(67846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1728;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI4OzIzOm01ZEFWQW82NzZBOUxyNXlpajdIMFJUZ0Vn?=
 =?utf-8?B?R1RUT0JnVG9EL3JWSkgrUmJoazdaa050SjBmSEhJeHBxUEtWM2F2aUhObi9z?=
 =?utf-8?B?UjNZbUUxS2R2alRRZHh6QTVWZ1U2Z09QWjJIVDlMcGpFNzR6VWIrb3FOYitt?=
 =?utf-8?B?YldZaTdNSWRaR3VuS3BJMTVmYTJXNnlCMmh2RERKczB3dktYNjhLZU8rT2NJ?=
 =?utf-8?B?Z01IQzJNZW0ya3R0cUlha3F0SURaR0htNFpqcUdBblh6ejJlQjJsNmx6TWl5?=
 =?utf-8?B?WnVUVFI0M2ljSjA0MENxdUcrZXJwUy9IVXJzMUxtRDNKaGJWbzAyWFRHYzZt?=
 =?utf-8?B?cXhOQ0FCcjdQZ0x1RHRsUGZ6a1pXQVRKdEg4NUE1OGlyNnd6WEhTSmkrdWlz?=
 =?utf-8?B?SlNtbFBubk1Ic0dQYnh4NUtuQ0NtZTBseTZsQ1BYZWVvM2NYR094Z2M1bW5u?=
 =?utf-8?B?N0dudkNWQWxxTFVzdHFtUlJhTkxZR0pLQldZOHBqd3Q3blhmSFdPUU9YU3dI?=
 =?utf-8?B?SnY2bFFTY01QUi9nOUNYSng4bmpDSXQvVnpMVG9CSFJvUXE1RUZDbTdNNjhE?=
 =?utf-8?B?eXNRQVgyNEJqMDhxM2VPNlRMQVpQejRqRVJTMVdmRTdLWnQ5VitaeVpVQjdh?=
 =?utf-8?B?dGhwcGJNSWhPQlMxU0hTWnhDVDdBQk9jOSs1UmJDbzh1bDNLZEx0ZnI4S1I2?=
 =?utf-8?B?eXJIeGhwVkp2RExqZGRycnFqQmxkV21zMEplaDBCU2RHOUg0SGZNQmtSQ2Qw?=
 =?utf-8?B?djZmN1F0bnlUVm41M3dLMWM5RGh4RXhGcXEvdVY4VmRYTDFvQmdnTlpReG02?=
 =?utf-8?B?SVVLc2lSakJVeDZaTWhmU0M1OUp1SmlYbHcvT3UwNExnRGFXRkRiV1pyMnlC?=
 =?utf-8?B?SkpvQjYrS04zNWY1bmUyUUFNOFUyMTk5WHU0QVhoLzkvMjFFbnl3YUlRMDg4?=
 =?utf-8?B?cWJ5R2xXanpLKzVOcGhEYWFrNEJQYmhDeEh1Rm5PalhpWHBwdXpqNG8zS1VB?=
 =?utf-8?B?bjJ2RkxkWTlOYmhtN1BWOTlzb2syNnVpWDJoTlFSaENpa2ZXMmV6M0RCcVJx?=
 =?utf-8?B?QytqZjRWYVBHUVlQYWoyV0Z2QkprOWNnQUZmNTlmOEhTbjFOamdVM2h3MTF0?=
 =?utf-8?B?MytPVU96UnF4dEJ5a3l4QWw5WisvUWdaRkdrK05uQlhkb0xVa2thVnQvWWxl?=
 =?utf-8?B?d2ZvNWd1aU92ZlBaL1g3a0Q3SnAvTUJWZ3lyOWhSMkFmTERhMk9lNHlDSU9p?=
 =?utf-8?B?bzZvNU8wRXl1QjhONFd6cFpXbUFyeVFSc1ZZUUlicTRJeHhBb2pCSU1wMU9w?=
 =?utf-8?B?MDBQQ1ZrSExCRk56bHgySTZqalRueFhkdmYrdFJJRWxmcXhXNmJuekcyTUVB?=
 =?utf-8?B?QzhjZ3JTNjFVeEMvRXVZdXU3T0o3R1JTendqMGpBaTEvRnZ5Q2NpZUd5S0JY?=
 =?utf-8?B?RmZicW5MVmFBQnpqQ1Y2dXNlV3BIbXFTcnRqTXBYMjRYOE1kV09mZ0FxYzI1?=
 =?utf-8?B?MHNxSDR6SHlvd2ZGNkVJWTR6QlFoVyt1NkR6NEVOcFJvbm1nUGE5YlNvZER5?=
 =?utf-8?B?elZmTFRUWUdYUXM1VmhYd3EwcDB4cDlRcDhJUCtmdjZFNTYyY1M4WTlQaXFm?=
 =?utf-8?B?VjVtZFYrTUVPMzRyK3ZaaVVwNTJkSmZYOHJhbzgvSko5OFVQYmU0Y1dwUmFz?=
 =?utf-8?B?UytvMFUxeStLQ1BYbUxqRjZiRGNuL29NRitrSTRvaDVlbDY2M2FQNlBYL2E2?=
 =?utf-8?B?bmYwRzY1MmorbGpCZWlsR2dpblJTRlI1YWQ1ZHByQ2xIMklBdDFEZlZ6UmQw?=
 =?utf-8?B?K3gwQ21haHJkUjBZK2xJSnhiVU9TZ1FMeE90UGxSMUdrRkFrWlczMldnUDBH?=
 =?utf-8?B?ajlXblZmdi9rQ0grTzgzc01LOU4zNlFRUEtEdnMrNkV1cWdSSjZnKzE1eWNN?=
 =?utf-8?B?dS9tVjNnNnNtSVViWVJSVXlDK3dlZEdEcWllMGNRckxWNmxCdTZ4M2YyT0gv?=
 =?utf-8?B?aWMrbnlvMXRnK0Fma0NLUDJ0UmxJaEdFWTZ5b3M3cTd5N2kwaE5qUjVkTnd6?=
 =?utf-8?Q?AyuY=3D?=
X-Microsoft-Antispam-Message-Info: IUyH/9uYqEEBolwM6wdaZN/ZU+fkuZ5quajo8Q+Ppf+Nj8NPRIxv8/Gts8xy25a/wMMZU6Q7Iu9CBzcyEvc/Je2SjgKFA/G6Awzh/MFBWGbgbocBTij5fdIQ0uPS86G//X0h8NAAslvLWUp5Bmcac3uycDavRmPMvRYjAcax7CJsQDo4F/FQhuZn9SnXpQqV
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;6:Zwd7EL/TSLRTzkFmR+XmmJ7WD/1ptvEW0HRXkZKFFlFngzG1DX9HA2NTeD2v0/y7wb1GR7IWL0owSIAPd5BVMr44MLNVDMOdxZKfBx+nWRY33oc2N5BS0uF7VOo9udw1cseQfzrusfpNyUN+8rcS8LEJW/ZA4rWRjbKB8WrW53ZN995Slbt5+UxP6tO4Luq25cTrFZ+Lgz/1RfuU9H20jeEbK1O/MWDZsyIcgZmSH2F+HqI2qR1VL22SMd1BBtJys0WAVHW+kAaT0GeRqaxb+9Rgfy3+p7Gtk/jlp0jrtFlphYj7EoJmMlVwxiBYz7GDiuRyBUavS6dla2mZJ5VvZL5zaKWqboaUaSXY4O8+r/biqhtyNgLsRAtljQhi3UArebChIpz2W0mmB10niumQ9GkWN3yEaLAGtpH7vITcGwbXs9YIgNW3kgoP6o8Gdx/exPudbv1LjsENu3HyAr/QzA==;5:Jjnsi4l3iABhO7C61Ymz4cHbdmfN6NxkGuFgqpxb6NkzL9vfEfF17xlIqZFOeoGPSkBZK4mYqd4DM1i+ET6dK4Bzn3aXF1iGOp59MIlngQVQAvp0f+IllYPyGeAu3l9vt4uiBRc5zEiod8ezyNMluUVHBlFmswb5PYEH2PW4oD4=;24:i91qVmyPQkQiKqY0S3hEEzk4otfinbSX04sVQj0bcPm/KiRXIcxMABqU7J3NUWGbu7iRg9w6vvPD/V7k9BSE6OIZz5jvaRyVN/No9e5gR+0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1728;7:rUAt+PPya1Oeborlm73nmNP9Y8x0VXJGLDMBfeG2svrClq7t8kXXEadpBpnU66LT2VgP9uJQZPDeHI0fZ3nond/temn86lIfnfJzgi9t8fwWpXQiQNV3X179PWVdY7bzgNpRY7V2cS3G6Lw0TEZcuvIrmbZ1OrZIqF1Q6qsrG5VYjRJ5R6rZmhd3SbGArivzLCU4PeZg76d8+R9Svl+VEN7tNl8WYIx3VVsP/gGVX4qAGf/e70ljISxsPzXQYL05;20:krE0C9cQNrjR9AkDCoBsuGkQddXK6j5hWGyv3LBISJz3aaK2VR+h3v9TrmXw1LJAd+LS4GQUgu2a6AIwJ3S1pm+VrJJc9IB0xr18TjWn/zpiTAtXngIwo7bxspQaIiBfswDr+2g4LhQKrmCXgS7mCwfyKgVKCt457lL7WfqrJfw1edG79s1++2MzjHuCaJCJw+EpOCn+U/fixIIxclsX/u3ikDKcf9glH62DKFK2ISFiH6S4CiY1sJgP9DWOqXx4
X-MS-Office365-Filtering-Correlation-Id: 6eccd5e1-31ea-403a-e341-08d5cc9b0562
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 17:20:48.7426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eccd5e1-31ea-403a-e341-08d5cc9b0562
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

Am 07.06.2018 um 18:24 schrieb Gabriel C:
>> [SNIP]
>> Ok done.. bisect points to:
>>
>> b468620f2a1dfdcfddfd6fa54367b8bcc1b51248 is the first bad commit
>> commit b468620f2a1dfdcfddfd6fa54367b8bcc1b51248
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Mon Mar 19 11:38:19 2018 +0100
>>
>>     iommu/amd_iommu: Use CONFIG_DMA_DIRECT_OPS=y and dma_direct_{alloc,free}()
>>
>>     This cleans up the code a lot by removing duplicate logic.
>>
>>     Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
>>     Tested-by: Joerg Roedel <jroedel@suse.de>
>>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>>     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>>     Acked-by: Joerg Roedel <jroedel@suse.de>
>>     Cc: David Woodhouse <dwmw2@infradead.org>
>>     Cc: Joerg Roedel <joro@8bytes.org>
>>     Cc: Jon Mason <jdmason@kudzu.us>
>>     Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>     Cc: Muli Ben-Yehuda <mulix@mulix.org>
>>     Cc: Peter Zijlstra <peterz@infradead.org>
>>     Cc: iommu@lists.linux-foundation.org
>>     Link: http://lkml.kernel.org/r/20180319103826.12853-8-hch@lst.de
>>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>>
>>
>> I'll try to revert this once I'm home.
> I can confirm reverting b468620f2a1dfdcfddfd6fa54367b8bcc1b51248
> fixes that issue for me.

any idea what could cause that? Basically this patch breaks radeon when 
SME is enabled.

> The GPU is working fine with SME enabled.
>
> Now with working GPU :) I can also confirm performance is back to normal
> without doing any other workarounds.
>
> The only app still acting up a bit is Firefox , just minor frame drops,
> but nothing to bad.  ( probably an Firefox bug too )
>
> crhomium/chrome is fine .. even with 10 tabs open , each one playing
> an video on youtube no glitches at all.
>
> Desktop is also fine now,  could not find anything wrong.

Thanks for testing,
Christian.

>
>
> BR
