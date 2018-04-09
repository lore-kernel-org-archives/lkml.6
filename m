Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240118-2-17887481327066991521
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
    1523240118; b=iR424h88bLJZIaF6MHAhThNYWNJ/jfcRlzHnCstobUkkO7NGnG
    aM/AeYuUki0Hd8+3SPUeJ/37DWf8AElSOvAz32h4uDJI/fgIyVjPHiszHwFNjuD3
    ax0Jxy0mQULgqr/3VHS9YxRma7NsxWqmRr9PQ1kywavy6ZQOamG+fkm2oe5wlqWc
    Y3Bfd0/FnTKbIjCj3XKnMGSTec5npNlrLYhrE0WvSsU6EvQlO451tWn7WJzA+buV
    MUrRWKEFSSLLOTphbTTT9RBALozsIynpt88fTzTtiivd2bxPXw1T7JRRus62kGeX
    zDZJ1gFDi7OrxhJZik4kkrOUgg1/IzH6Najw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240118; bh=FBTfwZHfG+
    EOglK60Yb+hJMLhTBs7qj7XT8CKY+H3II=; b=GYtgw8kmpJqek5FPp6fwbGwZYp
    nB8UIhuqLzjUb3iFbrAEIuSxZktk6WV7qwNkxEUB0tPiRaBV0bBg3DogfZ17/iu9
    AqjJ1h4KuQfQS8zICBGSlym0Vl/0iNLpdBwA9zljqGhQx6PWv+ITi0nlXi4+S80l
    nV0T3yxRWkUs7cSzFC701bWYW79zeqFcBSiy5Zg04bZCa57dCC2TyCM5wqak6/RP
    AVb66oofc6t3Kx8SG22OhsyB3wURukdxpEsFySClYVDpgPj56AsHn4cJ4k9kwQVF
    8viQGWOt1TYcjoI0bmeGPlm/bgL+jyI2mr+nG2XZhYAonzu4Nx+hUDMg3Biw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n0XTIDyg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n0XTIDyg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDqfhRHzBFrPI4nctcqJAUDRQ+ngPRL4gVXZbC8Np6Q+pcuDZrsyABF3WiDdmM3ZsbHsHBMuRxcdcbct5hIBgd/mlXjMrM3tYsfvsvJxMaZ4CGnQMK52
    fZphQaJ1/LBnEUO8J/vpKNzm5K3xO6plF2WvriwqokvB3rIAwSf+f5BcMpuPRGp2GzUjd3KQVTykArtIEnEk+ECGnAd4LmXZrYq8tS6ykp0a07Ow1alke3x3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=9K44mw4YlIJJ9uqzgfAA:9 a=wPNLvfGTeEIA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbeDICPO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:15:14 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756102AbeDIAaf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Mintz, Yuval" <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 142/293] bnx2x: Don't log mc removal
 needlessly
Thread-Topic: [PATCH AUTOSEL for 4.9 142/293] bnx2x: Don't log mc removal
 needlessly
Thread-Index: AQHTz5ko3TMFxd93B0ydh47+xvQxBA==
Date: Mon, 9 Apr 2018 00:24:43 +0000
Message-ID: <20180409002239.163177-142-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:YhTLWNFhuuKTyFlZXZNSxNNLaxjhEqOUvTIswzQ9Jx6yrAKNeU/SThOjN9nZ1lgbqNogpcLNkAA/i87wKwtex3r8d9kRn2jiOJGp2KtkIr5S4RekRln5/4CUcfegAobYPPdjF3jOUZrdGhfXvJTHKZo9ECW3Q+iGLc+kth+mJCKdhc2FU7H0tMXStsUoEiLcx6cJHlG0oYDxEXxWBArdqxUwlOIHdyMULBTGdQlutLURnNtmtrgJHIBAG4xIZkY6;20:mmCD4tsI9K1TjeVb2jguoz51nSGeKyMB00BMJfPLtwGbhE8eTmPRHOsW75Zx3ODkyJGb6+0SRzGxRhTxiQ1+ONfyQ3rvHkkfa61cG3vI6j2tYoZ4t4rh+HzWZzmuvC+5wsAIprwWzjA8bbz3RClDeHMHFwYbx66gfEwwE9d2cv0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff749f94-ffec-4167-4520-08d59db118e7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080710AF71FBD7AE8F19FF29FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: w3Y55W8EXr4bglQhQG+5SscOyv44d5BC2bjpFlwEtgRwHH/+l+Sr67HN/QSkTZSdAoQSS0uAjV3Frl4XPBaA6ypY1jkgbpvuS3vs9b17ZqPEdO8Uy+hfeHHTSyU49n4e9O3yZ3/USQQiVDEtm7VxHed2lj8jtSaEIfGFFTQQ4KrY0sbXLPQyiEpmHri2Hz/+F6w0IjqashhT/bdfadm7RKBobuBWiiAq1dvNHV20b8jafs6r2Obn5KweJd6TCOUpiaVac1cvVw9tM2dGoHZJLZrRMjpG+DBQD1DUtbqCfqk9m4ej2qOUsutEU2dzUBv/+zamBwDA/2E6RUe/JDRDGvtrZjvNShCog/8v69SNdIpBLSQtGLBOS35c/O/l91povdC7CiC8xgyjAq8Wr8MWvxOYcy5HXr/TWIzHsZ6mLSM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff749f94-ffec-4167-4520-08d59db118e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:43.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>

[ Upstream commit d0c32a16235aeacd32c9de6ff90f9219614d7e4e ]

When mc configuration changes bnx2x_config_mcast() can return 0 for
success, negative for failure and positive for benign reason preventing
its immediate work, e.g., when the command awaits the completion of
a previously sent command.

When removing all configured macs on a 578xx adapter, if a positive
value would be returned driver would errneously log it as an error.

Fixes: c7b7b483ccc9 ("bnx2x: Don't flush multicast MACs")
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net=
/ethernet/broadcom/bnx2x/bnx2x_main.c
index 554c4086b3c6..026befa7f865 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -12739,7 +12739,7 @@ static int bnx2x_set_mc_list(struct bnx2x *bp)
 	} else {
 		/* If no mc addresses are required, flush the configuration */
 		rc =3D bnx2x_config_mcast(bp, &rparam, BNX2X_MCAST_CMD_DEL);
-		if (rc)
+		if (rc < 0)
 			BNX2X_ERR("Failed to clear multicast configuration %d\n",
 				  rc);
 	}
--=20
2.15.1
