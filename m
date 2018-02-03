Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683111-2-15777844182438520694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683110; b=I8Qq7FwHrIn5yPC22ePmeQdPrB+d+c3JKb6i7NftCCxPe5J
    1wK6ZOVw8pZT4fAauo9QTuFwIQGoXK+w3j1aBu9gkiP7LDobDpoTIfbSKTejWpkH
    7paNFPd/07PXqtWOfiTnDMKZoeTTE+yi7iVf55pC6cL17hoVauSFtJWXdyRinZj3
    4/NXGBH9Zv44qwieUYOAagMhFyOcbH+GUYyCAJRcufwdt3uBgz24LVOK9CW06WmE
    IUi++EhVwh/cTSRKFU7lIOUOs3t32mXo/ukPj/zhTNM8dzsgazWaRo88OQ+m/B5B
    kq++Fe2WLNR8TpQrglcenL0NlrahCie0GqibQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683110; bh=pOy8rB
    RozFlo1QwT93ipUSp7GmUW3VCHElSwjrZIOAQ=; b=cqXdfJ9kHmg/d+OUZRML8X
    le95jWmvoMXK7eejnvadveca+d/KKdVm3BmYxJdhEvLyWVjfGf5A3f7tyOc4/tmd
    rUHko7JSHen3xeKAzSV+275MxIPibriHvpRDwfSA0sB7A2WUZlMex6FSu7AMZRY3
    pdr1s1REbH0DDHXp4M1rr5h7q7rK6YawjB//OFsOOT5rbl6LMbD9YeMxEOHNwt1z
    Db8Vyc0LEsKkShVrSdmGAhU1GG/tNJipLotRzS0w9ASQ+lA1bAdzdpUaNcj2QRNg
    H6FalZ5AdvRzoFgCD94PRe2FbgSKLNA46m8PLa4+lWzL2OogoePZrjkS+v6NVe2A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y5xBgGbs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y5xBgGbs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeBCSDi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:03:38 -0500
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:41422
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752997AbeBCSB5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Prateek Sood <prsood@codeaurora.org>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 030/110] cgroup: Fix deadlock in cpu hotplug
 path
Thread-Topic: [PATCH AUTOSEL for 4.14 030/110] cgroup: Fix deadlock in cpu
 hotplug path
Thread-Index: AQHTnRjoWBzwV/tJq0uAU/xdZ9hS9g==
Date: Sat, 3 Feb 2018 18:00:42 +0000
Message-ID: <20180203180015.29073-30-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:r0hbaRK2fnz4QKFQqkgVmkaeh9vu4RiydFDQpXciG3OUaTn/eDPl565vz9iyWk/0zmSuTVTL9vF2cGD3bCP2SBo9BP7LgJkdhK+iTg9A1nn4phSsFr/+Nvc2qQIuQ9NI0ISc02QMseZnyy9wxgPyRppTq6wdGby3GY06nzrmGJjfB6iLI1iOy9kF4dMuEODfLawcfDkCcUbqBi5vVjTOkNGmr/XPt3t4pOqmVdtW+RorNAmQnoTqh5Oljgs4CPohtMS9anid6SAPwRjBd87fTDigzHBLqAUmV2iBh8JGUP5Ie7jdqe1dbX0X5HHD5yVIetml1bGULkut9M684zG/zcKCD+3lXt6zIz+DLBSu500BZUmSSt6xPgTAIh7GUohm;5:5x4d/9yImZqBEzpHrfDTZ4SA+167oTiCJ/n/t7ocZPuB0KAGo1lQIxgF4jKMcj8tryxLvjstj37rbIvqCwlnC66BHjFiQKFrmy9fYpxr0sP/NBOP0m/g1/QZb5jXrdk+swaMqUG6xSwAvS07xceD+pOzGG1iWuI4kgJz17qxAQo=;24:OYzB6OIwqyHY88su60Vii9CP1m8Wl57bTgBlZoDT2oWzpyx7MJkLfkCbUf/yMZowkWZi3hiamkuSf6QC3rkbHH13KS3NrUKel3Gm0X24hWc=;7:WsaXhuQQxmPdhv6I2oud6mcjPdUupGA0kUYJsqT5hDNOUy/EF+ltDys1ruukqsMFwMdjYp4QDKzmEGdXE8I+5e2Qcoqx9sSQqxnh3Rdp2/8jnHFFSfrjN/rFtzbNweMI0mm4QlXcGWLP6RLsSjh/EDwA2kZ78u3tDngCBfe58Jdr7TW0ahrbUvb97BO/lb8hLNFWPnEbay0KllHI7Dh/tyaoFq+EZXlanMkRSmgPkvLKC24M/BBOYKJfv/XLjTo7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a045669a-bb4c-4499-c5b6-08d56b300c2d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB109089899DBA7D4C980B72C8FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(107886003)(72206003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 0c48uUybftMbrqLfqKfy+mkl70lXIwzKDJD5tcj+gUOwbdTJS/QNM9Ez5uZ2u7eKOZJYQye42mO1vZ7DCRXchg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a045669a-bb4c-4499-c5b6-08d56b300c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:42.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Prateek Sood <prsood@codeaurora.org>

[ Upstream commit 116d2f7496c51b2e02e8e4ecdd2bdf5fb9d5a641 ]

Deadlock during cgroup migration from cpu hotplug path when a task T is
being moved from source to destination cgroup.

kworker/0:0
cpuset_hotplug_workfn()
   cpuset_hotplug_update_tasks()
      hotplug_update_tasks_legacy()
        remove_tasks_in_empty_cpuset()
          cgroup_transfer_tasks() // stuck in iterator loop
            cgroup_migrate()
              cgroup_migrate_add_task()

In cgroup_migrate_add_task() it checks for PF_EXITING flag of task T.
Task T will not migrate to destination cgroup. css_task_iter_start()
will keep pointing to task T in loop waiting for task T cg_list node
to be removed.

Task T
do_exit()
  exit_signals() // sets PF_EXITING
  exit_task_namespaces()
    switch_task_namespaces()
      free_nsproxy()
        put_mnt_ns()
          drop_collected_mounts()
            namespace_unlock()
              synchronize_rcu()
                _synchronize_rcu_expedited()
                  schedule_work() // on cpu0 low priority worker pool
                  wait_event() // waiting for work item to execute

Task T inserted a work item in the worklist of cpu0 low priority
worker pool. It is waiting for expedited grace period work item
to execute. This work item will only be executed once kworker/0:0
complete execution of cpuset_hotplug_workfn().

kworker/0:0 =3D=3D> Task T =3D=3D>kworker/0:0

In case of PF_EXITING task being migrated from source to destination
cgroup, migrate next available task in source cgroup.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/cgroup/cgroup-v1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 024085daab1a..a2c05d2476ac 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -123,7 +123,11 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cg=
roup *from)
 	 */
 	do {
 		css_task_iter_start(&from->self, 0, &it);
-		task =3D css_task_iter_next(&it);
+
+		do {
+			task =3D css_task_iter_next(&it);
+		} while (task && (task->flags & PF_EXITING));
+
 		if (task)
 			get_task_struct(task);
 		css_task_iter_end(&it);
--=20
2.11.0
