Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488702-2-6203169356643744993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488701; b=fvX9F1QAr+58soojmDieC6DIDDCaIud9FRM/8pqm2EECncV
    ZxeHHWikEW92xn3A8T4JGegohiqP6TONU2OCHY3RQgK3fwEYfinq3Tjq/NsemHM1
    E6GbFxME1QV1PGk7ZNtmLWQHViQi69P8y/EXg/tskwOzNVN988E0sLoz1VkJGGAF
    3AaWJ/+ihdh+1vaLO1ZVxsE2aBh6D1GSknJ7vxLfoPvkr/r9qgawhLrwmKPn+y5s
    FYf4uz+7c+uPas2T41dXKkUa/9RLdKi4HgTScTV/ekeT/V+shQgLnyfG83oOyW88
    clc+vYPKkir4tZmwIpY0EhErCeefLHvReVdf4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488701; bh=AJXA2G
    4OUVGMqhKg1tT113oC/00Ks+JBO9bSVuJr+gg=; b=SF4YWIAsAM+dmahJS14r+P
    aLGYBgOg2OcUjl2MKqKOwViLrC3v/H+2Aljqk2YTbbQmeiu4222ysSmwszZV/OG8
    MbyrswCCbIKmLYzOJWPKUTNyAwuY62Uqy5cff9EfBxqa/m0csRDbkPrsvqg6WVSO
    SY7Rbjqk+OdoP+CiuzaYCws+X4YIUnlgB0DDec+CSPKdEbppb8b+0zkbYl7LOx2h
    FNKrPib1X5bChCLSWho2mWAmiXEJlzSSq4F4v2kRW0n5KzCcb726u0PnDIiba4vm
    ulMyiIWwl5TC9ih1B5mhf/CETdL6R47oI+D2gLTT53sYJBfXqERKpF7ljuXimqGQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YuNYFF22 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YuNYFF22 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966005AbeCHF6T (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:58:19 -0500
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:37347
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966004AbeCHFD0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 145/190] oom: improve oom disable handling
Thread-Topic: [PATCH AUTOSEL for 4.9 145/190] oom: improve oom disable
 handling
Thread-Index: AQHTtppNp5LpdkI/0UuBHQEAKKs4/g==
Date: Thu, 8 Mar 2018 04:59:55 +0000
Message-ID: <20180308045810.8041-145-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:/HejU0V5Nz1SDW6AoKB0Aoj7HULS9NOLFpjW0d3zCf/hOvZgz0VgOjpe+QOxo8FX4uqPG3j4YuBbeHT+KtczL41GmQROtutR2jyopL0fEM/EqsThc5PjosxvhHyPzkXbrFKulob2qTytXif/5Jmh8SUpEHHSvcD3fMLPATVgExwtY48pgPUonYtzvXADY3UcwulOBg8+5IHM4pdjujaUOfkM8rzY8Q13hI0thQpDMX55wv7tbXcyF73c9RcN7Y0Y;20:3EAdHJToA3U2PxLoykRLBM8+NNx/fN8yQqBNMZxL5C072236JnB72rRqSC/+jyv9rF+OTeULkx2qmIQcJuGW0dVvTgvimUAniMld0vLhjqQFd/0vp3bYjWqExZk7nnJF5FS94DBUiTRx+agXi5v0R91s2ZRBL4OXy6JdWRrbdEQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40aacf31-268f-4126-472a-08d584b1e9d7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090271EA025B8850B5230D32FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(274141268393343)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(966005)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6306002)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Lb2Z2QrShBGNC2bdammMWfAlEUYgPugBA9/3o9b8im0iUJ7zNIfvyZHBEoPftk9iNYk7ApHdIMibTgw9/OZb2tN1nP297NeyR9q1OVdHXykbK2v55uiCQgIXTGtMy43axx/C9Dxxnh6b/NE299ACU+iF78mk6946Bu3LHTrBC7p4S78Nuqda2Jw9FYnSy66hSoVtzJp9Md+kxP3XGrJe52A0iY/Y52tP8LYprKEfzJAvyQ14zw0Q4F8ScHkjd2y+Z27E/4Uh16sohytrSAqaFcSN7xcHhbMwacJHsEbc2ZG4QKYecNOvp1xHLAUZ9ulKA1ANIIDGag34pfYljk4ouw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40aacf31-268f-4126-472a-08d584b1e9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:56.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michal Hocko <mhocko@suse.com>

[ Upstream commit d75da004c708c9fca7b53f7da293a295522414d9 ]

Tetsuo has reported that sysrq triggered OOM killer will print a
misleading information when no tasks are selected:

  sysrq: SysRq : Manual OOM execution
  Out of memory: Kill process 4468 ((agetty)) score 0 or sacrifice child
  Killed process 4468 ((agetty)) total-vm:43704kB, anon-rss:1760kB, file-rs=
s:0kB, shmem-rss:0kB
  sysrq: SysRq : Manual OOM execution
  Out of memory: Kill process 4469 (systemd-cgroups) score 0 or sacrifice c=
hild
  Killed process 4469 (systemd-cgroups) total-vm:10704kB, anon-rss:120kB, f=
ile-rss:0kB, shmem-rss:0kB
  sysrq: SysRq : Manual OOM execution
  sysrq: OOM request ignored because killer is disabled
  sysrq: SysRq : Manual OOM execution
  sysrq: OOM request ignored because killer is disabled
  sysrq: SysRq : Manual OOM execution
  sysrq: OOM request ignored because killer is disabled

The real reason is that there are no eligible tasks for the OOM killer
to select but since commit 7c5f64f84483 ("mm: oom: deduplicate victim
selection code for memcg and global oom") the semantic of out_of_memory
has changed without updating moom_callback.

This patch updates moom_callback to tell that no task was eligible which
is the case for both oom killer disabled and no eligible tasks.  In
order to help distinguish first case from the second add printk to both
oom_killer_{enable,disable}.  This information is useful on its own
because it might help debugging potential memory allocation failures.

Fixes: 7c5f64f84483 ("mm: oom: deduplicate victim selection code for memcg =
and global oom")
Link: http://lkml.kernel.org/r/20170404134705.6361-1-mhocko@kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/sysrq.c | 2 +-
 mm/oom_kill.c       | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 53cbf4ebef10..ee86056ca9c3 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -375,7 +375,7 @@ static void moom_callback(struct work_struct *ignored)
=20
 	mutex_lock(&oom_lock);
 	if (!out_of_memory(&oc))
-		pr_info("OOM request ignored because killer is disabled\n");
+		pr_info("OOM request ignored. No task eligible\n");
 	mutex_unlock(&oom_lock);
 }
=20
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 4a184157cc3d..2641a11e4378 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -706,6 +706,7 @@ void exit_oom_victim(void)
 void oom_killer_enable(void)
 {
 	oom_killer_disabled =3D false;
+	pr_info("OOM killer enabled.\n");
 }
=20
 /**
@@ -742,6 +743,7 @@ bool oom_killer_disable(signed long timeout)
 		oom_killer_enable();
 		return false;
 	}
+	pr_info("OOM killer disabled.\n");
=20
 	return true;
 }
--=20
2.14.1
