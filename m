Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC3EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8281820C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="A5cXy0U3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8281820C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeHTK73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:59:29 -0400
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com ([104.47.32.60]:23569
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbeHTK72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmIfMUJvNRJC14eAC5Fua7xs2yOEIs7UxMQvBsW3IRo=;
 b=A5cXy0U3yQYe0YWnUolpV97584a3qjki08QHt61+tjfxGL5hGINsq5PX0GxvJNBkt7hmeNMgss1B0QN1N3oCdDIPFjmUeen+YYhdfybwhr4G8ZjSLAHiLb/M9Jo43Stb6nAHeermRIvx5IR2cer8lLm8iRSJySBeeogkir2i2MM=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB649.namprd06.prod.outlook.com (10.141.227.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Mon, 20 Aug 2018 07:44:48 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 07:44:46 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: unify vector max req constants
Thread-Topic: [PATCH] lightnvm: pblk: unify vector max req constants
Thread-Index: AQHUNjbwtttOtLRCl0Cbq6+R28FcRaTIRuOA
Date:   Mon, 20 Aug 2018 07:44:46 +0000
Message-ID: <FA7F0865-55BB-4710-9B43-4368E66E7F55@cnexlabs.com>
References: <20180817143055.26032-1-mb@lightnvm.io>
In-Reply-To: <20180817143055.26032-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB649;6:0cFx+xpEVCk2qTaH4NdXMFSWE/i3NWpMO5M4MDosLo/0qbMK+wl2y5cxsFNu9ZQ9LyfkKKWlgOkc81yzDmQN/nfAz9Y5LL4nMwaoT8HT1DXZ/1tcV+2ZJ/gUGJPrFjZh2nsX40EDIodOee+Q051Xt0h8W5SpbfwFIQqQf8fKZitH5JVlToj/4IRXdqKhLRTLKFv7VjWmX1eEaUsMhusvzGHlC0qOlxxIXC1C1vMQNx9i5W6EQfrQ2pWOGW4uQuv7llkMoV0sDEf3sEUdOrbPfhwnWphWQbwx8ykR+FhsIZK1TlTfgTBZ+XYWvDNfh5h6eQWgPMfjjvR+MVGtfsl1qRE7jmMGK81JrRu7YGYS+hCPs2s5hVDEzaF2WOVMe/0FJrv03wu5GejCIphU0Dh6wfqniG1f5tmRyV8oQ1XTHMRSec2PrZlWueF/0jwnIWaYcebanF8j+Ky7UXAxV68lIQ==;5:uDQT25TRgmYvPbvnUg6hY36zCbAdTnSkKKFKa4SjLgecYcwzHR2SZalpRChdbyEXcyXOQ/h98vnbmFc2ydgoU8qbdc96TOJETlzPdwVB3q19i/aKZIKiROSbfqfb63tO/FEgitj+FHabrCdChvnd7m7/2AVG1hLHcNCq9lQxlrw=;7:crseVAyUY8gAZlmzA0IJJrGM0j+W3/vRH1cJRvFlafSMbtXbJzHaA82fK40emr3FC2oUslYyHHRpAfNBF4XMpNc79bQv5YGQ1hsWyF80ORUMWZsXB5WiyGZ+2Q1aE+JEHU4IS7OCBPy0BsgDvUnXd3+5scqeU5yr5/yS6of9PAv2qMmzMeSKfIBrUUNCI/KbPlzozOpestizKI19U1zwpWPkaMYJ+0QA7YDYOAHNg3rC2Bq0/I5f2ff8sEr16c1A
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39830400003)(396003)(199004)(189003)(26005)(2616005)(6246003)(36756003)(11346002)(446003)(476003)(486006)(8676002)(102836004)(14454004)(6506007)(305945005)(81166006)(99936001)(316002)(256004)(83716003)(14444005)(7736002)(81156014)(186003)(105586002)(8936002)(82746002)(99286004)(68736007)(106356001)(2906002)(54906003)(97736004)(33656002)(76176011)(2900100001)(66066001)(4326008)(6486002)(5250100002)(6512007)(3846002)(478600001)(6916009)(53936002)(86362001)(5660300001)(575784001)(6116002)(6436002)(229853002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB649;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: c6a3b396-0cd0-4520-c48a-08d60670cd31
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB649;
x-ms-traffictypediagnostic: CO2PR06MB649:
x-microsoft-antispam-prvs: <CO2PR06MB6491B7915E5DE0A01F2C989BA320@CO2PR06MB649.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB649;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB649;
x-forefront-prvs: 0770F75EA9
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wi244F3AEhtD+GAoCXa5gxa2Udf9oVgSutNHaF41MEOaQb5KGCfc+oZSHTqChPEY/uPWcNAeD4Zgz87AfuEkYpIhTTjzIe5DInBmYlouXY4O7Cv/HF4bBNCCMhChHDbDWWGVvl2/YfA/MZ86G2fqOD7l9B/Sg647mhrUy77oAY7ECy1saKAKFJ7P6UNqhlEgogL5qlx/EmTxqktDeE5/S/nWd1VcGlFskGpE89LEKPaul0AdJ8nMsXbWRyHQKQPg5odR+0nbx2I0NYvzWXByIMD6pNvP7P9CH9wHEH2bnsP4YbOlkCkCUuCoIjQ/k0l6ulkW7XuLdLZe7xkQnbrre1RNgk8ySJJLb6IJP3mCFM4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_23CAA2AB-45A0-4D77-999D-58AE5C13884C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a3b396-0cd0-4520-c48a-08d60670cd31
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 07:44:46.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_23CAA2AB-45A0-4D77-999D-58AE5C13884C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Aug 2018, at 16.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> Both NVM_MAX_VLBA and PBLK_MAX_REQ_ADDRS define how many LBAs that
> are available in a vector command. pblk uses them interchangeably
> in its implementation. Use NVM_MAX_VLBA as the main one and remove
> usages of PBLK_MAX_REQ_ADDRS.
>=20
> Also remove the power representation that only has one user, and
> instead calculate it at runtime.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-init.c |  6 ------
> drivers/lightnvm/pblk-read.c |  6 +++---
> drivers/lightnvm/pblk-rl.c   |  4 ++--
> drivers/lightnvm/pblk.h      | 10 ++++------
> 4 files changed, 9 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 53bd52114aee..9119c64d6f62 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -376,12 +376,6 @@ static int pblk_core_init(struct pblk *pblk)
> 	pblk->max_write_pgs =3D min_t(int, max_write_ppas, =
NVM_MAX_VLBA);
> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>=20
> -	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
> -		pblk_err(pblk, "vector list too big(%u > %u)\n",
> -				pblk->max_write_pgs, =
PBLK_MAX_REQ_ADDRS);
> -		return -EINVAL;
> -	}
> -
> 	pblk->pad_dist =3D kcalloc(pblk->min_write_pgs - 1, =
sizeof(atomic64_t),
> 								=
GFP_KERNEL);
> 	if (!pblk->pad_dist)
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 48739f6c0417..cd2f61eed6a0 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 				 unsigned long *read_bitmap)
> {
> 	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> -	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
> +	struct ppa_addr ppas[NVM_MAX_VLBA];
> 	int nr_secs =3D rqd->nr_ppas;
> 	bool advanced_bio =3D false;
> 	int i, j =3D 0;
> @@ -450,7 +450,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio =
*bio)
> 	int ret =3D NVM_IO_ERR;
>=20
> 	/* logic error: lba out-of-bounds. Ignore read request */
> -	if (blba >=3D pblk->rl.nr_secs || nr_secs > PBLK_MAX_REQ_ADDRS) =
{
> +	if (blba >=3D pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
> 		WARN(1, "pblk: read lba out of bounds (lba:%llu, =
nr:%d)\n",
> 					(unsigned long long)blba, =
nr_secs);
> 		return NVM_IO_ERR;
> @@ -546,7 +546,7 @@ static int read_ppalist_rq_gc(struct pblk *pblk, =
struct nvm_rq *rqd,
> 			      struct pblk_line *line, u64 *lba_list,
> 			      u64 *paddr_list_gc, unsigned int nr_secs)
> {
> -	struct ppa_addr ppa_list_l2p[PBLK_MAX_REQ_ADDRS];
> +	struct ppa_addr ppa_list_l2p[NVM_MAX_VLBA];
> 	struct ppa_addr ppa_gc;
> 	int valid_secs =3D 0;
> 	int i;
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index 6a0616a6fcaf..a32790f7b7fc 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -127,7 +127,7 @@ static void __pblk_rl_update_rates(struct pblk_rl =
*rl,
> 	} else if (free_blocks < rl->high) {
> 		int shift =3D rl->high_pw - rl->rb_windows_pw;
> 		int user_windows =3D free_blocks >> shift;
> -		int user_max =3D user_windows << PBLK_MAX_REQ_ADDRS_PW;
> +		int user_max =3D user_windows << ilog2(NVM_MAX_VLBA);
>=20
> 		rl->rb_user_max =3D user_max;
> 		rl->rb_gc_max =3D max - user_max;
> @@ -228,7 +228,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
> 	rl->rsv_blocks =3D min_blocks;
>=20
> 	/* This will always be a power-of-2 */
> -	rb_windows =3D budget / PBLK_MAX_REQ_ADDRS;
> +	rb_windows =3D budget / NVM_MAX_VLBA;
> 	rl->rb_windows_pw =3D get_count_order(rb_windows);
>=20
> 	/* To start with, all buffer is available to user I/O writers */
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 579b4ea9716c..64ae0c7ed3bb 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -37,8 +37,6 @@
>=20
> #define PBLK_SECTOR (512)
> #define PBLK_EXPOSED_PAGE_SIZE (4096)
> -#define PBLK_MAX_REQ_ADDRS (64)
> -#define PBLK_MAX_REQ_ADDRS_PW (6)
>=20
> #define PBLK_NR_CLOSE_JOBS (4)
>=20
> @@ -99,8 +97,8 @@ enum {
> 	PBLK_RL_LOW =3D 4
> };
>=20
> -#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * =
PBLK_MAX_REQ_ADDRS)
> -#define pblk_dma_ppa_size (sizeof(u64) * PBLK_MAX_REQ_ADDRS)
> +#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * =
NVM_MAX_VLBA)
> +#define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
>=20
> /* write buffer completion context */
> struct pblk_c_ctx {
> @@ -218,8 +216,8 @@ struct pblk_lun {
> struct pblk_gc_rq {
> 	struct pblk_line *line;
> 	void *data;
> -	u64 paddr_list[PBLK_MAX_REQ_ADDRS];
> -	u64 lba_list[PBLK_MAX_REQ_ADDRS];
> +	u64 paddr_list[NVM_MAX_VLBA];
> +	u64 lba_list[NVM_MAX_VLBA];
> 	int nr_secs;
> 	int secs_to_gc;
> 	struct list_head list;
> --
> 2.11.0

Looks good to me.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_23CAA2AB-45A0-4D77-999D-58AE5C13884C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt6cWsACgkQIX4xUKFR
nnRIhA/+L8AJGWPhvsTfwvDb6XWZn8qzGsR+Pehm0gifjav8B1WClqTZpxfr0q+A
geOWIgfYyEld1kd7sFYf3WCVwtIRSNrCPn7w4B3MJyNNyXur1Nd3NR5uIBIsWeAy
nFtbflZX29FDeI3F3xOA6yXYQv5OZVGBM3IifEr8QOM2FAfXpSFyt0b2goVz8Yow
qlMtZoZJVHnS17DhcdFf1uVpL3/blDnCti9bcHYskZFkFQ3YQVzS7GIe/phFnOxo
DCLfEdNfrZ403y+MXSgZzdyDoH2QjmNAvJmBQ2PYa/P3ytKMQk4KNYtdAY2s5kVe
DZrWKsz7N9ZWd6yycX21ujOjmawmH8b2s0vKajb5/OdTvzzQLqRjkoMdMDo4Xeez
CiEyBLxgS/pPac3fI/myJY2jqwPgH2Y01kar9+RsDqM2Rtig+rHTjgMpp7l4iTZ8
3ZS3C/2Y/gjymOXVUI3Uc4IAm5LxznaBBs5vEvTzSaGpgG1qU/mQRryp8vdRsDJ9
fae3/OC0M25rkQTc3bll2nsL9uy68btl40aoYO+JqlkWFylxQxhbINUgJnw69aHp
xWLj6Jvs2l9Y4D58tIat23jFIMqAfN3d74mGzm5lGfWqH217uFi2Fc8TM66n7Qdx
/KIiv2JNvl07daNyqYaBdfshjd5vfDgkMXc9FA++KydIvzekLas=
=dHgz
-----END PGP SIGNATURE-----

--Apple-Mail=_23CAA2AB-45A0-4D77-999D-58AE5C13884C--
