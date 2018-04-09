Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238744-2-17906605065470439615
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
    1523238743; b=AQRnowGXymKVY2+Xe9v/KfZOFnjs53xi+aGgI5ciyO/4f3+9lP
    zmZPOBll/L03o5tc0CoAetPO0RSSVL6mhR785ccspSn0zAw4ztuEoNQebwgnJFxi
    bZHzhgc2m0xK5fB8NFNFaBbbqHvxwvBK/xVSqBOgdrJwXZ1nqdOPED51N2uls2JH
    HvmO/S+IxsmhQQl/VAj9tJMQde2yjHrrwk+l19oui6+mVyUdWYCwzE5JP91hAPkT
    TesgHy/VVs2YmzCUDcsCaSFiaN5uMlcYzW5XMpxQOvb2in+29/0HIAvNQw9CnI7I
    +uS5h7nf8373tpgx97Ay7IEdqBEEdSuAZDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238743; bh=hzMZY3DaNp
    1nbYji6bW4VPw/geV/k1dXAuXCwXMydOM=; b=fNi/L29GcskpI8HQ/wpvnNMlYh
    i86HFdq5f63XtjwXz25LwjvtC1r51efksw4WCAUJdre7xpY7b3CElOi/eSGZ0/XI
    ZHfrh46a6LxzYyVTFpC1FB2ZJJIB55mgZU3VDMZCd/fdkrCOqPfgTOkwjHF93+u+
    qNGG1ezclQlcgrIDgiKCgI4od0kUmKWjAjpJMmR1xCFrktlFtsZSvFJolTtAM2bB
    YBbic+AtyHu4uC6UP9kfsnYX+LBO444oiEd17AapkXvGIh/LvNGPDpPzko1nH5C5
    Z+2lTuGnZEX9JuLGrmaBj5fo0HuLLf3WXWYUKepOrZxqoFWdii61jHAQ+rGg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PD6DbnXk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PD6DbnXk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/xKbwIuhR3gkuyGY/ZIJZ3hKw4iUc5ci0jA5dG4FPsJydUW1SAKPgH3J2H7w5Qxk4a7Ahv95aiyl5OsvsN/uR9ONGYu6QKym8Ni82plw892VD8c3+C
    njKoTdKLqncESmHudAJpZ1Q1lv4Pxep8UzCcPkfmsasrupzt9FTzgdaEpi7s0IPp2NlI00YuSs6+GOUXuBDcXS/wKVIFvDXi5EmtZ1xkgnysOhGYVf9gotQ/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=Utfb4SCxKVlw79s-hMwA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeDIBwK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:52:10 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:45024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932314AbeDIAdq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 242/293] scsi: fas216: fix sense buffer
 initialization
Thread-Topic: [PATCH AUTOSEL for 4.9 242/293] scsi: fas216: fix sense buffer
 initialization
Thread-Index: AQHTz5lWAfCMa5Mec0+j7LDQ0b3ueA==
Date: Mon, 9 Apr 2018 00:26:01 +0000
Message-ID: <20180409002239.163177-242-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:fCmh6uljZ2wRqcouWNXS5kNp0fH5PqRwZofrawLe8JaYDKoY7v9UuuGb18JIdAKvi5NPhJCF2kivI9t+oZtFKmCt8Hr2i4Y/yGGhJ9UezZff8z2REk+nWYFOq4YA+B1BX5DuNpB4rNPn8OICb1yXcF2SrWTKNBrqIyLp6LoGU+bRLYvhQjLD6HLzy64zYFSrJWpRU7dUEeVk5kb9Dmn9vdXPigLWQw47EuPg1PTtixdP9oxlbK8H3pj4RLPPesDW;20:ycYtFjhN8wzdwa+U9O+kAsCxVYgEB7hb6jvmXO4WE66MN/9fKYcuaxNoio/Lk8xFSMXS0ywAMwCoevXsLB8qPdkj5liUSulqAMEIwVwP2Jn+QmxTl+DxPm6QECq29oK1e6bDK9EJj53/DnSx5/KXeF9yJVqheM4ZRJQofORv5ls=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c66edbea-979a-40fd-f808-08d59db18b81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099804B2298ACD1BA77A9EA4FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: O6Zo/LxLhsnv0BKTawD1Euoq4+g8hcUQCHCGpNq+G0UH3fxSmCfN++n7jcFM3Hdj/sX9xkoNG2oFNrRSyxHEDDpX07IqryVr93FUDVbuPksB/PkHcnnbp9GYJjyCgqYwjD7PisrN9ewf77X4zGg9RFhdLvAmPuKP5BwDHnL4rE9Iug9AYTT6+6+yJnPlGUNHQrPsguH4NKFBPeBX2lbuosAZ4hCtUYRZcBR/768LSJS6MqCAXGnZvTx7235JMpBgaR/7drqTMmWIxd+brWDfLS6J7ai9eRrHUUbQgIIx35s+mPuARZBz6f5bpkMyzOmC3Fp25cOt5cYETIn9Wd2buP90b4DVk3Eu32wpUvNCzES5MkvvKiLVao/3ZHiCTLLEqIY3DW6D9aJZQv5Yq/jCNZCC3yEfqamrv3amSItiS9M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66edbea-979a-40fd-f808-08d59db18b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:01.7849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 96d5eaa9bb74d299508d811d865c2c41b38b0301 ]

While testing with the ARM specific memset() macro removed, I ran into a
compiler warning that shows an old bug:

drivers/scsi/arm/fas216.c: In function 'fas216_rq_sns_done':
drivers/scsi/arm/fas216.c:2014:40: error: argument to 'sizeof' in 'memset' =
call is the same expression as the destination; did you mean to provide an =
explicit length? [-Werror=3Dsizeof-pointer-memaccess]

It turns out that the definition of the scsi_cmd structure changed back
in linux-2.6.25, so now we clear only four bytes (sizeof(pointer))
instead of 96 (SCSI_SENSE_BUFFERSIZE). I did not check whether we
actually need to initialize the buffer here, but it's clear that if we
do it, we should use the correct size.

Fixes: de25deb18016 ("[SCSI] use dynamically allocated sense buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/arm/fas216.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 24388795ee9a..936e8c735656 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2011,7 +2011,7 @@ static void fas216_rq_sns_done(FAS216_Info *info, str=
uct scsi_cmnd *SCpnt,
 		 * have valid data in the sense buffer that could
 		 * confuse the higher levels.
 		 */
-		memset(SCpnt->sense_buffer, 0, sizeof(SCpnt->sense_buffer));
+		memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 //printk("scsi%d.%c: sense buffer: ", info->host->host_no, '0' + SCpnt->de=
vice->id);
 //{ int i; for (i =3D 0; i < 32; i++) printk("%02x ", SCpnt->sense_buffer[=
i]); printk("\n"); }
 	/*
--=20
2.15.1
