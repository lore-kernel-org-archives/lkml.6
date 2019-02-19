Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCD9217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfBSMsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:48:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfBSMsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:48:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90C9840D88;
        Tue, 19 Feb 2019 12:48:09 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51A285D70E;
        Tue, 19 Feb 2019 12:47:59 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org>
 <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
 <20190218140947-mutt-send-email-mst@kernel.org>
 <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org>
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <e2273f4a-dfe9-45fe-d924-598d3e8b38b5@redhat.com>
Date:   Tue, 19 Feb 2019 07:47:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p6SRatsAVeeK97o7veSepbn8svFE3w2lM"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 12:48:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p6SRatsAVeeK97o7veSepbn8svFE3w2lM
Content-Type: multipart/mixed; boundary="osYSSeaMDvVL4bRIA1509I2G3hFewYuPz";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 yang.zhang.wz@gmail.com, riel@surriel.com, dodgen@google.com,
 konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
 Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <e2273f4a-dfe9-45fe-d924-598d3e8b38b5@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org>
 <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
 <20190218140947-mutt-send-email-mst@kernel.org>
 <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org>
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
In-Reply-To: <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>

--osYSSeaMDvVL4bRIA1509I2G3hFewYuPz
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/18/19 4:04 PM, David Hildenbrand wrote:
> On 18.02.19 21:40, Nitesh Narayan Lal wrote:
>> On 2/18/19 3:31 PM, Michael S. Tsirkin wrote:
>>> On Mon, Feb 18, 2019 at 09:04:57PM +0100, David Hildenbrand wrote:
>>>>>>>>> So I'm fine with a simple implementation but the interface need=
s to
>>>>>>>>> allow the hypervisor to process hints in parallel while guest i=
s
>>>>>>>>> running.  We can then fix any issues on hypervisor without brea=
king
>>>>>>>>> guests.
>>>>>>>> Yes, I am fine with defining an interface that theoretically let=
's us
>>>>>>>> change the implementation in the guest later.
>>>>>>>> I consider this even a
>>>>>>>> prerequisite. IMHO the interface shouldn't be different, it will=
 be
>>>>>>>> exactly the same.
>>>>>>>>
>>>>>>>> It is just "who" calls the batch freeing and waits for it. And a=
s I
>>>>>>>> outlined here, doing it without additional threads at least avoi=
ds us
>>>>>>>> for now having to think about dynamic data structures and that w=
e can
>>>>>>>> sometimes not report "because the thread is still busy reporting=
 or
>>>>>>>> wasn't scheduled yet".
>>>>>>> Sorry I wasn't clear. I think we need ability to change the
>>>>>>> implementation in the *host* later. IOW don't rely on
>>>>>>> host being synchronous.
>>>>>>>
>>>>>>>
>>>>>> I actually misread it :) . In any way, there has to be a mechanism=
 to
>>>>>> synchronize.
>>>>>>
>>>>>> If we are going via a bare hypercall (like s390x, like what Alexan=
der
>>>>>> proposes), it is going to be a synchronous interface either way. J=
ust a
>>>>>> bare hypercall, there will not really be any blocking on the guest=
 side.
>>>>> It bothers me that we are now tied to interface being synchronous. =
We
>>>>> won't be able to fix it if there's an issue as that would break gue=
sts.
>>>> I assume with "fix it" you mean "fix kfree taking longer on every X =
call"?
>>>>
>>>> Yes, as I initially wrote, this mimics s390x. That might be good (we=

>>>> know it has been working for years) and bad (we are inheriting the s=
ame
>>>> problem class, if it exists). And being synchronous is part of the
>>>> approach for now.
>>> BTW on s390 are these hypercalls handled by Linux?
>>>
>>>> I tend to focus on the first part (we don't know anything besides it=
 is
>>>> working) while you focus on the second part (there could be a potent=
ial
>>>> problem). Having a real problem at hand would be great, then we woul=
d
>>>> know what exactly we actually have to fix. But read below.
>>> If we end up doing a hypercall per THP, maybe we could at least
>>> not block with interrupts disabled? Poll in guest until
>>> hypervisor reports its done?  That would already be an
>>> improvement IMHO. E.g. perf within guest will point you
>>> in the right direction and towards disabling hinting.
>>>
>>>
>>>>>> Via virtio, I guess it is waiting for a response to a requests, ri=
ght?
>>>>> For the buffer to be used, yes. And it could mean putting some page=
s
>>>>> aside until hypervisor is done with them. Then you don't need timer=
s or
>>>>> tricks like this, you can get an interrupt and start using the memo=
ry.
>>>> I am very open to such an approach as long as we can make it work an=
d it
>>>> is not too complicated. (-> simple)
>>>>
>>>> This would mean for example
>>>>
>>>> 1. Collect entries to be reported per VCPU in a buffer. Say magic nu=
mber
>>>> 256/512.
>>>>
>>>> 2. Once the buffer is full, do crazy "take pages out of the balloon
>>>> action" and report them to the hypervisor via virtio. Let the VCPU
>>>> continue. This will require some memory to store the request. Small
>>>> hickup for the VCPU to kick of the reporting to the hypervisor.
>>>>
>>>> 3. On interrupt/response, go over the response and put the pages bac=
k to
>>>> the buddy.
>>>>
>>>> (assuming that reporting a bulk of frees is better than reporting ev=
ery
>>>> single free obviously)
>>>>
>>>> This could allow nice things like "when OOM gets trigger, see if pag=
es
>>>> are currently being reported and wait until they have been put back =
to
>>>> the buddy, return "new pages available", so in a real "low on memory=
"
>>>> scenario, no OOM killer would get involved. This could address the i=
ssue
>>>> Wei had with reporting when low on memory.
>>>>
>>>> Is that something you have in mind?
>>> Yes that seems more future proof I think.
>>>
>>>> I assume we would have to allocate
>>>> memory when crafting the new requests. This is the only reason I ten=
d to
>>>> prefer a synchronous interface for now. But if allocation is not a
>>>> problem, great.
>>> There are two main ways to avoid allocation:
>>> 1. do not add extra data on top of each chunk passed
>> If I am not wrong then this is close to what we have right now.
> Yes, minus the kthread(s) and eventually with some sort of memory
> allocation for the request. Once you're asynchronous via a notification=

