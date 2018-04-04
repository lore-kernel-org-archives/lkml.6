Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375845-1522855491-2-5726430639996802213
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
    1522855491; b=ENW3RXy6zEfUtOVkFopxNOqUDQCon30pv08K+ltYEKGeNTxbcN
    p6rCJ9IQMmLrM3Kn3YKlTSC7to1ZH56tE3Qz/cD6amPXslSEds2Lo9hIU+26C2WI
    StuokRibkmI4hRxVwCqHBwR0BC6EHTejCzAdOypGJdyExLEVlO5CivHrJCh4V0pn
    W783wGlCh7xQ70XaNHnXZ7VPo8bkMApoKb6SIWrghKv9/bMxSgbhYzmnC1Z2Txdx
    NAfedTtcLCxmVgpnhK6hfcpfifO99lc++wobm3uyXpg0dFMNiA6i/clW90z7uGpa
    zjHjwO55INswrK04p4wofSmEfr8P7OwXEtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1522855491; bh=0GQufnu/fjf+ZzeyYaz6ob0x4upxmR
    cdOSYQwCTtvVk=; b=Kk+AufprfCuNvyx55ueWqpZ+X1cxozzeUzpZqDSiqltsfZ
    Q23y2If542MJ+d6+k3u+LoU+8Jqz2VpCQHF/pmyj1Gk0Eny0iO57GLgWKVsgSmXN
    GX38Zbz6fPFWmvlKyK4e0Pu7D+HLACaLpc5u/mnSQysEDKZHPrFdSTF22meQhb8U
    swO6WeKWpyJjrWCvTSqRx6CumdJbNkvr4ZiqHGkkpN02cx2XAONxM5i7EWqEQKZt
    TlWgoG41bGCIyADVmoXH4QW7peUYHIPVGK8XXh+CU9js61VaV34Cw7TDvz38zSq7
    hhCO0/msW1odDn8LYwAuu8BI1cFfTVh4PF+5DWMw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=FqcWsZZ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=FqcWsZZ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK0fZCge5YQpuPmejxqZgEzQfHSEVle6nXMaBmuAohZ+KmCgMVNn+fmJlmee9+XDk+MU0o1qfcpxtBgljMsZJTJmqzSfwFcuV0dOIL0VN8lLRTTmhur9
    BqcqjnZPPva2GCACxfsH5AQv0PkMH7KViY0PAlHTSkuUCvLcOmkwqXbjdI/fBVxDfakq6etD+FKWb/xiKuORUdntNfyrcBf86dbYm1Kf8AqDnIwCousPcNqj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=dhh_qWxcV0sA:10 a=Tgzm40sRGssA:10 a=pxDe5PvTImUA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=tpEzL2_AlxEA:10 a=TYBLyS7eAAAA:8 a=uDvbYv-ym2vhfA1G2MsA:9
    a=QEXdDO2ut3YA:10 a=zvYvwCWiE4KgVXXeO06c:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeDDPYr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:24:47 -0400
