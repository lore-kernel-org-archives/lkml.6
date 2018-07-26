Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2188AC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8DC20852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="SpzzKUF8";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="Hc8lgyuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8DC20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ericsson.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeGZDdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:33:04 -0400
Received: from sessmg23.ericsson.net ([193.180.251.45]:56385 "EHLO
        sessmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeGZDdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/simple;
        q=dns/txt; i=@ericsson.com; t=1532571508;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ogz/Gbyz5vxSoJb7daJLE/f9hFPOg/bhKXlKUobMnXY=;
        b=SpzzKUF8iPcAXcl+yn1exrOsGWwWSkLA6CBZ6GPCQQ1fBXkebSptwiPQ/SMUin/b
        wBRd4QdaW6LY00SgAyCbLM5m+yeym3S0JYq3QUx65arzwG456oy6O8OLg/V+AIll
        A97q8AS1OJpQNuym9DGsXezN1EspbsiB2YcflwYcch0=;
X-AuditID: c1b4fb2d-20bff700000055ff-2b-5b592f746759
Received: from ESESBMB501.ericsson.se (Unknown_Domain [153.88.183.114])
        by sessmg23.ericsson.net (Symantec Mail Security) with SMTP id 40.DF.22015.47F295B5; Thu, 26 Jul 2018 04:18:28 +0200 (CEST)
Received: from ESESSMB501.ericsson.se (153.88.183.162) by
 ESESBMB501.ericsson.se (153.88.183.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Thu, 26 Jul 2018 04:18:28 +0200
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESSMB501.ericsson.se (153.88.183.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3 via Frontend Transport; Thu, 26 Jul 2018 04:18:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnj0WWo8O6F5fdFh0s+YhEDPhZ35Nuq/rdMUBGRgYyM=;
 b=Hc8lgyuLaIv8Hr5tx/846soRNzKAyNgm5DFGxHvBxkz+IVpB9i4pP7+3STTBKZ8QaIjYgAMwvnJUJyD15jpIFrZeuZypoFQGkGxuJTICG7OiQlOB5d8xLWpehYYe5o7diBMC75LJFSXDMgh6DdYlYkOzoyhTYIp2UxzRO7usjTM=
Received: from CY4PR15MB1575.namprd15.prod.outlook.com (10.172.162.16) by
 CY4PR15MB1669.namprd15.prod.outlook.com (10.175.120.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 02:18:26 +0000
Received: from CY4PR15MB1575.namprd15.prod.outlook.com
 ([fe80::6580:6b08:d88a:a6e1]) by CY4PR15MB1575.namprd15.prod.outlook.com
 ([fe80::6580:6b08:d88a:a6e1%2]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 02:18:26 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net-next] tipc: add missing dev_put() on error in
 tipc_enable_l2_media
Thread-Topic: [PATCH net-next] tipc: add missing dev_put() on error in
 tipc_enable_l2_media
Thread-Index: AQHUI/5ydF1yaPpDLkmb521eROg5SqSgxapw
Date:   Thu, 26 Jul 2018 02:18:25 +0000
Message-ID: <CY4PR15MB15757A375B11E1E6B6A0412F9A2B0@CY4PR15MB1575.namprd15.prod.outlook.com>
References: <20180725100049.20244-1-yuehaibing@huawei.com>
In-Reply-To: <20180725100049.20244-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [186.46.174.49]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1669;6:2acBmryXNlfv3lt/sfmGP6uvBY4wPMsNAy0XGzI9I0KAm610ly9tdgZqsZHAhyaa6A35U++gvObhvM5v2MRNm7bhwvx0DZhh4D1JicFk3HgIfPGmy8cV1wDAS8hZHGWWtTtX/NtCVdlUte5fXIdGUUYyOZuGLrBvBcbYe2hdV0k2WvzE/OBZv5PYIPG4bLtdCgJfuqBtaiEKlWhpaq9WcbKN2bcgnVGjSiIjTzDyl7EDvdzEXdL/YBtMCULGbixnRTAaNglghdbXiGHyZd9CZHhGt7iq04ljZ+1N90jFC6RWvjnG7bzE2+h7sptUyzyRL1ers+oP8s1dscTAdg0L8FXv8aQIcqMCKeNrvBJTOcL3zVZATlPo9LiOx7uRgwh9mC8fiwuAHJoiJvucwfHJd2kTyDb4/RIiNnvwzHKfi4ScDeTWcnazdtPNr664Bvzrh1QPKTleryNKz59tFHqrig==;5:KDOq0JG56KiabeAOxmFnR/RFzliVUbZKz82+R7Q3m3pCurWF4FsJ346IO4YS9DhCKISmpccG2Nx8m8wnbBn34WW/wekTk5ecmEJsCo1RoK41yT95f5Yho3FkCbw/gXQ5cwPzLpcWOcpWEAi6q1XbxGaCyC9mA5qdMlIvisSHBmM=;7:okwlbfC43Z13U3I9SR66PDWKQ/jFKOMP9/2NSyqX068oVF8nk0bFN4vpLrSPz5Gk7rYRemocpRwglyYtDSstk7fmsZKJKVOFXZY1elN2oURCgb9s6gV2TE/GMaGSTqgg5di9qrLNEdWyit34XWEUGDHVnBx3QkthzQVLyyIjXsr0akXZTL2utV5sZg8/OYE/8uJcrRgoslC5mP5fj35j5Lh7RaYi083ah74Ts1GbB99OYcvduTui8xXzpYYgMWZA
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 88134ad0-606d-4b40-b349-08d5f29e11d6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1669;
x-ms-traffictypediagnostic: CY4PR15MB1669:
x-microsoft-antispam-prvs: <CY4PR15MB16697E6EE0CA233D30CD6F9E9A2B0@CY4PR15MB1669.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(9452136761055)(50582790962513)(42262312472803)(248295561703944);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR15MB1669;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1669;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(13464003)(7736002)(74316002)(5660300001)(81156014)(25786009)(81166006)(66066001)(7696005)(76176011)(14454004)(4326008)(305945005)(2900100001)(8676002)(8936002)(97736004)(2201001)(6506007)(53546011)(9686003)(102836004)(478600001)(2906002)(53936002)(86362001)(6246003)(55016002)(229853002)(5250100002)(2501003)(68736007)(186003)(106356001)(316002)(54906003)(110136005)(446003)(11346002)(105586002)(6436002)(15760500003)(99286004)(6116002)(3846002)(476003)(256004)(33656002)(44832011)(486006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR15MB1669;H:CY4PR15MB1575.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TK4R8eoz6IfG3nPrp6J5BDjmL5d8lXoD38tVhHgmiVI4J4A7v6bgr/UKOEWnDG08FWuuJ0XjaX8S23wR+yOzQ9NFiH9Xvrc0hLGn3yrJDtrWuFJE4QnQXlVNikx/dRwndJe2Xc7fpdFnGvZZZjuUe4vQyS+KzL1wzoSanBg3m1zQ+r7vWX9UK62z+qrczwbLdAqtY/sHSUddLuptKXQcOEdEA5mTA4darx2roeg1N1Vys0A11tfliyoVDSGHbZPQdu3zqIBOf631jBkgn0zIGWq2ThxZWxjeOVxuKzx42jshSOEQDIIIZ7j7Z5e2nSZYI8jvDw1E+DXpb2Mpe+koGX2CfAP6rMsrYa26X3qOwUE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 88134ad0-606d-4b40-b349-08d5f29e11d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 02:18:26.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1669
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85m2fLwevy8uANGkimqWkRwyQSKvelKClqzqiRJzWv7Zho
        9cFSaN7KMkNt4QqTUiNT07yi85aaGWpaJqbOS9NKUbKZGrkdg779/u//x/NeeGlS/JRnT4dH
        xzGqaGWkhC+k8k5XqzzivOSKXXNTvlJNbwol7a/V8KXtWltpZe9FqX5oiJSO/JyhDvBllc8+
        EbKU1u88WZ12iZAtlTvLXlS+Io7xgoR+IUxkeDyj8tp/ThimXvzKizUKEspm+/hJSEOnIQEN
        eA98qC7hpSEhLcZtCEpvNyMuLCNI1mWQXCgkIPdNMmEKFM4iYTh7xIJrsgkYnKsguDCBoCbf
        iEyT+dgVDPfVZrbGagSds7YmicTdCPrqbxGmYisOhjxNJslJZ6BGryU49oGulDGeiSnsAjdz
        migTizb8jIwhsy/GvpCjnzBvIMD74POdFrODsC386io1zyGxHQxPFhDcVTEU1veSHNuAQf9n
        Yz694cuhe0rOLW+D9f60TcUJ+grSzY8BuNECCuY/8rjCAxZycjalI7DSuE5wUgeCnoeriCvc
        IPlbO8VxBDweMG5K6QgWUhc3JWcozhynspB3/n+H5XgnaOsW+Ry7Q9GjOTLf/ABW0Jk3SWkR
        VYxsWIZlo0J9dnsyqvDzLBsT7RnNxJWjjf/TXLnq8RqVzPnrEKaRxFI07SxXiHnKeDYxSoeA
        JiXWooMtpxRiUYgy8QqjijmruhzJsDrkQFMSO5FncX2QGIcq45gIhollVP9aghbYJ6HMkRPD
        bcvzARU1o7TX0cNO1+Rvjb8Ds3Re/mtWY4ewq+6C09pLw47gAUlD00LxuIvlF4XhLn3JPjd1
        zHFyhAm7Org3wEGqMQhCWwZcV+69e+CothvtKehIqLr+vAH53SjyPP6jy+h3svWJbUvt9tbp
        KpsZoLcoaiLfl7hXW5cFSig2TOntRqpY5V+jnfDyOwMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked
///Jon Maloy

> -----Original Message-----
> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On Beha=
lf Of YueHaibing
> Sent: Wednesday, 25 July, 2018 05:01
> To: davem@davemloft.net; Jon Maloy <jon.maloy@ericsson.com>; ying.xue@win=
driver.com
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; tipc-discussion=
@lists.sourceforge.net; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH net-next] tipc: add missing dev_put() on error in tipc_en=
able_l2_media
>=20
> when tipc_own_id failed to obtain node identity,dev_put should
> be call before return -EINVAL.
>=20
> Fixes: 682cd3cf946b ("tipc: confgiure and apply UDP bearer MTU on running=
 links")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/tipc/bearer.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index fd6d8f1..418f03d 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -395,6 +395,7 @@ int tipc_enable_l2_media(struct net *net, struct tipc=
_bearer *b,
>  		tipc_net_init(net, node_id, 0);
>  	}
>  	if (!tipc_own_id(net)) {
> +		dev_put(dev);
>  		pr_warn("Failed to obtain node identity\n");
>  		return -EINVAL;
>  	}
> --
> 2.7.0
>=20

