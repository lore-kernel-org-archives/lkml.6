Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517680929-2-8903045275250273723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680928; b=iIYwE/ImZOhbG6n9kUUEX98YdVFN5rhtT9Cc1xdDlJhgPkh
    GP0H+dvcxBDsiDLBhL9Qdz94O6O73u+19ZECMwgBfWUImjVATYUJkN5fSrlFyMlB
    uc3vretgDBpxVqp/++4ciGq97G9G6baJ3ME/t59GEf9NW7K4vue95qOZ7IKLGQrs
    dJpC66PxiZKybEZBazLidNjPsYo2reXPtwVVTzrqnjrgqTzODMRPrBxsDDeWAkL6
    deFo7FF+HnZsMv37lty6J8O4wnLv1d3GYWc74rKr+5N9gMqA0xCWS6BwPyEubvsz
    jAMsgCTZOdVJGYWSi0fVS9BjeUHXOiH7opMddZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680928; bh=00OYx5
    So+3yzfb0XcCJ+JkvwyVjZs4Lgf7Rft+4ohyY=; b=qQgi6vPcA2VacvDLQbJy1p
    fnN9at1Tj0bmHMJpHQYPHmbBJYZwmt4R9RwYMd9ayjH5HJLZ6xOK9KY2MEpKlLUG
    eSQaWg+v9jE9uNFR4OEhmuLaVah+GGtXdg7e9w0IAghKcgQ4+t1Cwv8hC69xUzMT
    Y4LNTrBOkPALEnkk1y/c71xsqYhXvF71Owcax+fSJyA8RAEpGgJfufswocLkf1Qv
    JyMEJx9IS6nBa1GcIcQ3vTsFrTMBGr/5xHd6p/WZQvBi02+y6DJQStkPudyA2E1c
    QclwIi866snMgtj2eBDq6Aik33JKrpXqGYghX5XcgFhreJKkYQRsVa8mDb9t+v1g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fq3QpUql x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fq3QpUql x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbeBCSCF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:02:05 -0500
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:24267
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752616AbeBCSAc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Prasad B Munirathnam <prasad.munirathnam@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 004/110] scsi: aacraid: Fix I/O drop during
 reset
Thread-Topic: [PATCH AUTOSEL for 4.14 004/110] scsi: aacraid: Fix I/O drop
 during reset
Thread-Index: AQHTnRjfz9sWhzXm5kqXVm0tiOdZEQ==
Date: Sat, 3 Feb 2018 18:00:27 +0000
Message-ID: <20180203180015.29073-4-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:s4t5qC7j08ez8xgurhnaWa1Yqd1UQE5BkRcJMG0RJC4DNBdxlbKD1xNgEenExh+ULJ30xbRrI9/FoTSCBQgf5BLOkpGuScSZ2bpfMEqQDAyIkuYdEYQomrUGJKGHF4bRWyeAyI1bozALE2YWNk5C83WeR+RLi2Uww/9UrTr7xTx9ArDSY1ftHQOdzW8kQxNMYkBS6NP2gCaeFAqs4p9iepBgKga8HI7cZ5ryvlWF/XIlW7lSzqy7QCVc1RaMb5Ha
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(8656006)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95854747-e12e-4bf5-a818-08d56b3002f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB10430BC374F407C4B8CF2C72FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(72170198267865)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 7aP7Tsl8MDyZ2UfOfT8JbSnPfJcCNLUSIsfILs8yQv7hMp6zCrrUFfUA0p8D06UvdJIX9Iv+AonjO1g52lH2Nw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95854747-e12e-4bf5-a818-08d56b3002f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:27.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Prasad B Munirathnam <prasad.munirathnam@microsemi.com>

[ Upstream commit 5771cfffdffe709ae9b403b6f80438ca40bf850e ]

"FIB_CONTEXT_FLAG_TIMEDOUT" flag is set in aac_eh_abort to indicate
command timeout. Using the same flag in reset handler causes the command
to time out and the I/Os were dropped.

Define a new flag "FIB_CONTEXT_FLAG_EH_RESET" to make sure I/O is
properly handled in eh_reset handler.

[mkp: tweaked commit message]

Signed-off-by: Prasad B Munirathnam <prasad.munirathnam@microsemi.com>
Reviewed-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.co=
m>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/aacraid/aacraid.h | 1 +
 drivers/scsi/aacraid/linit.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.=
h
index 403a639574e5..b0b290f7b8dc 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1724,6 +1724,7 @@ struct aac_dev
 #define FIB_CONTEXT_FLAG_NATIVE_HBA		(0x00000010)
 #define FIB_CONTEXT_FLAG_NATIVE_HBA_TMF	(0x00000020)
 #define FIB_CONTEXT_FLAG_SCSI_CMD	(0x00000040)
+#define FIB_CONTEXT_FLAG_EH_RESET	(0x00000080)
=20
 /*
  *	Define the command values
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index c9252b138c1f..509fe23fafe1 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1037,7 +1037,7 @@ static int aac_eh_bus_reset(struct scsi_cmnd* cmd)
 			info =3D &aac->hba_map[bus][cid];
 			if (bus >=3D AAC_MAX_BUSES || cid >=3D AAC_MAX_TARGETS ||
 			    info->devtype !=3D AAC_DEVTYPE_NATIVE_RAW) {
-				fib->flags |=3D FIB_CONTEXT_FLAG_TIMED_OUT;
+				fib->flags |=3D FIB_CONTEXT_FLAG_EH_RESET;
 				cmd->SCp.phase =3D AAC_OWNER_ERROR_HANDLER;
 			}
 		}
--=20
2.11.0
