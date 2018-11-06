Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B989C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C8520862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k057e+rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C8520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbeKGB3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:29:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41839 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388773AbeKGB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:29:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so14121852wrw.8;
        Tue, 06 Nov 2018 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yzNS/VoZoijLZqRXpszGM65p4sDQhWJxQZbfQ7B9CHs=;
        b=k057e+rdJg4UHuUSUsUZuMbspFbpUEK2SfR8EGJYmVWiCIIhR7Voz8BszwZM00jb70
         uubKygP2SnStDhwwZ5dU6hYQmwL055MbEuC2OJKSqeb4C5HxOYFY50ysDlqrZXQFmJDV
         kiQ5I0GwWKZ0CjndnYX5nCpSTOgPtR2r2PEu1hIC0OLcQcuxn08iiXlWMnok7mYCW/r5
         f7QHsU+pspGCYyMSuLDFB7jk1Qjl647ah4Cv9EPF7MOvj6kWNSi/7i2OuoTme+B4Cew/
         fawubp1puFOVntS+EqGnKa4E/xHhtXxzPpDGTnXEqL/MkvH3g8HDnurv0S9cdbxx/xz7
         Ix0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yzNS/VoZoijLZqRXpszGM65p4sDQhWJxQZbfQ7B9CHs=;
        b=OmWQJ5vvuBiLQVP9P4Y2SNsFQoG6666xjUwTgzxLU5DQmvGbVqV82VtP9ZliDnYCkk
         NSFWLq1M5mCV17j6ryZT0Z2NEFYm1b9GNZ7LLGe8nqHvx5/US55JfSB651B7+oN+sdHM
         HWQt4KRFmzWgC0kGtGuAxhFwHZ/ybK2sGM8vF1jzLU6ZVr9uDAZK1liRNIj9Xcu62DTE
         kI/kueKNxLp+3jrOITdx/Rw/Bac29zWmY7Rw26tRgzCQGIUSaMOV6Xc0tRH+NjQuIcMH
         I+Y1e+ui/+h96DWO/vTOUEJ0VIWq41RZCGIDn7hILjS2Tlx2pGubOBL9tfsPQxKlk9Q4
         vDJA==
X-Gm-Message-State: AGRZ1gJ/NIWieKapP5taMPlqieK9ZWh22Ii8sjmk7Tlr1oo0bpMx/Hh3
        /nb4jH/OwSV87MUo+Bx5PT4=
X-Google-Smtp-Source: AJdET5dG/hMFNvGDMr/TUwkBMeXtuzw/Xbzs8duq6A2bDwRF8MH8cYI3yd4iXXyRi76Zt/b6hLSamw==
X-Received: by 2002:adf:8444:: with SMTP id 62-v6mr22814396wrf.251.1541520198615;
        Tue, 06 Nov 2018 08:03:18 -0800 (PST)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id y76-v6sm3369015wmd.37.2018.11.06.08.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 08:03:17 -0800 (PST)
Date:   Tue, 6 Nov 2018 16:03:16 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add vhost_blk driver
Message-ID: <20181106160316.GC31579@stefanha-x1.localdomain>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
 <20181102182123.29420-2-v.mayatskih@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <20181102182123.29420-2-v.mayatskih@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 02, 2018 at 06:21:23PM +0000, Vitaly Mayatskikh wrote:
> This driver accelerates host side of virtio-blk.

Did you look at vhost-user-blk?  It does things slightly differently:
more of the virtio-blk device model is handled by the vhost-user device
(e.g. config space).  That might be necessary to implement
virtio_blk_config.writeback properly.

> +#define VHOST_BLK_SET_BACKEND _IOW(VHOST_VIRTIO, 0x50, int)

Needs to be in the uapi header so userspace can use it.

> +
> +enum {
> +	VHOST_BLK_VQ_MAX = 16,
> +	VHOST_BLK_VQ_MAX_REQS = 128,
> +};

These limits seem arbitrary and probably too low.