> mechanisnm, there is no real need for a thread anymore, hopefully.
Whether we should go with kthread or without it, I would like to do some
performance comparison before commenting on this.
>
>> One issue I see right now is that I am polling while host is freeing t=
he
>> memory.
>> In the next version I could tie the logic which returns pages to the
>> buddy and resets the per cpu array index value to 0 with the callback.=

>> (i.e.., it happens once we receive an response from the host)
> The question is, what happens when freeing pages and the array is not
> ready to be reused yet. In that case, you want to somehow continue
> freeing pages without busy waiting or eventually not reporting pages.
This is what happens right now.
Having kthread or not should not effect this behavior.
When the array is full the current approach simply skips collecting the
free pages.
>
> The callback should put the pages back to the buddy and free the reques=
t
> eventually to have a fully asynchronous mechanism.
>
>> Other change which I am testing right now is to only capture 'MAX_ORDE=
R
> I am not sure if this is an arbitrary number we came up with here. We
> should really play with different orders to find a hot spot. I wouldn't=

> consider this high priority, though. Getting the whole concept right to=

> be able to deal with any magic number we come up should be the ultimate=

> goal. (stuff that only works with huge pages I consider not future
> proof, especially regarding fragmented guests which can happen easily)
Its quite possible that when we are only capturing MAX_ORDER - 1 and run
a specific workload we don't get any memory back until we re-run the
program and buddy finally starts merging of pages of order MAX_ORDER -1.
This is why I think we may make this configurable from compile time and
keep capturing MAX_ORDER - 1 so that we don't end up breaking anything.
>
--=20
Regards
Nitesh


--osYSSeaMDvVL4bRIA1509I2G3hFewYuPz--

--p6SRatsAVeeK97o7veSepbn8svFE3w2lM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxr+v4ACgkQo4ZA3AYy
ozmbEw//XcRWG7Dbm3fWcO7L6+0GkhSA5wmaq5AFZP1T/yEuzY1Z+w7ZbmZ0vmI8
O846ikmoWDfloCL3w7fOrfGuomRsGJWVV0NmipRDxbY6OBdllqinRS0yxxRYtWuk
J82ipjpTJi+E0f8GFWq3s8Tlko6iJB1UK0dZgPp5Z6Ccy01Sk1DM9A01KSp4Nw8x
6gIeufvADD4PBbKj14pBSIlKrhMq4dJEKtoOQlT6RmvsRYpOR2E6P9hmBwqWbpOR
9jRbqvxg/Ssz9mxNEGjbYT6D8H0vGVueoVDXH+eWG7KaFljgfGOdjpDJ/GpvDhnT
2HlNyh6q7XQLu7C2sed824to8OKvumQA66Y66XTc3Ql/EaRuI+HeWypJBeaO3tq9
HfngAxhGTg7FrhJe8d15l0NxSYO9POY82EbUd5nNshYUnh0fb+uFeWLMc8OEOwup
OXoOWmQjCzih/OWgDQXbYfU8nUh8/lrVdSllbpK9Kv91/j3nlsmj3wGLEhZVqsNw
VXV94nlViYI5Mz2oe6B6OTg1w0IWRrfMWG/oyCuFpR9DN0BJVSxsH+b6q6Sa5QgL
LhQsAU9qEmMuHr8+tbFgnJpWybwhWq6N2X3kcoAAhIj+GPr6VDy1puMZT4iybg71
WccF/+vlAGYtLnON7I8daklOEyKlpinFbn9de/WPe2npQXkZoZc=
=EfnV
-----END PGP SIGNATURE-----

--p6SRatsAVeeK97o7veSepbn8svFE3w2lM--
