Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238805-2-1328832681603298238
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
    1523238804; b=Y0EfJwjAtSlT+Q+4lKetcWPXd7f3NCU943kofrsEe2JjXSf7gn
    +ATbTE5xLG+o+ChKexvBxuD3MDRZHeyjLGeLKyCXNLuLnDEzo1l5vxNz15IjEA//
    J9xpGOGdgLFH5DpWyguYulJtBjcfGMQJobhA9Xs2tnVwm06IJjs8PMN1Vyq4FTI0
    q+h6ECtHJ+VJ7zQ2tWRFnuKzRS+fldoL7Qa0S+wt7g0GQuEJ5JCasrhkTsbB7k4S
    1eNUcZyuwW/T6H1M4DN7EA1/r8ZoGK+HiTjbLWvUy8/YHFkGGIl6nPd3G9FI1x2k
    9TPnWQnlYxjgg/eCA4SVeHAgajHTJNOKu9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238804; bh=LMbO8edCIm
    GlEGQAc6JaQjBdI4JlVCeUdfX18PzhNDM=; b=JgKR63UGyGwIVzo7zpmGwizGcI
    3i3J5UJ4ttHACjbNAkFdsUd70ibYLXF9nb/x0sFULJhe5NkbDfkwXBXz8W9AAS9N
    B+lZ6I3Uo6VbqCijfeB0vh7QN4buLDKTsAxgSJtfTN0cs4H6GkxRHxemWDKEpCVC
    WMhPnpzki7X88HlnGb3rMdwpgGfkMbLMQboxykCGwLM2mHByz0o4rygpCsg/xeIu
    UodWFqokWszpcO1TK1/j8RN8XeSOBUmvOJcOhfS6IjKYBmXlccP64ZYj2a5313ml
    x/dJBVeT27AiOx99tq1050ptbaYB4HM4/15lFJWoB8+ByyUeP8jNacmsj2gA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P+iPz4fZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P+iPz4fZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPJWlRZ/AxhX+wHKt/AYq/fFZB0tp3y6j51cvuUppn9BDB9R4wPr96To9qOWtby25V7XoNP7zHi8WEYB0li4PhVqWHPr0v+6qwRmtQ4TjgY2bfioKXh7
    SGRxWQcVB/awERDDNXmfm5Z6F3bti0m1QmAwsMiQrXe+nhCrWhcaT4T4EMloFvAHeik98Cf41sQPnvEIXef3gDulgtGRdewu0CFvf8kksRjfS2HZVbixN3M7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=CayBMKeuEvu4Z8dvqTcA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeDIAdS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:18 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932287AbeDIAdQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Anand Jain <Anand.Jain@oracle.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 240/293] btrfs: fail mount when sb flag is not
 in BTRFS_SUPER_FLAG_SUPP
Thread-Topic: [PATCH AUTOSEL for 4.9 240/293] btrfs: fail mount when sb flag
 is not in BTRFS_SUPER_FLAG_SUPP
Thread-Index: AQHTz5lVNbgUQvjwq0iJjdR1AXfTDQ==
Date: Mon, 9 Apr 2018 00:26:00 +0000
Message-ID: <20180409002239.163177-240-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:FmQ3XjOhR//Lwa31pKV0+AirjfUfDz3duQFWx+j+faKlWCwQL9ZYi/JvqJp2SAxn7rpKLiecMtgHnfB5vwEXdP+al1VgrErQesik6IIzHflxGR3TNnsonkmmS5L49Zc8ZouzSw21vsrsdArqKnwlyU635jnOnrWM+hb/1TQUDl3C9Xa+J+b4YvSb1okpAZT59OrrcwAcyyiqbblkYqKELuh5vHSvmWBtnT20P5Y//m8N/hiBN7Ir8igXGUgh9KlE;20:eYeb2dCvNie8W7OSGcEkTEXq/YtSgruL129wRTpQEcHXIbZ+HahyB9SB/pvczo8My22leT0zPYYTNtbloVC6ODSO6iqV1SvMCTN4ZOvgxMUToMMY0QOXYvlr4I9guQChQBWQpzazKyPEFo7U91sN4EltrsRY7D/gt5ixskpuJlM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93ee044b-d49e-4ce0-3d80-08d59db178b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902EC7D7524356E33FDD6FEFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: AcPlCDohySkRK5+hDtM7ABOC9q/2qU6wPXsf8UReLvPhZONgU/ijIXOlH/26369iBysBNDdIUQ6GQlr7e5M9OgDphSWuvz46g/79+RLg8AmvxQ3hZIFGf13T45CelxfGUSQGLwgDcRmPV0KI+EIfjzro6MsZOoF7vjqWhisrugDDy3LmK1oHQudSSLZu3M8JQNTD+brIUqgpT40V4vQRKiZecMd6jyzmfR0NYUmDM8fhAlZYG8LXdarDKNS267gIDqBNr2fwGuNGsvJBU13+hhAQcVem9wxQU6FtA1+0pbOj9bt8ujqcJOn3Oq5LwIoZ/64ND8oSAPKvIq78sW+c8cNwOKVGYT+APYA1781rlMA0zgw5BHLs0Betqp3onAg3tbuS/HvUULPlfG4FGffaDctiIiifOp/Uo6nzLk9BRsA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ee044b-d49e-4ce0-3d80-08d59db178b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:00.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anand Jain <Anand.Jain@oracle.com>

[ Upstream commit 6f794e3c5c8f8fdd3b5bb20d9ded894e685b5bbe ]

It appears from the original commit [1] that there isn't any design
specific reason not to fail the mount instead of just warning. This
patch will change it to fail.

[1]
 commit 319e4d0661e5323c9f9945f0f8fb5905e5fe74c3
    btrfs: Enhance super validation check

Fixes: 319e4d0661e5323 ("btrfs: Enhance super validation check")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/disk-io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1cd325765aaa..e30aeedd326e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4142,9 +4142,11 @@ static int btrfs_check_super_valid(struct btrfs_fs_i=
nfo *fs_info,
 		btrfs_err(fs_info, "no valid FS found");
 		ret =3D -EINVAL;
 	}
-	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP)
-		btrfs_warn(fs_info, "unrecognized super flag: %llu",
+	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP) {
+		btrfs_err(fs_info, "unrecognized or unsupported super flag: %llu",
 				btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
+		ret =3D -EINVAL;
+	}
 	if (btrfs_super_root_level(sb) >=3D BTRFS_MAX_LEVEL) {
 		btrfs_err(fs_info, "tree_root level too big: %d >=3D %d",
 				btrfs_super_root_level(sb), BTRFS_MAX_LEVEL);
--=20
2.15.1
