Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98CAC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FCE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlrE7J6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FCE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeIMUam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:30:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45757 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeIMUal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:30:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so4915474eda.12;
        Thu, 13 Sep 2018 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RzDSx5WdgljUaDpJo2vjM2t2FXnKpDUWJPGAZlhZbo=;
        b=TlrE7J6o0Ie1IizjCb7k3vhGv9cW/TZQr/LHjuM1nwTX8sxdNCdCuIzDmnAudEvJfl
         l1wcxAwX55TSrNEUsEw5/QCFii4sTWC1pO1LPUE6/jIupfT2Z85en3T1ZBS6PhS0l+Rq
         PowEFbm2LsG9aG7CP64321HLs6yBi76AUXZDoJpahlPFyupyOLkWKF8jNHBr4SwXNzzP
         wVYzvrqosR2155d5Z+3PlN9H/Egm7H6WyIBu6JHUGH1HW9YHISaYmN7cs/5FnEY8SN3e
         vTuXMrESr9hEKw92qOHh/s4Sv7HC+ZLuo9Fl+BYoAr1cyE5EgyPMeelAUs+s1KHHb9Wi
         1qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RzDSx5WdgljUaDpJo2vjM2t2FXnKpDUWJPGAZlhZbo=;
        b=Q/3PFAE+MlfU3LFv4L+keJkPk1iQf+bal1Gu2ui/3RXFSMb4Sn4eBfmyVUScS/xc0Z
         n1Lf2SY+f/urRITVcjFsyPmNyG8dtTMR7cxYoNmAvYZWrEcU1fXJcTtDr1DLcbCuNBq1
         roqDVMTS9YLO+5YjPW07VmgILXaQE96KtHg+S7VK+m6X0ofNvW4kvJ/tjH4Ccfrt232t
         c5bv7y0g0sMunbmOZYKP9vv7XjriVoUq4Vd9gSENdQ3DJouNHKAAVPClzGl7i7bCe9Du
         LpGCRVD/+qqZ0klGgL6SyTxs+jlyXLvzuOz+qwDDr+FHmSakS/YEoqBYIOiUKVm656Du
         ntww==
X-Gm-Message-State: APzg51CA4pieCIqE299B8p5c1or4AraUxoaw8aTrDFepyjvzcVvZ2hac
        5YO8F9pvapEqfwTrBD8tGcQA2cZF0vJKTCCGvFM=
X-Google-Smtp-Source: ANB0VdbPAeNh3BtBThcMNzYUVAtXSmb28ogBUQAEQnRGdcicd0Bq7m6RKIobpI9fmZyS8sayA7lZOzkyA13FpJ3bJE8=
X-Received: by 2002:a50:8c98:: with SMTP id q24-v6mr12336397edq.2.1536852040905;
 Thu, 13 Sep 2018 08:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180913053545.18585-1-jasowang@redhat.com>
In-Reply-To: <20180913053545.18585-1-jasowang@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 13 Sep 2018 11:20:06 -0400
Message-ID: <CAF=yD-LSgCEnL_kTH44A8-FH3nut3y=bonf4Bgf75=jd=D64hw@mail.gmail.com>
Subject: Re: [PATCH net-next V2] virtio_net: ethtool tx napi configuration
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Miller <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 1:40 AM Jason Wang <jasowang@redhat.com> wrote:
>
> Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
> Interrupt moderation is currently not supported, so these accept and
> display the default settings of 0 usec and 1 frame.
>
> Toggle tx napi through a bit in tx-frames. So as to not interfere
> with possible future interrupt moderation, value 1 means tx napi while
> value 0 means not.
>
> To properly synchronize with the data path, tx napi is disabled and
> tx lock is held when changing the value of napi weight. And two more
> places that can access tx napi weight:
>
> - speculative tx polling in rx napi, we can leave it as is since it
>   not a must for correctness.
> - skb_xmit_done(), one more check of napi weight is added before
>   trying to enable tx to avoid tx to be disabled forever if napi is
>   disabled after skb_xmit_done() but before the napi
>
> Link: https://patchwork.ozlabs.org/patch/948149/
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - try to synchronize with datapath to allow changing mode when
>   interface is up.
> - use tx-frames 0 as to disable tx napi while tx-frames 1 to enable tx napi
> ---
>  drivers/net/virtio_net.c | 64 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 765920905226..6e70864f5899 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -66,6 +66,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
>
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>
> +static const u32 ethtool_coalesce_napi_mask = (1UL << 10);
> +

