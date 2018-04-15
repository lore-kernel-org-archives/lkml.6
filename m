Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523804515-2-16252294467877949695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523804514; b=jHFFuMQkXOVliCxELlzyCPkYubG/IwMgRDvOHJHsmJMrriZm7e
    4PBlbTpYSbv15Ts0qzF85KvihxemsSPbH2oem75YnYSxEDO48Yk2rtI7gwm/T1QP
    p06e8X/E/TIdlwQU+j+LtUUumOoyyVSpFCq0XM4E6bi+5blRPYK87DPe9ntQ44RA
    vn+Adv1uo/iNoZZRunEuOeWdsC0FKw+w5YxQ01lAghMn38S3ovCvVHOGe1UBcbpb
    nawDB8WcOFGjQddho4iNhBzofYk4ZT7WUSK34vuL8/wV3+NzC0fEPRk1aN5K4eNi
    8G1gNA3EdqOwYQZsHRkr/lDSgcnpEgeS2QzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523804514; bh=Vx3xrZZIpEOLGlwWTn1kqbv1PCdxz0fyvOXPzdkC8CY=; b=
    Irv47ep8arHvyh61cqsq62L8FpWU+scO2Isi7H9y9ChZFW0Q+Dv8OCzvxM3wpsEw
    wpKOH6QIh58xOz8c7lgpehJDltOK+VjOycRFy/OSEsI4N8Aial19e0NKCPJuMcKD
    x9nUpFu13wZ37bhWMXyFOlGTQZDnq1H1jZdOxCsAEj6jFwJAYOCpS4xiFb/em0CK
    ZILrryMLd3B8WeePxkvF0g+xAs8MklVCyFConBTV/wvpR3MruWAN2zq9qAG3OmyX
    cN/thLeuWD5h/ijx1SK9fxQgJhdOU7+4YBpdP8cCZ2n9ttd9G+Td3L/kkjAAX50L
    aRpjN3G5fH1SUkayEzdWsw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SwkWe7LT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SwkWe7LT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGsqxtiGUXFZdW9qNTXyvhLY7wNU+6+gR/kobaOKmIIjVNP48FYo+vU7tTrP5K/3VrlTIkY5GQk85jIrfK6Lsy2GDMAUi0C3c3GtLXxY454xF30xKUP/
    QlQ/WfLFAhs8f016Xj8ydMFpyYjLDmbhRme5f4gMXVvzwhBeN1J5ro2VlF1zrlLg0Q1wxJo75lhG2EsDnm4vonBfOoVukokryVbyQ4vCDJKJo8bV/FOr/Ooy
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8
    a=3YK-YeDDL78iWeVMEC4A:9 a=CjuIK1q_8ugA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDOPBv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 11:01:51 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:45280
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752557AbeDOPBs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 11:01:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Chenbo Feng <fengc@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH AUTOSEL for 4.4 065/162] tcp: Add a tcp_filter hook before
 handle ack packet
Thread-Topic: [PATCH AUTOSEL for 4.4 065/162] tcp: Add a tcp_filter hook
 before handle ack packet
Thread-Index: AQHTz5muPOAMHA8h+kOm3imPN1eGhKP4ufsAgAk8I4A=
Date: Sun, 15 Apr 2018 15:01:43 +0000
Message-ID: <20180415150141.GS2341@sasha-vm>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
 <20180409002738.163941-65-alexander.levin@microsoft.com>
 <CAMOXUJkEomBfpBLbfaZTG9SyGGAvtG_zoA3CfMtxW4BUOSX6sg@mail.gmail.com>
