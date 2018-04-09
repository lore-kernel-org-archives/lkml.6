Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234171-2-2204632148378451235
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
    1523234170; b=DiY7fqstu0pyvkV555G+XGcGm7JsJLQzbRavItxUtrbzXt+/F0
    JiKgF5GLyl0V5jz6sO1k5mPrUu0fzwzH0iTk3AhaWfVIA0ld7mkj+ZLfdY3aqKAW
    sTp6nWDn9gl6sV13cbUDPAeFvWV2tUgJs7S6t8D9BiaG2tnJxEN9TKgbfNwYyhgP
    cgE2xUWyJgW22mi7W2w4MTMToTpKIWIUIsagfAIgqwfvwwZgBx8r8i+EUrpj7DSO
    H+NpVoJ7bwg9QHgaTd2VJghVhukg9EkgCFGvtfd1OMNs3/S0G92UDzc0hZFDhrmZ
    SvHfVbfqFpCxTqCwv+Pvyl8lO3HuxoBeFUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234170; bh=zAWPdJFTaC
    bJUo81T7tU236lyFMLu6S1VTV/jN+Uc6k=; b=RLIMTet9dEehnWvhE5X1VHJlLI
    7/OonGKsor+LdfXCThvQ6rxzxu3qEPSA98OaTZow73SHtlToAO0lxB5A8RNnaIGb
    K0BzhzVV56XCtf6PhACifQpBxHnlrwN+2ixYbE7cK8xjeIf730zjGQj6irfTYdHN
    /qKZEF1BgVRn/59CsON7KamEBqXLzRUBJcUygcljYHW3fohxxp402CvKHC8ziCvr
    5bnbIdFB0UA1q8aTRVxm/Tl4M4ML9SvhrsmrFTyt/7Za28yM9Po/jMLwTX15npZL
    N7SaSz6RUVi/c9l+aKt9UXFlxFcVXYctUioA3SuKDzmNGO5i2pYLiGQAQAfg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VkytXdFW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VkytXdFW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA6zmZoK5JW1Y6Y7MkjWkZ1VwselhvwwZa4eCwZs+VfI32KelipenKprJ9HBxlEvuGYIz4K2V6LbUnis/UuGgT20Mfpa6fPmCKvpI5+RxP6I9M267Ya0
    iA3EVAdjDu8FKHM244HiTH2nLdHYGAGxYtWOG79sQRx+uVVP5JIWFcFqXZtC2l9f7YhOaEXur9OmeyOzJe/MnLaIfC+D50diGuRMqx6gOtQz9ZIQguLbGJ3z
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=sLElGgjd5OrDGVp6BKMA:9 a=NK6uLVygNTIT7gyA:21 a=UcunAN-FmZF65z0e:21
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756661AbeDIAgD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:03 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:40736
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756640AbeDIAf7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 047/162] Btrfs: tolerate errors if we have
 retried successfully
Thread-Topic: [PATCH AUTOSEL for 4.4 047/162] Btrfs: tolerate errors if we
 have retried successfully
Thread-Index: AQHTz5mnLhKcxHuwAEyYpE+J93iSMw==
Date: Mon, 9 Apr 2018 00:28:16 +0000
Message-ID: <20180409002738.163941-47-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:4kGB3dhUOsJT1C57hUkmJOmau7HSVkwS8FgvlynrkyRD8slCCF3WzNYFtzLEPKyAWBvoWFOSmOc+KyzhIRxSS2tATtGohWtkZVhAyiyyZYZzI+kdfd9Bn8/Kp2J3J8u5GfX6Qyq8e+/RF4ZoaOYoG126V3pi+edi4ASMWOe+4HtKmvRprY3j7dgS+B1M4ltP92uadiz9EX1Ia3RpOWuVX2c9eA4HOVtEIEjKq0xYRQLSUBUkvLvqV7cOS7jL1duc;20:yQi7tbCy6T1VKApXsNbK2XJNUptDC6Zn8OTCidcKc8TTJSW/eE/AOn0e1g9AOMP0700gUblLyCvAIfS4DTMSYzFPwTClCa+oDM6tOQGw10Vg7U2OndA0qyO3Q7Mi/rd4xCMgeknwPmhT6QEhBT1cACIs2HZw6YNExRIhg/lBAgg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4217b334-3471-43a7-c52b-08d59db1dc69
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10152DF3170E6EA6079C7751FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kbPvQiUj9h5Fod5OYdRLiHsN3oJX7Ypu6y3YPtq0nwmeqnX4uGaiRFMaPpGqk5gdbOIr+fsP/QVUxA1pKheS41yBGarGe9qcCtwVJtH6K/hoMHV5+JpdF4lmP/lt1OSEUjxlJp5f4e+3v3CyFnOAHAXcI9sCzK0KYFiED7F8T26uOMQuGJ3zyFU1BSo3TNNq60DMag4qH0PGRzUdICcrKJNskd6/VANE+KCGkb+lIkf07EvkGHIpvgjWfvTSoM7QSHx5lqREe2kqPY7bMlVYvbp+YT25KxsvVjBazvC/W8I50PVKu33mL2jSw8JYVUWfuO44NfEo4Nb2d9+NlznJuz3IiW6fmHaNWcKjn5NXJf1PzlPNNncQRhYn+9hPYDgYUndIvZQFvuRPZLUF6v4CPTNLyHqUPlLsxWgoXa7Q5zU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4217b334-3471-43a7-c52b-08d59db1dc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:16.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit e3d37faba2eb19a1d459917bbf54ac1c65711510 ]

With raid1 profile, dio read isn't tolerating IO errors if read length is
less than the stripe length (64K).

Our bio didn't get split in btrfs_submit_direct_hook() if (dip->flags &
BTRFS_DIO_ORIG_BIO_SUBMITTED) is true and that happens when the read
length is less than 64k.  In this case, if the underlying device returns
error somehow, bio->bi_error has recorded that error.

If we could recover the correct data from another copy in profile raid1/10/=
5/6,
with btrfs_subio_endio_read() returning 0, bio would have the correct data =
in
its vector, but bio->bi_error is not updated accordingly so that the follow=
ing
dio_end_io(dio_bio, bio->bi_error) makes directIO think this read has faile=
d.

This fixes the problem by setting bio's error to 0 if a good copy has been
found.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 81b5a461d94e..d56520e52dce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8029,8 +8029,11 @@ static void btrfs_endio_direct_read(struct bio *bio)
 	struct btrfs_io_bio *io_bio =3D btrfs_io_bio(bio);
 	int err =3D bio->bi_error;
=20
-	if (dip->flags & BTRFS_DIO_ORIG_BIO_SUBMITTED)
+	if (dip->flags & BTRFS_DIO_ORIG_BIO_SUBMITTED) {
 		err =3D btrfs_subio_endio_read(inode, io_bio, err);
+		if (!err)
+			bio->bi_error =3D 0;
+	}
=20
 	unlock_extent(&BTRFS_I(inode)->io_tree, dip->logical_offset,
 		      dip->logical_offset + dip->bytes - 1);
--=20
2.15.1
