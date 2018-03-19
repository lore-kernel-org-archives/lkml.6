Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3715406-1521493284-2-407509756277301545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493282; b=Q7fjOc6PJubi7vxwhlZxT0qcFhg8YmmyVbr3Ptv0cxyfnU5
    RI2FZhhoooIpf1f++vdHGC3JQ1jRZyWu6niOtfad/KD3SioSSxwydjWLe21gRn0v
    ccYnfBExiBNGxVV/D1lcoy/ct/QgiCSap3AcTYWS/q9ZjpRu89/eG2cDLXt+kUmX
    Qrnu134EU3AoJHCLRlrthg0dcCRMwQrkFN/b8Si2Pne88hrId348i1QwfbzlEgd1
    GZnAAqz6QqnheJwxKH9eKfZqsAFVERe1rBTwo5jgBM5LS6hD+YZrYbkXJZv9iwpQ
    ezSZ1eJ/qyeqSszNBonBNYtYZV1iUNaN0220nEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493282; bh=A/L2gi
    xHmBCEX0tgugWdSqmbvMHploMk6wENR9uwsxI=; b=UHhpEPgnkT6v7mcQIoKMwg
    8lLC30n8sQx5NUKNpatwKr+4SvLbITjUyt33epHc7UeN+pGZgwoQwuAO+Jhl8Hb2
    5KK4Ily/rDUE8vnZcmGY11e/CL7GLGAdwTr4LapGaINX6yJNhwOQw1noQ3XrD4gE
    B1ute+CPGiSTF9zfEDCygxgbA5gjoKlrtCgwnkuyF4uSSJAjPSzY88jmYrFuNNNK
    A5j6rviFynyZ1Jr/pJl+UMQZvDGAghVwKNCO1hIWVqRMYm8AxTDbNqTdAjXfuoUG
    uvIkUAQycyxo9zKLJzfTdGA+Gv99cr/1tt1HzUTdd+lCiQH3QfZwxhU9uWwndMQg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V034wCOu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedtieenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V034wCOu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedtieenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031917AbeCSVAa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:00:30 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:27264
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934816AbeCSQCy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 165/281] i40evf: fix merge error in older
 patch
Thread-Topic: [PATCH AUTOSEL for 4.9 165/281] i40evf: fix merge error in older
 patch
Thread-Index: AQHTv5t+2rR9B2BTQU2F2BaPOMx54g==
Date: Mon, 19 Mar 2018 16:01:09 +0000
Message-ID: <20180319155742.13731-165-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:ycHwQA7POdayXAn6sv4d9IJAQML6EQdt1a0rrXqSXX+uo8adRTYVA7QlYb7ih0FhwCcu8+h0mcESUtl4wv+tGtB6Q0AxXxm2LeIC9NeysJdBErZ+iXb5h4UC7CKFuGTw7FtT372x9M+hQ9yyHSgiGugJS9kT6Bp+ETeOsfj0krY7J+xQZDa+rOWQ+AlIUKN5/zcJoXjWBW2z6YZHCJQYxtF2iRj8r7DZDyb8JSq5s2uiK27zV2Y0G1H/+6336tqA;20:lh5NirKTzIMpkrO17NnJjZVS7coFUewM6orkgiJfX6MdUHPqD7P472vBrG7Uob4AAcK5d/x3FERZ6pTr58I5B+WyyTLkdZ4L+G3Q7RTvmiQVdzmLl9pzDlBZjCRWqM19/UKskb6EwnKT8oY72sEXVOAxjfEC6nSQE8+ZnQCMPVU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 406bc769-52f9-480f-1e3e-08d58db2deb2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725EF7C8B612D17E7F8BBAFFBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(575784001)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Qb7A1YnASll0kmtDlcwdwazOmbQgUmswUle/9cqgozZrvb1L7xbpTLeJA7a8YmU36g4a4OHZPccMICLjqg90xfzrwKfC1G6HHbEOWWX/yhhm4SiD/1DweVxmaDFupVKJut2+iQubBRVd9YVhbTaik9GdLrpt8GjxwmymW/L8m8DRy6Jx8WnGfsuzhhI/XH9HSthFQfM6Vl78wg/1k1M/vu92EjFQzqRRkIpyqT8vPc2T8sQfJopi5DqxINMKHjOc2avRzStH4d5r624N8+6r/03KvXcJckIyml1LLSseyIPj3b3LDMDx4RDKl1igfGQSCjOhpcJQyGgXOKKi8ZYgiQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406bc769-52f9-480f-1e3e-08d58db2deb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:09.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 155b0f690051345deefc653774b739c786067d61 ]

This patch fixes a missing line that was missed while merging,
which results in a driver feature in the VF not working to
enable RSS as a negotiated feature.

Fixes: 43a3d9ba34c9c ("i40evf: Allow PF driver to configure RSS")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/=
net/ethernet/intel/i40evf/i40evf_virtchnl.c
index ddf478d6322b..614f93e01500 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -154,6 +154,7 @@ int i40evf_send_vf_config_msg(struct i40evf_adapter *ad=
apter)
 	adapter->current_op =3D I40E_VIRTCHNL_OP_GET_VF_RESOURCES;
 	adapter->aq_required &=3D ~I40EVF_FLAG_AQ_GET_CONFIG;
 	caps =3D I40E_VIRTCHNL_VF_OFFLOAD_L2 |
+	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG |
 	       I40E_VIRTCHNL_VF_OFFLOAD_VLAN |
--=20
2.14.1