> +
> +struct vhost_blk_req {
> +	struct llist_node list;
> +	int index;
> +	struct vhost_blk_queue *q;
> +	struct virtio_blk_outhdr hdr;
> +	struct iovec *out_iov;
> +	struct iovec *in_iov;
> +	u8 out_num;
> +	u8 in_num;
> +	long len;
> +	struct kiocb iocb;
> +	struct iov_iter i;
> +	int res;
> +	void __user *status;
> +};
> +
> +struct vhost_blk_queue {
> +	int index;
> +	struct vhost_blk *blk;
> +	struct vhost_virtqueue vq;
> +	struct vhost_work w;
> +	struct llist_head wl;

What is this?  Please use clear names and comments. :)

> +static int vhost_blk_req_handle(struct vhost_blk_req *req)
> +{
> +	struct vhost_blk *blk = req->q->blk;
> +	struct vhost_virtqueue *vq = &req->q->vq;
> +	int type = le32_to_cpu(req->hdr.type);
> +	int ret;
> +	u8 status;
> +
> +	if ((type == VIRTIO_BLK_T_IN) || (type == VIRTIO_BLK_T_OUT)) {
> +		bool write = (type == VIRTIO_BLK_T_OUT);
> +		int nr_seg = (write ? req->out_num : req->in_num) - 1;
> +		unsigned long sector = le64_to_cpu(req->hdr.sector);

Using little-endian instead of the virtio types means that only VIRTIO
1.0 modern devices are supported (older devices may not be
little-endian!).  In that case you'd need to put the VIRTIO_1 feature
bit into the features mask.

> +		req = &q->req[head];
> +		req->index = head;
> +		req->out_num = out;
> +		req->in_num = in;
> +		req->out_iov = &vq->iov[1];
> +		req->in_iov = &vq->iov[out];
> +		req->status = vq->iov[out + in - 1].iov_base;

The VIRTIO spec explicitly requires that devices support arbitrary
descriptor layouts, so you cannot assume a particular iov[] layout.

> +static long vhost_blk_ioctl(struct file *f, unsigned int ioctl,
> +			    unsigned long arg)
> +{
> +	struct vhost_blk *blk = f->private_data;
> +	void __user *argp = (void __user *)arg;
> +	int fd;
> +	u64 __user *featurep = argp;
> +	u64 features;
> +	long ret;
> +	struct vhost_vring_state s;
> +
> +	switch (ioctl) {
> +	case VHOST_SET_MEM_TABLE:
> +		vhost_blk_stop(blk);
> +		ret = vhost_blk_pass_ioctl(blk, ioctl, argp);
> +		break;

Why is this necessary?  Existing vhost devices pass the ioctl through
without an explicit case for it.

> +	case VHOST_SET_VRING_NUM:
> +		if (copy_from_user(&s, argp, sizeof(s)))
> +			return -EFAULT;
> +		ret = vhost_blk_pass_ioctl(blk, ioctl, argp);
> +		if (!ret)
> +			blk->num_queues = s.index + 1;

Where is this input checked against ARRAY_SIZE(blk->queue)?

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4btEAAoJEJykq7OBq3PI18kIAIWRNjdZlTZigFtAV0woY7NN
RQ9Kc0frAJv1XpbDemdbA41L7y2resmg4dcMIEFtd0qRbNjoXi8e8yRqF9RbBaqG
R9EUKz6cTYVlBURJp9zMYyEFbVR1tbo3J7Wid1Z1uRY9QAiB6FbmCu8cYWFVWL+S
8GA/rjcuqvoz19VnfVtH0IZbjD1/GH4boK0Y+fwH5WjC7jrnZSnjrXKSiFOeTm+9
3Mzgelzw/hKQePNvTO1B+W/C2+Se6q0Jfwb9i8pmtnyv4hl63IDkqnOqvDZ8L/qO
ypdaqmXAIGRZzUH5sn7yqZQX7mFNy8IdGk7RAazczZfsrKexHMD+YIS1OSfdmfY=
=eZZY
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
