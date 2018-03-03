Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122663-2-2789296553184406513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122662; b=qdCmpH36ysZGCM0r0D8r62jvGkRlnonOjSgB44/KBQIlnPi
    gr3nsRYWH1ywjQTsfTgBc1AP8c50EnkeLPSxvp5xfSVfXn6NcClUmPU1ugEWlOda
    zswl0ezTcGOehxT2sRkINEaoy1eP+XGIQMWsvJxxIUnnbtoOO6qRfu9xcp3jz66R
    HJWuklxwaTYLl0gQdX7NrKEV2Fw3D6XPCuJCTXn9mBDYLUipK8KD4RD67zvUUdzP
    sw2epAnFGN+Dw9pf0WHYyxKJnn9AJOX9io2Z6SDIrsDHbf0vNwwdV2iiB8NhXn52
    l2h6GaaWaGahpXmDF96bwumOfGIB7glBZ4BqYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122662; bh=jp7HIo
    4Hmo9uYqOaa0QG3rbiGSHzG06EJv7rqnZF664=; b=LonlnzyDRxvoTZ5cRZUhu/
    jbzkT8q/diywBY/F9PanWKWnoc3CgsTEl3YFeQh8PV8rNTwm9N/IgOnVcblOsQ8l
    EQ/RVPXOwbsEs1ZuJjqcGKbwHd8SF+aiH+JQXehpvKDa7I7M0l+gv/IWB9r++igg
    cEKkAmUtoDwSBfQfVzLR3KqWDwURw6L9hghRUINdOk6vW/+MqCTwFne3X0XleCwg
    2mK8InuDdsw/s3qKmSHryoeo97srPnO5VWxq3njH+nYW3P/TscAcaBZzPMtZKo+h
    PxxdfPxB/R6Go19f7wpViDHCjBHsxN2hlcPAw/DKL97wZl/AAk+nbxRYSdu+UqSA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JP713ZC4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JP713ZC4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932492AbeCDART (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:17:19 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14153
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933337AbeCCW3P (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 50/84] iwlwifi: mvm: avoid dumping assert log
 when device is stopped
Thread-Topic: [PATCH AUTOSEL for 4.14 50/84] iwlwifi: mvm: avoid dumping
 assert log when device is stopped
Thread-Index: AQHTsz6sz/n3Nhiv00CFwrCmcIMlFQ==
Date: Sat, 3 Mar 2018 22:26:28 +0000
Message-ID: <20180303222518.26271-50-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:/wKTWvbTi5kLdhI8pi06HY1edQY9BxOW3eYwfiJEuFV7RK9yXnohuyCSCLrPKSl1Jd0lniyubSaDeqysslPqU8yC531aCd/VxYx1VgU5P75tLpHX7jGQA4D1Jo2OdCGiggpQ4ogq3sIFdHG9OetiR0weTP2VqN5LGjoPk5FXmKXRYD2+Pems6pCRemk7UvywQQ8tLU/9QpyjzBXvuP0c+kYYrq3TYQNACmzvpNhszXzNQqlaHocScx4g2q6i3Tiz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44abda89-aff5-4780-890c-08d5815630dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10652F9EB41CBB29B7B4F527FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kRznwQ64MFngpMBnKvS6ql/JvGuOy8sWnrpLNdmB/vnox+8/vdSXTuXMQOX8CRPA/2gn0tWpeFUs6y2lG+D+vwjL9XbR2s6iAiVkJedUud/wDA3fB7CkC67NWU80yRkTPiCTg7s+qyaWY/9rbQ9jzp2ROiI3DpI2KcpbK5NSUgQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44abda89-aff5-4780-890c-08d5815630dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:28.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 6362ab721ef5c4ecfa01f53ad4137d3d984f0c6c ]

We might erroneously get to error dumping code when the
device is already stopped.

In that case the driver will detect a defective value and will try to
reset the HW, assuming it is only a bus issue.  The driver than
proceeds with the dumping.

The result has two side effects:

1. The device won't be stopped again, since the transport status is
already stopped, so the device remains powered on while it actually
should be stopped.

2. The dump in that case is completely garbaged and useless.

Detect and avoid this.  It will also make debugging such issues
easier.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/w=
ireless/intel/iwlwifi/mvm/utils.c
index 0ae7624eac9d..43ab172d31cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -603,6 +603,12 @@ static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm=
 *mvm, u32 base)
=20
 void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
 {
+	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
+		IWL_ERR(mvm,
+			"DEVICE_ENABLED bit is not set. Aborting dump.\n");
+		return;
+	}
+
 	iwl_mvm_dump_lmac_error_log(mvm, mvm->error_event_table[0]);
=20
 	if (mvm->error_event_table[1])
--=20
2.14.1
