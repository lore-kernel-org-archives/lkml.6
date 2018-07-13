Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EEDECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E896208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QaTlO8XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E896208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeGMIhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:37:02 -0400
Received: from mail-he1eur01on0127.outbound.protection.outlook.com ([104.47.0.127]:47856
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeGMIhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGi2tsAM3yk+BY/mcRWNNJ4jUeXkZey37yElu2b7uzs=;
 b=QaTlO8XX/E4B7wpmKjkIAmAG41mp4oxTD7cjnmnyhittWKu5xPM4MnpwVN51dlivHwxBJi+xNnagChkXF0Ygm6h9DwO4T+nMfAdtkEIGIx97TrrMZIfBLbeRo9LCzDjL+hTUFMUZbsUZ6gR/IsDIOZ5S43M7nJuX5PRznSCCLxA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xemul@virtuozzo.com; 
Received: from [192.168.43.234] (83.220.238.176) by
 VI1PR08MB2991.eurprd08.prod.outlook.com (2603:10a6:803:44::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 08:23:21 +0000
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
To:     Adrian Reber <adrian@lisas.de>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
References: <20180712130733.11510-1-adrian@lisas.de>
From:   Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <d79abec3-566e-12b5-fa67-3cd8e3158eea@virtuozzo.com>
Date:   Fri, 13 Jul 2018 11:23:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180712130733.11510-1-adrian@lisas.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [83.220.238.176]
X-ClientProxiedBy: VI1PR08CA0130.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::32) To VI1PR08MB2991.eurprd08.prod.outlook.com
 (2603:10a6:803:44::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58342e2f-036d-4353-41f8-08d5e899e58f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2991;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2991;3:jBisppVqGLPVnXEDg2monjsscetHVA/e8zQNF/pibBu3rC8MbZthbqijOa+vu1g+7v8HD6P4PE29+cddS0cZ/+IsQit3yeprx6baE7OhbYgJap/0l95DpbTLXkkdsZxsxHCppbOggrzar2a3PZO2e0oev6n4Q40NMUVS2/QpnR6ycAKaNOABOoxA4ZRNqKNp9xgdF1ogE5WZfcMIy8PNkgFYMUKXkwaXtj/IQ7zNKuwqGP0masqd8QKjeyCeSMZk;25:g8IkybdPdeqrR+fSqNO0aoqBKjNZewOQ2q86k8//DtttGqTbFlmE5Hud1icBIVYXiChoKc8LbYY/WNhgSTbt+bqsBrS+/7BO24pdFne+08BH1KT1e8F/o9MIx2Jp1xgtGwpijPg6PAH8VuDyfV4fz6jmnZOPXOvjNNlw/K+V9ZmF9W2RaxUOfnHv/c1isLCA6QvvFHXkXJo3vN6jPIR5p47HRd3Osc6w88RVKHo7ooMN88J+RNwfFx7qskaf4bqS/jgmfiMw0lwwxd87j2Rgr0Qp9U+nMy+qrBjJJemHN40GBPTcWuKI5BMeSZ9fl61CXKM+YsrFiRZrrC7Cort61Q==;31:gBqaNgti5fyuUvKU+DqgOsxQNYick5AwVTn5plylrKLiE9CJSA7yvu+WGVFjuAgV36ULVE0bXwW/ZHzxeEBnreWKmpZ1eNU8EO+PQMKlDlkSM/hPQ07+LrUzq16VWx5b/DMcm1aukmy3woJMzX4gg4klg9wGfo7PEFIawG5pIas76rk2f5TCJvMoNk2+SPEmcHVIbLWsGu+MBZqkCQ9EwlxQnZhLouQYQBwxbNd0n7s=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2991:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2991;20:gnJLXuxF3lYpMkngMxuRS39tm6h/uEeDpMhQ9i/JNycE02zm//wfb89lPDSqTnADV+NXj683ZkfNIS1uMAQCCi9gr4GfFL/zngoqqV8DyaRgnEthcZUa3LRh53FyZ+tI7kx4Zqy+K5aDxnb8rV2ERlOeWFvV1G5L85td6yG+vys+RgegFfV5kY4+EncOM9g2X+vtQqvdWlBlwWNYDNAXiGIG+nE63na89kS1qbzIVRFA/XBzmg3LIk/atJysj/zbG7J6Q0W1/EdQ7FnYnTmy6E6jkzydXTxeP7D5hWKRp3TxlmhtALW/mDyp6nAfERiz/NTaIXRNPItSCvGYE2kyobmyq6xnXaQoq6VJB7ktqgbMqebsIbdJ2Cw9zrRchgbMxa3Ohhi72HSVgrXddAJl1W9R6BRrJ5rz5wkBzsGCnsleS7de68X/qdlBdUu44nmIbbLO6d4TnOWsEiTkZJh79JbsAb6VEHpM/zO4358ZgYi4UfDLTEgLbIWGuhmt8sVO;4:GKhT16yPazuurcw/C7LwoJl0xJx4xX6eyEKNaZBEcWzc81JRdeUHwnqZjtmxg9U/tzjEOlZq4kaaHc13Qbpd3dFzsYYO3y9jE3T0hu9sWV56obtaJ6G9czYhO+Tdppev2sWuOXlRnYA67/tMJvPopSREC69g8n7zKKxXLlpzs3Xb2jzLM7JaJGZIkfHSb/Hl3Lk4uPw1oNNCtzpDJfew0nJthSk92YaYtLkJPBHqvbS6s7d/kJr6SP7QqUOLuvyCeCPku0vG3G7jedDikdMTQ2BWVESajzL73VYWapbgdSC088oKq9fS8lbeoG/BWAUX
X-Microsoft-Antispam-PRVS: <VI1PR08MB29911052FADB91A6C2BA7F5BB0580@VI1PR08MB2991.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB2991;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2991;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(136003)(366004)(396003)(39850400004)(189003)(199004)(6666003)(47776003)(66066001)(6486002)(65956001)(65806001)(117156002)(4326008)(31686004)(2486003)(77096007)(53936002)(26005)(76176011)(2906002)(23676004)(52146003)(68736007)(53546011)(478600001)(229853002)(25786009)(386003)(36756003)(16526019)(52116002)(186003)(6246003)(956004)(476003)(446003)(110136005)(11346002)(2616005)(305945005)(7736002)(50466002)(31696002)(81156014)(5660300001)(316002)(14444005)(16576012)(8936002)(54906003)(486006)(86362001)(58126008)(64126003)(81166006)(8676002)(97736004)(6116002)(230700001)(105586002)(106356001)(3846002)(65826007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2991;H:[192.168.43.234];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyOTkxOzIzOmRXL0J1cWUwZ0VLeHErVCtBK3lzbFNWQ2Qx?=
 =?utf-8?B?KzNjZC9FQ0pkWmUyUWVTZ25UdW5wLzVWaEUyYzhRVm5zL3NJTUs0YkNvMWxo?=
 =?utf-8?B?MDYzdnF2d3dHT3V6SE5pSnVyODhVbW5LZWFiVWxiWE42c1NPSUVRc2QxNWlM?=
 =?utf-8?B?ZnBaQ2NuOTJ1ZWMvR3lFUkMxZGMzYzl4Q2VoNnAxR2VGS0tHVWtzZ0JNczNo?=
 =?utf-8?B?ZlpFb2lhT00ydnBLZVl3UndUTU1JOWR5dlVtdzVRWWhiU01jalBNMENvV2ZM?=
 =?utf-8?B?WnF3aUNLeDU3T3AzakdoWnJldTU4RlgrTjFmT3U3MUl2NDdhUkVkais2UThJ?=
 =?utf-8?B?UVRPb0NLUHplbmcwa29ITDZoek1DN1Q2TjdISS9Ca0pYMEZNUXZoWW5rUHAz?=
 =?utf-8?B?T2tKenB0ZDMrNWwvNzUwSk5kbWh1SjBENzU5aUlRclhVU1NlS3UwT2ZzL2dW?=
 =?utf-8?B?OWRNVVhwQ05UTEtjTTlvRDMwVGVudWxXRVZLWEwxMi9BT3BiMzZ3OU1uemdH?=
 =?utf-8?B?eVh3L2NMTCtGMEVDTGdVTmlEZ0htZ3h6M3U3NEpsUUhoVnlyclQrZDQ3LzFU?=
 =?utf-8?B?eXE3V3ZGYTRiT2pxTTM2YkVZOWtGYUowczg1cW9XekMxUjNWZ2NUeWtwTS90?=
 =?utf-8?B?eFpKdG9adkczVFBiR3RQUjBIQVNQY2lGbUxLajdrOU5OM3FpTVpyUHMvbzlm?=
 =?utf-8?B?cWY0bkMrRkxrU20wdGszTjZzcU9abWdDMFNxZktzODVUL0tuQVlFQVpzbjkr?=
 =?utf-8?B?bVhnUkNjMHEwR29NT2l2MHNWTzNpdWdUV3BwYWlrdTdIempWcTV2ejF4NFd5?=
 =?utf-8?B?U25KY09naE1WSXFXcENyOUVhdnk4SXpuRGh1VEgrOHF5cmRZdW9vUE44Vklj?=
 =?utf-8?B?Zm5jWjZwZy96OWhFWE5sREZJZFZpczBnVFlSRE1YbUhzdXZnajB3alNJYU8x?=
 =?utf-8?B?NkNieS9aMnh6a2RXS3M5K29CQVJTV3hLWHBtTmtJa2twVTROUEJyQVBiZzVy?=
 =?utf-8?B?R0hoUXlXVi94dXdTSW1jekZoS3JNWDNrMU45dVl6T0UxRGhxaTFYb0ZtYXJV?=
 =?utf-8?B?TndZV2dqc3ZrRXdkLzdMWU1rM2xtT3dYMng3QXVRbEc1N1R3YngxSU9aT0F6?=
 =?utf-8?B?akRKUzNjTkhYYWF2SVBESFptTG9TMHozcUR3TStFbzBZVWxIQVNDMXpHUytS?=
 =?utf-8?B?ZEpvOCs0eUd6aXVXZWN4TTZMRUNKR2lUR0VWbmpsd3pKVlFrNUFKTlNYczBC?=
 =?utf-8?B?Q3c3WEY0RlNEaWRmdzl6YmJEQkh4OHZDM0FOclU3RkNaY1hkNlZicm5HWFJ1?=
 =?utf-8?B?eWdGUVh6MWxzSk9NaGljRld3VGZDL3MwODkzdVZqa3hTRXFQcTFiZVN0WEc2?=
 =?utf-8?B?V2UycC9aQ0hvWmFTWUJGc3FxKzJWM3Z3ODV5cjNsbWcxUXBSWUs1amNScTJI?=
 =?utf-8?B?L1VPSEkrVVE1SVdLKzdTRXlIbGNkTFMzeDFqZFZoc29PZmNmSE43SXhSazBN?=
 =?utf-8?B?c051UW1SZUhhZW9QdERyUFhRelJVakY5ajZJdk53ZXpuVlpwYnE5bzE0ckQ5?=
 =?utf-8?B?WkxPMzlDa0hkOTFYeU5WVUdXNXcyczc2VWJLYUdUZ3FOSUM4K2JjMTVDRS9M?=
 =?utf-8?B?bnpuRXIvR0p3S0dWeWFLdEtWRkxzc3NNdFZUOVZNNkNWcTNUNVBEVm9nOGV4?=
 =?utf-8?B?a0hUdGJnQXpIZkRDbkVYRmxLSHFGZmkxKzlYc0tlcHRHSHgrVDl2eXdBUndm?=
 =?utf-8?B?SXIvS1U4SnFRVlY4S09tOFl5Vm5UQWExclRnS2ZMZTdzVFQ2c0lLTmxYY2Vk?=
 =?utf-8?B?cmoxMVhQK1JWUWFyQmRwSEx6ZU12YWlLM1I4T2ZWU2NudCtDN3cyM2lDMHdY?=
 =?utf-8?B?NzV2S3NTU0cwTkxxdkw2VmlxQzZCV1ZIa3QvZnEvYmlhTHRJN1lSM2QvZS9z?=
 =?utf-8?B?TDFjVnEwR3plMjNPci81Z2pTU1JuUkg2QWRLSTNBRFhZbmRmbjJYS2RyWVF0?=
 =?utf-8?B?MVdMSU1aeXRlNU9wOG1SS3pBMkVtMmZLcHljdz09?=
X-Microsoft-Antispam-Message-Info: N1f0Hd8tSxyWOofvPF3DQm/OdmeSL73pzb/s1W5J02joW41++Tt3ywjzE4zkic1UH+5qj7AF57IBlDBRYWcF+VD1iz7SLpFry40ZN36yANjH0jCgUAQu2eKhuveUsONQ1FB4y8U/TjsMGnpMM4qbzaT/HNR6f8epoFdGHpz//GioE37fuLEzYp1KD+GzYam7+ynz3sGXPnWbdSr36C7+g8aA6hQjWpVJkRR1JLKQ1v5A7BFVR579y+3jpAQ2N1AWvnCs2V12w6iHOoqFAoJbwmtQCCvTHMzf9VqEV0CfHZVidX7N1rgYe6iHWAa3JJ/F6yoHENsN30xZD8uzX76yPRUplBh4BoGEv0nZDSgegLs=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2991;6:h+SBEPFefuxa8DRQk/f9UuQnyEFRsf7IUvgShhPgtO0FNhD1c0xqBl0Xbf0VyMIA3CzajdEN0NT4wLFU+4YY+dj2RmCraTvukr2ws2I565nnqXBR+4uVUdzGrPj3+2KcKF63UlkB7AHiYd0bXvJT9L+fL8DPNMGuQMA8qyudghOLLLvRq6+vaNSlAcrMS+EADRCclR8W2hzqWQ+aHgCX4Dj3Q/lyf4hqK8a9TpS4vnS2dAA6ctZnz0rLKNqZA8rRs8b8SqDldIik3hN81C2pZmvs21YIZpiXtXs6AqGMKpwVFp4YvF71vhFfl00N5C2W5niz9FkuDGO65b14RifcBPbZCTiPFWVrNrsqphlXifdR4hmqLImdhVmi8iCn6g+RWjqRcI5SRtSETYpl3SbfADU46+WlTymNZIvv9lfWzcITUUNAilAZ9eHaEiY0+GaS4BYMA1yvZlO77lueErEnyw==;5:9k2EKKckDu6+Xa9rOFIZogy6vryfg3lAPdiwqB/WjTqca46YJr5RX+fIdchjk4N2kxNgpEWj8YLHIXE+1ljl4HHhxKiEqn091Jr7mVZaUf9os6j/DlzgEhh19HcHqtYQsal26uQK4V+/kBMSWsfCeTf76gd4u818Mbm+cREx+qE=;24:nnOpKg0gtw4w9ydkaygpFfyi4M9DlM9FcIaqBrwXbIZnSdf1XlU9pE1cl4DLM4G/TYq7HD73czbrEGES3n8W5E2jkupiLDyQL/g0UsO3VYk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2991;7:Ek+evX1MNwh/49nY6PRkl/xcwluHrR3s3n3jI5mWWU6RL2c8siKAWHXYk0EG++pr+5HNpWL0QkBx3WKSR3msj9Q/O8CWW8DLEbdFfJRyjrQZ/pQBVjj4zjOW/XtHNAETw8VQyHiPDIXaAufxfeptjRIxo++8IR5GNyZlVRyXPggKVbbjmDq138X2LsthgT0lPqlpuUNb23cxw8v04OUcI+TDiZsyg2bbjQvwmyISca9JxKscHUnae71mhO14ng+I;20:Ze4xo/p8qW/7xKk0iM8hHgtk7veh15GHtXW+/0xLDhqKrH65YI8BnUX2Cc6wv7F6zxPEn7skuz0BGa6ITgS1wQI9EOekGkRyXqsetscJn/b01xbLyj71twRBYuFqJ1TaSyBeFoVQGrAspEE1hXmusH6t5vQ+oq7KptvsoDoCtXE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 08:23:21.1086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58342e2f-036d-4353-41f8-08d5e899e58f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2991
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 04:07 PM, Adrian Reber wrote:
> The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
> combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
> distribution kernels and also part of the defconfigs of various
> architectures.
> 
> To make it easier for distributions to enable CHECKPOINT_RESTORE this
> removes EXPERT and moves the configuration option out of the EXPERT
> block.
> 
> Signed-off-by: Adrian Reber <adrian@lisas.de>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Andrei Vagin <avagin@virtuozzo.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Acked-by: Pavel Emelyanov <xemul@virtuozzo.com>

> ---
>  init/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 041f3a022122..9c529c763326 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -932,6 +932,18 @@ config NET_NS
>  
>  endif # NAMESPACES
>  
> +config CHECKPOINT_RESTORE
> +	bool "Checkpoint/restore support"
> +	select PROC_CHILDREN
> +	default n
> +	help
> +	  Enables additional kernel features in a sake of checkpoint/restore.
> +	  In particular it adds auxiliary prctl codes to setup process text,
> +	  data and heap segment sizes, and a few additional /proc filesystem
> +	  entries.
> +
> +	  If unsure, say N here.
> +
>  config SCHED_AUTOGROUP
>  	bool "Automatic process group scheduling"
>  	select CGROUPS
> @@ -1348,18 +1360,6 @@ config MEMBARRIER
>  
>  	  If unsure, say Y.
>  
> -config CHECKPOINT_RESTORE
> -	bool "Checkpoint/restore support" if EXPERT
> -	select PROC_CHILDREN
> -	default n
> -	help
> -	  Enables additional kernel features in a sake of checkpoint/restore.
> -	  In particular it adds auxiliary prctl codes to setup process text,
> -	  data and heap segment sizes, and a few additional /proc filesystem
> -	  entries.
> -
> -	  If unsure, say N here.
> -
>  config KALLSYMS
>  	 bool "Load all symbols for debugging/ksymoops" if EXPERT
>  	 default y
> 

