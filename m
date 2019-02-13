Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54093222AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbfBMMG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:06:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfBMMG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:06:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 648AC420A6;
        Wed, 13 Feb 2019 12:06:54 +0000 (UTC)
Received: from [10.40.205.148] (unknown [10.40.205.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E64B05C226;
        Wed, 13 Feb 2019 12:06:36 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     "Wang, Wei W" <wei.w.wang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "david@redhat.com" <david@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B56A@shsmsx102.ccr.corp.intel.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <f9516222-793a-a169-c18a-728ca0256cd3@redhat.com>
Date:   Wed, 13 Feb 2019 07:06:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <286AC319A985734F985F78AFA26841F73DF6B56A@shsmsx102.ccr.corp.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wJpfxsrk2Gr0YRZLQdbt08sQsMIednBHY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 13 Feb 2019 12:06:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wJpfxsrk2Gr0YRZLQdbt08sQsMIednBHY
Content-Type: multipart/mixed; boundary="PLnnUTd4vEqoEphvcp8R9SJ7Y1kub4KsV";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
 "pagupta@redhat.com" <pagupta@redhat.com>,
 "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
 "riel@surriel.com" <riel@surriel.com>, "david@redhat.com"
 <david@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "dodgen@google.com" <dodgen@google.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dhildenb@redhat.com" <dhildenb@redhat.com>,
 "aarcange@redhat.com" <aarcange@redhat.com>
Message-ID: <f9516222-793a-a169-c18a-728ca0256cd3@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B56A@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <286AC319A985734F985F78AFA26841F73DF6B56A@shsmsx102.ccr.corp.intel.com>

--PLnnUTd4vEqoEphvcp8R9SJ7Y1kub4KsV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/13/19 4:00 AM, Wang, Wei W wrote:
> On Tuesday, February 5, 2019 4:19 AM, Nitesh Narayan Lal wrote:
>> The following patch-set proposes an efficient mechanism for handing fr=
eed
>> memory between the guest and the host. It enables the guests with no p=
age
>> cache to rapidly free and reclaims memory to and from the host respect=
ively.
>>
>> Benefit:
>> With this patch-series, in our test-case, executed on a single system =
and
>> single NUMA node with 15GB memory, we were able to successfully launch=

>> atleast 5 guests when page hinting was enabled and 3 without it. (Deta=
iled
>> explanation of the test procedure is provided at the bottom).
>>
>> Changelog in V8:
>> In this patch-series, the earlier approach [1] which was used to captu=
re and
>> scan the pages freed by the guest has been changed. The new approach i=
s
>> briefly described below:
>>
>> The patch-set still leverages the existing arch_free_page() to add thi=
s
>> functionality. It maintains a per CPU array which is used to store the=
 pages
>> freed by the guest. The maximum number of entries which it can hold is=

>> defined by MAX_FGPT_ENTRIES(1000). When the array is completely filled=
, it
>> is scanned and only the pages which are available in the buddy are sto=
red.
>> This process continues until the array is filled with pages which are =
part of
>> the buddy free list. After which it wakes up a kernel per-cpu-thread.
>> This kernel per-cpu-thread rescans the per-cpu-array for any re-alloca=
tion
>> and if the page is not reallocated and present in the buddy, the kerne=
l
>> thread attempts to isolate it from the buddy. If it is successfully is=
olated, the
>> page is added to another per-cpu array. Once the entire scanning proce=
ss is
>> complete, all the isolated pages are reported to the host through an e=
xisting
>> virtio-balloon driver.
> The free page is removed from the buddy list here. When will they get r=
eturned to the buddy list so that the guest threads can use them normally=
?
Once the host free the pages. All the isolated pages are returned back
to the buddy. (This is implemented in hyperlist_ready())
>
> Best,
> Wei
--=20
Regards
Nitesh


--PLnnUTd4vEqoEphvcp8R9SJ7Y1kub4KsV--

--wJpfxsrk2Gr0YRZLQdbt08sQsMIednBHY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxkCEkACgkQo4ZA3AYy
oznBvw/+NpAiojgFLOk9fG0ZODJzn93xztizMxiSRXuQAMRkpAmC8h4Ld2X2ZWtd
DTMHQg2FLNDDY20pPV1DFsJcVHnWk69V49mCLcsZ4KXjrVi8n7Wncr0ZXOsSoJB+
0z1lRXHwhLwF/XZQLlV2uJtwgMUE1BnkVrlDRUpt9eZ4DYinPJwR0TD2fuSfoeaD
fXVQavXp29XVDKP9Wk8pBvSa8ErYj4iR5zFVMtdOmC5Z/MkegIl8SaNHMoxGRVJX
4zroO7HxtFG70wSxyAg2p9i+S+jU/2Wcpcv8iHOq7FLzgoo8pYaKo4naIRl4JBl2
YnufdS4iSLAzdsA2a6iRzU0MKfmcDmxxiea3mma57YT9Qms8KM/v5LUyevXZ9S20
l6TX4utQCQXTHpG4OTxDp9UN5+lY2Is4DNilo5qrd37LQC1oQjbEkrJ0iHVdHY8x
EzE0nOJNfw1bqAk6qzawUtUuQrJiU6e59ggiMzPN+98nlTP+ShcmQ9GVnSIzmz3A
hM3Q4t2MSFfjYsgTwAo1YOAuxhHbKPIxEtxpEtjkkOnwrpq8wTY6mZA73WSAUsn5
gYIhulyNnc2ddJWqdPk9b0dRoBEPwNqqLCkp+RsETxzyWKMsYlaSGygmq/hIl8OO
BcYTJLAvIa7xikYqbVndySFNQeCNEfAdKFwGb49tckFkR4oh2z0=
=jfjl
-----END PGP SIGNATURE-----

--wJpfxsrk2Gr0YRZLQdbt08sQsMIednBHY--
