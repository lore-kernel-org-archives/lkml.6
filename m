Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495654-2-1981308350754514555
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
    t=1521495653; b=k2RFzZ/6+l+hGMghl+nOlTKVzsTaBbZHEqnj/ssDH1TJ2U1
    IZGO8d/oCxn1GbjyOvpjLWli1AIv4APuQJVAKILLLGS0z35/i9nDFWEEm3cnnKdW
    6OBxtG7ff/iXNnBmGRXDurrDzCfLkNwX+J3S1kBBttsb36lED9g/A2YVJWgPnGgg
    q8gENexyBPH5MSTpjvmPOZdBQNhOna8NLjc3IAwDuMN0PZ2ec27Y2hffYLrIzM7u
    ol6yAjercLfz54BTsiQdLG/jKooxctsyqGL5H+mlMan0F1TsvsaiOM0NCyY3l+EB
    mHdbRgNRn38celOq1nQ73GNvNzfT7Abj1AN/3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495653; bh=KKeskM
    tNF/LRDZhs5L0C33TJkhd/1UVwkBIz6+pUUic=; b=ArS5/DOqIpcoNa+GEkLtiJ
    VvONfi4Gr+jrsP9D+jP1LWkj4gagXlM4IyRV+LfIkGP4Hm6wn99uaE9PL1q524Tf
    wu89j5UeAE4sP462JqaKdyHEffwjsPWZDwEEx26zbeeUy4iWM4sJecgmKSSPoVkv
    LUeUUsBbUkznrH+PGTEw8Zw9TR2P1cABekcqIptda8KKLwG15/VltP7TLN/H5MRl
    LGoGPqAUj4oIDriuixs9MYXc+RWklFE4AkVWbk0eVVfzq3MPO/pmcWPhHYWcd71F
    G/l/V8RCRRROoiewJShuOI3fy3dhT8qovgtil8k95S9Ga9p6V2cYHsmylc6ixbgQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bICNPIdF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeejudenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bICNPIdF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeejudenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965035AbeCSP7H (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:07 -0400
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:14025
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965026AbeCSP7F (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 035/281] scsi: sg: don't return bogus
 Sg_requests
Thread-Topic: [PATCH AUTOSEL for 4.9 035/281] scsi: sg: don't return bogus
 Sg_requests
Thread-Index: AQHTv5sgj0UsFuZmMU6hqyp07sY00Q==
Date: Mon, 19 Mar 2018 15:58:31 +0000
Message-ID: <20180319155742.13731-35-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:CxFXyhzYwzbXkatQLak/a3D1zecQqMVfpD1L0H2OWEqdxcnDzacBiDuPjCcSVzASqz5ztuaryLwaxubFhhmXWoH6PlH54dj1cHueBCFXa+HY+cnJEdvoZ244ZnDsf9f60VU8gwgb6fsg82zewKw7XYUhJMlf01out+iVShW4cgnCrBvARaLxrcD/WmnAb8m/cQeX2yJTIOkmVG8MwpLmZREVAXNFthMdWCoP0vS0krxDlj+Jb9cwJ5NC1JhXYIMY;20:JISvHGhxsGwSfuFPOO40kYekQ7lp7JQV83+0edi+AG5fLWDcVe6T1FNynCgt3kDNB+J54AMPMqR6mRJNSSbnV9XGRWp/MZAW8DZ/rrgOmudSavhncdFofwbClXOzhe3Ms+NzD2MnabutdBmKl8IXEYa/t9p/HZOmQtgNOIN4dfs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58332284-07fa-4a5e-d2fc-08d58db25433
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726C4EBA5CF47CE2D887466FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(6666003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FJUPH6146kA+b3+3iDZrANzCQ2jDukoQ5FYimv+yYtEcOFldPgzJRq3XF8q8bMvJ24nasgKFYAyw2icYshPeo/XmtgYIAWZnQXTtL/5SEcOdnIng6JK8pm40K2S9imWvKQj0S5qcK/HmI99HURokbAD8FhSH/A+rvufcVjk+9l+ar97COk8/bAlYMmhmyQkDgc1vFlmU4NkkdOXE8E5pnbf/o++FarSPBdVzUBVJc0tD4gitOqPCA8yznaqBJcQOq7jnJUt8EvtnC2dSD4H7fkLIDSocF6H9K/Y8rc/YEvHaA1ExsFjBuypOK9JcAPO+9zoUvzhEJrprsFd/AVAM+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58332284-07fa-4a5e-d2fc-08d58db25433
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:31.7827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit 48ae8484e9fc324b4968d33c585e54bc98e44d61 ]

If the list search in sg_get_rq_mark() fails to find a valid request, we
return a bogus element. This then can later lead to a GPF in
sg_remove_scat().

So don't return bogus Sg_requests in sg_get_rq_mark() but NULL in case
the list search doesn't find a valid request.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Doug Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index cd9537ddc19f..aca0c1659041 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2062,11 +2062,12 @@ sg_get_rq_mark(Sg_fd * sfp, int pack_id)
 		if ((1 =3D=3D resp->done) && (!resp->sg_io_owned) &&
 		    ((-1 =3D=3D pack_id) || (resp->header.pack_id =3D=3D pack_id))) {
 			resp->done =3D 2;	/* guard against other readers */
-			break;
+			write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+			return resp;
 		}
 	}
 	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return resp;
+	return NULL;
 }
=20
 /* always adds to end of list */
--=20
2.14.1
