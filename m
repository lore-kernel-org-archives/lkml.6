Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474583-2-13692183893026133937
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
    t=1521474581; b=ATRDC/MfleXkwXvWQMZXuDDpHLuPWtgc8MGtOF2tLsBKsg2
    NpCvUeYRm+nTUbuAPRvQXKPVq1GZVVi7hpQB1apm+OU/yfVkznKKSE/qhx/7Ww5w
    JHvWCUxB7CP0mlcn6b7XykW4hyWpTiG8HBi6b5ipgU879T2soAqr325/GpaXSP2z
    A/bCXxs4PEe6N7tExWaJ3J/z3EFNI7KmBBDPvP0De+INHgRbGCRpt8VI+PSNyxUy
    UVUCe5QF72UkwpswpLDA8AQvSP87J4jP5F+T0H8RllZxQ2nQ7i2qYMDEMfD6J0tn
    q7y6+uoHs3Jd7RF5FtG3ke3Sd0dIz/AO85L9OHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474581; bh=opW27y
    yuJqWs7ekLiqUEibGOFT8fEwKaMJCp2pBHWNw=; b=kBO1I0+DBmJ3nPJuvoko+s
    1SkW2yGQiYkG51JN2pye+bghJtrqRFTs3PtBl1ak/MvzYpbu0ZPom0ba0slBTpFb
    /0+bSHH83utNGcUero4Z9Fl923FIS8RKYTGPEqhw5peREf9Bqbj8LNJm/Fo11AIz
    fwVAi2Tg7GOk2FfA4tkGMgtHXRWFxMCjMnb0V3rApJeSdeB7773EtrfLCuWRHqOM
    6lyaZIp9slugPUu7t4phMxgHsyccBpRYf0N3v25LDMO3wAblL8AvPOjuedfP/O5Y
    vMTRy3XNzaatlxps9BS86UD7NXYOfDepAmdjdMyM9PzjjHKEbgydtGR8HK1AAtgg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QviyHqh3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvddugeehgeenucevlhhushhtvghrufhiiigvpeeiie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QviyHqh3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvddugeehgeenucevlhhushhtvghrufhiiigvpeeiie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeCSPtf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:49:35 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:18692
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933855AbeCSPt3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jason Yan <yanaijie@huawei.com>,
        Yijing Wang <wangyijing@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ewan Milne <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Tomas Henzl <thenzl@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 085/124] scsi: libsas: Use dynamic alloced
 work to avoid sas event lost
Thread-Topic: [PATCH AUTOSEL for 4.15 085/124] scsi: libsas: Use dynamic
 alloced work to avoid sas event lost
