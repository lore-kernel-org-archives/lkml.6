Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4+PAZkEEdkLfv1GbXAdR2p59DmNyP67v6K8z7reVrMlJiTfgo+3BS4OdhEGcMq2ePPiTugL
ARC-Seal: i=1; a=rsa-sha256; t=1522436548; cv=none;
        d=google.com; s=arc-20160816;
        b=bibgqp/6I5p/r9PGnEAasr1Kg4IQ96dKou6oiUTVQgLpC/he4wHeePg0QJkq+F24wH
         97SYd31Hih1nI+awbC3fbRuZs3AIwgHo1HsxwRbXYiGxR36MtgtD58EFkIhm7ei9UtB+
         GLzSgFFn7eEqce0en4D4UKx9n2CePSE6K57j8ZUYuTIoW21eLfl6QH1HPkKJTNnC96jN
         cB4fn2j5vlyeWRvNPWcll/Fqy5nxXIi53UB84eWgYJOysHsgL02/77JKDineixa+qojZ
         6cuvpncrafqZoenqDSjFCrgMiASKcNH54LsYad1IeNkLU0+f7aa9zB3i46fORxmCnsiT
         UEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=3wSmQT31W9971eaUCj5DZZrcH/bT1TSw060SxbRHtZI=;
        b=m2l3kP8hhlhRxnCExUjfE0xFa3D+UQLN/nMED3a4Ly82hJvxq+3vqZir9Njs7UVqdu
         eLVQpeotCkoPc+RhxI/4441j7PzXgE6OlcKU+1CmAhKs46zs0BGaKciV/JhdDBM5gNmJ
         mPqaVZXgbslMexmHj+nAj/P6t6EB1Pve3Bv0o527yHj7p4ixsR/G0zSlJe8GGJBqJZ0U
         XhfdKZ5+ia+Gmr/67oIbBezhvrLTtzG0Qmx2uJCB6C8GS938RdcmkSHg0ffBvfgWdjh5
         vPcoBoNTGKJrFRI/eM+0Bwe73jtbpeqNowFFXSNj2cB0JS28HL2mpEaar/kX6aA3vcMW
         tvfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=BiULij7s;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=BiULij7s;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 20:02:24 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 14/17] staging: lustre: discard cfs_duration_sec()
