Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jXDPC8JhHlttSAAAmS7hNA
	; Mon, 11 Jun 2018 11:50:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A9BDB60541; Mon, 11 Jun 2018 11:50:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2A21D60541;
	Mon, 11 Jun 2018 11:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A21D60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeFKLuA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:50:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932940AbeFKLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:49:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BBn8qf134512
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 07:49:53 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jhp6s6h2a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 07:49:53 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 11 Jun 2018 12:49:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 12:49:46 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5BBnjtV22741124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 11:49:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAB72AE045;
        Mon, 11 Jun 2018 12:38:37 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0F6FAE051;
        Mon, 11 Jun 2018 12:38:36 +0100 (BST)
Received: from [9.152.224.155] (unknown [9.152.224.155])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 12:38:36 +0100 (BST)
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
To: Halil Pasic <pasic@linux.ibm.com>, pmorel@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Janosch Frank <frankja@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
 <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
 <8f68183d-8385-8025-1898-23cad604ae94@linux.vnet.ibm.com>
 <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
 <d6455b0b-804f-b58e-41bc-83731979911a@linux.ibm.com>
 <f74f2d2d-36d3-7910-5511-3691a483b89f@linux.vnet.ibm.com>
 <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
 <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
 <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
 <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
 <010679ed-bd80-42f8-3f6f-e4dee10e82f5@linux.ibm.com>
 <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date: Mon, 11 Jun 2018 13:49:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p5WSB1KGON5tNXD1JZuJXkKMiYD44HYdo"
X-TM-AS-GCONF: 00
x-cbid: 18061111-0028-0000-0000-000002CF822F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061111-0029-0000-0000-00002386985C
Message-Id: <dd81f313-a8c2-bf2a-da4c-4669db170401@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=973 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p5WSB1KGON5tNXD1JZuJXkKMiYD44HYdo
Content-Type: multipart/mixed; boundary="0bQrGcgO62KKUu7NthEmnKLGUSMRsJ8rm";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>, pmorel@linux.ibm.com,
 Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
 bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
 alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
 jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
 berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
 Janosch Frank <frankja@linux.vnet.ibm.com>
Message-ID: <dd81f313-a8c2-bf2a-da4c-4669db170401@linux.ibm.com>
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
 <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
 <8f68183d-8385-8025-1898-23cad604ae94@linux.vnet.ibm.com>
 <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
 <d6455b0b-804f-b58e-41bc-83731979911a@linux.ibm.com>
 <f74f2d2d-36d3-7910-5511-3691a483b89f@linux.vnet.ibm.com>
 <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
 <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
 <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
 <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
 <010679ed-bd80-42f8-3f6f-e4dee10e82f5@linux.ibm.com>
 <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>
In-Reply-To: <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>

--0bQrGcgO62KKUu7NthEmnKLGUSMRsJ8rm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.06.2018 13:32, Halil Pasic wrote:
>=20
>=20
> On 06/11/2018 11:23 AM, Pierre Morel wrote:
>> On 08/06/2018 23:59, Tony Krowiak wrote:
>>> On 06/07/2018 01:15 PM, Pierre Morel wrote:
>>>>
>>
>> ...snip...
>>
>>>>>>
>>>>>>>
>>>>>>> Why maintain a list of kvm_ap_matrix structures if we don't have =
to; it is stored
>>>>>>> with the mediated matrix device which is passed in to all of the =
vfio_ap driver
>>>>>>> callbacks.
>>>>>>
>>>>>> Because using the vm_list which is a static in kvm makes you stick=
 inside the kvm code.
>>>
>>> I understand your point here, but even if we did maintain a list of k=
vm_ap_matrix structures,
>>> we still need the kvm code to configure the guest's CRYCB and eventua=
lly ECA.28. There is
>>> also code in kvm-ap.c that is called from KVM.
>>
>> The only code from kvm-ap which is called from KVM is temporary code
>> waiting for Harald to offer the clean interface to AP instructions.
>>
>>> The idea behind kvm-ap.c is that all code
>>> related to configuration of AP structures in KVM is in this one spot.=

