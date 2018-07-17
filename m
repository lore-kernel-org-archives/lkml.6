Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D847FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8127D206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="ALs+LrMv";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="k15ueeV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8127D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ericsson.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeGQUYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:24:09 -0400
Received: from sessmg23.ericsson.net ([193.180.251.45]:57522 "EHLO
        sessmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbeGQUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/simple;
        q=dns/txt; i=@ericsson.com; t=1531856997;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZClv4zwGj1lxjibazmYtTssbEqOflaQtB9BpRUiJy8Y=;
        b=ALs+LrMvKsg/2VQrY7HNiXvDJ2Z3nlq8KqiRQmHlAkJ/683MC2RLwjswzmIaUZzP
        mby3/efFsYZIvTURVqaPCD6y9oA9Mo29DlZ1xB7b8gzz2dAsqPD3EgjaltPS+SWx
        qQfr7iK7P/cfvNiLOIDveTJod/m9TApH5TjD15gwR70=;
X-AuditID: c1b4fb2d-20bff700000055ff-da-5b4e48659562
Received: from ESESSMB502.ericsson.se (Unknown_Domain [153.88.183.120])
        by sessmg23.ericsson.net (Symantec Mail Security) with SMTP id 42.BE.22015.5684E4B5; Tue, 17 Jul 2018 21:49:57 +0200 (CEST)
Received: from ESESSMB501.ericsson.se (153.88.183.162) by
 ESESSMB502.ericsson.se (153.88.183.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Tue, 17 Jul 2018 21:49:57 +0200
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESSMB501.ericsson.se (153.88.183.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3 via Frontend Transport; Tue, 17 Jul 2018 21:49:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HkyeWFA+W9aY5b3Yd5DPZ8p9oaQDbqgZaCKGHkxRZE=;
 b=k15ueeV8JOr6rQFRjzSbU+p3gMW24UDkS0ZWdnsUdP0BoHbrhSZGc9/4A2igJgsmDdo6CMmkY5OTIYFkDAFLhTqi9T9PUSq0bStB8SXLVzqqDfsJTChJOnvHKQIwVc8UIH7i/9zMKDUEDaPDVJTSN1SZeoJiF+VPGmVsayT/IFA=
Received: from CY4PR15MB1575.namprd15.prod.outlook.com (10.172.162.16) by
 CY4PR15MB1640.namprd15.prod.outlook.com (10.175.120.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 17 Jul 2018 19:49:53 +0000
Received: from CY4PR15MB1575.namprd15.prod.outlook.com
 ([fe80::dd16:f8c3:a7bc:2efc]) by CY4PR15MB1575.namprd15.prod.outlook.com
 ([fe80::dd16:f8c3:a7bc:2efc%3]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 19:49:53 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net-next] tipc: remove unused tipc_group_size
Thread-Topic: [PATCH net-next] tipc: remove unused tipc_group_size
Thread-Index: AQHUHdhswZJdpjWG0UGF0njE58xgsqST0t+A
Date:   Tue, 17 Jul 2018 19:49:53 +0000
Message-ID: <CY4PR15MB1575A6E38DADDF8A686B1F369A5C0@CY4PR15MB1575.namprd15.prod.outlook.com>
References: <20180717141123.9684-1-yuehaibing@huawei.com>
In-Reply-To: <20180717141123.9684-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [192.75.88.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1640;7:Z9LODujOFcwm8oqzIipRQSn/pH8hCi3RIvaDnxCtzL9DDLQZIMS8NLVljhX+B5RldEgmLLP8YYxDiRrncim59A0nOxFli/gF/ZeqG50L2b2w55ho2Egqwyp2efb+X4vnJIOE9B8KivMnyvqGxAaTOU27D8Elw7FEnLcgYh56JvejTq+5QcbcPuwOUzkf4b5BAeaLl9+69h0AhQgQzvak4MN2EzomsHgedRZ5wp5vmLztQ7l4GtgZTyG0nAb/+Iv/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7801b6e3-9d07-455d-8c2e-08d5ec1e771c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1640;
x-ms-traffictypediagnostic: CY4PR15MB1640:
x-microsoft-antispam-prvs: <CY4PR15MB1640012B40B305B05B703FDB9A5C0@CY4PR15MB1640.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(9452136761055)(50582790962513)(42262312472803);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR15MB1640;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1640;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(13464003)(189003)(199004)(66066001)(11346002)(486006)(316002)(55016002)(476003)(2501003)(305945005)(74316002)(5660300001)(4326008)(68736007)(97736004)(446003)(99286004)(6246003)(53936002)(7736002)(33656002)(3846002)(6116002)(54906003)(110136005)(106356001)(6436002)(2900100001)(5250100002)(105586002)(26005)(478600001)(25786009)(53546011)(76176011)(2906002)(7696005)(102836004)(186003)(6506007)(8676002)(9686003)(256004)(81156014)(81166006)(8936002)(86362001)(14454004)(2201001)(44832011)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR15MB1640;H:CY4PR15MB1575.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jxIdfWe9vGm1X1bPXpEqNTJnVFcgWo8KkckatJtILzBfiueIMGc7AQrhPnnKxvP75KuYqu1ylh9TkszcxpxmVdGjufFhiGJj4h+1MxH8PayYx+LMIVbiB2plk+zV62UekKusEt0FwV1JZKpKUGunz21bS/sfliZC/fI7NBLqWgl1qB12RZbcBnpQj236xP5EZT+wdt9a+IthkEOJeLs6Tfv33vgwm3clGfU3DDdJihXyCn7of5yo96AlU3JGAPHFR2TKJLyP+Fjsvv+/U+3alkgeBW8p/cjGZD0T8OKLvNQePJkJ5Pj+HMwv40cYMQRH/ONjWx0CJRafa1wQo6vK36zBEv2aHBJ4iRHjeO6KJqw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7801b6e3-9d07-455d-8c2e-08d5ec1e771c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 19:49:53.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1640
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH932e585zOH07nM+0tE5WiDqaHemHzNw/lNUfIXHLE/Jz9yDU
        FpuaiWMZopMfsyZaml2j3Gp3YXQ1jZkfs1Z+jEuWWCXNyXOPtv57fb6f9/v9+Xy/+9KkpEXg
        SqdkZDPqDFWaTGhL1V3szvNhlJGxR2deyRXa4WJKMfpSK1QMNEkVuuFritnxcVIx/WOBOi1U
        6h5PEsrivmWBsrdpjVCudbkpO3XPiXOCGNvgRCYtJZdRHzmZYJusWTCjrNeiPJNpmSxEczal
        SEQDPgbr3ZuoFNnSEtyPYHpgw4YvfiJ4N90g4ItWAr5PT1FcQeFKEsbqOgjOL8FVBJRtXeVV
        Mwg2Bu9Yg4X4EJhrShDHTrgEwdAXKScisQnBiF5jdTviENAZH9rwojOg2dLuGPzgnqZCWIro
        7XEeMPZRxKEYX4KJWnd+biCsmitIjkU4CJYrH1idCEvh19sn1nQSu8DUXCPB3xNDq36Y5NkZ
        zLMWAReJcDSY5qP54/1g6Hkm4HkvjDTetT4LYB0BE0WLiG/4wEp19U5OBCxOdgt50QcEhqeb
        FN/wAstoEcUNAJwK2sFwHgvAoAvmFW7QXv6ZqkTy+v825fkwNPWuCnn2hkfNSyTHYrwbhurm
        qCZEtSNnlmHZ9CQ/f19GnXKFZTMzfDOY7C60/XMMuj8+PahjKcSIMI1k9uK1gMhYiUCVy+an
        GxHQpMxJ3L8SESsRJ6ryCxh1Zrw6J41hjWgPTclcxL7t+hgJTlJlM6kMk8Wo/3UJWuRaiDzs
        5Ftx1NA39+HrUaE9Nsft2+YWWt+rggYLWywBvy0xN/X68E7HogRGc8Phfuc+xsHTO+xgVb39
        hTb/EqbM0n/eKUcuLqT7QmelgWdHkmJzc5olt950Ok952q1nfzoR1eB2e1PfVjLyIvVAfE1t
        udQhONHzco8p7ut8hcyw61SYjGKTVXIvUs2q/gJSVDJtNQMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Jon Maloy <jon.maloy@ericsson.com>

///jon

> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Tuesday, 17 July, 2018 10:11
> To: davem@davemloft.net; Jon Maloy <jon.maloy@ericsson.com>; ying.xue@win=
driver.com
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; tipc-discussion=
@lists.sourceforge.net; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH net-next] tipc: remove unused tipc_group_size
>=20
> After commit eb929a91b213 ("tipc: improve poll() for group member socket"=
),
> it is no longer used.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/tipc/group.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/net/tipc/group.c b/net/tipc/group.c
> index cbe39e8..8f43e7d 100644
> --- a/net/tipc/group.c
> +++ b/net/tipc/group.c
> @@ -159,11 +159,6 @@ u32 tipc_group_exclude(struct tipc_group *grp)
>  	return 0;
>  }
>=20
> -int tipc_group_size(struct tipc_group *grp)
> -{
> -	return grp->member_cnt;
> -}
> -
>  struct tipc_group *tipc_group_create(struct net *net, u32 portid,
>  				     struct tipc_group_req *mreq,
>  				     bool *group_is_open)
> --
> 2.7.0
>=20

