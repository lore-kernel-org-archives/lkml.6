Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243671-2-13966324825214148212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243671; b=fiY0iozsS1yTTTaCrW0Lq5nizinfAhJquhGBUSwnL+1bNzLn9C
    sIDLoyvGuweRC9/3Ws+ezIOYUc3h67vvGRLQaGPAVEqpporNzs5uZ5XiN59zoLbP
    TpeyGmQaZrCiKI/prcy7J87iNb9T1FCdYMQDp1tI8Zd2DccDSsb/bIRBrTowIfZy
    zT8qAiFc71od/Ta7pbUTizxAFwGGSAr97oikcdQogwFjlWsaPDRKegaWwVC2YELu
    V2OV5KV31pXZUP+S+JFp/DCs0OdX5N6Nkv4jX77EsWUES6cvYSsvQrwvMZ0HZ3da
    AmIRPqvQcJLnMZpEtrI9E7wXfcwUipLtoMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243671; bh=sV6TC5PYIL
    1uVqXPPVeNWjO/VrTu2KXUMo57A6YdYp8=; b=I6/nisVWMemLiLq5+Hym3NJuI+
    6j87BT2+k4WiGeT522fe+0so2TDMNcxpZnzN1MBvTr5heCZttUI966Kx4ZN480Oj
    kC6FoGJAOnqNiTRCn4ZirGxhx9So0NLKBlQu8IQmkLb9F9b/E8kkDVbRZrwfPXdI
    VaomZ+JZicZGKnITPpbWAwak+EmVPP1vWsiPSDp3KgKU613llMzuPx/PoVrM7QIK
    zUt15+7sFHIYbCc2bNHUItUTonk9CBhCFtUgYaUGaa/XHj6Adto4Jd4Uw+0SlkGO
    aeUv7/EgYn/D+MLkRaA0fp2KIZZpGDs1O6PEx9zxBali2aA38eYLMg7kwt2A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WVhr9ml9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WVhr9ml9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO3VgkU+am0tqreo/BfMXj/KC3nhU2lpL3NJj6XC5+X9/vOgfAhttAype5O2uyvFFRnXOgluhbMkGboUzPsx3t0xJ2+QPbqCdl4lYzG1NvoyA7vZ+H0i
    rcGA06A+72/SEDrtKKigLqpxRPVjZ8Rpy8Q0O6E2qbSWo5luvUOOhizQQRuPRka6j6Vd1EBOFxSqGK22dJi58AnqtZlZERALB5+bLB1gKKei4zB+5tEX6rlu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=Q-0LPAu1DzJBLX4319oA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeDIDN4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:13:56 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754941AbeDIAXu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eryu Guan <eguan@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 070/161] blk-mq-debugfs: don't allow write on
 attributes with seq_operations set
Thread-Topic: [PATCH AUTOSEL for 4.14 070/161] blk-mq-debugfs: don't allow
 write on attributes with seq_operations set
Thread-Index: AQHTz5iYRpWuT6cNrUyhI31Gj/wmfw==
Date: Mon, 9 Apr 2018 00:20:43 +0000
Message-ID: <20180409001936.162706-70-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:cDgwPmFH0QHsQjGqUPPY0XxfhAaI6W7rMTuqcrNzcXVmdjcN7DOiiwgTIqHzkWfqAZZDxGy/zsV1IX+BegkP1KllEnKv+5C7cfFtaEQSheM961nPkrI5XF9Li9iK6cJ8vpx9stGGCwSHfZw7c4G1ChMLYm9f0v2aWh6Omwydj/SS4hal8SljnZgiBIggR3+l+xoKlomv8CYbdv0zYEiVJASbGUoVuDBoorniCFKfaoeNVoyrNyKapKrFUuX0E7Qj;20:GJZ/X/QK0rVIQXMqhhec6/eDL6Kt53XpwKZHRAgwYiZZUdOaAvFE1JBaPCgwC9k0Swj3Y6IuWssQKNKX90LF5k3DNHgOHt8KCPP0m0vJ6e8XIWn7vEer2zuhBRuh4lzex6HCaH0sA44fnWFQ9HM1H7kzruehJSiI1CiNYAbglmI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bdba955-bc0c-4bfd-0849-08d59db0285c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080B93434F43C0D3EED7F23FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DlmAjYG2XkshmLLavRYRcYZkTFlKB8Wy25NdrBExYAfiavZ76D8Z6nf0OooQrqm20J7RYVMzWuoGRCeqFL3jY7v049nOrZA2SnAXSF1WkiGO2rWjHxsow3oLCsPnRxtTGtEcPReBTooZ0ZmdI2UfK5EhFmzJBHOoRIOvHApKeUOIvEj1FeRnLOKQHTB/ptX7Da2M+dyaGjujk6y9OwBQZ11E36YrBbgOfeOeWuTf2QPVcR8StSWKGWEW3U564goaJA12XS1pBhcXhrooMiU37HioDCBAkfrggHSPKDBUmrAibmqzeLPGMkPzcdpZRluk3A14knEhmHkUjvKVMzcASeVfjGP3P7eDD8F1Ke2/6ScQ9ZEVbCg/q88FuqM++VGziY/FPrPoq7RyKbNWWe8VQbVXQ37Yq791zoVTGdyPR7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdba955-bc0c-4bfd-0849-08d59db0285c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:43.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eryu Guan <eguan@redhat.com>

[ Upstream commit 6b136a24b05c81a24e0b648a4bd938bcd0c4f69e ]

Attributes that only implement .seq_ops are read-only, any write to
them should be rejected. But currently kernel would crash when
writing to such debugfs entries, e.g.

chmod +w /sys/kernel/debug/block/<dev>/requeue_list
echo 0 > /sys/kernel/debug/block/<dev>/requeue_list
chmod -w /sys/kernel/debug/block/<dev>/requeue_list

Fix it by returning -EPERM in blk_mq_debugfs_write() when writing to
such attributes.

Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq-debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index de294d775acf..d95439154556 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -704,7 +704,11 @@ static ssize_t blk_mq_debugfs_write(struct file *file,=
 const char __user *buf,
 	const struct blk_mq_debugfs_attr *attr =3D m->private;
 	void *data =3D d_inode(file->f_path.dentry->d_parent)->i_private;
=20
-	if (!attr->write)
+	/*
+	 * Attributes that only implement .seq_ops are read-only and 'attr' is
+	 * the same with 'data' in this case.
+	 */
+	if (attr =3D=3D data || !attr->write)
 		return -EPERM;
=20
 	return attr->write(data, buf, count, ppos);
--=20
2.15.1
