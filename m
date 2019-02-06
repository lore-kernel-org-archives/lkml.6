Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAACC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B485720B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfBFM4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:56:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbfBFM4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:56:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A58A8A787A;
        Wed,  6 Feb 2019 12:56:44 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E5DA68D27;
        Wed,  6 Feb 2019 12:56:38 +0000 (UTC)
Subject: Re: [RFC][Patch v8 5/7] virtio: Enables to add a single descriptor to
 the host
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
        dhildenb@redhat.com, aarcange@redhat.com
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-6-nitesh@redhat.com>
 <20190205154545-mutt-send-email-mst@kernel.org>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFl4pQoBEADT/nXR2JOfsCjDgYmE2qonSGjkM1g8S6p9UWD+bf7YEAYYYzZsLtbilFTe
 z4nL4AV6VJmC7dBIlTi3Mj2eymD/2dkKP6UXlliWkq67feVg1KG+4UIp89lFW7v5Y8Muw3Fm
 uQbFvxyhN8n3tmhRe+ScWsndSBDxYOZgkbCSIfNPdZrHcnOLfA7xMJZeRCjqUpwhIjxQdFA7
 n0s0KZ2cHIsemtBM8b2WXSQG9CjqAJHVkDhrBWKThDRF7k80oiJdEQlTEiVhaEDURXq+2XmG
 jpCnvRQDb28EJSsQlNEAzwzHMeplddfB0vCg9fRk/kOBMDBtGsTvNT9OYUZD+7jaf0gvBvBB
 lbKmmMMX7uJB+ejY7bnw6ePNrVPErWyfHzR5WYrIFUtgoR3LigKnw5apzc7UIV9G8uiIcZEn
 C+QJCK43jgnkPcSmwVPztcrkbC84g1K5v2Dxh9amXKLBA1/i+CAY8JWMTepsFohIFMXNLj+B
 RJoOcR4HGYXZ6CAJa3Glu3mCmYqHTOKwezJTAvmsCLd3W7WxOGF8BbBjVaPjcZfavOvkin0u
 DaFvhAmrzN6lL0msY17JCZo046z8oAqkyvEflFbC0S1R/POzehKrzQ1RFRD3/YzzlhmIowkM
 BpTqNBeHEzQAlIhQuyu1ugmQtfsYYq6FPmWMRfFPes/4JUU/PQARAQABtCVOaXRlc2ggTmFy
 YXlhbiBMYWwgPG5pbGFsQHJlZGhhdC5jb20+iQI9BBMBCAAnBQJZeKUKAhsjBQkJZgGABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEKOGQNwGMqM56lEP/A2KMs/pu0URcVk/kqVwcBhU
 SnvB8DP3lDWDnmVrAkFEOnPX7GTbactQ41wF/xwjwmEmTzLrMRZpkqz2y9mV0hWHjqoXbOCS
 6RwK3ri5e2ThIPoGxFLt6TrMHgCRwm8YuOSJ97o+uohCTN8pmQ86KMUrDNwMqRkeTRW9wWIQ
 EdDqW44VwelnyPwcmWHBNNb1Kd8j3xKlHtnS45vc6WuoKxYRBTQOwI/5uFpDZtZ1a5kq9Ak/
 MOPDDZpd84rqd+IvgMw5z4a5QlkvOTpScD21G3gjmtTEtyfahltyDK/5i8IaQC3YiXJCrqxE
 r7/4JMZeOYiKpE9iZMtS90t4wBgbVTqAGH1nE/ifZVAUcCtycD0f3egX9CHe45Ad4fsF3edQ
 ESa5tZAogiA4Hc/yQpnnf43a3aQ67XPOJXxS0Qptzu4vfF9h7kTKYWSrVesOU3QKYbjEAf95
 NewF9FhAlYqYrwIwnuAZ8TdXVDYt7Z3z506//sf6zoRwYIDA8RDqFGRuPMXUsoUnf/KKPrtR
 ceLcSUP/JCNiYbf1/QtW8S6Ca/4qJFXQHp0knqJPGmwuFHsarSdpvZQ9qpxD3FnuPyo64S2N
 Dfq8TAeifNp2pAmPY2PAHQ3nOmKgMG8Gn5QiORvMUGzSz8Lo31LW58NdBKbh6bci5+t/HE0H
 pnyVf5xhNC/FuQINBFl4pQoBEACr+MgxWHUP76oNNYjRiNDhaIVtnPRqxiZ9v4H5FPxJy9UD
 Bqr54rifr1E+K+yYNPt/Po43vVL2cAyfyI/LVLlhiY4yH6T1n+Di/hSkkviCaf13gczuvgz4
 KVYLwojU8+naJUsiCJw01MjO3pg9GQ+47HgsnRjCdNmmHiUQqksMIfd8k3reO9SUNlEmDDNB
 XuSzkHjE5y/R/6p8uXaVpiKPfHoULjNRWaFc3d2JGmxJpBdpYnajoz61m7XJlgwl/B5Ql/6B
 dHGaX3VHxOZsfRfugwYF9CkrPbyO5PK7yJ5vaiWre7aQ9bmCtXAomvF1q3/qRwZp77k6i9R3
 tWfXjZDOQokw0u6d6DYJ0Vkfcwheg2i/Mf/epQl7Pf846G3PgSnyVK6cRwerBl5a68w7xqVU
 4KgAh0DePjtDcbcXsKRT9D63cfyfrNE+ea4i0SVik6+N4nAj1HbzWHTk2KIxTsJXypibOKFX
 2VykltxutR1sUfZBYMkfU4PogE7NjVEU7KtuCOSAkYzIWrZNEQrxYkxHLJsWruhSYNRsqVBy
 KvY6JAsq/i5yhVd5JKKU8wIOgSwC9P6mXYRgwPyfg15GZpnw+Fpey4bCDkT5fMOaCcS+vSU1
 UaFmC4Ogzpe2BW2DOaPU5Ik99zUFNn6cRmOOXArrryjFlLT5oSOe4IposgWzdwARAQABiQIl
 BBgBCAAPBQJZeKUKAhsMBQkJZgGAAAoJEKOGQNwGMqM5ELoP/jj9d9gF1Al4+9bngUlYohYu
 0sxyZo9IZ7Yb7cHuJzOMqfgoP4tydP4QCuyd9Q2OHHL5AL4VFNb8SvqAxxYSPuDJTI3JZwI7
 d8JTPKwpulMSUaJE8ZH9n8A/+sdC3CAD4QafVBcCcbFe1jifHmQRdDrvHV9Es14QVAOTZhnJ
 vweENyHEIxkpLsyUUDuVypIo6y/Cws+EBCWt27BJi9GH/EOTB0wb+2ghCs/i3h8a+bi+bS7L
 FCCm/AxIqxRurh2UySn0P/2+2eZvneJ1/uTgfxnjeSlwQJ1BWzMAdAHQO1/lnbyZgEZEtUZJ
 x9d9ASekTtJjBMKJXAw7GbB2dAA/QmbA+Q+Xuamzm/1imigz6L6sOt2n/X/SSc33w8RJUyor
 SvAIoG/zU2Y76pKTgbpQqMDmkmNYFMLcAukpvC4ki3Sf086TdMgkjqtnpTkEElMSFJC8npXv
 3QnGGOIfFug/qs8z03DLPBz9VYS26jiiN7QIJVpeeEdN/LKnaz5LO+h5kNAyj44qdF2T2AiF
 HxnZnxO5JNP5uISQH3FjxxGxJkdJ8jKzZV7aT37sC+Rp0o3KNc+GXTR+GSVq87Xfuhx0LRST
 NK9ZhT0+qkiN7npFLtNtbzwqaqceq3XhafmCiw8xrtzCnlB/C4SiBr/93Ip4kihXJ0EuHSLn
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <26a36489-2289-f970-3362-60547b268a76@redhat.com>
Date:   Wed, 6 Feb 2019 07:56:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205154545-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ha4exRGTtw5KbdsWt5m4y9umJmPCcpij8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 06 Feb 2019 12:56:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ha4exRGTtw5KbdsWt5m4y9umJmPCcpij8
Content-Type: multipart/mixed; boundary="tdA7p9mxdzwJbQvr5PBwjo22dgtaMZoyO";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 yang.zhang.wz@gmail.com, riel@surriel.com, david@redhat.com,
 dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
 aarcange@redhat.com
