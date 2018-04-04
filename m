Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-426418-1522857326-2-14386360597993531403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522857326; b=lY5mcO5YhxWLpzyv89lJXgz46J9XMsjTJUtO/scVnzHMGfiG/6
    Q5SdH8V1obb/vaIdSyB9xiF9a/u30hRzZouOnmtQYA1cKFyl4BtAeM14uASjOcDX
    DUGRQf6X37O4KEB0Te8A441uZrqQMv00qoZ18TAWpaUNatQIegC5J5TTcmomq+sp
    ALFjbpbSrkYOpgH6JJM6mS7tvtJ/gOwlALcvJpbgYnFtlaAkwEmmcD3AFwzn32a+
    qHrQW1DDpiiP5E1jz6daQ8v7SCl4rP53jliA28aq7sc2PWsIHYsSi9cilBR+1c7h
    Uaytfm9fst2Qync2+5kVdPUay7Jw3hGlQPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522857326;
    bh=Q1IihAFuyxdlk8WpOJJjUzW2Gvvx4uNbL+yamdLm6gM=; b=gRokA7W4iAu4
    ulqpRVFebHWn0hzhNsf7Rzt3JLE5y4aAnIKTLtfGxjEftFquHU66IBvP8yRb07ON
    tLGZA7XdyY66QlZk1fmF+XxZBU2eBvpeZgTiQT+wcI1c8e3SZbn4ovJaAlWyLEA1
    2I8k0IfXpwnRpJ2/+sRkx5bZHF/DMfy3R0TYjrKoIAI2WDtaMS/w/Qk4AJ29n89R
    Jb1rT8MRQ+A425/HncZJRAiKVg6quNxdcm6WqdVsC9N1tu0Wt/0Q/sZfAwdm8RPR
    fe+SWGrLYADjvDaYG/rviTI1vCmaykfbRK6LnmHdlDLz3mrMBDbZGhQJ+OSNQ5eD
    N1GdoE8Tig==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=KbpNFtyM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=KbpNFtyM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLT8krRloDxS5U1bLSU7EklYh3U4ktOWvF6zaH0DTrd3NvnuW2GTFI+ekceUgkgCtkQJNyVaJysV+DQpj5/Fa4kwQqPr4flXGMP+5LbysjDgTLgk2aLn
    iiRwb1kSt7KZ3AP9nbSTD8cGkegv0zBgl9qR4SXxu6Aq5I+G8CeFqi38gXnW5/KbzQ3HlZUErbo4MUzZPZJAlV9CX2Zny14EKSg7kSLJyn6mnqBO73u8kTtB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=dhh_qWxcV0sA:10 a=Tgzm40sRGssA:10 a=BHzdoRfpx9IA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=tpEzL2_AlxEA:10 a=ROkMcCTqUkJbTB4lWDIA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeDDPzW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:55:22 -0400
