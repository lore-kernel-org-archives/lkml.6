Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeDTSjG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:39:06 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:42420
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753583AbeDTSjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:39:04 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 1/3] lightnvm: pblk: rework write error recovery path
Thread-Topic: [PATCH 1/3] lightnvm: pblk: rework write error recovery path
Thread-Index: AQHT1/0YgBHfBX/x30S+iYAQNgFCq6QJ/bGA
Date: Fri, 20 Apr 2018 18:38:58 +0000
Message-ID: <736C3C1A-AABA-471C-94D2-ECF3353F78A3@cnexlabs.com>
References: <1524155964-3743-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1524155964-3743-2-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524155964-3743-2-git-send-email-hans.ml.holmberg@owltronix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [50.207.153.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB668;7:WY5QepWDwmThKSOV7Picl0cBbqr0Fu0Szc79SDidxB0cuff8xTrSjbI910vGKjnQ62cU2nbsI7l8ovPpG17UPhWuLGuCgdYzaxRfc89G1WRMsinaVQvfhk5DR1RGJB8m76v6ny4wfDyZas3pP0fzraQq6LhKG5jAD6FJnOQO+gNoCZeAgZpQYisPFvZl5cv8ffgsPKfjha6avn0RQRAuK6Ko25z5QaySRyhwsoH3/K43n3b7d3QzQBr0kxB3z7BT
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39380400002)(478600001)(107886003)(2616005)(446003)(6246003)(26005)(66066001)(186003)(5250100002)(25786009)(2906002)(2900100001)(33656002)(53946003)(53936002)(83716003)(59450400001)(486006)(6512007)(5660300001)(6506007)(476003)(6116002)(6436002)(86362001)(305945005)(3846002)(3660700001)(36756003)(4326008)(11346002)(54906003)(102836004)(3280700002)(6486002)(229853002)(76176011)(8676002)(82746002)(8936002)(316002)(7736002)(99936001)(81166006)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB668;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB668;
x-ms-traffictypediagnostic: CO2PR06MB668:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=cnexlabs.com;
x-microsoft-antispam-prvs: <CO2PR06MB6688D12623F67BB58773C90BAB40@CO2PR06MB668.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501397)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR06MB668;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB668;
x-forefront-prvs: 0648FCFFA8
x-microsoft-antispam-message-info: UrnDCYqHRsfCDXQJjADN19j6QT4AtHcq4RHUsxDJdgNIRNbl097EY5aRjaG6Jcw5BnydQjiu1Jp9tTbvbzTA6z+9wC0uZ5zbnTaIxLAoPE2P6z+tkb9XHf+h47oOwaJ4tQLJgbwRfTvd34ihhcg/pMcrGibiiiDAZktv1gnyvt0oohkwiGpYNDHZIUoJByM+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A5B1587A-12FA-4EFF-82DD-ED059B9A3E9A";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dd1a275c-fa52-4227-ee59-08d5a6edfa8a
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1a275c-fa52-4227-ee59-08d5a6edfa8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 18:38:58.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB668
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_A5B1587A-12FA-4EFF-82DD-ED059B9A3E9A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 19 Apr 2018, at 09.39, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> The write error recovery path is incomplete, so rework
> the write error recovery handling to do resubmits directly
> from the write buffer.
>=20
> When a write error occurs, the remaining sectors in the chunk are
> mapped out and invalidated and the request inserted in a resubmit =
list.
>=20
> The writer thread checks if there are any requests to resubmit,
> scans and invalidates any lbas that have been overwritten by later
> writes and resubmits the failed entries.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-init.c     |   2 +
> drivers/lightnvm/pblk-recovery.c |  91 ---------------
> drivers/lightnvm/pblk-write.c    | 241 =
++++++++++++++++++++++++++++-----------
> drivers/lightnvm/pblk.h          |   8 +-
> 4 files changed, 180 insertions(+), 162 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index bfc488d..6f06727 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -426,6 +426,7 @@ static int pblk_core_init(struct pblk *pblk)
> 		goto free_r_end_wq;
>=20
> 	INIT_LIST_HEAD(&pblk->compl_list);
> +	INIT_LIST_HEAD(&pblk->resubmit_list);
>=20
> 	return 0;
>=20
> @@ -1185,6 +1186,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 	pblk->state =3D PBLK_STATE_RUNNING;
> 	pblk->gc.gc_enabled =3D 0;
>=20
> +	spin_lock_init(&pblk->resubmit_lock);
> 	spin_lock_init(&pblk->trans_lock);
> 	spin_lock_init(&pblk->lock);
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 9cb6d5d..5983428 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -16,97 +16,6 @@
>=20
> #include "pblk.h"
>=20
> -void pblk_submit_rec(struct work_struct *work)
> -{
> -	struct pblk_rec_ctx *recovery =3D
> -			container_of(work, struct pblk_rec_ctx, ws_rec);
> -	struct pblk *pblk =3D recovery->pblk;
> -	struct nvm_rq *rqd =3D recovery->rqd;
> -	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
> -	struct bio *bio;
> -	unsigned int nr_rec_secs;
> -	unsigned int pgs_read;
> -	int ret;
> -
> -	nr_rec_secs =3D bitmap_weight((unsigned long int =
*)&rqd->ppa_status,
> -								=
NVM_MAX_VLBA);
> -
> -	bio =3D bio_alloc(GFP_KERNEL, nr_rec_secs);
> -
> -	bio->bi_iter.bi_sector =3D 0;
> -	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> -	rqd->bio =3D bio;
> -	rqd->nr_ppas =3D nr_rec_secs;
> -
> -	pgs_read =3D pblk_rb_read_to_bio_list(&pblk->rwb, bio, =
&recovery->failed,
> -								=
nr_rec_secs);

Please, remove functions that are not longer used. Doing a pass on the
rest of the removed functions would be a good idea.

> -	if (pgs_read !=3D nr_rec_secs) {
> -		pr_err("pblk: could not read recovery entries\n");
> -		goto err;
> -	}
> -
> -	if (pblk_setup_w_rec_rq(pblk, rqd, c_ctx)) {

Same here

> -		pr_err("pblk: could not setup recovery request\n");
> -		goto err;
> -	}
> -
> -#ifdef CONFIG_NVM_DEBUG
> -	atomic_long_add(nr_rec_secs, &pblk->recov_writes);
> -#endif

Can you add this debug counter to the new path? I see you added other
counters, if it is a rename, can you put it on a separate patch?

> -
> -	ret =3D pblk_submit_io(pblk, rqd);
> -	if (ret) {
> -		pr_err("pblk: I/O submission failed: %d\n", ret);
> -		goto err;
> -	}
> -
> -	mempool_free(recovery, pblk->rec_pool);
> -	return;
> -
> -err:
> -	bio_put(bio);
> -	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> -}
> -
> -int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
> -			struct pblk_rec_ctx *recovery, u64 *comp_bits,
> -			unsigned int comp)
> -{
> -	struct nvm_rq *rec_rqd;
> -	struct pblk_c_ctx *rec_ctx;
> -	int nr_entries =3D c_ctx->nr_valid + c_ctx->nr_padded;
> -
> -	rec_rqd =3D pblk_alloc_rqd(pblk, PBLK_WRITE);
> -	rec_ctx =3D nvm_rq_to_pdu(rec_rqd);
> -
> -	/* Copy completion bitmap, but exclude the first X completed =
entries */
> -	bitmap_shift_right((unsigned long int *)&rec_rqd->ppa_status,
> -				(unsigned long int *)comp_bits,
> -				comp, NVM_MAX_VLBA);
> -
> -	/* Save the context for the entries that need to be re-written =
and
> -	 * update current context with the completed entries.
> -	 */
> -	rec_ctx->sentry =3D pblk_rb_wrap_pos(&pblk->rwb, c_ctx->sentry + =
comp);
> -	if (comp >=3D c_ctx->nr_valid) {
> -		rec_ctx->nr_valid =3D 0;
> -		rec_ctx->nr_padded =3D nr_entries - comp;
> -
> -		c_ctx->nr_padded =3D comp - c_ctx->nr_valid;
> -	} else {
> -		rec_ctx->nr_valid =3D c_ctx->nr_valid - comp;
> -		rec_ctx->nr_padded =3D c_ctx->nr_padded;
> -
> -		c_ctx->nr_valid =3D comp;
> -		c_ctx->nr_padded =3D 0;
> -	}
> -
> -	recovery->rqd =3D rec_rqd;
> -	recovery->pblk =3D pblk;
> -
> -	return 0;
> -}
> -
> int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta =
*emeta_buf)
> {
> 	u32 crc;
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 3e6f1eb..ab45157 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -103,68 +103,147 @@ static void pblk_complete_write(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	pblk_rb_sync_end(&pblk->rwb, &flags);
> }
>=20
> -/* When a write fails, we are not sure whether the block has grown =
bad or a page
> - * range is more susceptible to write errors. If a high number of =
pages fail, we
> - * assume that the block is bad and we mark it accordingly. In all =
cases, we
> - * remap and resubmit the failed entries as fast as possible; if a =
flush is
> - * waiting on a completion, the whole stack would stall otherwise.
> - */
> -static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
> +/* Map remaining sectors in chunk, starting from ppa */
> +static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr =
*ppa)
> {
> -	void *comp_bits =3D &rqd->ppa_status;
> -	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
> -	struct pblk_rec_ctx *recovery;
> -	struct ppa_addr *ppa_list =3D rqd->ppa_list;
> -	int nr_ppas =3D rqd->nr_ppas;
> -	unsigned int c_entries;
> -	int bit, ret;
> +	struct nvm_tgt_dev *dev =3D pblk->dev;
> +	struct nvm_geo *geo =3D &dev->geo;
> +	struct pblk_line *line;
> +	struct ppa_addr map_ppa =3D *ppa;
> +	u64 paddr;
> +	int done =3D 0;
>=20
> -	if (unlikely(nr_ppas =3D=3D 1))
> -		ppa_list =3D &rqd->ppa_addr;
> +	line =3D &pblk->lines[pblk_ppa_to_line(*ppa)];
> +	spin_lock(&line->lock);
>=20
> -	recovery =3D mempool_alloc(pblk->rec_pool, GFP_ATOMIC);
> +	while (!done)  {
> +		paddr =3D pblk_dev_ppa_to_line_addr(pblk, map_ppa);
>=20
> -	INIT_LIST_HEAD(&recovery->failed);
> +		if (!test_and_set_bit(paddr, line->map_bitmap))
> +			line->left_msecs--;
>=20
> -	bit =3D -1;
> -	while ((bit =3D find_next_bit(comp_bits, nr_ppas, bit + 1)) < =
nr_ppas) {
> -		struct pblk_rb_entry *entry;
> -		struct ppa_addr ppa;
> +		if (!test_and_set_bit(paddr, line->invalid_bitmap))
> +			le32_add_cpu(line->vsc, -1);
>=20
> -		/* Logic error */
> -		if (bit > c_ctx->nr_valid) {
> -			WARN_ONCE(1, "pblk: corrupted write request\n");
> -			mempool_free(recovery, pblk->rec_pool);
> -			goto out;
> +		if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
> +			map_ppa.ppa++;
> +			if (map_ppa.g.pg =3D=3D geo->num_pg)
> +				done =3D 1;
> +		} else {
> +			map_ppa.m.sec++;
> +			if (map_ppa.m.sec =3D=3D geo->clba)
> +				done =3D 1;
> 		}
> +	}
>=20
> -		ppa =3D ppa_list[bit];
> -		entry =3D pblk_rb_sync_scan_entry(&pblk->rwb, &ppa);
> -		if (!entry) {
> -			pr_err("pblk: could not scan entry on write =
failure\n");
> -			mempool_free(recovery, pblk->rec_pool);
> -			goto out;
> -		}
> +	spin_unlock(&line->lock);
> +}
> +
> +static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int =
sentry,
> +		unsigned int nr_entries)

Can you align this?

> +{
> +	struct pblk_rb *rb =3D &pblk->rwb;
> +	struct pblk_rb_entry *entry;
> +	struct pblk_line *line;
> +	struct pblk_w_ctx *w_ctx;
> +	struct ppa_addr ppa_l2p;
> +	int flags;
> +	unsigned int pos, i;
> +
> +	spin_lock(&pblk->trans_lock);
> +	pos =3D sentry;
> +	for (i =3D 0; i < nr_entries; i++) {
> +		entry =3D &rb->entries[pos];
> +		w_ctx =3D &entry->w_ctx;
> +
> +		/* Check if the lba has been overwritten */
> +		ppa_l2p =3D pblk_trans_map_get(pblk, w_ctx->lba);
> +		if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
> +			w_ctx->lba =3D ADDR_EMPTY;
> +
> +		/* Mark up the entry as submittable again */
> +		flags =3D READ_ONCE(w_ctx->flags);
> +		flags |=3D PBLK_WRITTEN_DATA;
> +		/* Release flags on write context. Protect from writes =
*/
> +		smp_store_release(&w_ctx->flags, flags);
>=20
> -		/* The list is filled first and emptied afterwards. No =
need for
> -		 * protecting it with a lock
> +		/* Decrese the reference count to the line as we will
> +		 * re-map these entries
> 		 */
> -		list_add_tail(&entry->index, &recovery->failed);
> +		line =3D &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
> +		kref_put(&line->ref, pblk_line_put);
> +
> +		pos =3D (pos + 1) & (rb->nr_entries - 1);
> 	}
> +	spin_unlock(&pblk->trans_lock);
> +}
>=20
> -	c_entries =3D find_first_bit(comp_bits, nr_ppas);
> -	ret =3D pblk_recov_setup_rq(pblk, c_ctx, recovery, comp_bits, =
c_entries);
> -	if (ret) {
> -		pr_err("pblk: could not recover from write failure\n");
> -		mempool_free(recovery, pblk->rec_pool);
> -		goto out;
> +static void pblk_queue_resubmit(struct pblk *pblk, struct pblk_c_ctx =
*c_ctx)
> +{
> +	struct pblk_c_ctx *r_ctx;
> +
> +	r_ctx =3D kzalloc(sizeof(struct pblk_c_ctx), GFP_KERNEL);
> +	if (!r_ctx) {
> +		pr_err("pblk: failed to allocate resubmit context");

No need to print allocation failures - I know there are a few of these
in the code, but they should be removed.

> +		return;
> 	}
>=20
> +	r_ctx->lun_bitmap =3D NULL;
> +	r_ctx->sentry =3D c_ctx->sentry;
> +	r_ctx->nr_valid =3D c_ctx->nr_valid;
> +	r_ctx->nr_padded =3D c_ctx->nr_padded;
> +
> +	spin_lock(&pblk->resubmit_lock);
> +	list_add_tail(&r_ctx->list, &pblk->resubmit_list);
> +	spin_unlock(&pblk->resubmit_lock);
> +}
> +
> +static void pblk_submit_rec(struct work_struct *work)
> +{
> +	struct pblk_rec_ctx *recovery =3D
> +			container_of(work, struct pblk_rec_ctx, ws_rec);
> +	struct pblk *pblk =3D recovery->pblk;
> +	struct nvm_rq *rqd =3D recovery->rqd;
> +	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
> +	struct ppa_addr *ppa_list;
> +
> +	pblk_log_write_err(pblk, rqd);
> +
> +	if (rqd->nr_ppas =3D=3D 1)
> +		ppa_list =3D &rqd->ppa_addr;
> +	else
> +		ppa_list =3D rqd->ppa_list;
> +
> +	pblk_map_remaining(pblk, ppa_list);
> +	pblk_queue_resubmit(pblk, c_ctx);
> +
> +	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, =
c_ctx->lun_bitmap);
> +	if (c_ctx->nr_padded)
> +		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
> +							=
c_ctx->nr_padded);
> +	bio_put(rqd->bio);
> +	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> +	mempool_free(recovery, pblk->rec_pool);
> +
> +	atomic_dec(&pblk->inflight_io);
> +}
> +
> +
> +static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	struct pblk_rec_ctx *recovery;
> +
> +	recovery =3D mempool_alloc(pblk->rec_pool, GFP_ATOMIC);
> +	if (!recovery) {
> +		pr_err("pblk: could not allocate recovery work\n");
> +		return;
> +	}
> +
> +	recovery->pblk =3D pblk;
> +	recovery->rqd =3D rqd;
> +
> 	INIT_WORK(&recovery->ws_rec, pblk_submit_rec);
> 	queue_work(pblk->close_wq, &recovery->ws_rec);
> -
> -out:
> -	pblk_complete_write(pblk, rqd, c_ctx);
> }
>=20
> static void pblk_end_io_write(struct nvm_rq *rqd)
> @@ -173,8 +252,8 @@ static void pblk_end_io_write(struct nvm_rq *rqd)
> 	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
>=20
> 	if (rqd->error) {
> -		pblk_log_write_err(pblk, rqd);
> -		return pblk_end_w_fail(pblk, rqd);
> +		pblk_end_w_fail(pblk, rqd);
> +		return;
> 	}
> #ifdef CONFIG_NVM_DEBUG
> 	else
> @@ -339,6 +418,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
> 	bio =3D pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
> 					l_mg->emeta_alloc_type, =
GFP_KERNEL);
> 	if (IS_ERR(bio)) {
> +		pr_err("pblk: failed to map emeta io");
> 		ret =3D PTR_ERR(bio);
> 		goto fail_free_rqd;
> 	}
> @@ -515,26 +595,54 @@ static int pblk_submit_write(struct pblk *pblk)
> 	unsigned int secs_avail, secs_to_sync, secs_to_com;
> 	unsigned int secs_to_flush;
> 	unsigned long pos;
> +	unsigned int resubmit;
>=20
> -	/* If there are no sectors in the cache, flushes (bios without =
data)
> -	 * will be cleared on the cache threads
> -	 */
> -	secs_avail =3D pblk_rb_read_count(&pblk->rwb);
> -	if (!secs_avail)
> -		return 1;
> -
> -	secs_to_flush =3D pblk_rb_flush_point_count(&pblk->rwb);
> -	if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
> -		return 1;
> -
> -	secs_to_sync =3D pblk_calc_secs_to_sync(pblk, secs_avail, =
secs_to_flush);
> -	if (secs_to_sync > pblk->max_write_pgs) {
> -		pr_err("pblk: bad buffer sync calculation\n");
> -		return 1;
> -	}
> +	spin_lock(&pblk->resubmit_lock);
> +	resubmit =3D !list_empty(&pblk->resubmit_list);
> +	spin_unlock(&pblk->resubmit_lock);
> +
> +	/* Resubmit failed writes first */
> +	if (resubmit) {
> +		struct pblk_c_ctx *r_ctx;
> +
> +		spin_lock(&pblk->resubmit_lock);
> +		r_ctx =3D list_first_entry(&pblk->resubmit_list,
> +					struct pblk_c_ctx, list);
> +		list_del(&r_ctx->list);
> +		spin_unlock(&pblk->resubmit_lock);
>=20
> -	secs_to_com =3D (secs_to_sync > secs_avail) ? secs_avail : =
secs_to_sync;
> -	pos =3D pblk_rb_read_commit(&pblk->rwb, secs_to_com);
> +		secs_avail =3D r_ctx->nr_valid;
> +		pos =3D r_ctx->sentry;
> +
> +		pblk_prepare_resubmit(pblk, pos, secs_avail);
> +		secs_to_sync =3D pblk_calc_secs_to_sync(pblk, =
secs_avail,
> +				secs_avail);
> +
> +		kfree(r_ctx);
> +	} else {
> +		/* If there are no sectors in the cache,
> +		 * flushes (bios without data) will be cleared on
> +		 * the cache threads
> +		 */
> +		secs_avail =3D pblk_rb_read_count(&pblk->rwb);
> +		if (!secs_avail)
> +			return 1;
> +
> +		secs_to_flush =3D pblk_rb_flush_point_count(&pblk->rwb);
> +		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
> +			return 1;
> +
> +		secs_to_sync =3D pblk_calc_secs_to_sync(pblk, =
secs_avail,
> +					secs_to_flush);
> +		if (secs_to_sync > pblk->max_write_pgs) {
> +			pr_err("pblk: bad buffer sync calculation\n");
> +			return 1;
> +		}
> +
> +		secs_to_com =3D (secs_to_sync > secs_avail) ?
> +			secs_avail : secs_to_sync;
> +		pos =3D pblk_rb_read_commit(&pblk->rwb, secs_to_com);
> +	}
>=20
> 	bio =3D bio_alloc(GFP_KERNEL, secs_to_sync);
>=20
> @@ -553,6 +661,7 @@ static int pblk_submit_write(struct pblk *pblk)
> 	if (pblk_submit_io_set(pblk, rqd))
> 		goto fail_free_bio;
>=20
> +