Message-ID: <26a36489-2289-f970-3362-60547b268a76@redhat.com>
Subject: Re: [RFC][Patch v8 5/7] virtio: Enables to add a single descriptor to
 the host
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-6-nitesh@redhat.com>
 <20190205154545-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190205154545-mutt-send-email-mst@kernel.org>

--tdA7p9mxdzwJbQvr5PBwjo22dgtaMZoyO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/5/19 3:49 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 04, 2019 at 03:18:52PM -0500, Nitesh Narayan Lal wrote:
>> This patch enables the caller to expose a single buffers to the
>> other end using vring descriptor. It also allows the caller to
>> perform this action in synchornous manner by using virtqueue_kick_sync=
=2E
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> I am not sure why do we need this API. Polling in guest
> until host runs isn't great either since these
> might be running on the same host CPU.
True.

However, my understanding is that the existing API such as
virtqueue_add_outbuf() requires an allocation which will be problematic
for my implementation.
Although I am not blocking the allocation path during normal Linux
kernel usage as even if one of the zone is locked the other zone could
be used to get free pages.
But during the initial boot time (device initialization), in certain
situations the allocation can only come from a single zone, acquiring a
lock on it may result in a deadlock situation.

>
>
>
>> ---
>>  drivers/virtio/virtio_ring.c | 72 +++++++++++++++++++++++++++++++++++=
+
>>  include/linux/virtio.h       |  4 ++
>>  2 files changed, 76 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring=
=2Ec
>> index cd7e755484e3..93c161ac6a28 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -1695,6 +1695,52 @@ static inline int virtqueue_add(struct virtqueu=
e *_vq,
>>  					out_sgs, in_sgs, data, ctx, gfp);
>>  }
>> =20
>> +/**
>> + * virtqueue_add_desc - add a buffer to a chain using a vring desc
>> + * @vq: the struct virtqueue we're talking about.
>> + * @addr: address of the buffer to add.
>> + * @len: length of the buffer.
>> + * @in: set if the buffer is for the device to write.
>> + *
>> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
>> + */
>> +int virtqueue_add_desc(struct virtqueue *_vq, u64 addr, u32 len, int =
in)
>> +{
>> +	struct vring_virtqueue *vq =3D to_vvq(_vq);
>> +	struct vring_desc *desc =3D vq->split.vring.desc;
>> +	u16 flags =3D in ? VRING_DESC_F_WRITE : 0;
>> +	unsigned int i;
>> +	void *data =3D (void *)addr;
>> +	int avail_idx;
>> +
>> +	/* Sanity check */
>> +	if (!_vq)
>> +		return -EINVAL;
>> +
>> +	START_USE(vq);
>> +	if (unlikely(vq->broken)) {
>> +		END_USE(vq);
>> +		return -EIO;
>> +	}
>> +
>> +	i =3D vq->free_head;
>> +	flags &=3D ~VRING_DESC_F_NEXT;
>> +	desc[i].flags =3D cpu_to_virtio16(_vq->vdev, flags);
>> +	desc[i].addr =3D cpu_to_virtio64(_vq->vdev, addr);
>> +	desc[i].len =3D cpu_to_virtio32(_vq->vdev, len);
>> +
>> +	vq->vq.num_free--;
>> +	vq->free_head =3D virtio16_to_cpu(_vq->vdev, desc[i].next);
>> +	vq->split.desc_state[i].data =3D data;
>> +	vq->split.avail_idx_shadow =3D 1;
>> +	avail_idx =3D vq->split.avail_idx_shadow;
>> +	vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev, avail_idx)=
;
>> +	vq->num_added =3D 1;
>> +	END_USE(vq);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(virtqueue_add_desc);
>> +
>>  /**
>>   * virtqueue_add_sgs - expose buffers to other end
>>   * @vq: the struct virtqueue we're talking about.
>> @@ -1842,6 +1888,32 @@ bool virtqueue_notify(struct virtqueue *_vq)
>>  }
>>  EXPORT_SYMBOL_GPL(virtqueue_notify);
>> =20
>> +/**
>> + * virtqueue_kick_sync - update after add_buf and busy wait till upda=
te is done
>> + * @vq: the struct virtqueue
>> + *
>> + * After one or more virtqueue_add_* calls, invoke this to kick
>> + * the other side. Busy wait till the other side is done with the upd=
ate.
>> + *
>> + * Caller must ensure we don't call this with other virtqueue
>> + * operations at the same time (except where noted).
>> + *
>> + * Returns false if kick failed, otherwise true.
>> + */
>> +bool virtqueue_kick_sync(struct virtqueue *vq)
>> +{
>> +	u32 len;
>> +
>> +	if (likely(virtqueue_kick(vq))) {
>> +		while (!virtqueue_get_buf(vq, &len) &&
>> +		       !virtqueue_is_broken(vq))
>> +			cpu_relax();
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(virtqueue_kick_sync);
>> +
>>  /**
>>   * virtqueue_kick - update after add_buf
>>   * @vq: the struct virtqueue
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index fa1b5da2804e..58943a3a0e8d 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -57,6 +57,10 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>>  		      unsigned int in_sgs,
>>  		      void *data,
>>  		      gfp_t gfp);
>> +/* A desc with this init id is treated as an invalid desc */
>> +int virtqueue_add_desc(struct virtqueue *_vq, u64 addr, u32 len, int =
in);
>> +
>> +bool virtqueue_kick_sync(struct virtqueue *vq);
>> =20
>>  bool virtqueue_kick(struct virtqueue *vq);
>> =20
>> --=20
>> 2.17.2
--=20
Regards
Nitesh


--tdA7p9mxdzwJbQvr5PBwjo22dgtaMZoyO--

--ha4exRGTtw5KbdsWt5m4y9umJmPCcpij8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxa2YUACgkQo4ZA3AYy
ozm3YhAArLA7JLniz1fqgzuOgoKdVdhkoaS1sxtMPh31s/UzOtaArza9oi65DlcI
qCwYTo48bsoo4+VAQfBWkYI3F8mdCnPZNRUzCrIgKMA+DSUF27PjUOEvpxZeADMP
TgaXwONd/cPYOlXRomZlSfUwzq0fKDh/X6CPXAqPaaEf2L5yDvET3B69INGgxTzz
yMPWeCUtw5R4Q0KGPOnGhiJ8PbhgO5hP9yZZOlXJVMJo2ADb1BugC6AmTR6CM880
BI2/pSAuYKvtSEV4hRV7nHsqBHaPvVGaaPfbW1rmWrkNLquk91hm8vrPH8aw0wCS
neu/GDQ9LMgRWrR05Pr359Tg+SyPEiNrBrHHjNJ8ttISSlcW6XWOXkGwx9yydjkC
aTUP9+lDNsv/7A9RvqG12/OnM0/Juy8eDQMoJdHnqSeGbBjjYBxxI2EtrGXh8nZx
OErN/nebZUnS9AdZXIrEgwmK0/Wc9U66sXgkowu8WHMReJPwrFoHoctmJCjOoMAH
ViT3DC2c5qw6Xp0+laEItIw5M/wjn0VMhj21RYbp2sjEJ4QTM1jSVAm1NsYHmdrt
pyoxCMg55C/sp41JkrZHN6DedF2qFT0NA1NK5i6gKR9az2Jfju4eLsqAJh3nPx/2
qcXjgvO21PDf9kMFbb2p79oCmGtAUBxoqMAd8vYWZXh0UMn+s6E=
=J5tb
-----END PGP SIGNATURE-----

--ha4exRGTtw5KbdsWt5m4y9umJmPCcpij8--
