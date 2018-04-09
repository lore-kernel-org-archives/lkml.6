Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233695-2-5644492399418765657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233695; b=R2FlgIHoZeA7kODmfl23W+7QxY7DOCDgI90TOOvI3u7QQcks8B
    jplRRfA9Jy5sdHyrn6QsFPN4S+g4/EOue1hmTCDxSCG+JcRsyRVG2w5s+WClGhTj
    GM+xX0M8V+OaU24Klf/1RbR0wqGm2rIhA7RHqNi8k5VxIF6Wg131aUZNKQrNMlKF
    0x0335p0nY5rWVVea32UNRHIBw/nJqJN/F4gymVZynaFxHzYltxNib+AfxxoIvVV
    WPIVoMab70xp4ZKUf64K4NZq9AiIMXJ4oUfga5c8qOnUuPZynHwso9+lCulLpHpk
    UtAwG3QXx7+Wu+lrI2OLqgtnedbfNsYNBZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233695; bh=LctEp1v5qL
    joRmWJISLg14Qw4qrxZvHSNT4mmxzoBCw=; b=GPw/BcuYV8ooq9lwHqI7Kn6Jb5
    yfhgnwSIOcX07REECm63rn6pftKHvMRo89J9IixxU7lueghkN3tTvlsrlsV/8PKv
    fve7EOIBAPMfECB5Hj2AgV+V0y+b5kEbyEZwbYVlxwjVM3l/FVUoLpGZQPEABixJ
    W4nXwX2tmvn/yaouoBbQcQs4CnfLUSoHxaETZkTqUMSEIRMPtICYfSyhVZp11sgH
    //Ia7ch7ejsQ4e22a3jcHNKiqRonJ53aPS3tCoWjuXj0YdQeqTCmExncW4ZMFLb9
    thN/QbEsWGJQ0B8wjIB40FW+HmFDVI5EeA9eXPkt1faGVkuJoSxCNMlBVD9w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RDT/L2qM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RDT/L2qM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdKp8hkuQy0ueclTf9O6Kp6HJmVELGbRvuOED6JDCoFtaYcEdCoGsMMljIjF0cJUK3K/i7rAT3nGAL2VeL+8Sh8jNoDIj18J7TX714nhe01jbPipvPc
    mclg+kgYpHNNaZKhlM6RSTsDwrIHQUZ/lSDGA2sDZCuBVVJw/vgXqhElYRSNdehV+bp2Wlni/p9xMbJTJ8RBACspriTOMr/ONWrC6e5Anqerr4xPxeUEcG+b
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=B-4895p5AAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=NseAPaqsQ_DdMo1T8_oA:9 a=wPNLvfGTeEIA:10
    a=CvvKU93EpHcLr5xCDv7z:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755747AbeDIA2M (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:12 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:15008
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754850AbeDIA2K (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 063/293] tpm_tis: Fix IRQ autoprobing when
 using platform_device
Thread-Topic: [PATCH AUTOSEL for 4.9 063/293] tpm_tis: Fix IRQ autoprobing
 when using platform_device
Thread-Index: AQHTz5kDYA/DaU1HAkOU1hiaTdk6jQ==
Date: Mon, 9 Apr 2018 00:23:41 +0000
Message-ID: <20180409002239.163177-63-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:bLs7VQIiiCs1YMs5zjE5eo020366smZbYwNgRBLm866sz1ikGvjkliRataRZqf2skfqnZ9A7J2PmFmzI0VCv8X93ZM7TCM8lIDbaD6ayyS7lry/EcEkE9t2TVVoXM90gTUqbxUvjcQzFtJp3UEEVijOU/Jm3C3UGfTP/yt3Au+3cSuCfRG04Oe+RKHj4KS1VapaqNZq51snSDz+hKgLPYGsrNzGXzRpKhlvx1IA9DqJcA78kJbe5xAge+xWpFKXq;20:ZnruUzyhNS0vrG2DferNvfP5BzS8RRR6fV/+ljmHL0AeJuU+QRlx9H62Fobr1klhjnS31jQfYItwTghlr/yXJijHt2ABsS8X5TtJS7KDBMYR9Zxy5hsMEXzApxaehHmvAA6J6a37TPDD+IlkNibS71MDjq4AyGiYYVj6B59TmhE=
X-MS-Office365-Filtering-Correlation-Id: 51aa4da0-3ab6-4d11-bd65-08d59db0c42b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871C01639A30BECD97CFDD6FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Y1v5CPVHZGjUu/todX231+TnhtUSJrwkVwKXzB11XfchTSh/+tEZVKEKPFFMSvWvewU+ry4cpRX6hcVHmIIWlKgThUeiVmxh2UeWTYIRLzH7Tx5lQsL+Z0PCnunka28MchumfN023UjMkUOv++WMgjnzN7jNHHs94Jj4lGssFDbRvhLJ1WUFj/DDf5/0tk1MqhZmL1lCaf2kbo+haUGGmpOO0+Q/L9fdEAaGwVJRUc5IQ6CMNSdYn8MqAwIiWzHQvN5yNY0GA1vBVMfPPcsRJ/31yZ3T/mfW6wS77BHyA3Fi+8VPBnO6YKAJ6c8xHhR1LAO8Rr72h0sALdUbDRO8vof7BzhkEWywAxlHEXl4hhOpUimPWvMnZs7A9e7SqdPVBuPer5TRPTR/B7msx9QzdzvefRUqoJIwKqc8c2kcFXI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aa4da0-3ab6-4d11-bd65-08d59db0c42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:41.7530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

[ Upstream commit d27f81f061bbde627ac4fbd735114f9ea2c63615 ]

The test was backwards, triggering IRQ autoprobing if the firmware
did not specify an IRQ, instead of triggering it only when the
module force parameter was specified.

Since autoprobing is not enabled on !x86 and the platform device is
currently only used on !x86, or with force, this has gone unnoticed.

Fixes: 00194826e6be ("tpm_tis: Clean up the force=3D1 module parameter")
Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com> (with TPM 2.0)
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> (with TPM 1.2)
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 06173d2e316f..2721f9c2e70a 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -334,7 +334,7 @@ static int tpm_tis_plat_probe(struct platform_device *p=
dev)
 	if (res) {
 		tpm_info.irq =3D res->start;
 	} else {
-		if (pdev =3D=3D force_pdev)
+		if (pdev !=3D force_pdev)
 			tpm_info.irq =3D -1;
 		else
 			/* When forcing auto probe the IRQ */
--=20
2.15.1