Thread-Index: AQHTv5m8XcK0YlL780uD9FJeDXiaRg==
Date: Mon, 19 Mar 2018 15:48:34 +0000
Message-ID: <20180319154645.11350-85-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:MRut30TwyjZyzaeNcs1tkrdt+fYolv6ZXgIWTH49f+omrYR0CO53K0sVxZZJCPdus0wvlxeT+xhBaZEsuFBNHaM+tQXy1LLkv7Cru9P+TQ1Oe0lXzfoxLRFVTlDausjyniOFeGwJ0zMwb4NpW1+YBbFS5lb1Wj8HdNeYVnb6ewor0vOGH4JrLWbp5vXNO4dR6xKWkUpJhQ96XTi4HufIJU6sZ49AEbOlShN6MT6PWdzpxHs+Mcadzbzb6vzxDRvG;20:7tqEQrWcbfX9Nvt0I15xBowvA3/ofRK8V/+qs1ffIfJeJzrNuXVirUlOZs2AODkMy53VZUTnw2RUNDvx8VWq4/BdtbhtPELvCvCxrgeFcjmY1yjuj1J2VWTV+73vVpi5bSeXFFDwez+U6Br9PwZ43I8m5WWAM6MWAP6Rak9V4ag=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70c4d825-a2e1-43b2-666c-08d58db0f073
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919A37FB308728560469435FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(7416002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(5890100001)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(575784001)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: WQkO4dcV/RIOkxcx5KZe7h0FcC83GQHCtl1gtftvGVbPjD9V5MB6R6NyntlaThn3oHOW5lcgcEUl96vSVeWXf+oCM6uYQLn74xbQitz7F0Ik436ytTFwzPKHUV/Ey+75VIuJfcGdCIX0Jcw99gOLJl6A7DQhGM77Mskl5ppm61CmISjVosoSFx6Pu8KY7TUX33aOi9PwRAnoyFCM+U94meQLKQdH/GMhEeo5AOc61VSxvUW5je/firb23c3kCN8mgKXwyi+77pfJ8VtXK/ZjBhKSo0xPmtenfDPnBXU6Rqej4uWUYBniZfpBcg5z0RGqFq+QpwaV4FrzNiQdumvSIQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c4d825-a2e1-43b2-666c-08d58db0f073
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:34.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jason Yan <yanaijie@huawei.com>

[ Upstream commit 1c393b970e0f4070e4376d45f89a2d19a5c895d0 ]

Now libsas hotplug work is static, every sas event type has its own
static work, LLDD driver queues the hotplug work into shost->work_q.  If
LLDD driver burst posts lots hotplug events to libsas, the hotplug
events may pending in the workqueue like

shost->work_q
new work[PORTE_BYTES_DMAED] --> |[PHYE_LOSS_OF_SIGNAL][PORTE_BYTES_DMAED] -=
> processing
                                |<-------wait worker to process-------->|

In this case, a new PORTE_BYTES_DMAED event coming, libsas try to queue
it to shost->work_q, but this work is already pending, so it would be
lost. Finally, libsas delete the related sas port and sas devices, but
LLDD driver expect libsas add the sas port and devices(last sas event).

This patch use dynamic allocated work to avoid this issue.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/libsas/sas_event.c    | 74 +++++++++++++++++++++++++++++-----=
----
 drivers/scsi/libsas/sas_init.c     | 27 ++++++++++++--
 drivers/scsi/libsas/sas_internal.h |  6 ++++
 drivers/scsi/libsas/sas_phy.c      | 44 +++++------------------
 drivers/scsi/libsas/sas_port.c     | 18 +++++-----
 include/scsi/libsas.h              | 17 +++++----
 6 files changed, 115 insertions(+), 71 deletions(-)

diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_even=
t.c
index 0bb9eefc08c8..5d7254aa2dd2 100644
--- a/drivers/scsi/libsas/sas_event.c
+++ b/drivers/scsi/libsas/sas_event.c
@@ -29,7 +29,8 @@
=20
 int sas_queue_work(struct sas_ha_struct *ha, struct sas_work *sw)
 {
-	int rc =3D 0;
+	/* it's added to the defer_q when draining so return succeed */
+	int rc =3D 1;
=20
 	if (!test_bit(SAS_HA_REGISTERED, &ha->state))
 		return 0;
@@ -44,19 +45,15 @@ int sas_queue_work(struct sas_ha_struct *ha, struct sas=
_work *sw)
 	return rc;
 }
=20
-static int sas_queue_event(int event, unsigned long *pending,
-			    struct sas_work *work,
+static int sas_queue_event(int event, struct sas_work *work,
 			    struct sas_ha_struct *ha)
 {
-	int rc =3D 0;
+	unsigned long flags;
+	int rc;
=20
-	if (!test_and_set_bit(event, pending)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&ha->lock, flags);
-		rc =3D sas_queue_work(ha, work);
-		spin_unlock_irqrestore(&ha->lock, flags);
-	}
+	spin_lock_irqsave(&ha->lock, flags);
+	rc =3D sas_queue_work(ha, work);
+	spin_unlock_irqrestore(&ha->lock, flags);
=20
 	return rc;
 }
@@ -66,6 +63,7 @@ void __sas_drain_work(struct sas_ha_struct *ha)
 {
 	struct workqueue_struct *wq =3D ha->core.shost->work_q;
 	struct sas_work *sw, *_sw;
+	int ret;
=20
 	set_bit(SAS_HA_DRAINING, &ha->state);
 	/* flush submitters */
@@ -78,7 +76,10 @@ void __sas_drain_work(struct sas_ha_struct *ha)
 	clear_bit(SAS_HA_DRAINING, &ha->state);
 	list_for_each_entry_safe(sw, _sw, &ha->defer_q, drain_node) {
 		list_del_init(&sw->drain_node);
-		sas_queue_work(ha, sw);
+		ret =3D sas_queue_work(ha, sw);
+		if (ret !=3D 1)
+			sas_free_event(to_asd_sas_event(&sw->work));
+
 	}
 	spin_unlock_irq(&ha->lock);
 }
@@ -119,29 +120,68 @@ void sas_enable_revalidation(struct sas_ha_struct *ha=
)
 		if (!test_and_clear_bit(ev, &d->pending))
 			continue;
=20
-		sas_queue_event(ev, &d->pending, &d->disc_work[ev].work, ha);
+		sas_queue_event(ev, &d->disc_work[ev].work, ha);
 	}
 	mutex_unlock(&ha->disco_mutex);
 }
