Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76676ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0024D208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bA/zDTXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0024D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeGMIth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:49:37 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com ([40.107.7.122]:4128
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeGMIth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocIWZrHmDZFGrET41qU4YzI+vQSxsNHigXCBZLTFh98=;
 b=bA/zDTXcYEtVhb3otW8iT44G0ppPtjbe/cEbbycr4C25jehr2woB9E2ZyHnY7YGZIGkeU6y1YjDCnCNq90ovcwh2DuRqcdW8wCHK0sLtdvql/RHDGG7EDraV+yL0qfSnpwE8YhsAnm1f1Y6Setde67Nyq19HQ6yUoRlhOM4yB24=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xemul@virtuozzo.com; 
Received: from [192.168.43.234] (83.220.238.176) by
 AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:44::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Fri, 13 Jul 2018 08:35:54 +0000
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Adrian Reber <adrian@lisas.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180712130733.11510-1-adrian@lisas.de>
 <87sh4o5s82.fsf@xmission.com>
From:   Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <23f87cb4-cdf5-0f9c-c7b9-a0abb228b77f@virtuozzo.com>
Date:   Fri, 13 Jul 2018 11:35:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87sh4o5s82.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [83.220.238.176]
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:44::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0adcdf81-9c37-460a-0c16-08d5e89ba66f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB2982;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2982;3:qCJkvIcHF1ZIhX5m/EKmoeq6O6IpH+BlDNvKe2YcBsridpqmz+0qwkmBuqJa7Rp8dFvqSFGtwpozCfRy/hUfphcMh+0qKtbwrNwV48OAc7E7QvxLrabLNeoqCJ2KahW2AeVQ7nZ0rHJxbw7pP0REnOAeNFZd1TR3zMDS4sFFKYXpepqFADnRB1ZslzhlGuJ5VVzojPjBCTL5Ye1NmFtj/fB+SuOAA2piJ6EscDBajqi8XLObLHArrDi2OKiZwNCk;25:AZz0p8+S5FKZv6r4CtJK6BmRmvMDSku85vYDP4FbOrNlPRHCmLn4zuesGUGQkp9owcPULdjqfj/bPMxmpqkMA90WOWDeUDYt5QViAtC1+S898So7E0nLXfiKq6D1QZqWIaJRDl1dNs5o3fOuT6rCxkRRY+zDRWAN2truHppQ7tuuusK9jLh83/f/zXMzYBga/Jes+lO1ZKrsJSMg5N8H9SGeVAdDFdafYNVV6ApG+QygaIx+tNgan8OX0AM9ZZsrHL0svxRsCrJnOOtMiMoWM5KtCVj3IhiDiMQRECBX1nwtEmZyKuYDBClI7hJyQIF0DsyqCw4rF7kIuOoMDOPNyQ==;31:AxJHAGaQwWbujTXNxTP1mtBDkGHDclWH8wsIqGVxGuB8YOgcHbAnCIeCIW/v3bI4l3oiTzfUiacD2TOPktZANXYnwu6Re9j+LU1WNQXPHsHHJgaTbgEuBXlmtoqkXFgBfRW606zHVjXvTgzUixIUJ2G46PC3tx5bTbG/iH8QV7/yuKSHnsNbty9OCW9n79dm+I4cbaxjduob4NN5KaT9A/ItTQ5TEIum15m3m4Drwto=
X-MS-TrafficTypeDiagnostic: AM6PR08MB2982:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2982;20:4O0vvui8sxvZFkZRsW6g6nabvnOIf+7qlwDGsnJ8Yg9JP3hDvcZJQbZT59jdRnWMi/hvcW/OTKpYWJKCcoqmcPshzgJBz1GTgz9kzEMf6WNkt5PUsXtr+BjO45I7MVztX+OXSX4KieUKak3Tv+NremfWJ1iZF6rtVkGbLrRuexHotT2ee6PMKLB9gPPx8LJqTXQW2GW5r5OcIEFL3WWxH4LnATRhN4GM/juV4HYBKTZTtFvLnFDSvK9nVb9FmbGvPc0xwJU3y/faLbVioL1MlR/ZJgEJsJ27mXGrVOa4qycgd7gLY1FVPYGCHPss0eJW0uWlG4JH+SRmidbLEU+RdVt4TT7fzq7joItwtBRmyo5lmp/9bdEaxzWd1p0pOCs8N07RL6QekcM+unca2TJHEqodWpgOVV3FHJM/5YL2L0xij/BcMLBxRCr4VawLnZGUb5l2huDy7j7e+cou1UsYlXfm+7jaH6hZSkpsNk+czi00X7Wk+tqPElTVKJm39J90;4:cp9t4gBJNxnFh6vbWCI6KzLMna3PXnB40UlMSRfUNsbnXqxkS32FlIlC17c1Fo1W6gt8OML7uUobwG4vbM605jPy2w2eKOpF9hRUf7aHy5mCZFMlDAozycao6udir8LzWWS/ATaA2lNgdYhEsbJ26X0yzpMpjqUfxLbS+wLSSkDmgYHLFOuOSzF7NzZER5OuCWWV26jnWkaWmCCKHz5B64k1aohzB864N57IWHlVjXyhr1n6fK68SZYpDh3uGAVvpxdSoAAQcKDqv+u8f/3txOVrf0M4/PitF0SbydE5R9lI80FaYFTH9Wg8rzxRFU9lk2cPKqohO/92AIoZrzL4mY1eoMnB4V5Udn2txhvNk4A=
X-Microsoft-Antispam-PRVS: <AM6PR08MB29829E36BBA047F60009A452B0580@AM6PR08MB2982.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB2982;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB2982;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(136003)(39850400004)(396003)(346002)(376002)(199004)(189003)(16576012)(52146003)(316002)(65826007)(64126003)(386003)(6666003)(53546011)(478600001)(186003)(26005)(25786009)(77096007)(16526019)(58126008)(110136005)(54906003)(4326008)(31686004)(105586002)(53936002)(97736004)(106356001)(5660300001)(6246003)(76176011)(966005)(2486003)(52116002)(23676004)(36756003)(6116002)(229853002)(2906002)(8936002)(486006)(446003)(11346002)(956004)(3846002)(7736002)(8676002)(230700001)(476003)(2616005)(81156014)(81166006)(305945005)(14444005)(6306002)(117156002)(50466002)(47776003)(6486002)(575784001)(68736007)(86362001)(31696002)(65956001)(66066001)(65806001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB2982;H:[192.168.43.234];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIyOTgyOzIzOlR0NEJGWVBUbmRpZ2p1OE1NN1loQjJNMVp0?=
 =?utf-8?B?MDZobFNQOTEzSEJSc0pXNXFzbkQ0cGpNbzV6VnFNMUhoaUNvVm11ZlhaRTkz?=
 =?utf-8?B?UzYreEhBQVMzU1lPT00zdTZ3dHhTWk40QWRYSzJhbC9iRGxnKzhSVzVkOEJC?=
 =?utf-8?B?K2Vwbjc4blVHeEZuc1EyTTBNbG1KY0ZiWUxvUC9zcWVleldFbEtHN3FHa3VF?=
 =?utf-8?B?bHh1cFQ4anNqUXVLNC9MejRkSUoyKzZrQjZ2UGdEaExXSC9GbHVsUDNleW9j?=
 =?utf-8?B?Q3FuRlk2V2piT25WblBJYXMrZklVaUpiSWtXRnFMU29RaFBGR1JqczR1QitK?=
 =?utf-8?B?aFpVb200MEEwNWJpV1h4VEJyckl5OUFlRzVBTFpSS2k3Wi9zTnZjM2ppMjIz?=
 =?utf-8?B?NW5Oa2FjZUVqcCtwUmxyTUpKMkx6VXBKcGVlcjIyRG9Ed3ArVm1zall2ZDNr?=
 =?utf-8?B?QWp2RzNLVTF1WW1aN0NkbTBQMHBwbmlpSy9sWDBlemhRQy9LdXZOTWEvYmNL?=
 =?utf-8?B?aUM4VFlLWW8xVVlmaklVelZ0ZGFOSzRFSXFyTmZXVXowVHVST2NWaTYvekgz?=
 =?utf-8?B?U0ZIU1Z0V1E2M0xKdSsyZEVQcFRJSkJ1M1pBYlYzaGdvRUxJTDdsOTJuTzY2?=
 =?utf-8?B?TlNJQXVxSXNIQXl3eUp0cEltdDlqblkxdjFqSUhYVDgyQkc2OEY1MEk4SHQv?=
 =?utf-8?B?ZVM3ZWNGMTZoMkhuM2RnamN3YU41c1VTVXNTRStlalhCYjFtNTBHVW9Na21h?=
 =?utf-8?B?Y2JCbXFMTHF1UjIrVWZOZXFyU2sraldSSjJIWEQ4N1dRb0ZHNmZFNEZrcFlS?=
 =?utf-8?B?N214RGVqd3B1UURFMW5Mc0hnbFhwb1BEODZrRmdkSll4Yml4alg1Q3FHTEpR?=
 =?utf-8?B?cFJYVDFCMWpWNFgwUWsyeFpmNVFyMUY2M2Zlam9NYi95SlNRdXBucXRQTkxG?=
 =?utf-8?B?bXE0eXFpaGxJcTRpOFFZSFdXcXJBdW4xUHVYdkxYd0JqNmdGb20vS0I5UVpa?=
 =?utf-8?B?cjdDbVlTSHU1YnMrekQ4RTArdE80TzZOeEtiWUtjUDQzWEF5SUY2c1VIa2Ux?=
 =?utf-8?B?Zi82VE1ubnNlL0dGYjJ1ZlhYbWQ3cXdia053NURzNVhoRGl5aWdMaUx3b3ZJ?=
 =?utf-8?B?SHd2RXBmTTA2OTd1WU5sbXkxdmNnWDFEWnU5OU1NUlUvRDlMSmJkbzhFSE9n?=
 =?utf-8?B?Sy9KUE1oWUVzRXRzUnJGMys1V0NFQWJyMXZNZUtyZVVFZTR6eERZNjdWSUtX?=
 =?utf-8?B?YzZtNDNVdlZVL2JBVENsZU9CQzZzYjBtdk96N0R5UENTY1l5cmRnb04xd0sw?=
 =?utf-8?B?Q0IwOGhwM3ovYTIwcEhtTFVVTlNHNjhkNkloU1FRTG9rTHExMlUzaFlrOXFt?=
 =?utf-8?B?cXBIdUVwcnQyb25hMEJsUE5hQTVxZmQ2djBCMnRiaU52dElGMWVVdlQvSEV0?=
 =?utf-8?B?RVNmZzVQREJZcXBGMS94dE1OOWdWYzBHd2xCSEsxbWIwZ1FUc2pnOW5XV0FC?=
 =?utf-8?B?OG1mVUpmMHovUU9rdC9FK3BLb1ZrYlp2ZUFsODE1RkMrdVlIald4TE1nRVZl?=
 =?utf-8?B?MmZVRTB0eWJ5MnhvUHoxUWV2M1Rzejc3ZEdCKzNxQWFJRGp1ejQyYThnb2tF?=
 =?utf-8?B?TFJ4UmJNNC9tNmtKM0hJbkFSaGpBVmJ0Q0dNUWNWdVpUQ1NueGJMbnlwWHhE?=
 =?utf-8?B?T0ZZajgydnFOai9CaGNpbnRDTTIreWNYc2U2Y0t5ZnQ3K0gyczFSa25CNDZB?=
 =?utf-8?B?MS9HUU1td0UwMUR1eWtOT0JwWGxpeDNmVzR4YnZ5dkF1ZGlCbTVjUzQrMkJQ?=
 =?utf-8?B?TUo4dWJlMHJHdm5aZ1JEWWp3cGhUb05HeEpxSUtjZFoyQ3pud1BNN3RGUmhB?=
 =?utf-8?B?MlRMVXFwWmYrRWxRMVlrbUc1c3pRMnZRUVlpRXJZbXNnQ3JMcTVxM0Fub2Nm?=
 =?utf-8?B?YzlIVEVPU0h2L2NPemJJT3YrV28rY2lFSTRSTVEzVVVKUkg4WXhhY1RkekJi?=
 =?utf-8?B?ODc0aFdHaU9YdEF1UWtzV3g2TDJIV09aTjBMdEcvb2hrY1BEaDF0cGg1bjZD?=
 =?utf-8?B?eVZ5U1ExdFIvWi91S2ROV1N6WmVRUFZUOWViN0hvWG5HYnZxQ09obEZIcHJD?=
 =?utf-8?B?QWc9PQ==?=
X-Microsoft-Antispam-Message-Info: qwSe4s16Qzd94E4sS0wnOgXgW70Am/h5XWTuOnonwZDRGt+u0l0wG+NEinA9XfjVAD91RfgjnBPYCJCEvz3Q6WChbWJydasYXTkz3IdvlR07k9S6I7/aKDpXorGJEmIKly11nFqkTsaHuJRcYA6GypWsOhUM6l1GsT095tcXi58TUmjW+US+Fdobvy4iROGppfw8l5eEWJaLCsoyPCa8g3UoL415KNXJlA/zRElP6Lp2RiEIYIgLNh9kv1FsSxNhoksuohr9OT3G8cSyFQ4niQVgYr/1lewbh5hoTNfwBXHXkBK21joyH3I+sn50pG4vMufiHPLYXzAaIy5c3+XvMJJS0AQlzIxLQBBCWqFBqV8=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2982;6:zxEKavWlGkBwlHJP6zP5bhPsfN/be7YAHvBI1z1UXe0DwYooW5ytJDGddw94s9VqLbhQNcW6NUdduYfmN1BYfRlGs9VprG3gGGXyiHZHSqmVJ8Ijp/tCvWVmd56Tv0CEDfOHF8botKLxQ5GRoQOwOzWax0Drrh7DHk54PSfhOkOpu+aNKqg93kBGBEk/mDJDKazBbgY9AWOv351egMv2keEiIKatZJb6eL89TG0ZlVyU2rHvRlT+r8K+1ByIo4r/vnJviwOyyaOqWX3UjMzf8rvdDACGdS5kn8V4GKJ/q3qZFOMnP8Of8v5MCcRbTQM/kZboeuInVsTpQVt4J/falKpMnVIHktKA5A3H6SE5XBWOguBcADfYlZbu6ugmah3MvwbW3pKj3eS+itg2zQlTqLX0SOhr3OHjOCZRPdpuumk13f6GeIOA/jkKYk74JVE7mAj/wMxChkrGKuNifdHjRg==;5:qivB4snRXnwufUK6BZHZGtjdVt07gE8HDQk8rr3kudZz791uCzSAcuM4dwMFAgGAvFfFGOS5IFTHv8vNZPteexEo/cRKhkLDtLkqNoQcJtIlWX3jVYE/DSx0V3Bomza0LUvt9OBgDeF/C++fU+A4uAtqBj9SJ6wN3rWJvS1v2uc=;24:OsjD2IgXRrHAa2IidXX8OSFILdu1TjZBHD7DYkL9yrIT3ROQ0CEu0PpuL8iWiHWWojAJBJj/sOJoipmUWl3zHfClnh6avxQVxl5Z1TbFn3c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB2982;7:t3VVztnrhAngPw6IxfLZLzYgMQLeHVV23y5W5HIaPSmzehC9MAHahmh3BfrIvamMH8QkPDFYyYBpfg42XkSO1o65JOT7QbpHHKOxsP++SGOQjIegyn3mT5PbHqCWLOJa5H/uouSwuc0fgaEKeHYrlqOI9a5Mw/t63QXkRf/JsjdQGiaouCVd4QAsRdmDF6JyqD+jXM3QDAAwz2u2eT11f55tBdX2ewXU0Q/pv+1urvfv2zGynDEjKkVgKbsBambQ;20:2J7k7h5UQUk21GU9/aW1l4NCMKeVj9sTSj9c9DC30ayhpVXQz/XxqdQ0LA6Sm76E+NveqEHgaOkZZ1fnSnEFZkJc1iEivJvs35gzEVA9l4hUuXtJYdJ6OBIvN9tjQsAEpjJdr6aNLO+dUEBjW08v8zRAIqj5N+QSoCpE1hoAshA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 08:35:54.2456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adcdf81-9c37-460a-0c16-08d5e89ba66f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 07:33 PM, Eric W. Biederman wrote:
> 
> Adrian Reber <adrian@lisas.de> writes:
> 
>> The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
>> combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
>> distribution kernels and also part of the defconfigs of various
>> architectures.
>>
>> To make it easier for distributions to enable CHECKPOINT_RESTORE this
>> removes EXPERT and moves the configuration option out of the EXPERT
>> block.
> 
> I think we should change the help text at the same time, to match
> our improve understanding of the situation.
> 
> Does anyone remember why this option was added at all?

Sure! Quoting Andrew's ~7 years ago akpm branch merge e-mail:

   However I'm less confident than the developers that it will all
   eventually work! So what I'm asking them to do is to wrap each piece
   of new code inside CONFIG_CHECKPOINT_RESTORE.  So if it all
   eventually comes to tears and the project as a whole fails, it should
   be a simple matter to go through and delete all trace of it.

the best link with full e-mail I googled for is
https://gitlab.imag.fr/kaunetem/linux-kaunetem/commit/099469502f62fbe0d7e4f0b83a2f22538367f734

-- Pavel

> Why this option was placed under expert?
> 
> What is the value of disabling this functionality ever?
> 
> Is there any reason why we don't just delete CONFIG_CHECKPOINT_RESTORE
> entirely?
> 
> Certainly we are at a point where distro's are enabling this so hiding
> it behind CONFIG_EXPERT with a default of N seems inapparopriate.
> 
> The only thing I can imagine might be sensible is changing the default
> to Y and leaving it behind CONFIG_EXPERT.
> 
> I want to know what is the point of maintaining all of the complexity of
> the ifdefs.  If no one can come up with a reason I say let's just remove
> CONFIG_CHECKPOINT_RESTORE entirely.
> 
> Eric
> 
> 
>> Signed-off-by: Adrian Reber <adrian@lisas.de>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Andrei Vagin <avagin@virtuozzo.com>
>> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>> ---
>>  init/Kconfig | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 041f3a022122..9c529c763326 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -932,6 +932,18 @@ config NET_NS
>>  
>>  endif # NAMESPACES
>>  
>> +config CHECKPOINT_RESTORE
>> +	bool "Checkpoint/restore support"
>> +	select PROC_CHILDREN
>> +	default n
>> +	help
>> +	  Enables additional kernel features in a sake of checkpoint/restore.
>> +	  In particular it adds auxiliary prctl codes to setup process text,
>> +	  data and heap segment sizes, and a few additional /proc filesystem
>> +	  entries.
>> +
>> +	  If unsure, say N here.
>> +
>>  config SCHED_AUTOGROUP
>>  	bool "Automatic process group scheduling"
>>  	select CGROUPS
>> @@ -1348,18 +1360,6 @@ config MEMBARRIER
>>  
>>  	  If unsure, say Y.
>>  
>> -config CHECKPOINT_RESTORE
>> -	bool "Checkpoint/restore support" if EXPERT
>> -	select PROC_CHILDREN
>> -	default n
>> -	help
>> -	  Enables additional kernel features in a sake of checkpoint/restore.
>> -	  In particular it adds auxiliary prctl codes to setup process text,
>> -	  data and heap segment sizes, and a few additional /proc filesystem
>> -	  entries.
>> -
>> -	  If unsure, say N here.
>> -
>>  config KALLSYMS
>>  	 bool "Load all symbols for debugging/ksymoops" if EXPERT
>>  	 default y
> .
> 

