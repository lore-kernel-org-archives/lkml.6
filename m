Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683563-2-7318894709913765691
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
    t=1517683563; b=mMDTW2SD+ulDiREXmfVJOhke/jXYOVYqlg1MlIIwWeczXYv
    llYeV7GqFwf/y5SeigXModGLDcBj8RWNSNss77RXqgtb2jAw9KD6oJJaIX126FI6
    Uy23sqn9I5qBHPm4mlrEzDZ4qMrbmBhrzwmaNB7hTYykwB2FdW3maUXAFpwLQPfi
    hMx1Rha3ZgQtm1q9dQUBCOaFrIWQdBoiafFaC+x0qEQw5cJ8ydk1699/fNUVCBOO
    esI0FfhDr1U5gGvyA5fbPcjSzXeG67gE8zficpWzNWphImi6kCrQ8LeWqekvGJpL
    GAQhOqq6Un7+YBswYQVFl5c14VMQKX9OVKMjxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683563; bh=RSo/h1
    imGFx9Vec+Gd4ivG8nKZzDITUnrXFUlpORJcs=; b=OwC0lUuKlWJPVgi13wGZg6
    0xEEBLqZ/QA05xFCjwfduBGnnaKJFnkhqWyVLcshKp87oWBAOUnV6x4jA8cTMotX
    sCGQd7P4H/dto4TtE4NUjyVUviNpJoJklVGsU5U9+wkdJyGg+2hGbLFukwB+5Xlm
    XV6lmjHOadV7sNTxKhblGQjJQq3AXLpowHG/eVkg4CYAUj8xd0gJANZ6j8a3MVzh
    xuk0g8rl8zjfzSKVdOpaPzaOjuEpqidfLYrx6FKfESh4X71Hs/hM4nJmhZOXtMqc
    D/2rEXzPhk/pZBq8XMQj0cwByDDKFdfmT6bYoovfhyGtaYvEgsJLUEExo8B0dtrQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oVvPAkk0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oVvPAkk0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeBCSp7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:59 -0500
Received: from mail-dm3nam03on0124.outbound.protection.outlook.com ([104.47.41.124]:55488
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753087AbeBCSCU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Cathy Avery <cavery@redhat.com>, Long Li <longli@microsoft.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 047/110] scsi: storvsc: Fix scsi_cmd error
 assignments in storvsc_handle_error
Thread-Topic: [PATCH AUTOSEL for 4.14 047/110] scsi: storvsc: Fix scsi_cmd
 error assignments in storvsc_handle_error
Thread-Index: AQHTnRjtaDvB6YDa1kyObMLm+UGGhw==
Date: Sat, 3 Feb 2018 18:00:51 +0000
Message-ID: <20180203180015.29073-47-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:lh4plpcyUNu5uqaCFnu0ARj3D5XrkE+cN8CRyvBphvZA/7SaA4ilBgf8AQx4Il09ffP0YzJLIKOP6G4O3R25U5klPHSgKenstFU/LUm0tWYK4oP7Uk4CgfNN7/YRqpH7aw4zUj8Zyb6fi8BmkO1j8vwmc85NJRTQrOeODo4i0IGt/bLUwFTgVdzfDJ8V+U5dHYFKUxkvDtp9t438+vG/5MWODb57w4ekb+wxWsH5qnYGD78w1+de+UH/CCk0bc9u
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b561b48-b32e-4966-347e-08d56b302430
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB1092EB79548E78E9B0DB6685FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: cf7ty6TY+3Tk9k9djRxjLUpPi8yHsmbz1x2bX78bUe3Gmr6boJWuvUwE90vKojwX4eAHA5r/Crys44F8mMdB+Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b561b48-b32e-4966-347e-08d56b302430
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:51.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Cathy Avery <cavery@redhat.com>

[ Upstream commit d1b8b2391c24751e44f618fcf86fb55d9a9247fd ]

When an I/O is returned with an srb_status of SRB_STATUS_INVALID_LUN
which has zero good_bytes it must be assigned an error. Otherwise the
I/O will be continuously requeued and will cause a deadlock in the case
where disks are being hot added and removed. sd_probe_async will wait
forever for its I/O to complete while holding scsi_sd_probe_domain.

Also returning the default error of DID_TARGET_FAILURE causes multipath
to not retry the I/O resulting in applications receiving I/O errors
before a failover can occur.

Signed-off-by: Cathy Avery <cavery@redhat.com>
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 5e7200f05873..91ff378a0ae9 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -952,10 +952,11 @@ static void storvsc_handle_error(struct vmscsi_reques=
t *vm_srb,
 		case TEST_UNIT_READY:
 			break;
 		default:
-			set_host_byte(scmnd, DID_TARGET_FAILURE);
+			set_host_byte(scmnd, DID_ERROR);
 		}
 		break;
 	case SRB_STATUS_INVALID_LUN:
+		set_host_byte(scmnd, DID_NO_CONNECT);
 		do_work =3D true;
 		process_err_fn =3D storvsc_remove_lun;
 		break;
--=20
2.11.0