=20
+
+static void sas_port_event_worker(struct work_struct *work)
+{
+	struct asd_sas_event *ev =3D to_asd_sas_event(work);
+
+	sas_port_event_fns[ev->event](work);
+	sas_free_event(ev);
+}
+
+static void sas_phy_event_worker(struct work_struct *work)
+{
+	struct asd_sas_event *ev =3D to_asd_sas_event(work);
+
+	sas_phy_event_fns[ev->event](work);
+	sas_free_event(ev);
+}
+
 static int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event =
event)
 {
+	struct asd_sas_event *ev;
 	struct sas_ha_struct *ha =3D phy->ha;
+	int ret;
=20
 	BUG_ON(event >=3D PORT_NUM_EVENTS);
=20
-	return sas_queue_event(event, &phy->port_events_pending,
-			       &phy->port_events[event].work, ha);
+	ev =3D sas_alloc_event(phy);
+	if (!ev)
+		return -ENOMEM;
+
+	INIT_SAS_EVENT(ev, sas_port_event_worker, phy, event);
+
+	ret =3D sas_queue_event(event, &ev->work, ha);
+	if (ret !=3D 1)
+		sas_free_event(ev);
+
+	return ret;
 }
=20
 int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event)
 {
+	struct asd_sas_event *ev;
 	struct sas_ha_struct *ha =3D phy->ha;
+	int ret;
=20
 	BUG_ON(event >=3D PHY_NUM_EVENTS);
=20
-	return sas_queue_event(event, &phy->phy_events_pending,
-			       &phy->phy_events[event].work, ha);
+	ev =3D sas_alloc_event(phy);
+	if (!ev)
+		return -ENOMEM;
+
+	INIT_SAS_EVENT(ev, sas_phy_event_worker, phy, event);
+
+	ret =3D sas_queue_event(event, &ev->work, ha);
+	if (ret !=3D 1)
+		sas_free_event(ev);
+
+	return ret;
 }
=20
 int sas_init_events(struct sas_ha_struct *sas_ha)
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.=
c
index 64fa6f53cb8b..e04f6d6f5aff 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -39,6 +39,7 @@
 #include "../scsi_sas_internal.h"
=20
 static struct kmem_cache *sas_task_cache;
+static struct kmem_cache *sas_event_cache;
=20
 struct sas_task *sas_alloc_task(gfp_t flags)
 {
@@ -364,8 +365,6 @@ void sas_prep_resume_ha(struct sas_ha_struct *ha)
 		struct asd_sas_phy *phy =3D ha->sas_phy[i];
=20
 		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
-		phy->port_events_pending =3D 0;
-		phy->phy_events_pending =3D 0;
 		phy->frame_rcvd_size =3D 0;
 	}
 }
@@ -555,20 +554,42 @@ sas_domain_attach_transport(struct sas_domain_functio=
n_template *dft)
 }
 EXPORT_SYMBOL_GPL(sas_domain_attach_transport);
