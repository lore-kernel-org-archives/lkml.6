Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680848-2-15447061589511292224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680846; b=K0v7f/9qbDVG578HYmzNbjhuBexioKDnF/EhyKPHEge1KXj
    2oDeumDIncVoGVn+9On1j5E+A6a3TXJeYYqaHghgySjkEHi5UAf5azD8dPqAVIAG
    A5KxOn+oMROEB48G63CMkdkkJv71f/Nyc5QbKuZw24ZxYT3IrMfHQqfL+HmdX9zV
    R/uQSZLe4eYqN9K4hOFvB+73Pe0qKDU+lvyqrrlMUyaenNYg24ohUjSa1bIIwhGf
    IBxRZas1mpjTvorAYMX5molw7VvPqqqr7oV+0xS0P5YhE3EZSDdchUy6gpCQCxhf
    M3yBiOihySW1xp6DAKW5r47lL8V/Vryvh7YCXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680846; bh=TS6pUh
    KF1HHsWCdH4b06t0BVZzoh8QGABmkZb+n6Jfw=; b=hdylj1PJpRips4tf2zKu6E
    Kxyiv0h4unI5T8306kV6A15/z+fDTKEFVVcNrAY3/o9Ohcvs+7q2TPEBiKleVRyP
    066Rg28gNliTVOQYePbc5aqvAKDdl44HeJxZmq4cj0MysgFkjjS4mHNYawzW4DZT
    ZIhKidmQVIfjaP3Os5p168YMVzzd7i1xZiRn7McLFVAMX8SKT85eY1EbW83MqWgx
    vyI3EMdzQn7ughrZHtj9d7uKoQIv99wXziPyQgmvpYKpdZCI1a4gtrihP4AIXC0b
    wqhlLOVTJ1nMcs0Ry9KpWXq5BKthAzc8CffM/82SfIkCfXCKnhBhrDh/O31qmPQw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zb9YUCD2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zb9YUCD2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeBCSAg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:00:36 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752538AbeBCSAa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 003/110] mm/frame_vector.c: release a
 semaphore in 'get_vaddr_frames()'
Thread-Topic: [PATCH AUTOSEL for 4.14 003/110] mm/frame_vector.c: release a
 semaphore in 'get_vaddr_frames()'
Thread-Index: AQHTnRjfdOtBMkTpwUi+kJ9BH44k4w==
Date: Sat, 3 Feb 2018 18:00:27 +0000
Message-ID: <20180203180015.29073-3-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;6:rlAy0YUOAIAeday04WWn3JLgl9bxZUg2BZn71oF5u8hGtO0XTH/e3rjRzsOQscNL0RcMBgIK/XXTXcDWdbVIMxZwvawze873LJ5h+MNrU4m/on1Eqa9lSXz85I4lNWN88oMbH6s+ytz7QVERReFCkwjktLkx9W1l3xPIlItUeSIyrIucs0BHzarrbMnXoUoo0Ti92UHkLjSXmWed9f2K+OcaAh6ynbd6uek0KDyD6CjGrLKeFmY8VJAd6UuXGZdxGbiti6hOQpExoHiDRWcXRkUbgjru+FqGYZHelIdZ4lZwkhhcpi7CdsD2w7l/E0WnQOij7I7yCkp2Qtlzj/QXcEj0iRWB4ypraN6tODkSK3evWrtBG7IT4PPU7CenFbnm;5:4XMUhUJOFT6cXnT3/sPDZab3JRWKY9GhOsASK4hFHcbnQVqwyV1rNo9ESOIrFnFekGSJb9pgxe+Q0yRjT+LaimyZu7L4qdkSmfqMGMMc455Nm1nvgbm70adGr4HpRPSAFtTJ4uuNY3H1UgOwDDDEFvgrRWFNHPZw40nP+LzA9mU=;24:49wyCs3fmRrKgxlom5p+hPUtXJHT3/Kf7QxG3kMDz284MWtGSAqKXSmS4k8NzG8jPMdN5dKzB0lIewpcfaNVOfw5b8DZW+9QZt4UGqFCSi8=;7:3pmwF0qNst24YX1+hRdZ32ZSmX6wXngefbZCNVoE56wkEp7T2R1iAYia227+0z6PXfUGibiyVHM+fcH+MJyc7a1zY40RsdZvd09wV1eZvevTf89zaXwAbcLAz6JCSRnSHEJq7E+2HZ0ON9gAgon0EfeinD7kl9A4jNiXYbsXQpiH59SsFlj6h3/E/nCRLN+BV3fjBxX4p6gxEfSn97VBFRTp9n4nNgZgrbBb2JTUbXxkwftAC3o4DmWhlNXXDZEW
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6306002)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(966005)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bae1efea-503a-40c5-39be-08d56b300240
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB10438FC5DE6FF9E63F7374B9FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(155761271638844)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: V3gIr8iKnCZfH2zjssCVQntC8cmN1tL1YtX2ff2ml3VkuOdyYZr0mUhe3juMUdi8o8IaYQUG6BKJcQItWiCNfw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae1efea-503a-40c5-39be-08d56b300240
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:27.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 1f704fd0d14043e76e80f6b8b2251b9b2cedcca6 ]

A semaphore is acquired before this check, so we must release it before
leaving.

Link: http://lkml.kernel.org/r/20171211211009.4971-1-christophe.jaillet@wan=
adoo.fr
Fixes: b7f0554a56f2 ("mm: fail get_vaddr_frames() for filesystem-dax mappin=
gs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/frame_vector.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index 297c7238f7d4..c64dca6e27c2 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -62,8 +62,10 @@ int get_vaddr_frames(unsigned long start, unsigned int n=
r_frames,
 	 * get_user_pages_longterm() and disallow it for filesystem-dax
 	 * mappings.
 	 */
-	if (vma_is_fsdax(vma))
-		return -EOPNOTSUPP;
+	if (vma_is_fsdax(vma)) {
+		ret =3D -EOPNOTSUPP;
+		goto out;
+	}
=20
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
 		vec->got_ref =3D true;
--=20
2.11.0
