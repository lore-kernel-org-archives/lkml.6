Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524650643-2-9948860697506949024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524650643; b=o6A7WfnMXJ5QcEcqlTcAGFA6Gc1lDpATT688DUXp3Drchz2Rjp
    o+s++StijHkjAscgim30Hl44psIQR9NefBPabdc89lS5TnWZT0CbmAwd4ofvbveL
    vzkH7qK4kxYfSOGCMtF15ZoRS+fVxJ/WI5iOBxK19JqtvUsGIbjJipsfAlWVKlqU
    d9j0KVYRtOsRyCrLqLRfokcamDugG9kT4F7WEFUvD1fP3flvnxWitNeSXxwG0iOz
    N5zQU08FnirQ2kRdfuLHPNCstHz9nvQYq3XpCrRTW2CiV+LOaBrYC9crLb35EcBB
    xefo1gemFQg8rULno5UgEo3EG0kXGlTx6whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524650643; bh=DLes2
    cpJfucGrS0JezmTzWRMgNkHqk1AgNUYp/UWE5s=; b=nV+r17njunVAns6Ygbtgt
    mL54NCCGYiRQVeuhgSR6h6pr5MhDQt6DPVj8XIaDTh8xRY5w5P/TT1gia0iJB+cf
    bptCXhyrZe6Xi2vf3kRrbwWcplQv6/gxhnBpShOv34IeOUO3aJtoSUl060RGAjz9
    zRupN5Ld7jmsj959FHWIwT3FnJgtWD6oQdu5rq8svNyqNQBBsjG7NcZmBCN26iIb
    YBS03BuWdcFgD4P/D/mwv7wV2yHyugcqznaTIRtFA4eVfGTR7wVdVKsULY6yQBJh
    +FCZMnjjq5XZ2YOjr+C7g8t2gnJJtcLHmh1do2gWsRvT9VjiS5QynXNcFqJCr85y
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l5LV8oOW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l5LV8oOW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHmAGjDOW3TEgkvkuH6uWzWe8PYBi4mDTt8Z6TuDmv+dYyldkCAmB1UgMNGYfThbt59h1OvcbYTNYWZxCqCauBif5hBPYVd82p/ps0JTrLFbIlPwxPYt
    CqPy3g1sDUMnWIwxMwbGu4Y/oDYcsnAhi+4HFLoqlGxt6x3gL0VwEu6JWhgnWCedDS+DawZN1qZe9nAE5ESOCYd3Dlw5JrFNL9pmFNCEgkb7eiLSXW6bGtnL
    NWv9iC1V4XRcrb/Cd1Fb7Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=3JM7wWF9qpnLQrVuEQkA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 25 Apr 2018 13:03:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware
 timestamping
Message-ID: <20180425100345.b5oxgdjyud7t6kzc@mwanda>
References: <20180425091749.46841-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180425091749.46841-1-yangbo.lu@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804250093
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 05:17:49PM +0800, Yangbo Lu wrote:
> @@ -275,6 +278,16 @@ static void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
>  
>  	prefetch(skb->data);
>  
> +	/* Get the timestamp value */
> +	if (priv->ts_rx_en) {
> +		struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> +		u64 *ns = dpaa2_get_ts(vaddr, false);
> +
> +		*ns = DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS * le64_to_cpup(ns);

This will cause Sparse endianess warnings.

I don't totally understand why we're writing to *ns.  Do we access *ns
again or not?  Either way, this doesn't seem right.  In other words, why
don't we do this:

		__le64 *period = dpaa2_get_ts(vaddr, false);
		u64 ns;

		ns = DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS * le64_to_cpup(period);
		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
		shhwtstamps->hwtstamp = ns_to_ktime(ns);

Then if we need to save a munged *ns then we can do this at the end:

		/* we need this because blah blah blah */
		*period = (__le64)ns;


> +		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
> +		shhwtstamps->hwtstamp = ns_to_ktime(*ns);
> +	}
> +
>  	/* Check if we need to validate the L4 csum */
>  	if (likely(dpaa2_fd_get_frc(fd) & DPAA2_FD_FRC_FASV)) {
>  		status = le32_to_cpu(fas->status);

[ snip ]

> @@ -520,6 +561,19 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
>  		return;
>  	}
>  
> +	/* Get the timestamp value */
> +	if (priv->ts_tx_en && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
> +		struct skb_shared_hwtstamps shhwtstamps;
> +		u64 *ns;
> +
> +		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> +
> +		ns = dpaa2_get_ts(skbh, true);
> +		*ns = DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS * le64_to_cpup(ns);
> +		shhwtstamps.hwtstamp = ns_to_ktime(*ns);
> +		skb_tstamp_tx(skb, &shhwtstamps);

Sparse issues here also.

> +	}
> +
>  	/* Free SGT buffer allocated on tx */
>  	if (fd_format != dpaa2_fd_single)
>  		skb_free_frag(skbh);
> @@ -552,6 +606,10 @@ static netdev_tx_t dpaa2_eth_tx(struct sk_buff *skb, struct net_device *net_dev)
>  			goto err_alloc_headroom;
>  		}
>  		percpu_extras->tx_reallocs++;
> +
> +		if (skb->sk)
> +			skb_set_owner_w(ns, skb->sk);

Is this really related?  (I have not looked at this code).

> +
>  		dev_kfree_skb(skb);
>  		skb = ns;
>  	}

[ snip ]

> @@ -319,6 +351,9 @@ struct dpaa2_eth_priv {
>  	u16 bpid;
>  	struct iommu_domain *iommu_domain;
>  
> +	bool ts_tx_en; /* Tx timestamping enabled */
> +	bool ts_rx_en; /* Rx timestamping enabled */

These variable names are not great.  I wouldn't have understood "ts_"
without the comment.  "tx_" is good.  "en" is confusing until you read
the comment.  But really it should just be left out because "enable" is
assumed, generally.  Last week I asked someone to rewrite a patch that
had a _disable variable because negative variables lead to double
negatives which screw with my tiny head.

	if (blah_disable != 0) {

OH MY BLASTED WORD MY BRIAN ESPLODED!!!1!

So let's just name these "tx_timestamps" or something.


> +
>  	u16 tx_qdid;
>  	u16 rx_buf_align;
>  	struct fsl_mc_io *mc_io;

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
