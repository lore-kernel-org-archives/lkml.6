Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A653F21763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="eCKEa7VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A653F21763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeHCPcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:32:20 -0400
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:50882
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729909AbeHCPcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga+2Muq5yj6SKF4NYdLnqd1EE3Vp6F+cxtVrw9A54x4=;
 b=eCKEa7VLwb/Ua6tS90jndouEv8zfOj39A9od5w8qShKDQda2lzSf0sBswBFfgAm8B2Chjg+t1Ar+0TnMnh6GvEXNnwJRiA21G1wF95PmN+9CmDawf0jmzaLWlTcvSEWoqtI2YIa9ozlEKxLwWKrg83dqAilyLXm/7XyodkH+Rxo=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB492.namprd06.prod.outlook.com (10.141.197.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 13:35:50 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 13:35:49 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: combine 1.2 and 2.0 command flags
Thread-Topic: [PATCH] lightnvm: combine 1.2 and 2.0 command flags
Thread-Index: AQHUKnzdSVefevl9GE6jg84HfdmUqKSuCMuA
Date:   Fri, 3 Aug 2018 13:35:49 +0000
Message-ID: <537156D9-0CE0-4B8F-B8E3-32B291529EE4@cnexlabs.com>
References: <20180802162058.9800-1-mb@lightnvm.io>
In-Reply-To: <20180802162058.9800-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB492;6:YWKB0Pb6nmylkACbprWMG6gDky7NXezmr2Zh8l1toHtNcr+MtKEjICWqGSJkOLxNPjLCDZHmXoB3HdATvFl2YIQz/g3r+VSrg3Q4UoZSFASaRx3cr/FZuqdIytefu68QLfyBmceWEBCusaxjIQ35TDW12cZcdc2MraJjkMG15GLGC1ubcjKF2FEHPlCxot6cZLR4p5DgMIbUHORbtWZl8WniN+jJ5b2O0Na4RU7kakZV9CpYy9W2mpV1CgPOCVxdE3RQmfDRqgmX9C8eeL//ssfrHlsncIoXIsTCpzf9da/33PgkH9o/j9x4fgSo1OQ5T6rWqzpEDEPPMuELJY9KOle5eV/WnY4jcDrcc/xcYPkCQI/psupTHHFNkqHGAQkjigi5UFvwR2tgz7m9uhHBTGgruIoYQ14lxrQkMDVON9LX6QH+QTOxtaoQiPkOt2V/sM5auQ1W3MFOny7qBAyDlQ==;5:iGdAclivmowzCXMdNeDWmVb/hL+5fD7IsVzMgcOu3yrEyGPRes4J6GsOfY3aiIqKiFoMk4wLu+Mpqe4cZAbN7Da06EenpbRLM51pTFRL+oPB8FKpRwtPLui6cF+25aS1u8U+8iHK0dm/UxVbhgYcz+i4EyKniNmczVMTcLyZfBk=;7:3QGaFP5UPU/DqY2vJ1qo+ks7wMOCBKtDK56KQPy4IAHIxIWKOp0Xgp+K/YfrCg8A4rK12rTQx9l3vYuOqNrGfloVaU1nFc4yRRr3yh7D0msgpTwHkTO2E68UJhotzgAOfyb97xM4hk7lfiObR7hA9y9Qm/NvfUFlnJykc/Q7yuSleVUcUbAlp93hOvlWcAy4x0YXs/DvcYJjQyATnyynSmWKia3CO7d8+Uagu5pt/ZIK8Ybqftgv2/2iBnXgVO07
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39840400004)(189003)(199004)(476003)(25786009)(14444005)(256004)(5660300001)(5250100002)(36756003)(99286004)(66066001)(6246003)(33656002)(86362001)(2900100001)(6916009)(478600001)(4326008)(486006)(575784001)(53936002)(82746002)(2616005)(6486002)(446003)(7736002)(6506007)(97736004)(102836004)(229853002)(106356001)(105586002)(6436002)(76176011)(26005)(14454004)(6116002)(8676002)(3846002)(54906003)(305945005)(8936002)(81166006)(81156014)(83716003)(6512007)(11346002)(186003)(99936001)(2906002)(68736007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB492;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5e26c0eb-fd01-4226-3092-08d5f94606be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB492;
x-ms-traffictypediagnostic: CO2PR06MB492:
x-microsoft-antispam-prvs: <CO2PR06MB492EC633384DF0AF0610F90BA230@CO2PR06MB492.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB492;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB492;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oYfKzSm3XYlCojU1KLM50qxoL4RKy27zJ7iWgBZPUBkUTJMYxso/2XRfiiZ4RsEExQ9mY2injcdmVXfailp45kupVle/VD92GcZAC/dqCPZW//pPqcneanRCSrV9TCdQ1S/ndKU2cQVGSp/dfsOrevh7jdXoysZPMgtT9shMKV7zmlZEc5HYyIma9KJkDVNKS4VQEkzdb7BIGoKWvM2MwdMUeDsU8BJ1z6E63EtRAUacQunzq2Ugx56BTvqp2HqdJYLy6/uumQLO82qZCcrZlSEwQ6FZBLXo6B92MTSHyIK9/nSziSrKXgRVghHFkMskcmwWY5mziXmxywcy/gdtjf/OBo5QqNapusmLpegTpGw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C9F32BAF-51E9-40FC-A0EE-12CAAB031353";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e26c0eb-fd01-4226-3092-08d5f94606be
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 13:35:49.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_C9F32BAF-51E9-40FC-A0EE-12CAAB031353
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Aug 2018, at 18.20, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> Avoid targets open-code the nvm_rq command flag for version 1.2 and
> 2.0. The core should have this responsibility.
>=20
> When moved into core, the flags parameter can be distilled into
> access hint, scrambling, and program/erase suspend. Replace the
> access hint with a "is_seq" parameter, and let the rest be
> dependent on the command opcode, which is trivial to detect and
> set.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/core.c          | 20 ++++++++++++++++++++
> drivers/lightnvm/pblk-core.c     | 13 ++++---------
> drivers/lightnvm/pblk-read.c     |  8 +-------
> drivers/lightnvm/pblk-recovery.c | 14 ++++----------
> drivers/lightnvm/pblk-write.c    |  2 +-
> drivers/lightnvm/pblk.h          | 38 =
--------------------------------------
> include/linux/lightnvm.h         |  2 ++
> 7 files changed, 32 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 60aa7bc5a630..68553c7ae937 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -752,6 +752,24 @@ int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev =
*tgt_dev, struct ppa_addr *ppas,
> }
> EXPORT_SYMBOL(nvm_set_tgt_bb_tbl);
>=20
> +static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
> +{
> +	int flags =3D 0;
> +
> +	if (geo->version =3D=3D NVM_OCSSD_SPEC_20)
> +		return 0;
> +
> +	if (rqd->is_seq)
> +		flags |=3D geo->pln_mode >> 1;
> +
> +	if (rqd->opcode =3D=3D NVM_OP_PREAD)
> +		flags |=3D (NVM_IO_SCRAMBLE_ENABLE | NVM_IO_SUSPEND);
> +	else if (rqd->opcode =3D=3D NVM_OP_PWRITE)
> +		flags |=3D NVM_IO_SCRAMBLE_ENABLE;
> +
> +	return flags;
> +}
> +
> int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
> {
> 	struct nvm_dev *dev =3D tgt_dev->parent;
> @@ -763,6 +781,7 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, =
struct nvm_rq *rqd)
> 	nvm_rq_tgt_to_dev(tgt_dev, rqd);
>=20
> 	rqd->dev =3D tgt_dev;
> +	rqd->flags =3D nvm_set_flags(&tgt_dev->geo, rqd);
>=20
> 	/* In case of error, fail with right address format */
> 	ret =3D dev->ops->submit_io(dev, rqd);
> @@ -783,6 +802,7 @@ int nvm_submit_io_sync(struct nvm_tgt_dev =
*tgt_dev, struct nvm_rq *rqd)
> 	nvm_rq_tgt_to_dev(tgt_dev, rqd);
>=20
> 	rqd->dev =3D tgt_dev;
> +	rqd->flags =3D nvm_set_flags(&tgt_dev->geo, rqd);
>=20
> 	/* In case of error, fail with right address format */
> 	ret =3D dev->ops->submit_io_sync(dev, rqd);
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 00984b486fea..72acf2f6dbd6 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -688,7 +688,7 @@ static int pblk_line_submit_emeta_io(struct pblk =
*pblk, struct pblk_line *line,
> 	if (dir =3D=3D PBLK_WRITE) {
> 		struct pblk_sec_meta *meta_list =3D rqd.meta_list;
>=20
> -		rqd.flags =3D pblk_set_progr_mode(pblk, PBLK_WRITE);
> +		rqd.is_seq =3D 1;
> 		for (i =3D 0; i < rqd.nr_ppas; ) {
> 			spin_lock(&line->lock);
> 			paddr =3D __pblk_alloc_page(pblk, line, min);
> @@ -703,11 +703,9 @@ static int pblk_line_submit_emeta_io(struct pblk =
*pblk, struct pblk_line *line,
> 		for (i =3D 0; i < rqd.nr_ppas; ) {
> 			struct ppa_addr ppa =3D addr_to_gen_ppa(pblk, =
paddr, id);
> 			int pos =3D pblk_ppa_to_pos(geo, ppa);
> -			int read_type =3D PBLK_READ_RANDOM;
>=20
> 			if (pblk_io_aligned(pblk, rq_ppas))
> -				read_type =3D PBLK_READ_SEQUENTIAL;
> -			rqd.flags =3D pblk_set_read_mode(pblk, =
read_type);
> +				rqd.is_seq =3D 1;
>=20
> 			while (test_bit(pos, line->blk_bitmap)) {
> 				paddr +=3D min;
> @@ -787,17 +785,14 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
> 	__le64 *lba_list =3D NULL;
> 	int i, ret;
> 	int cmd_op, bio_op;
> -	int flags;
>=20
> 	if (dir =3D=3D PBLK_WRITE) {
> 		bio_op =3D REQ_OP_WRITE;
> 		cmd_op =3D NVM_OP_PWRITE;
> -		flags =3D pblk_set_progr_mode(pblk, PBLK_WRITE);
> 		lba_list =3D emeta_to_lbas(pblk, line->emeta->buf);
> 	} else if (dir =3D=3D PBLK_READ_RECOV || dir =3D=3D PBLK_READ) {
> 		bio_op =3D REQ_OP_READ;
> 		cmd_op =3D NVM_OP_PREAD;
> -		flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_SEQUENTIAL);
> 	} else
> 		return -EINVAL;
>=20
> @@ -822,7 +817,7 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
>=20
> 	rqd.bio =3D bio;
> 	rqd.opcode =3D cmd_op;
> -	rqd.flags =3D flags;
> +	rqd.is_seq =3D 1;
> 	rqd.nr_ppas =3D lm->smeta_sec;
>=20
> 	for (i =3D 0; i < lm->smeta_sec; i++, paddr++) {
> @@ -885,7 +880,7 @@ static void pblk_setup_e_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 	rqd->opcode =3D NVM_OP_ERASE;
> 	rqd->ppa_addr =3D ppa;
> 	rqd->nr_ppas =3D 1;
> -	rqd->flags =3D pblk_set_progr_mode(pblk, PBLK_ERASE);
> +	rqd->is_seq =3D 1;
> 	rqd->bio =3D NULL;
> }
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 26d414ae25b6..48739f6c0417 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -93,9 +93,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 	}
>=20
> 	if (pblk_io_aligned(pblk, nr_secs))
> -		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_SEQUENTIAL);
> -	else
> -		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_RANDOM);
> +		rqd->is_seq =3D 1;
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	atomic_long_add(nr_secs, &pblk->inflight_reads);
> @@ -344,7 +342,6 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
>=20
> 	rqd->bio =3D new_bio;
> 	rqd->nr_ppas =3D nr_holes;
> -	rqd->flags =3D pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
>=20
> 	pr_ctx->ppa_ptr =3D NULL;
> 	pr_ctx->orig_bio =3D bio;
> @@ -438,8 +435,6 @@ static void pblk_read_rq(struct pblk *pblk, struct =
nvm_rq *rqd, struct bio *bio,
> 	} else {
> 		rqd->ppa_addr =3D ppa;
> 	}
> -
> -	rqd->flags =3D pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
> }
>=20
> int pblk_submit_read(struct pblk *pblk, struct bio *bio)
> @@ -662,7 +657,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq)
>=20
> 	rqd.opcode =3D NVM_OP_PREAD;
> 	rqd.nr_ppas =3D gc_rq->secs_to_gc;
> -	rqd.flags =3D pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
> 	rqd.bio =3D bio;
>=20
> 	if (pblk_submit_io_sync(pblk, &rqd)) {
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index e232e47e1353..cf629ab016ba 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -159,9 +159,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	rqd->dma_meta_list =3D dma_meta_list;
>=20
> 	if (pblk_io_aligned(pblk, rq_ppas))
> -		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_SEQUENTIAL);
> -	else
> -		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_RANDOM);
> +		rqd->is_seq =3D 1;
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; ) {
> 		struct ppa_addr ppa;
> @@ -302,7 +300,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, =
struct pblk_line *line,
>=20
> 	rqd->bio =3D bio;
> 	rqd->opcode =3D NVM_OP_PWRITE;
> -	rqd->flags =3D pblk_set_progr_mode(pblk, PBLK_WRITE);
> +	rqd->is_seq =3D 1;
> 	rqd->meta_list =3D meta_list;
> 	rqd->nr_ppas =3D rq_ppas;
> 	rqd->ppa_list =3D ppa_list;
> @@ -436,9 +434,7 @@ static int pblk_recov_scan_all_oob(struct pblk =
*pblk, struct pblk_line *line,
> 	rqd->dma_meta_list =3D dma_meta_list;
>=20
> 	if (pblk_io_aligned(pblk, rq_ppas))
> -		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_SEQUENTIAL);
> -	else
> -		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_RANDOM);
> +		rqd->is_seq =3D 1;
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; ) {
> 		struct ppa_addr ppa;
> @@ -567,9 +563,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	rqd->dma_meta_list =3D dma_meta_list;
>=20
> 	if (pblk_io_aligned(pblk, rq_ppas))
> -		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_SEQUENTIAL);
> -	else
> -		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_RANDOM);
> +		rqd->is_seq =3D 1;
>=20
> 	for (i =3D 0; i < rqd->nr_ppas; ) {
> 		struct ppa_addr ppa;
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index ee774a86cf1e..508c63701eda 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -302,7 +302,7 @@ static int pblk_alloc_w_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> 	/* Setup write request */
> 	rqd->opcode =3D NVM_OP_PWRITE;
> 	rqd->nr_ppas =3D nr_secs;
> -	rqd->flags =3D pblk_set_progr_mode(pblk, PBLK_WRITE);
> +	rqd->is_seq =3D 1;
> 	rqd->private =3D pblk;
> 	rqd->end_io =3D end_io;
>=20
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 4760af7b6499..48b3035df3c4 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1255,44 +1255,6 @@ static inline u32 pblk_calc_emeta_crc(struct =
pblk *pblk,
> 	return crc;
> }
>=20
> -static inline int pblk_set_progr_mode(struct pblk *pblk, int type)
> -{
> -	struct nvm_tgt_dev *dev =3D pblk->dev;
> -	struct nvm_geo *geo =3D &dev->geo;
> -	int flags;
> -
> -	if (geo->version =3D=3D NVM_OCSSD_SPEC_20)
> -		return 0;
> -
> -	flags =3D geo->pln_mode >> 1;
> -
> -	if (type =3D=3D PBLK_WRITE)
> -		flags |=3D NVM_IO_SCRAMBLE_ENABLE;
> -
> -	return flags;
> -}
> -
> -enum {
> -	PBLK_READ_RANDOM	=3D 0,
> -	PBLK_READ_SEQUENTIAL	=3D 1,
> -};
> -
> -static inline int pblk_set_read_mode(struct pblk *pblk, int type)
> -{
> -	struct nvm_tgt_dev *dev =3D pblk->dev;
> -	struct nvm_geo *geo =3D &dev->geo;
> -	int flags;
> -
> -	if (geo->version =3D=3D NVM_OCSSD_SPEC_20)
> -		return 0;
> -
> -	flags =3D NVM_IO_SUSPEND | NVM_IO_SCRAMBLE_ENABLE;
> -	if (type =3D=3D PBLK_READ_SEQUENTIAL)
> -		flags |=3D geo->pln_mode >> 1;
> -
> -	return flags;
> -}
> -
> static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
> {
> 	return !(nr_secs % pblk->min_write_pgs);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index e9e0d1c7eaf5..8acc2fe277d6 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -305,6 +305,8 @@ struct nvm_rq {
> 	u64 ppa_status; /* ppa media status */
> 	int error;
>=20
> +	int is_seq; /* Sequential hint flag. 1.2 only */
> +
> 	void *private;
> };
>=20
> --
> 2.11.0

Looks good to me. If you pick up [1], please note that you will need to
transform it too.

[1] lightnvm: pblk: recover chunk state on 1.2 devices

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_C9F32BAF-51E9-40FC-A0EE-12CAAB031353
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkWjMACgkQIX4xUKFR
nnQa9RAApxPIua3cDtspXc7ibA5wx7a3pdlxSGIpVc4Bz9LWSn5bh1j3lkoMc8J2
Wlk5kQjfV6HRQuqnPiJCidLwDu0thGq3Bw9Q3xkiVb3X8akyhV4IS17pdhfwDemx
GIL7aJjEMYOkglJaKumQ8fTOFNEClMJdKDGKVemd1iBLX/oteNO9BVp97VvJoq6Z
uBd1cXJ65tmNNWt6LH460/ZQ2iAaNlMBGASigq8JCokkHyGTUTUcZI5/BvZK+7TS
96A/uCQPvqXdoiCny0nw7e4v/PmQ06UFzrV35QO5/AHM7azz8WTHYdJPWjLiyQeB
uYRrLJ8mvkUQ5BYnJumIw73pni+BUbQl/pfjWjBw8GoMGJUnW2CEdkwlV52YQJQD
4ug/kq3ouZ56seHDbCbUd94IjURK5HDSamEP1Ge1Dq8lEC0UvGnyx+Q2jKX4wOeV
mcLRi76h8AuF0n63ann5mqgeLEvpqbJ0iKf9QlypmXmZuM7zRKXOiH0/HNVZm29C
aVyEvnW8Cs3Sc2A4u/n954U142sS0RzOfBP0R19MHB6biZXmtE8J6vtAQXq/XOTB
keoR6LExEO3wPmiJH6hHZKnopeDs1IgfqSQp7R2lDUv+8ohw/JPXhbkE10v+yUdJ
x6iSvumlnvaoKc70HcckecwAHldWDtSH6OmvnfjtMiTlG7cnxsA=
=AZPg
-----END PGP SIGNATURE-----

--Apple-Mail=_C9F32BAF-51E9-40FC-A0EE-12CAAB031353--