In-Reply-To: <CAMOXUJkEomBfpBLbfaZTG9SyGGAvtG_zoA3CfMtxW4BUOSX6sg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:7kooey025m70dgy8lsLyb8KJ4Tg+Y3ODADZtR/IH9dz8+aMRlnqTUnjJcx5tPNelHsKfxqN2seInjp6QsI6bDycfFfl+11J7VZfeltylrIXhZD+AWVy7crkzKqQtmuxmfLcYdcfR5VkEDM4esWhckZYvdQKN0hhaVu5orQ19qv/Osty5uFrhNhbdQL9/SBbRmSONZCWBOgFrA5TGpu6CrM2gkJSSDO4LUIYq1xOcOFyeNkgF8XFsY1rTiTriZVQ4;20:fdm66Hw73yTcfOo0BtP8tY8U5E+Wg+RcgwIYxk3zcNZcYfNoJa010pp9pa+tIPHUPuq1J84ynAIkSS5azv0n7X9XFKBUzTgVhnBouomx9FJ8kJRV+XKGXu05Y3QMXeiRJknzHNpxT1pkIWom8hk38CdI6FpLPmHBZRTrmqvl1O0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10150212C31AB66377FF3D57FBB10@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501347)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(376002)(39860400002)(346002)(39380400002)(199004)(189003)(76176011)(59450400001)(10290500003)(446003)(25786009)(8936002)(6486002)(33896004)(575784001)(26005)(305945005)(86362001)(3280700002)(3660700001)(186003)(478600001)(14454004)(72206003)(2906002)(5660300001)(6246003)(99286004)(33656002)(54906003)(102836004)(53936002)(7736002)(2900100001)(6506007)(105586002)(229853002)(10090500001)(1076002)(9686003)(6512007)(3846002)(6116002)(81166006)(81156014)(22452003)(4326008)(5250100002)(476003)(8676002)(6436002)(6916009)(86612001)(68736007)(97736004)(33716001)(66066001)(6666003)(11346002)(106356001)(316002)(486006)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: HycyPSudbgSsSV248reFiAhvjUxyHNm0p9ai/4h1c4T2dm/FeoFdPSpjj5Ig5Iq6karRCY+P6gKeK6iOshtg/DI5//BunYzd0HlnO/kYfELTXcRJ3gwpsNhlg3OVeI7uq3dZ3UO0UvvcDZ3ebTF5dAojLnXOrb6nXE9ikDGKtSby4klv73QE+Ce07qAjUdkN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45A1F765E1F7C3449053F95647BCE45B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 07e9e247-5644-4dbd-f08f-08d5a2e1ced3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e9e247-5644-4dbd-f08f-08d5a2e1ced3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 15:01:43.1056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 11:00:06AM -0700, Chenbo Feng wrote:
>On Sun, Apr 8, 2018 at 5:28 PM, Sasha Levin
><Alexander.Levin@microsoft.com> wrote:
>> From: Chenbo Feng <fengc@google.com>
>>
>> [ Upstream commit 8fac365f63c866a00015fa13932d8ffc584518b8 ]
>>
>> Currently in both ipv4 and ipv6 code path, the ack packet received when
>> sk at TCP_NEW_SYN_RECV state is not filtered by socket filter or cgroup
>> filter since it is handled from tcp_child_process and never reaches the
>> tcp_filter inside tcp_v4_rcv or tcp_v6_rcv. Adding a tcp_filter hooks
>> here can make sure all the ingress tcp packet can be correctly filtered.
>>
>> Signed-off-by: Chenbo Feng <fengc@google.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  net/ipv4/tcp_ipv4.c | 2 ++
>>  net/ipv6/tcp_ipv6.c | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 61c93a93f228..2eb9a1747f25 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -1639,6 +1639,8 @@ process:
>>                 }
>>                 if (nsk =3D=3D sk) {
>>                         reqsk_put(req);
>> +               } else if (tcp_filter(sk, skb)) {
>> +                       goto discard_and_relse;
>>                 } else if (tcp_child_process(sk, nsk, skb)) {
>>                         tcp_v4_send_reset(nsk, skb);
>>                         goto discard_and_relse;
>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>> index 74cbcc4b399c..7d7f0999a919 100644
>> --- a/net/ipv6/tcp_ipv6.c
>> +++ b/net/ipv6/tcp_ipv6.c
>> @@ -1428,6 +1428,8 @@ process:
>>                 if (nsk =3D=3D sk) {
>>                         reqsk_put(req);
>>                         tcp_v6_restore_cb(skb);
>> +               } else if (tcp_filter(sk, skb)) {
>> +                       goto discard_and_relse;
>>                 } else if (tcp_child_process(sk, nsk, skb)) {
>>                         tcp_v6_send_reset(nsk, skb);
>>                         goto discard_and_relse;
>> --
>> 2.15.1
>There is a bug fix for this patch upstream:
>"d624d276d1ddacbcb12ad96832ce0c7b82cd25db tcp: fix possible deadlock
>in TCP stack vs BPF filter", Please make you include that as well if
>you want to add this patch to stable.

That commit had quite a few conflicts, so I dropped this commit instead.
Thanks!=
