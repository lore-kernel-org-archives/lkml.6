Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF96CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E651204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfBSMwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:52:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:52:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66A47C04B948;
        Tue, 19 Feb 2019 12:52:53 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A4EE61B93;
        Tue, 19 Feb 2019 12:52:45 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
 <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com>
 <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
 <20190219024611.GC24502@redhat.com>
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
Message-ID: <962d007f-1bcc-2495-98ab-871160472f78@redhat.com>
Date:   Tue, 19 Feb 2019 07:52:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219024611.GC24502@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c4G3RTOfu7IxRLuyLZues10vZVNhaEDaU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 12:52:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c4G3RTOfu7IxRLuyLZues10vZVNhaEDaU
Content-Type: multipart/mixed; boundary="pelLFpw6xaWDgkjvGa6B2I3HTTQn2nB6R";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: Andrea Arcangeli <aarcange@redhat.com>,
 Alexander Duyck <alexander.duyck@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, kvm list <kvm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>,
 dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 dhildenb@redhat.com
Message-ID: <962d007f-1bcc-2495-98ab-871160472f78@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
 <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com>
 <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
 <20190219024611.GC24502@redhat.com>
In-Reply-To: <20190219024611.GC24502@redhat.com>

--pelLFpw6xaWDgkjvGa6B2I3HTTQn2nB6R
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/18/19 9:46 PM, Andrea Arcangeli wrote:
> Hello,
>
> On Mon, Feb 18, 2019 at 03:47:22PM -0800, Alexander Duyck wrote:
>> essentially fragmented them. I guess hugepaged went through and
>> started trying to reassemble the huge pages and as a result there have=

>> been apps that ended up consuming more memory than they would have
>> otherwise since they were using fragments of THP pages after doing an
>> MADV_DONTNEED on sections of the page.
> With relatively recent kernels MADV_DONTNEED doesn't necessarily free
> anything when it's applied to a THP subpage, it only splits the
> pagetables and queues the THP for deferred splitting. If there's
> memory pressure a shrinker will be invoked and the queue is scanned
> and the THPs are physically splitted, but to be reassembled/collapsed
> after a physical split it requires at least one young pte.
>
> If this is particularly problematic for page hinting, this behavior
> where the MADV_DONTNEED can be undoed by khugepaged (if some subpage is=

> being frequently accessed), can be turned off by setting
> /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none to
> 0. Then the THP will only be collapsed if all 512 subpages are mapped
> (i.e. they've all be re-allocated by the guest).
>
> Regardless of the max_ptes_none default, keeping the smaller guest
> buddy orders as the last target for page hinting should be good for
> performance.
>
>> Yeah, no problem. The only thing I don't like about MADV_FREE is that
>> you have to have memory pressure before the pages really start getting=

>> scrubbed with is both a benefit and a drawback. Basically it defers
>> the freeing until you are under actual memory pressure so when you hit=

>> that case things start feeling much slower, that and it limits your
>> allocations since the kernel doesn't recognize the pages as free until=

>> it would have to start trying to push memory to swap.
> The guest allocation behavior should not be influenced by MADV_FREE vs
> MADV_DONTNEED, the guest can't see the difference anyway, so why
> should it limit the allocations?
>
> The benefit of MADV_FREE should be that when the same guest frees and
> reallocates an huge amount of RAM (i.e. guest app allocating and
> freeing lots of RAM in a loop, not so uncommon), there will be no KVM
> page fault during guest re-allocations. So in absence of memory
> pressure in the host it should be a major win. Overall it sounds like
> a good tradeoff compared to MADV_DONTNEED that forcefully invokes MMU
> notifiers and forces host allocations and KVM page faults in order to
> reallocate the same RAM in the same guest.
This does makes sense.
Thanks for explaining this.
>
> When there's memory pressure it's up to the host Linux VM to notice
> there's plenty of MADV_FREE material to free at zero I/O cost before
> starting swapping.
>
> Thanks,
> Andrea
--=20
Regards
Nitesh


--pelLFpw6xaWDgkjvGa6B2I3HTTQn2nB6R--

--c4G3RTOfu7IxRLuyLZues10vZVNhaEDaU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxr/B0ACgkQo4ZA3AYy
ozmGqw/+NXI4IguKv3TTqggM3uX77U6iqYZ6tPHn32gbTWe3CJzNS++P4hBgFqWl
E3lnfYbO0LlMiYLZEMstRHrHjiZPjIzuJJ9l4WhZyG9SYAHuIrFDFviLobie3rVx
r3nsCLROyMMJ2ai/HmHutl24ivtBFOpVXTbXfMG612fWAaV9gmNGlb7Jhtg4FyFf
irZtHTT/PyeI83rqszuEmVMoBrET5wa6qnYPzDKhBm2y6KP94qARZS+VA4py/2UQ
qbwKn6kawUSKLp6BYfUlKzO6cF1y/ZN3ktL5Xkuu6CIYxmMRcq5ipAT+qrCAWjca
Zp2Xf/5zMmtxmYhYmox4bhbh1F0+PRlbBqvhAMOWmFmOwLszeqS7DGNqV91FYVnX
Y7zlXW4G7di1kaTkln7/Jz10Rz4Q9AO7g1Q5FUIG/QCNB4MJzn+c0ugcLH6z8ehF
DJ/4+f2L/FyPj0YrFOEl9GopH1OHybDCyMohcCWoq66/C6CCKbT4HpXh0oMJmzd5
kx7ULz8RKpBAIr6B59tfutYEqBPdJM30mI7F2H6ZC07F7asgKcwdcZOFyGrIsplu
O+g62KlqRpif0fGmj84Qjn+mITk1Btghiv29PknPo/4Zdd8iCc0q/WtHdAcE/80j
LN1ATphEdXbk1nwlPBbObM5hQfUqS8e+HiPWebvPyuA2csjBX6s=
=1lf0
-----END PGP SIGNATURE-----

--c4G3RTOfu7IxRLuyLZues10vZVNhaEDaU--
