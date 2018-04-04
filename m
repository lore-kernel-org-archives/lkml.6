Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-426418-1522857084-2-16059283654297962872
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
    1522857084; b=EIrNy1moeXKshiwjPnH9u8D2U8/QBYYc4MMwthy9+MVsg0vz1F
    qKQyFwQW/PW1rrm5iXxBm9SppAxhib5sntmTEPXORoQYvSzYtkI++pfeTqV39CNc
    W3pJ3zIR5vi/iBeoxr12N3j39yDLynOJ2zXQfC7/51KXebVnhogo5wi9OBeaxe/B
    4g7bn4hWg35bPjcOiYkEgMG0yoZ2STncU15iG6aXlUoLVHbF7JUqr9BfCVO15L0C
    ni+1T1dRqCZ8URhvC6cjoX7As5JcgxuvV6P8b+IJj5nv52pm3n/3yATLFbyh33Fb
    9JSGC4wJz4XiAoC/oE0oFLnURk7diVZpvoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522857084;
    bh=BrJfMWJDd6Ze+wC9xL6mHrgaY+cU4H6vNZvWZaifM5g=; b=B9lJTuOP/MVN
    kKTNRbyFyOomavfXkN0BXjNwo/JQ1CHzzCLu+qclKlJB6E7+z/32GiuFPDUEU/sn
    rN+CSmON5cuJGxhrNu0pTMuFrkicJEVIPHzp65puDcG7d8sgRwaWDqNrHdj7RtGH
    82BKythTVWY6xq99WxgBghuO/rKm9cdaP6F5csmHGifn2loEZSgNGGNGnH/t5iZG
    M2ITlI137LrMo8S0urQQQzshNDm5tNUihNh1EEIOmmacFaOvFppRRrNWSxdMC6sP
    DlgppxoD7hjMlLEn4aE3deDaDR63hDU2eYM2P0TeZSNnj1NE46Yn6T804AYsRqNL
    Go4aSene9A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=LH64Ker/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=LH64Ker/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfODTyFVRrojoi6MImzrXxOtAS/OkcnwEjXzoVJLZGED3Px0MwhQ0Px7E4r7RLAFaGZNl0kxYCXKkYdjP8OVhGgCrGU2UggXc9YbboNegC8FARJUl5aJc
    ababif/SgtyBzIVGC6F0/F9iYMq5Gv4UizTkkpN+EWLgz0ypK6W0TXfsh72JJdmdvWsHC6r0ewZxu4DWNkEK095JIl/5FN/w1RSXQIQfnN0f3X8LzVDUTSWv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=dhh_qWxcV0sA:10 a=Tgzm40sRGssA:10 a=BHzdoRfpx9IA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=tpEzL2_AlxEA:10 a=ik5KRz9xOIx7DBEaaA4A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbeDDPvV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:51:21 -0400
Received: from mail-ve1eur01on0133.outbound.protection.outlook.com ([104.47.1.133]:20885
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751620AbeDDPvU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 11:51:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] locking/qrwlock: Give priority to readers with irqs
 disabled to prevent deadlock
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
 <20180404153534.GI4043@hirez.programming.kicks-ass.net>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3c9b507c-c6bb-3e13-2a82-f3504626d016@virtuozzo.com>
