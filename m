Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-540544-1520346754-2-6376367459815710425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520346753; b=eSg/jpkAYU75wxbHGstwYfaWSvveyI3Iqagj2zXFgYCeMgN
    4Y3izZuQU5aMWW40Y0xvknXWzJVSlMcfGs7Aak7JJ22sQ1pedt+a8ITFBlgxj6XA
    9OFLNaHPr6ZkwC3OJLLl7VwSnQme73Qd2F436w08Wu68i9mxGObWqZQiM0yIeOzg
    LsIJH+9Cbd7w7TNGUnP/iNmosVD72jOdYrWN/evgDWI6ySJTBX1bESW/5i6DoGLe
    s7g4oerZiAo+3OOogvvuIdLA2wfYqjaOyV4ibYivod85ALngCFmeuEMSiQTI7JSP
    914Ox/3nd1i8RjQ/wGZ37ING+h3y108Eel5uZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520346753; bh=HRkbHvfXX/1STQRUtJ/kFLi/WzTXjZsnaWe7/Wq0SwM=; b=N
    4ZZ6yZ5UZqLUxiRVbZCl4K+rZx+nSyUTMsK0XbldAMdiH313OPQ0UiAXFKqjKX1w
    BhBMElwbMDKKLC1rjYHaENNyfc1l3iQT+GL4Cygvg7z0BaMbz8lR1WR0LofmZYpx
    gsE8qYKyOOUHjdD43lWR8TSIKj047otJY7M7XVQ/eUTPvNiKfTdcsZuBEWfzSCmt
    MCQd1jOrOZtQB0fmzALMTF2vh5zJ1P3N4oHi5FTdWB5+SHxTW9hZsBP9tiQNtklo
    7y9MhipeQOFB6PUFomvn03VJDgaVwkdSEWXfufKy1PClLw6ZzeV/F9xfRoxzpVBo
    KP+n30/R92bB6R6RTebiQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=MZws9efC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=MZws9efC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeCFOca (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 09:32:30 -0500
Received: from mail-db5eur01on0130.outbound.protection.outlook.com ([104.47.2.130]:65060
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753344AbeCFOc2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 09:32:28 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 4.4 163/193] kasan: rework Kconfig settings
To: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170351.424191376@linuxfoundation.org>
 <1520346571.23626.5.camel@codethink.co.uk>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <93bd3861-6b3c-95f0-466e-e5022e0ab3d2@virtuozzo.com>
Date: Tue, 6 Mar 2018 17:33:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520346571.23626.5.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6PR0301CA0044.eurprd03.prod.outlook.com
 (2603:10a6:4:54::12) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4263c750-c2e1-4bf6-b821-08d5836f1440
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:XQYlJ/GrvWbmPZg8MWbRRzUlzO4Unz4T4pO8VV2J6HBcTgOEF9v3VcyEJOwImUdiN+Is9OGd0RZ6XUbS8MIYAnGuVpT+TGr+GnNuHWwOoYFx05eqTDocLV86iaSVCLtKXyYAs+s8jT+0h+d/eFRZWQ1zd+8+pE19q16bKuhfhSrc1vLiEYkslyGnSfl5/lGjiEaFmQcmEkNpfj4snCHphFfkEMLEUHtMrlQ5XhEHLD7c8KTQCXsko8sEvAe2jRPz;25:9QbqI/G9ICsewO2K7GnLAQuYKO+y9sc+IwOA04Ohuq+VA6K2lBPMqp7+RhW4eOXPy775/hs4LO52ho6vAnXR0D1Io9/LMBHoy0fFS11UFIgNLGsT/lIOa9eYmOGyvG+c1YuU/KDDKKUNJK0CEt5zqlLj8yVyL6NR2G2GsZkkajyOhyot67ncsgPPhVKUe4bgFHMqeGpHOFo9nt67m5v4vIlH4Fp5tIvWhRgs8GVSOb6ICe9VGgzDnvkMZS5EMnX58NP0XkzoC+uH39ATz6zUlEkNu4JvFcsB0Nsekd2JXI07Az5haXPeJe0MqyIhnDn1fzRozQ5wDKxRsJM98sE5RA==;31:wc6/OTS4D+JFWfBseogcvsHAgt40UCnjsTvCxRvPESWvESqGB3EI4yS08OQXYrTM0KZ8h3sCaULkiswkMloDLKsHIIUnrcLKItdJ0q6aeF5Knzwvd8l01qUKWonuQzoHY3XtyfoGf68KjKab1ohVav6a46Mj9pswj8sK2Q0UfbqNNwVZp68P/ZRhD7bNs8sz+xgYIGTyJ6jOtVNKdVC3iH80JIcpIVcRIT5XiHhM1cA=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:hY+2HnE3Qez5R/hc3+kX3hN6Bx6AeAsqhLCZo6tWKOxSZNeO63N9awvOMnb56vh9X1xnUCVqjhVhQustk8umAuRfhKJSHWowRfpa4ctcv4YhUXUqznP0ObN/5MIs/Iejjq+VQI5EvErOxKB1bzYqqAt29ljrtCfpdX4wlai++NOqB8+944UWvklas6VSPN9HquvMYQLjYnFKObUfex6qNS0r3ZPUvtDIakYf++kQ43H3UbJfKkaT7+CYZINWfR/NvQFrcDj67Qy6BRA8tW8a75P/sOCzcZFWLF4wVWVC0K1/QFUWa0jX7xo7/Qxnpdz2d5TF3GAt20kQn6f84xV23mID7FsCuITq9yU2gzKtMRtiizl+eA4kl34KxkloRoBYT3zgnADd9Oew6qsw8CrzG+2mYWYiXIEtsKPHdAS8Yw53nhirXCXrJ/vKl2tMScTGvBZI6FTlpzemZMEppU9YXu22tFya9d4oVcnAAUehu8bELLGlV1ef+kdXosimtqmT;4:srcWdCC6jBzZ/FGCu6thQvt6i2aTTX+Z09sQlT3mZR/uwrrorjgK/CjlRGiWnE8JJx43hD28mmLTRemNY03hVrPg1WpSaRZGr2re3PZAtU78R7gFqIL5q1JKiCgG8y6CIGYL+ErhQlrf4bpLZqUybwVLQdApvNGcO/KQKCQEZH7Jym6Pkvzk/bGxWY5Hp9RWYuJx0BrBfpU/F1eQF02T1+HEWpZ32xq+kfb25Xfmyf9CwFeHPXDiVtR9wVCbgocdlnXIEqvd806JxDQaC5Tu0A==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3254669C3741589C26359453B0D90@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(396003)(39380400002)(376002)(39850400004)(189003)(199004)(377424004)(81156014)(47776003)(65806001)(386003)(478600001)(3846002)(6116002)(6486002)(77096007)(26005)(2950100002)(229853002)(6666003)(59450400001)(65956001)(6246003)(25786009)(4326008)(7416002)(2906002)(2870700001)(66066001)(8936002)(53936002)(36756003)(55236004)(53546011)(23676004)(50466002)(81166006)(2486003)(8676002)(65826007)(305945005)(110136005)(16576012)(16526019)(54906003)(52146003)(86362001)(7736002)(64126003)(106356001)(58126008)(186003)(97736004)(52116002)(31696002)(105586002)(68736007)(31686004)(5660300001)(316002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU0OzIzOnZkcjJhbVh0MUhuNWZPbGFJMXgvTXdZWkRU?=
 =?utf-8?B?WWpKU1VpeEttUnYrSXpkTWpWM3J2d1VwNWg4eTFNL294R1lnZzBVcExERDFJ?=
 =?utf-8?B?d3ZMUklJcmRWQjhGNVpVYmliSUN6Y01IWDdOdDB3L2xGMXMyY2o1L2Nia3M3?=
 =?utf-8?B?Rmp5d2JHMDlNZU4xa2JOOGtIcUE1Z3JsbTBMTFlLYmluRHZubEJVaUY1UjZC?=
 =?utf-8?B?dTFmcTR4c2ZTWENjaWVPZHlmMTNWRzJ3aEFIeW5BSGhpRi9VQnVMUU44Ukp2?=
 =?utf-8?B?N1h4TktVMHVzMWk0Z1dYNytsdThUMy9xM3p3cWt0alFKelIyNndSNEVEczh2?=
 =?utf-8?B?UjVFcFk0bTdDMGNlNWRqaXY2alNjZUtJMElRMU5QK1Q0a1lkdTlLTllWV1lV?=
 =?utf-8?B?SUVRZ1Q4SnFzelhzU2xNWlV0VkRqRHpvT3orVGNrZDU5bDEzK3FUTkRTWitB?=
 =?utf-8?B?OFl4T3hhaTA0T0Q0dDFhN0FlVXhBQUY0UGZQWVdINnJHTW8rNEZoQ1dOUG8v?=
 =?utf-8?B?ckRSR3R5RTFQSm1XNXkrYzV5UWRNM1BIRzQyT3lSdmMvNk9hY0J2N29wRTVM?=
 =?utf-8?B?ZklkWlVJNlFiL0l1TGRCOGhBRlVtV3FKM1hlN255V0RaNERLb0RoNGRqQ25i?=
 =?utf-8?B?S2NNSUFmdFJ5VTc1cnBqbG5Sb2d3N0dXVmUzWFV0ODNxZHUyTDF4NHl6MUZD?=
 =?utf-8?B?SUJYc2pvRDl0MFVBeW5RNnVEZ3ljVUw5bXdWQnY1eDc2N1BlQTN3bUI0RG1O?=
 =?utf-8?B?SkVtWTY3dTcyK3RGVk1FK1cyVkZ5dU1sNjZROVQyK2Q3K2JJQWNVb29pNEtw?=
 =?utf-8?B?VTltMkl0b1dENWl1bXNkV3J4TXVRNzVOUDhuRFB5enlIMHpFUk5MVzU0R1Ja?=
 =?utf-8?B?Y3RsZUorelFGY3F3OGs3ZXAvZFI5RjBEeXBYMThqT1NKL0xEZjZ2K0s2K0g0?=
 =?utf-8?B?cFYzd3dzZWUyMUdXSzJ4aW00TFFubFlodWZnalNIKzRRcmNaV1RaK1MzQUQ5?=
 =?utf-8?B?cVNtazdYZUlGRUJWcXZsYURJem5BNWowblVkK0pCSmRCcXlCV0ljbzh6YkpG?=
 =?utf-8?B?b0p6ZnFGbWlTZFZjRVZETzJQd285ZUltWXgwa0Z3VG9CYWZlTm5OeWlBcTZN?=
 =?utf-8?B?YU5Da05udmZRaUlUUGpjRUY5bnFOWStIVVBvNDBFeVFTSGgvamNlclYvVW5y?=
 =?utf-8?B?Tm5hZEk2SXYwL3F2RUJWN3Vtd1RhQ1IwYTdkMWdFOHJNWjVEL3pqMWNwQ1JS?=
 =?utf-8?B?YTM2MXJvRk5JeXdjS0lPL1hPYVByaTJTQUhpTWVWeGNPMCtOSk1uMzhTYkVC?=
 =?utf-8?B?ZEQ3ZFBsMFpDQ0s0b1A0by9tQTJRWUVMcFMvQmxvYlgzdE0xbUVnaEJpUGcy?=
 =?utf-8?B?R0tlbkdiY0twSXNWcGtEcEZZM3hUT0hNUFZSSmRacThWOXRLcm1DVVVFekwx?=
 =?utf-8?B?MDkwNElGMU5GcDYwUEdLU1NLWnp3Ly95V1pEZ3hvdmFmRjdIMjVvU00vUklX?=
 =?utf-8?B?WW9wV3ZlWUtEdkpuM0pJVlRiSElvN2tIZm83YUJrWnRnbVJnRmxDZXN6QmFr?=
 =?utf-8?B?R3FDMytPV01YZDlLRmVKQzBqWTgzV2tTdzVNMHpnZDhjN2hUbVowK0VQTGdN?=
 =?utf-8?B?M1U0cUVJanJHRCtOMGtDMzQxUkNjV0txQll2UENzWGJvcG41bmc0U0grRkZ3?=
 =?utf-8?B?R1pZL1ZMUVhyRGNOTnJ1Wk5JN3pPUXREWkZ5RkowV0p5YkxxazRVZ0Rrc09Y?=
 =?utf-8?B?NVdwa21PdmtNYkZCcURjaVNUV0ljb1BPbERoYzYweXdPT1doZ0dLOWhJWmhi?=
 =?utf-8?B?SjFHSDZyY1dJTVZzNytXTHZPM3FnSlgwb0xDc1NTYjFPZjIwR3BPeEx0emgy?=
 =?utf-8?B?N2V1VXUvdEFxcmk1VnlwejRJUEdDZWM5R0Y3TXpvZ3AxcmlVcDBSbHVNNEpW?=
 =?utf-8?B?WXNmSStzOTcyZCtKMkw0MTVOZlZZcDJvMytianBPeHhaT3VCZk9UcEIwS1Er?=
 =?utf-8?Q?bQUTOl?=
X-Microsoft-Antispam-Message-Info: +U6TEzhPVdsrK/4e/z2VRkQw4Fk1lY1tK0bBNyy7E8ygnCqMDGEqtUT7wWQfd0fs5QoF27zaJ561C6NEFziws9ukqftn9mFToNKC2ZgQMDTIuA3mb+zsz/rXzt+/Qu2Z2uxywT9OFePXBXW6oaAQ7pFX5phGJrXzcF11+YBEdGq+P1HY8sf2dOlBCriEvTUH
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:TOD3eyc87N5ZrBmyf9HJdztEWPfavwXo/cJzJWfo8hRQ7g86LtUHGbwFNspOZMCnG+VTzNRPAg44LbXX4JIQ0mUG02bo7SDK9BqCtQVgkriN0nIJRdOsIMFFMif1G2DApAucsDpliwbhrfN3KLgHT0g9UBTdicwQv7CjgGPcgfU8Acup2BwxVWI4G/IOLqv3SicHD9vCLqT8ri3jQLgxVqc0D0tNmNJmp4DL0EOUA5Fp+EcM8U0lwmMJgwn3lQDsXzDtjfWyPkDGq4KykhAy3M+EsIz+XbDD0UTQdSZ82rXbktlv+femjMgV6zyl4NDUUb6pz4bEKfSk04AbTee/xm9CEpAAOXvcKOsxjwq2Sew=;5:cEed8btQQnCH3TiEhVfX/DRUsiJiAxlUCNbs/tBKJGIR74RaYwPvHsyKD6awc5CMXbdd+PZZMx+uQ3vjj1bFYf5oxa+mMJkR8qaiRmoGbi476NZPSrFsEVTVPNJ6NdJ6pQZxOgegtWzuzPizajQUWMeokt1G4hgRlEQXH1TeZ5s=;24:aH20YcAxSJQGjsVlVd6Kz9k+XDBy8QSTSMtIe6mH1o2iXT3rLbdt5xpf8WxELq4H1hD4wxJMZM3jJrqNSD+Dm3IvKzIThrBo4n5M+pqQbSI=;7:YjeIpFekT8MP92p5yHLy05HVMUBlld1oz4uVefU1klExOKoo5kuxv4boWHhmrBJjmcjCrf0aMnYLfItZUfXomuuNOA/eZ4VocOUNQ2FGzumTmT6KDDDiYUKHLPVf+M63eo5oz4FU/9EcJuzbrpdyqXFxtzbmXVtniIZvMmAU1zU354u1oj4BCkQRpQ15EO1UF4ieI/KciuWdCKjh/4HWcffIkjS4QlWQGGZneZaNBt6OZ+oREbyzmt+XHByIclS+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:N+zSlMkKo2QFUAOFAYdBT4ggL3YgxB4k9zGHGQ5FvjNeZkKB3q+ANqQZ2zsHEb8nJX0uZ4DWzNJv8QB22F4Gx2D4mp5ND4NSCBzQiYRA9E/8E6uzbtyCwGe9hniwVsijm90qyxyxPZBjFiwm9Cb5FuDTBapQH0X+8NwwfZ1iDi4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 14:32:23.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4263c750-c2e1-4bf6-b821-08d5836f1440
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/06/2018 05:29 PM, Ben Hutchings wrote:
> On Fri, 2018-02-23 at 19:26 +0100, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> commit e7c52b84fb18f08ce49b6067ae6285aca79084a8 upstream.
> [...]
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -197,7 +197,7 @@ config ENABLE_MUST_CHECK
>>  config FRAME_WARN
>>  	int "Warn for stack frames larger than (needs gcc 4.4)"
>>  	range 0 8192
>> -	default 0 if KASAN
>> +	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>>  	default 1024 if !64BIT
>>   	default 2048 if 64BIT
>>  	help
> 
> This doesn't make sense for 4.4.  There is no GCC_PLUGIN_LATENT_ENTROPY
> in 4.4, and this line wasn't added by the upstream commit.
> 
> I think all that was really needed in the backport was to delete the
> 'default 0', right?
> 

Yep, 'default 0 if KASAN' to be precise. 

> Ben.
> 
