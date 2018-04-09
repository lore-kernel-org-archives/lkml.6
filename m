Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240164-5-8837187124668793667
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
    1523240164; b=PR9LozzMyedCMpMgL84WCCanmiwFdbRuhnPHfK7hQOvvjSAIJX
    jM5V7UZsvf8L0YXdpSlvWrByDb0SuypGdBQo0i1PwraFvEvmqzCaruu/w0sxMeZJ
    Hr1RP8eIYaHwI32fSRsIzuJkOGZGvK4iim5PbTNIeP3aR9dsIPR4+8Usv9yU3g+N
    SgvP6iFs850dmRlgfZH9pV5+dHK7Zeqr9IL6ylKhGgRpRAoEERs4/lMuvVyWbKlq
    KfKbdSkVVny7Ha9PzM59WCDbyLZPglZW45bdkbOyQN6XmXA+V155DAxebYsZ0lLe
    axPhSg+nm7Y5I6UeG5dxpxbucnpte0QCXpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240164; bh=dsrIqCC+lQ
    v71TbdL8mmGYzH+rZk44CNOMFDQ9Y1yf4=; b=uKCKHVgZeJgtgo7lOLCOoDKPKL
    KEP696kddlEXrhPXZhqD1NVUN67HUwdOyKZO3Lp9VObXMMAOaK4ZJANk1jiJUyo/
    G7HI1kQCRYLDECsDHQ1McK9Q7wcuqPFDfXo8isdrrd5qUy2qCJoWDAQxkBChgm+m
    r3GqBShi9rN+eo4cUmjyXsToVdJErI3veSinOlSNJOghayZ9esulLNUXyVx4cXTP
    tX5SWRHoPqajXa6pElBNEnK7nCoscJvqnKtb6g9T+w7NAqdnjHf4OMDeWfuJiOFl
    YE4rk4uZz6SxOX6XnlZB+A3zCa+bSazG7pCTuNrOQBpYxupVodyuvhjvluag==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=azqtTU5w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=azqtTU5w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDNo7JJPOTdFtcvdGrWk0cgAjCOm6cCzP3kh5nYeBMwc5fSt/sNojGhfKTwfGbl9Px8Ncasb4AssLd3nfiuJXxKKOSAcwGlo59uLjzVnF9K9i7Q8HsSy
    SASFupcGOFsGgLBRM5bk+n04tr+5pCqxJTjMbYwOXR8IsVLyt27xtOjvi3Am23/X6RFxCJInGuR4iDxVs7zCi+bS9N/ya4pxwHJk8eIoxyX7HmgIDur62qor
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=v2ayTJwUvYohpW15PQ4A:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757589AbeDICQB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:16:01 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756091AbeDIAae (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 140/293] ext4: require key for truncate(2) of
 encrypted file
Thread-Topic: [PATCH AUTOSEL for 4.9 140/293] ext4: require key for
 truncate(2) of encrypted file
Thread-Index: AQHTz5knzMXPRYytnEqNP6l05Oz3vQ==
Date: Mon, 9 Apr 2018 00:24:42 +0000
Message-ID: <20180409002239.163177-140-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:WpMaW993SODGrKTyE8RrrKwEtlA3c6lclasMf+QeNP4RCMxEVerO39LZmAYLZm+m+eWiA96sVbp2WzQkkogHi0w4Tfm4pCiptSi0N9rHYSGzqEpCE4HG2ym21ruunbYT2ic23H6YkcIv8yFaewakXheaUHtJc+UrvBKP1hElIoWj3C83iiQG2R6NeZPxMsQnU4UqP5cYAw+7tCl2dHWghTVbHNGX8z6mDvIOwMbNzBJQZqVpfW5R3aIhV5rm4znF;20:lQtEFz0Wr1qSCdxdR5OyGWD1/IiP1vw2rmf0c0L6V7IDIi3fOq71AcTCwPK6YGGh1THG6Av8+UJdKAeUcHv9pFR1rRIWL2gunKm+KK+XuXSM7Yz50Wy3Cxv3rLNaTs/PvZbX2fDiAjwKtxRRHzmYW9KriY0EBPjUbYba/FOOFWc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5659d917-20d7-4723-37b7-08d59db11858
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807EA3CB308806B34C37CC1FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lgD6XSJajIk/IxXVkg3fBdd8KgrZvBMu086MhW7IcIGxTUOV2PnauSCDKYQXUYmbwIy7DPvG8rXv7y3iMSqiuhnT3GuVzU9Sja093CG8Xw5odZAft9Ska/ouJ9HxvPEmSpKtrSwjSgqkXRIry841e3Ts1x0pXyWjAd8FpsuACBG6l4brlVPW9lJ0dxzS4UarVA5PGYByclmyuw1nbt3p/37SYh807a9tr69LeYLKiqkiqeQL1bfMp6oN1F1WHYYWN1Sl3mA+YpD0J/cbEq074AwgeLHHoBPyV7zgwhqnkDxcRKVbRsVGADWToH5wQqChNk+NvatigJmxllshNgzIbo8OQw5UGiyK+lsTsOVXe0bwHTwTbcLnm7RepZbz2ixI7RaHXxEQKj7mItlmuIu+Vth4P5SdINBdwKwnnc3hS60=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5659d917-20d7-4723-37b7-08d59db11858
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:42.5344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 63136858aecbe86dbd3c3289a3f46ba1b5f92239 ]

Currently, filesystems allow truncate(2) on an encrypted file without
the encryption key.  However, it's impossible to correctly handle the
case where the size being truncated to is not a multiple of the
filesystem block size, because that would require decrypting the final
block, zeroing the part beyond i_size, then encrypting the block.

As other modifications to encrypted file contents are prohibited without
the key, just prohibit truncate(2) as well, making it fail with ENOKEY.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ext4/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5cccec68a0a5..58d57c56ec62 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5166,6 +5166,14 @@ int ext4_setattr(struct dentry *dentry, struct iattr=
 *attr)
 		loff_t oldsize =3D inode->i_size;
 		int shrink =3D (attr->ia_size <=3D inode->i_size);
=20
+		if (ext4_encrypted_inode(inode)) {
+			error =3D fscrypt_get_encryption_info(inode);
+			if (error)
+				return error;
+			if (!fscrypt_has_encryption_key(inode))
+				return -ENOKEY;
+		}
+
 		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
 			struct ext4_sb_info *sbi =3D EXT4_SB(inode->i_sb);
=20
--=20
2.15.1
