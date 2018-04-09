Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242299-2-3266376678962005996
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242299; b=U06YOdhLiP+cnrRrhG+CSd1RuUh6GPLdwFQQ9DTtuj11frWwyI
    Zah6Z9b+b0cCWYX/I3dbDr8lKS8OqGL0/golnnKe9OFttKcU/LhnPLjXHbWc3mnc
    F+opK+VTvsNHGMAH8rdaYRPTkiyebxRx+9PUnAGzJVHy6pzDxffuRYCgVOyC+gRs
    ljfBgu0CIv44wee3KJRFk/ywijwAqd0L+pHYzV8qyi+yiliODgbM/lbmQzF+d4HT
    RqpHhrDwPJ6B1qHs4+sT4zfuJ1o/lHR0o2QaGQ7IqEJvMhENfeiaCeeJQLSD77qu
    P0xMXI4dFsAc6/4Nn05cvGvf+s/wZJJMwvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242299; bh=eupEr1OImI
    C1dqrHon02FUZNbis2rWHcIzoICgpkI+s=; b=r8LzkY9GCHOlpDsUMGA+bP4LeW
    zQ6tQN1HPjBkW2TRNzYdJmtja3OEca8ksUjxJm8lJTLP6EpDy9t8wJ+wg4PlXMce
    3GdXuDP8Cp61vWSxHcqXZZP++whe/kjsgouxYN7TxDBIDieXySXjTX7qp4/obhKX
    ILHan8k5rCIE8W9wgQu6j3Ce1o7gc8uPHbqDWRgYJXW1usNHpc6K1wW1tIpl9GYO
    o/08UIqJ3pQ8Fzty/WDLGbWHrIZgo8uI9bex3QqplBVZP3gDxMKMd7oujErWZ1ba
    +285UNLgAT7u+4PZ+VVhObgrD72OYYwgbyPcsWManKfcME/wp1YBkz1hRdTg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RXfbn8Wm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RXfbn8Wm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNRjOVCUtH8eMnWE8gB3lDKyN05wJwfqSlrAcZYdKPmfMeJaZPAuG0jGV0dnJq5fQJlliQsU7p3cugfyGJYgWwGWvEgydPS3K9tnmJe+VCe+4BfIeW2T
    xmXZ1iznshIUK9pVUuaL5Oudf3bSrimWhsJ1KTeqURwlztmJ9ViI7cgwKepLIaFv9/sIAyp4p1fzAy47wGN3vB7CJGbeqtt5QlAZd4Kz+C5sTUzyjPw13grC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=XapYkokd9fjVYds4b-UA:9 a=wPNLvfGTeEIA:10
    a=92Q717GQZsEA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755465AbeDICve (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:51:34 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755340AbeDIA0c (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 156/161] locking/qspinlock: Ensure
 node->count is updated before initialising node
Thread-Topic: [PATCH AUTOSEL for 4.14 156/161] locking/qspinlock: Ensure
 node->count is updated before initialising node
Thread-Index: AQHTz5jH4uJdvGUNy02wUjiAgr8Quw==
Date: Mon, 9 Apr 2018 00:22:01 +0000
Message-ID: <20180409001936.162706-156-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:53SuDfl/fo8WtDJ7+8JBn+G19qkD/ROwJ2yGTCersUFy3JFpKeF1HxPJs7ZnhZiwDzIZmWGV24hsfptHunaxUQJz7mQOBsQIOON9/xGOumMtkYH0zrYjF+6oIy1295rWF8dDT/v4xaQW2oHnEmAln6baOZfS/SVQhgGPtByXUPeF8Io7Cz/PyTYyu7YkUjhKY4kDw5dZVIcW0L7iR9IS7azspnxQIyFnlIWX+EPYKLxjHvrjfPTAER2/Ig+V7pyy;20:Tg935W3i6SMr4pRzFRJ3EBeacJWv2BmcbDdTMD5+wLigZ+LN13LhBvZZj7fKZBGER8D2f5iuwXdIN7cgASy6Q1g2dtytYbImyjE1l98Y5Ody1D9ik3b6EkkW6Noe8NyJjBP+EyBZJ5eFBPROawZEWk8zfv2KD3iI/DjqZhdqFN4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04a717e3-0bb4-4e46-efa8-08d59db0874e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015ECA67F3B743EDC35941AFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(51234002)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7xvzHHzKptnVCXH9jUkY8u8aG8D7lJILlxsVQIhkWNC77ac9qfLDosxmItQrI3DQbB7eH9UMCpUSiuzAOBuTdlDYKA2ww9AZ4xsEfsZJwE/HP0fARqB60RtheUZqfSx6mlDF8QgrgoFdOiMQ98solg1xvswv7peUIbVpUgJN67rrbXYaDBDQHZdvRZC+RMTnedW4DUpEV01QCvq4GGyWzOtYg56aq5NpJOu4evLjyswduV1hEG+IQyICuPC+jPEz5rYeI489Q5IluqbQlhLqJuSP9xrv95P68xhA5xq4kd5dSC4jBmsSPOTxc1Fm3sNglVz3lsGrsXIUN/s4RouLdkUj0RddrH1nBKMWaRPd4Qb6ZU7z3GGjhnjgs7ZMAHhPUq/3m/Cmf7NWfiltOjuVhTkTfe5HKOePIuZeNahGi0Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a717e3-0bb4-4e46-efa8-08d59db0874e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:01.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 11dc13224c975efcec96647a4768a6f1bb7a19a8 ]

When queuing on the qspinlock, the count field for the current CPU's head
node is incremented. This needn't be atomic because locking in e.g. IRQ
context is balanced and so an IRQ will return with node->count as it
found it.

However, the compiler could in theory reorder the initialisation of
node[idx] before the increment of the head node->count, causing an
IRQ to overwrite the initialised node and potentially corrupt the lock
state.

Avoid the potential for this harmful compiler reordering by placing a
barrier() between the increment of the head node->count and the subsequent
node initialisation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518528177-19169-3-git-send-email-will.deaco=
n@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/locking/qspinlock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 294294c71ba4..50dc42aeaa56 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -379,6 +379,14 @@ queue:
 	tail =3D encode_tail(smp_processor_id(), idx);
=20
 	node +=3D idx;
+
+	/*
+	 * Ensure that we increment the head node->count before initialising
+	 * the actual node. If the compiler is kind enough to reorder these
+	 * stores, then an IRQ could overwrite our assignments.
+	 */
+	barrier();
+
 	node->locked =3D 0;
 	node->next =3D NULL;
 	pv_init_node(node);
--=20
2.15.1
