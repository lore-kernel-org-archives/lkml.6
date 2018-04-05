Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2451662-1522921433-2-2495339335427066674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522921433; b=BnHCc7JTJwjMLhMxEbGowh3wncoxB7mK2CfmxD6RbpbwTU4O33
    H1sHrq77JqNmchjGHpSXxIl6CMZ63ry3hCfmyR4pBqXGvW6HimRz4G1b8NizgoLI
    OH0Qy3b0mq0v5EAJgvkGmIKqC2q/lTIVmG65QBebHlE2xJNoVi29DPaIotNwTXpn
    73U0FmxZt/xyGYFn66ze9YW7np75lKoS2KnfHFoRF/gaKK5Ro6rm5VRQ7PS6Uv4f
    d7o55Fu87DYaFsowCBSGtOiVZYizd3gOUlMq4uqNEs6LU3nHW9fv1vuJRdnT2MOD
    GvQZr02++7dxnffXkBxLtNNnMXcZwHZWOzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522921433;
    bh=LHBOotTuWE2eRJZGfG90U37bxB3Hme3dFDzqu9WMMxw=; b=T7UJgZaTJzZU
    IwmVF3JsMDJUZkKwLk74mT12jmWLNYYi6yS/CYFGjqM4zGokygx4j/opcEh1Q9W+
    eLEOAf3Q+sWzysSOZblkb6BGbRONr0fwKSNee1EDXmqJH8HMFYQaMOyWQ5Joi0Tj
    FHMaH3elq9KceFqKjQMqfnzlPE42IqChBk3KCX6+xau62/T2KoqAazSn0tJXHWAN
    wVi0H30wRk7LyRvk+oe7YkdalvuQ8P+RW5QcN0dmskJRqkmsxharVnU5aQDn5juV
    j4x8p+/bfbhIvyaDObiyqa2TAOkCa78tbZM23zxHfdLiisqBK8NcBvJ8IDYznGre
    VeJ/yEIJtw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=H+aKUmXf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=H+aKUmXf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOMb3w2QGH5zfLQNr2r6ZhMyyXgJJ/DUKaFQu4E9I0p2eOzniBmLgUVy4Esp2HgZzFZBTKVAoTZwdLPeVCt5cxBG3g3WZN8Nt/XlnaUESLH0yE6EG7uz
    qNXDox9EUKEV44rNgicHCPxwNyn7HYYhvcncHKdu3N7L2T44yH703xUEDusE01RQeW1xq44rpT7qe0JGVJt9RESdtpUM2b6sjUWFf5hqORsjy6uPCdzeQvfb
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=dhh_qWxcV0sA:10 a=Tgzm40sRGssA:10 a=BHzdoRfpx9IA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=tpEzL2_AlxEA:10 a=v2geH_gf5vA7EyyFoBUA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeDEJnu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 05:43:50 -0400
Received: from mail-db5eur01on0130.outbound.protection.outlook.com ([104.47.2.130]:5632
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751097AbeDEJns (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 05:43:48 -0400
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
 <3c9b507c-c6bb-3e13-2a82-f3504626d016@virtuozzo.com>
 <20180404161818.GJ4043@hirez.programming.kicks-ass.net>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0092bc52-6536-4226-cdbf-8bdc97265c3f@virtuozzo.com>
Date: Thu, 5 Apr 2018 12:43:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404161818.GJ4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::16) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b737313d-9e4b-4c6a-56f7-08d59ad9b8fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:AwTlTDQ1CLkWibSIwQGWUWnh4ARydLznDUfg6UQInu6S4V3/kuc9l11SUqO3rAaAtCWpghP2NlouVRkAyTCEA4kd3HUYse9fwFlJQpZPQYyylBssomLR6f/oGEduZBVc/MRWDHZ0uNryYnzEhxQgRvmbN+19XO1lgR7lp48lykeuZ3w2oUmvhl4yqVgU6+B9NZJ12N1G54oyEH87CnbbzkPsVM2biCjnmGoM0/PcR3tP6HD4bkMLleE6Q3nb6zgX;25:R6jFAEMvwZxFEbIcDbCRlAf0haIf2S/UCkQ7mYyUBmt6pXtzbx3l3uvFlXEmMwE2keB8WRSy6x+2kkoT9EyUXFq/n0dslH+70u/iirx2U+6mxTa49eNva2xaU93+TkRQgzACSEmi/JVREW/5tAnaCrfNPYdLWjAeYYYAzEDp9ma/hFjMKmyiXv3sZ28vXKrh0oS0ax3WFR9m/8yIMOpWELgtUJwpZGRYb1rgEiHWvImiz/1n5npaPZkWZprTo+Qy60Rqr2H2R8T+cAqJVUzcnvf6hTGyp2/HBlqAVptf5CKwlV6gyC0BXagzUC5Ll8urjbFTMcU5+kDPHkKhT/gZrA==;31:tBkaKTe9vYArcDlf67O5IsRCZhvX0Se20TqzHdpwh1JXv/j2G9VN5+xceUJCcbVtCEUzilvsTm/lQiiQgNmNJRZb6+2rtMgnkB+WcXg52Hk0pLN1u91PqFDrGoINM26AhLhNdbZfB705P4vtgZLA1ZmUZNhoPMadx27xXyZnWDXOloa7Viw4sUUiQpw0tua8CJzgi7wK0KvT1yVQLiKK7gciN+9lclyGw54PX0Tn5lk=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:7jJo4WBGwcz2fuY0lFRwHesLwJC9i9+5fPBrZ3Jwm2jnMMFCWuk8aTATTfK1lUNm/h1K/a8Dxrm/tfGyuJ2HoZX2YBUegHVhDneeVc5s7EWCALSFgvCraHZ5USChYqbPMWzfP4Yb3A+1OLJZVILD20a1Vox4LN+07iOIpuo5p3aaAKWwdkdqwvlFULS0Zbq3iM8UCpH269mvy4NLOQYvpWs06TW/6NIWZHo2ZM0UeiX0sN2UZ6+frYwGDdXjBTOOqIqt2r2HU1gKieH+We+lEH+Tr+a8ApDjnHMPfgAC9DAQstkiy7iAwR3C+W+BuvVclYl7sAZNghEqOn9OSUA7PFT8LqXYO3NPmsUDvxD7HbL4HLyaG+JDWPzZ+Ry6DQZXBz5RC2NzFlcALJfr7xQ0Mpsr/h5GEn10Ora0wxKevIL+/fpGUmIqHbACQkQeNh+94jHikv76t1y+60HfzBgr6d2L9TcRQ0Ex20S/LkPx5RB83QuzD86tWCtBIk6fe6T7;4:VvgQLPP4FYU9azXndXgN/pcnUKHi/IcKdXVdKLA79U8/kZuXf9jrOsd2V7XDbPkfsF6GF8iQMJYJwM30DyUq4JYMP0Yw/qosLxIVk7VR1YJtzY4VcVGnIZJYam8PUzgx+rJTVyx5PT1n9FVfCMG4/EJtXcm4D+ErV/NxQ4R03mlloSYaJT4UlwB39aYLa9ftvWbV0H20JjjSUK0EBcvv7UV8ZZzYvTE52FAO/Yk4UArj4NQu3puJiZY7A8R+ezGuuGgHvwrxwbAlg1zT3JdgCw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13381A4F82A0B8BD065C4EAACDBB0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(39850400004)(396003)(366004)(376002)(346002)(199004)(189003)(2616005)(105586002)(230700001)(76176011)(478600001)(106356001)(77096007)(2486003)(52146003)(68736007)(52116002)(93886005)(229853002)(65956001)(66066001)(23676004)(54906003)(47776003)(65806001)(58126008)(316002)(31686004)(186003)(26005)(16576012)(6916009)(31696002)(16526019)(86362001)(6666003)(7736002)(50466002)(2906002)(305945005)(97736004)(81166006)(476003)(65826007)(39060400002)(6116002)(36756003)(4326008)(25786009)(59450400001)(5660300001)(8936002)(386003)(6246003)(8676002)(53936002)(55236004)(956004)(486006)(11346002)(53546011)(6486002)(3846002)(81156014)(64126003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6QnlwRDVodXdUSkFXZENQRkw4aktRck0r?=
 =?utf-8?B?Mnd6cGVOcFpqdFhwQ1M5VXdweExFcE1oa2loSTA1NGJIZGdsRW05Y1RVQml0?=
 =?utf-8?B?SmJadkFlMlVtM2F6RngyTkYxb25BZGFabDdYRER2aE5Pb1piM0RKa3d2aWxI?=
 =?utf-8?B?YnVCZDR0RExQUUpZN2NrY01IdnlJNEJGQ2pIa3ZudXR5VHhFVTU1WVdnWEU5?=
 =?utf-8?B?WWFoNmRMWTRXVHhrM2g3MHZDb09oUjBJb3YwaE5NK3Nma1lNckZiQkdtT2R0?=
 =?utf-8?B?UDFWVEJSaXFHa1M4M0E5S3lZQTFvZDIvZUlBMGl0YU5HRXU2eDBtQm9CRGVq?=
 =?utf-8?B?Mlg0UGw2cm5LcmFBeTR6L0laUVFIQVU3UUFvWUUyd2ViRi9ZdTV6d0lwKzlB?=
 =?utf-8?B?amlvR3ZoVzVaVWpBV21ZYTZQbzlGL1g1V21qUllJRzFaWHA2T2o2U2xXbVZw?=
 =?utf-8?B?TXM2cDhCL2hvMnFZaWFIOVdwenQrRFMwTU1ERXhMdEs5cnpxaGxEbGp3T21Q?=
 =?utf-8?B?OVFxVGorSkw0Nkg3NmlodW9rQlpFcUJTMjhxYUs0aDJkSlpneEkvMHZFZ0FC?=
 =?utf-8?B?MXV3WXNKSFZ1RDg5blFkRHNRR2RnbC9XSXNCUlJzVHAxczh2VlNvcng1dGtH?=
 =?utf-8?B?eG9WaGpBSGZscVNERUNuUTBqR0lpS0o1QjlMU0taM0o0RUtKWVVxNzhFUU84?=
 =?utf-8?B?NHlxSmhxZU5JU3hNKy9aaTl0bTdoRXdVK0RVYU1mbmNEaVkwQnNiczAzSVFn?=
 =?utf-8?B?NE5KS1BZV3NLVUZYYWJVUzlZYnordVRBMjl4bTJEYkhlV3BrODJUTUtsdWxN?=
 =?utf-8?B?QXVNTFJ2cWFvRXI3clBacjVPekdkN0RCNUplTmI0M0cvOUR2UitVRVFaRk1L?=
 =?utf-8?B?ZlhSamFURlMrQVFaZWNsSTdwb2pQODZQenRabWtWZnJCVHJ2dHZ2SEFLWUdn?=
 =?utf-8?B?bUUvNnJJR0ZTN0lSclRiclY3R1ZiaWpkeVBzSHo3UGJjV3RmSytJQUZzSGxY?=
 =?utf-8?B?OW1xTmNHb0ZlWWRFT3pEQTdRL01JRVlITUFndjZwTHp1SWpPMkpHTUpxZHNo?=
 =?utf-8?B?K1lvaDg3YXAzb1UvUW5LMWx2YTdZZGNTUDA5L0prLzJSVUJMNFZYREZlSU96?=
 =?utf-8?B?SmhqMHc3RmxINlVNS2g0SHp3dHltSW9RejB5ZWZRNHAzZXp2bUhLVFYySnVh?=
 =?utf-8?B?ZkY5bkl6UnBYVGFpNEZsUzNWb2hqQ2NDSkoya0NrSFRmcEF3MlBBMUNHUDAw?=
 =?utf-8?B?TFlYY1FXYVlCNGxNZG1reFNCbjlkRitQYUc0OUJVdVpOdk00ZlJKdHhoWU5x?=
 =?utf-8?B?dHJwb3FneVFsQWRmQnRYRjh1WmE2MjNtd01KK3UxSkpNRUtGc0hPRzFDa1hQ?=
 =?utf-8?B?cnhjUFVjOWJhbkxpa0p4eVRaTVl2K2xIR0FJZDlUM2IzY1c4WXpRRkc5UlBi?=
 =?utf-8?B?dTBWY0R1QlZNYlo1azBSY1BWdmIyN044WndvZG84TGUwbE1JNDRrV1NxMCtp?=
 =?utf-8?B?cy94UHEvRlgrcFpIZkVoVTRpbUtLQ2pscS9DMHdSWWJ4aS9xdksrNXlJK25x?=
 =?utf-8?B?TE16eUREc0N0UmVZdUE0dDBvRnZ5VE5lcm5hS0tvTFJlYlhUY24ycTdFWEhR?=
 =?utf-8?B?T1Y5eEVTejVERi9zQk92VUhXbzZCaE5ZMWNsLy8wSDFpMUlwUGxjNklxNFE0?=
 =?utf-8?B?dlIyWGFpdWh3ZU5BaUZzcFhYb1Q3RGFjZlJSaDhSUjhqSEQyaXlKdFVJTkw1?=
 =?utf-8?B?RGd0V2U3T0VHcGV6Qnc5d0pUZHphVXkxSm1LeWJ0MGI2UXdXdzBuTWFaQlpq?=
 =?utf-8?B?ZTlFeHVoYmsvaDFVZjFyU2hDUG1tSlM2K3p6VFVhK2x1cHhDeldZYnZUK1Za?=
 =?utf-8?B?cnhzUnNBeUd1YUdPTXZSWUx0M1plVGtZRXVybXNBRFhzeTNGQ0VManI0TytP?=
 =?utf-8?B?VFhtQ3IvMFNZeDlWcVlDMnVoQ0liMnJxaFFuWUgvUnFCenRIL1ZWQU52VkNQ?=
 =?utf-8?B?cE1BN2VWdTE4QlhpL1VMOFFLejNldDZWSDZwOTgzZ21sbTcvQ1gvVVRJWFB6?=
 =?utf-8?Q?VmEeo49YMpdPuLKvbmowa/UXFED?=
X-Microsoft-Antispam-Message-Info: WGqzl47bB65iY83Z7rQB6h8EyV3CEW0IJgIiqbFTzQQb/d7+IFr249CDHypx7oaAofacLx1SJfAhm/WOXvgyMs7L2q/HqBCsqGcPGEGNco+jeoHgPIFhFIB0pV04XNkO8rvnPDJYZ5h+y+OFoqzqmAxnN/YIAjRq9Ww7apgAv5EqgdOneOBpNUCLk1bFvNbD
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:ufvq1nNfZIUOmweUykq7Oi+9lOXXoWaD1wQYwBki6dSZAqSVugDyOXIYFXs43CyolygzdzjJbAXWziyRks88kuxtdNCw7ycSuk7UmhkzGD0TQbgyidub31rYVedUhKxo5d8tsmsBJsdFA9cw4R5z/b/Dh5ggN1LN5dEmYlNN8N7DLmgwlfjujbRMxYJ1bIxMUOQZiFJz0+ho4+f66NLRwFji67j1IuIrzelqJHYligP0/722RfjbftlV38y+PyBlyLPMBh0dJK94rAXJ5b8WrQBn+6Bys1P3+7uh/tzIBIBqwKZMxrBIemZFeC/DvR2uKqL/kRFFl9eMBm3ZjYDjUMLPiobjPBsJwAian8x4H4xj4+nSLExV2i6jk46L1oRYkMtO3AKW/U2svl9x8xNYsyBLPWZjfoGvQYf/NDSCGJHpR9DCXjWgDkR0q1e+UCEQAeYcsCIEHOOIItU23DWAdw==;5:ZBOB4OQRu4hW1wn5/RDPKQmxN6zvfGeIVC2yEB6pZH3PRxQjUppxtCH/0m/1iEIqR6mb8AtPAde9KzT0vY8E2z9PUCtSx+qQkhGG/6V2xsVYPe7ad5DlN2CKEI4BWUmLZWKVtb3VzaJtOYMKyl5nIz2h4d+DgBMuFXt8QHm3Hag=;24:FsnAzzZsaQShdwv3SKRLe0Wu+gDhjsiCP52FIoUjsRvaWiIgBuIPXXICYcdopa49477zRrgh5Tvblkde0i9mBdGsUFIDXpJdNi4ZlGXKTN4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:u6kIVZv+3L89g0jmjQ+aoO8qCcWQQYfILchgLhekb4weHXdemj9JJAfE6x5RLQPsvRUM6zbGSyXcJJyB+3DoR5mHBu8vWoRDUQ+DUk7c1isf5mn1pFD409VwdTwcExOau6tqHsB/Q2I3NlWrgZanaJt7YY7FRhY1wFZ2jNByfOfU0LTZNQqwirPE+Ol+4bzvX/06vUkVrGqO3Dzfi3zPdOroR9sbhqLUWP4jvnFUmGo0U85WnQlWJW3QK67vW1VM;20:1SNtO0Muzh/IFg4QNRw98hkYUZb3lS1xi0CJrJ4cKN9uBJfErB49r680YjNZnF7en4PGtNY4gyqXJ6Ne54i8BjTFM0oUqFdwlRqc4oA8VxdgByT5agvf8yQuDQYazzBwG970klYf7iFlOMQmyybN/KiHwQwvgvY1pzGgEU1KR0k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 09:43:44.2549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b737313d-9e4b-4c6a-56f7-08d59ad9b8fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04.04.2018 19:18, Peter Zijlstra wrote:
> On Wed, Apr 04, 2018 at 06:51:08PM +0300, Kirill Tkhai wrote:
>> On 04.04.2018 18:35, Peter Zijlstra wrote:
>>> On Wed, Apr 04, 2018 at 06:24:39PM +0300, Kirill Tkhai wrote:
>>>> The following situation leads to deadlock:
>>>>
>>>> [task 1]                          [task 2]                         [task 3]
>>>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>>>   send_sigio()                    <IRQ>                             ...
>>>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>>>
>>>> Task 1 can't acquire read locked tasklist_lock, since there is
>>>> already task 3 expressed its wish to take the lock exclusive.
>>>> Task 2 holds the read locked lock, but it can't take the spin lock.
>>>>
>>>> The patch makes queued_read_lock_slowpath() to give task 1 the same
>>>> priority as it was an interrupt handler, and to take the lock
>>>
>>> That re-introduces starvation scenarios. And the above looks like a
>>> proper deadlock that should be sorted by fixing the locking order.
>>
>> We can move tasklist_lock out of send_sigio(), but I'm not sure
>> it's possible for read_lock(&fown->lock).
> 
> So the scenario is:
> 
> CPU0			CPU1				CPU2
> 
> spin_lock_irqsave(&fa->fa_lock);
> 			read_lock(&tasklist_lock)
> 							write_lock_irq(&tasklist_lock)
> read_lock(&tasklist_lock)
> 			<IRQ>
> 			  spin_lock_irqsave(&fa->fa_lock);
> 
> 
> Right? (where the row now signifies time)
> 
> That doesn't seem to include fown->lock, you're saying it has an
> identical issue?

There is also read_lock(), which can be taken from interrupt:

CPU0                                          CPU1                                     CPU2

f_getown()                                    kill_fasync()                               
  read_lock(&f_own->lock)                      spin_lock_irqsave(&fa->fa_lock, flags)    
  <IRQ>                                        send_sigio()                            write_lock_irq(&f_own->lock);
    kill_fasync()                                 read_lock(&fown->lock)
      spin_lock_irqsave(&fa->fa_lock, flags)

To prevent deadlock, this requires all &f_own->lock be taken via read_lock_irqsave().

This may be formalized as lockdep rule: if spinlock nests into read_lock(), and they
both can be called from interrupt, the rest of read_lock() always must disable interrupts.

>> Is there another solution? Is there reliable way to iterate do_each_pid_task()
>> with rcu_read_lock()?
> 
> Depends on what you call reliable :-), Yes you can use
> do_each_pid_task() with RCU, but as always you're prone to see tasks
> that are dead and miss tasks that just came in.
>
> If that is sufficient for the signal muck, dunno :/ Typically signals
> use sighand lock, not tasklist_lock.

The first thing is not a problem, while missing a newly moved task is not suitable.
So, it seems it's not reliable...

Kirill
