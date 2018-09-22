Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F7EC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B9621532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NiRQaUsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B9621532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeIVURn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:17:43 -0400
Received: from mail-oln040092007036.outbound.protection.outlook.com ([40.92.7.36]:13118
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728836AbeIVURm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64P0Fy/P3deUds8qHKeXO6u0lM/pOylOndWfNQnjU5g=;
 b=NiRQaUsdr2cAhmmectpfgKyVU7H8bfEFsonTHBWcd1JZteSPPzSOVDlrGlOIQn93YAcr847+kotyV6iSGW2al8VPKGBJZgRKrRpX506Pkvue0B9pomm+BHgg7zi1VTpEuHA96T1h0o1Ah9XjGA4pRI3xY5FJAoBy/Ym2f6iPq9XxW0L5NtGEoCZSgxofJ+cjHrtc0k519thMhwK+ukYRm+JPX3uK85o2gRn8HhFj05YHTZ7DBZ9Kp6OBxWy5Ds6xJIwDFf43Is6n8QhFkw0xkGR/puHjht9L7KZbyi827jtQUZjmbN86pU7+WibINSnmmcqyDzKpM2h7YQaKDR+gkQ==
Received: from DM3NAM03FT028.eop-NAM03.prod.protection.outlook.com
 (10.152.82.53) by DM3NAM03HT216.eop-NAM03.prod.protection.outlook.com
 (10.152.83.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1164.13; Sat, 22
 Sep 2018 14:23:55 +0000
Received: from BN6PR17MB0996.namprd17.prod.outlook.com (10.152.82.56) by
 DM3NAM03FT028.mail.protection.outlook.com (10.152.82.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.13 via Frontend Transport; Sat, 22 Sep 2018 14:23:55 +0000
Received: from BN6PR17MB0996.namprd17.prod.outlook.com
 ([fe80::2cd3:5085:8114:52cf]) by BN6PR17MB0996.namprd17.prod.outlook.com
 ([fe80::2cd3:5085:8114:52cf%4]) with mapi id 15.20.1143.019; Sat, 22 Sep 2018
 14:23:54 +0000
From:   Karthik Nishanth <nishanthkarthik@live.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karthik Nishanth" <nishanthkarthik@live.com>
Subject: [PATCH v2] Staging: rtlwifi: remove unnecessary NULL check
Thread-Topic: [PATCH v2] Staging: rtlwifi: remove unnecessary NULL check
Thread-Index: AQHUUn/kOOQjU9rMkkq51p455v1DvA==
Date:   Sat, 22 Sep 2018 14:23:54 +0000
Message-ID: <BN6PR17MB0996855CE6529373A40A3CC6CA110@BN6PR17MB0996.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::30) To BN6PR17MB0996.namprd17.prod.outlook.com
 (2603:10b6:404:6e::10)
x-incomingtopheadermarker: OriginalChecksum:DEC7555DEBDD8D89E0EF61C513376FD024E4E99F95C16319A057557D71A1BF20;UpperCasedChecksum:0A0A76E1E8CA486A798787C4435EE019C220BD65E768B7519FFE98542BD5E52A;SizeAsReceived:7557;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [T4SaGB4uZZXmiVV4uRzi+R1s8hAMRE1a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM3NAM03HT216;6:gogERmViplFjmLrONxLT/XtDzaLL/JvadwBXkqrxvWXTkkA+3pIKZLD68C5NpkpOAFzEzRZNZlLVqO9apQCc8MrrBTJqxb8VTlsTpK/YquuUQ+ugcUARutrdVsS0z0Yw0ymxUCLh6xPA7At0rZg+lF4s4c6JnEKcq1QpKl1q+zshmpxUJUTL4CTKjgdmIVy7ZGazMif+tA/c42WPO4+4CZOp3gQ11GdF3jvZ53jqZcGYZinsMx0kShqLt9J/LRtJsZlLwsJKO+KnJ8Y4pwQhx7JxHEif2xl1PO+zvVk3yryp1gC5b600UYlMzHLYjI1HmNDF3BwBkvrx+c06JNlJgYO9h4yS2TU09vmuz5Gm+f4Gj423xGQr3mbMml0d4eN/X1z6TwmF6D7/kZmMndMdG5cX4tG73rnptzbIznaY3cZVlXuXgGm2p+wRu80LnRfqEV1IscAKj1rzvN0FxUhzxg==;5:Ftl8bc/Wlw7qm4SlH4DoWEhBWbMsIkCZ3zOe9xCzR85UdRFs0RsFn3ND7SaMLD48pNSn/LX82qjNXIysfb4W+5//cYwoz3KpM0VGUMd2ehhHlaXcVlYo+lncPibn9dfOcoGFoapoID+29PF/FpSSV6/Wmoo55KSbW1cVC2t7CQU=;7:ClJ43O1NlxUZaLcAQ+NLVN2P/swjxVfaQVDL2YIpaCQFdt9m/4L/HSkCf53K5TT74EDeL/l060SUG8svs1uTeftUhy/2/rg6qsR3VZbLQGRsvxGvPY5G2mYMMGNu3vjVNlgTiWPIoVZ5wx93zNVoaOaW4LwNjTwbcHRNV99fonL1Y0qUNCOCXvmW9pAwUMDcTD38os8lTVn5ovH8QHNxGiTQ0y7WQ0TbTEDCIoyUPOXaTWvNTyzVoa7f9s52EcQO
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: S/btQ8cKWiRNHt+mfxkJr/1FcEaiOcko4PyfmLZMaHihN7+oXhWim4XPFmIJ2WbCvFaGyaUHwC0mu9H11yH6OaSn9YW8zqJMAkRplBRxx7naH/OktT8mxjsJa0UqWHT9Dw5RNroDnmSF4q/TxDSwQHiOwi3tw9aO8DJ2hJh5Sw0//x6TY3/uju4SCsYgn8lkIucng+RKFWYlLu79G0g5qxjJFGJ5DbLxjXHr2FZLyBMmVtcXhzjC78bnBWiPcwi9dxVk38eIvRJfNlbBNZM+HK8jYZyb/8zfsqU5DiJkXvxjhBqWutNXvgixuT+kKNZ3Y7Ek2pVAMqUmUI2a2OHdHA8eKFFxBiTBYbj2jNAtNfnMo8aChRg2Qsso0OjctXM6Uxx1URN3i4dilLDhi0HdLBBx2nNvU/fSjOSa0aT2IQUxFGo5fGH+U8gtDcvgdFcDqWvGdXH2NfvF1/WMH/hJ5Jk3If4LPP9pmWyfG89bGmls9R9uS6YCh3/u68RMYJj2+SmmNrZcW8yIsjovz9IWFy9Rx9rTlJFKN538JuXWCctgZWgwE5RpYR1Qn+lfdFk0PD858UN9/RwWxWVmIIS3/pY/fEvA8HxjxoYt3viU510PmKOf/yViE2Ev6ymy5Tp5dCcVqivHil76fu7BUEW7se07EYQ9dhIY6fnOjxfXCBRK108e3iLfWw2p8oZvRwWTQLXbjZ/Ryf0aLnFBN3VkQy4j0Y3pCfZ/4h6+ECcdtAdiCaRUMr5SGdCQ0njxclQ4JXxqDcx5BW8=
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(201702181274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DM3NAM03HT216;
x-ms-traffictypediagnostic: DM3NAM03HT216:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:DM3NAM03HT216;BCL:0;PCL:0;RULEID:;SRVR:DM3NAM03HT216;
x-forefront-prvs: 0803A0241F
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(199004)(189003)(6306002)(82202002)(55016002)(33656002)(5640700003)(74316002)(305945005)(25786009)(8676002)(4326008)(68736007)(8936002)(105586002)(71200400001)(71190400001)(81156014)(6436002)(5660300001)(1730700003)(54906003)(106356001)(2900100001)(39060400002)(486006)(9686003)(7696005)(99286004)(104016004)(14454004)(14444005)(6916009)(386003)(56003)(476003)(86362001)(6346003)(97736004)(2501003)(966005)(6506007)(2351001)(256004)(5250100002)(102836004)(26005);DIR:OUT;SFP:1901;SCL:1;SRVR:DM3NAM03HT216;H:BN6PR17MB0996.namprd17.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: live.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nishanthkarthik@live.com; 
x-microsoft-antispam-message-info: rkG/RhjEMRByFnbLPeiQllcO5pBJV93n6jTtrDzIaOueaas7SKeQUvvoEh6LoHPonk+62zYaR2IQNK6yV5q2hFHJqYdGmJ3/YO9MIKl+rYD1d6tjRdWRK88DTPeifu1Ak4q9VqLu1t6sXvFxOZxE6SUTb05CosI0TwihD5zuyFqQUbW8lY8QtwJD7bdZs2PL/Ml2i5PXWUmj+zkS7U3jC2LvRARtCI4CW+RmilYME5o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: c001924d-3e68-4f40-89c2-901a49278da7
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eba28e1-8ae9-4305-6ff2-08d62097066d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: c001924d-3e68-4f40-89c2-901a49278da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2018 14:23:54.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3NAM03HT216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member regd of the struct rtl_priv is true in a boolean context.

drivers/staging/rtlwifi/regd.c:413:27: warning: address of 'rtlpriv->regd' =
will always
      evaluate to 'true' [-Wpointer-bool-conversion]
        if (!wiphy || !&rtlpriv->regd)
                      ~ ~~~~~~~~~^~~~
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/170

Signed-off-by: Karthik Nishanth <nishanthkarthik@live.com>
---
v2: changed the subject

 drivers/staging/rtlwifi/regd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/regd.c b/drivers/staging/rtlwifi/regd.=
c
index 3afd206ce4b1..5213ca771175 100644
--- a/drivers/staging/rtlwifi/regd.c
+++ b/drivers/staging/rtlwifi/regd.c
@@ -410,7 +410,7 @@ int rtl_regd_init(struct ieee80211_hw *hw,
 	struct wiphy *wiphy =3D hw->wiphy;
 	struct country_code_to_enum_rd *country =3D NULL;
=20
-	if (!wiphy || !&rtlpriv->regd)
+	if (!wiphy)
 		return -EINVAL;
=20
 	/* init country_code from efuse channel plan */
--=20
2.19.0

