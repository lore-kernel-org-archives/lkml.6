Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F3FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DD424025
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tho7gWiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DD424025
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeGBNKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:10:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42227 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeGBNJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:09:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so15514532wrs.9;
        Mon, 02 Jul 2018 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WGOpp8i213pdENeSvYcvSZFDbxULJv0+1K5ikmR/W6w=;
        b=Tho7gWiW3cfweMlvDYylffCmb7ezr7CbUrWd/DTbh5zieD9vOnIHndItK8fYlMClMx
         2AXtImCoER2oQkcr1nMZC4XMKHGwTX6R4j2sTcjzUuCSDFM4l6RfcxHwmhiSBl+ItpwF
         Ym8Qsfjoehba6uKnWnpRYagPZBQDJ8rLF/8pfZEJ5XtF+m3pheA8iPzRDREpLAztUXpi
         M4wF68jSM6Wa9nMKPh9gzrx2QfOozpGmeJ6FL4uaGgFrjoruNY9hIHuuNjFY4jyh8nN9
         ASS+lRD07ohTw4ZNCYVn8gOV3oYQ7VAyiS4tljOpKQ3vmVAi2I+uEb1l/bWCY/CaHhrL
         klag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGOpp8i213pdENeSvYcvSZFDbxULJv0+1K5ikmR/W6w=;
        b=MJfHDrXTVDgcMlwVvf68r2KvDNCVLUI0w3Xt6sY2Z9twm19kpPAlFC/a2UV8CgHsGB
         KtZvknJ+DJyBSiQ56RQLbPJovJ6cA9gFGuDJsaAfhcPkFtFCwdbPhuvUGzPB5efMf3MT
         YaYC+nkTQIR4L+PqSX6mXOxq5JV2QceGJXdnHBdkZipxyLEtFIx0bQHcr3uklj4+FFP/
         tzzKDoV+13u/Ncw0R/hyjo4X4p3v33DUjEz7q1arVC/I11/G9B9mKd8u9roXLTtJbbmf
         tTafSVBL9+80BU089Fupp0xfVRZICdc+yRPWzn/tgU36GM0YY/F0QZN3zWpOIEwDVuuc
         qN+g==
X-Gm-Message-State: APt69E1BqP/kmA2iSN+dOD40Gddr5GV7cUUGS54gnp/olHBS7LkhU/zs
        bIQyNp+G39xr5DkROeILSnY=
X-Google-Smtp-Source: AAOMgpewjXoVQngAHoS1X9J42qaHeg8w0jKyF8RURfcCtXE2wo4p+MfRrdv1kbRmz0yu+uUEZlooKg==
X-Received: by 2002:adf:b0a3:: with SMTP id i32-v6mr19537864wra.213.1530536994356;
        Mon, 02 Jul 2018 06:09:54 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id j5-v6sm15784455wrq.91.2018.07.02.06.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:09:53 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:09:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
Message-ID: <20180702130952.GE13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-4-mperttunen@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:28PM +0300, Mikko Perttunen wrote:
> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
> send_data function of the mailbox driver is expected to block until
> the message has been sent. The new option is used with the Tegra
> Combined UART driver to minimize unnecessary overhead when transmitting
> data.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/mailbox/mailbox.c | 30 +++++++++++++++++++++---------
>  drivers/mailbox/mailbox.h |  1 +
>  2 files changed, 22 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 674b35f402f5..5c76b70e673c 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -53,6 +53,8 @@ static int add_to_rbuf(struct mbox_chan *chan, void *ms=
sg)
>  	return idx;
>  }
> =20
> +static void tx_tick(struct mbox_chan *chan, int r, bool submit_next);
> +
>  static void msg_submit(struct mbox_chan *chan)
>  {
>  	unsigned count, idx;
> @@ -60,10 +62,13 @@ static void msg_submit(struct mbox_chan *chan)
>  	void *data;
>  	int err =3D -EBUSY;
> =20
> +next:
>  	spin_lock_irqsave(&chan->lock, flags);
> =20
> -	if (!chan->msg_count || chan->active_req)
> -		goto exit;
> +	if (!chan->msg_count || chan->active_req) {
> +		spin_unlock_irqrestore(&chan->lock, flags);
> +		return;
> +	}
> =20
>  	count =3D chan->msg_count;
>  	idx =3D chan->msg_free;
> @@ -82,15 +87,21 @@ static void msg_submit(struct mbox_chan *chan)
>  		chan->active_req =3D data;
>  		chan->msg_count--;
>  	}
> -exit:
> +
>  	spin_unlock_irqrestore(&chan->lock, flags);
> =20
>  	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
>  		/* kick start the timer immediately to avoid delays */
>  		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> +
> +	if (chan->txdone_method & TXDONE_BY_BLOCK) {
> +		tx_tick(chan, err, false);
> +		if (!err)
> +			goto next;
> +	}

