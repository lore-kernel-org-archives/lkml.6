Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233663-2-15975327083185096229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233662; b=LVBmX0QkDw9ZEY6dXnQJJcw/usH40HlFtZRxLY1dYzQK8QYqvD
    T3V6FKcqKCjdWgC9gf6JZAkJk2cmiO9VIiExKE6yM6tOpr2buTPPLYUVSJf/vsbg
    RW6hH2GS5Q0192bEet7qZcki3HNCRJgBrmb/D4ZG/8UB2DueO6wj7FJomuoKKwum
    Ua9XbU+26qy0N7AFQTDnWAauZA/gYp8b/QEx4d2fvytMCvjO22tWdqSP2vD7wJeM
    dNjVNanfC4X7mQEl97JOEkw6kNHUM0VA7oNvDKheYEwNA4w9hOjTkCJoSlRZrox6
    XF0ONHIoc97XqQt4rqOwKs2Wc/8xvkMSeD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233662; bh=RbMjNXNf9i
    OapiXJhfUlkUH9s3hljlEi6FEEQOweCBI=; b=E6HsBXrURtk2eRIgJ6otB2K5Vb
    4xIP/C1WIZ5eKpx6oJRVOke92ST020nNCITReg4GPaTtbOX3bQQ+JE2rlw9thuVy
    E8Wv/df70RDDi5PmyCteXDNUPDv/WJdvR+syzSJq3764bUgfXv3oKoK6Hbs487QU
    bqPvt0cLEtz/LCoRnureaAoTU4FMjNvpJZY2FiIhqTnUjz2DK0+wf9nQ/dryGjHM
    7UVbJyngWmxzCU7UvAAU74vll3yNNSfSMvsrrUOK3jYF2N4iT5FJSe+UxEcvIEhV
    zVNHP/CdXPejtpBNN6Na2gZ+EsbpZNPZKMcFZnTBwYnU8IYgw7hfEw+mGUUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gkr84Ezn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gkr84Ezn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEmJ2bXchOkoRKLLhWM8Samcc3hTmsYRdOCz8Yhqlvbhx4jAlCn6D0q8IAoWMCozBYYUs5PijW25LbtC/KJNznII7ECJOxGYjfeMTmM4QQProjACBxnW
    B4xRONKV0qkY0stkjU3xsMYyR9NR0Arf7gRGKD2yFQvrQZZJBj5BdLQVBR2EO4ZnG+GKeQUi3oVFTt0s9yQb8N3Pa+Yj7mSssOVL8Q7ziE4i8sy1Q4D04d23
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=vggBfdFIAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=TuVOELpT45cMjGVs4z0A:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754094AbeDIA10 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:26 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754664AbeDIA1V (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 033/293] net: ena: fix race condition between
 submit and completion admin command
Thread-Topic: [PATCH AUTOSEL for 4.9 033/293] net: ena: fix race condition
 between submit and completion admin command
Thread-Index: AQHTz5j0jcBHpdppDkOM1ghVZudKaw==
Date: Mon, 9 Apr 2018 00:23:16 +0000
Message-ID: <20180409002239.163177-33-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:WJa0WhY7MH/6/bmaDh6znij3ikdXgmsT4qkii8erlmLH+//Ixa0EX59+WA4lLnbeeqCj1v/Tai877om8zv7yDLuM7FgeJTrOfwdEKJ3oklxCzAuploCgg1BH2DINsJ8N830YUoJXS0NS2mp3v9JiMPJQveD3IqE2aTNQ0vmlOaR/O4yOkixbixWjLmMBpChmUv8155tHNNStQyQh/GbTeWrTPbKKa21sNOi2UQkTzYy4vac3Tw9IIxNfMzD1UPCr;20:EEK+c5ebU3NasYYCghYmFW4eargL3T+iRHjcFZuRfuSXi8olhYVJX9f6IieDteeZz1f0GIRYHC2iSPV1cMWhe+1OlUFPtJ+AyTEcumH2df45LuRteC6EZloNfSrj6Hj2HdnYRF13npk6sQ2JVNPq6hu/SBgdk7Gs1T6XRkHVR9w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7bd4169-b860-40fb-7625-08d59db0a751
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10312DCC45D4A5AE700D1614FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sTQkquVIAKvodRQCpDr9wR3DxmPZwiBxXzdGYbXMhXZvNPv50wxFkGSxwjm2dR7mpZ1eCIgtf4rklaEopR/r1Kxikh+48jgTn6aRFEcbrJmx9Yb4fmb6SoSifM0KX4sNXFBW4sUCi6FwB8z17dta1vsgEKMykDckjoKrkBitvdBYH1dtU22ICXiu0dFt0I3X4wXC1gXhxpVcP4p8mEak3D5tLwYra+AAaZiA32aWOwOSu2+cLo9PTweTeU0H3APDoI4fKCpfE/gDU+yyECpl6+beusmV2CLPz47grUGyStEd1LBR1BCtg/X0x19czrH49q548KJfIAyp0FvWsii4PDJkZbNA0XJ5OTpHJWRF7EdwmD+BvskJoCuV8MMGYF4eKiRbOHCCF1IjH3HBRNV9jEOH/gyDblzfXNjs7ENUA+8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bd4169-b860-40fb-7625-08d59db0a751
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:16.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 661d2b0ccef6a63f48b61105cf7be17403d1db01 ]

Bug:
"Completion context is occupied" error printout will be noticed in
dmesg.
This error will cause the admin command to fail, which will lead to
an ena_probe() failure or a watchdog reset (depends on which admin
command failed).

Root cause:
__ena_com_submit_admin_cmd() is the function that submits new entries to
the admin queue.
The function have a check that makes sure the queue is not full and the
function does not override any outstanding command.
It uses head and tail indexes for this check.
The head is increased by ena_com_handle_admin_completion() which runs
from interrupt context, and the tail index is increased by the submit
function (the function is running under ->q_lock, so there is no risk
of multithread increment).
Each command is associated with a completion context. This context
allocated before call to __ena_com_submit_admin_cmd() and freed by
ena_com_wait_and_process_admin_cq_interrupts(), right after the command
was completed.

This can lead to a state where the head was increased, the check passed,
but the completion context is still in use.

Solution:
Use the atomic variable ->outstanding_cmds instead of using the head and
the tail indexes.
This variable is safe for use since it is bumped in get_comp_ctx() in
__ena_com_submit_admin_cmd() and is freed by comp_ctxt_release()

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethern=
et/amazon/ena/ena_com.c
index 564b556baba9..f4c107b66af4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -232,11 +232,9 @@ static struct ena_comp_ctx *__ena_com_submit_admin_cmd=
(struct ena_com_admin_queu
 	tail_masked =3D admin_queue->sq.tail & queue_size_mask;
=20
 	/* In case of queue FULL */
-	cnt =3D admin_queue->sq.tail - admin_queue->sq.head;
+	cnt =3D atomic_read(&admin_queue->outstanding_cmds);
 	if (cnt >=3D admin_queue->q_depth) {
-		pr_debug("admin queue is FULL (tail %d head %d depth: %d)\n",
-			 admin_queue->sq.tail, admin_queue->sq.head,
-			 admin_queue->q_depth);
+		pr_debug("admin queue is full.\n");
 		admin_queue->stats.out_of_space++;
 		return ERR_PTR(-ENOSPC);
 	}
--=20
2.15.1
