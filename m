Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC95DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA7C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="j7Dl1eXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA7C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeJFFBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:01:48 -0400
Received: from mail-eopbgr700059.outbound.protection.outlook.com ([40.107.70.59]:28474
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbeJFFBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpuxBR8CTT4d6ljXnZxdd7ywz18poqXCXlrxlPlgNNY=;
 b=j7Dl1eXuq72TwlGYp+EgK6Vk//Y0O4NWhbwrugBva3VF/v0/WxvkfYl5+P3rSPBbhrkTv19vbV+O8FRGJgU7oJkkAv2AOLIpAUN3lee2Y9wJ82y/LGIJzFizz29vROSSmIxKREAE1P16/ElR3Qqbp12zaLTiYn2B024kqJK9tKg=
Received: from BYAPR05MB4887.namprd05.prod.outlook.com (52.135.235.153) by
 BYAPR05MB4312.namprd05.prod.outlook.com (52.135.202.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.13; Fri, 5 Oct 2018 22:01:01 +0000
Received: from BYAPR05MB4887.namprd05.prod.outlook.com
 ([fe80::a143:c9c9:a2e:314f]) by BYAPR05MB4887.namprd05.prod.outlook.com
 ([fe80::a143:c9c9:a2e:314f%4]) with mapi id 15.20.1228.011; Fri, 5 Oct 2018
 22:01:01 +0000
From:   Sinclair Yeh <syeh@vmware.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] drm/vmwgfx: Remove set but not used variable
 'file_priv'
Thread-Topic: [PATCH -next] drm/vmwgfx: Remove set but not used variable
 'file_priv'
Thread-Index: AQHUXJ4nHvYIpJqNSEaAlDLBmoVkR6URM3GA
Date:   Fri, 5 Oct 2018 22:01:00 +0000
Message-ID: <20181005215658.GA616@vmware.com>
References: <1538739418-151469-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1538739418-151469-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [66.170.99.1]
x-clientproxiedby: BN6PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:405:2::15) To BYAPR05MB4887.namprd05.prod.outlook.com
 (2603:10b6:a03:42::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=syeh@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4312;20:HpClEUfv2srVDEOYGGJN5Q74dDZXjGWnE+Oqd3IVnUeNkRe49UjFmdA0f5H3xQ3kyGdfH4fN02xKVQaOvHg508rmLXtFsJ4K2linMU+zPGzFLv8NhBJG6Xnht4dXZKyvRVh37dqLdqt4SavcpUjpYrPsYEZj2ZG0TPmzN0ed4Sg=
x-ms-office365-filtering-correlation-id: 2e092ba1-44b1-4037-0b60-08d62b0e0931
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4312;
x-ms-traffictypediagnostic: BYAPR05MB4312:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB43125DCC2451C000B54F4912A8EB0@BYAPR05MB4312.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR05MB4312;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4312;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(316002)(53936002)(54906003)(6916009)(71200400001)(71190400001)(1076002)(2900100001)(3846002)(33656002)(4326008)(58126008)(6486002)(25786009)(6116002)(6246003)(97736004)(86362001)(186003)(7736002)(76176011)(6506007)(81156014)(26005)(386003)(478600001)(68736007)(5660300001)(2616005)(36756003)(5250100002)(52116002)(81166006)(6512007)(14454004)(106356001)(102836004)(305945005)(8936002)(256004)(14444005)(105586002)(2906002)(476003)(8676002)(66066001)(99286004)(446003)(486006)(11346002)(6436002)(229853002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4312;H:BYAPR05MB4887.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aDRQnyxQlu7SSBA4//vBTMqcjJGQ8ZuhFVPZ3bfQo/eZz2JA7WAibMrgzyXitZj8u+uc7Paci9xYaVz+Ikl7qfaWrPadXi3ptD4W+DjM336AIKNLg3L1GLE9Hnr6Uf0wHv9t6Ppa7FJsGWx5hdtjf+kk0jheLTjjShOlmL0gxMeYpqsvCwjiHakCn3muoA2q2t5PB38XESaEAilUGtkUGs60TMYW+73UwNAFJsk25dUofgnWIHEkN0PNGpcxK/APnovLp1onLHaPLtHRDUzg+B+hvtDw8KglKghUG2ma/plwM2eQ1D1jlUEzON4N6frZY84l6gIdj6qiUcQyXoMOf4N5U85FBMJkZ3Oxx5n7E0Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17B741D74262A247BCB48575055CCD3C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e092ba1-44b1-4037-0b60-08d62b0e0931
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 22:01:00.9353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Sinclair Yeh <syeh@vmware.com>

On Fri, Oct 05, 2018 at 11:36:58AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/gpu/drm/vmwgfx/vmwgfx_fence.c: In function 'vmw_event_fence_actio=
n_seq_passed':
> drivers/gpu/drm/vmwgfx/vmwgfx_fence.c:909:19: warning:
>  variable 'file_priv' set but not used [-Wunused-but-set-variable]
>   struct drm_file *file_priv;
>  =20
> It not used any more since=20
> commit fb740cf2492c ("drm: Create drm_send_event helpers")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_fence.c
> index f872615..301260e 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -906,13 +906,10 @@ static void vmw_event_fence_action_seq_passed(struc=
t vmw_fence_action *action)
>  		container_of(action, struct vmw_event_fence_action, action);
>  	struct drm_device *dev =3D eaction->dev;
>  	struct drm_pending_event *event =3D eaction->event;
> -	struct drm_file *file_priv;
> -
> =20
>  	if (unlikely(event =3D=3D NULL))
>  		return;
> =20
> -	file_priv =3D event->file_priv;
>  	spin_lock_irq(&dev->event_lock);
> =20
>  	if (likely(eaction->tv_sec !=3D NULL)) {
>=20
>=20
>=20