This is no longer needed

>  static const unsigned long guest_offloads[] = {
>         VIRTIO_NET_F_GUEST_TSO4,
>         VIRTIO_NET_F_GUEST_TSO6,
> @@ -1444,7 +1446,10 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>
>         virtqueue_napi_complete(napi, sq->vq, 0);
>
> -       if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +       /* Check napi.weight to avoid tx stall since it could be set
> +        * to zero by ethtool after skb_xmit_done().
> +        */
> +       if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS || !sq->napi.weight)
>                 netif_tx_wake_queue(txq);

I see. This assumes that the napi handler will always be called on
conversion from napi to no-napi mode.

That is safe to assume because if it isn't called (and will not call
netif_tx_wake_queue) that implies that napi was not scheduled, and
thus the tx interrupt was not suppressed and thus there was no tx
completion work to be scheduled?

>
>         return 0;
> @@ -2181,6 +2186,61 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
>         return 0;
>  }
>
> +static int virtnet_set_coalesce(struct net_device *dev,
> +                               struct ethtool_coalesce *ec)
> +{
> +       struct ethtool_coalesce ec_default = {
> +               .cmd = ETHTOOL_SCOALESCE,
> +               .rx_max_coalesced_frames = 1,
> +       };
> +       struct virtnet_info *vi = netdev_priv(dev);
> +       int i, napi_weight;
> +
> +       if (ec->tx_max_coalesced_frames > 1)
> +               return -EINVAL;
> +
> +       ec_default.tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
> +       napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> +
> +       /* disallow changes to fields not explicitly tested above */
> +       if (memcmp(ec, &ec_default, sizeof(ec_default)))
> +               return -EINVAL;
> +
> +       if (napi_weight ^ vi->sq[0].napi.weight) {
> +               for (i = 0; i < vi->max_queue_pairs; i++) {
> +                       struct netdev_queue *txq =
> +                              netdev_get_tx_queue(vi->dev, i);
> +
> +                       virtnet_napi_tx_disable(&vi->sq[i].napi);
> +                       __netif_tx_lock_bh(txq);
> +                       vi->sq[i].napi.weight = napi_weight;
> +                       __netif_tx_unlock_bh(txq);
> +                       virtnet_napi_tx_enable(vi, vi->sq[i].vq,
> +                                              &vi->sq[i].napi);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int virtnet_get_coalesce(struct net_device *dev,
> +                               struct ethtool_coalesce *ec)
> +{
> +       struct ethtool_coalesce ec_default = {
> +               .cmd = ETHTOOL_GCOALESCE,
> +               .rx_max_coalesced_frames = 1,
> +               .tx_max_coalesced_frames = 0,

no need to explicitly initialize to 0 (unless you did this for
documentation purposes, which is fine).

> +       };
> +       struct virtnet_info *vi = netdev_priv(dev);
> +
> +       memcpy(ec, &ec_default, sizeof(ec_default));
> +
> +       if (vi->sq[0].napi.weight)
> +               ec->tx_max_coalesced_frames = 1;
> +
> +       return 0;
> +}
> +
>  static void virtnet_init_settings(struct net_device *dev)
>  {
>         struct virtnet_info *vi = netdev_priv(dev);
> @@ -2219,6 +2279,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>         .get_ts_info = ethtool_op_get_ts_info,
>         .get_link_ksettings = virtnet_get_link_ksettings,
>         .set_link_ksettings = virtnet_set_link_ksettings,
> +       .set_coalesce = virtnet_set_coalesce,
> +       .get_coalesce = virtnet_get_coalesce,
>  };
>
>  static void virtnet_freeze_down(struct virtio_device *vdev)
> --
> 2.17.1
>
