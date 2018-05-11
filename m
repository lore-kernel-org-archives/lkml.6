Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366326-1526018250-2-16328499304591856523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: cc='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526018249; b=Hw6WkcKVUZD61zpJHka7D/swXKGfJMMHE3Xuu0ZRtIEMoq9qOT
    JS4j8nJidz/Xt57hW027xBaXz6PEQ4iQz8CIpc0VwlnCZhjOBsPD8J2jMhsDRm4q
    2oztQDv2Gwi0EFm3Fs07lYBGXyQS+Wg3QVSIpP4MbkWl/3n4UMmQjCM6aVCNrQIC
    5PvMrFxnd4aMqEYQupQCsR1FHJpvd/KGJBUQf0uDmgrOWf6KUcGbDQqBpB+hXFdR
    OQX/7s1i9Q/vAC0zKalvmgmivG8CsT8RcVpwnIdU4ZTkcieAanbS0uBQh2ruhEvN
    FviffvrILwMMv8hknpIgdybNydqGcs3CxQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526018249; bh=+aAUyLsLQPGzE2RdzDcUn48mpcpsfL
    QqrsCtPuAyIAw=; b=MZnI3gO4KvCc4QoYtRiO9KFHKMfuntF6Zb4BXLW2+8zBtT
    niYl0NbQVFbeBv8YQPkolm04l7J30m0r6KCoIV2CMck/6Y6rqdIrQ79ZoK+c6CGL
    Jh/5dV1WDpkBSR9COrZl6f9P6nVnWDSXLdmg7WOy3qs6UbxweOvgH6T1ZfM1WPVA
    W0IzbKoVnZi+1mJPsbG+y4virhayV4UM5nr0LRTLKP+Hy2wlhfWKH/DiDv8H/puQ
    D5UpsX5U6V18n38tOZFjmYs/3l4d10RhCUwmWRaD9R+PKBH9urJq9wTtEZrDueSx
    pQmCg2AsjI7OE0szhegxlLcmdNU9efssCrry4Qnw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com
    header.i=@virtuozzo.com header.b=da3shqto x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=virtuozzo.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com
      header.i=@virtuozzo.com header.b=da3shqto x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=virtuozzo.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHQ3vLwppMizT3wKTSVUty2yILAOogrmJLKXgUDGIDgy1yk8/9REuvwpwAWVJk0UnyfQ4WdA1AQc6XkV7cNwYKlihL8yocSfVoh7yWtYaB0sQtb9jXX
    rf2xBXUpHrOU2ceIQRi0a1GpEbyavxedZK6QGM8DAfniwCQItrAuasZ4H6QvwVqsY17b+x1El7jRV5htYNo/AGKmG/jmij0/AzdrSbtJrIGyVyICqgRwbONH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=bS8SK7wl-9sA:10 a=i2TOPrtFYBEA:10 a=NG3IxQmJIM0A:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=tpEzL2_AlxEA:10 a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8
    a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8 a=UyJFq-IYlfc0etDp9AAA:9 a=CjuIK1q_8ugA:10
    a=cQPPKAXgyycSBL8etih5:22 a=zvYvwCWiE4KgVXXeO06c:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeEKF5Q (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 01:57:16 -0400
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com ([104.47.1.97]:9612
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750751AbeEKF5O (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 01:57:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Fri, 11 May 2018 08:57:04 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        syzbot <syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Cathy Avery <cavery@redhat.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-ID: <20180511055704.GB12563@rkaganip.lan>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        syzbot <syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Cathy Avery <cavery@redhat.com>, stable <stable@vger.kernel.org>
References: <20180510191634.18796-1-rkagan@virtuozzo.com>
 <52bd5b0b-a4bb-5426-3c92-edd7085faea3@redhat.com>
 <CACT4Y+bZaW6NN-RdVd+EL1pXQs42Nb-dWUn733=eEORT_3NjUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bZaW6NN-RdVd+EL1pXQs42Nb-dWUn733=eEORT_3NjUA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [2a02:2168:e1c:be00::cb2]
X-ClientProxiedBy: AM6PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:209::26) To VI1PR0801MB1981.eurprd08.prod.outlook.com
 (2603:10a6:800:8a::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1981;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;3:jgjE/bNgTjqNlXbRNa7vaJs8AvSX+jLosHl44Zj4lHJTW/6JongLSSvBH2mbor9+2GU+bHBPa1CvzQ1DZMs5eFf27kjIRqFvrKDGFUps6y3ODyya7Qng1bv7qjoFxiygUGMUMCfwW8/cwRkmOZWjI5/4hmxoa9OE6SkllBYiEJZUAyFFc0LyAkXnqCc84OR+P/IWMXFLzbdmkYRSDX1Kl9DlSnImYR/ovcp1D2zC39RH0iZlZhpzVVJCYJgdr7sQ;25:smjkO+lHs73rw+lHNcTazc5CJ2pq6e3idn2XOTzfuybLEAoxNLEpxomgaAcScm96m1ZL3Wp0UNOn+Bws2+aIdwwTpTcqwx9gtpYCUu6EW74TbeMdinsu/I8LbFOnjaoWhoftlJIvY9TUBxjRBJN9XtvWuSHWdgS+gw4lB38sj7Z8MUmmhswBXp/2zZN6AVuqnUft3vtGTE0DTFdSHEX1b8JKcFdc8sASFGlWBOVj2CyKnRCCqZhn2hnx7gdoto9/iD105M5EyzVq56v9lkgCubuk6D3l50/8QVRM9pdyA64L5BsJEo92ewJWyvhx4X9yOngyLDsOqo8uxs+7ZtUzGQ==;31:taf+j/04OYn1GFQnH2T9s5A9hf2FU/a8ruRAzcKReCvYcLJ9xDLT3Y1/ScOhwBz/qGfRoqjDx5LKTUBEyTEiPyhcbJI6yU41Oq6BoNn6k7gGoBGnXK87dlrUD2eYaOPTmeO5jeP1PH3b+b1gKB+yV8qM7r17Js6FqNYgA9+DmDCCeqjQiCrIOw1qKgxiMXAjyW9aS32VFlr7zQTE4B4aVAbBpVRtpGOan2wn4jymLnM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1981:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;20:LqCC8mawDfeIiYDh7XDtJI7G8UxW8vQxXoyMcypT5Vbg+K2z5VqVUamZqUu68p2BgnfXBdxtZ8agLY5OCAJBnGaezpa68AQoqhNwl4TQ9ccggiT7T+cLZA9NZIeUWTyAkU8E2jucdpXaZPM9LyXvv97m1J2K9vqPfhQrHlDUwK3emoLEeZYY3YWtnfLXQUCO237r+yH9P9MHK9AuFM/ccwWftmv3Rj5/mYGZ73IzExyNoIzrdkA9pZhUkuYSyVvdtj9mtkqNEZfsD6mt4Z6MtOtdKmdDgytb6J/CrYzb9TEIYxAhVOeSb2KEMMjcPEb6GaZU91qaka+21+/76GuJTFkNvGaCa5rt7C/yDoO/MaL2T6ams7nqQXP6tMNWncmB8b1OvHyaV/VHMjzfVCzwuwt5Ceq9VOZsvNEeYkweM/TiG70V2FN8vAJ5BnuQUhZPqxYt/RgGGt3EaUOsug6YLmMG1Ln6bxze5OdaTZmRlpB5m+E9YMWJGs4oKLalk2hZ;4:VSlK7XeM3OMq5oLEyYq8emrL2etbMug8L31Ws0+MIqMKVCqRgUReaaDU0VD5pMrsMxIDuth42hKkT54G0G2f4/swov8Qv5Mby782QFUC/8Al4uenTH98aq5iJqYg6G7JHMcUE6O/XhxfiK/VTvNsK4lzp/6dR8TppKHxS+2PT6u6w9i7phNOCEfHwL7TmAtrpna9z42YSNeBerOnBBjK6hB4o3FVOAPg/slMlK9m2lvs+xRfiU0u9UNAC0SYC+0AYKElWDzFFWsq+41/hTMWy8yUUES0SQOOJfflnLbKHKt7OCM4rI7J0gTXKITLoRZE
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1981C51C5526F6726B3F56C0C99F0@VI1PR0801MB1981.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1981;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1981;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(346002)(39850400004)(376002)(189003)(199004)(21086003)(16526019)(59450400001)(6666003)(46003)(52396003)(446003)(6916009)(7416002)(54906003)(4326008)(53936002)(2906002)(6116002)(386003)(6506007)(16586007)(53546011)(68736007)(25786009)(5660300001)(575784001)(86362001)(229853002)(186003)(8936002)(7696005)(52116002)(76176011)(97736004)(36756003)(476003)(316002)(50466002)(55016002)(486006)(8676002)(7736002)(69596002)(81166006)(8666007)(1076002)(106356001)(105586002)(81156014)(9686003)(6246003)(23726003)(47776003)(33656002)(478600001)(11346002)(305945005)(58126008)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1981;H:rkaganip.lan;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1981;23:vqgInOwc/Drq5xKnR9ZszY2b5K/hdWbwz4PYbAs?=
 =?us-ascii?Q?7iTKOrCF8C2N9ktlq7RzRElk7q9FJ7BJB9YtDmVAlA+riU3N8D/D6GwTUZ7m?=
 =?us-ascii?Q?mbw/Ovush1wtsVJ3iF6Oeo0RnHOfayyIRQ0SCZh0Zp9G0Wor2u740ywQTIYq?=
 =?us-ascii?Q?RT4kXXAMFHymftk8DeOrv/MSi6XtrLtiUuqw4d4t68o1oDOZyehXK1m3ZGAt?=
 =?us-ascii?Q?McxbTkM6nJ7bOLWyKQwOhQisE3JJzrIo58UWDThCmCUB1AWeng2Qj9D0ORzJ?=
 =?us-ascii?Q?N3iqV9bjgFzrhGn1j2bzTJmbF1145rxB0s9lKkRQ6l7Yzkhf7aIDl/Yfjd+G?=
 =?us-ascii?Q?sUsND4HALv1nNaxePtmjnRaELtyKlFjP4/3wPQBiJdYmaOHeeg0skGLu5MyJ?=
 =?us-ascii?Q?SoHx270zRQ4KTnEBtUZWy6BSf9bCWCccda5IsVFwCoYrKd4b/9qm334wHwjj?=
 =?us-ascii?Q?YRD3nis4UaunAhBlgziYIE2KGsxk3zL/Rcm60geiNjPWrDZezNcagxQVgaZK?=
 =?us-ascii?Q?sghI3igZPur+iMS8Hf7YRqnSSHOybWktQFLzl3cQsJO06A+YiMLhev1LIrPp?=
 =?us-ascii?Q?kQ6UGTpFtghDsOZI3xYiQePc03esZbCj9zAaHRoxUPyzu/11u9vOwvO1ePIo?=
 =?us-ascii?Q?sh2XE1nrF9kdLDWT1l4l3Kk4PDxQtIpkCZak+csM2SgzUbsNH/FJlJ+no1lb?=
 =?us-ascii?Q?l3ZPx/XrXgnAZX19riXyUdwv2v1wJzlFCHx0Cn2K5LmDP6/rLzb4xLjPcAXJ?=
 =?us-ascii?Q?SjLsU74wREEkneexPvPzvi0tjopKgi8yfQ4vLaeqUsq2IikUAy6idHdqSii6?=
 =?us-ascii?Q?kG0bp5DcRCyQpwGvkIIeM9j18U1FAi+w88FQoSeZCGQdpR4dLAradNjUtMg0?=
 =?us-ascii?Q?OSPahMh1IiiobTmdtUw/VP5nR/IAtZG7NGSv6rVuXxj0MTf6WjrCzPIdHACJ?=
 =?us-ascii?Q?5fSH+itrqHA4SFntnYkOsWMvuLSjdWOdbORrbu9XN6JIujWfCkGDQXMLGt2Z?=
 =?us-ascii?Q?6cCRZaTpI4xe4ej21XhTdczLuonTuTeEVcjTcnJfI9agcdMLla98N3rQSLAN?=
 =?us-ascii?Q?PHIlvrX3oESAF3+3T56/sm/VRwGbDaJAi5sBeu9OGsA6DMvV4jUAySPbryuG?=
 =?us-ascii?Q?QIbsq+zGrGCJcBrM09LrD4DKfT38MR9GZgB1vF+C8yQV2DV7SAKvEgzpKSoN?=
 =?us-ascii?Q?WRoQrrvzYBsXrYGVnbohuEiDlmvU7BzxRqj1PUgWYUxxaj3Ibxq+7mCmWGIz?=
 =?us-ascii?Q?ISIp1KAqxnlsZgStBRKIxYPASVbXzkDh/dh5nImnZ8IYHJWbSgXyV0uZPuL+?=
 =?us-ascii?Q?FtWYYybP6mfQ0Hw71935lXZXWuuOWa4BTI+uPcfp6eBo50BVqVkhIqveIfWF?=
 =?us-ascii?Q?dLxFv2IliYmh5Xo4zoGivqLtr+C2X6dGI5pLxNn6Se0WNu74k?=
X-Microsoft-Antispam-Message-Info: 77/+dTgaaoALW6LV4r49eo+Ei2mA2TW7tMaRvcIhHUPRgBlOPD7YkVK+hGGmiAUjdKs2JkTlflcn0XRmNbSwQSexFMIy3tf+ELEV6lJnOXDUG5di2RKluuF8/jZvKzHfAykaCB74wlXzIug8XFe4ZQcw16pmG5p9dlwqIRgvCeDpiuPpPqzzfZcSGb6PbVdv
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;6:WEL9htPqZaOOBTt1oVFcLckDEU3ZTSx3PhHYfnOXoReQvLm4kOMjGUZHS0KD70Xad37umWCdOVU2erls3fTa12AuKYS7QH5CTBIGxzlQLFeca099JjQQ+csvIcsUa7B8awfqUlsLSDPqhSDeDFMRYMFRNQxPjcN3PMJaMSRGFe5nZLxpgxEqi5Pt89O7R3jZdanXyxw8m60oBxvsFfCHG/5whbgKPcwb7ruCSexsqlUDR+snP8YuHFvUx/cZuipH1jye1bgRkAn6xPuvkLZQ1EPEBWEW+LphoPecHFJe0OJSEfQqCCQvgSVseWDCCVifx3jbQVw0OIMc4tY5fgUSUFiNvv3tnjPszP4VqC72IzK+4kobFEpRNHwIJvWFcdJ46v6Yi0D1NKXZ1Q3pvzWLqBtOpcrejPrucONISWkHsfYj/+VqCBLm/1bMsHJIfhvK3TU4ZsouuQn72PAD9btYvw==;5:43Z/xxEIKDfKzDUxJo7h87dwYIP0PdspwCo80krIERiZTWIlhJyBMGzXjrqxb4FBeCXULt8ecm1iIcw7lGB6gSarxrQjpXalj3CHslc0xp7ic39VAqFqApJ+eDO4ktWq5srEOMCYMbj8yUm3EsAsK+uzxd6V/BTx2/MBSmM1HGk=;24:2R1PDXWgR+afaX5dHYi55F6npZaf6Dk81ztPyo2+Nuy6ZJ9Nfv6srzXr5NQP6nQYjYeSeJBjsHsoRWRcImqxPB8ekFZpjqRIke2DfkePtxc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1981;7:SXUoKRD4+MUB1hbc4G+nOSgL+4Ys9KtkZ/D8CnvX3cKpIFSa4ib34KfNVm7//xXQMuKn8VB3ukF1v6h4D/tyAxNnH1Fk8ucAkCXQCbTPffObqUxNP/bCs0Iqt+ekYOo/v+qDGKNOmI4XiT0u8R7Do40AuVA3yC/pXmXWZqwHFr+J+wsoBgkBhrqhkKECkygL+VD9vqiBwDiiO7SVfuXleQZW1x9rbVxeiau7zTv2m6V1Cq9I5fgSOCSdc+r5x8+b;20:bQmFQ0Rbw7Gkr+SUY9fgmfa3Qhf7pt2oToXACVbE1DusSgTay7fqgsoQGaE0qq3M184ujfiPP32SE5t8A2N1mgrPPg6dJUirasZ+/1QtVkOFyd/vHHkZR6ypu0pJEJxHwywrgivPT+ztdbrQ0yVspD7tSfCbg4XqSdj4UCKNpFE=
X-MS-Office365-Filtering-Correlation-Id: 855abf23-c0d6-4e89-fab2-08d5b70408e4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 05:57:08.6158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855abf23-c0d6-4e89-fab2-08d5b70408e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 07:40:26AM +0200, Dmitry Vyukov wrote:
> On Fri, May 11, 2018 at 1:54 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 10/05/2018 21:16, Roman Kagan wrote:
> >> If an IDR contains a single entry at index==0, the underlying radix tree
> >> has a single item in its root node, in which case
> >> __radix_tree_lookup(index!=0) doesn't set its *@nodep argument (in
> >> addition to returning NULL).
> >>
> >> However, the tree itself is not empty, i.e. the tree root doesn't have
> >> IDR_FREE tag.
> >>
> >> As a result, on an attempt to remove an index!=0 entry from such an IDR,
> >> radix_tree_delete_item doesn't return early and calls
> >> __radix_tree_delete with invalid parameters which are then dereferenced.
> >>
> >> Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> >> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> >> ---
> >>  lib/radix-tree.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> >> index da9e10c827df..10ff1bfae952 100644
> >> --- a/lib/radix-tree.c
> >> +++ b/lib/radix-tree.c
> >> @@ -2040,8 +2040,9 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
> >>       void *entry;
> >>
> >>       entry = __radix_tree_lookup(root, index, &node, &slot);
> >> -     if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
> >> -                                             get_slot_offset(node, slot))))
> >> +     if (!entry && (!is_idr(root) || !node ||
> >> +                    node_tag_get(root, node, IDR_FREE,
> >> +                                 get_slot_offset(node, slot))))
> >>               return NULL;
> >>
> >>       if (item && entry != item)
> >>
> >
> > I cannot really vouch for the patch, but if it is correct it's
> > definitely stuff for stable.  The KVM testcase is only for 4.17-rc but
> > this is a really nasty bug in a core data structure.
> >
> > Cc: stable@vger.kernel.org
> >
> > Should radix-tree be compilable in userspace, so that we can add unit
> > tests for it?...
> 
> Good point.
> 
> For my education, what/where are the tests that run as user-space code?

Actually there are userspace tests for it under tools/tests/radix-tree,
but I didn't manage to get them to build.  Looks like the recent
introduction of a spin_lock in the radix_tree structure (for XArray
work?) broke them.

Roman.