Date: Wed, 4 Apr 2018 18:51:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404153534.GI4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::28) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f514ef7-935d-4d2f-52e9-08d59a43e6aa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:WEoV8iL/Yi3Nodvf8iR8z7YoszNglBPhPHpusFmXYz9/u1/Er/7rjOHW7c/qf/XQY9uul6q8Z8ExELP429rLf8irwCD3iIPriWaCd1dtOZTbj0C3omyeuB8jGnVP9UCJCoY+g73avoHSGiLtnlkKOaz35KPTcIcyq86cZyWnQayfuVBgecar6RT4qQFbbq4mhAnJqWdLbM6sFTRRdlgtepfeur2jyceyT/Uij3fJGNajqd7KLByG/+GIIh7QkJ8E;25:w/RiVn6y355cO/vY9GRruY+gJSyK/972qOUhrxNoB/cuyL/jXLUfAkKxNuFnw37AfTaZYHqVtGtbnhV/7SFv78KLtQi76dG7Byknr6UC2mIWxgRHF+n63+x2hsO9UX4WA9mzrbppPninb4sfC9GKIsHiV/ePL7r5wNhzxws/Agu28B5+h6vSbvdSJa6PUp1W8Z8gn3NCaucNdcZ+rnLKMVHXRRziMKA4gpYr+um3B0FyKCIXyTy5rvD/H6bHZ6cFFAbwQKeWfBPvQM3X10YhgGLS/06HLnyIwN6Cd06zp3iT9i2oR8+GYZCk10/6npykdjhCGGCu+jr5pLUqWtr1Gw==;31:S/t2BjmpX7+5wH47e6b9RWY7SR/yYIWQWsWAsdLxLAOAgRH07+qtrBcCj8Xuy7RedhxZySnN8iz0goWxA6Jkh5vHK6ltvgI+HHliHP/a5SjguuS/7c0GcwSW21Dt9/YfIZBCPWIgpDSihFvRwN5E17Rk3S4s53f/kNyvpV9djxtF06xMMJqeuVFdcfWVLTMglkvUKrfZcTeFpmHLkj//PBWEL8/R/QBskR+5ZWUcIAQ=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:IXC1IC7AuQK4ClAEuqF0expxDMFm7gmiqjOrE8yUMDtDhe3hu/UsEXDEm6ekz7jhCmS02Hjeas2P1SAUWJaSYgPaHsRZxKDGG+gCB+JF+MvLNezdJvm/tNH+DUaNEi7wzT2FHhcGJhEE3ysuIHu5W0XsEcnnXt+ppO9sXEPa5BHzSxetYWzEtE2X5lpSy0Ymb2exjvCVpl+cPILpZfd0sTHEDzOCtXOKRB+CYHAR+9GqGdizh4XLg/rZRiTn12xA1JzPNadF0jcC9CIymbz5ttXl/VX0n5fv4v81RpCWkFPTRTJ7Gvga/OWTN6pRNcnX4deQR9XGE4H5K424IpqMgIuu0Z86N2Z5/f8Uyx5Xpxshn8LBwksb8UA832pKgKR52MfObVR1tTtsIlnJBOGoMJJOFcJ6VCxeR8cvzljIOx0lnRL+pe6Eu/vKm2F9IecBPvYVN7Lz6U59o9zleOI4erOHVpabLhXJtXCpkrbCyS1nZW77vuycGhrRNnJzoY/K;4:g7X5o4Y8avZpadd2Hf8MKWU7q4co38YLUh3/yfJbuNJ4Nl/SyEU8QEwDA5kC++BIZdEgKgRzHL1MSL4/TbWR/ldfvpyx/liFCbO14oM3AbKuodJ8ZGTGTADCy6Vk6VE4WphEe8YckKbOmLq3LPKDVaM6dvy4fzRr+RY1A+V7C+ZTxzqAO5oZblGcB6vIUPQncsLEfM4u8sVhy1uIUEjRVWuKO50XmKv0ddLE4Yk0ppcCaIHMPEfD8fI3sGJqPpdnja4QvktQpf9SQdoIPGibpA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330C435480D8015A45B352FCDA40@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(396003)(39850400004)(346002)(39380400002)(199004)(189003)(11346002)(316002)(2486003)(8676002)(25786009)(305945005)(229853002)(186003)(53936002)(6486002)(68736007)(7736002)(65826007)(77096007)(86362001)(8936002)(59450400001)(52146003)(64126003)(478600001)(16526019)(23676004)(76176011)(52116002)(105586002)(47776003)(2906002)(81156014)(54906003)(476003)(97736004)(956004)(65956001)(31696002)(5660300001)(36756003)(2616005)(6666003)(106356001)(16576012)(58126008)(230700001)(6916009)(386003)(446003)(39060400002)(3846002)(26005)(53546011)(55236004)(50466002)(31686004)(4326008)(81166006)(6116002)(486006)(6246003)(65806001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6UWZ1V0RqRzdLWElmTEI2MlRYbVY4T0Zw?=
 =?utf-8?B?UjF0eHJYUjBSR3ovQXpoUlREYlVuUXNyc3NRZys0WW41TXNEaThDRzN4SGNr?=
 =?utf-8?B?V1orNmM5UGRSeDlUeUhDM0d3dHQxdGNrNWczdlZSbHdoZXgzVDhxUExQdWxt?=
 =?utf-8?B?cG5KRTROZE1SbHFrRjBIMVVtSXUvUEY4RElsZzUvUEY5cFlwSGlESHp5Tmg0?=
 =?utf-8?B?dVNFOFF6RTBnV28rWnhNbjB3MWF4elNqVmFNVDNUaEJ3cE5oNG9MOEg2RFJZ?=
 =?utf-8?B?WkpnazFuNElwYW43djZ5bWlqZlRjeFBmNWZxOGkwVzV3QjZ2WUhDUmQyeWN4?=
 =?utf-8?B?SFQ0SCthY2NPUUU2eVNab052ek1jNXdZUkl6S09jS2kwTTJYdjVUZjJZdmR2?=
 =?utf-8?B?NC8zYjIvK0hHU2ZsU0tmUmIxMGwza2JsSnVnd3lvMVZrUEI0L002N3RETGZz?=
 =?utf-8?B?dWcvMjM3bFFKSm9qWTZjQ0ZmWE51VExxMnNiNStGRDRFc2NaK3hsbzBKUlZF?=
 =?utf-8?B?MkZyM08rTS9YYTRObm02SnFDcER5ZTVSVVd5YWRibVdSNTFLbWFWSjBkaTFR?=
 =?utf-8?B?TThFcGpYaUJMTVpYOU5nK1Azb0xsT1NHOFJnTUpDWHB1Zk1RTVFjeld2NDZa?=
 =?utf-8?B?alcxR0VRV1RhOUJES1QyWHpMVWJyak5YMTlqdEFpWVNhUjBBYWd0eEtOYWJE?=
 =?utf-8?B?K2F4STNndTVORTF6UXBBM0t4MkZsNHhVdUJRQVhSenZVNUNsRHdHeUJhdVJN?=
 =?utf-8?B?cEFDOTNvWVZrTldCYTY4U1FtOXlEVVlWWVU1U0dhZGFLRDhiK2I5NGlhYlhO?=
 =?utf-8?B?R2VIRGFYMHg4VDVrNGlIbEZJWTcyWkJwNFJLM0YwazhwQjJDa1k1YzhZUVNM?=
 =?utf-8?B?aUhudjJKOFlwOUNHcXQ3RWU2cE9hMkdpYStDci9iYlUvQmhXckRjcC9lWFgw?=
 =?utf-8?B?RmV1TnM1OHBwQjRROE9Fbk05eTE0VDZJNGxTUk1FQWhzcjN4UUlCTjRBd01k?=
 =?utf-8?B?Q25GZVBVakFEREl4NWpEWVVZL1BNdTIrN0pEWktPRHBaSEY5aDg1UDh0ak4w?=
 =?utf-8?B?RkU2S3p6R0U5YzJvakNCT1FFaU9vejhHc0g1T0FJSWM1U0w0ZVNTZHJCeCts?=
 =?utf-8?B?SzlNcDZhbjJoRGtjZ095NUpPckMvRzJYUFRNMUhyZkw3MXplU2M0R09sR1RC?=
 =?utf-8?B?MXd0K2FHUzhPbXI0bGhNZXRmSm9YT2tIZThndHVOWXkvQWZ2aTI0dVNCRktK?=
 =?utf-8?B?Tk9YbFBjYkVqbTVQdURDakVNNFc4elVYNEdJZXVLd2QybkZUR3BjSzI1U2Ew?=
 =?utf-8?B?ZS9Xdmd1WlN2ZTR5dDR5TEFwTG1lTU9JSGorMkk3MWh5Y3AvWVZ2NjYwSXp5?=
 =?utf-8?B?MENsUEEweC9lOGZ6SmxRYjBSdWk1VVhsRzJBUkNUb0RZNDl1L0YydlBFSGxr?=
 =?utf-8?B?OHNGVWN5Wk1uUFprUEowVC83cDFzUEFwQjB5T1lncWsyUGdjWnpJNTlOOUFh?=
 =?utf-8?B?aUNjWTZUOFF6a0txMXIwMTd6UDBxL0puN0RrRThublpXZ3VvNEF3Z0RNblE5?=
 =?utf-8?B?aGdmVlYxOXNmanpMTnNjY0NTd3l4cExHTEZQQ0M2U3ViN0c1SXNtdnlFUURF?=
 =?utf-8?B?YnRlcFN3aGl5R3FoT2h3d0tVK2lUbEQ4RlRPTzRkZjcwV0tVdVc0bVhhQUVB?=
 =?utf-8?B?WjVnWmJ1ZjNGVHIyVEViYlpVWStmTkxtVm5Ia2xnWTRSZ1V5NENXOC92MHhE?=
 =?utf-8?B?eEhGcGFYUGxUVXFlSVJTVVZzT0VyQ0NNNWo5MVNFVDliaGpSb0FzcE1xQzBZ?=
 =?utf-8?B?WVpuazY5Vng2VFYzZTBuR0M5N3llanQvdGY3TWxyVk5jYnFKbitzTlBqb2dk?=
 =?utf-8?B?bnhSSG9YQm1SRkJFZG04K25GelBhK0h0Sm5ZMWpMRmFBdkNwdWV1R1V0SzNV?=
 =?utf-8?B?YWU1NUZkR1RuRFZodXg2UkI0YkNTd0czTUhFNjVELzVDWElKc2dROFNOYWQ1?=
 =?utf-8?B?SVdsbjZGOTFnaGwrNkdoL3g5clNaaFN1OWFhZWtPTEZreTVWZXZvZ25yTXVj?=
 =?utf-8?Q?KeQPNg=3D?=
