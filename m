Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE23C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6651220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mlj1qjfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6651220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeKAIdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:33:51 -0400
Received: from mail-hk2apc01on0138.outbound.protection.outlook.com ([104.47.124.138]:8256
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728437AbeKAIdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDh7ZCaxCqkI6QLXi/XSj09YquXsGnVZKXzJmbCpN+s=;
 b=Mlj1qjfGQ1q+jFFHQH9Kfyze2Di9kT2sv7yV2kH1LazNxClmVzcyekTPatc1xuSBgeq3731k1vvvBCb7phj52S8mNmbzUr3JaT2clqb+6Qg98KhL7Gy+5prARC/2TRj4uj5FfbLigPE2ERqzrsxiFaIYGzjwpuOHy1dfK9jP0nM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0137.APCP153.PROD.OUTLOOK.COM (10.170.188.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.2; Wed, 31 Oct 2018 23:33:24 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217%3]) with mapi id 15.20.1294.014; Wed, 31 Oct 2018
 23:33:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH AUTOSEL 4.19 109/146] Drivers: hv: kvp: Fix two "this
 statement may fall through" warnings
Thread-Topic: [PATCH AUTOSEL 4.19 109/146] Drivers: hv: kvp: Fix two "this
 statement may fall through" warnings
Thread-Index: AQHUcW5+MuHME28YHkakaeR1NEWg96U5/wgQ
Date:   Wed, 31 Oct 2018 23:33:23 +0000
Message-ID: <PU1P153MB01690D8A6D95ED88F8907745BFCD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181031230541.28822-1-sashal@kernel.org>
 <20181031230541.28822-109-sashal@kernel.org>
