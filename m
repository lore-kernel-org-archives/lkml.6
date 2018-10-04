Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F10BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F432087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="kyDi6Dt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F432087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJEDMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:12:12 -0400
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:42249
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbeJEDMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt2nDL1LznBBcosFNE3tARjlsvhOWrovlnepNqmwpzA=;
 b=kyDi6Dt7qF3wPTnoBB+rymOBaCdKwozBXF2K6O5YgmE4mcVuUr40Oo43pZPM5lt+g1pMVidtAMaQePMPzpcfelc1fPo/ugZdOM9tKG38swdOuv1MAddmJ3U/5xSoQotNq8XhNLqTxigdtdtIQY2X88pSYXe5xRsxHXtPDwSVnr8=
Received: from BYAPR05MB4887.namprd05.prod.outlook.com (52.135.235.153) by
 BYAPR05MB4038.namprd05.prod.outlook.com (52.135.199.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 20:17:14 +0000
Received: from BYAPR05MB4887.namprd05.prod.outlook.com
 ([fe80::a143:c9c9:a2e:314f]) by BYAPR05MB4887.namprd05.prod.outlook.com
 ([fe80::a143:c9c9:a2e:314f%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 20:17:14 +0000
From:   Sinclair Yeh <syeh@vmware.com>
To:     Colin King <colin.king@canonical.com>
CC:     linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][drm-next] drm/vmwgfx: remove redundant return ret
 statement
Thread-Topic: [PATCH][drm-next] drm/vmwgfx: remove redundant return ret
 statement
Thread-Index: AQHUXAqsmNjYI0R1Ck2VCZeWx2z3DqUPhUOA
Date:   Thu, 4 Oct 2018 20:17:14 +0000
Message-ID: <20181004201309.GA9246@vmware.com>
References: <20181004174953.28107-1-colin.king@canonical.com>
In-Reply-To: <20181004174953.28107-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [66.170.99.1]
x-clientproxiedby: DM5PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:3:37::22) To BYAPR05MB4887.namprd05.prod.outlook.com
 (2603:10b6:a03:42::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=syeh@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4038;20:1SXU0luMnd9LnbXd7vq0cUIA6wXPNrj0o8kdTyL9NNtV0hQ67o99PmuioICuibAuVMrFUpq2SBzI+LXV+Lxh4nRX8ztwIBqVe6tBOr3JkDMs7BYmARly8vDTYCX6YykSEU03IjDEXgvvTdLHVQsvem06hytTEBv27/NkZXIGfzs=
x-ms-office365-filtering-correlation-id: a719a764-1ae1-4fd1-3bdd-08d62a365f8c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4038;
x-ms-traffictypediagnostic: BYAPR05MB4038:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4038F88D15D380C9BEADEF49A8EA0@BYAPR05MB4038.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:BYAPR05MB4038;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4038;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(6116002)(4326008)(256004)(6246003)(478600001)(2906002)(54906003)(58126008)(186003)(102836004)(5660300001)(26005)(36756003)(25786009)(68736007)(8936002)(1076002)(106356001)(66066001)(5250100002)(97736004)(71190400001)(71200400001)(3846002)(2900100001)(76176011)(316002)(53936002)(6436002)(6916009)(81156014)(86362001)(105586002)(6486002)(99286004)(81166006)(52116002)(229853002)(8676002)(6506007)(386003)(486006)(33656002)(476003)(11346002)(446003)(14454004)(7736002)(305945005)(2616005)(6512007)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4038;H:BYAPR05MB4887.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: krrV4gxfqW5qXy6acru8zFwotsXPYvxJmBIbXwVXzfeji14idopw3zDUwfPC1168feISDghDBjasYdchmkBKoVkqTebzOh9qLDdT0rdgl2UzQZ9prlBuh4pcZnvLibMsFrsk5W7g7Jr43YiafNh5XbcsBZDPJkP+MGx/eUw4/KFg5adB9bk/ra53ygAqvtXtmOCCZcTYI2gongxs5EKrfGgLFMULUuYKQsz/PXFRubMNsMKw5JORBxPnGaiTy7VZBDsH0HRMdOVHGrj6s9n+r+Q94DUXNXREY8A8sfKWj97PvGPTnT38bAAYS1n12dIAwB7nG8LqR0R7wZG1TLfHUDslBXMm/cIrDh+6Yj0UySM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <653C633B6695334897FD977C1EC39631@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a719a764-1ae1-4fd1-3bdd-08d62a365f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 20:17:14.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch.

Reviewed-by: Sinclair Yeh <syeh@vmware.com>

On Thu, Oct 04, 2018 at 06:49:53PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The return statement is redundant as there is a return statement
> immediately before it so we have dead code that can be removed.
> Also remove the unused declaration of ret.
>=20
> Detected by CoverityScan, CID#1473793 ("Structurally dead code")
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> index 5a6b70ba137a..260650bb5560 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -1738,7 +1738,6 @@ static int vmw_cmd_check_define_gmrfb(struct vmw_pr=
ivate *dev_priv,
>  				      void *buf)
>  {
>  	struct vmw_buffer_object *vmw_bo;
> -	int ret;
> =20
>  	struct {
>  		uint32_t header;
> @@ -1748,7 +1747,6 @@ static int vmw_cmd_check_define_gmrfb(struct vmw_pr=
ivate *dev_priv,
>  	return vmw_translate_guest_ptr(dev_priv, sw_context,
>  				       &cmd->body.ptr,
>  				       &vmw_bo);
> -	return ret;
>  }
> =20
> =20
> --=20
> 2.17.1
>=20
