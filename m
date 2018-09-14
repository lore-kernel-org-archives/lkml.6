Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24394ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEC82083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEC82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeINUF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:05:28 -0400
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:13715
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbeINUF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkvey89vMKLRLKD1o0qBldmSJOUtqtZZmCxqemvbsJE=;
 b=JWdW99WComr4TTnqmmSDJp8GqlZNlVhopACPWCvx06rR6/41+OM0QOD/80DBEn5zT6xB7bfo8hHozeY1Cjstn7vGB98sDiJxem7hi12VMVBYi5WXa6FBjE4QMvxwy1LCBuMlemntUO48VoYUdqt90cwJAE4bBqhFsbmit2TsXeQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.18.82] (165.204.77.1) by
 SN1PR12MB0176.namprd12.prod.outlook.com (2a01:111:e400:5144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Fri, 14 Sep
 2018 14:50:15 +0000
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared
 variables
To:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
 <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
 <20180914071056.GA4747@zn.tnic>
 <3517a0db-2f64-6d09-7100-dced40561d08@amd.com>
 <alpine.DEB.2.21.1809141414390.10480@nanos.tec.linutronix.de>
 <20180914141216.GA29898@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <07c76a33-7883-f407-5b1c-b6de7dda37b1@amd.com>
Date:   Fri, 14 Sep 2018 09:50:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914141216.GA29898@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR12CA0070.namprd12.prod.outlook.com
 (2603:10b6:3:103::32) To SN1PR12MB0176.namprd12.prod.outlook.com
 (2a01:111:e400:5144::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1a1df3-39ff-42fa-34f5-08d61a51624e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0176;3:ee3znd6IMbiJxDQUr/NI3OKpZcZ/xS9LAUEGMYU9VaNj6fgg5GdAnNW4p0qadhxrGMEpDna7ASqVsaPD0VDtv/s0pzAnxrKzUIcwQS5oEPljMAOwE4apLP5pf8Q3BYpA727oYtYh6X2e5lZR/YA9J6toLYUniF4Bea0faCLg7KUV0zQjBcutFbOgFxiMJvnM6VuwC4mgY44+gKxQyEiNmwM2GQqR8vsrNddg4d1Cab4GRNQzNqO+m4ZYOTb6sqOY;25:7jLfAsh2SSV+yb8jCWc74KfC6rpHZGlxTACvIFG4HZqW0FYWzVjLiDKkNzLVG6d/e7M4PKm1oXTTkZC17hqhUzIr2QkRclG1hPhZ2rgVWbHhzHvg21qVTBzX+dIR/lP/D8qkODCE4R2f3LRJ04T0EiGtN3h6IgLKfx8d+yUPF6k0ivlH23w61Q8Mbgnu6esf1R94hJ7mbiL9yImsP6Z+VbldAQbRJgKFHewJRIaIrvdP0mNt//WtWx+svhIw82te+gsFWqg5eo1NCeiRuDqBv86An5lmLXrd+h5wstvFZ/jvIRIMQPwDFaDpnI/m1aXR2vhrS5eQ1BQc8Qz+R14WBw==;31:lm1BvCDulSVULoRr3A6kxcJSccOfgIbQcSC4wsmWZwA9tp3eFv/zX+GDpbBzHZQadalOIGvFuAgL8O1owwrUlvgregjXfQ/+r1Ep9OwNxgug09JqmiczV/TbV6GDe2Bb28J0Y8uN9TiEsAoTCRIFZ6Q8XXoJ6DynQZnW3Gok2wmr+FLf9L+ALxPY1oVfzE0EEbxBLWbtKicODBLryZuCTcvRwosdSh079jJpoFfM1gI=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0176;20:HSy9jxsjqGmYuFrB9UPpjM6IBYficJ0CCCDWrZUbMCO//vBYH3d5sz96gaMvSQrKvwMGoTnDoNQn18JhP2iiNf06pJKN1kBGMCQfnErAG/82fuSblyzyiB1ubwx7vO2QK5etOToTdKrLSGgRNe0W5NEsDFIhzeEmwrvNfEGWPMrBQvnul11dwBUzRCMFOReAoRTrxoYA/FOqB3Mrl/ndoISu08d9FkDA+aW06nvLEpKJ+RcqnLjtSXfNsFWq8O9rfuQiZOSjCLbku/fi+cNF2Tc4fQjrLo51o+sOy8MK9Ky3okwXf8i40W2SvwU7NDmdKRpCoTcbd3WDzcmlkSZueXHH5qDkwgkNHZa1FjtAVjfJBlpEpjAoAe7NcPqwZJicLcZycQv/jpTmwBQgqmOvGYYU0xPdcap3JV8OIa5GAk3r1Dda8hTeeES1COjl9sYxaSD82nZhGRzY7eMC4vacvvY7K39GlmnXEbq9DjiMF/VO7fZHHcQYXxR7p9LgvpiJ;4:2+QYcngoTTtI5nzVmzttNoO/depGaoCot9KXbdKfeivDd6/7/QXuAFSDcWKBeVo0IziWTPt1vutUgtqItH4wDK6tH0QdYv9XniL5svZ46VLYbhzNasTnojvBRj/SYDhNTlZwWyvfM5gV5ZmkOumFrBAv+GuyFlPtinR/7rk5A+1hSEARCAlNXaTEWSbeX6pkuZOoN+3MLixQYSxurw1lQ4bg5ydU27tYDqbmqK+6Ls488fk5zJlxrfVZ128yrC3C4HdYMFRZxQfquUknr6Jadw==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0176751E7389E2902DE5F9EEEC190@SN1PR12MB0176.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699050);SRVR:SN1PR12MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0176;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(136003)(39860400002)(366004)(376002)(199004)(189003)(58126008)(446003)(72206003)(229853002)(386003)(52116002)(65806001)(2616005)(50466002)(23676004)(956004)(53546011)(7736002)(11346002)(97736004)(77096007)(575784001)(6116002)(2906002)(14444005)(31686004)(8936002)(186003)(86362001)(76176011)(486006)(54906003)(64126003)(52146003)(4326008)(81166006)(8676002)(16576012)(6246003)(316002)(6486002)(6666003)(81156014)(36756003)(31696002)(26005)(5660300001)(93886005)(105586002)(476003)(110136005)(2486003)(47776003)(2870700001)(53936002)(65956001)(106356001)(16526019)(305945005)(25786009)(6636002)(68736007)(66066001)(65826007)(478600001)(3846002)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0176;H:[10.236.18.82];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTc2OzIzOmdCOE90ai8raGp3Y01sd3ByNXpTNzNxSHlO?=
 =?utf-8?B?amFJTFdHUSt4aTk2a1QveTNISnhKNUp0cDNFTlZZSkJDcWdpQ1ViQUx2NG94?=
 =?utf-8?B?a2ZzL1ZWTkx0c2Vkc255N0FWTXNlMmR4NXYyMWx5MTNzU01LOWJ3TFZ6M0pQ?=
 =?utf-8?B?S1dlbWRZQmJSY0VoSDhTcVJPUndNWklVb056b0J4dFI0SE4vdGNkSE42Yzcw?=
 =?utf-8?B?UzJKRisxcVZsZ2lmNEdTUmNBNW91TnhRRlpheENPTkx1ejJtcFZ6TFB4UG8x?=
 =?utf-8?B?NTlFdHFJL0ZvemRhelc0MFFKUktMK1pRbi9oa096dkdkYnRFbUhJL3UwRXpW?=
 =?utf-8?B?QjltUzRlYmFzSjdLNklXazFRU1pXaUVXWFBoMUhUNHkxMzhrdGlpVmRJUi8w?=
 =?utf-8?B?dXZCU2NiQWVwVytQZklVUEhXaXdVakRObzJNR0Rqa1lNdFpHQkcxTzJqVWxz?=
 =?utf-8?B?WStnMHMvb2lIR1RkckFjQWk3TFU5bWVtTTlqajl4Q1ZGTFRtZW9HaW5TcnlD?=
 =?utf-8?B?NjlPMWEraG11Rk1BTWxZTjF0NEpzbmRpUDBRYTZ0cUZ2WGVuM1F2ejVjT1Jh?=
 =?utf-8?B?cUQ1VmpSRW1oTWFBbzBoSzRNR0FPcExJL0YwWGlZdWNqenV4a0RPc1ZjdE9B?=
 =?utf-8?B?bUhmU3JEdFBuVWdnUnZqMzVxdGtERlFIU2tRN214cnM0UHNObW1QR0xKTFpp?=
 =?utf-8?B?ZUpuN1pUaDBrMGtYSXVjbDhaWEllZGxaWTVKTTJ0cENLcnplaHRYQ0pSNWkv?=
 =?utf-8?B?V0FwRlNWQ0w1azV4ZnRZNVhsdkp4anBUMzh6VG9sZllvakhzdzVXRy9EZnNM?=
 =?utf-8?B?ais1aHZMYXJzOEFRSGNSb1RBbG9YQ1hoSW1GUmNSNWp2dEtCaktKTXNWTWZZ?=
 =?utf-8?B?em1EbG9VTFRrMkVIRG5kckJXS0hDaEJlSThGQndWbHNaNGtTYzd0Vzhmd3lZ?=
 =?utf-8?B?UFEyRnF5VGoxS1EvS0F0OFIzUkVaZVpnSWFZMHZQR09tbjBDWlFta21ZUlJq?=
 =?utf-8?B?YmY4S2RIa2ViTm9NYmI5bCtJRDM3aFNQYzVnS29QL041TWRCRy95MlVEdFYx?=
 =?utf-8?B?WVFocUgydWpyaG9KN1BubU1JenQ4WE9LbFNZd29manZRRlA0eDkxZkpsb3FQ?=
 =?utf-8?B?cUhPd1RwVmh6cExtWXpmZFJacHlzQ3V2UEROQ1YvdVo1VEh1NC9tRkdNdk9l?=
 =?utf-8?B?Z3hOd1o1MFpoeWZONTdsTkFvUGtoMHhTa0VXSjVWSW51bFhXVElQcm9qeFA4?=
 =?utf-8?B?OWhCU1NVTWJ5TytKUDlxL0FXbWdvZmNNam95ZVhxWi9aN1dmYVNVSTNDeWtU?=
 =?utf-8?B?UGd4QklIZzlNS0VobWJoOGdmSVhreUUvT2twcFdBV21Xckg0VmZ4NG9GREZJ?=
 =?utf-8?B?Y21qdURQMDlMOS9JU0I4a0gyWHV1WHZUd0lNNUxha1RsbFFjODR5dklEdk1z?=
 =?utf-8?B?cUJpZUt1c2hLV0NGb1RLdWFsNFA2MlBWeWhBWmtYNHBDNU1peFVpSlpEK2pF?=
 =?utf-8?B?cEF5YURGWjBybVVvYStoZnhBMEFLSjlHbTJBSGhhUW92SFd1REJ3eVh2VFFt?=
 =?utf-8?B?eGIxSGdYRWZoOVVRRks2Nys5WU5MUlR5OFE1Mk1tUDJONzBESGtyb3k5WG04?=
 =?utf-8?B?QlNnTlM2bElOWkdObXUzN0RDVmtCKzBlQTZDZmhXSitkc0xncmx1NDZCWnBv?=
 =?utf-8?B?T2VYalBncHcvYm1sSW9QcHNzeVlTSkpMTGJPeFNTMXYvK1pqUUwzMU90YWdx?=
 =?utf-8?B?aUJHaXlOa0NtNE9wZis2eXRNSmNWVkRSMFRKMElYbm0yK1dYbnJzdE1DZGIz?=
 =?utf-8?B?WEhuVlkyRVl1blRVQk92TktBcmlRYW4yMC9nQjRtWTVDd0JtRlc3cnN1MDk3?=
 =?utf-8?B?WE1jSWpNVGJ1dmxBdXFkQmQ4cWZjQlNxelJvVHE2TjdmU0VNWHJRVjJGT0Vj?=
 =?utf-8?B?QzAwVzFYUUQ4N245b2FnRjNmNXh6aHhSbTVNVXZWUHA4dHM0djBTT0xxcjB3?=
 =?utf-8?B?OG95R0k3VUxjYi95eHpydlRDcW5td3hPeDcycmJwSTQ0eHBQREJYdWN0NmVa?=
 =?utf-8?B?TkttRTYwVTV1Q211MTVlMEhzNlNHQ0l1WEdZWWQzYnVLQkZRbWtwOGt2TkZ1?=
 =?utf-8?Q?b7f+klYut7R1AxHITzbZHb2h31kadg/kdhbqMd9E9+Vj?=
X-Microsoft-Antispam-Message-Info: Ti3q1BMw3zVylbKymx0nHkdgim6xtj0gjnWCmQX4KiHXjS2vPu6ZxmB810lwsgd941e8CIH5I7QxdUQ0pkVQH3sf7yxC3qfGZukCQO+L85luj6ZpIpPUwW01XLU/vQLS6Txi7K9zM5pxdQGaLL9D217+1byCzZjsQo6KWr6QkXrhGeSSC7lA8f1dX93MFJg8rVSKQGVacbB8G7YPjwjlTtxcil3wI6QPncEZaWXuo8Si6NZQrveyHuzKB1VxtqHcK4yB1MESD0kIgp4uQAjkyYFHmeCrI5USKOZcEubzgq7lZ2HoxSMp3fdkMfp7qTGeQkPaGEt1V2Dk4C3qsZeYIzS4jbkCVvBT/ft0p5GC9Uw=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0176;6:wg2qnvFnh50kpH7f3KUt4yf+iKKybBxYDW3qLNY3adxiEq2hDKipkT5iGy97+XaDflJG9jKK+8KKsL3WMCXbHaiegSSzXGzV6GSZANawUd7KJ/REp979EHzMyGTDn5XYzmlT4S+TXFmkM/rfj2pVlIl4U/BjLLK5PeZvRyE8bVmLMWnSe3+AbJyic572v8slGKAsScdt5Y9EnZVVIRgWgW9REGwnZIgJYfpnmuhTj8Fizvk2FCXDU/sxREtjE8v13YwHSsq5t04cjiyf/P+KCo9oMTXBRTRFPQxTR2yWYUL8eNAdr50W3+uTKrGykxtt0th6AIIoWnn3UYZ2s11QOgDtTrwK/7hzmKZWRulxihHQIl4q+tOJhttGgtqaq4j+5QI93JbkvsOxtVnslL8M89aRJHs/UWL9uzIfptrQuWUZpnhcADnNZc9ut8WQ8w3+nORWGGN/HJoxjrnsNHDbTw==;5:PMBMQcOLHXAU3xnO8I6hgQBNs0gvE0a56NNyvz4jomSSoJ9igdcDFQNr7raASPd9ggIumUUxj0nMiAEBX8O1ImF3E+WOyHspFMnVjb1GsViN8Tub9bt80wOUjApfJZhaEG0hSTMEcNGwNah8+l9zpcAD1b2mBuwvp27AZOCAAgA=;7:yWT4clyfkfztYgliI1Bja2H/ypvBn9JplxVhJAe9KcC/lxhdFc2WHuIL6kE1jhHFnatu1MyVC8LxVYpMrFlVxjmy2JGxtaq0fWDZZfEASpsma+EViCp4fW+KoOGfdiYBhYDGbvI9vFm4MHz/6L9/TZZcd5uYg5j+HquOXjWU9QL3sK+ju1HibTapzReJW5PAxrOcWYZe9Qywk/YrviHK7kR6XZIsa+z5+3Q5+isrbCltQAIL0QjhkDbPKM5W9apy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0176;20:T7i9SDGZlx6Cv9EGQNthb3lbCF4QIbyyWUCk61HE5pvh/McpKs57qe9X/pBXmjZVusl4YA7vG1x59zhJiPWceR1PPi4lk6Nh2S7DwZZmYFNxQYeUWAGGzaJUOP5/44Rim1/McobdZON4QKcugy1h7zFWTqBRiJDOyeaOJ4cRlZIiE1DUGRkjg2n5Z392ldL0VU1+qvRU9JFxYTPOBtxtUKwMa/SpVZwleNI/6UYb84PVWiArIOg5VLRzMC4/Ah3Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 14:50:15.6750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1a1df3-39ff-42fa-34f5-08d61a51624e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 09:12 AM, Borislav Petkov wrote:
> On Fri, Sep 14, 2018 at 02:17:05PM +0200, Thomas Gleixner wrote:
>>> The sme_encrypt_kernel() does not have access to pmd (after pointer
>>> fixup is applied). You can extend the sme_encrypt_kernel() to pass an
>>> additional arguments but then we start getting in include hell. The pmd
>>> is defined as "pmdval_t". If we extend the sme_encrypt_kernel() then 
>>> asm/mem_encrypt.h need to include the header file which defines
>>> "pmdval_t". Adding the 'asm/pgtable_type.h' was causing all kind of
>>> compilation errors. I didn't spend much time on it. IMO, we really don't
>>> need to go in this path unless we see some value from doing this.
>>
>> Keep it here then.
> 
> *For what is worth*, a simple forward declaration works. I've taken the
> 64-bit forward declaration of pmdval_t as SME is 64-bit only anyway.

Just my 2 cents, but I'd prefer it to be in head64.c.  This is where
the future pagetable entries are all updated to set the encryption
mask by applying sme_get_me_mask() to load_delta.  So, to me, it makes
sense to keep the clearing of the encryption mask for the bss_decrypted
section here.

Thanks,
Tom

> 
> The below diff ontop passes the mandatory all*config smoke builds:
> 
> ---
>  arch/x86/include/asm/mem_encrypt.h |  6 ++++--
>  arch/x86/kernel/head64.c           | 18 +-----------------
>  arch/x86/mm/mem_encrypt_identity.c | 18 +++++++++++++++++-
>  3 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 616f8e637bc3..67c0e6cfdfb3 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -19,6 +19,8 @@
>  
>  #include <asm/bootparam.h>
>  
> +typedef unsigned long pmdval_t;
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  
>  extern u64 sme_me_mask;
> @@ -40,7 +42,7 @@ void __init sme_unmap_bootdata(char *real_mode_data);
>  
>  void __init sme_early_init(void);
>  
> -void __init sme_encrypt_kernel(struct boot_params *bp);
> +void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd);
>  void __init sme_enable(struct boot_params *bp);
>  
>  int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
> @@ -69,7 +71,7 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
>  
>  static inline void __init sme_early_init(void) { }
>  
> -static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
> +static inline void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd) { }
>  static inline void __init sme_enable(struct boot_params *bp) { }
>  
>  static inline bool sme_active(void) { return false; }
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index c16af27eb23f..6f8e9b534e80 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -112,7 +112,6 @@ static bool __head check_la57_support(unsigned long physaddr)
>  unsigned long __head __startup_64(unsigned long physaddr,
>  				  struct boot_params *bp)
>  {
> -	unsigned long vaddr, vaddr_end;
>  	unsigned long load_delta, *p;
>  	unsigned long pgtable_flags;
>  	pgdval_t *pgd;
> @@ -233,22 +232,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
>  
>  	/* Encrypt the kernel and related (if SME is active) */
> -	sme_encrypt_kernel(bp);
> -
> -	/*
> -	 * Clear the memory encryption mask from the .bss..decrypted section.
> -	 * The bss section will be memset to zero later in the initialization so
> -	 * there is no need to zero it after changing the memory encryption
> -	 * attribute.
> -	 */
> -	if (mem_encrypt_active()) {
> -		vaddr = (unsigned long)__start_bss_decrypted;
> -		vaddr_end = (unsigned long)__end_bss_decrypted;
> -		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> -			i = pmd_index(vaddr);
> -			pmd[i] -= sme_get_me_mask();
> -		}
> -	}
> +	sme_encrypt_kernel(bp, pmd);
>  
>  	/*
>  	 * Return the SME encryption mask (if SME is active) to be used as a
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index a19ef1a416ff..9dbc145d10f8 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -267,15 +267,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
>  	return entries + tables;
>  }
>  
> -void __init sme_encrypt_kernel(struct boot_params *bp)
> +void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd)
>  {
>  	unsigned long workarea_start, workarea_end, workarea_len;
>  	unsigned long execute_start, execute_end, execute_len;
>  	unsigned long kernel_start, kernel_end, kernel_len;
>  	unsigned long initrd_start, initrd_end, initrd_len;
>  	struct sme_populate_pgd_data ppd;
> +	unsigned long vaddr, vaddr_end;
>  	unsigned long pgtable_area_len;
>  	unsigned long decrypted_base;
> +	int i;
>  
>  	if (!sme_active())
>  		return;
> @@ -467,6 +469,20 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  
>  	/* Flush the TLB - no globals so cr3 is enough */
>  	native_write_cr3(__native_read_cr3());
> +
> +	/*
> +	 * Clear the memory encryption mask from the .bss..decrypted section.
> +	 * The bss section will be memset to zero later in the initialization so
> +	 * there is no need to zero it after changing the memory encryption
> +	 * attribute.
> +	 */
> +	vaddr = (unsigned long)__start_bss_decrypted;
> +	vaddr_end = (unsigned long)__end_bss_decrypted;
> +
> +	for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +		i = pmd_index(vaddr);
> +		pmd[i] -= sme_get_me_mask();
> +	}
>  }
>  
>  void __init sme_enable(struct boot_params *bp)
> 