In-Reply-To: <20181031230541.28822-109-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-31T23:33:21.5291076Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:584e:e773:fba4:7fdb]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0137;6:n5fxAAWsun8/PBz1G7UZJ1Ob2QYhM9sXGP39wl5UCNag04E2eqLoUmw0uPE9zQVecUZY4KKidePAcZj8z3nGc8jdDqO0Me/A/P762lCL0WXVBcEqLewM1RbcjptBfJ4IhxhCLIVtnmZwAug8hNAxapcTpKIlrHbnGCp987q/0SK2sB4vgm8/0FGGOaEWGI51RLTWD1Jl0PDEo5/OaQlm08NDjrZ3APNeoeyVIU9Mzm6x2AYsQajIRSTvVGCmu+0lEiFQqJ8ryGsIfYc5XpvUfRmlI1Z8TXH71nHVEczS2Pqxrx8fUA8V6heIl0HPGSMfF6LJ0wWODup3yNXkNgEGs7U4Njzyvozj27ADZxydwF+OuHVvCDHQfEiniHUvdVMVvY5J3l8jbYiesJJbI09TBsqp3j2gTYbHqjb3F4WRp+pWv1gY0Vam0AfarRHe2oxGhC0aS/7RpsZR1VQTW3CKXg==;5:rqjEevyMqZbwcVxZg8dSBE+RT4gjdOXwbHmQEfXaL/e+LStb0aUeVirqM2gDPHiXmx3jnV7k5GpBgQC+6mxdNvAB5w+iXyzOUMAHVIRmm7XPZSIlDRFMnGb2+2qUJZr2gk8Wv9luVvw+iOuuepuzCjCYbQ9pu9YiUH9gFiFMwDI=;7:/hnlUyggFfpoYO14JyZxbWHXEC8S1Uq9HDObEAl3K4cMM2KhdIRLFlu15ukyjbM7zlozaFk2fVqhSsBU07UWUyIYU4ErQukWWMqO9d8navk/n99JrtQGjvDKVlNJjFUnvEY5gb+Yd5jY3iycgnaP7w==
x-ms-office365-filtering-correlation-id: 089050f9-db61-4309-6ed1-08d63f894046
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0137;
x-ms-traffictypediagnostic: PU1P153MB0137:
x-microsoft-antispam-prvs: <PU1P153MB01373841FB2125074015F0B1BFCD0@PU1P153MB0137.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0137;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0137;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(217873002)(186003)(81166006)(81156014)(10090500001)(6306002)(6346003)(9686003)(102836004)(476003)(55016002)(8676002)(305945005)(486006)(11346002)(6436002)(446003)(7736002)(53936002)(46003)(6116002)(229853002)(106356001)(33656002)(110136005)(54906003)(86612001)(5660300001)(86362001)(575784001)(4326008)(256004)(316002)(2201001)(71190400001)(71200400001)(8990500004)(99286004)(97736004)(22452003)(6246003)(2900100001)(5250100002)(76176011)(7696005)(2501003)(478600001)(8936002)(74316002)(25786009)(14454004)(6506007)(10290500003)(53546011)(68736007)(2906002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0137;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-microsoft-antispam-message-info: xLCYR4x6rGtXtLJlfQFMlNHk0OxkWttVWkrZpx2Ua05rMrD7FxoYrhetRBBqWjnwAjuOtYPSG0/Bmep6R67cRryl8L/2Mw1sLl2+B8MBc5tgcagI/uIs67Drg0hKlB+OkDTD4sCXR45PKCiEBczDhAQ1vqxKUgwErRL0XlNfWNuqW2QFD1B5ShBKgCM2z8dhIUbephqoLywj+C0XgQBi8iDpEDl2gk0ncvez5xdG464DPm5ZqvSNI+kWnXk3uM+g1+tLNSOfembbC5TOhq9cctqNrbPcAyCcvAn15T6LHY5OCJ0MM3ipoo6Mqu+u2zGTRevQXVzAl06eDK8cZNSd/EZZva6/90qbYxkiHDuxqL0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089050f9-db61-4309-6ed1-08d63f894046
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 23:33:23.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Wednesday, October 31, 2018 16:05
> To: stable@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Stable@vger.kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Sasha Levin <sashal@kernel.org>
> Subject: [PATCH AUTOSEL 4.19 109/146] Drivers: hv: kvp: Fix two "this
> statement may fall through" warnings
>=20
> From: Dexuan Cui <decui@microsoft.com>
>=20
> [ Upstream commit fc62c3b1977d62e6374fd6e28d371bb42dfa5c9d ]
>=20
> We don't need to call process_ib_ipinfo() if message->kvp_hdr.operation i=
s
> KVP_OP_GET_IP_INFO in kvp_send_key(), because here we just need to pass
> on
> the op code from the host to the userspace; when the userspace returns
> the info requested by the host, we pass the info on to the host in
> kvp_respond_to_host() -> process_ob_ipinfo(). BTW, the current buggy code
> actually doesn't cause any harm, because only message->kvp_hdr.operation
> is used by the userspace, in the case of KVP_OP_GET_IP_INFO.
>=20
> The patch also adds a missing "break;" in kvp_send_key(). BTW, the curren=
t
> buggy code actually doesn't cause any harm, because in the case of
> KVP_OP_SET, the unexpected fall-through corrupts
> message->body.kvp_set.data.key_size, but that is not really used: see
> the definition of struct hv_kvp_exchg_msg_value.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/hv/hv_kvp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index 5eed1e7da15c..57715a0c8120 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -353,7 +353,6 @@ static void process_ib_ipinfo(void *in_msg, void
> *out_msg, int op)
>=20
>  		out->body.kvp_ip_val.dhcp_enabled =3D in->kvp_ip_val.dhcp_enabled;
>=20
> -	default:
>  		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
>  				MAX_ADAPTER_ID_SIZE,
>  				UTF16_LITTLE_ENDIAN,
> @@ -406,7 +405,7 @@ kvp_send_key(struct work_struct *dummy)
>  		process_ib_ipinfo(in_msg, message, KVP_OP_SET_IP_INFO);
>  		break;
>  	case KVP_OP_GET_IP_INFO:
> -		process_ib_ipinfo(in_msg, message, KVP_OP_GET_IP_INFO);
> +		/* We only need to pass on message->kvp_hdr.operation.  */
>  		break;
>  	case KVP_OP_SET:
>  		switch (in_msg->body.kvp_set.data.value_type) {
> @@ -446,6 +445,9 @@ kvp_send_key(struct work_struct *dummy)
>  			break;
>=20
>  		}
> +
> +		break;
> +
>  	case KVP_OP_GET:
>  		message->body.kvp_set.data.key_size =3D
>  			utf16s_to_utf8s(
> --
> 2.17.1

This patch caused a regression and the fix (https://lkml.org/lkml/2018/10/1=
8/288)=20
has not been in Greg's tree yet...

For now, please don't backport this patch to the stable kernels (4.19, 4.18=
, 4.14, 4.9, 4.4, 3.18,etc). Sorry for the trouble!

-- Dexuan