>>
>> This I understand, but the code can be in one spot inside VFIO_AP inst=
ead
>> of inside KVM.
>> Putting the code inside KVM induce dependencies between KVM and AP
>> while the kvm/vfio interface allows to avoid this dependency.
>>
>> The purpose of VFIO_AP is to handle the CRYCB, all get/clear/set crycb=
 masks
>> functions should be in VFIO AP.
>>
>> If we use wrappers in KVM, since the CRYCB is an a SIE extension,
>> it is legitimate, the KVM interface to the CRYCB should only
>> handle bitmaps and be unaware of the vfio_ap internal structures.

Yes, please!

>>
>> Another concern, the kvm_ap_validate_queue_sharing() should not be
>> inside KVM because it is a decision of current VFIO_AP driver
>> to not share the queues between guest of level 2.
>>
>> The Z architecture does not allow to share AP queues between
>> guests of level 1 but we could re-engineer the AP bus and the '
>> VFIO AP to offer queue sharing for guest level 2.
>>
>> This would be a new VFIO_AP driver (and an AP bus extension).
>> We should not have to change KVM for this.
>>
>=20
>=20
> Pierre's proposal makes a lot of sense to me. We would not need to take=

> the kvm_lock (which we need to traverse the vm_list safely) for the
> validation, and we could have immediate validation (which is in my opin=
ion
> better).

Please do not use the kvm_lock if possible.

>=20
> Also your refcount (which is not a refcout) could go away. You simply
> traverse your list and check for duplicates when hooking up the mdev
> with KVM.
>=20
> And my opinion is if we don't have to add code to the kvm module we
> better not.
>=20
> @Janosch: Does core KVM share my opinion?

At least I do.

KVM does not care about who has which crypto queue/card.
I'd like to have a driver that does internal bookkeeping and then
registers the crycb with KVM, so the VM can use it.

>=20
> Regards,
> Halil
>=20



--0bQrGcgO62KKUu7NthEmnKLGUSMRsJ8rm--

--p5WSB1KGON5tNXD1JZuJXkKMiYD44HYdo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbHmHYAAoJEBcO/8Q8ZEV5AS4QAIwpHJh6L9SUp6BQhM5Sz1iN
uA8Gz3HJ8mg7zr7EJg3ExIejQlgCG9kjVwDDZcGOIyEltPD7CuCznrXZh24gq+bv
w/uqo5XAeuUCFWSffPRHJLqRu7pUxcPYT1a7z2h6PqC6RV7L1ndiXtMZx5enYC5D
Kath9KuFaPGZ6xHP73ms9i4BU7STsFbKxZXBFlDosUBk+e2nSdCh/zV1sTlv8B16
TgrvSqpkhIkLOf8+63tvZDnejg/iIlTmQQf4kA8hDQIXY1v9gyyanabsz5qlP3r/
o13fAxd1a/qfUkWN0H+skPv37ngWcALvm/1lsY9XCvkmioe49BSt3jeMe1LG+oT8
Dm1GaPrQ3gTtl7K2tUj7l9+OFihCBJFnhtDDERVXlDD6Hp9qnF2PrjyVYvmBHyPh
xBTyQ5V91PZc++8OqZb/nOyifxteso8qgwiOK3NJKVmj7wZFXPSpX8uxDYP16x+H
m0BCPPswiAed3DQjk7+n2ga7mHEb4zoCSAYUzwqQhFkdqKwzYMW5aYO4xhQW0wi7
C2oL9Ke7FgXaNIY1Hs9nEFB5M5hFpKqwtWAYk4f25gvorfG+rGAhwKBPQQSShCRr
77M9T3+ycLpGEOQh7wTZGeG2SmmzYgnC8gTnJ5tz57jWbHplxt8BGlLg35aJ1Tmk
/R8ew/jcll6tDwF2yA2/
=UnoK
-----END PGP SIGNATURE-----

--p5WSB1KGON5tNXD1JZuJXkKMiYD44HYdo--
