Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967895AbeCALyc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:54:32 -0500
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:18160
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967800AbeCALya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:54:30 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 09/15] lightnvm: implement get log report chunk helpers
Thread-Topic: [PATCH 09/15] lightnvm: implement get log report chunk helpers
Thread-Index: AQHTsKvKPQr+t6kXIEStiyH2zG/Y/aO7Mg2AgAAGQwCAAA2qAIAAAMKA
Date: Thu, 1 Mar 2018 11:54:25 +0000
Message-ID: <CFBBD8F3-938A-48FF-88B0-2D680AE7398C@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
 <1519832975-25432-10-git-send-email-javier@cnexlabs.com>
 <4c82d581-d8bf-25fb-26ea-48b26e6de899@lightnvm.io>
 <B6B4086D-DA0B-41FF-AFB4-5E752F18CD01@cnexlabs.com>
 <3713fd85-5050-b498-ce32-e699444337ba@lightnvm.io>
In-Reply-To: <3713fd85-5050-b498-ce32-e699444337ba@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3491;7:IKLaTZxxuGOnkjcHX0QlZ8Gdn6Yb6QD3OpjNO9UCI2wMn2zHPLaf0Xx7W1thRfxLGgAQmnGHkBZfkvUqzqLjT1nQ7U7hCFErmOSOckLkH3GZHlImwZWYkK4RETuEEIYEqtcVwr0DvdlYE/Nsxw7uzfUKENw+UnCUHzonzpTzCpHD69eWgZa/ZJkqnu0aH6a9SixsUZeWMiHLp9iuii1L5vEFq6ndnzTRfcdlZoVgSvKt4VKiuLYNYmn+oABxZOiU
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 5c171500-58a3-402d-cfaa-08d57f6b2e7e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3491;
x-ms-traffictypediagnostic: BN6PR06MB3491:
x-microsoft-antispam-prvs: <BN6PR06MB349181C040A410D67BE65149BAC60@BN6PR06MB3491.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501224)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR06MB3491;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3491;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39840400004)(396003)(39380400002)(189003)(199004)(8676002)(77096007)(81166006)(6512007)(81156014)(316002)(106356001)(68736007)(6116002)(3846002)(66066001)(6506007)(99286004)(97736004)(575784001)(82746002)(8936002)(86362001)(53546011)(83716003)(186003)(54906003)(105586002)(25786009)(26005)(4326008)(3660700001)(305945005)(76176011)(6486002)(2906002)(7736002)(3280700002)(6916009)(33656002)(2950100002)(102836004)(6436002)(5660300001)(229853002)(2900100001)(6246003)(36756003)(14454004)(99936001)(93886005)(53936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3491;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HcXCzveOEJpG7y8bXAY0i0gjdcLVOXH/KokoVqfNqxmt3V1Y7dnjug9iPQMjDWckiyqjKj5158mPi89K0dy+zS46br7tyzzZUCkLApWJRPD8t8fwPdLe/kNb7I0ZCZZHlU7f6BmcJraouIzd5dK1E4d1NKFn4VPAkk9QriMWPc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5E0B93CC-57E5-4307-97DA-39802F3271D5";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c171500-58a3-402d-cfaa-08d57f6b2e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 11:54:25.8583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3491
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_5E0B93CC-57E5-4307-97DA-39802F3271D5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 1 Mar 2018, at 12.51, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 03/01/2018 12:02 PM, Javier Gonzalez wrote:
>>> On 1 Mar 2018, at 11.40, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 02/28/2018 04:49 PM, Javier Gonz=C3=A1lez wrote:
>>>> The 2.0 spec provides a report chunk log page that can be retrieved
>>>> using the stangard nvme get log page. This replaces the dedicated
>>>> get/put bad block table in 1.2.
>>>> This patch implements the helper functions to allow targets =
retrieve the
>>>> chunk metadata using get log page. It makes nvme_get_log_ext =
available
>>>> outside of nvme core so that we can use it form lightnvm.
>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>> ---
>>>>  drivers/lightnvm/core.c      | 11 +++++++
>>>>  drivers/nvme/host/core.c     |  6 ++--
>>>>  drivers/nvme/host/lightnvm.c | 74 =
++++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/nvme/host/nvme.h     |  3 ++
>>>>  include/linux/lightnvm.h     | 24 ++++++++++++++
>>>>  5 files changed, 115 insertions(+), 3 deletions(-)
>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>> index ed33e0b11788..4141871f460d 100644
>>>> --- a/drivers/lightnvm/core.c
>>>> +++ b/drivers/lightnvm/core.c
>>>> @@ -712,6 +712,17 @@ static void nvm_free_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev,
>>>>  	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, =
rqd->dma_ppa_list);
>>>>  }
>>>>  +int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct =
nvm_chk_meta *meta,
>>>> +		struct ppa_addr ppa, int nchks)
>>>> +{
>>>> +	struct nvm_dev *dev =3D tgt_dev->parent;
>>>> +
>>>> +	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
>>>> +
>>>> +	return dev->ops->get_chk_meta(tgt_dev->parent, meta,
>>>> +						(sector_t)ppa.ppa, =
nchks);
>>>> +}
>>>> +EXPORT_SYMBOL(nvm_get_chunk_meta);
>>>>    int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct =
ppa_addr *ppas,
>>>>  		       int nr_ppas, int type)
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 2e9e9f973a75..af642ce6ba69 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -2127,9 +2127,9 @@ static int nvme_init_subsystem(struct =
nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>>>  	return ret;
>>>>  }
>>>>  -static int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct =
nvme_ns *ns,
>>>> -			    u8 log_page, void *log,
>>>> -			    size_t size, size_t offset)
>>>> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>>> +		     u8 log_page, void *log,
>>>> +		     size_t size, size_t offset)
>>>>  {
>>>>  	struct nvme_command c =3D { };
>>>>  	unsigned long dwlen =3D size / 4 - 1;
>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>> index f7135659f918..a1796241040f 100644
>>>> --- a/drivers/nvme/host/lightnvm.c
>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>> @@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
>>>>  	nvme_nvm_admin_set_bb_tbl	=3D 0xf1,
>>>>  };
>>>>  +enum nvme_nvm_log_page {
>>>> +	NVME_NVM_LOG_REPORT_CHUNK	=3D 0xca,
>>>> +};
>>>> +
>>>>  struct nvme_nvm_ph_rw {
>>>>  	__u8			opcode;
>>>>  	__u8			flags;
>>>> @@ -236,6 +240,16 @@ struct nvme_nvm_id20 {
>>>>  	__u8			vs[1024];
>>>>  };
>>>>  +struct nvme_nvm_chk_meta {
>>>> +	__u8	state;
>>>> +	__u8	type;
>>>> +	__u8	wi;
>>>> +	__u8	rsvd[5];
>>>> +	__le64	slba;
>>>> +	__le64	cnlb;
>>>> +	__le64	wp;
>>>> +};
>>>> +
>>>>  /*
>>>>   * Check we didn't inadvertently grow the command struct
>>>>   */
>>>> @@ -252,6 +266,9 @@ static inline void _nvme_nvm_check_size(void)
>>>>  	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) !=3D 64);
>>>>  	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20_addrf) !=3D 8);
>>>>  	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20) !=3D =
NVME_IDENTIFY_DATA_SIZE);
>>>> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_chk_meta) !=3D 32);
>>>> +	BUILD_BUG_ON(sizeof(struct nvme_nvm_chk_meta) !=3D
>>>> +						sizeof(struct =
nvm_chk_meta));
>>>>  }
>>>>    static void nvme_nvm_set_addr_12(struct nvm_addr_format_12 *dst,
>>>> @@ -555,6 +572,61 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev =
*nvmdev, struct ppa_addr *ppas,
>>>>  	return ret;
>>>>  }
>>>>  +/*
>>>> + * Expect the lba in device format
>>>> + */
>>>> +static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>>>> +				 struct nvm_chk_meta *meta,
>>>> +				 sector_t slba, int nchks)
>>>> +{
>>>> +	struct nvm_geo *geo =3D &ndev->geo;
>>>> +	struct nvme_ns *ns =3D ndev->q->queuedata;
>>>> +	struct nvme_ctrl *ctrl =3D ns->ctrl;
>>>> +	struct nvme_nvm_chk_meta *dev_meta =3D (struct nvme_nvm_chk_meta =
*)meta;
>>>> +	struct ppa_addr ppa;
>>>> +	size_t left =3D nchks * sizeof(struct nvme_nvm_chk_meta);
>>>> +	size_t log_pos, offset, len;
>>>> +	int ret, i;
>>>> +
>>>> +	/* Normalize lba address space to obtain log offset */
>>>> +	ppa.ppa =3D slba;
>>>> +	ppa =3D dev_to_generic_addr(ndev, ppa);
>>>> +
>>>> +	log_pos =3D ppa.m.chk;
>>>> +	log_pos +=3D ppa.m.pu * geo->num_chk;
>>>> +	log_pos +=3D ppa.m.grp * geo->num_lun * geo->num_chk;
>>>=20
>>> Why is this done?
>> The log page does not map to the lba space. You need to convert it to
>> get one chunk at a time in the format.
>>    GRP:PU:CHK
>> I can see why taking a lba as argument is better than a ppa, since =
users
>> might use the lbas directly, but the conversion needs to be done
>> somewhere.
>=20
> Good point. I guess this is clash between the two APIs. Chunk metadata
> being laid out sequentially, while the address space is sparse.

Exactly.

> I'm good with the conversion being in the fn.

Cool. I think it is good here too, as it hides the ppa format from the
upper layers. It requires a double conversion from pblk, but it is not
on the fast path anyway...

Javier

--Apple-Mail=_5E0B93CC-57E5-4307-97DA-39802F3271D5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqX6e8ACgkQIX4xUKFR
nnQ6WRAAuuok7MH6q1phZveJyXSKnIU6XXDKNS5CyKE91jxLVzAUnLnKJAbKtUPv
/Ed7YAHnsSfXUnGWBwe0dM98hnieme5j2hJ/JCdHaahcI3Yi9yYb105hr0ZE21fA
Ozp/4tAK3cAGDQI+eKASe8Tm6Hi2QaTLFTNfQuE32GmFi7hECxaj6RoU9DZ9CAFq
q8jIte/5rmrQDyNrtcO90ma/b2zpK5XnhqgA3QX8TOb3fEHrKt5+FsAt+UsjHZQP
d2pEcaGxAay9IdI+9Yb/yiylTOiSuSzz7cZECKzhx/+a3fPhXIetyIa/LuoGHT1w
99k+IRydfctenQZz3F8YeNieXfNKnIRX3UhVuqoRBoAZLKMWwmZH4IR2SxLABoRU
do/+cr1Z8sIxxrg/PEEdmyAG/w6G6WdbiZ8pOYqYjHFA8HKK21LX8BX1VMGcqo7m
xJjQBxw6T70asspnaONk5uXl3ouM4GwbXMX3aHNW+I0u9I5BaGXDqYf7PKibR1tY
6SVgXRm30clWz3qxVcbLsLyzHfvB1rBfOsaSDP/nb6xpPCpJmyTjAB17KUt8y7Ky
GpMW1zeFbP2Vt0BmhppfdYQ6IGWNag1dF7vgg+8fzZBB3gjGExrKAdVwupKw4Cp6
/M70jHKxR+IZjHVhXYesfKMYZW8yx45FivMzzySBduvWpBME79g=
=5Iwl
-----END PGP SIGNATURE-----

--Apple-Mail=_5E0B93CC-57E5-4307-97DA-39802F3271D5--
