Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233597-2-9146962983150534336
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
    1523233596; b=QpU9WkSO/MHepCQamWNd8AslixorIVSZWcXaHCc5pjLXe0kWkt
    K68GjqYxaAWmEuQ4KwmDtz3c3cNvkC6dm+FOytccZGECw2tguEcKxmVqM+83j/i2
    /16UZYcz+Kw6B8D9FPCc1vKgR4nheK71xVTvcsqytJ641RcK7Z0aG+Q8kxllyNpQ
    RIbKQrT1zQJVcfqPWR6lxu14jhZYPoVVskRIrBitQ6EN1KUKMB1FIM09ad83lMnZ
    XxpVbiqDMd20ILKHSSKAeLBDvUJiApRAbvvwMaaiMyRNUsWrgoALUsOyJKrZm1cn
    wPMG+0TJ6fsNKi6o6tXnARpqgaqqI+V+4q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233596; bh=Dmyd8pIkqs
    lu39cEEG+KevbgCCTGAkcXYOFlkEdapf0=; b=JOb/gry/1D7Nn5MHI4ute75lkw
    oqTxDAzNVKZqYGch3Moq+Z3pc2+mCUzu/zVyxnRCy1mhl+3kcQhONvUtw8ShAxAc
    curaSJ7V9bto5E7iBFjOglV8M0UKB0M2st+kR+0QLPDtb+pN+Z9MT60Arj3h3qdf
    lZmYHquA3VaLWZqaXnJXN6xPjF6jrMM+9zgi7i5N5OUtHqRIsVusnc7fg+2RFWdw
    592zbkU6kGV8pBQdxeni6N3AItHzB5bGYoyUO82uRQv2LfFhnG2JOoLI8JoM549f
    94Ct2fqSACndkbgRgH5a2cyQQ9KEUno6BCnKt5ZWXN49X8KZWqFT1Nj82QAg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bRHxnVkw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bRHxnVkw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfELM8zRZASLvyLJTvdS9KoNq5JX6SYfBbJPjw9+puv58Pbh4mdyq6Q0ide3sxGcYNbnDT4WmwbIVoQxCEVK+WTJh+EkZu5v0DPaYYlPx8utcCvqKe1aZ
    fOfTEkdX4YG4rzLt67x2GEmFfItnNakgp9dlCQjuHjYbcydSdGdHqg9T3Nuv4NQ4Ehlr5aWDxSYik6wZckwhIeuASJHLBtW9XlNef0sTUr6WJX6T7j0vksPN
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VZJtwKKvAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=gOAldnjqTaq4RK9y1oUA:9 a=wPNLvfGTeEIA:10 a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755318AbeDIA0Z (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:25 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:4960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755311AbeDIA0U (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 148/161] SUNRPC: Don't call
 __UDPX_INC_STATS() from a preemptible context
Thread-Topic: [PATCH AUTOSEL for 4.14 148/161] SUNRPC: Don't call
 __UDPX_INC_STATS() from a preemptible context
Thread-Index: AQHTz5jDLWCZKInW00ScQYyJj6N5hQ==
Date: Mon, 9 Apr 2018 00:21:54 +0000
Message-ID: <20180409001936.162706-148-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:R0qNhvMYswxxzD+l9rNICfqEu9hEiYvjEsERr3SbdgnP/2Noqds6KLYvJ7kDyH4jVnRaial2B5H/kIOvcJwIGpSEprCOy2kyl9xtCfSG4hjon6bMZwbm7lTrVrEjSne0OMdG9seywBcCUnrPTdyimOPmAlEKKgUSIy4byWuiEjmYHoHAGotcHBvmarHLYXZ8/kYBMvxCd2Q4C/iSm5KXF+P2cB8uNw8FuMLKtAvMjqFrICZ2tlwz/u8aEV83xlrA;20:QleprY4A0oy73VYgePBKENag1Q9olTtZm6Nk0gio/DJzPtbHv9jzZwQ3xifxPwVvuMF7ug8vwnkZLO6Blv8XSPLONUB8swXSjB2DWvDYYRuC1dBjjz90sK7KqIlafOKW/k0g460GOjLLRM7ZhelfLEo9CgfURJq8OjCLlm7BOhA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e12ba72-c572-4991-9058-08d59db08384
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072599B2518883F01ACA0911FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(51234002)(52314003)(6486002)(81166006)(26005)(6512007)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fnGJnutk61vAfQ7GLJPyGxv81m4iuB7eijqoqoOrKpy0871Wlgg3HQV5WqC7xhsYwhLqW7FXyie/flBN5E46yctLT0QlmIG4HOadHHpQGgF73TiF+dcsh3K2hYywJtryMsQ5xqrsJ9JZtDNtytkb5/cAGd4lQNzRvYXMEPVnY8E1boFGx36y87jQHAoGnSirb1pIdytZAEKbmcBuqz06otBWtsZ476wvSTUGfb9p0upt6XED1RGUzTQW4CY76pwIE6w3mzmMS/o4pOtTk1RDL2p4cwtCCRxk3QVK/0Jrxe9O9Dg8+0BYGM+VZwXLJSlCNKjTGYShHcqYH3vG/GwvFbMy+Q66jak5fxcGae8bgVtwSb1e+a42w4/XrAFAeH0sy/QHK/SjyInVbPLAmtQG6rCHoT00ZEv3Mcj3hTDd5Ok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e12ba72-c572-4991-9058-08d59db08384
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:54.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit 0afa6b4412988019db14c6bfb8c6cbdf120ca9ad ]

