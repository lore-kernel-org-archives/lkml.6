Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AIpwx4806rJSF+EGVVARBtf8C0Mud4cBaIb4SVVLqr8R6LhoIHtHS/TPnPgu4WnECy18gWSkY1Kq
ARC-Seal: i=1; a=rsa-sha256; t=1522697690; cv=none;
        d=google.com; s=arc-20160816;
        b=GuG30lNaeMVz+Y3DhWJOWiDVU5pQ2rX641Kx9HpsE301K009RqLBmuUUFewjdawa5G
         7x0MpiKP28KGY0zCZ3mKVhn47FuMrD9P+kbjW2NbTfJcv5qSJaFPCWtSla+MYT/GOrdV
         KTmGv02OzVCfcHZdL1SWylkE1n6ue+edXKxnzgq0h4DCBkA09BQqZus7NjhIk1iRj/yz
         oKk7rtZdvgLiAH87YU+RA1NEbQol6CD5m3fUI3/AalQcjPQPP+kesmJLFxkb21E0ij38
         5Su1tEwME6RaeAXZtPz7PZjFIv/9OfpNEB0OyQmUzr0GBqDjTjx4Jh1ZBDwN48XNht/k
         w1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=GkXJqHZp0WY2GInWoB+0UYydbCcjsIDjwEH3Tc4RHoM=;
        b=0TjIHT6wAEy4uTAhGWJUfEeoTZ3UBa5ZdtjB3qs0x9z9ToqUUT40dgIWAB4MSpkiT4
         SRKaMcBsfQ/lWgMKS5nmP9jgxBPhcOs+LvDT/RikvCqR5WIe9yaTPJDOaUIPJpDx5sOl
         cqpvyw0/q7EKTH/+fwaRDsEb/EYxvpiz3CsdtJF6IB/CKDopC393hicj3ZKO3kW1iZkH
         pnYovj+UoPInNpQpV81hC3iWjB7R7D4LFWHst5XouJUvcvNVhJm07MOdRxHZ6jrxMU25
         dYDW4QJN0Blb2LrrFJ4Wg7mTVzz+ndUz96zi8HBBq7iip7gC6dxDxaFwmPVQgjGif2Us
         CNUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,396,1517904000";
   d="scan'208";a="217038970"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: James Simmons <jsimmons@infradead.org>
CC: NeilBrown <neilb@suse.com>, "Drokin, Oleg" <oleg.drokin@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 11/17] staging: lustre: libcfs: discard cfs_time_shift().
Thread-Topic: [PATCH 11/17] staging: lustre: libcfs: discard
 cfs_time_shift().
Thread-Index: AQHTyFmnPaab2m4I+kyw4VsVO58/aKPuV+IA
Date: Mon, 2 Apr 2018 19:34:33 +0000
Message-ID: <0B6A147C-7E98-4B00-AF32-AF8843484CF9@intel.com>
References: <152229732768.27689.4800156943561963977.stgit@noble>
 <152229760863.27689.4681198496926109808.stgit@noble>
 <alpine.LFD.2.21.1803302001440.9681@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.21.1803302001440.9681@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.110.185]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF0962041D683C4A8E64DCDC563B8F17@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244842312934549?=
X-GMAIL-MSGID: =?utf-8?q?1596664253017803115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Mar 30, 2018, at 13:02, James Simmons <jsimmons@infradead.org> wrote:
>=20
>=20
>> This function simply multiplies by HZ and adds jiffies.
>> This is simple enough to be opencoded, and doing so
>> makes the code easier to read.
>>=20
>> Same for cfs_time_shift_64()
>=20
> Reviewed-by: James Simmons <jsimmons@infradead.org>

Hmm, I thought we were trying to get rid of direct HZ usage in modules,
because of tickless systems, and move to e.g. msecs_to_jiffies() or similar=
?

Cheers, Andreas