X-Microsoft-Antispam-Message-Info: ZFLpb7EgcEN1934H+qqAG6lzUhpCz1wdvQCHES0BNQmyMtbLjegOd6WigiaShOcJ87qJmnOn+UkT0avUuKoFXvJhQed75Rdr/6WqbvwK8VYEdMPojuFSs0Hq02NwDPhP4aWtRk1GAIRT7rbSo1mHMuToO6eXyOXgLCHPQGTlbp94ZjobygIUHpnU5Xo29lPw
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:mgxXfYvf9kKs4ijgV2u/rGKJhFDgJiF8QyMgDshsfiNwNQm845WXVxZE/rfhc9ew8Ayfky/XdeWX5ZPewdpGwDQRjvxLLNFSH6ASnXMhvGaeJKlxk+AtXcBYuZ2ggd5+3qehcCYmQlxCKXEMbubjD4kWsp14mLmaNr5G0+pbx0Kco5pr2dFMqajQo4ldUs6gFKUPeEaJEh3Lg4emhLgtZsq9vvF13Qx8ESERXcMGmCWOrndePknicziXpHdVoErapgagAKNOh2m0jXKzs4zZ7wP7bA3neGDQJxv+Hj4aZ8USRNRfw++V/h3UP5qNNzOD/vY9heXlOwSyTkafiYUqwRS3wrquj0PFhRuFQEHJStO0PwUVvHRVflh5VizJFA6Ina4S+uX+IhPAGvfDgHDsHCzt5vWWSKw9vy4Rfj7R5blzSFm1MQuFyYuaposVHSmwWYgW9eu55CyIm2MWnsd72w==;5:tlmyu1nbQ97lZNKqAYrP/g5fw9ggSDDYLPiohdkCZMuegRbYCh7BF5wDZSRTj71Tzam+dP2kmlgBYgaU0fwfOOHUlvJKHCqxuNnlwxPFk/mBM8owQDKaWONAbgGOoNvXXwcOQlzl71xkpKW3NKRaC4k6oe6LTMg6NGJqpUigZ1k=;24:E/Z4Hp9ifQD8aHEborqg2PIfqB1KIVQbFd+/juWplCDGIb7GXsm25OlnTFg7vNz3S3PTxrxKky7BCP7sNaOq+1h4hFvrZquq4UBlRW5Ha9E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:o8bsD8aeF4PPAeJCUYEF3YTHqFjbOirOh/wpgdVsC14zp4kYxVlPtirYbq7+/G0KiFl7W90sX0BORW9IAeSAoms0LBe8+LaCtj9i8qeGkEscDJmH5KvOqdbURXmTeLBzgtGW5czDmN8017DhdwxP40BIx3pjmT9wN0zHXDCnm99fGmtYwmbI8OCen3PkcnC6pY6Z1LGfn5so2UBXqYvhkvR7AFY3uLmDbzsYfU9z/cp9AirGTXrAUWBS1Ycu78di;20:Ou86iTXSIb3SSDjMYvHsHgFesRXYJ2AInGqr2iUTxLOaIIgfD1TVcRcLo8txxSRstHCONaCIyLkolur3K0cZc2keyQhEyMK5YTV+aJFjAdI3SIrHUyoG8t7CWANFefYr2DSUeS1MA1Jxenj8QUgG8YNxL+96ZjOEnZcV/Wt28nI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 15:51:15.9526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f514ef7-935d-4d2f-52e9-08d59a43e6aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04.04.2018 18:35, Peter Zijlstra wrote:
> On Wed, Apr 04, 2018 at 06:24:39PM +0300, Kirill Tkhai wrote:
>> The following situation leads to deadlock:
>>
>> [task 1]                          [task 2]                         [task 3]
>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>   send_sigio()                    <IRQ>                             ...
>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>
>> Task 1 can't acquire read locked tasklist_lock, since there is
>> already task 3 expressed its wish to take the lock exclusive.
>> Task 2 holds the read locked lock, but it can't take the spin lock.
>>
>> The patch makes queued_read_lock_slowpath() to give task 1 the same
>> priority as it was an interrupt handler, and to take the lock
> 
> That re-introduces starvation scenarios. And the above looks like a
> proper deadlock that should be sorted by fixing the locking order.

We can move tasklist_lock out of send_sigio(), but I'm not sure
it's possible for read_lock(&fown->lock).

Is there another solution? Is there reliable way to iterate do_each_pid_task()
with rcu_read_lock()?
