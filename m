Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683921-2-2172841041826006418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683920; b=e/4IjJtEprsp74LRBMzyTmFUCb+YLqPFx+ISmAzA80HnNHE
    xixCjSm8OzT6eFaWcn+41x7UZCk/CLSWKszey4htVpWQfHp0LXdHQtxK9s7lW4N9
    jSt3vyNefbZhEP2XOIaVWBXsWaEO+kYXWH6xl2tUPn8ZeNGdg7MLqMO1iufDR8yc
    /s+gTb//IIXT+pmzZjGMzcB8q/h72njfHjJ9JH6kJFQn/KWMxPN+HIa/0UcPN3GQ
    RLa2TxMpmwdliVUNk9UaIuS4pMpIXjwugcFIv4yK6OwGyYLxidURpAYju3jTMSDB
    UE6LXencg6I5ElBpF1TNL8z8UeF09fAJzdwrVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683920; bh=u4/QCJ
    LjDkOEdQhojky/xf2JJAPxozBPW1reDsNpwi0=; b=YwPpH2T49hT/b4UCLnLkKZ
    7f0J7nbE58fKfjze1sQ/7g3WCpTXAqWA0NsshSbVTtaCaYcDf8UNTTqBKpIHT7Uu
    34cPECtRlOG88za1GeFatwkyKWkTfCkeqiDj7vUBM6xDZAjgFnx6KeVSnd46OhXc
    hKxUPevQsrnHWpHJF5xuvt2ueLGWtE77CrhKo5hbG7R7caJPHnjB9kqc/Sfj4Sr3
    Uvf+2d48oEbT9FPq4TYu4U0rgwZa21igzSAlf7Iw8/+IugMDCqK6QUr7Mh/ulz3G
    v1ENu+IbdBpNpLIXibwoZpl/3YM/GSiJdMzVN4d+/+bDrHtpCbix54YUVZ57iZ8g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MGeGks6R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MGeGks6R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeBCSv6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:51:58 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:35168
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752838AbeBCSBD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 024/110] scsi: core: check for device state
 in __scsi_remove_target()
Thread-Topic: [PATCH AUTOSEL for 4.14 024/110] scsi: core: check for device
 state in __scsi_remove_target()
Thread-Index: AQHTnRjmsOcnDB1qIkKhePoAB6WrTA==
Date: Sat, 3 Feb 2018 18:00:39 +0000
Message-ID: <20180203180015.29073-24-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:77zdUZ1lDhtp8+Tf8kZXao5nN6whxcJX76s1AWueGIdA3RDJy9P3WOnqvJGoeS9aac5W4+HJ8skMbD3PkJlI/1rfS1HwGSXnpwMvxS2hdgTuum/JX/pP2D/5guz/h3UWlno2t/kMjhx/C0v/AUKZDNp/iSXhrD2eEoVICaJOCphSYVaARBZX+q2M0/Jc9KCyEVyYDcoL4057R1UrC2SjET7mvIPCUkwz2PmfJEzz8lslSZipBhGdNTkT/bWEKfy4MdZvD0Nbdoi20MCiKtlT3vRiL5PCsoNk6aBslcX6and6qKxCkbORpA2bNbMlD1p6kKh6DdgOw59QLTLND78e+ntoJ8dJSDohcoNGiB5qtu1qmXM56ayIXqZq+/J3yjlt;5:6CuPIkHeMs8brbsBdraumyNLuoOG1Es58n78F9qtbDiIWOsRvIedvV2gMSginEQq9Zn+jZB/li2fS+sfhad2fmRl0u2HmVC3GFa6Hred1/ZemFNMxuVjVT2ksoiMPcfWoM5j5l7Dj9wKxHJ1+MB8qejaY3g8sLDEC9e1eT4tld4=;24:CvmoaURNm9NMQu5k6DryK5mTa4SG1tXGQ1vrtPrcplT4XoFNBzMthYWSBKTXw5VRxkV78Z5+Y1x/3OfqShH9JVZWJaB3yRBcbpSkVpybN0M=;7:J6dAyoLdi28395JRyI23Z3WjqUjtu1aH2RMiaOaTth2bPCxDzBsp6SRPXb8nZkag4pN3cRhFiQW+gi6AQx7PYtKonVEC33tw+gFaD+HwbRW7FEp/eg1NilZbGJMnMS0dR1nop9BFsaHIWLXL5pxGQpmdMZ3vq5+5biuy/2h4IGYBeQSNpGR/dbiWdD3xY7zr4+INzJMLpRPuMnqSOzwRsMtNnHPAwHw1Df5lcg8ltJW2/yGKmRrtH0CrWwPdxOYv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53145365-1764-4686-78b0-08d56b300a5a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090800B98EDD1890937DCCEFBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(575784001)(107886003)(72206003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: dMYwWXwIqG45cgfUvgO+LMNtKXrEiVDnbgyY9MwhuM8Lt3X+Ea32wtbgR7QirNDgluPxkPenoPSpLNsxVHyzOw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53145365-1764-4686-78b0-08d56b300a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:39.5346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 81b6c999897919d5a16fedc018fe375dbab091c5 ]

As it turned out device_get() doesn't use kref_get_unless_zero(), so we
will be always getting a device pointer.  Consequently, we need to check
for the device state in __scsi_remove_target() to avoid tripping over
deleted objects.

Fixes: fbce4d97fd43 ("scsi: fixup kernel warning during rmmod()")
Reported-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/scsi_sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index f796bd61f3f0..40406c162d0d 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1383,7 +1383,10 @@ static void __scsi_remove_target(struct scsi_target =
*starget)
 		 * check.
 		 */
 		if (sdev->channel !=3D starget->channel ||
-		    sdev->id !=3D starget->id ||
+		    sdev->id !=3D starget->id)
+			continue;
+		if (sdev->sdev_state =3D=3D SDEV_DEL ||
+		    sdev->sdev_state =3D=3D SDEV_CANCEL ||
 		    !get_device(&sdev->sdev_gendev))
 			continue;
 		spin_unlock_irqrestore(shost->host_lock, flags);
--=20
2.11.0