Received: from mail-he1eur01on0116.outbound.protection.outlook.com ([104.47.0.116]:12641
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751645AbeDDPYq (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 11:24:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH] locking/qrwlock: Give priority to readers with irqs
 disabled to prevent deadlock
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: peterz@infradead.org, mingo@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date: Wed, 04 Apr 2018 18:24:39 +0300
Message-ID: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:7:28::28) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71cde2be-0462-4982-7063-08d59a4030d6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:y/PMf8h1D93lL3bTNYCJLkdo6tZCYywYL1hVP5GUFoe7qRJ40kRATniw4vPoxXCRSRAOX965orNfiogeQDb4NQVVQvS+WBD5JiTFx9bmBasx1CLVpcKj1cbjk9VyYKmibXcjvBUzRz91/noHe+aFrXtCADnwvONqTJdlCvoOSqJ0HOtVD1HblD61NfUXBxvtHEm8yURWhxmB2UC0TZD+LK8tVM4BfpsWvvptUSHVOQcoXtxQpIwjQ/wZQlLfUBoc;25:GLn6fTRUlVzNxYPu0dRQ3n99PYIS/ryNPsKCbVKe87de+QOvn+pPaBQApbXUIJJs7x4lC6bzjBO7lrG5lfRpccPDO6gtcZ+z4nkzX2lgmPLyna5qN85RCxYdf92re+wwsCucjZho3kSDJO5tIZit17/dI7KWDs2Lz9hqNOryR+y5NlbLbQG9F6xs9+Ch3USyFzGo5MpzhBskDoICZrngYFH1PJ61AcykF6iMRn1Q38IJpO+tF/u1+qlFehemdSQcgn7vGAxuJjyKw2C6ZY9xVlMHAVM+rVzdktMKBd+gpuXKNC0Yzrzpz2M3C4dLG8q6cxPY7wUSIx4WFCBqbDLQTw==;31:CtPTUCzj0TrkGqSrSGEu8FcmlpIkmteYJPPsqs/u1C5Ytl4nb4c54uLnhDYcJBC0Df3tvZYvVgURWSrHpWG+/Lg60kUKtpvAXZyt2f++Gx9u06Lc4VZuLha4u8XfFbRP4+PYmJPUJCV3uDDPte87Ej8Dxg5J9cb5zFluQrh58Nye8u0OAoCAtzW9wBX7ev3CKWLSqc+rWKbze8diNe72mrkvNJ+7BhTtDUbZDBDTbqE=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:Y6vm+7KssQl6pyerOVhrP9Zl4h7dzgB6oI8rjD0K5cdrlK9Jh+dvoNm3BnG0j7LbNeVL7b1NxJpk5F+LXE3VHqRT9tq9BYrEQF0il9z0q6QwQE54h1bFNwTlQ7AlTpoA+oMhYT/D24dbbApoKys8esCtlnBD6X4k9mNxiNexyFMB4EcEgm2VeUZrcvWGHtqOXnlqDAbufIyV6Bpz4xAqVT+zQC0/04yZJNJoRdADrPPkMSerrJx9LByiyALs1AZeUNQVKlJUyfCRUNj+ubPXjc8kdWgyESongM8BTlhxTEcCHC6aOqkYk183BEGmlS7TNSPXrjcgM9exrUXJe1xUrDvoPWKbdcY0DfZpDZA/7AuMP01dR87vzmC0Stw66oucOpG8z7m6ktRK4Ipdh0OVdX0oKCQyrdHcoEr+ax5SMKzbkW/Ia9etLqrT0YhhO0QcXjlTSsR7J0Wokf/wn1pXRyMrq4JUTz/mcu9c4eKK/oHjtqUvD1vGW6+2FKsH3uQf;4:JbkHPZnhrr4qp1taIYNBcAUwWqv+AFciwuJ0UDG26vXF87mGtxvaBa3mnIx/uvAKv75YMWl3y18+9rGAPgBFSwQisuFbGHSV7z7Wh1mf66Ejdsg3W8hhXQF15Dsthbl2NPqImG/1FpMSnkTfYS+1gg1clSugc2QFEA55zAC4uJgdzBZVhkF0eVq7uoKkBmjN3nGYMfnTalNzeT4+dv0EOpW6jfp7vMVxmRs1tYFhyb22YZLxMLcrQC6/i1efSopfWM5XkkKaZdcU+2YVRhgSqw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13310BCEA86618F8BF706A8DCDA40@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(346002)(396003)(366004)(39380400002)(376002)(199004)(189003)(8676002)(81156014)(478600001)(230700001)(103116003)(7696005)(47776003)(9686003)(86362001)(8936002)(3846002)(956004)(316002)(55236004)(50466002)(58126008)(97736004)(486006)(476003)(81166006)(2906002)(106356001)(6116002)(7736002)(61506002)(16526019)(26005)(25786009)(105586002)(68736007)(1857600001)(305945005)(186003)(386003)(2486003)(66066001)(23676004)(5660300001)(52116002)(6506007)(33896004)(55016002)(6666003)(59450400001)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6SDZUNUFZRm10czh5VjNqZmhWc056WFJX?=
 =?utf-8?B?YW9INmxyQVRPTjZBb1UzMzRJN0o1TVNFUzk4MjdtWU1xSWNWVEQrZkJzZ0xp?=
 =?utf-8?B?UUNKOVFmZm83cTRhK2FVaG8vblBGWWQ3dWdaSVpxaTJTZ3BjTHNLYjdROUc5?=
 =?utf-8?B?STNhZE5DOURKQm01NHNzTlFpY0crZ0x0S2MvRi9WUWMrS3kwYjhwMzZNTGtP?=
 =?utf-8?B?Z1I0K3BpTXI5RHhhY2c2YThNeXEwM0ZQK0dNWlpZS3B6dFU3eVBaOU9JZkJh?=
 =?utf-8?B?Z0lHWWdLK3NjM1VWaGRjWGVpTHJ6NUlkcC9naG93K01sNnNYQ2tLalBnaHNz?=
 =?utf-8?B?WHYzWjBJcjhPbnlsSkNsRmlqeWNkS0FaY1J1b2JnNndmQVhRMUxwRW15VEtr?=
 =?utf-8?B?eGVQVG5JaEZwaUVnS3ZMVURYVmxlQ3Bpak0xT0loRzdVMlpWTzdqR0JhWnJX?=
 =?utf-8?B?NVJ6NDBBTHFvUWRPMVkxcW94Vkx0c3pYdldveFJOMzFyTVRlNGJuMmY5b1Zp?=
 =?utf-8?B?Y1M2VlhmL1RBZXlmaWFlRC8zRGFUd3A1aTZ2eXNsU2REeHNsRXI0amRUUnYz?=
 =?utf-8?B?NnZsQVRoY3dDUmhsWVRXK0lxSWRvaDdTZzNrZkZsSy8vUkpmNjVXaEE4SmJU?=
 =?utf-8?B?VHVwMUM5VjF5QVBzT1R4NHluOUd6cURJMS8zWFRsb1JKcFh0NUhQbUJlc1dX?=
 =?utf-8?B?amNMT2drZ1RZNzF5cjR2QzZsVlMvRGUrbTVGTnk5RGNHM00xYzRSUGY1M2xt?=
 =?utf-8?B?TFNURmZnaU5Id25ueDAxbjgzZnYzTE5vNTFnZ0d0emdQQUx4YTc0R3A5UU1h?=
 =?utf-8?B?T1lDMkkwU3JtYndQWWlzRWQ0ZkNuSjM2alZ6TXNkcmduYXVObFhCNnBYejZF?=
 =?utf-8?B?TjNPaGo1bjNCSEd5OHVDTmFYb3Q3WkJaZlZoTm9RekJEb3I2a0kzWnRHWlNq?=
 =?utf-8?B?M0haWEVyOFM0M2U4Wk9kRFNPOFllSVNIc0ZpMy9reDlxenM0TlNiaVpWaldy?=
 =?utf-8?B?ekxPMDREQzVSYkpIK2cvaTFobVpBdXRRclRLZXVoSCtjZnJQR0dOL2YvS1RO?=
 =?utf-8?B?eG5sRkFZZlRVSXZ2R3R6SUJ6OW9Cb1pLWjlYZWp4SDQ5TjBGbDBhT1ZzK2Zl?=
 =?utf-8?B?M1dldUt3TEdDemh2Ky9sbjNaNUd6b3pZOVh2aHVNaWxxT25KZXA2NUJkUFAy?=
 =?utf-8?B?U3NocFFtL1kxTHhodnh5VTduWExlU0FGYmVzdlF2TE8zU0ExR2FORDNXSlpa?=
 =?utf-8?B?V0JBeG9vdndpQ2lwUHVyWTZuYnhvSWs3QVhYYTNwMWxHRks2Z2l4S1BESjVF?=
 =?utf-8?B?amNMdHowQ0JrRVVicHcvNEFPN25zQ0hiZXhpZkt5N2R2SW42c01hdGdXcW80?=
 =?utf-8?B?U0Rzd3Y0a1NMRDdTL1JMOHFHcTZsZmpmVTFncnV5cUgwOXc2dnVsVmIyWWhM?=
 =?utf-8?B?MUxGWTUyQmxNbDdOcnFPQms0VUJZcVIwZit6L0Q3THhzRGVWOHpiajBOWDdq?=
 =?utf-8?B?TmxSQlM2VE5HNGN3V0t4OWNJZkhWN3ZKdW5UUllpd0R5blByQ1pmc1JRVDdB?=
 =?utf-8?B?QW5PNklWdUVFaXZHS1AxOUZoaWlpU2h6ZnVwTWYydHhXdXVHTW9BUFliWXNW?=
 =?utf-8?B?MkdjQUI5Q3BkZHdNelhvOEVhQ3R3aytoQlRneWk4Qk56bFJWcXEvYUFmZEE9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: OkNVcKYPXBd8XInEyN7kABKkPqR3WcGuFPcfk5tWKzQpiAG29ZmPD1y9QtDZ4M0PShuzY4A/u9FytoFVBmAhKZ6NqvjQ5Kl1euQkm7O+hRoGgxA73Abj9+ET7eELOxvzwB3aTxfj/i0xhV5D2JDQIbW2esfJhDmRad1gNvCOlGXNgYi/q7pw+6CZeannRTWY
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:99HbsAAtTQkOLlQE+JMnid4Sc8FsAD+ssPnZt9k9YvzN82yCwyEJxtxhfT3RRM4VWJd8UfmYEKEF+vzri4unIi8KgwkriXksxPN5lVWI2wk8lz5S/LPTJSF64HlPY1fIlnrQ9PQDpfVtAv06HNRcE1D9FS7aMmhz1/GWQa8gwxQkJrwQqTxWcVL081eXbnZS6xRhP61v0z06bF39MoJa5YO4KN63LOeAPIbBJLlWxBAqbtGJB7t8vndFvboZiG2DQdVELXLwp1rwZDVDZjFbLCaiZPOlJM1bE/0u6bRnHLLf3JfudndmlMnGgnwpcLcVHeRzefLMfNeRh8Q98iQ3Rv/Th8Mj4pkKiyczm4qwLZrhaybs7W7f8JxCpJUCdEe4OfP3FtqJksoixpVqHSg91QGo1XXWrGSCM98WraU+ACprWoI7j+Lnz7wdlFKDlyofF+6Wk0YKUrIgOHf/8row1Q==;5:vEhYtmZ69+PvwtNE1Ay3E5lwFYhxQnHv5gUvqNhpiJFAT07CdHJE/3VQeQYT/QEFkpCnnua0CGfQBFYoS6z3mnZSbkeexbG4xDxjEPKDclAkDvizWF37X6VhziHmNR3u0CHS0uS+3oeOAaKRUGfbBodk4XV35dr9cCry0Ok5Kys=;24:qIstCMWib540lLO7iFzq02dSTAJnPLnIpbluUsfyPoLUar/xihiM8MLeS8hxaQtIZnUY9cwxb6sa9yqV4z3hSfDn3QEnESwfcfflyNEgkjw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:IERgHrZrX6wvMqp9ioFXAAlkMtGy7F+KHkVKbzyCZ6WjyBLKARg4CZm1rnn1p/D3A1zF291S0/HWoTaz1Eg8269cjtkLox9tqi2VXgZEQM7f+OV30YnZYOVEpAhg8bJfogPj+vLA6ElKIYXeMMIhhjJbC53Sx/hur9+Ou0EfA2jtnEXvZwydNVdEVwLXjDVDntz7ko6k4meIeuvKExnoJqI5UDgt8TWQ6jYjNUymK9bcLgfh5cyvrVSOMl6Ufjk6;20:oRbaDG4Nw+A/AFp78zeBH69mAWY6UqJdFuCCASSRhdMfuMIOMDJ0oceicVO2UYd/TrCu9YKkdEcrT8F5PhnQt8qdDH3xDSnvC4T2rqiXTtt9QELmftNaiBgFbL2N6egVOCA3TDq1v9ZIZgSuTN/sANWpWTz/mSSZpQen79GqbAc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 15:24:42.6574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cde2be-0462-4982-7063-08d59a4030d6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following situation leads to deadlock:

[task 1]                          [task 2]                         [task 3]
kill_fasync()                     mm_update_next_owner()           copy_process()
 spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
  send_sigio()                    <IRQ>                             ...
   read_lock(&fown->lock)         kill_fasync()                     ...
    read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...

Task 1 can't acquire read locked tasklist_lock, since there is
already task 3 expressed its wish to take the lock exclusive.
Task 2 holds the read locked lock, but it can't take the spin lock.

The patch makes queued_read_lock_slowpath() to give task 1 the same
priority as it was an interrupt handler, and to take the lock
dispite of task 3 is waiting it, and this prevents the deadlock.
It seems there is no better way to detect such the situations,
also in general it's not good to wait so long for readers with
interrupts disabled, since read_lock may nest with another locks
and delay the system.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/locking/qrwlock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index c7471c3fb798..d15df85de8f5 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -32,7 +32,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 	/*
 	 * Readers come here when they cannot get the lock without waiting
 	 */
-	if (unlikely(in_interrupt())) {
+	if (unlikely(irqs_disabled())) {
 		/*
 		 * Readers in interrupt context will get the lock immediately
 		 * if the writer is just waiting (not holding the lock yet),