In-Reply-To: <152229760877.27689.15086130563636138485.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803302002160.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760877.27689.15086130563636138485.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_200224_337517_70779270 
X-CRM114-Status: GOOD (  18.42  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244865449305529?=
X-GMAIL-MSGID: =?utf-8?q?1596390426061225082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> cfs_duration_sec() simply divides by HZ.
> It is mostly used to report durations in debug messages.
> Remove and just use X/HZ.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  .../lustre/include/linux/libcfs/linux/linux-time.h |    5 -----
>  .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |    2 +-
>  .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    5 ++---
>  .../staging/lustre/lnet/klnds/socklnd/socklnd.c    |    4 ++--
>  .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |    4 ++--
>  drivers/staging/lustre/lnet/libcfs/debug.c         |    2 +-
>  drivers/staging/lustre/lnet/lnet/router.c          |    2 +-
>  drivers/staging/lustre/lnet/lnet/router_proc.c     |    6 +++---
>  drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |    2 +-
>  9 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> index ecb2126a9e6f..9a353c6cb85a 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> @@ -60,11 +60,6 @@
>   * Generic kernel stuff
>   */
>  
> -static inline long cfs_duration_sec(long d)
> -{
> -	return d / msecs_to_jiffies(MSEC_PER_SEC);
> -}
> -
>  static inline int cfs_time_before_64(u64 t1, u64 t2)
>  {
>  	return (__s64)t2 - (__s64)t1 > 0;
> diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
> index d0ce37d72571..959e119384df 100644
> --- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
> +++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
> @@ -1068,7 +1068,7 @@ static void kiblnd_query(struct lnet_ni *ni, lnet_nid_t nid,
>  
>  	CDEBUG(D_NET, "Peer %s %p, alive %ld secs ago\n",
>  	       libcfs_nid2str(nid), peer,
> -	       last_alive ? cfs_duration_sec(now - last_alive) : -1);
> +	       last_alive ? (now - last_alive) / HZ : -1);
>  }
>  
>  static void kiblnd_free_pages(struct kib_pages *p)
> diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> index 563ff5c972bf..b4a182d87ae7 100644
> --- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> +++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> @@ -3144,7 +3144,7 @@ kiblnd_check_txs_locked(struct kib_conn *conn, struct list_head *txs)
>  		if (time_after_eq(jiffies, tx->tx_deadline)) {
>  			CERROR("Timed out tx: %s, %lu seconds\n",
>  			       kiblnd_queue2str(conn, txs),
> -			       cfs_duration_sec(jiffies - tx->tx_deadline));
> +			       (jiffies - tx->tx_deadline) / HZ);
>  			return 1;
>  		}
>  	}
> @@ -3206,8 +3206,7 @@ kiblnd_check_conns(int idx)
>  			if (timedout) {
>  				CERROR("Timed out RDMA with %s (%lu): c: %u, oc: %u, rc: %u\n",
>  				       libcfs_nid2str(peer->ibp_nid),
> -				       cfs_duration_sec(jiffies -
> -							peer->ibp_last_alive),
> +				       (jiffies - peer->ibp_last_alive) / HZ,
>  				       conn->ibc_credits,
>  				       conn->ibc_outstanding_credits,
>  				       conn->ibc_reserved_credits);
> diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
> index 16c1ab0b0bd9..79b98cdd0f9d 100644
> --- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
> +++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
> @@ -1682,7 +1682,7 @@ ksocknal_destroy_conn(struct ksock_conn *conn)
>  		       libcfs_id2str(conn->ksnc_peer->ksnp_id), conn->ksnc_type,
>  		       &conn->ksnc_ipaddr, conn->ksnc_port,
>  		       iov_iter_count(&conn->ksnc_rx_to), conn->ksnc_rx_nob_left,
> -		       cfs_duration_sec(jiffies - last_rcv));
> +		       (jiffies - last_rcv) / HZ);
>  		lnet_finalize(conn->ksnc_peer->ksnp_ni,
>  			      conn->ksnc_cookie, -EIO);
>  		break;
> @@ -1870,7 +1870,7 @@ ksocknal_query(struct lnet_ni *ni, lnet_nid_t nid, unsigned long *when)
>  
>  	CDEBUG(D_NET, "Peer %s %p, alive %ld secs ago, connect %d\n",
>  	       libcfs_nid2str(nid), peer,
> -	       last_alive ? cfs_duration_sec(now - last_alive) : -1,
> +	       last_alive ? (now - last_alive) / HZ : -1,
>  	       connect);
>  
>  	if (!connect)
> diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
> index 8ead1e02e854..14450fd5957a 100644
> --- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
> +++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd_cb.c
> @@ -751,7 +751,7 @@ ksocknal_find_connectable_route_locked(struct ksock_peer *peer)
>  			       &route->ksnr_ipaddr,
>  			       route->ksnr_connected,
>  			       route->ksnr_retry_interval,
> -			       cfs_duration_sec(route->ksnr_timeout - now));
> +			       (route->ksnr_timeout - now) / HZ);
>  			continue;
>  		}
>  
> @@ -2439,7 +2439,7 @@ ksocknal_check_peer_timeouts(int idx)
>  
>  		CERROR("Total %d stale ZC_REQs for peer %s detected; the oldest(%p) timed out %ld secs ago, resid: %d, wmem: %d\n",
>  		       n, libcfs_nid2str(peer->ksnp_id.nid), tx_stale,
> -		       cfs_duration_sec(jiffies - deadline),
> +		       (jiffies - deadline) / HZ,
>  		       resid, conn->ksnc_sock->sk->sk_wmem_queued);
>  
>  		ksocknal_close_conn_and_siblings(conn, -ETIMEDOUT);
> diff --git a/drivers/staging/lustre/lnet/libcfs/debug.c b/drivers/staging/lustre/lnet/libcfs/debug.c
> index 1371224a8cb9..5862f0730dd0 100644
> --- a/drivers/staging/lustre/lnet/libcfs/debug.c
> +++ b/drivers/staging/lustre/lnet/libcfs/debug.c
> @@ -126,7 +126,7 @@ static int param_get_delay(char *buffer, const struct kernel_param *kp)
>  {
>  	unsigned int d = *(unsigned int *)kp->arg;
>  
> -	return sprintf(buffer, "%u", (unsigned int)cfs_duration_sec(d * 100));
> +	return sprintf(buffer, "%u", (unsigned int)(d * 100) / HZ);
>  }
>  
>  unsigned int libcfs_console_max_delay;
> diff --git a/drivers/staging/lustre/lnet/lnet/router.c b/drivers/staging/lustre/lnet/lnet/router.c
> index 8baf35d56ca7..6267d5e4bbd6 100644
> --- a/drivers/staging/lustre/lnet/lnet/router.c
> +++ b/drivers/staging/lustre/lnet/lnet/router.c
> @@ -1752,7 +1752,7 @@ lnet_notify(struct lnet_ni *ni, lnet_nid_t nid, int alive, unsigned long when)
>  		CWARN("Ignoring prediction from %s of %s %s %ld seconds in the future\n",
>  		      !ni ? "userspace" : libcfs_nid2str(ni->ni_nid),
>  		      libcfs_nid2str(nid), alive ? "up" : "down",
> -		      cfs_duration_sec(when - now));
> +		      (when - now) / HZ);
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/staging/lustre/lnet/lnet/router_proc.c b/drivers/staging/lustre/lnet/lnet/router_proc.c
> index e4172311be68..015dccbc4a58 100644
> --- a/drivers/staging/lustre/lnet/lnet/router_proc.c
> +++ b/drivers/staging/lustre/lnet/lnet/router_proc.c
> @@ -331,7 +331,7 @@ static int proc_lnet_routers(struct ctl_table *table, int write,
>  			int alive_cnt = peer->lp_alive_count;
>  			int alive = peer->lp_alive;
>  			int pingsent = !peer->lp_ping_notsent;
> -			int last_ping = cfs_duration_sec(now - peer->lp_ping_timestamp);
> +			int last_ping = (now - peer->lp_ping_timestamp) / HZ;
>  			int down_ni = 0;
>  			struct lnet_route *rtr;
>  
> @@ -363,7 +363,7 @@ static int proc_lnet_routers(struct ctl_table *table, int write,
>  					      nrefs, nrtrrefs, alive_cnt,
>  					      alive ? "up" : "down", last_ping,
>  					      pingsent,
> -					      cfs_duration_sec(deadline - now),
> +					      (deadline - now) / HZ,
>  					      down_ni, libcfs_nid2str(nid));
>  			LASSERT(tmpstr + tmpsiz - s > 0);
>  		}
> @@ -512,7 +512,7 @@ static int proc_lnet_peers(struct ctl_table *table, int write,
>  				long delta;
>  
>  				delta = now - peer->lp_last_alive;
> -				lastalive = cfs_duration_sec(delta);
> +				lastalive = (delta) / HZ;
>  
>  				/* No need to mess up peers contents with
>  				 * arbitrarily long integers - it suffices to
> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
> index 187095022fb1..f573de9cf45d 100644
> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
> @@ -1181,7 +1181,7 @@ static enum ldlm_policy_res ldlm_cancel_lrur_policy(struct ldlm_namespace *ns,
>  
>  	slv = ldlm_pool_get_slv(pl);
>  	lvf = ldlm_pool_get_lvf(pl);
> -	la = cfs_duration_sec(cur - lock->l_last_used);
> +	la = (cur - lock->l_last_used) / HZ;
>  	lv = lvf * la * unused;
>  
>  	/* Inform pool about current CLV to see it via debugfs. */
> 
> 
> 