=20
+
+struct asd_sas_event *sas_alloc_event(struct asd_sas_phy *phy)
+{
+	gfp_t flags =3D in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
+
+	return kmem_cache_zalloc(sas_event_cache, flags);
+}
+
+void sas_free_event(struct asd_sas_event *event)
+{
+	kmem_cache_free(sas_event_cache, event);
+}
+
 /* ---------- SAS Class register/unregister ---------- */
=20
 static int __init sas_class_init(void)
 {
 	sas_task_cache =3D KMEM_CACHE(sas_task, SLAB_HWCACHE_ALIGN);
 	if (!sas_task_cache)
-		return -ENOMEM;
+		goto out;
+
+	sas_event_cache =3D KMEM_CACHE(asd_sas_event, SLAB_HWCACHE_ALIGN);
+	if (!sas_event_cache)
+		goto free_task_kmem;
=20
 	return 0;
+free_task_kmem:
+	kmem_cache_destroy(sas_task_cache);
+out:
+	return -ENOMEM;
 }
=20
 static void __exit sas_class_exit(void)
 {
 	kmem_cache_destroy(sas_task_cache);
+	kmem_cache_destroy(sas_event_cache);
 }
=20
 MODULE_AUTHOR("Luben Tuikov <luben_tuikov@adaptec.com>");
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_i=
nternal.h
index c07e08136491..d8826a747690 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -61,6 +61,9 @@ int sas_show_oob_mode(enum sas_oob_mode oob_mode, char *b=
uf);
 int  sas_register_phys(struct sas_ha_struct *sas_ha);
 void sas_unregister_phys(struct sas_ha_struct *sas_ha);
=20
+struct asd_sas_event *sas_alloc_event(struct asd_sas_phy *phy);
+void sas_free_event(struct asd_sas_event *event);
+
 int  sas_register_ports(struct sas_ha_struct *sas_ha);
 void sas_unregister_ports(struct sas_ha_struct *sas_ha);
=20
@@ -99,6 +102,9 @@ void sas_hae_reset(struct work_struct *work);
=20
 void sas_free_device(struct kref *kref);
=20
+extern const work_func_t sas_phy_event_fns[PHY_NUM_EVENTS];
+extern const work_func_t sas_port_event_fns[PORT_NUM_EVENTS];
+
 #ifdef CONFIG_SCSI_SAS_HOST_SMP
 extern void sas_smp_host_handler(struct bsg_job *job, struct Scsi_Host *sh=
ost);
 #else
diff --git a/drivers/scsi/libsas/sas_phy.c b/drivers/scsi/libsas/sas_phy.c
index cdee446c29e1..59f82929b0a3 100644
--- a/drivers/scsi/libsas/sas_phy.c
+++ b/drivers/scsi/libsas/sas_phy.c
@@ -35,7 +35,6 @@ static void sas_phye_loss_of_signal(struct work_struct *w=
ork)
 	struct asd_sas_event *ev =3D to_asd_sas_event(work);
 	struct asd_sas_phy *phy =3D ev->phy;
=20
-	clear_bit(PHYE_LOSS_OF_SIGNAL, &phy->phy_events_pending);
 	phy->error =3D 0;
 	sas_deform_port(phy, 1);
 }
@@ -45,7 +44,6 @@ static void sas_phye_oob_done(struct work_struct *work)
 	struct asd_sas_event *ev =3D to_asd_sas_event(work);
 	struct asd_sas_phy *phy =3D ev->phy;
=20
-	clear_bit(PHYE_OOB_DONE, &phy->phy_events_pending);
 	phy->error =3D 0;
 }
=20
@@ -58,8 +56,6 @@ static void sas_phye_oob_error(struct work_struct *work)
 	struct sas_internal *i =3D
 		to_sas_internal(sas_ha->core.shost->transportt);
=20
-	clear_bit(PHYE_OOB_ERROR, &phy->phy_events_pending);
-
 	sas_deform_port(phy, 1);
