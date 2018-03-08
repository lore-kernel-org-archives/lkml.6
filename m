Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490741-2-3896434110757886122
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
    t=1520490740; b=qJsN0iyniG8qeikDJJCT9IO6AYbNBuWmhRzs5BZTYLCofFU
    nEu0tXJ8/CMaTfW/7yklJxVGLrrplaOKRW9ZlJGVFT1oODfWNHS4vKvBgG7Sx2j1
    7K5RDtAPGRrlp4/gmdHYeI8cKBKB4GBknJuo7YrdRthQkFjyj7Gg/Er6Sr7hUXva
    hLqnlW3IuGFxJGZNt91QuUB+p5aMsObwcj6Iy/Kc5QLw1cKNczlqILZq/Ifa4720
    UDLWRTSA43t6p7eHXgOBnDuSws65t5ozNTS4bHeOlI4fc0qiLo6RI9vK9q5yp2Qf
    dHnboP+N+7vH1XFAtoqkvVKJAXjYYxi96PqlfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490740; bh=39/Gbw
    HUt23t9BhaEjrHVJ+zPBha8pGGyHl4jCn/cBw=; b=gl2uHl9iCxOMuhcSdzSR5b
    LLRDWWinNqJyR4O4oZPrQMEELFwXRkSRfVc+935kcol5zy5kMcwRJ1BYQfk8lxio
    9sKhzY8hR7W4V8YsJ+QiUUgQZc/6/cP6YPD5r9X4ElWHD4TFYfSbs8/Lsw5ofteo
    9b5qWn9Z1fTDdpZ4Xu0vsMXXA6ly6g8X5SVe9scZOWrkbt0xK8HdWmxCRu1zVT2m
    HcqrmoplCV2+ftfLUHT+Zix6gpYrXRGSB/RVfaz3KbcWe8bQoh5vFBwlQGz2u3U5
    IseCDKWbOnJNmOUuFkXf6AaT3eFC6jt4e3QimlVhTQVdLFI/TEQYmMM6NF4fnHog
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U/n8Txe0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U/n8Txe0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934942AbeCHGbT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:31:19 -0500
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:7440
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965473AbeCHFAF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 010/190] scsi: sg: check for valid direction
 before starting the request
Thread-Topic: [PATCH AUTOSEL for 4.9 010/190] scsi: sg: check for valid
 direction before starting the request
Thread-Index: AQHTtpomJUjAEAdfHkOCpvVojRGzxg==
Date: Thu, 8 Mar 2018 04:58:53 +0000
Message-ID: <20180308045810.8041-10-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:TzfAXZl8fH1acgtC9BSjUKyLPzqjO37q8cznVOFBxsXWueG7JaMoIDe8bOFFFYcKVgykls0TxCq779r7InvkASiNU3ylQMCPBjlf/abgzEeqkVMejq5IJmuboe0eG5re7jdN4vWbxqc7BKVrD9zxOcki+qyIRJv7T/3ZakikYXU4JuHGZjHvoICcmPolcqn83taPin3jAoYmz/MtiyEd2a4/8By5c813/Wd3kKrlaCKmydVLAELbiToOm4+NqxRQ;20:vvNhJtVkqPmtDdM1cd0pMuKxt9antuWVckWTR8E1Mc5uoh2LU/RUPjLW97TsAfkudb1cn4fc/TGpQsR4U6yYL3PBHryanXw0BrI+eDXI46l2uq1Ojv/yVERxL+PcwXxwH33KpE/IsqQurjYUVejVSAjGN/kBN34iL4hrI09+UPY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c705342-b63d-4e12-6217-08d584b16f35
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920769D0F7B671E4AA90918FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(966005)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6116002)(3280700002)(3846002)(86612001)(6306002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: uRB37E8af0upWfx1kfw09hcexFj+zM/GKbSjXXHNIHPC7Bf47jaM3ON8P2faiY+4/kOLHyFMshqL1wwvbJRt39pV81H0kuy/kSCpgOM7JQGZEYcHnmmXY28HIAMIZGVg2lanBJ9XPJZHfWr6006RspiPdlJDMLpQ3I4p0pdrOPWZ7qPBs9tmO4/uW9Q0Rm8Rm1DBYc011qDw0XZca6fnr0hjka24lOEiZSKUKMxdRlQ7SniL4Z6b5p7MF07oEKP++NPxdU3z5xzpGJP4Kz3ei6kXBmvL5juGZXf4IA9MFWAK60wQUj/s+DtNwl68hQOWECfAw7SD0k/HIsFoMBKyCA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c705342-b63d-4e12-6217-08d584b16f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:53.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit 28676d869bbb5257b5f14c0c95ad3af3a7019dd5 ]

Check for a valid direction before starting the request, otherwise we
risk running into an assertion in the scsi midlayer checking for valid
requests.

[mkp: fixed typo]

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Link: http://www.spinics.net/lists/linux-scsi/msg104400.html
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sg.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index cd9537ddc19f..6b6064dc3467 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -663,18 +663,14 @@ sg_write(struct file *filp, const char __user *buf, s=
ize_t count, loff_t * ppos)
 	 * is a non-zero input_size, so emit a warning.
 	 */
 	if (hp->dxfer_direction =3D=3D SG_DXFER_TO_FROM_DEV) {
-		static char cmd[TASK_COMM_LEN];
-		if (strcmp(current->comm, cmd)) {
-			printk_ratelimited(KERN_WARNING
-					   "sg_write: data in/out %d/%d bytes "
-					   "for SCSI command 0x%x-- guessing "
-					   "data in;\n   program %s not setting "
-					   "count and/or reply_len properly\n",
-					   old_hdr.reply_len - (int)SZ_SG_HEADER,
-					   input_size, (unsigned int) cmnd[0],
-					   current->comm);
-			strcpy(cmd, current->comm);
-		}
+		printk_ratelimited(KERN_WARNING
+				   "sg_write: data in/out %d/%d bytes "
+				   "for SCSI command 0x%x-- guessing "
+				   "data in;\n   program %s not setting "
+				   "count and/or reply_len properly\n",
+				   old_hdr.reply_len - (int)SZ_SG_HEADER,
+				   input_size, (unsigned int) cmnd[0],
+				   current->comm);
 	}
 	k =3D sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
 	return (k < 0) ? k : count;
@@ -753,6 +749,29 @@ sg_new_write(Sg_fd *sfp, struct file *file, const char=
 __user *buf,
 	return count;
 }
=20
+static bool sg_is_valid_dxfer(sg_io_hdr_t *hp)
+{
+	switch (hp->dxfer_direction) {
+	case SG_DXFER_NONE:
+		if (hp->dxferp || hp->dxfer_len > 0)
+			return false;
+		return true;
+	case SG_DXFER_TO_DEV:
+	case SG_DXFER_FROM_DEV:
+	case SG_DXFER_TO_FROM_DEV:
+		if (!hp->dxferp || hp->dxfer_len =3D=3D 0)
+			return false;
+		return true;
+	case SG_DXFER_UNKNOWN:
+		if ((!hp->dxferp && hp->dxfer_len) ||
+		    (hp->dxferp && hp->dxfer_len =3D=3D 0))
+			return false;
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		unsigned char *cmnd, int timeout, int blocking)
@@ -773,6 +792,9 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 			"sg_common_write:  scsi opcode=3D0x%02x, cmd_size=3D%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
=20
+	if (!sg_is_valid_dxfer(hp))
+		return -EINVAL;
+
 	k =3D sg_start_req(srp, cmnd);
 	if (k) {
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
--=20
2.14.1
