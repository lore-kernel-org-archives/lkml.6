Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TDcCHlbSGFuFKAAAmS7hNA
	; Thu, 07 Jun 2018 07:07:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5E8056089E; Thu,  7 Jun 2018 07:07:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TcAn3M9b"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 859FC60452;
	Thu,  7 Jun 2018 07:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 859FC60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeFGHHq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:07:46 -0400
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:20512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752570AbeFGHHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWrPmQm4YFRAZeo57xHidWZuYAg1LQWHeYCwtTRyHt0=;
 b=TcAn3M9bgPw34upaJ/hmi0pFXA0Bk8vQoTUA64Z2xsdcXJ3r9caPTULSMa6iQ7wyNFzfPIUCE5VkUyxnRWvP7P89C2qJUsL4s/YZowCnT4UX/6k4tnmtLtIQPBRxQIqdQ6yDcV2uVYU426v5nOjNtUNv23USftsiTqIUKiTugGM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:112::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Thu, 7 Jun 2018 07:07:36 +0000
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: Gabriel C <nix.or.die@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com>
 <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net>
 <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com>
Date: Thu, 7 Jun 2018 09:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0402CA0019.eurprd04.prod.outlook.com
 (2603:10a6:203:90::29) To MWHPR12MB1726.namprd12.prod.outlook.com
 (2603:10b6:300:112::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1726;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;3:wRggOZ1kuvs/p8Z0GIL7uS0Ie1qIznYTGItjnEJDl/GSp0yhfTt1lbXI1t+u7KJRzsm4FsghcpLJzTV5YLcOK8wxBXRrohwYnKgGJwS64TCcQ/U7e0pY2jTNqfHUlTCtYEulGC95uLy1Rl/FUS/Ez4AFD6QfUDKsjHZQDsjwNh1QfGBJub/gOR+kjFrIjUMUesgES17sJ9pxrrT7/uqYEg4XW2mbmk1USbMf/fEG5JOIiTjO3Np1zD9Q6DT3Re2f;25:s/dPpWuY3BCnm0J3vRSFWH0vxgjMBH9uvPn162bEVOGt/xim8QZLuFcppAA91MitZmoodrrbS9rWop0Jqir+344G94ioLbhfK9l90gx8jl+fHWuKkLaCIzQbBu9U7uBcHRFa2i6gXF/VxHh5ajXdOsaj5v5VpTwhHsIEKD3RdytrgFnH0+WY9MQ4jdses7BpmKLYpc59GSadkkPAuZJusKt2N6H9hS0bXzIa+zcpBvxg3sr9iauZPAjJaTAU5JgY0Dn5tMuGrtR7Tx3dHTxdB5YYFKPd+h1gzh3Z2AjgsPZ4eYwkYlBSgjR3sN/jdcnSzWs84edNieyFsnKvX1BCUA==;31:rhaAIqIeufMowgyjBTyBbEEpaeDR9OJO5Gy70W1s/Bum0nCSs0u7clnMpDJptDnDFsuoIZvEHLx91Wds/jPpNjcUO9hywZB0R7OA07Uajn4aC6yQyp4UOuFPdgledKg7tzABji54WhNb6B1F8laGBcOHK1c6RLfamRrvEB+y5Huwnrakz+pmakEEXl7++siJQX9caUzQU1njo1LhA9k/EHxArPkZP4gZKiz2r9CP/jM=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1726:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;20:4LSdzb+1gotcfwD+p9bcF5l36kKuJJNDirqn+yt6DjVP3s1Bw5eJS6A3J14iSQgjdWRpWx4VrpqcO4lAUJpi4G3Iq3dbQLV9MXMYpYfnfrh5gC3rYXRjdDSmX9kfdWJNHctZDeJPWnkYF/FpMUSZWMGwDtcwMyxgAD1VeUG2kXbvcKsIboEX4vYZbihvPzrWaI+5bIWPGKxQZCMpKVi8F9Q8HGO+yV9kGZo+Utm845q7NaK767iYhmmvsB+wRL3LdBWV20MD7SUwhU4lBSkJu+PKBD3hRSIhTmk7k27LoHFOnW2V6zGzvPwx+YZsGRQcotd+SXgGLXF2NJMEiW5q6ECLZdtFmyB1vR5ce4/QocLFG8SaEn6ixNk6HheUxf9e7I0YQ3K77vW82Li2SP1IQmmM4tTKT88lS/MyaCFx0UKslPY+pA4cVpZLAj1hw5g+MR/0RoVnpfLZBz0gqyvEYlOgzYQGOTXlU3+l4DnU77tYWKjBQI6EA/59gkX9D4il;4:y2ZA2/8jdJjmhv65e3i1pnzUs7uuINXv2iux3kOyz11uODZzdi9aEBGBKyE7EHWuyiiHErQjRjo4ofvSAwjgGO0Ina90oNTjsclSLZ+cqtXe1OcqyA7X1oOjR45Xww6QCJkM/8/16SL6fJ+kwQOqCQZjvDJeAU9fbe576KPzr4Tb8yy8dXdK+hZWObmypKfw+4K9KfqOVkZuifS+a9qhx7AZLrSZt4sJSZkHtCfRCHD3MvPLD2w+lTGtLL5eC5JcXLoboCCAPWpWbsSPOTlXKo3Am+lus1edbsmEFGcWurOCtwedGhgyJ9HARd25QMpVavBvzQIjFQSeIol75YyOpP/OBaJY9RjWYTSO+uG91jvISjZ1bdiIEYqZEzizynl7
X-Microsoft-Antispam-PRVS: <MWHPR12MB17264C2C573BFEE4D77017CC83640@MWHPR12MB1726.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(95223839027130)(20558992708506)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1726;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1726;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(396003)(39380400002)(199004)(189003)(575784001)(6306002)(72206003)(2616005)(11346002)(446003)(64126003)(186003)(478600001)(65826007)(229853002)(50466002)(486006)(106356001)(476003)(6486002)(5660300001)(966005)(68736007)(386003)(8676002)(46003)(6666003)(105586002)(36756003)(53546011)(305945005)(7736002)(16526019)(81156014)(76176011)(93886005)(65806001)(65956001)(2906002)(81166006)(110136005)(58126008)(54906003)(52396003)(23676004)(8936002)(52116002)(52146003)(2486003)(2870700001)(316002)(6246003)(39060400002)(53386004)(97736004)(67846002)(47776003)(1706002)(31696002)(86362001)(6116002)(31686004)(25786009)(53936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1726;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI2OzIzOm16eVdiU000c2ozemtPcWZjUFMyMG13TUtu?=
 =?utf-8?B?RUxuVWIwRnQyZzVWYnNSOFkvNmtIajMvVnlVWkVCYVpFdGV0SzNkdkxaUDVy?=
 =?utf-8?B?WC9QL0QzcENzcjBsby9PVyswb0VnM3hML1A2dXFOUGdHWU5zR2RhZXNaSHc4?=
 =?utf-8?B?SG03eEluNE1SQmV4b01ZNGFsSTlXcDNyTWxmb3JMYnJ5VS9vdExxZE1VTVlG?=
 =?utf-8?B?M3p3Vzcra01qelc5SUx4ZzlkbnEwYUVJNFF0VkhWNS94SWh3MGxnQThhTkNY?=
 =?utf-8?B?aVRUdUgxc2VVVjQvYUNjdXdMTEtBdG05WDgzcTg4RURQR3J6eVh3SGt4V2hP?=
 =?utf-8?B?UldncU9sRFUwRmUwZWZaZE5mbVludk1QZGhhTm5BbXRhM1B4QlNkd0hML2JC?=
 =?utf-8?B?OTFFZjlHTmx4Sm82RTNZY2dzc2dWME56V25jTUtNc2dMWTFVMlZaa1RKcXhJ?=
 =?utf-8?B?ZjZrWG4yMmdtZjNQU3ZHTm1Ta2tZRUw0TCtaSXFObjlLV0FlRjhrU0pUU0g0?=
 =?utf-8?B?TDR2bi9ZMG1tUnArM29OcDJGL3VWMXJORUVNRHdBMWFCT2RSRmpweGkzZmJh?=
 =?utf-8?B?UExQR2g4RWZiT2JiMTY1UGdXU3dIY0liVGdhRkJJQVk3WTY5VEI2bDlBY09G?=
 =?utf-8?B?cUI1alIxb2dXYlExZ1Q3MTVMN2phZDZBZzZNK1MyLzN4bXZwR1pWUHRtMVM2?=
 =?utf-8?B?Tld4cTRPZnNrOWZoek9aMDFLY3FRWjhJVk50S3htQlk0eVdaOWNLRHp4K2Rn?=
 =?utf-8?B?dVhYVEdaT0hsZDBVZ1dCMjBqTXpoUFMxZ2dnNS9OQ01qRk5wRlZnSS95NEkv?=
 =?utf-8?B?cHdTejlRMXJybGdyUzk5RXdmMjhsbEFJMjRaWkU2M0lWek9JMWo3N29QTmlm?=
 =?utf-8?B?eVlwRWg4V2FsV0xnN2w5M3B6aG5VZVM2M0tUS1BMY3JtcjB6ZkRLQnlPdjFO?=
 =?utf-8?B?ejR4QSsxeEFxR0premdSRU5tSFZEWmYvR2lGZHZRTFpmYWg0YXpYYVR6SUM4?=
 =?utf-8?B?S2RPbklsWE5BYVd1OHJLeXRCTTVydUFMNE9kT3NzK3V2K3dLWmEraCtFSDlv?=
 =?utf-8?B?aUZzWDJPQkRBemM5THFrbnhBS1Mzby9MY0NxSDVGZXo1SVpLY3cvUWI4STNs?=
 =?utf-8?B?dlNmNzQvMGdZMzVBa0dWd2ZjZEVIRTF4VS9makl2K1NSQ21MVVpmMlpUSEcw?=
 =?utf-8?B?RXA1SEVCdnhyK3M2NzFuM0s1Qms5N3F6S1B4Um40OE92cFRRWG9DanFhN0xz?=
 =?utf-8?B?MEVJR2x2MFlyWnVudUxwbVU4d1YwQ2gvVEtMNGUvSXFhejZqSndvZ1dvN3Zu?=
 =?utf-8?B?LzlWVmpFcTJ6cU5BajdMR2pOM3cyaVZFTzdwbDhnMWFXWFZ6TFl5Y3ZRVTNk?=
 =?utf-8?B?Qjlwek1NMTh6Ymd4YlZTb3BoVk95YkhtMlcxNHNTUlZnTXpvRHU0a2t0bXRU?=
 =?utf-8?B?QzVBeFlEcXVHa0JEakI4MUdHd1RmaS9RWm1HV05qUmQrTDdZY0xSNG16N3k0?=
 =?utf-8?B?dE8zSERXNlcwUWRjZmkveFR5MXJncHlubTgvdUV5aWM0bVVENnZKQ0xCSzYv?=
 =?utf-8?B?aHJzakF5bzRCbUdLVkpUM3JiWEFWVTN4S1V6bS8rS3V4Uk41eG1WUzdERXQ5?=
 =?utf-8?B?QURMSEdXUEZBc3VPb3E2NklZMnJVSnljd3RMc2JoWDBBeXEwYklmQ2FDZE9a?=
 =?utf-8?B?OG03SEZLQ01zU21QN1pCUGhFZ2ZNTUxEQTlRY1NYeWFTeS93SUR0Mnl6ck1p?=
 =?utf-8?B?amQwa0JueVRuby9XYmFXalpCQmxXS3VYOGNML0tnWlNtUzhKT1JoSVViTisx?=
 =?utf-8?B?UWRJTFBiUk91YzBIRlpjWjVpaVFnTmM4ejJDQ0QrUVZFd1VIa3ByUGNxMnpN?=
 =?utf-8?B?RUZJSUVkWTZGWitxaFM2c0ZVY2hIa3NJTmJORFc4RGVDbkdOMzhKMUVJM2Za?=
 =?utf-8?B?Si9yZHNLMU9vNDB4NVE1NWhqWlJpWElMMkxKc0NhTElQUlU0bWh4K0g1QXo5?=
 =?utf-8?B?VmdxalgrUUM4c1JEcDVnWWtoOFJoVjFQb0ZpaWMrdE9DRGovUHRhd2lyU1RC?=
 =?utf-8?Q?ssvm0YFpalJ61K7+hp44IM/ln?=
X-Microsoft-Antispam-Message-Info: ssHLGN0JgbfnaQZrqlP9z4Laq9MlDDxffHthfvTqT8GYbyddVJ0Vkdps/thNbakE4dFTuN8nQBRIkgCZn60HmvBAcU9GRVwRnl/hmEjl/xKfwNEBYSbqUcsQrpYrfTFqUmR6yOIuoqt225oCWhTmbLWP7tQqCcY7P4uzeAv0A22vQ0ga9k7RswrmEmVqdIOO
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;6:boxnhXBAMr6g8kqQyK6eT82kDplB5I6YmAmnLZ5+MYjCn3NaWGwjBTXhtnpIZfiHIrCW5zHYVRkhSYgNlkXWgkTjGyA1bnkHCj60tBAyPj+sZfl+itsGQ8rycjnswjthm5vplT8xm8I/QkCDLkVfSvfXfp8xGGMC1Q7aw5mAW23sXpMS7l7M7PJf93lYuNSZzzoK1AIJpGmbaFhT8P4Wsox4sb1MbparwArAKhyPF/0Cgt7g6tpNfzYEIhOKm5N10jUKWnZzC1a4DKS7Sjl7S3ZueSTfY+g84ZK+va/GVCpYzqPBzkNWZPiVSHQ+Qly92dJiCkc/yKV6jLF7PZanS1EAvI2aG/wyb6/Sm4gRVUpR7wIKixiLvjRYDvdNM7+mJMbw0O6dJbE+lM0EpEz0XGZACyuRGNkThcRrnaMLnDMqf8E5yj1HfhBJMldfKaul+KRetxL9QubowU1RmE+MmQ==;5:/26lPEZvRn9mOQZTnHQ6g2s9pO0QsxHtQHiY7rOoqZY3hSRjgm42dVY5aa69KWoowMWouHXuap2kdZF+rD/kmqwKN4q5V8x6HuuqUCphxqebvyfqSnNCxy1KP10HhbXDUdk4CSwlB1RgKAnreNAjgoY0iNOHwrHr5KGhU8ONCwI=;24:y9B8hlVYcwkcR/XYA0xDTlWZhV8Oknv6wqPNvx8e6/4hIqes6xqeUJIpqWXiwliTua/zLvA26H5owfbXwR4VVoTTQBLmtlc5fpvstVd70+c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;7:gNrRvF5s7rY17M3RooCL5QgQi/uwyGpdHU0+VHuHv3+HQ0+TqQswyg6Pfg2+4xxZ7U2Rl9bTmMxeHGd53mYX5oy7YP5VnO/xGPQbmFqxzCVy5ny4meep6Ql9coTCK0l+IXGH1cvCwkJVtTf40AwZs4NoGFru0lRG/vY3/ZuvUFRJz3rPfmCDAmV2h3qYMV2vm9KRwS1h/Or5VQrM20B02mHh2RF8GKx24jlX3JBcd60zoyw9k8jM2BDAeoh37qQh;20:rycreKKQcfca45iwsIYJGpJ0IANaE7bIaRrZaLwnL/0dkB1nQcJUFXwD5hrtehOHRNkJu/Lv5GkwXejb4CZ+hZexG7QRpqe1JB8E3zH5Drz8m5hP6Ikv7oIVK2Vkq8XZaZBnhHcHhDB0AL8cEinwWyKJb5XbAGYaJC257U/FiTr2U2A6ITS+XDWe11o5ng8eMAf69+EuX2WJwN3j08Rz669cRjId7rtjJAIZ3UWYc8hcIGviBS30g/RGdonEvOtY
X-MS-Office365-Filtering-Correlation-Id: 79a526aa-da58-451b-d9d5-08d5cc455c8c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 07:07:36.3851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a526aa-da58-451b-d9d5-08d5cc455c8c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.06.2018 um 17:44 schrieb Gabriel C:
> 2018-06-06 17:03 GMT+02:00 Michel Dänzer <michel@daenzer.net>:
>> On 2018-06-06 04:44 PM, Christian König wrote:
>>> Am 06.06.2018 um 16:12 schrieb Michel Dänzer:
>>> [SNIP]
>>> At least in theory it should work when we use the coherent DMA allocator.
>>>
>>> When that really worked before, so the most likely commit which broke
>>> this is:
>>>
>>> commit fd5fd480dd8fe4910546e7b080b3ae345e57fe9f
>>> Author: Chunming Zhou <david1.zhou@amd.com>
>>> Date:   Fri Feb 9 10:44:09 2018 +0800
>>>
>>>      drm/amdgpu: only enable swiotlb alloc when need v2
>>>
>>>      get the max io mapping address of system memory to see if it is over
>>>      our card accessing range.
>>>      v2: move checking later
>>>
>>>      Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
>>>      Reviewed-by: Monk Liu <monk.liu@amd.com>
>>>      Reviewed-by: Christian König <christian.koenig@amd.com>
>>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> Currently looking into how we could somehow improve this detection.
>> I guess this could fit for Gabriel, but e.g.
>> https://bugs.freedesktop.org/104437 says amdgpu was already broken with
>> SME in 4.15, if not 4.14 (I suspect there was simply no SME support
>> earlier).

And what I totally missed is that Gabriel is using radeon and not amdgpu.

So Gabriel you need to revert this one for testing:
commit 1bc3d3cce8c3b44c2b5ac6cee98c830bb40e6b0f
Author: Chunming Zhou <david1.zhou@amd.com>
Date:   Fri Feb 9 10:44:10 2018 +0800

     drm/radeon: only enable swiotlb path when need v2

     swiotlb expands our card accessing range, but its path always is slower
     than ttm pool allocation.
     So add condition to use it.
     v2: move a bit later

     Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
     Reviewed-by: Monk Liu <monk.liu@amd.com>
     Reviewed-by: Christian König <christian.koenig@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
     Link: 
https://patchwork.freedesktop.org/patch/msgid/20180209024410.1469-3-david1.zhou@amd.com

> I got strange performance issue with 4.15 and 4.16 .. but SME was ON
> on that setup ( even before it hit mainline ) and never broke the GPU like this.

Well that is very interesting, you are the first one who reports that 
SME + GFX works in some way. So far we only got negative reports for that.

> There is a 4.16.13 boot dmesg which has no such issue:
>
> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-radeon-SME-ON-kernel-4.16.txt
>
> With the setup as is booting 4.16.x works , while 4.17 trows the errors.

Please do the bisect if the patch I've mentioned above doesn't help.

Thanks,
Christian.

>
>>
>> --
>> Earthling Michel Dänzer               |               http://www.amd.com
>> Libre software enthusiast             |             Mesa and X developer
