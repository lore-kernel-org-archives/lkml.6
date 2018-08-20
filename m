Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBCFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D0A21531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Fq8cBPDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D0A21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeHUAva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:51:30 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:45632
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbeHUAva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6/lofnNFIr5B3ocm+800RoSwVcn85h/Fx4+Cxx6cKo=;
 b=Fq8cBPDzuZMB+35WCar798YT0OAEf1HJf84IP3LFvrZ6wFtaOGJoHp6TB4ENL0H/bVS/GNSf56H56r7XThW4QQHhibHX5uq6O2Y+8p/cCJQB2QZSp1ZOf4Cu/KDifjvzlPu9OcTwLMR/uMV0GTF7LMTi7P4BTPim0iMxNF1l/aI=
Received: from BYAPR05MB4181.namprd05.prod.outlook.com (52.135.200.140) by
 BYAPR05MB3989.namprd05.prod.outlook.com (52.135.199.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.11; Mon, 20 Aug 2018 21:34:08 +0000
Received: from BYAPR05MB4181.namprd05.prod.outlook.com
 ([fe80::fd5a:fb5f:9b1f:4db6]) by BYAPR05MB4181.namprd05.prod.outlook.com
 ([fe80::fd5a:fb5f:9b1f:4db6%5]) with mapi id 15.20.1080.010; Mon, 20 Aug 2018
 21:34:08 +0000
From:   Deepak Singh Rawat <drawat@vmware.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        "ajitn.linux@gmail.com" <ajitn.linux@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: RE: [Linux-graphics-maintainer] [PATCH] drm/vmwgfx: Convert
        drm_atomic_helper_suspend/resume()
Thread-Topic: [Linux-graphics-maintainer] [PATCH] drm/vmwgfx: Convert
        drm_atomic_helper_suspend/resume()
Thread-Index: AQHUMa8tGVSn47onSUynMSmbeLGea6TJNnkg
Date:   Mon, 20 Aug 2018 21:34:08 +0000
Message-ID: <BYAPR05MB4181991EA79CE952D9F8C398BA320@BYAPR05MB4181.namprd05.prod.outlook.com>
References: <20180811201147.GA14169@jordon-HP-15-Notebook-PC>
In-Reply-To: <20180811201147.GA14169@jordon-HP-15-Notebook-PC>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3989;20:MdyRj43wBwNkb0eRxsR8udyEGn4wHjYNUiemoFWehfqFyMy2Rxq92cciKw+58ubJRsI26EmjMhc5IDJGa2IRmXJ96oTUzGA9YBeTBaza2pHYrpSbKj+j4fCPlASlLfx6SiZRujb/ataKYaEMDXrn/iBrRnVpPpshim/IWNkDnMI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 217be592-5a51-437c-9541-08d606e4a96e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3989;
x-ms-traffictypediagnostic: BYAPR05MB3989:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB39898C1B8EB1EC4DFDBB58D9BA320@BYAPR05MB3989.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR05MB3989;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB3989;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(346002)(366004)(51914003)(189003)(199004)(39060400002)(4326008)(53936002)(305945005)(11346002)(81166006)(81156014)(7736002)(74316002)(446003)(476003)(256004)(14444005)(102836004)(55016002)(86362001)(9686003)(2900100001)(6436002)(6506007)(186003)(26005)(99286004)(105586002)(76176011)(5660300001)(54906003)(2906002)(316002)(2501003)(33656002)(5250100002)(6116002)(7696005)(68736007)(106356001)(478600001)(14454004)(3846002)(8936002)(66066001)(25786009)(97736004)(6246003)(486006)(229853002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3989;H:BYAPR05MB4181.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0BPwUIiFZo46/FBogoP4H85G04lmtpZD6eai1NIku3SaRR14gAA48jqHty0T87C78TKOJ409gM8178hiU21Pfg68sLvKGkHMTNzLKMetez5Zb6C5QZEIp4anQNvywOPvYVYRdmELJOq79VtDsuaQHtiHpQ81tL+O/LeUJjnuBap4M+uliNpuB/2pYcudMelV+aFOVvyJBzFT/tDIt6sMTpLPEOpfi5abQXnASEsqFEEvLH6FSAcolDvFrhF5iUQWNSiiELX3rnPqw82r13EfyVRQEh9uEEZ7K7bexrGg57whKGqGfo+QIAQFYqkpLJpF5od0u4maGF0Ccgdq6CrrDY8jDao1cR6VOy1hYPGZ+f4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217be592-5a51-437c-9541-08d606e4a96e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 21:34:08.2549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for the patch. Perhaps can get rid of vmw_kms_resume
and vmw_kms_suspend, otherwise looks good to me.

>=20
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>=20
> suspend_state can be removed from vmw_private as
> it will not be used anymore.
>=20
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c |  6 +++---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  1 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 25 ++-----------------------
>  3 files changed, 5 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index bb6dbbe..a317cda 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1521,7 +1521,7 @@ static int vmw_pm_freeze(struct device *kdev)
>  		WARN_ON(vmw_request_device_late(dev_priv));
>  		dev_priv->suspend_locked =3D false;
>  		ttm_suspend_unlock(&dev_priv->reservation_sem);
> -		if (dev_priv->suspend_state)
> +		if (dev->mode_config.suspend_state)
>  			vmw_kms_resume(dev);
>  		if (dev_priv->enable_fb)
>  			vmw_fb_on(dev_priv);
> @@ -1558,8 +1558,8 @@ static int vmw_pm_restore(struct device *kdev)
>  	vmw_fence_fifo_up(dev_priv->fman);
>  	dev_priv->suspend_locked =3D false;
>  	ttm_suspend_unlock(&dev_priv->reservation_sem);
> -	if (dev_priv->suspend_state)
> -		vmw_kms_resume(dev_priv->dev);
> +	if (dev->mode_config.suspend_state)
> +		vmw_kms_resume(dev);
>=20
>  	if (dev_priv->enable_fb)
>  		vmw_fb_on(dev_priv);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> index 1abe217..b8e200b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -438,7 +438,6 @@ struct vmw_private {
>  	struct vmw_framebuffer *implicit_fb;
>  	struct mutex global_kms_state_mutex;
>  	spinlock_t cursor_lock;
> -	struct drm_atomic_state *suspend_state;
>=20
>  	/*
>  	 * Context and surface management.
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index 23beff5..2d011a1 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -3028,19 +3028,7 @@ int vmw_kms_set_config(struct drm_mode_set
> *set,
>   */
>  int vmw_kms_suspend(struct drm_device *dev)
>  {
> -	struct vmw_private *dev_priv =3D vmw_priv(dev);
> -
> -	dev_priv->suspend_state =3D drm_atomic_helper_suspend(dev);
> -	if (IS_ERR(dev_priv->suspend_state)) {
> -		int ret =3D PTR_ERR(dev_priv->suspend_state);
> -
> -		DRM_ERROR("Failed kms suspend: %d\n", ret);
> -		dev_priv->suspend_state =3D NULL;
> -
> -		return ret;
> -	}
> -
> -	return 0;
> +	return drm_mode_config_helper_suspend(dev);
>  }
>=20
>=20
> @@ -3055,16 +3043,7 @@ int vmw_kms_suspend(struct drm_device *dev)
>   */
>  int vmw_kms_resume(struct drm_device *dev)
>  {
> -	struct vmw_private *dev_priv =3D vmw_priv(dev);
> -	int ret;
> -
> -	if (WARN_ON(!dev_priv->suspend_state))
> -		return 0;
> -
> -	ret =3D drm_atomic_helper_resume(dev, dev_priv->suspend_state);
> -	dev_priv->suspend_state =3D NULL;
> -
> -	return ret;
> +	return drm_mode_config_helper_resume(dev);
>  }
>=20
>  /**
> --
> 1.9.1
