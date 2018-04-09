Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244833-2-1683606701381655050
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
    1523244832; b=oz5jrQQS79z0cbpBIZJ2HC+RIxgJ/GNvcLruNKJhDLFCJ4k2kT
    GfUJ0xXkoo/Y5mg6mJYW1eJC5bQ+R4hm3pRJ5cKVgsXdPc4J6azeWErPZ/wF+Uqq
    mN2j7flN8NtfWX02AMBYfZVwK7iPd8uV6OXvlcFDUp2/kNRCDCW+MAHGwl7+KzG1
    ey6+O6/kZDx0uBSKiQVrm+6TFsaCZ/zaEP8JAK+VJxXvq7FdJkcxM5y6R9Tbyv7L
    7WqSCaA7fXJ+uL0WRs9boL6xQwej/NUhSUmQGOylmB/eJ9pQqDK4NJT91dXETEGy
    mTV9EWaBHFgIycdXgYluzcidC1p9+KqIdR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244832; bh=rW/beMzn6L
    hgz4SArzGgzjjRsdCfyC4ZkrAc2Etp224=; b=sG6AF3i58wWAvNdU06CjXI8bFJ
    BRL0x2MqmXuR15puQm8j8WxYmLxWJ7AQVLvaytpdMPAj8zfctVoee02ilyVELSTo
    INwAC0fzpRZ+BgSj9huAjikTNP1ozqgP2mbtOdERwePwjY4qbGWQd9Z/Yc5LkDaK
    p23gYEdBS4EcTKhIhtSAmfj5Qlvfel8fHqgL4RFiYMYVa9+raDNBOB8y8/L91wPh
    f/iZrWpa4skw5eiInicFfROJARligIlLarApmu2PfHsXrMbhTwbHp4SQAy2ckFUG
    A1MiWipo+Wug/0/ncUDjU3aHWShsKOyHF1A9nPeY6wQvMk2sEozvoQ8Asy8g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BP1w7e6Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BP1w7e6Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMSoSWNs4hqNo0RavF9DB0nxuaDW26YmpJs098vHPlShmaGHkZ1Yl/VGPA+jRdpwKLUIcNUbeG6QQ4JVPR8dQhBE+7CV5sC1eTSCVPa9cQ0XzBhzq0W2
    dAAE/EAhr66voCL8KTX8r91+sorlZAtwilU1tzabtyUNk7FPE/ZNJqUTsaNjIBlOnkij5WSJldWH/PLTu0XzDB+M9bnKxKu7E0SOwrG7Bc3e34hAa2dVDfRL
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VZJtwKKvAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=gOAldnjqTaq4RK9y1oUA:9 a=wPNLvfGTeEIA:10 a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeDIDdJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:33:09 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:54803
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754449AbeDIAVU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 176/189] SUNRPC: Don't call
 __UDPX_INC_STATS() from a preemptible context
Thread-Topic: [PATCH AUTOSEL for 4.15 176/189] SUNRPC: Don't call
 __UDPX_INC_STATS() from a preemptible context
Thread-Index: AQHTz5hgNkKA6xQ9ekKk8G6oLPoI6g==
Date: Mon, 9 Apr 2018 00:19:08 +0000
Message-ID: <20180409001637.162453-176-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:gXeDg2QkvXORTUKW5CzBbzo2vcu2aZEwpUhl4VRmzshha9mXu31PQRXdvSN8ZKIinr6bHKXMcZkCjqq/ubPLEroYy4PsIjQzHhz2t+Fx0sCKCjSzcgA0Ixc1yH0ELrEx8fBrBt1CJBrtlOFZKlGOKIJjElW5fVojNVqf95F/o6LN9ZifZky21GvjgjMNE4H3oHDZuM/yBgJdT553qGYzlscf/xvdqCcZXXvWHY+qX6zqAAoICfpxQj57mlWDNDMD;20:7II3UvLDwYsPomFpiNyNhVGu4pCLKBRl9ZyjkLIeGEoMFh/zpiszEcSvy5yuPdpLq89+lGnIn6eeYedYXT8WovQ6Zq+OGo4ftwZv6TM8ucLKAY8iT+VwqSzEv0hqs3LAVEXj4BzGwHs29ibAhmni5HbxzLnUQPAPdowINGMnXus=
X-MS-Office365-Filtering-Correlation-Id: b9968f6d-4ca2-4255-d84b-08d59dafcdc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125064E364FCD856C082E83FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(52314003)(199004)(189003)(51234002)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: WzgN0IPKhnr2dm1eYTrNnczRsZfcQ6N3QQswEKUi1QWf3cqvDGbsB1kGV32Bvw6aO5fyeqR7427/9uN97QGq0jZz+POzVWMqXVz2narsgzm768tjpFxipp19VrtjrZsdtcCCC+3D2rZrCBSgG6jV/56GV89pLYyq6YvQ11jPKQDILkan6VufH1NQqJl5Y77TYuPDcDkxhEkcnA94XCT2thbRh7xIhh+bcYOqB5Uk7G56oLDj5urPgiFSRUZptDUHSv+UHs/qGpzOgILutG++ZtnbqpspQCi3w7JdUnAcrXst2g/x5VYk7p+MlsLpITIn4R0mTE5Fz5sxl5g/5Uim1V+UBXorGHSlotfozDP77Dxu4fFdo639AkELFjKGnSoDVRH1qcxML9Glj4EmTbFKmzH7LWcJ0mLB8yWCH2ZUFsY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9968f6d-4ca2-4255-d84b-08d59dafcdc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:08.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 6d0cc3b8f932..33e2baebdca7 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1070,18 +1070,18 @@ static void xs_udp_data_read_skb(struct rpc_xprt *x=
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
