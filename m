Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69346C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB952086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="SnVOUNdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB952086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeIJWob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:44:31 -0400
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:53955
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbeIJWob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVV7RJE0NvxjOScMhiokTO1YgiOaYyqyirRfmfmt5gU=;
 b=SnVOUNdTdzQZK0IpziQwkKpoDcKjLa1E9ci/69prdwehkyLO90+9cwlfoDvEgXoobNcmpvDrGG20IKoy1cWnAmgJwQ3uovGJaIRzTi9Ls69m5SgYXHZJdFmUaz719wrU0CVMA0BFHbU0HcXLillpUmFhN2ejP53T5jwXB0Zi6nY=
Received: from CO2PR07MB2712.namprd07.prod.outlook.com (10.166.214.13) by
 CO2PR07MB2711.namprd07.prod.outlook.com (10.166.214.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 17:49:14 +0000
Received: from CO2PR07MB2712.namprd07.prod.outlook.com
 ([fe80::d8c5:264f:e6a6:616c]) by CO2PR07MB2712.namprd07.prod.outlook.com
 ([fe80::d8c5:264f:e6a6:616c%4]) with mapi id 15.20.1122.018; Mon, 10 Sep 2018
 17:49:14 +0000
From:   "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To:     Colin King <colin.king@canonical.com>
CC:     Dept-Eng QLA2xxx Upstream <qla2xxx-upstream@cavium.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: qla2xxx: fix typo "CT-PASSTRHU" -> "CT-PASSTHRU"
Thread-Topic: [PATCH] scsi: qla2xxx: fix typo "CT-PASSTRHU" -> "CT-PASSTHRU"
Thread-Index: AQHUSIv32OBy/owXvkaQfVA9seeqfaTpzBkA
Date:   Mon, 10 Sep 2018 17:49:14 +0000
Message-ID: <1E6E5FDA-33ED-4CBB-8E96-D3086EEE6B88@cavium.com>
References: <20180909222503.8298-1-colin.king@canonical.com>
In-Reply-To: <20180909222503.8298-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Himanshu.Madhani@cavium.com; 
x-originating-ip: [173.186.134.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2711;6:vWgNKSyEgSPHXhM+xyf14bLzVKXI/DRKaEJc4uvntFxiQVmPVqFM8eXqevfDcnk5Qyqe4Syw3tfM4IQffP4DFs4UjjERz8RJ0WS5l03HMsE3C31uwmFemaitBgfW5LaGFV9S/lj89Oi/C6gdL/DQfZuGcMvlcz1/J7oVXcF807XqFZ7Sx4XqCBP3XbEpeOYqxgknK0jTt3dj4t07fWQtQZcMMWTn2ViMB+6iD6PKMNjk1fBjhin56MqybekhvEQzCWbBIIWEDlDR6daPhgELtXigA4SJcFgNtYt04zXUm5TmetJYpnxXwbotnun0Aw7TNjjqxG68VfHj70JC6pwwHy5GeRN35FAVlVU/lKE+iAl/aW2esgnty0+VdjeCtd5Exiw62/z74dY/cnBW8a+HYj9i3yRylpFadb4cS5a/jXCzrwuqu4Bu51+BWLDO94WCs40HLBVoOUJ21dd2BibygA==;5:+ZTdnxulzNolVoE2Fdzss6RSO/KeZjqwvj8mHIbHEZVUijD6AHGImFO9Im5S0xHAMy18VZkfObluvcSaKRJOZfzFrU/jR1o9qEROKuhAR2AFs7R5ptfpl4yqG4LkhPxfSRD21Utfp7wP8yYU7ml48jg80u2gZSACNktw9FuC35I=;7:qteiOh036UW5xrovsxpr3AQYSVYQgZjaicn/w05lcQnKVhm5/LrvAIQuGtJZCZmSiGZjspKhnp7um/x+ITwsmdGbzF28id+rODg/t3n2Ty4+5Zlv8jNmElE6CMl0rnBqyu+xbDFNl0y2eg9oInVNK1s41NmlZWfVolHqc448eORlGH/ni7s0gErNgJnTqKIkuPKAjHPBWBucNUMw1DLG+hfZ0GcT50iQuJIQOLehaJrFbWx9FHJaDYSHMbLgkjQF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f4b39b6b-e498-48c0-4834-08d61745b95b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2711;
x-ms-traffictypediagnostic: CO2PR07MB2711:
x-microsoft-antispam-prvs: <CO2PR07MB2711ABED43D4B62A5F8818B9F5050@CO2PR07MB2711.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:CO2PR07MB2711;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2711;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(72206003)(6246003)(316002)(2906002)(6436002)(6486002)(256004)(4326008)(114624004)(53936002)(76176011)(99286004)(86362001)(186003)(5250100002)(486006)(26005)(14444005)(14454004)(6506007)(54906003)(102836004)(229853002)(106356001)(3846002)(105586002)(6116002)(66066001)(446003)(2616005)(476003)(6512007)(478600001)(53546011)(25786009)(11346002)(36756003)(8676002)(81156014)(81166006)(68736007)(82746002)(83716003)(7736002)(8936002)(305945005)(33656002)(2900100001)(97736004)(6916009)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2711;H:CO2PR07MB2712.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4oB/C9ZqCxYiIjsHDaC6Df6vWhzgqmLjrHfjK+glSn/zqT9Jrmv2dxE0OJVZyF/gV2yhN+tA/suwXodQcZasyh6LlvMCatKf7li3S7hYAVZErSvfeC79z0vPViD346aAvWlfw9VN9OGkWws3jxZQxzg6dQwBbRAH0Z2OdySoIhWDKfHmuUnejWZlAbGUPwidISqcBgxKf91pJIZLdLsca3CRQV8ZS/yqzcD4+TryBZnQvqtqBoN8xC6BUZIfu4ZUYS6DmyJ7aLg2d4WX0QBOteXZcrak8YsWhOHe414GBO8LfZnWB2ZJg07EVy93y5ZInBIQ1r2sqRpXAYfl5Zjc+rQf1ACUXyLZ9BmOUWvTo/s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4D122E14D73874EA4963BC24ED530EB@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b39b6b-e498-48c0-4834-08d61745b95b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 17:49:14.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 9, 2018, at 3:25 PM, Colin King <colin.king@canonical.com> wrote:
>=20
> External Email
>=20
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to typo in debug message text.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/scsi/qla2xxx/qla_gs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.=
c
> index a0038d879b9d..b48ff0095843 100644
> --- a/drivers/scsi/qla2xxx/qla_gs.c
> +++ b/drivers/scsi/qla2xxx/qla_gs.c
> @@ -4289,7 +4289,7 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha=
, struct srb *sp,
>        }
>=20
>        ql_dbg(ql_dbg_disc, vha, 0xfffff,
> -           "%s: FC4Type %x, CT-PASSTRHU %s command ctarg rsp size %d, ct=
arg req size %d\n",
> +           "%s: FC4Type %x, CT-PASSTHRU %s command ctarg rsp size %d, ct=
arg req size %d\n",
>            __func__, fc4_type, sp->name, sp->u.iocb_cmd.u.ctarg.rsp_size,
>             sp->u.iocb_cmd.u.ctarg.req_size);
>=20
> --
> 2.17.1
>=20

Acked-By: Himanshu Madhani <himanshu.madhani@cavium.com>

Thanks,
- Himanshu

