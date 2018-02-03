Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682542-2-6713883297803923344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682541; b=qEcnt4gKQ6tHnAkjftEy8KaxOyF/ApxAD0eQmVkgPJVTypO
    QxRWIbWFZou5N6PNCfja/BnrGUWnQAaIQMPgtBHbraBQen0ZDahJBL0rl05X7vRV
    b8zkHxn66/hQaa1Xc3ponG5OC6BxIqlTwOmVx4Y51DB42lfGPyajIC3P69WyqBYO
    5z9B+p/1YFNHbvIjXi4XZfEi1TaU+Wt9sFlb7KdQu/7jTJ47tarU642l0pvPpBxa
    hKY5rTybAVLpWjPU5bvj4urgDADyrlwKWhJ7OfNakJ7y5rak37fp203NPZ8z9jtr
    DtigiYSPaaEBwrHax5iEoIGocC9KQBfR08bWdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682541; bh=Yd64cf
    JYx3fW3IJQdE/VvZizf6Kro6FGFZAFshPuxEE=; b=a9txv1nVnEZ3AD7ZYL40M9
    lyqTsRe7neArfOaONp7RCm3tW6YIbOjxJncWuRNtHEU25BHp2hiW1EC7Mp0UE/om
    k7uC5dOr5jpHLuFwMPNaE0QTiATUL2ExY30014YwjwE/SEMGz0JeLpKjisL5dB4P
    PClzO3qe37cn8Kz2hLhWgpxjy7cbWxnH+IlVrOXXOmm9xNfxtop0lkKhbsPQZD0S
    VpkbNhtZqbN4jO0unEujPlJGAcUPyO//Sv6aBwPoMrYBtJZ9smNBmP7AihR6wt6B
    AXjsDc35BbjwRo0hWvdZscCznh1qEs9XT7IMekjzLjUXONYwI9A8TKi0vKn7AjJA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jpObI5ae x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jpObI5ae x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbeBCS26 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:58 -0500
Received: from mail-bl2nam02on0115.outbound.protection.outlook.com ([104.47.38.115]:21822
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752799AbeBCSEp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Valentin Ilie <valentin.ilie@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 092/110] ia64, sched/cputime: Fix build error
 if CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
Thread-Topic: [PATCH AUTOSEL for 4.14 092/110] ia64, sched/cputime: Fix build
 error if CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
Thread-Index: AQHTnRkCF4zjEdzv8UqjvceBUnh9jg==
Date: Sat, 3 Feb 2018 18:01:27 +0000
Message-ID: <20180203180015.29073-92-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:VLfoatXaAiDmFzDcxPNhLjl/4gQcL6AA/G9qHVqDSK1MgW5QhFZeRJ7CTh1ju+Fv447Txq7yx+fQcUz4+ETwMwNsV1rrovAqyRJx+HGNRZma00/UoKaOKObYpOHSTFRrfM1AEYP89V7uF+8AzrXou9lSElHwb6IMxzly+nolYRDgQd2hibRDvtzG4i4v7DsU8d5I8QXjzgQBFstWpsGOCoQ1tNf49gWpiD55eshjNFxZn/YNnm2i6fLXGJom/utQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f133efed-5878-4bbc-babf-08d56b3054f3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB1041BA104F5753AA3A0EB63BFBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(7416002)(53936002)(325944009)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(966005)(4326008)(39060400002)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(6306002)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: M/8nxyDNXEuL/ckS7HrImfFJ6kAsUNcbtFQxATsvn3OBQAoFsHDB0VyQxcjb+tbZKfVHcp/rO9i+s4uBA7Mdag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f133efed-5878-4bbc-babf-08d56b3054f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:27.2065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Valentin Ilie <valentin.ilie@gmail.com>

[ Upstream commit 7729bebc619307a0233c86f8585a4bf3eadc7ce4 ]

Remove the extra parenthesis.

This bug was introduced by:

  e2339a4caa5e: ("ia64: Convert vtime to use nsec units directly")

Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: linux-ia64@vger.kernel.org
Cc: tony.luck@intel.com
Link: http://lkml.kernel.org/r/1515193979-24873-1-git-send-email-valentin.i=
lie@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/ia64/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index aa7be020a904..c954523d00fe 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -88,7 +88,7 @@ void vtime_flush(struct task_struct *tsk)
 	}
=20
 	if (ti->softirq_time) {
-		delta =3D cycle_to_nsec(ti->softirq_time));
+		delta =3D cycle_to_nsec(ti->softirq_time);
 		account_system_index_time(tsk, delta, CPUTIME_SOFTIRQ);
 	}
=20
--=20
2.11.0
