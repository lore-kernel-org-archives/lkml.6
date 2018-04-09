Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523246701-2-11667618531894733718
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
    1523246700; b=dUxBaxiJpncCGlD1DyZQKqn0l4fqu8ZOmiXNvp+BoBhFJcCdl2
    dujxE27aJsXIPSlVSU2h63ENjTJiYIdRBdePfofkeiXPvL+DY4o6C/6kOVP33o7w
    Iwou5awYf/ddbfH/2QxyV9hlgeG42Wy16hSk9SHfUBgB23OtmEATAbyCpTkOP9b/
    4QJdpfhGFJUxEaoW+gQb00UDzl9r7NsPbeD9pWCXwEUHWxQGa42PAM8nLCCwjdwO
    z4F01itw6FbhRKU6B4rMICWwn6z87bYUAeCN6tZB8dnWJANgkV1e+vnT1lB4Y0xU
    cpNyEzlOjLJpDEkEjW7QmTStlT6jR01zEytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246700; bh=M9CE1Q1nfa
    CweWI3pv9lgFRNPKfOwSy32PZihRdstbw=; b=t+l/4BZn9nX5MMsZ9muy8CSanD
    NewOmS32/iOLC+4B/ksp8kQ6xE5o4yQ6kDkaKQoCvnrmKIzbE43OzSUJa8Q52PtF
    pfR9tlPoaweSjD4fq6/UoOuW1LbZfMPMMG4TilwInbRR7U0eTGzdgSDUmyPw3ED8
    DcaOL5T3ZydQYNZxfEuoa0WR53RWzgw/y2kl2vBXSC3yKHMYr4IFbrUdHkFjqQzc
    3QCw/uQ3qGEuIkubzphw4d+yKH+kACJgyaXyligBtCj/humuG4tZwpgsc0rp9nak
    Dkf4YAUpWXbs6rb7yHcQC/ANfrub2Se01IP8WrMbWcLDN98glnBUG4dWRBpA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mdzmSqlk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mdzmSqlk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFxOtd6Nb73fg26Nt+F4zHoBoPz5yVXt5w+wyD8cSEMJXDbuHGTrNpCRf7BU8jGSIjolTfWlxwC9pXH4d5mwLC3T8iCGo81vKENLLwNE915PP9pppfOB
    NfWoEIJL5cIW+5KpPD/q9mD87qP9JNwS+rXdjgev7/cZkPLES0CPnxBXumxxCHeOEsXIPJhyXnA86yOjzBC/fzh0S+sd3UnxW623GaggEEbAs+kxEucIU8D7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=RW_g7ExWAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=1C7F8m05DB2dRtyQP74A:9 a=wPNLvfGTeEIA:10 a=UQnFI0IN6KXBP4Chuhxn:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbeDIEEr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:04:47 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753214AbeDIAR4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jan Chochol <jan@chochol.info>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 046/189] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Topic: [PATCH AUTOSEL for 4.15 046/189] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Index: AQHTz5ghRuu3YuiHrEelQujOqeLMug==
Date: Mon, 9 Apr 2018 00:17:22 +0000
Message-ID: <20180409001637.162453-46-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:vR1BWSbOXFFfWiDYsK8xQJjmoctW2uAHI7NhCKEszfY+V9VxMikOuaLPNnP60JtgHWPdu75Um1rnd7KpIrC158GhwJ3WQWkUbWrIe6JyYYZBl2FT0Pmw2kO7ASL+Tl8WoH5iso7L6jTkD74voAniHsjDmTwWBosA6AU8q83HDk249VC6jHhNve0afV1L0gx1CUmUxS4YV4bp5V5fS4hSornIMgyCDpuV8IISjFZpL7pNYg+A7vxCQTmyvstAkaQO;20:M/g0HbcKwnlKsZTj6/cUBhRN0kLiiWuTmkce7kktd3PliXGHXW48qlr8LIa9HONog3z78Ed1x2wtwglauLIwVzLzvqR9t8RIiLpaOSVWA4TWEmA8jE64nJAVNIX3hbSG+PJl2D4jhxPTXZNUoKMGHa4UZo1CteMY0Go4Pvmn3x8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fddabc81-99a9-41b2-dfae-08d59daf53b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048B68D9BC0823AF8D57FB4FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZiTxgiSW+YiMNtGrG7/B3V//ipVbdlKLJY7TpTxscvOeLiMEd/oPiYGN3x/6B2OUxcrxjA/ftoGsQPe0rcOHtRryTb7CY6/c3KBTnaeeSxSVOCNPs7npujNKS6I816zHvGdbXQVeNSMPwGZWUA/Rr5s6UphJsXSf3ibf7V5wf1pDcUMg+WASmCrjLORo9HxjXZAZ2nBVOhFIIJShxOPWlVsdIE7ACLLawv0UpzVq5aZOf0JloeQc1VDn3G8SRuuhzCGiePG1jrkwPaIYLkxGWJMVgt/mnXIDz4KhZNDm2fd3xSXiuaspapcx+g+u9FhVJ7aLFR0zTtwZ9dMriNHC/ySjRv75a9d8Xu2ouqAFw6LPbx+Xwx7Tn7hilm6Us7ounP3WErIPu1sCpSibOT6A69WK1TeK6C1+XQ3H3qPEzGk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddabc81-99a9-41b2-dfae-08d59daf53b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:22.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jan Chochol <jan@chochol.info>

[ Upstream commit cbebc6ef4fc830f4040d4140bf53484812d5d5d9 ]

Since commit 57e62324e469 ("NFS: Store the legacy idmapper result in the
keyring") nfs_idmap_cache_timeout changed units from jiffies to seconds.
Unfortunately sysctl interface was not updated accordingly.

As a effect updating /proc/sys/fs/nfs/idmap_cache_timeout with some
value will incorrectly multiply this value by HZ.
Also reading /proc/sys/fs/nfs/idmap_cache_timeout will show real value
divided by HZ.

Fixes: 57e62324e469 ("NFS: Store the legacy idmapper result in the keyring"=
)
Signed-off-by: Jan Chochol <jan@chochol.info>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/nfs4sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index 0d91d84e5822..c394e4447100 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -32,7 +32,7 @@ static struct ctl_table nfs4_cb_sysctls[] =3D {
 		.data =3D &nfs_idmap_cache_timeout,
 		.maxlen =3D sizeof(int),
 		.mode =3D 0644,
-		.proc_handler =3D proc_dointvec_jiffies,
+		.proc_handler =3D proc_dointvec,
 	},
 	{ }
 };
--=20
2.15.1
