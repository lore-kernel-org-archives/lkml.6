Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A1CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55B920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FIwP0tFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55B920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeLMMSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:18:17 -0500
Received: from mail-bgr052101130064.outbound.protection.outlook.com ([52.101.130.64]:7591
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728766AbeLMMSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6uic+Kx2iDZyWJFJXnp5OJArt/j53kR2m4+3SZIXSQ=;
 b=FIwP0tFOlaMyj5Tqy6sDSsoA36TK5kGesNsDkbCkNtTs9SJUbqHV+BaLRDF2Cl6tmnWTKHoxMhf02+sKnqR4KmPqMDsyVDz5TkQA2OcssZn/AsKUF4svJOWYvyx7/GKPOz5yA7pZpHnbG7fBPxSTZ8smqTj+B+Ve4LJ7pqVnXdg=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.10.210) by
 DB8PR08MB4012.eurprd08.prod.outlook.com (20.179.9.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 12:18:06 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d0e0:ff54:c6fe:1407]) by DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d0e0:ff54:c6fe:1407%3]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:18:06 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/kvm/hyper-v: disallow setting illegal vectors
 for direct mode stimers
Thread-Topic: [PATCH v2 2/2] x86/kvm/hyper-v: disallow setting illegal vectors
 for direct mode stimers
Thread-Index: AQHUkjrHqNRvLS3Jxk+TspHM7QD0g6V8l1MA
Date:   Thu, 13 Dec 2018 12:18:06 +0000
Message-ID: <20181213121802.GB2474@rkaganb.sw.ru>
References: <20181212165017.13278-1-vkuznets@redhat.com>
 <20181212165017.13278-3-vkuznets@redhat.com>
In-Reply-To: <20181212165017.13278-3-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,_kvm@vger.kernel.org,=09Paolo_Bonzini_<?=
 =?iso-8859-2?Q?pbonzini@redhat.com>,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat?=
 =?iso-8859-2?Q?.com>,=09linux-kernel@vger.kernel.org?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0134.eurprd05.prod.outlook.com
 (2603:10a6:7:28::21) To DB8PR08MB4092.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB8PR08MB4012;7:3VE/PSCKhiDhMoDeSWHxQ/EahL/l7C9GpHvNOcG7JNFfdSmgNhutddRfns+RQYwgUJsKfDqpxVMKYmkL0pRA8Y+QnPrNRrWc0L6ZnKDUc5LUeD9oL3KN2wZDQAeOgzN3x9mjUD7hEmbiX/3D8eBsuA==;20:ttCUPw5G1avw+AGio9ycGXeaXyDVW0EuwM9XvXNz5a9d4i960WDkL8nxi59d1gZj9jNpJIH26QVbFGdVCDAahq3sNGcrlyv4T+Wh0Nk/lOgBYo0g2RGSTteTWg1HxLbgQacHI38xoet+ycpZzRZlvaZnma3pOCCE0h4sL1Ymbvw=
x-ms-office365-filtering-correlation-id: b3df24f7-7a03-4184-2101-08d660f50966
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB4012;
x-ms-traffictypediagnostic: DB8PR08MB4012:|DB8PR08MB4012:
x-microsoft-antispam-prvs: <DB8PR08MB4012DAE8356F9FD930BF57D9C9A00@DB8PR08MB4012.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB8PR08MB4012;BCL:0;PCL:0;RULEID:;SRVR:DB8PR08MB4012;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(136003)(396003)(39850400004)(366004)(376002)(346002)(189003)(199004)(71200400001)(68736007)(58126008)(186003)(386003)(86362001)(102836004)(4326008)(71190400001)(33896004)(6506007)(26005)(105586002)(2906002)(54906003)(316002)(53936002)(97736004)(6116002)(6512007)(9686003)(1076002)(14454004)(6246003)(106356001)(36756003)(8676002)(5660300001)(478600001)(8936002)(81156014)(6436002)(3846002)(81166006)(229853002)(256004)(7736002)(25786009)(99286004)(33656002)(6486002)(52116002)(446003)(66066001)(11346002)(476003)(486006)(6916009)(76176011)(305945005)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB8PR08MB4012;H:DB8PR08MB4092.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xaF498R54ZNJ1AEj6l7QjF7oRcSfmYsCRzEKVj7wpK7UEbsp6TiNAe//u7cVFXwNnf7jp5LJrWSmFXw8fJLS8MfhGrSfpISW9nP8oa2gUQGZkYBQ4TKGOwar/Dy09yOX5tnUIceBAFqjppvooDHeU+NeizHwwnZEiJA2+6pmMuIASsMFBC2PGIbSWxKZ8e8KRlIfo3R/GMDKy34vbl7FgFcQLpd+GtBOOXDmdMt0gquq/8vD65xxxCSlcoHX7bLHx4rr2gn1KahgmgKKV/Nc4KFDqCAUzKLo3j/ALA4gCRcYRZMDr96aBXf1XyXriqIHiymbLNhw+9x+3JakMVMpWpuHKs7CJf81FY+73OQiJ+5xOwT/fFlRPTUirlo3mpXiPoVchylyR8HjwJRaZ0+3Zm3Zy5uda7AY/tubrzhAz10ksk1GUxPAA6eWvEqAFjjIzCazgFe2Y5ycCVRoRafJ8CdmDRls2WbptAs4WpkmSUcr2OFEIB9YmAwjc7+wCKU2
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <6848010972E5E04F9E3256CF6330606A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3df24f7-7a03-4184-2101-08d660f50966
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:18:06.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 05:50:17PM +0100, Vitaly Kuznetsov wrote:
> APIC vectors used for direct mode stimers should be valid for lAPIC and
> just like genuine Hyper-V we should #GP when an illegal one is specified.
>=20
> Add the appropriate check to stimer_set_config()
>=20
> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