>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>> .../lustre/include/linux/libcfs/libcfs_time.h      |    5 ----
>> .../lustre/include/linux/libcfs/linux/linux-time.h |    5 ----
>> .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |   12 +++++----
>> .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    4 ++-
>> .../staging/lustre/lnet/klnds/socklnd/socklnd.c    |    4 ++-
>> .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |   12 +++++----
>> drivers/staging/lustre/lnet/lnet/net_fault.c       |   26 ++++++++++----=
------
>> drivers/staging/lustre/lnet/lnet/router.c          |    2 +-
>> drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |    2 +-
>> drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |    2 +-
>> drivers/staging/lustre/lustre/llite/llite_lib.c    |    4 ++-
>> drivers/staging/lustre/lustre/llite/lproc_llite.c  |   12 +++++----
>> drivers/staging/lustre/lustre/llite/statahead.c    |    2 +-
>> drivers/staging/lustre/lustre/lmv/lmv_obd.c        |    2 +-
>> drivers/staging/lustre/lustre/lov/lov_obd.c        |    2 +-
>> drivers/staging/lustre/lustre/mdc/mdc_request.c    |    2 +-
>> .../lustre/lustre/obdclass/lprocfs_status.c        |   12 +++++----
>> .../staging/lustre/lustre/obdclass/obd_config.c    |    2 +-
>> drivers/staging/lustre/lustre/osc/osc_request.c    |    2 +-
>> drivers/staging/lustre/lustre/ptlrpc/pinger.c      |    6 ++---
>> drivers/staging/lustre/lustre/ptlrpc/service.c     |    2 +-
>> 21 files changed, 56 insertions(+), 66 deletions(-)
>>=20
>> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h b=
/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
>> index 7b41a129f041..0ebbde4ec8e8 100644
>> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
>> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
>> @@ -50,11 +50,6 @@ static inline int cfs_time_aftereq(unsigned long t1, =
unsigned long t2)
>> 	return time_before_eq(t2, t1);
>> }
>>=20
>> -static inline unsigned long cfs_time_shift(int seconds)
>> -{
>> -	return jiffies + seconds * HZ;
>> -}
>> -
>> /*
>>  * return valid time-out based on user supplied one. Currently we only c=
heck
>>  * that time-out is not shorted than allowed.
>> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-tim=
e.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
>> index b3a80531bd71..ff3aae2f1231 100644
>> --- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
>> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
>> @@ -65,11 +65,6 @@ static inline long cfs_duration_sec(long d)
>> 	return d / msecs_to_jiffies(MSEC_PER_SEC);
>> }
>>=20
>> -static inline u64 cfs_time_shift_64(int seconds)
>> -{
>> -	return get_jiffies_64() + (u64)seconds * HZ;
>> -}
>> -
>> static inline int cfs_time_before_64(u64 t1, u64 t2)
>> {
>> 	return (__s64)t2 - (__s64)t1 > 0;
>> diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c b/drive=
rs/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
>> index 7df07f39b849..276bf486f64b 100644
>> --- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
>> +++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
>> @@ -1446,7 +1446,7 @@ static int kiblnd_create_fmr_pool(struct kib_fmr_p=
oolset *fps,
>> 	if (rc)
>> 		goto out_fpo;
>>=20
>> -	fpo->fpo_deadline =3D cfs_time_shift(IBLND_POOL_DEADLINE);
>> +	fpo->fpo_deadline =3D jiffies + IBLND_POOL_DEADLINE * HZ;
>> 	fpo->fpo_owner =3D fps;
>> 	*pp_fpo =3D fpo;
>>=20
>> @@ -1619,7 +1619,7 @@ int kiblnd_fmr_pool_map(struct kib_fmr_poolset *fp=
s, struct kib_tx *tx,
>> 	spin_lock(&fps->fps_lock);
>> 	version =3D fps->fps_version;
>> 	list_for_each_entry(fpo, &fps->fps_pool_list, fpo_list) {
>> -		fpo->fpo_deadline =3D cfs_time_shift(IBLND_POOL_DEADLINE);
>> +		fpo->fpo_deadline =3D jiffies + IBLND_POOL_DEADLINE * HZ;
>> 		fpo->fpo_map_count++;
>>=20
>> 		if (fpo->fpo_is_fmr) {
>> @@ -1743,7 +1743,7 @@ int kiblnd_fmr_pool_map(struct kib_fmr_poolset *fp=
s, struct kib_tx *tx,
>> 		fps->fps_version++;
>> 		list_add_tail(&fpo->fpo_list, &fps->fps_pool_list);
>> 	} else {
>> -		fps->fps_next_retry =3D cfs_time_shift(IBLND_POOL_RETRY);
>> +		fps->fps_next_retry =3D jiffies + IBLND_POOL_RETRY * HZ;
>> 	}
>> 	spin_unlock(&fps->fps_lock);
>>=20
>> @@ -1764,7 +1764,7 @@ static void kiblnd_init_pool(struct kib_poolset *p=
s, struct kib_pool *pool, int
>>=20
>> 	memset(pool, 0, sizeof(*pool));
>> 	INIT_LIST_HEAD(&pool->po_free_list);
>> -	pool->po_deadline =3D cfs_time_shift(IBLND_POOL_DEADLINE);
>> +	pool->po_deadline =3D jiffies + IBLND_POOL_DEADLINE * HZ;
>> 	pool->po_owner    =3D ps;
>> 	pool->po_size     =3D size;
>> }
>> @@ -1899,7 +1899,7 @@ struct list_head *kiblnd_pool_alloc_node(struct ki=
b_poolset *ps)
>> 			continue;
>>=20
>> 		pool->po_allocated++;
>> -		pool->po_deadline =3D cfs_time_shift(IBLND_POOL_DEADLINE);
>> +		pool->po_deadline =3D jiffies + IBLND_POOL_DEADLINE * HZ;
>> 		node =3D pool->po_free_list.next;
>> 		list_del(node);
>>=20
>> @@ -1947,7 +1947,7 @@ struct list_head *kiblnd_pool_alloc_node(struct ki=
b_poolset *ps)
>> 	if (!rc) {
>> 		list_add_tail(&pool->po_list, &ps->ps_pool_list);
>> 	} else {
>> -		ps->ps_next_retry =3D cfs_time_shift(IBLND_POOL_RETRY);
>> +		ps->ps_next_retry =3D jiffies + IBLND_POOL_RETRY * HZ;
>> 		CERROR("Can't allocate new %s pool because out of memory\n",
>> 		       ps->ps_name);
>> 	}
>> diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/dr=
ivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
>> index c1c3277f4c1f..f9761d8f2e3e 100644
>> --- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
>> +++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
>> @@ -3700,13 +3700,13 @@ kiblnd_failover_thread(void *arg)
>> 			LASSERT(dev->ibd_failover);
>> 			dev->ibd_failover =3D 0;
>> 			if (rc >=3D 0) { /* Device is OK or failover succeed */
>> -				dev->ibd_next_failover =3D cfs_time_shift(3);
>> +				dev->ibd_next_failover =3D jiffies + 3 * HZ;
>> 				continue;
>> 			}
>>=20
>> 			/* failed to failover, retry later */
>> 			dev->ibd_next_failover =3D
>> -				cfs_time_shift(min(dev->ibd_failed_failover, 10));
>> +				jiffies + min(dev->ibd_failed_failover, 10) * HZ;
>> 			if (kiblnd_dev_can_failover(dev)) {
>> 				list_add_tail(&dev->ibd_fail_list,
>> 					      &kiblnd_data.kib_failed_devs);
>> diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c b/drive=
rs/staging/lustre/lnet/klnds/socklnd/socklnd.c
>> index 4546618c1c12..16c1ab0b0bd9 100644
>> --- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
>> +++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
>> @@ -1287,7 +1287,7 @@ ksocknal_create_conn(struct lnet_ni *ni, struct ks=
ock_route *route,
>> 	conn->ksnc_tx_last_post =3D jiffies;
>> 	/* Set the deadline for the outgoing HELLO to drain */
>> 	conn->ksnc_tx_bufnob =3D sock->sk->sk_wmem_queued;
>> -	conn->ksnc_tx_deadline =3D cfs_time_shift(*ksocknal_tunables.ksnd_time=
out);
>> +	conn->ksnc_tx_deadline =3D jiffies + *ksocknal_tunables.ksnd_timeout *=
 HZ;
>> 	mb();   /* order with adding to peer's conn list */
>>=20
>> 	list_add(&conn->ksnc_list, &peer->ksnp_conns);
>> @@ -1852,7 +1852,7 @@ ksocknal_query(struct lnet_ni *ni, lnet_nid_t nid,=
 unsigned long *when)
>> 			if (bufnob < conn->ksnc_tx_bufnob) {
>> 				/* something got ACKed */
>> 				conn->ksnc_tx_deadline =3D
>> -					cfs_time_shift(*ksocknal_tunables.ksnd_timeout);
>> +					jiffies + *ksocknal_tunables.ksnd_timeout * HZ;
>> 				peer->ksnp_last_alive =3D now;
>> 				conn->ksnc_tx_bufnob =3D bufnob;
>> 			}
>> diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c b/dr=
ivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
>> index 5b34c7c030ad..1ace54c9b133 100644
>> --- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
>> +++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
>> @@ -221,7 +221,7 @@ ksocknal_transmit(struct ksock_conn *conn, struct ks=
ock_tx *tx)
>> 			 * something got ACKed
>> 			 */
>> 			conn->ksnc_tx_deadline =3D
>> -				cfs_time_shift(*ksocknal_tunables.ksnd_timeout);
>> +				jiffies + *ksocknal_tunables.ksnd_timeout * HZ;
>> 			conn->ksnc_peer->ksnp_last_alive =3D jiffies;
>> 			conn->ksnc_tx_bufnob =3D bufnob;
>> 			mb();
>> @@ -269,7 +269,7 @@ ksocknal_recv_iter(struct ksock_conn *conn)
>>=20
>> 	conn->ksnc_peer->ksnp_last_alive =3D jiffies;
>> 	conn->ksnc_rx_deadline =3D
>> -		cfs_time_shift(*ksocknal_tunables.ksnd_timeout);
>> +		jiffies + *ksocknal_tunables.ksnd_timeout * HZ;
>> 	mb();		       /* order with setting rx_started */
>> 	conn->ksnc_rx_started =3D 1;
>>=20
>> @@ -405,7 +405,7 @@ ksocknal_check_zc_req(struct ksock_tx *tx)
>>=20
>> 	/* ZC_REQ is going to be pinned to the peer */
>> 	tx->tx_deadline =3D
>> -		cfs_time_shift(*ksocknal_tunables.ksnd_timeout);
>> +		jiffies + *ksocknal_tunables.ksnd_timeout * HZ;
>>=20
>> 	LASSERT(!tx->tx_msg.ksm_zc_cookies[0]);
>>=20
>> @@ -677,7 +677,7 @@ ksocknal_queue_tx_locked(struct ksock_tx *tx, struct=
 ksock_conn *conn)
>> 	if (list_empty(&conn->ksnc_tx_queue) && !bufnob) {
>> 		/* First packet starts the timeout */
>> 		conn->ksnc_tx_deadline =3D
>> -			cfs_time_shift(*ksocknal_tunables.ksnd_timeout);
>> +			jiffies + *ksocknal_tunables.ksnd_timeout * HZ;
>> 		if (conn->ksnc_tx_bufnob > 0) /* something got ACKed */
>> 			conn->ksnc_peer->ksnp_last_alive =3D jiffies;
>> 		conn->ksnc_tx_bufnob =3D 0;
>> @@ -858,7 +858,7 @@ ksocknal_launch_packet(struct lnet_ni *ni, struct ks=
ock_tx *tx,
>> 	    ksocknal_find_connecting_route_locked(peer)) {
>> 		/* the message is going to be pinned to the peer */
>> 		tx->tx_deadline =3D
>> -			cfs_time_shift(*ksocknal_tunables.ksnd_timeout);
>> +			jiffies + *ksocknal_tunables.ksnd_timeout * HZ;
>>=20
>> 		/* Queue the message until a connection is established */
>> 		list_add_tail(&tx->tx_list, &peer->ksnp_tx_queue);
>> @@ -2308,7 +2308,7 @@ ksocknal_send_keepalive_locked(struct ksock_peer *=
peer)
>> 	 * retry 10 secs later, so we wouldn't put pressure
>> 	 * on this peer if we failed to send keepalive this time
>> 	 */
>> -	peer->ksnp_send_keepalive =3D cfs_time_shift(10);
>> +	peer->ksnp_send_keepalive =3D jiffies + 10 * HZ;
>>=20
>> 	conn =3D ksocknal_find_conn_locked(peer, NULL, 1);
>> 	if (conn) {
>> diff --git a/drivers/staging/lustre/lnet/lnet/net_fault.c b/drivers/stag=
ing/lustre/lnet/lnet/net_fault.c
>> index 3928e9a74d6f..05d7b754815a 100644
>> --- a/drivers/staging/lustre/lnet/lnet/net_fault.c
>> +++ b/drivers/staging/lustre/lnet/lnet/net_fault.c
>> @@ -169,9 +169,9 @@ lnet_drop_rule_add(struct lnet_fault_attr *attr)
>>=20
>> 	rule->dr_attr =3D *attr;
>> 	if (attr->u.drop.da_interval) {
>> -		rule->dr_time_base =3D cfs_time_shift(attr->u.drop.da_interval);
>> -		rule->dr_drop_time =3D cfs_time_shift(
>> -			prandom_u32_max(attr->u.drop.da_interval));
>> +		rule->dr_time_base =3D jiffies + attr->u.drop.da_interval * HZ;
>> +		rule->dr_drop_time =3D jiffies +
>> +			prandom_u32_max(attr->u.drop.da_interval) * HZ;
>> 	} else {
>> 		rule->dr_drop_at =3D prandom_u32_max(attr->u.drop.da_rate);
>> 	}
>> @@ -279,9 +279,9 @@ lnet_drop_rule_reset(void)
>> 		if (attr->u.drop.da_rate) {
>> 			rule->dr_drop_at =3D prandom_u32_max(attr->u.drop.da_rate);
>> 		} else {
>> -			rule->dr_drop_time =3D cfs_time_shift(
>> -				prandom_u32_max(attr->u.drop.da_interval));
>> -			rule->dr_time_base =3D cfs_time_shift(attr->u.drop.da_interval);
>> +			rule->dr_drop_time =3D jiffies +
>> +				prandom_u32_max(attr->u.drop.da_interval) * HZ;
>> +			rule->dr_time_base =3D jiffies + attr->u.drop.da_interval * HZ;
>> 		}
>> 		spin_unlock(&rule->dr_lock);
>> 	}
>> @@ -513,7 +513,7 @@ delay_rule_match(struct lnet_delay_rule *rule, lnet_=
nid_t src,
>>=20
>> 	list_add_tail(&msg->msg_list, &rule->dl_msg_list);
>> 	msg->msg_delay_send =3D round_timeout(
>> -			cfs_time_shift(attr->u.delay.la_latency));
>> +			jiffies + attr->u.delay.la_latency * HZ);
>> 	if (rule->dl_msg_send =3D=3D -1) {
>> 		rule->dl_msg_send =3D msg->msg_delay_send;
>> 		mod_timer(&rule->dl_timer, rule->dl_msg_send);
>> @@ -767,9 +767,9 @@ lnet_delay_rule_add(struct lnet_fault_attr *attr)
>>=20
>> 	rule->dl_attr =3D *attr;
>> 	if (attr->u.delay.la_interval) {
>> -		rule->dl_time_base =3D cfs_time_shift(attr->u.delay.la_interval);
>> -		rule->dl_delay_time =3D cfs_time_shift(
>> -			prandom_u32_max(attr->u.delay.la_interval));
>> +		rule->dl_time_base =3D jiffies + attr->u.delay.la_interval * HZ;
>> +		rule->dl_delay_time =3D jiffies +=20
>> +			prandom_u32_max(attr->u.delay.la_interval) * HZ;
>> 	} else {
>> 		rule->dl_delay_at =3D prandom_u32_max(attr->u.delay.la_rate);
>> 	}
>> @@ -920,9 +920,9 @@ lnet_delay_rule_reset(void)
>> 			rule->dl_delay_at =3D prandom_u32_max(attr->u.delay.la_rate);
>> 		} else {
>> 			rule->dl_delay_time =3D
>> -				cfs_time_shift(prandom_u32_max(
>> -						       attr->u.delay.la_interval));
>> -			rule->dl_time_base =3D cfs_time_shift(attr->u.delay.la_interval);
>> +				jiffies + prandom_u32_max(
>> +					attr->u.delay.la_interval) * HZ;
>> +			rule->dl_time_base =3D jiffies + attr->u.delay.la_interval * HZ;
>> 		}
>> 		spin_unlock(&rule->dl_lock);
>> 	}
>> diff --git a/drivers/staging/lustre/lnet/lnet/router.c b/drivers/staging=
/lustre/lnet/lnet/router.c
>> index 4595a7ad4336..c72d4f4454ec 100644
>> --- a/drivers/staging/lustre/lnet/lnet/router.c
>> +++ b/drivers/staging/lustre/lnet/lnet/router.c
>> @@ -1026,7 +1026,7 @@ lnet_ping_router_locked(struct lnet_peer *rtr)
>>=20
>> 		if (!rtr->lp_ping_deadline) {
>> 			rtr->lp_ping_deadline =3D
>> -				cfs_time_shift(router_ping_timeout);
>> +				jiffies + router_ping_timeout * HZ;
>> 		}
>>=20
>> 		lnet_net_unlock(rtr->lp_cpt);
>> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers=
/staging/lustre/lustre/ldlm/ldlm_request.c
>> index 6eb42f16040d..647e85b16c02 100644
>> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
>> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
>> @@ -118,7 +118,7 @@ static void ldlm_expired_completion_wait(struct ldlm=
_lock *lock, __u32 conn_cnt)
>> 				 lock->l_last_activity));
>> 		if (cfs_time_after(jiffies, next_dump)) {
>> 			last_dump =3D next_dump;
>> -			next_dump =3D cfs_time_shift(300);
>> +			next_dump =3D jiffies + 300 * HZ;
>> 			ldlm_namespace_dump(D_DLMTRACE,
>> 					    ldlm_lock_to_ns(lock));
>> 			if (last_dump =3D=3D 0)
>> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/driver=
s/staging/lustre/lustre/ldlm/ldlm_resource.c
>> index ccd0c082e39b..6c615b6e9bdc 100644
>> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
>> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
>> @@ -1323,7 +1323,7 @@ void ldlm_namespace_dump(int level, struct ldlm_na=
mespace *ns)
>> 				 ldlm_res_hash_dump,
>> 				 (void *)(unsigned long)level, 0);
>> 	spin_lock(&ns->ns_lock);
>> -	ns->ns_next_dump =3D cfs_time_shift(10);
>> +	ns->ns_next_dump =3D jiffies + 10 * HZ;
>> 	spin_unlock(&ns->ns_lock);
>> }
>>=20
>> diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/s=
taging/lustre/lustre/llite/llite_lib.c
>> index e7500c53fafc..60dbe888e336 100644
>> --- a/drivers/staging/lustre/lustre/llite/llite_lib.c
>> +++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
>> @@ -257,7 +257,7 @@ static int client_common_fill_super(struct super_blo=
ck *sb, char *md, char *dt)
>> 	 * available
>> 	 */
>> 	err =3D obd_statfs(NULL, sbi->ll_md_exp, osfs,
>> -			 cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +			 get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 			 OBD_STATFS_FOR_MDT0);
>> 	if (err)
>> 		goto out_md_fid;
>> @@ -1675,7 +1675,7 @@ int ll_statfs(struct dentry *de, struct kstatfs *s=
fs)
>>=20
>> 	/* Some amount of caching on the client is allowed */
>> 	rc =3D ll_statfs_internal(sb, &osfs,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				0);
>> 	if (rc)
>> 		return rc;
>> diff --git a/drivers/staging/lustre/lustre/llite/lproc_llite.c b/drivers=
/staging/lustre/lustre/llite/lproc_llite.c
>> index 644bea2f9d37..164fe4d6b6b8 100644
>> --- a/drivers/staging/lustre/lustre/llite/lproc_llite.c
>> +++ b/drivers/staging/lustre/lustre/llite/lproc_llite.c
>> @@ -53,7 +53,7 @@ static ssize_t blocksize_show(struct kobject *kobj, st=
ruct attribute *attr,
>> 	int rc;
>>=20
>> 	rc =3D ll_statfs_internal(sbi->ll_sb, &osfs,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				OBD_STATFS_NODELAY);
>> 	if (!rc)
>> 		return sprintf(buf, "%u\n", osfs.os_bsize);
>> @@ -71,7 +71,7 @@ static ssize_t kbytestotal_show(struct kobject *kobj, =
struct attribute *attr,
>> 	int rc;
>>=20
>> 	rc =3D ll_statfs_internal(sbi->ll_sb, &osfs,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				OBD_STATFS_NODELAY);
>> 	if (!rc) {
>> 		__u32 blk_size =3D osfs.os_bsize >> 10;
>> @@ -96,7 +96,7 @@ static ssize_t kbytesfree_show(struct kobject *kobj, s=
truct attribute *attr,
>> 	int rc;
>>=20
>> 	rc =3D ll_statfs_internal(sbi->ll_sb, &osfs,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				OBD_STATFS_NODELAY);
>> 	if (!rc) {
>> 		__u32 blk_size =3D osfs.os_bsize >> 10;
>> @@ -121,7 +121,7 @@ static ssize_t kbytesavail_show(struct kobject *kobj=
, struct attribute *attr,
>> 	int rc;
>>=20
>> 	rc =3D ll_statfs_internal(sbi->ll_sb, &osfs,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				OBD_STATFS_NODELAY);
>> 	if (!rc) {
>> 		__u32 blk_size =3D osfs.os_bsize >> 10;
>> @@ -146,7 +146,7 @@ static ssize_t filestotal_show(struct kobject *kobj,=
 struct attribute *attr,
>> 	int rc;
>>=20
>> 	rc =3D ll_statfs_internal(sbi->ll_sb, &osfs,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				OBD_STATFS_NODELAY);
>> 	if (!rc)
>> 		return sprintf(buf, "%llu\n", osfs.os_files);
>> @@ -164,7 +164,7 @@ static ssize_t filesfree_show(struct kobject *kobj, =
struct attribute *attr,
>> 	int rc;
>>=20
>> 	rc =3D ll_statfs_internal(sbi->ll_sb, &osfs,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				OBD_STATFS_NODELAY);
>> 	if (!rc)
>> 		return sprintf(buf, "%llu\n", osfs.os_ffree);
>> diff --git a/drivers/staging/lustre/lustre/llite/statahead.c b/drivers/s=
taging/lustre/lustre/llite/statahead.c
>> index 6f996acf6aa8..b4a6ee6c83f3 100644
>> --- a/drivers/staging/lustre/lustre/llite/statahead.c
>> +++ b/drivers/staging/lustre/lustre/llite/statahead.c
>> @@ -523,7 +523,7 @@ static void ll_agl_trigger(struct inode *inode, stru=
ct ll_statahead_info *sai)
>> 	 *    affect the performance.
>> 	 */
>> 	if (lli->lli_glimpse_time !=3D 0 &&
>> -	    time_before(cfs_time_shift(-1), lli->lli_glimpse_time)) {
>> +	    time_before(jiffies - 1 * HZ, lli->lli_glimpse_time)) {
>> 		up_write(&lli->lli_glimpse_sem);
>> 		lli->lli_agl_index =3D 0;
>> 		iput(inode);
>> diff --git a/drivers/staging/lustre/lustre/lmv/lmv_obd.c b/drivers/stagi=
ng/lustre/lustre/lmv/lmv_obd.c
>> index e8a9b9902c37..7be931039e3c 100644
>> --- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
>> +++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
>> @@ -876,7 +876,7 @@ static int lmv_iocontrol(unsigned int cmd, struct ob=
d_export *exp,
>> 			return -EFAULT;
>>=20
>> 		rc =3D obd_statfs(NULL, tgt->ltd_exp, &stat_buf,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				0);
>> 		if (rc)
>> 			return rc;
>> diff --git a/drivers/staging/lustre/lustre/lov/lov_obd.c b/drivers/stagi=
ng/lustre/lustre/lov/lov_obd.c
>> index ec70c12e5b40..355e87ecc62d 100644
>> --- a/drivers/staging/lustre/lustre/lov/lov_obd.c
>> +++ b/drivers/staging/lustre/lustre/lov/lov_obd.c
>> @@ -1063,7 +1063,7 @@ static int lov_iocontrol(unsigned int cmd, struct =
obd_export *exp, int len,
>>=20
>> 		/* got statfs data */
>> 		rc =3D obd_statfs(NULL, lov->lov_tgts[index]->ltd_exp, &stat_buf,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				flags);
>> 		if (rc)
>> 			return rc;
>> diff --git a/drivers/staging/lustre/lustre/mdc/mdc_request.c b/drivers/s=
taging/lustre/lustre/mdc/mdc_request.c
>> index 3b1c8e5a3053..266fa90cb03d 100644
>> --- a/drivers/staging/lustre/lustre/mdc/mdc_request.c
>> +++ b/drivers/staging/lustre/lustre/mdc/mdc_request.c
>> @@ -2104,7 +2104,7 @@ static int mdc_iocontrol(unsigned int cmd, struct =
obd_export *exp, int len,
>> 		}
>>=20
>> 		rc =3D mdc_statfs(NULL, obd->obd_self_export, &stat_buf,
>> -				cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +				get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 				0);
>> 		if (rc !=3D 0)
>> 			goto out;
>> diff --git a/drivers/staging/lustre/lustre/obdclass/lprocfs_status.c b/d=
rivers/staging/lustre/lustre/obdclass/lprocfs_status.c
>> index 2ed350527398..eb6396add78d 100644
>> --- a/drivers/staging/lustre/lustre/obdclass/lprocfs_status.c
>> +++ b/drivers/staging/lustre/lustre/obdclass/lprocfs_status.c
>> @@ -407,7 +407,7 @@ static ssize_t blocksize_show(struct kobject *kobj, =
struct attribute *attr,
>> 					      obd_kobj);
>> 	struct obd_statfs  osfs;
>> 	int rc =3D obd_statfs(NULL, obd->obd_self_export, &osfs,
>> -			    cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +			    get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 			    OBD_STATFS_NODELAY);
>> 	if (!rc)
>> 		return sprintf(buf, "%u\n", osfs.os_bsize);
>> @@ -423,7 +423,7 @@ static ssize_t kbytestotal_show(struct kobject *kobj=
, struct attribute *attr,
>> 					      obd_kobj);
>> 	struct obd_statfs  osfs;
>> 	int rc =3D obd_statfs(NULL, obd->obd_self_export, &osfs,
>> -			    cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +			    get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 			    OBD_STATFS_NODELAY);
>> 	if (!rc) {
>> 		__u32 blk_size =3D osfs.os_bsize >> 10;
>> @@ -446,7 +446,7 @@ static ssize_t kbytesfree_show(struct kobject *kobj,=
 struct attribute *attr,
>> 					      obd_kobj);
>> 	struct obd_statfs  osfs;
>> 	int rc =3D obd_statfs(NULL, obd->obd_self_export, &osfs,
>> -			    cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +			    get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 			    OBD_STATFS_NODELAY);
>> 	if (!rc) {
>> 		__u32 blk_size =3D osfs.os_bsize >> 10;
>> @@ -469,7 +469,7 @@ static ssize_t kbytesavail_show(struct kobject *kobj=
, struct attribute *attr,
>> 					      obd_kobj);
>> 	struct obd_statfs  osfs;
>> 	int rc =3D obd_statfs(NULL, obd->obd_self_export, &osfs,
>> -			    cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +			    get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 			    OBD_STATFS_NODELAY);
>> 	if (!rc) {
>> 		__u32 blk_size =3D osfs.os_bsize >> 10;
>> @@ -492,7 +492,7 @@ static ssize_t filestotal_show(struct kobject *kobj,=
 struct attribute *attr,
>> 					      obd_kobj);
>> 	struct obd_statfs  osfs;
>> 	int rc =3D obd_statfs(NULL, obd->obd_self_export, &osfs,
>> -			    cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +			    get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 			    OBD_STATFS_NODELAY);
>> 	if (!rc)
>> 		return sprintf(buf, "%llu\n", osfs.os_files);
>> @@ -508,7 +508,7 @@ static ssize_t filesfree_show(struct kobject *kobj, =
struct attribute *attr,
>> 					      obd_kobj);
>> 	struct obd_statfs  osfs;
>> 	int rc =3D obd_statfs(NULL, obd->obd_self_export, &osfs,
>> -			    cfs_time_shift_64(-OBD_STATFS_CACHE_SECONDS),
>> +			    get_jiffies_64() - OBD_STATFS_CACHE_SECONDS * HZ,
>> 			    OBD_STATFS_NODELAY);
>> 	if (!rc)
>> 		return sprintf(buf, "%llu\n", osfs.os_ffree);
>> diff --git a/drivers/staging/lustre/lustre/obdclass/obd_config.c b/drive=
rs/staging/lustre/lustre/obdclass/obd_config.c
>> index 277576b586db..eab03766236f 100644
>> --- a/drivers/staging/lustre/lustre/obdclass/obd_config.c
>> +++ b/drivers/staging/lustre/lustre/obdclass/obd_config.c
>> @@ -269,7 +269,7 @@ static int class_attach(struct lustre_cfg *lcfg)
>> 	/* obd->obd_osfs_age must be set to a value in the distant
>> 	 * past to guarantee a fresh statfs is fetched on mount.
>> 	 */
>> -	obd->obd_osfs_age =3D cfs_time_shift_64(-1000);
>> +	obd->obd_osfs_age =3D get_jiffies_64() - 1000 * HZ;
>>=20
>> 	/* XXX belongs in setup not attach  */
>> 	init_rwsem(&obd->obd_observer_link_sem);
>> diff --git a/drivers/staging/lustre/lustre/osc/osc_request.c b/drivers/s=
taging/lustre/lustre/osc/osc_request.c
>> index 9966fc7af789..04d801f11ace 100644
>> --- a/drivers/staging/lustre/lustre/osc/osc_request.c
>> +++ b/drivers/staging/lustre/lustre/osc/osc_request.c
>> @@ -617,7 +617,7 @@ static void osc_announce_cached(struct client_obd *c=
li, struct obdo *oa,
>> void osc_update_next_shrink(struct client_obd *cli)
>> {
>> 	cli->cl_next_shrink_grant =3D
>> -		cfs_time_shift(cli->cl_grant_shrink_interval);
>> +		jiffies + cli->cl_grant_shrink_interval * HZ;
>> 	CDEBUG(D_CACHE, "next time %ld to shrink grant\n",
>> 	       cli->cl_next_shrink_grant);
>> }
>> diff --git a/drivers/staging/lustre/lustre/ptlrpc/pinger.c b/drivers/sta=
ging/lustre/lustre/ptlrpc/pinger.c
>> index e836591c5936..7057b4447035 100644
>> --- a/drivers/staging/lustre/lustre/ptlrpc/pinger.c
>> +++ b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
>> @@ -108,7 +108,7 @@ static void ptlrpc_update_next_ping(struct obd_impor=
t *imp, int soon)
>> 				  at_get(&imp->imp_at.iat_net_latency));
>> 		time =3D min(time, dtime);
>> 	}
>> -	imp->imp_next_ping =3D cfs_time_shift(time);
>> +	imp->imp_next_ping =3D jiffies + time * HZ;
>> }
>>=20
>> static inline int imp_is_deactive(struct obd_import *imp)
>> @@ -120,9 +120,9 @@ static inline int imp_is_deactive(struct obd_import =
*imp)
>> static inline int ptlrpc_next_reconnect(struct obd_import *imp)
>> {
>> 	if (imp->imp_server_timeout)
>> -		return cfs_time_shift(obd_timeout / 2);
>> +		return jiffies + obd_timeout / 2 * HZ;
>> 	else
>> -		return cfs_time_shift(obd_timeout);
>> +		return jiffies + obd_timeout * HZ;
>> }
>>=20
>> static long pinger_check_timeout(unsigned long time)
>> diff --git a/drivers/staging/lustre/lustre/ptlrpc/service.c b/drivers/st=
aging/lustre/lustre/ptlrpc/service.c
>> index e71046db28e5..4265e8d00ca5 100644
>> --- a/drivers/staging/lustre/lustre/ptlrpc/service.c
>> +++ b/drivers/staging/lustre/lustre/ptlrpc/service.c
>> @@ -922,7 +922,7 @@ static void ptlrpc_at_set_timer(struct ptlrpc_servic=
e_part *svcpt)
>> 	if (next <=3D 0) {
>> 		ptlrpc_at_timer(&svcpt->scp_at_timer);
>> 	} else {
>> -		mod_timer(&svcpt->scp_at_timer, cfs_time_shift(next));
>> +		mod_timer(&svcpt->scp_at_timer, jiffies + next * HZ);
>> 		CDEBUG(D_INFO, "armed %s at %+ds\n",
>> 		       svcpt->scp_service->srv_name, next);
>> 	}
>>=20
>>=20
>>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
