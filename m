Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240600-3-6333355679973644813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240599; b=rJLULaf7J7dAkLz/Qxdpm7EjQHr3N53fElFrAz7Vf6Y0BKlh24
    i7L1xNX3I6AIEZzLjdbjotDRvo0M2k0gxVwdwesWQfCvxY5MJ+f2WWqTDESIGzoc
    ZcPSH1ys66t0FaP656oD3EqkLZaA9fsga2zWeYijyPPnOPK3EooIBbBZs+xjyGVO
    7MCEaAfCRR/QTXHjyPypqQCIkDgmYCDgUbMBnFF2Tv74EwCqBEmfC1m3XnT7sl53
    Qv+Nds4DkQpUmL0Ipj2AfpPNlRlLMqssjGHguw4xwu7aqES4tCVkLOc7u+fszCU7
    fH71AfoEJbRXTekjk2GD/3FO+k2AuZYspEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240599; bh=vQUdF/d9yY
    VUGOxn5m97Mojm2aReJIHW1W8mA5cAw50=; b=OQ8XP6mHz4EJjxwOAdYRmb2JN2
    jgVN3uSYpcMkIEP0z4DzbMsduN26K6l+n16SyIpPpTOAfNM94W6fAsRHE6qgUX3P
    58f2Zt7zAojOvBrLwlnWc9+j17lw5LvdkaA0OwJqr9wmC7/hrnQVvh3/bbxXxde3
    ofAy02PQtnSq4LG+e7vCk/pOSYdRv4mpVJQKJLipASbehk1UGmge36CDKoiw6beH
    HFJJkrTuTOULADG3RC/XbJAeJvxgRipujQKzNclmQVYsUEghrz2KcjVRoYXvEQmo
    RlZIxyCdmYDvp7X+b872leTkq3xUkjuqed5idPxjgozUYhhBUSTWiePDBKQg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q7zNe3me x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q7zNe3me x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNAu9VVhAp5cieozjHOG1Y9IfpZN9qjteBSv6KcjZvlYPVxBozUQvlvYmoHr3JO9byGL1eDYXEoimMyV0ULKS1+2VY0XvczdZl656Vqk8KCQaWzCJrly
    +NKKn+BFCAg1fl0W+SwkLDAnDr/Q+j72ffq8LbJ/QvXmtVFWn+lukT8reHn+FNo+6PmSSxjM0arRh+yvkjTKf4/FNpdRDQHOrFElCf9sfDoNGmeIrHaDHzpG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zRKbQ67AAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=FbnaQ8Hq_s0ZBRUY5coA:9 a=wPNLvfGTeEIA:10 a=PA03WX8tBzeizutn5_OT:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756117AbeDICW6 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:22:58 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:6816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756022AbeDIA3j (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Edward Cree <ecree@solarflare.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 109/293] sfc: remove duplicate up_write on VF
 filter_sem
Thread-Topic: [PATCH AUTOSEL for 4.9 109/293] sfc: remove duplicate up_write
 on VF filter_sem
Thread-Index: AQHTz5kZtXYNtbTly0S7JFi/e5t7lQ==
Date: Mon, 9 Apr 2018 00:24:18 +0000
Message-ID: <20180409002239.163177-109-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:jF8ZpMN1TY81Pb/0bPaWYb8YBBIQaq6NDow1Bk/iW44cG+VsZMHxV6klqqNcMBItnPDG183ylzKePvbtbce0PTn1f4i0P5vwqszLylCil+65bAUfSA43CjrfcZBVUNXShjJyft8zVtFyGHWd0vdqKnOODF1/YjC/HhguJTTtEuGMSLbTNZTWXa4o2LL+QuqH18iIscNmS+wsmWq72sLqUvxzlTSyP8OSPo/JBzky7tutErEDvZvBttcsoJcYCVSS;20:OTHuqjbgv0+O0m7YLQUKGgQMMJLaeqmclWCv1CsDF6TTHJsQYjDs3dV6npc/SoYD4xyjgNkFMJ/DvwYGzA95xSe9rPcx8/kxKy4A0jusPnQHsLqQ1wcCbbkqhUWwiCgCIZhiTziug0iq96RBhjGfg/ofGlog/fKjadBKlvJhArM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e59241ce-3a3b-43c1-abfe-08d59db0f8d1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967F36CE3BFF9E53D1497F9FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(575784001)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5jSp8DE0L62aB6Az2l9qLjNoO+8mPOaaI2xKorevaBbfKfDhMpd5uVs11Q/JVM4tr6EC5mbl/+aXafBSDF5CVcmZZ2i09G9r6UjkGmZx0zqSB45UzY8L6Zi4koGfqTf9gqHgqDfixjetB+n5+jw0U6j/w2J7TuFB4nzUaHCUVQE2fGNIbdb8221PQPB81du80PHUBGLcfD8snX8Ci1uboJWmBR2lzeN1gWzNJuDzzib6e+V+9BipyDCS1FlqN9SlKDvTXLifJbx/BD5EKHxAePwOQnYd1IcYCoSKZQvTXwb3YkyfdZa+54wijVfmx4jNzlnAdLFVicGsflmVjmRY2xLzzJ6gtsXJ0doKpYQRIKRRZ+asydTecqp6hlRIb1B0d2xqd908LHjtzDIPPicAv34eZKLxDRT4lZPHvEUmCBY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59241ce-3a3b-43c1-abfe-08d59db0f8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:18.4719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Edward Cree <ecree@solarflare.com>

[ Upstream commit 57f0c9cf58ff7fe479137ab847a886d0eed3ad1d ]

Somehow two copies of the line 'up_write(&vf->efx->filter_sem);' got into
 efx_ef10_sriov_set_vf_vlan().  This would put the mutex in a bad state and
 cause all subsequent down attempts to hang.

Fixes: 671b53eec2ed ("sfc: Ensure down_write(&filter_sem) and up_write() ar=
e matched before calling efx_net_open()")
Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/sfc/ef10_sriov.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/s=
fc/ef10_sriov.c
index a949b9d27329..d87d89d3c956 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -660,8 +660,6 @@ restore_filters:
 		up_write(&vf->efx->filter_sem);
 		mutex_unlock(&vf->efx->mac_lock);
=20
-		up_write(&vf->efx->filter_sem);
-
 		rc2 =3D efx_net_open(vf->efx->net_dev);
 		if (rc2)
 			goto reset_nic;
--=20
2.15.1