This bit is slightly confusing: if check for err, but the call to the
tx_tick() function doesn't actually change err (it's passed by value).
Now, I don't have any great ideas on how to improve this, but perhaps
a simple comment would help clarify what's going on here, or maybe by
adding an extra blank line between the tx_tick() call and the
conditional would make it more obvious that these aren't related.

Also, it looks to me like this is actually modifying msg_submit() to
actually do more than just submit the next data from a message. This
effectively flushes the complete message via the mailbox, right?

Perhaps a slightly clearer implmentation would be to turn this into a
separate function that repeatedly calls msg_submit() in a loop or some
such.

>  }
> =20
> -static void tx_tick(struct mbox_chan *chan, int r)
> +static void tx_tick(struct mbox_chan *chan, int r, bool submit_next)
>  {
>  	unsigned long flags;
>  	void *mssg;
> @@ -101,7 +112,8 @@ static void tx_tick(struct mbox_chan *chan, int r)
>  	spin_unlock_irqrestore(&chan->lock, flags);
> =20
>  	/* Submit next message */
> -	msg_submit(chan);
> +	if (submit_next)
> +		msg_submit(chan);
> =20
>  	if (!mssg)
>  		return;
> @@ -127,7 +139,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrt=
imer *hrtimer)
>  		if (chan->active_req && chan->cl) {
>  			txdone =3D chan->mbox->ops->last_tx_done(chan);
>  			if (txdone)
> -				tx_tick(chan, 0);
> +				tx_tick(chan, 0, true);
>  			else
>  				resched =3D true;
>  		}
> @@ -176,7 +188,7 @@ void mbox_chan_txdone(struct mbox_chan *chan, int r)
>  		return;
>  	}
> =20
> -	tx_tick(chan, r);
> +	tx_tick(chan, r, true);
>  }
>  EXPORT_SYMBOL_GPL(mbox_chan_txdone);
> =20
> @@ -196,7 +208,7 @@ void mbox_client_txdone(struct mbox_chan *chan, int r)
>  		return;
>  	}
> =20
> -	tx_tick(chan, r);
> +	tx_tick(chan, r, true);
>  }
>  EXPORT_SYMBOL_GPL(mbox_client_txdone);
> =20
> @@ -275,7 +287,7 @@ int mbox_send_message(struct mbox_chan *chan, void *m=
ssg)
>  		ret =3D wait_for_completion_timeout(&chan->tx_complete, wait);
>  		if (ret =3D=3D 0) {
>  			t =3D -ETIME;
> -			tx_tick(chan, t);
> +			tx_tick(chan, t, true);
>  		}
>  	}
> =20
> diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
> index 456ba68513bb..ec68e2e28cd6 100644
> --- a/drivers/mailbox/mailbox.h
> +++ b/drivers/mailbox/mailbox.h
> @@ -10,5 +10,6 @@
>  #define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
>  #define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
>  #define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX =
*/
> +#define TXDONE_BY_BLOCK	BIT(3) /* mailbox driver send_data blocks until =
done */

Perhaps clarify here that it blocks until all data in the message has
been transmitted. As it is, this could mean just block until the current
datum is done transmitting.

Thierry

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6JB0ACgkQ3SOs138+
s6GGfw/9FbJ6iRWT4PYlCUartz9zy0pB/iz3QiLHqNFxmOx7UWJYUK/YD4JB7YtR
zuKGgOtn+KL7Acmz8rVgQBCB0HJnbro1QNYQDkDcCx1MP9bhTXmnu/c6hS99CmZn
2pENlQg52KVZsKxEp8SvlByET0MZF3dOOxNTSakbDo75a8OtHCyJgeLKcU907JV9
0G/aB8zW393mQCjYmrA4q2S9iEoMPz0NRQxL4zxKduWBzOUg7vV8URD3A3nqP5QV
lSBRMpWsr67M9nI663Z0cL86gdHSQPIt2Pa7XrU0F+4/1J+VjOITGYK+U/f6dvPO
SsQVlK7iq0tHgsXQCl4qDginYGebay3+sbynPRCfl+8IC4cO7sbZbHmKDWeMW0Ch
73mxhgz4ARICUcoZDXeSbHD26wZzwaQ8CLm2FciJS3EZx8hN58Bab3I/yHuiaSNj
qnv547LQA8Cvai7ktsRr2vE3Lt262vrgsE7aoa3XUHPRJcK8+scoro9LczcLkcm1
v1CWS/9bzFjzlbaagwGhjC/pzzvJDKmNb7Q7ebY1TfbLvemWcmtMgYZSM49iRFTn
MyC9newHlLfTa0YUuasm/idt7vJp/PW4SuElTMJ96uTkIL52ypX/hpuIBhOlVyTk
SGtVvTK+kbpARfwPyNW7bumPhKQKJHJVTfNFKuWEgsyG3VsXXHI=
=aii2
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