No need for the extra line

> #ifdef CONFIG_NVM_DEBUG
> 	atomic_long_add(secs_to_sync, &pblk->sub_writes);
> #endif
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 9838d03..cff6aea 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -128,7 +128,6 @@ struct pblk_pad_rq {
> struct pblk_rec_ctx {
> 	struct pblk *pblk;
> 	struct nvm_rq *rqd;
> -	struct list_head failed;
> 	struct work_struct ws_rec;
> };
>=20
> @@ -664,6 +663,9 @@ struct pblk {
>=20
> 	struct list_head compl_list;
>=20
> +	spinlock_t resubmit_lock;	 /* Resubmit list lock */
> +	struct list_head resubmit_list; /* Resubmit list for failed =
writes*/
> +
> 	mempool_t *page_bio_pool;
> 	mempool_t *gen_ws_pool;
> 	mempool_t *rec_pool;
> @@ -849,13 +851,9 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq);
> /*
>  * pblk recovery
>  */
> -void pblk_submit_rec(struct work_struct *work);
> struct pblk_line *pblk_recov_l2p(struct pblk *pblk);
> int pblk_recov_pad(struct pblk *pblk);
> int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta =
*emeta);
> -int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
> -			struct pblk_rec_ctx *recovery, u64 *comp_bits,
> -			unsigned int comp);
>=20
> /*
>  * pblk gc
> --
> 2.7.4

Otherwise, it looks good to me.

Javier

--Apple-Mail=_A5B1587A-12FA-4EFF-82DD-ED059B9A3E9A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlraM78ACgkQIX4xUKFR
nnT5mRAAyVbkcOE2TRsShFfO1rb+ghxy8fZtjIaGPtgEEmyDhkz8qpkocZd6+zb2
yF2NT8LzUoAk91j95SmfMOWbGhrBblCS7GnYMkCa2p+WXJHjNBdR0zqc5K5L0DJS
/o6IUUWvNIzTqxPVG5BP0qaMv9qszGy41y9QZPCWH03uPl6RRf5SiP6AuNGT9R52
21WamLXYSsnodBojStIRmu4kiQS5yu7Owv0WHPonGC6eS4EFC0185EGC67WUMiB0
QjgkJuG1R+iAjwj9rEP+//cLhZbS5aFoVt7moiYMpcqhOz3PTQmGAjI70P19YuhJ
xyEayHVl7lzf5BRM1DFoABX/jKne3VMao0mZIAGvNj5EDWZWfuJ5XXXV3QUvxGf9
coWmfP5yKyL2OB3jZzTfVFegPQ2mN8fiNTjaxXYvmXytjVq865UG8kDEv02Dqi64
e8nV5LShuHMaI8lzaL0lybg548w8Z6SNK/swawhMnndqIL6urRswkTA8BMII/snY
JzyqRZN2Fq0NuKwxjmgbYAWy36qhMTZcpKwx3c/lXa5UmEmQW5Lv4smfppRT441r
q848igSDuyUQ4FXQS+wY9s1gbIh79hQP6fNZbRBk+h8chJegT0UUVV/jhC9e04wU
+roSV4gMPEggCK+mgbmP9ZWy5iI72yz/T3M+sugVMOb9I/YuoZI=
=5iqj
-----END PGP SIGNATURE-----

--Apple-Mail=_A5B1587A-12FA-4EFF-82DD-ED059B9A3E9A--