Calling __UDPX_INC_STATS() from a preemptible context leads to a
warning of the form:

 BUG: using __this_cpu_add() in preemptible [00000000] code: kworker/u5:0/3=
1
 caller is xs_udp_data_receive_workfn+0x194/0x270
 CPU: 1 PID: 31 Comm: kworker/u5:0 Not tainted 4.15.0-rc8-00076-g90ea9f1 #2
 Workqueue: xprtiod xs_udp_data_receive_workfn
 Call Trace:
  dump_stack+0x85/0xc1
  check_preemption_disabled+0xce/0xe0
  xs_udp_data_receive_workfn+0x194/0x270
  process_one_work+0x318/0x620
  worker_thread+0x20a/0x390
  ? process_one_work+0x620/0x620
  kthread+0x120/0x130
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x24/0x30

Since we're taking a spinlock in those functions anyway, let's fix the
issue by moving the call so that it occurs under the spinlock.

Reported-by: kernel test robot <fengguang.wu@intel.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sunrpc/xprtsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 8cb40f8ffa5b..30192abfdc3b 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1069,18 +1069,18 @@ static void xs_udp_data_read_skb(struct rpc_xprt *x=
prt,
=20
 	/* Suck it into the iovec, verify checksum if not done by hw. */
 	if (csum_partial_copy_to_xdr(&rovr->rq_private_buf, skb)) {
-		__UDPX_INC_STATS(sk, UDP_MIB_INERRORS);
 		spin_lock(&xprt->recv_lock);
+		__UDPX_INC_STATS(sk, UDP_MIB_INERRORS);
 		goto out_unpin;
 	}
=20
-	__UDPX_INC_STATS(sk, UDP_MIB_INDATAGRAMS);
=20
 	spin_lock_bh(&xprt->transport_lock);
 	xprt_adjust_cwnd(xprt, task, copied);
 	spin_unlock_bh(&xprt->transport_lock);
 	spin_lock(&xprt->recv_lock);
 	xprt_complete_rqst(task, copied);
+	__UDPX_INC_STATS(sk, UDP_MIB_INDATAGRAMS);
 out_unpin:
 	xprt_unpin_rqst(rovr);
  out_unlock:
--=20
2.15.1
