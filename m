Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174C1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0B52172D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Ahu94Kms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0B52172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeHUAKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:10:31 -0400
Received: from mail-sn1nam01on0066.outbound.protection.outlook.com ([104.47.32.66]:53942
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbeHUAKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBZUwStDtIRXY+afSXrvP57IDr04bKARedbjP6gVRG4=;
 b=Ahu94Kmse/RVo8oDJRv4/QNizZrIjFAT7SGyIrO6Sz//TXb/Cai0hdv2FKtNQOuZ9bPE561+/9OQPw2PEMvJ/oQNzyNSdcf6rNwRiSS7ReLtlrNcEO8fWcoI22rzsHAj/a+vWoP1LaVJ3KuZZb68T+0dJ3Yr3JaFFkOp8Y9v/vo=
Received: from BYAPR05MB4181.namprd05.prod.outlook.com (52.135.200.140) by
 BYAPR05MB4615.namprd05.prod.outlook.com (52.135.233.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.10; Mon, 20 Aug 2018 20:53:17 +0000
Received: from BYAPR05MB4181.namprd05.prod.outlook.com
 ([fe80::fd5a:fb5f:9b1f:4db6]) by BYAPR05MB4181.namprd05.prod.outlook.com
 ([fe80::fd5a:fb5f:9b1f:4db6%5]) with mapi id 15.20.1080.010; Mon, 20 Aug 2018
 20:53:17 +0000
From:   Deepak Singh Rawat <drawat@vmware.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [Linux-graphics-maintainer] [PATCH] drm/vmwgfx: Fix potential
        Spectre v1
Thread-Topic: [Linux-graphics-maintainer] [PATCH] drm/vmwgfx: Fix potential
        Spectre v1
Thread-Index: AQHUNZekvSLtsC4/3Eujy23VuUgFKaTJI7CA
Date:   Mon, 20 Aug 2018 20:53:17 +0000
Message-ID: <BYAPR05MB41817986B00F59780A68D63CBA320@BYAPR05MB4181.namprd05.prod.outlook.com>
References: <20180816193015.GA12093@embeddedor.com>
In-Reply-To: <20180816193015.GA12093@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4615;20:zNh8nydaRXHi7vZnJCemDMgEZlNpsGULItDTnE3GWDf1BSk8WdLMij72xVxWZq/+szM3w6Quaa392jxjvBZBHSG2D20a+HIf6Fjz+SKljdz8T+cB0TohAEQ81tgok/4tlWsiO2aK+8utrMaB0ed2Qc5Ro6+OW5SHvhmH86pO+QE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2d928cd0-14b4-44ca-3b86-08d606def4d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4615;
x-ms-traffictypediagnostic: BYAPR05MB4615:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4615B2FBB07CB57BB285FDF6BA320@BYAPR05MB4615.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055)(189930954265078)(219752817060721);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BYAPR05MB4615;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4615;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(189003)(74316002)(7736002)(14444005)(256004)(6246003)(305945005)(81166006)(81156014)(76176011)(7696005)(2900100001)(33656002)(9686003)(6306002)(45080400002)(316002)(229853002)(110136005)(55016002)(54906003)(966005)(14454004)(25786009)(6436002)(4326008)(478600001)(446003)(5660300001)(53936002)(102836004)(6346003)(2906002)(186003)(66066001)(6506007)(86362001)(8936002)(97736004)(105586002)(106356001)(486006)(11346002)(5250100002)(3846002)(6116002)(26005)(99286004)(68736007)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4615;H:BYAPR05MB4181.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com; 
x-microsoft-antispam-message-info: S7nf67xhM1Q+MLofuxhxX4ApqzT1iNESbR13qoYSlgPwa/6iQrOuNm1TswSSnZx8ATfzV/RmI+yTIuLtZxfqrv9JIjms9y9v5z9DL3y/i1RA4mXwcbI7OyjPON7lfX9xq63wFT6BuIIQg4+YYL270ehjJKahKaBQjxik3peaoRZbhYKlTcomcy/ZVLedhMJs1zSAK6MrEdcqqCpGYj5zzaANYqeWFApXa24HuMhyi+RJBilKaOXJOra3O9Vol2hekFzOvCB72WyO05e5pHK5hP2u+NzWFSw0A9NOhFwX/MSW5srCbx8/H30PyXXEmohlYVEGKWD2pVw5dSVTfGj/HadOMC93RvvEWHlwoypNl60=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d928cd0-14b4-44ca-3b86-08d606def4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 20:53:17.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me based on my limited understanding. Thomas/Sinclair can
could you please review and then we can include this in drm-fixes.

Thanks,
Deepak

>=20
> arg.version is indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
>=20
> This issue was detected with the help of Smatch:
>=20
> drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:4526 vmw_execbuf_ioctl()
> warn:
> potential spectre issue 'copy_offset' [w]
>=20
> Fix this by sanitizing arg.version before using it to index copy_offset
>=20
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
>=20
> [1]
> https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmarc.i
> nfo%2F%3Fl%3Dlinux-
> kernel%26m%3D152449131114778%26w%3D2&amp;data=3D02%7C01%7Clinux-
> graphics-
> maintainer%40vmware.com%7Cf010b707b8ef4896c1a908d603aebcc6%7Cb39
> 138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636700446365603728&amp;
> sdata=3D0D8lnUScxOmCCWXLHh8Otc3o%2F1yF1SxgGwIklRdMlXY%3D&amp;re
> served=3D0
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 1f13457..ad91c6e 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -25,6 +25,7 @@
>   *
>=20
> **********************************************************
> ****************/
>  #include <linux/sync_file.h>
> +#include <linux/nospec.h>
>=20
>  #include "vmwgfx_drv.h"
>  #include "vmwgfx_reg.h"
> @@ -4520,8 +4521,10 @@ int vmw_execbuf_ioctl(struct drm_device *dev,
> unsigned long data,
>  		return -EINVAL;
>  	}
>=20
> -	if (arg.version > 1 &&
> -	    copy_from_user(&arg.context_handle,
> +	if (arg.version >=3D ARRAY_SIZE(copy_offset))
> +		return -EFAULT;
> +	arg.version =3D array_index_nospec(arg.version,
> ARRAY_SIZE(copy_offset));
> +	if (copy_from_user(&arg.context_handle,
>  			   (void __user *) (data + copy_offset[0]),
>  			   copy_offset[arg.version - 1] -
>  			   copy_offset[0]) !=3D 0)
> --
> 2.7.4
>=20
> _______________________________________________
> Sent to linux-graphics-maintainer@vmware.com