Received: from mail-he1eur01on0112.outbound.protection.outlook.com ([104.47.0.112]:33696
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752030AbeDDPzR (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 11:55:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] locking/qrwlock: Give priority to readers with irqs
 disabled to prevent deadlock
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
 <20180404153534.GI4043@hirez.programming.kicks-ass.net>
 <3c9b507c-c6bb-3e13-2a82-f3504626d016@virtuozzo.com>
Message-ID: <af5e2a7b-7dec-6bf3-08e5-f6c4ebaf59a5@virtuozzo.com>
Date: Wed, 4 Apr 2018 18:55:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3c9b507c-c6bb-3e13-2a82-f3504626d016@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0038.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::24) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6218f724-61cd-437c-cda7-08d59a4473ba
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:42ojEWx29iKOcj3hE0oilMVHOmNi9n9dfdHYJA8ZxrnQuF+WV/3d4Z1CwN2md1Tl/879oN9JEg3TuHbgGh0sVZ+UU+YTR6xrfsIdvkvajQ2H1heCQmScL74MPFoc/8pNHBsaZ0O4e91TE3roQiOnGuWisX6DV70wNH5PwCJTpOHjLXdNLVYmWgc0iNVM+WJNEVlVrrho98wgLH2TL8p/H1zD3YE7jhTUU5VIaTLuWJEkGA9QYFHH/ywW4aGuMsXQ;25:ArIu30IQWZikn6FOTSNm7dup3vEbB1Syq73Rd9hJ1+WgVXYZ/7qmvmAW5EH5F7bzaqGnNEBRfJkm26Hbi5s7w2LdkOEERUU/Mz7d7Oaiw/PBCpZG3Sm/ljS75Wt0dFMXzQmlOuZAhw+Lyfi3yZ5Wi31KKpP8ciiZ1ffwiGhA4EsS0IM6+KACxuiq+gsGl/tLfo/K+u659DUh3c72JuOosGYaLUeFwzvcNF69X5yUpgCShwwvs+6YfMwLjQP38zajxp/HkTuTbWIXJ+gNivCNBZMztpJawklRlB13uC86yL5LYTzIfzP6/7/vIkcwbRfTnKNfWqzgkWHFk0akHQXYeg==;31:4Ts9m2pf5XAza8jO/dWLhTHznyGBTewI9sUQw/UFfkaAxWQLvcG6j2sM7OpQ9s+JE030HzKodi9FxwV2f421nYa0XyZ9peUu18juIgQptLHteVsMoGmI1GH8aBhs8QaHlVvrPcjiPllXNdwdu0X8Ek+d4GE9oEYQtQOe3hTM+gOxjQTUfkTcp5krZNkj3qOcRo02iZaYin9xLUvCDg/KkIWfv9U0A5u9e+3DxgBHIy8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:zTUsyXSFpMSrlMEMKLpFxk7SGVvPbVBSjXWuF15W3G1N+t0W7SCRjc+r7gycXmqb1PEqA1z0B5HycZB9DPXzupx/dY71MjCDuFKEK83bJPtQqc239MxVkjHbPQ8rodVvuOj1KYAKSCuGCRhspgyFOMu4Sbi50mzVJNTAHMFBY01yR8oygBVRcAqSYJGdi7AMV/Y5t+TcJkMTUOWZ+sTHqKyjcdf5KbMyj/CCnWq6CI1Rglq47w2vHE/eVBPJ4VVfnYkez/A3UEOINifjl6ZNFB9dtEXRc1QpWSYb2Mhb3i84wu0KKvZ68oe8DPERwTF3O/1L9snc+0czvUjW+vhLG72MJMsAEYAYXwgMXxXDgVPKCE+juxZfkwFvZQy4b0Bvk/T/x4nSG6tAlVxoHubK8CcmpXY5WIf2OB+ynQr2lTndj6R0Q7ZDXhHBioI27jCrtimzDUiGIBYRx4FAGjWzoc4CDNHBgEU7DaON351IKmJHyvm/SV+pmhD4oKJQhCPa;4:+loUtrmILjPlUA/E7lqFTgBCUaQIO7ZLsSw4XtwwRxvAtvQkqRz4U04XlvXvSQMZ6qpspcFbJ4QbMYfCBNvcjgLhRjYaNa5ABecNcOgGaMCqB91x0n81Vuw4KFTCmrFbB14mxTWHPCRNZvJXrUMEN8+tqCj+ofSYcjKagygmjk3Q+YM21mmlMCdmZBxUP7W55rocbfeRRwLNKvSv3LJmspfVQNC0mknZ4rsig95N1+wqgPnSNNyGpaBQjjAqMGdAuXOmUn6k+uUS6VYXr5+yCw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1333BA2A87332111574BC2C4CDA40@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(39850400004)(376002)(366004)(39380400002)(199004)(189003)(8676002)(105586002)(31686004)(36756003)(31696002)(50466002)(97736004)(230700001)(186003)(3846002)(106356001)(6116002)(64126003)(54906003)(2906002)(26005)(16526019)(77096007)(25786009)(55236004)(16576012)(58126008)(478600001)(386003)(59450400001)(53546011)(316002)(52116002)(5660300001)(476003)(2616005)(956004)(11346002)(65826007)(305945005)(486006)(7736002)(76176011)(4326008)(52146003)(23676004)(2486003)(446003)(6246003)(53936002)(6486002)(81166006)(81156014)(8936002)(68736007)(6666003)(65956001)(229853002)(65806001)(39060400002)(66066001)(6916009)(86362001)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6S3B1eUV3ZTVQRkZvOFY2RG1rMWtpaTdY?=
 =?utf-8?B?NGdRMUpid0VFZ2N2V0pCT0pPdU9LdFk0d1o2cEtVMHMyL1lJVXN3WnV3eGRy?=
 =?utf-8?B?bEJnWDZVd2tLLzRsWEhyMDZwa3FHRVRwN1dMbmdIMmJZRkJOdFNBK0c5MWlM?=
 =?utf-8?B?UDc5TVY3YXNaV2pIeXJxTHBDTW1XS1dIay9WNVVOdzBWTDVvczF0UitJZUVw?=
 =?utf-8?B?Mm1FSG9yd1BnZFBZV1ZTN0ZOM0gva1E2ZGlUUTRMcjUzNnZOWTdXRzY4R1Bz?=
 =?utf-8?B?bmZtK2I0OGluTkFodXpXa3MwZjg2VWJZY09CanF3QlBCQm5oV0Z3M3FreDVY?=
 =?utf-8?B?WXU3amRyZFhhQUlCVGJPTmpNNHFKdHNwV1EzTWpJa3RKSVFTTkIyK3dxRWkr?=
 =?utf-8?B?cUtFWVI0MnNyTGhFaFNzWFgySG1lUmZVNnBpOWhaMysxL1BFYjgybm1YdDZD?=
 =?utf-8?B?QTlHb2tWRFhmZWNOWmpEZ1BmZFFqUWNxVzkzZHozTFBob2NDbjVqV05IUUt5?=
 =?utf-8?B?TzdraTlTZ2RTS3luWmdWanBkQ1pxeWFEVGxpRHJ4U1ltSFMrcjMyUHZWQkhl?=
 =?utf-8?B?eGpJMzIrNWRzZ1dtNGdWNm04T0I4c2ZXcS9zZHl4UG9Jb3RTbGdxelpOSFpy?=
 =?utf-8?B?WllwSGNJdS83amxpNzIxQVNyYWZIbEhpdXRtSlR0T2JIUGx5ZWxqQ2EySkFX?=
 =?utf-8?B?ZGx3UXJTK1Y1enJLYzFpcHczTXdpY1liUURFRFJBZGRNbGN6Znh1bVhkQ0VY?=
 =?utf-8?B?LzBpMWhTbzgyK1F2QzBOdktHWGM0cHMyYjhCby8wWjU2SEQ3RXRiYmk2c0dX?=
 =?utf-8?B?ajVPbHp2ckJZYTd4YWlsd0pQRnNVU3F6K3BpQmpXc2x3dnc2UkJyNWNHZDYx?=
 =?utf-8?B?ZDFIM25EY0hsUWloa3Y5Qys1Z3FOam1JY01NdE9OTXl2REVxNkVBZDNKdk5O?=
 =?utf-8?B?NytMZnB0TGRoUnVUVXg1Yi85dkN4dHhaYVVWZnU5eUppdEtQNk5VN0tlZGRt?=
 =?utf-8?B?NCs1NWxtdjFXeWRhNm51dTA4QUw3M3lWSVh4YXpndThMRkx6dkJ4L1MxclZB?=
 =?utf-8?B?Z1l0cXRkODd2Uko4Q20zWGIwT2o2eEtQVnZYQlBvTlhlN3ltd3htQTdrSzQ4?=
 =?utf-8?B?SVN5blZjK1UrcGhqUEo5akZ2eVZSdFJVc0s1SmNHRTVka0pwMGZOUlhCSXE1?=
 =?utf-8?B?b0ZVbnNwV3ZhbkVoU2dic1hLVGJkRnd0Z0VNUlZnWXlDUzVnY1ZSejIxUGYx?=
 =?utf-8?B?angzL0htdm90YkxHemJmWm5lZDRlOHVDZWNxcG04RFl3R0VQem0wVDFrc0pt?=
 =?utf-8?B?cFdiZUcxOGphakI1cy94WEgrMURZWlJaaks1aHBVbmF2K2JRbEErYXZ1Sy9O?=
 =?utf-8?B?K2N0M0w5QmFkVWFrRUUzdmdJclo5dTN2bXlMMEdHL01rdGhJM0FqbjE4TXZ1?=
 =?utf-8?B?V0JBY2FpM2M1a2gvdC80K0ZPVEJLWXJxaXRuOTZCTEtBcEkxbFc4aDFzQzVJ?=
 =?utf-8?B?TmRvSXB5K0swcXgyZk5ZSlFjRElwVXhGdlFwYXZQTUtWS09nWmhnUnlldkxQ?=
 =?utf-8?B?REpKckZaZjgyV0tLVTA3UktjVm1iSmUyc01hdHoza3c4RVJrNy9BVUszTkty?=
 =?utf-8?B?QytSbGRyNlpYd2g4NmRjcVlnVlhnRnNpOW8wYjJFaG44b3pvN2R1UGhTS3Jw?=
 =?utf-8?B?Qm42QmNHaXA0MCt2Z2JlUEZVZTQrVmk2dVdHZTZBRGNXQjk0bGp0MWpieUZ3?=
 =?utf-8?B?ZXlpVW5nZmdZUUxvdUQrTXU3T2xheFp5L2NnWnFlMGVJV3d4Rm1hYjYyejh2?=
 =?utf-8?B?WGxLSndzNThkdUo5SzJHY2l5TXlUSlMwdDhBNDVnMkxVejJaNmU0L01MNndq?=
 =?utf-8?B?NDNGNlVRRUY5K3hWKzl6TUxSelRGWGsrZkJHQ2hRdm1RRkxmbkN0WXo4YzNH?=
 =?utf-8?B?dVVGWDlnUU1ZcFBkSmRDb1V5QitydlFpZWF3NVNJaGZOR3V2U2hib0Z0bS8y?=
 =?utf-8?B?azNkK3VNT0g0ZnRqZ3RtMlVlcFZJRmxFUncvMWQ2WWM0c2cwZHk2Y1NnWk44?=
 =?utf-8?Q?UxHYrM=3D?=
