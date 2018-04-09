Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243989-2-4753208123543241353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243989; b=qoUQhQFIYbnrLqVcSGplLvLqvBNb1iRLmdYmRYO49xKGuZZ44a
    KOJyH8XFMKi51/WMgmkHY2dJ8vLY8UjP8eoTDSSNlyJL4YSB6X3GE1rBSkMUa54A
    hL9xm2gEIPn22YpxseseVzD7IdODZaN+KyqK/oPvPsSNf5fml6ooAEpsEAMvkh7k
    RMU8Qiuw/XJmaqfM0tkqgep+jTH4ItsaU5s2Oi0BOQEG4AfXaqYxsKo3nQ0/Ld8+
    QWLU+N+qO1RoRYx1I1BuNi6985guE9A01GCj5qZKgXAtUfVwwTcpdgTiiF7IQRR7
    auC4I/iKnZrzMbAbcb2IgR60sFhXon/PfUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243989; bh=j0w1JO0Kg/
    qAdkB76SviOy+daLTt0x5CDokcTpq+fsA=; b=YTy1o9C7G1evhr4zsKXXIFvKa4
    WjtnBA+cIq5FCV63lyBgv1nhGXtPTOWejugAYOWlHtpgO+bk0XNFIZVO5ZE3WHAY
    FkqKII5wEUAbSdH/6PgThd4KtCg9fnDiM7UYmKS+XU+BnCp3avV/SEouI4k+dum7
    GLsKP5cGdnCJ8PRL5iJ9tSTW4PTnEcqvxydHucZkJC3Lc+svZdHkg/Pb2ivOLyL2
    VwSaHmi1dwZqlfWIqSoYRSPa/l83/hDTxuZEvqaTl3/M72Tzwq0Irdf/yE/MNqJf
    L7Xece377r8AfBY87fIfwGhzXAvr6k5jVr10DqXuVgOvkfZIwY29xMtvkaDA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JtEsgeZL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JtEsgeZL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI+z51rCvsEg+p5rRgfrUH0c47rrJkKI5aFPRNg57mX2bWIqOUWhsaptJMQKW304sw/29OFV5eLkcczqfW80mLgQZlt9+aVa66wCqH3yOQCMiyTP6k2I
    gq0vp9BzgkG36/FdNwudTm4YFdg/E7A5usVeWaoFTzcE3NMx5ojXdo4N61j1Yb88aEPp+X9bOuquvbvXkONTTSUZv0pHrfD8R5mLh7w5WdcllOI9aQ8xJIz1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=1EsaE_6oAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=1vR2FzZSdyBwo_47p4gA:9 a=dteP5O-kDf-mquxc:21
    a=LdMjILow4WDEMZA0:21 a=wPNLvfGTeEIA:10 a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeDIAXD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:03 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754794AbeDIAXB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 049/161] mac80211_hwsim: fix possible memory
 leak in hwsim_new_radio_nl()
Thread-Topic: [PATCH AUTOSEL for 4.14 049/161] mac80211_hwsim: fix possible
 memory leak in hwsim_new_radio_nl()
Thread-Index: AQHTz5iOGbS2uGDPAEy73XDroqMSZg==
Date: Mon, 9 Apr 2018 00:20:26 +0000
Message-ID: <20180409001936.162706-49-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:mVeAwuqZ4cdhkDPgh39accospxvur88eAsdoHzLI3lAHxgltNR01rKWLRpuQ1+DbAEAleV7M2V3kQ38dx23rC9uyQumC44DtyiRGVSrVK2AwEltqN5Cz468BUiPVJFxoC7iTmrEyQMrQ6Ldd7kWjYqQ+3RD9nbIVT2JXZIX1752+iWvsmNZF26BTzZ/OJQ3VBWjv7xRc7AWPC+kenhQ1q63t9dMovmwgYnrjvn1zPVtRSaALe6kqoWSOni/cbcX6;20:Fa2l7c0bfUH0RP5p9O7+NcfXgM/OHw7eFtTcdUh8WyRiTakbmsFjWoHuITGQuK1xbE01DJd4yoyeVX60HkEPJM3pElM/ieri1pNymILMntDEBTwJvcnGeERWd5tQOSFhVLzkSw0EarOoKpa0PGbxX+qPQ+G41wlHi/PCVwykvDM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9326b855-ed0c-4469-d0e4-08d59db00b43
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101400B39722D440E4EDB2A1FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(575784001)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: L5WFu2G0SCpu9bk1Ge68yqkCjw5yKnwfyzAsrfU5FFOQcEadn6SMTNdMGN/w26zeOs5gFvcFE5resKYkJzPCXs5gq9z4Fw8rdpVF5zDnnRdrJhJi6V6z6iZvquXQ7exIxS+o5oxuziJmQc8LvZRPB2SJKdSUWAO6/5uX6EZSTNKVcBy9rb82p35U6QFNB22ASq2klqROGPmn+hXNuzNDY8CF07EC8Gc0/UJMO6tqPxNScZjefL/7nt2YZelPt2SsESsPKJLlsle495/Zdf5EYVTXZ3JCHMNFEF1cvJ/5Su+mQ/hELaxV9rXgWi+IwgLh7hLD5S1kik65hgHjg8U/47AUuVy1Row76+jDQAVBdeS4pcJ3fIfhCCgF87766I07XD69NcIOhC4ve7lfZPbnAy/UHJtdpziqSWgka7pdJ88=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9326b855-ed0c-4469-d0e4-08d59db00b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:26.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "weiyongjun (A)" <weiyongjun1@huawei.com>

[ Upstream commit 0ddcff49b672239dda94d70d0fcf50317a9f4b51 ]

'hwname' is malloced in hwsim_new_radio_nl() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: ff4dd73dd2b4 ("mac80211_hwsim: check HWSIM_ATTR_RADIO_NAME length")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index d148dbf3beeb..977fd7aa2082 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3153,8 +3153,10 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, s=
truct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_REG_CUSTOM_REG]) {
 		u32 idx =3D nla_get_u32(info->attrs[HWSIM_ATTR_REG_CUSTOM_REG]);
=20
-		if (idx >=3D ARRAY_SIZE(hwsim_world_regdom_custom))
+		if (idx >=3D ARRAY_SIZE(hwsim_world_regdom_custom)) {
+			kfree(hwname);
 			return -EINVAL;
+		}
 		param.regd =3D hwsim_world_regdom_custom[idx];
 	}
=20
--=20
2.15.1