=20
 	if (!port && phy->enabled && i->dft->lldd_control_phy) {
@@ -88,8 +84,6 @@ static void sas_phye_spinup_hold(struct work_struct *work=
)
 	struct sas_internal *i =3D
 		to_sas_internal(sas_ha->core.shost->transportt);
=20
-	clear_bit(PHYE_SPINUP_HOLD, &phy->phy_events_pending);
-
 	phy->error =3D 0;
 	i->dft->lldd_control_phy(phy, PHY_FUNC_RELEASE_SPINUP_HOLD, NULL);
 }
@@ -99,8 +93,6 @@ static void sas_phye_resume_timeout(struct work_struct *w=
ork)
 	struct asd_sas_event *ev =3D to_asd_sas_event(work);
 	struct asd_sas_phy *phy =3D ev->phy;
=20
-	clear_bit(PHYE_RESUME_TIMEOUT, &phy->phy_events_pending);
-
 	/* phew, lldd got the phy back in the nick of time */
 	if (!phy->suspended) {
 		dev_info(&phy->phy->dev, "resume timeout cancelled\n");
@@ -119,39 +111,12 @@ int sas_register_phys(struct sas_ha_struct *sas_ha)
 {
 	int i;
=20
-	static const work_func_t sas_phy_event_fns[PHY_NUM_EVENTS] =3D {
-		[PHYE_LOSS_OF_SIGNAL] =3D sas_phye_loss_of_signal,
-		[PHYE_OOB_DONE] =3D sas_phye_oob_done,
-		[PHYE_OOB_ERROR] =3D sas_phye_oob_error,
-		[PHYE_SPINUP_HOLD] =3D sas_phye_spinup_hold,
-		[PHYE_RESUME_TIMEOUT] =3D sas_phye_resume_timeout,
-
-	};
-
-	static const work_func_t sas_port_event_fns[PORT_NUM_EVENTS] =3D {
-		[PORTE_BYTES_DMAED] =3D sas_porte_bytes_dmaed,
-		[PORTE_BROADCAST_RCVD] =3D sas_porte_broadcast_rcvd,
-		[PORTE_LINK_RESET_ERR] =3D sas_porte_link_reset_err,
-		[PORTE_TIMER_EVENT] =3D sas_porte_timer_event,
-		[PORTE_HARD_RESET] =3D sas_porte_hard_reset,
-	};
-
 	/* Now register the phys. */
 	for (i =3D 0; i < sas_ha->num_phys; i++) {
-		int k;
 		struct asd_sas_phy *phy =3D sas_ha->sas_phy[i];
=20
 		phy->error =3D 0;
 		INIT_LIST_HEAD(&phy->port_phy_el);
-		for (k =3D 0; k < PORT_NUM_EVENTS; k++) {
-			INIT_SAS_WORK(&phy->port_events[k].work, sas_port_event_fns[k]);
-			phy->port_events[k].phy =3D phy;
-		}
-
-		for (k =3D 0; k < PHY_NUM_EVENTS; k++) {
-			INIT_SAS_WORK(&phy->phy_events[k].work, sas_phy_event_fns[k]);
-			phy->phy_events[k].phy =3D phy;
-		}
=20
 		phy->port =3D NULL;
 		phy->ha =3D sas_ha;
@@ -179,3 +144,12 @@ int sas_register_phys(struct sas_ha_struct *sas_ha)
=20
 	return 0;
 }
+
+const work_func_t sas_phy_event_fns[PHY_NUM_EVENTS] =3D {
+	[PHYE_LOSS_OF_SIGNAL] =3D sas_phye_loss_of_signal,
+	[PHYE_OOB_DONE] =3D sas_phye_oob_done,
+	[PHYE_OOB_ERROR] =3D sas_phye_oob_error,
+	[PHYE_SPINUP_HOLD] =3D sas_phye_spinup_hold,
+	[PHYE_RESUME_TIMEOUT] =3D sas_phye_resume_timeout,
+
+};
diff --git a/drivers/scsi/libsas/sas_port.c b/drivers/scsi/libsas/sas_port.=
c
index d3c5297c6c89..93266283f51f 100644
--- a/drivers/scsi/libsas/sas_port.c
+++ b/drivers/scsi/libsas/sas_port.c
@@ -261,8 +261,6 @@ void sas_porte_bytes_dmaed(struct work_struct *work)
 	struct asd_sas_event *ev =3D to_asd_sas_event(work);
 	struct asd_sas_phy *phy =3D ev->phy;
=20
-	clear_bit(PORTE_BYTES_DMAED, &phy->port_events_pending);
-
 	sas_form_port(phy);
 }
=20
@@ -273,8 +271,6 @@ void sas_porte_broadcast_rcvd(struct work_struct *work)
 	unsigned long flags;
 	u32 prim;
=20
-	clear_bit(PORTE_BROADCAST_RCVD, &phy->port_events_pending);
-
 	spin_lock_irqsave(&phy->sas_prim_lock, flags);
 	prim =3D phy->sas_prim;
 	spin_unlock_irqrestore(&phy->sas_prim_lock, flags);
@@ -288,8 +284,6 @@ void sas_porte_link_reset_err(struct work_struct *work)
 	struct asd_sas_event *ev =3D to_asd_sas_event(work);
 	struct asd_sas_phy *phy =3D ev->phy;
=20
-	clear_bit(PORTE_LINK_RESET_ERR, &phy->port_events_pending);
-
 	sas_deform_port(phy, 1);
 }
