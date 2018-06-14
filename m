Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4EBD9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF85B208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF85B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755396AbeFNPCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:02:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755072AbeFNPCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:02:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEEE5738E0;
        Thu, 14 Jun 2018 15:02:06 +0000 (UTC)
Received: from [10.40.205.76] (unknown [10.40.205.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 044A12022DF5;
        Thu, 14 Jun 2018 15:02:02 +0000 (UTC)
Subject: Re: [PULL] vhost: cleanups and fixes
To:     Wei Wang <wei.w.wang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20180611192353-mutt-send-email-mst@kernel.org>
 <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
 <CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
 <20180612042600-mutt-send-email-mst@kernel.org>
 <CA+55aFyNhEzzufw0XP9DcqZNS1CH+jDGdN4CVnazb3ssFxFbzQ@mail.gmail.com>
 <5B1FA8EF.4030409@intel.com>
From:   Nitesh Narayan Lal <nilal@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nilal@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFl4pQoBEADT/nXR2JOfsCjDgYmE2qonSGjkM1g8S6p9UWD+bf7YEAYYYzZsLtbilFTe
 z4nL4AV6VJmC7dBIlTi3Mj2eymD/2dkKP6UXlliWkq67feVg1KG+4UIp89lFW7v5Y8Muw3Fm
 uQbFvxyhN8n3tmhRe+ScWsndSBDxYOZgkbCSIfNPdZrHcnOLfA7xMJZeRCjqUpwhIjxQdFA7
 n0s0KZ2cHIsemtBM8b2WXSQG9CjqAJHVkDhrBWKThDRF7k80oiJdEQlTEiVhaEDURXq+2XmG
 jpCnvRQDb28EJSsQlNEAzwzHMeplddfB0vCg9fRk/kOBMDBtGsTvNT9OYUZD+7jaf0gvBvBB
 lbKmmMMX7uJB+ejY7bnw6ePNrVPErWyfHzR5WYrIFUtgoR3LigKnw5apzc7UIV9G8uiIcZEn
 C+QJCK43jgnkPcSmwVPztcrkbC84g1K5v2Dxh9amXKLBA1/i+CAY8JWMTepsFohIFMXNLj+B
 RJoOcR4HGYXZ6CAJa3Glu3mCmYqHTOKwezJTAvmsCLd3W7WxOGF8BbBjVaPjcZfavOvkin0u
 DaFvhAmrzN6lL0msY17JCZo046z8oAqkyvEflFbC0S1R/POzehKrzQ1RFRD3/YzzlhmIowkM
 BpTqNBeHEzQAlIhQuyu1ugmQtfsYYq6FPmWMRfFPes/4JUU/PQARAQABzSVOaXRlc2ggTmFy
 YXlhbiBMYWwgPG5pbGFsQHJlZGhhdC5jb20+wsF9BBMBCAAnBQJZeKUKAhsjBQkJZgGABQsJ
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
 pnyVf5xhNC/FzsFNBFl4pQoBEACr+MgxWHUP76oNNYjRiNDhaIVtnPRqxiZ9v4H5FPxJy9UD
 Bqr54rifr1E+K+yYNPt/Po43vVL2cAyfyI/LVLlhiY4yH6T1n+Di/hSkkviCaf13gczuvgz4
 KVYLwojU8+naJUsiCJw01MjO3pg9GQ+47HgsnRjCdNmmHiUQqksMIfd8k3reO9SUNlEmDDNB
 XuSzkHjE5y/R/6p8uXaVpiKPfHoULjNRWaFc3d2JGmxJpBdpYnajoz61m7XJlgwl/B5Ql/6B
 dHGaX3VHxOZsfRfugwYF9CkrPbyO5PK7yJ5vaiWre7aQ9bmCtXAomvF1q3/qRwZp77k6i9R3
 tWfXjZDOQokw0u6d6DYJ0Vkfcwheg2i/Mf/epQl7Pf846G3PgSnyVK6cRwerBl5a68w7xqVU
 4KgAh0DePjtDcbcXsKRT9D63cfyfrNE+ea4i0SVik6+N4nAj1HbzWHTk2KIxTsJXypibOKFX
 2VykltxutR1sUfZBYMkfU4PogE7NjVEU7KtuCOSAkYzIWrZNEQrxYkxHLJsWruhSYNRsqVBy
 KvY6JAsq/i5yhVd5JKKU8wIOgSwC9P6mXYRgwPyfg15GZpnw+Fpey4bCDkT5fMOaCcS+vSU1
 UaFmC4Ogzpe2BW2DOaPU5Ik99zUFNn6cRmOOXArrryjFlLT5oSOe4IposgWzdwARAQABwsFl
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
Message-ID: <0f18063c-c76b-4728-5145-810f069988ea@redhat.com>
Date:   Thu, 14 Jun 2018 11:01:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <5B1FA8EF.4030409@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C0WFAU9gndFtW7QPGmxTNU31IlbEQU5Zk"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 14 Jun 2018 15:02:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 14 Jun 2018 15:02:06 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'nilal@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C0WFAU9gndFtW7QPGmxTNU31IlbEQU5Zk
Content-Type: multipart/mixed; boundary="sgSEkqYiSh3LZ7fwVPXMo9SKALwufKrUn";
 protected-headers="v1"
From: Nitesh Narayan Lal <nilal@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Message-ID: <0f18063c-c76b-4728-5145-810f069988ea@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
References: <20180611192353-mutt-send-email-mst@kernel.org>
 <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
 <CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
 <20180612042600-mutt-send-email-mst@kernel.org>
 <CA+55aFyNhEzzufw0XP9DcqZNS1CH+jDGdN4CVnazb3ssFxFbzQ@mail.gmail.com>
 <5B1FA8EF.4030409@intel.com>
In-Reply-To: <5B1FA8EF.4030409@intel.com>

--sgSEkqYiSh3LZ7fwVPXMo9SKALwufKrUn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi Wei,


On 06/12/2018 07:05 AM, Wei Wang wrote:
> On 06/12/2018 09:59 AM, Linus Torvalds wrote:
>> On Mon, Jun 11, 2018 at 6:36 PM Michael S. Tsirkin <mst@redhat.com>
>> wrote:
>>> Maybe it will help to have GFP_NONE which will make any allocation
>>> fail if attempted. Linus, would this address your comment?
>> It would definitely have helped me initially overlook that call chain.=

>>
>> But then when I started looking at the whole dma_map_page() thing, it
>> just raised my hackles again.
>>
>> I would seriously suggest having a much simpler version for the "no
>> allocation, no dma mapping" case, so that it's *obvious* that that
>> never happens.
>>
>> So instead of having virtio_balloon_send_free_pages() call a really
>> generic complex chain of functions that in _some_ cases can do memory
>> allocation, why isn't there a short-circuited "vitruque_add_datum()"
>> that is guaranteed to never do anything like that?
>>
>> Honestly, I look at "add_one_sg()" and it really doesn't make me
>> happy. It looks hacky as hell. If I read the code right, you're really=

>> trying to just queue up a simple tuple of <pfn,len>, except you encode=

>> it as a page pointer in order to play games with the SG logic, and
>> then you hmap that to the ring, except in this case it's all a fake
>> ring that just adds the cpu-physical address instead.
>>
>> And to figuer that out, it's like five layers of indirection through
>> different helper functions that *can* do more generic things but in
>> this case don't.
>>
>> And you do all of this from a core VM callback function with some
>> _really_ core VM locks held.
>>
>> That makes no sense to me.
>>
>> How about this:
>>
>> =C2=A0 - get rid of all that code
>>
>> =C2=A0 - make the core VM callback save the "these are the free memory=

>> regions" in a fixed and limited array. One that DOES JUST THAT. No
>> crazy "SG IO dma-mapping function crap". Just a plain array of a fixed=

>> size, pre-allocated for that virtio instance.
>>
>> =C2=A0 - make it obvious that what you do in that sequence is ten
>> instructions and no allocations ("Look ma, I wrote a value to an array=

>> and incremented the array idex, and I'M DONE")
>>
>> =C2=A0 - then in that workqueue entry that you start *anyway*, you emp=
ty the
>> array and do all the crazy virtio stuff.
>>
>> In fact, while at it, just simplify the VM interface too. Instead of
>> traversing a random number of buddy lists, just trraverse *one* - the
>> top-level one. Are you seriously ever going to shrink or mark
>> read-only anythin *but* something big enough to be in the maximum
>> order?
>>
>> MAX_ORDER is what, 11? So we're talking 8MB blocks. Do you *really*
>> want the balloon code to work on smaller things, particularly since
>> the whole interface is fundamentally racy and opportunistic to begin
>> with?
>
> OK, I will implement a new version based on the suggestions. Thanks.

I have been working on a similar series [1] that is more generic, which
solves the problem of giving unused memory back to the host and could be
used to solve the migration problem as well. Can you take a look and see
if you can use my series in some way?

[1] https://www.spinics.net/lists/kvm/msg170113.html

>
> Best,
> Wei
>

--=20
Regards
Nitesh


--sgSEkqYiSh3LZ7fwVPXMo9SKALwufKrUn--

--C0WFAU9gndFtW7QPGmxTNU31IlbEQU5Zk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbIoNnAAoJEKOGQNwGMqM5Dy4P/Ra5IFpF8SVy4Q9fWv/o5efH
jGrm45/6BhRpOF73lsHROIUxncelHLW9TKWOCmSQ6kgC84OKAdo/1O5gNbWvVz5W
4IvPTGVEDAyAFj4AUlkkPMPbRapCRpbzPCuH+KaIVb4QDn8uHU+alSPLn+v1ZjPd
zraiY7nJ4muqNlKraOrStNUnZ2Hny1ZPSha/IDWLWFk9S/pPB1pP1nghmcGQI3Tp
UkJjx3uz1DDZ/fIlnkO93GVzZtYhK5NNQzgvc0b1E7fK0+FnHq7AmBQfG5ZokvSE
u6icEZl2muRpgWz2Tzewycn28yR8P5/5EVnDkoti0lkET009AAAb/ylcmvtR6BHh
ZWcGl1EK23268rN6RzYa4Bj/9cipbDNMjOu5zJX4/3/7d5t9qaWmIiM7HGXFhKLI
Ly0YgK9uLngKlTT3B74w0PgX0+MXT6rxn1aPNZi9ddI68iHaynS/xwKWi9HkN86i
8ZhqwkkY5Gxa62R4ed+0LfNap6DgsiOisusHIi4eSfKbvhFFIgVN1/dOrNDe1dTq
uJC/CrOjztJA9x469IL0Js6nhFDrrZMLzH5j6vQgJw/ifR3Ee6memY0ycf9kQrwj
xHFpINvR477cbc3dhbDvCH1sOo/JwJJkvViqNFZKtgGjosLZC7ATWN8eucAQqnZT
lSPpv+uFdTnKdSexYr4h
=H2xU
-----END PGP SIGNATURE-----

--C0WFAU9gndFtW7QPGmxTNU31IlbEQU5Zk--
