Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9AEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DA520661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="jLH5T8ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DA520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeHaQTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:19:13 -0400
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:5968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727446AbeHaQTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sReJ6iOAp7gRpL7gutaHTUPlW2Yh0+zqTvBsYhslROs=;
 b=jLH5T8aobRqzJ9ZvtRhG/fn8gA0SGZmrxn3hYuI46TU4f/fe7eiZFzc0/q8AfJ/5SWABnp8AaNRe1kcyWbBLLW1bDZP6VxC8/RJEYpiTYVccBxG++YkfQQvmB9pP/booyODzsXBK6PF046ujqrzH3Ml+juDjm97YgT2/o4GedBI=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB521.namprd06.prod.outlook.com (10.141.198.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Fri, 31 Aug 2018 12:11:52 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Fri, 31 Aug 2018
 12:11:51 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Thread-Topic: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Thread-Index: AQHUP6HN+5S4mphJPEehcGEbp/in3aTZyFEA
Date:   Fri, 31 Aug 2018 12:11:51 +0000
Message-ID: <AAA74C68-4C22-48C8-B138-1C8EE72A875C@cnexlabs.com>
References: <20180829140832.29341-1-mb@lightnvm.io>
In-Reply-To: <20180829140832.29341-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB521;6:6ybgLBia0vRuK7fXFOhmdT6O5XENq4ikilKHQUe5W7fGteF9itHyypnoxLmyEt49bHdNbMKX+lalM73Lh/VVZT7mvIJX7c0W7m6yGHdcQZujI0z0/gqWzCA9zyyeVw6IlAtuWMaXEnm+xGU206fGtNkQvN5mFT7XT5wSJu6t0EZ/R3cg+6Cjm/0ruehkOCKLhXrudZDIPYaJVkFBfFqGEEzM4DLscBEixSSIL2p/hUn8TTDU9lpN9hFwfFWwD0zDI6fVm/bzVjtSmnYADlj9IY6yLe1ifOW9Xx5nrkto90W2mlIpVzoWEZ51zYDUed6Yx5SDaLvlTzGhyeFyj0frzB3x/BO0SPyF8Tz7oGgl/PCvuulQxLx9lgYGHW9qK6wbdNWpvfcSfHO0YJwpZgEz2+DUhkcL+S5Aq6CU1bMgZY88kU1CTNymxGpTVKnbN8mg5vJEwg7ruyYKgWqZO0c+Jw==;5:yFBXYRVAr6LldvTor+wKS0svgfrNge8mfsVKrpcEofYNXYu2s7NxDMf00xoh2rgIR/2GXk+uMUwg0xNYFumVU8u0b92cJc5qhHyapfTC9Uxii1yEsGd9qd6lSO2okMzPWmxO9eEj7s1YFqbhsSPoISnk8X+s+P1hIabxKSPB29I=;7:KxQVh+xtiIg5iu9VsnXpkvDSzOcI/0VtrM4ANKr8W7lUJ077/sw344qQNtG6DNqePeSiJQTGovVWxE7SXrKBdoWWu/XZorpwGwx0hS2CHN4jk55tZJtO4AO5luDS/eW2OK++aBk/gXQ1o/IcZLf8q85AWd77qckSVc1c1VA2nWnUn6BeKYatp8YDpU9HBV4wFvJM+b7p5ApROxQ/kRyOO2Z4FbPGK3/gT2xVen17U3LX2KyZqnsgP47b7bsMVJKv
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39840400004)(199004)(189003)(8676002)(316002)(7736002)(81156014)(81166006)(305945005)(4326008)(66066001)(478600001)(8936002)(25786009)(6916009)(6246003)(5660300001)(53936002)(5250100002)(6512007)(54906003)(36756003)(2906002)(68736007)(256004)(97736004)(6486002)(186003)(106356001)(105586002)(99936001)(33656002)(99286004)(6116002)(3846002)(83716003)(486006)(6436002)(476003)(82746002)(102836004)(76176011)(2616005)(2900100001)(229853002)(14454004)(14444005)(446003)(86362001)(11346002)(575784001)(26005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB521;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: ab59429a-ef86-477a-7808-08d60f3aef17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB521;
x-ms-traffictypediagnostic: CO2PR06MB521:
x-microsoft-antispam-prvs: <CO2PR06MB52173997379F45B09765572BA0F0@CO2PR06MB521.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR06MB521;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB521;
x-forefront-prvs: 07817FCC2D
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cws16QSdHVSM+bXhHIWENq3EVP4aWrYF9Yoz6ZcXlQonSPE2+iCIw7atk0qvTDfHKMSciBNElyX4jSB6M+FmHmIsPGdQjD5mXub9mmayjFkOUiCwVzhPAmnCBXVwJCYHBSik/VhSorCvyMBItT160fGS2QGgl4pdkcQIHzd1plWL2p+nlvJp6Ne2KsPVT5P6Aso6x0UTkQpBvfAb75qiyAZ4zabEPJlbg9c7cyU/TQAeEYBF4pgYF/+NB111xVs61MoeiwScYohUjGXjXdOyPPY5EehJ+NlnZ0AM5bFlZ7iadckCGaKOzBpVdCA8QLMr7VKs55aa8+F3SyKpTtKRrjSqr0I+M3sckznVDBY5Css=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0FBCFE71-71C9-44E8-9409-8C4BB4DDCE0E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab59429a-ef86-477a-7808-08d60f3aef17
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 12:11:51.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_0FBCFE71-71C9-44E8-9409-8C4BB4DDCE0E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Aug 2018, at 16.08, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> Remove the debug only iteration within __pblk_down_page, which
> then allows us to reduce the number of arguments down to pblk and
> the parallel unit from the functions that calls it. Simplifying the
> callers logic considerably.
>=20
> Also, rename the functions pblk_[down/up]_page to pblk_[down/up]_pu,
> to communicate that it takes a lock on the parallel unit.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-core.c     | 34 =
+++++++++-------------------------
> drivers/lightnvm/pblk-map.c      |  2 +-
> drivers/lightnvm/pblk-recovery.c |  6 +++---
> drivers/lightnvm/pblk-write.c    |  6 +++---
> drivers/lightnvm/pblk.h          |  6 +++---
> 5 files changed, 19 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index bb1a7cc24cbb..08df6bcd2f81 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1861,8 +1861,7 @@ void pblk_gen_run_ws(struct pblk *pblk, struct =
pblk_line *line, void *priv,
> 	queue_work(wq, &line_ws->ws);
> }
>=20
> -static void __pblk_down_page(struct pblk *pblk, struct ppa_addr =
*ppa_list,
> -			     int nr_ppas, int pos)
> +static void __pblk_down_pu(struct pblk *pblk, int pos)
> {
> 	struct pblk_lun *rlun =3D &pblk->luns[pos];
> 	int ret;
> @@ -1871,13 +1870,6 @@ static void __pblk_down_page(struct pblk *pblk, =
struct ppa_addr *ppa_list,
> 	 * Only send one inflight I/O per LUN. Since we map at a page
> 	 * granurality, all ppas in the I/O will map to the same LUN
> 	 */
> -#ifdef CONFIG_NVM_PBLK_DEBUG
> -	int i;
> -
> -	for (i =3D 1; i < nr_ppas; i++)
> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
> -#endif
>=20
> 	ret =3D down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
> 	if (ret =3D=3D -ETIME || ret =3D=3D -EINTR)
> @@ -1885,21 +1877,21 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
> 				-ret);
> }
>=20
> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas)
> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>=20
> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
> +	__pblk_down_pu(pblk, pos);
> }
>=20
> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas,
> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
> 		  unsigned long *lun_bitmap)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>=20
> 	/* If the LUN has been locked for this same request, do no =
attempt to
> 	 * lock it again
> @@ -1907,23 +1899,15 @@ void pblk_down_rq(struct pblk *pblk, struct =
ppa_addr *ppa_list, int nr_ppas,
> 	if (test_and_set_bit(pos, lun_bitmap))
> 		return;
>=20
> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
> +	__pblk_down_pu(pblk, pos);
> }
>=20
> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas)
> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_lun *rlun;
> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
> -
> -#ifdef CONFIG_NVM_PBLK_DEBUG
> -	int i;
> -
> -	for (i =3D 1; i < nr_ppas; i++)
> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
> -#endif
> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>=20
> 	rlun =3D &pblk->luns[pos];
> 	up(&rlun->wr_sem);
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index dc0efb852475..ff677ca6e4e1 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -79,7 +79,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 		}
> 	}
>=20
> -	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
> +	pblk_down_rq(pblk, ppa_list[0], lun_bitmap);
> 	return 0;
> }
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index eea901d7cebc..df624d504d24 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -227,7 +227,7 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
> 	struct pblk_pad_rq *pad_rq =3D rqd->private;
> 	struct pblk *pblk =3D pad_rq->pblk;
>=20
> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
> +	pblk_up_pu(pblk, ppa_list[0]);
>=20
> 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>=20
> @@ -339,12 +339,12 @@ static int pblk_recov_pad_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	}
>=20
> 	kref_get(&pad_rq->ref);
> -	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> +	pblk_down_pu(pblk, rqd->ppa_list[0]);
>=20
> 	ret =3D pblk_submit_io(pblk, rqd);
> 	if (ret) {
> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
> -		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> +		pblk_up_pu(pblk, rqd->ppa_list[0]);
> 		goto fail_free_bio;
> 	}
>=20
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index cd579b440b56..55d198edd70a 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -270,7 +270,7 @@ static void pblk_end_io_write_meta(struct nvm_rq =
*rqd)
> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> 	int sync;
>=20
> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
> +	pblk_up_pu(pblk, ppa_list[0]);
>=20
> 	if (rqd->error) {
> 		pblk_log_write_err(pblk, rqd);
> @@ -420,7 +420,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
> 		list_del(&meta_line->list);
> 	spin_unlock(&l_mg->close_lock);
>=20
> -	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
> +	pblk_down_pu(pblk, ppa_list[0]);
>=20
> 	ret =3D pblk_submit_io(pblk, rqd);
> 	if (ret) {
> @@ -431,7 +431,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
> 	return NVM_IO_OK;
>=20
> fail_rollback:
> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
> +	pblk_up_pu(pblk, ppa_list[0]);
> 	spin_lock(&l_mg->close_lock);
> 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
> 	list_add(&meta_line->list, &meta_line->list);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 2f61f4428fcb..390855375b1e 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -823,10 +823,10 @@ u64 pblk_alloc_page(struct pblk *pblk, struct =
pblk_line *line, int nr_secs);
> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int =
nr_secs);
> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
> 		   unsigned long secs_to_flush);
> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas);
> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas,
> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa);
> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
> 		  unsigned long *lun_bitmap);
> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas);
> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa);
> void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
> int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t =
flags,
> 		       int nr_pages);
> --
> 2.11.0


The patch looks good to me. The renaming to PU though is confusing. The
underlying reason to take the semaphore is to avoid write pointer
violations. At the moment, we only have an open line in pblk, which
makes that the semaphore effectively protects a PU, but when we have
several open lines this is no longer true.

Javier

--Apple-Mail=_0FBCFE71-71C9-44E8-9409-8C4BB4DDCE0E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluJMIQACgkQIX4xUKFR
nnTX0w/8DgUHqMSZUKSJPDMJtMyGNm1HMcl8IWeUvku+a0L+WFL8FUSN67xUsZcj
22HZf7s6nasmYU60+70r71TBqDp4wdD7ZzF4apNQLwrr9YvpYWqwTcBVS8YUwBGb
TUnIdO/kXNO+3v5OS3zczbzq+myTaqbAwKHJhbsDJRZBBO1pY2QaFvCKlSX3AKEu
V5qVcRwCfSOfvRIg4YjPMDfq7vKm/JHtnBy5bseteR5WSZRdtXLWPnqqtJ/x8Itt
sWtZ54x5ZpPbxs9TlDxh6lA5UFIE16REQwnppfkNZlxPhbHl+I/bdeQmBfD7p2HJ
15ObF2rJap3aJvmZ4b9P1LdhMK9+v4jXk9ry6FVpY/Mn6qb0zerErGkdfI7epAcu
mNXyRJDfkijYoIKmezrq20RMTUVG51lW05bT9bdQjN05856BhlCwLJnXd4OYPy2P
owm7jBlgt78qZZmO9aUwkQt19IMPsPSCK0n1Di2bn+uLW5Dmv02fWfbluusVUwsO
fXEHfmA6KQGZCUNFJ+mJP49N6RoMUGM6HROKGzLa0dNCSiHOK6oPHLoeLtYgthES
VuXkkTankws+ueoqHSu3QIfoxIJdiEeoKqSrLKCZSAGlBxsZ5xLODHJExVGAyrJn
AeV9Txmfv1twgYnT5H4G6XrVisVe5tAyM5bGNOee7HnEMRpAsb8=
=wClt
-----END PGP SIGNATURE-----

--Apple-Mail=_0FBCFE71-71C9-44E8-9409-8C4BB4DDCE0E--
