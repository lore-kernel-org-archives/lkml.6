Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236040-2-13567757734534884702
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
    1523236039; b=EJENNE/90Hvkq8/PGh4prMy6DgVkDYEAO2nbnDYnQiOUjy599H
    o9guUsyFfN7aSay0iVXI27J215347SY0h/YJGCLFoEE5OJl1A5DDp0VeKALko6bt
    ky2W90fxRoBJ93lrwHEv70l/YD4RpyKvNvdwgP3Fxk1Jd7PmauxD+U6PbxNqmDQY
    i0/gOlUAR06KUcA6zbntITWYZpf8AVaOoKxJpMDWZk9sRGp0H7usecNpAOc5NR4J
    hqW6ANk5o/S71wVOjDzChAblllHN6nWMqz4QMy/bz1ez1PpON4zplzBpfiVnJiTU
    tQVMf4xpSiv513d4k6NpyqRP20sJGYEL6/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236039; bh=eodKxzhQHP
    0yL8UNPsgczb+UI8j2GaOld+8Ia4PHKEQ=; b=DBRalfGpz3UM+ChJXubP92U10B
    gGIJnbzqt58/rlWwpoitMJL4dPNdWUDep9lBBfuYb3m8PnOmEcJejrJ6+qw8UF2M
    aA59evR0U9erqwG5Fz9RTgBTB5o2jZ8rMrhOzVGKP2nLCDu5cxwCHA8BO0rGD5tS
    Kac3NSvK8bmRwD28a+pi6O612v0DEmgnBHnFn2cPMpC1VXSXN48f0x88uOCKBmaI
    yezAlQAbQSo7ArcPRgfeKGsXeyiIaZOLQaRTCq8su4XzPomYqSbWIT2WMBgv7Ns7
    gOMV9/JBocyAKZAeix/m6WLhRSds4FuRnkXtq5T7TENsEdF9yiJZRjgDDM7w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lQoWsZXN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lQoWsZXN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEA0rQPLIVtIzR87WdtRCmKbHLumRgI5ybqwurPnE5Pt9exFAfEn54oeO7pH1fTa2J1xV/G0a03q+3jxXZXB1450g2jHsEGEBAbMhOQq03kaXKGCIKPp
    4OGMkyEIKQZmBt4TQoe3VBImrz4X6MjDTU8cCa1WnpVtrKrcY2pLtjB3mC6oslV4DKE37UipL5IoPby/vLwb7bsgmAUkIBU7qmAr/sOowrpYo5DOhjkBmsLM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=43XURk6w0g5GeypUxR4A:9 a=wPNLvfGTeEIA:10
    a=Z52K5TbU17EcDgFyT5Ki:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933090AbeDIAjW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:22 -0400
Received: from mail-co1nam03on0120.outbound.protection.outlook.com ([104.47.40.120]:40064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933056AbeDIAix (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 150/162] xen/grant-table: Use put_page instead
 of free_page
Thread-Topic: [PATCH AUTOSEL for 4.4 150/162] xen/grant-table: Use put_page
 instead of free_page
Thread-Index: AQHTz5nc6UonNFYcZUCJq7k+/UfB9A==
Date: Mon, 9 Apr 2018 00:29:47 +0000
Message-ID: <20180409002738.163941-150-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:V1fZiwUD4SiprcluA3muXdl6ol2i2R8TtSEK7fpNHKF3PDloyCSk45CLFdsQnG/qsMqM+DmT3mJf7kWajiRcOfE3QJNCnMoCEUUAYESoXBZK6wve+GqOYjeQ8G1KyZNHZtSRvVmRJFL31MsKJHfppRwqeXOwVixkmHG3fS9ICeqpYwfYcvUwl0UU1eYLioSQ8vnaoY+SlaxHc23n1njO5wqYG1+3D4qh9QFgCdu5QMqjHETRvWGnxRKvnvlEmlUw;20:vp5kC7Pjw0E1tzy3L/O1rMccaCcJCa89XDQPh6+x1IkxDX5D0e3jIDqwHzEbOFx6ATgncQXQbnj4BDCSp/6QHdtWyXwr6Bpx61USbljeJHSWGJyuAPFhHpZVeuZvweIgkZLUe+F0AAg6dux1ddIGbD+BYkb2CEum65spOekkLbE=
X-MS-Office365-Filtering-Correlation-Id: c120c768-3309-40ff-d063-08d59db241b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112534F07DB2DE80FA11C34DFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(8666007)(3280700002)(10290500003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yQ00DHDExdkeP3/00nR0BYI8K1i1dKTfctiyahXeCpdeuQ1NNe6FWJciwGjOKC5BDVWkZbq4Nd/D9GWfOosPgh7HAuoSG1FFxXMMpRgtjoKo1DglNnz2G70OcFygi0ArwWowyyDnV4Z9/AznUuGM5PX0M9P5KXHt+mkyN0TzLrz/OP6/wbk65/mgR/yhcGxtxTOZxinnWaIb5TVwQlzgynpkGAGEK7VBtH+M1rD6h3k4HiI0jm9lIcWO1yMPNq/XlGCepdWrjNZBV4Dx5zEhjbbpEfjyrl9s8cWNjPLM767Z9cYnvaR/OJvYHXrJv5/Z3kz7QMbfk5IWRrVF5QI3xbf4w3CxuN95nssTMGt6bfqmEtkhzwOOnpwIF1uLmLF1As/bbsYH0jeEbfLnW+g6TPTkGAWeSYtbXx9u6i7lEz4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c120c768-3309-40ff-d063-08d59db241b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:47.0214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 3ac7292a25db1c607a50752055a18aba32ac2176 ]

The page given to gnttab_end_foreign_access() to free could be a
compound page so use put_page() instead of free_page() since it can
handle both compound and single pages correctly.

This bug was discovered when migrating a Xen VM with several VIFs and
CONFIG_DEBUG_VM enabled. It hits a BUG usually after fewer than 10
iterations. All netfront devices disconnect from the backend during a
suspend/resume and this will call gnttab_end_foreign_access() if a
netfront queue has an outstanding skb. The mismatch between calling
get_page() and free_page() on a compound page causes a reference
counting error which is detected when DEBUG_VM is enabled.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/grant-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index c49f79ed58c5..4b7ce442d8e5 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -328,7 +328,7 @@ static void gnttab_handle_deferred(unsigned long unused=
)
 			if (entry->page) {
 				pr_debug("freeing g.e. %#x (pfn %#lx)\n",
 					 entry->ref, page_to_pfn(entry->page));
-				__free_page(entry->page);
+				put_page(entry->page);
 			} else
 				pr_info("freeing g.e. %#x\n", entry->ref);
 			kfree(entry);
@@ -384,7 +384,7 @@ void gnttab_end_foreign_access(grant_ref_t ref, int rea=
donly,
 	if (gnttab_end_foreign_access_ref(ref, readonly)) {
 		put_free_entry(ref);
 		if (page !=3D 0)
-			free_page(page);
+			put_page(virt_to_page(page));
 	} else
 		gnttab_add_deferred(ref, readonly,
 				    page ? virt_to_page(page) : NULL);
--=20
2.15.1