=20
@@ -298,8 +292,6 @@ void sas_porte_timer_event(struct work_struct *work)
 	struct asd_sas_event *ev =3D to_asd_sas_event(work);
 	struct asd_sas_phy *phy =3D ev->phy;
=20
-	clear_bit(PORTE_TIMER_EVENT, &phy->port_events_pending);
-
 	sas_deform_port(phy, 1);
 }
=20
@@ -308,8 +300,6 @@ void sas_porte_hard_reset(struct work_struct *work)
 	struct asd_sas_event *ev =3D to_asd_sas_event(work);
 	struct asd_sas_phy *phy =3D ev->phy;
=20
-	clear_bit(PORTE_HARD_RESET, &phy->port_events_pending);
-
 	sas_deform_port(phy, 1);
 }
=20
@@ -353,3 +343,11 @@ void sas_unregister_ports(struct sas_ha_struct *sas_ha=
)
 			sas_deform_port(sas_ha->sas_phy[i], 0);
=20
 }
+
+const work_func_t sas_port_event_fns[PORT_NUM_EVENTS] =3D {
+	[PORTE_BYTES_DMAED] =3D sas_porte_bytes_dmaed,
+	[PORTE_BROADCAST_RCVD] =3D sas_porte_broadcast_rcvd,
+	[PORTE_LINK_RESET_ERR] =3D sas_porte_link_reset_err,
+	[PORTE_TIMER_EVENT] =3D sas_porte_timer_event,
+	[PORTE_HARD_RESET] =3D sas_porte_hard_reset,
+};
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 6df6fe0c2198..61c84d536a7e 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -292,6 +292,7 @@ struct asd_sas_port {
 struct asd_sas_event {
 	struct sas_work work;
 	struct asd_sas_phy *phy;
+	int event;
 };
=20
 static inline struct asd_sas_event *to_asd_sas_event(struct work_struct *w=
ork)
@@ -301,17 +302,21 @@ static inline struct asd_sas_event *to_asd_sas_event(=
struct work_struct *work)
 	return ev;
 }
=20
+static inline void INIT_SAS_EVENT(struct asd_sas_event *ev,
+		void (*fn)(struct work_struct *),
+		struct asd_sas_phy *phy, int event)
+{
+	INIT_SAS_WORK(&ev->work, fn);
+	ev->phy =3D phy;
+	ev->event =3D event;
+}
+
+
 /* The phy pretty much is controlled by the LLDD.
  * The class only reads those fields.
  */
 struct asd_sas_phy {
 /* private: */
-	struct asd_sas_event   port_events[PORT_NUM_EVENTS];
-	struct asd_sas_event   phy_events[PHY_NUM_EVENTS];
-
-	unsigned long port_events_pending;
-	unsigned long phy_events_pending;
-
 	int error;
 	int suspended;
=20
--=20
2.14.1