X-Microsoft-Antispam-Message-Info: zFQT7mferFco1IROFY3Tt8oENd/nL2AeRIZhVM3RET72Zpd760MTZnQMQQ008QyoHYtW4Mre8VIyie00g8WRUnxCRs/MutbGDcKIPn7hS3urPEcvQb/jxPaKUN4zOsqoLaWUiAqELNN9qGA+s1dPkKypY/1W+H7+5C346XWamWurHICwxFh5iXsPwK0al+tF
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:SMtfneh96KYTVH6+224YyS+EBAGRqOF0I7BkMRV33dVXjYZWRmjmSsprRpkJf+9k8FFzpaUjJIodPqtufD9TlTd5PxkuV+Cbguhy7MWE8yDXu3RPQs6bUoxpLXqv6aR38tMhhZuFHTKdVl1EqKY6YJU6dlDcSfBcvZBKHIeNs/6voX+noOZXL6gtybP8Hs5d4mAFfd4kkXiwWs8rXzezCYEwVluG39B7s7yGdYVKDm/vSQDGI+o4SYK2S8Rs7JBixL3qTXviRzjYjcDi2U+mBrMPnoHpxPyDeM9/1d+bGKTnxFu+uBdfMnAt5Z/I314+As+1WT7mJ929+g8Lxkg2PJmtl4AaZSKkfIq7o4meNbLSiyUb5+rokapg3QipWqUgUKJ3HXWp9zhJ4Q0Kmbwb5nxuodG8iiE5rLa2DvssaVSqjCP0ouxbbxaFBWZs8UUcT7j4zkCxjACAi5wPxjef6Q==;5:3fVgLu9euvDWXnQRxJOccGfZUycYKQ542Ms1jOKdH3q/97b9Q0Ww6otoP9D7osPPlPjMrp9aGgUwWCI5NvsUQRgy5wc/jrioQZxg5LLwm+fNqiXjIs1/IfunWqV+jICpyBd66zSCKC/N/KkG5wQ9cuZErlW4PWmt9npr5yBAMbg=;24:L3YYNNStl+RDFr3uHxO9WYQDSw3yD7uTTp822v/A19sxMs+bG4+gXJ1nGJpo0s+2Fi6htqbfAwoXEu0EzvhsV95674QH5Im0O2ZGQAiXE8U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:IVX6H64oFa3pFrit5GWqYB9YOsQe8OmJWTqY5F4XNId04Nig4NGUv1WFOVz6rI88SEvFC1cWB2+xcGJ6CS9MXj0FzF/vvk+TeK0D30Dge7vZQ4deeUw+TdwclQ4rT3bPoOvmxuQa9mv0Ir/VsoeuYbtxBcTyHVwaSuidKFETpK9Dgst8XNL7PLXQ1aM57cBUjmb3CUjGiKVlcEo4N9fl58G/Kv9Msw5wZZmAsFER7txUcKi8j4hFYcNE/mzAZb6k;20:HqPD0ys7YjcmeVaWEvXT7HSL/sTQNOkJIwM7OYJpe68lOnJ3EZi1pQmWdyndvBiPIIPxlSFj2Ua+YzHjKJfhShcRVRH/X6feBpCFD48NGnMjgoyeWPRop94boBXypt49WeF/y8CLjTFSovVRKOkRZ0mF1xp/h1zOXbKR+nk0CI0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 15:55:12.6150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6218f724-61cd-437c-cda7-08d59a4473ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04.04.2018 18:51, Kirill Tkhai wrote:
> On 04.04.2018 18:35, Peter Zijlstra wrote:
>> On Wed, Apr 04, 2018 at 06:24:39PM +0300, Kirill Tkhai wrote:
>>> The following situation leads to deadlock:
>>>
>>> [task 1]                          [task 2]                         [task 3]
>>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>>   send_sigio()                    <IRQ>                             ...
>>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>>
>>> Task 1 can't acquire read locked tasklist_lock, since there is
>>> already task 3 expressed its wish to take the lock exclusive.
>>> Task 2 holds the read locked lock, but it can't take the spin lock.
>>>
>>> The patch makes queued_read_lock_slowpath() to give task 1 the same
>>> priority as it was an interrupt handler, and to take the lock
>>
>> That re-introduces starvation scenarios. And the above looks like a
>> proper deadlock that should be sorted by fixing the locking order.
> 
> We can move tasklist_lock out of send_sigio(), but I'm not sure
> it's possible for read_lock(&fown->lock).
> 
> Is there another solution? Is there reliable way to iterate do_each_pid_task()
> with rcu_read_lock()?

In case of &fown->lock we may always disable irqs for all the places, where it's
taken for read, i.e. read_lock_irqsave(&fown->lock). This seems to fix the problem
for this lock.
