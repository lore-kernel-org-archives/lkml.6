Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D98C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB9120C07
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB9120C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeHVN4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:56:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbeHVN4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:56:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MASmZk011841
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:32:04 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m13spn0fm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:32:04 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 22 Aug 2018 11:32:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 11:32:00 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MAVxha32833684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 10:31:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1203352051;
        Wed, 22 Aug 2018 13:31:59 +0100 (BST)
Received: from [9.152.224.110] (unknown [9.152.224.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B4A705204F;
        Wed, 22 Aug 2018 13:31:58 +0100 (BST)
Subject: Re: [PATCH v1] KVM: s390: store DXC/VXC in fpc on
 DATA/Vector-processing exceptions
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
References: <20180822095310.29145-1-david@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date:   Wed, 22 Aug 2018 12:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822095310.29145-1-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l4bQxt9GGF8Px9Rf8rR7Qe6dO42zMoX4V"
X-TM-AS-GCONF: 00
x-cbid: 18082210-0020-0000-0000-000002BA1DAC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082210-0021-0000-0000-000021077346
Message-Id: <02f9379d-d20d-8b69-94b9-959f46490a26@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l4bQxt9GGF8Px9Rf8rR7Qe6dO42zMoX4V
Content-Type: multipart/mixed; boundary="0jNstAGar3fITyMN608yC3fb0xBQ5VF0a";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Message-ID: <02f9379d-d20d-8b69-94b9-959f46490a26@linux.ibm.com>
Subject: Re: [PATCH v1] KVM: s390: store DXC/VXC in fpc on
 DATA/Vector-processing exceptions
References: <20180822095310.29145-1-david@redhat.com>
In-Reply-To: <20180822095310.29145-1-david@redhat.com>

--0jNstAGar3fITyMN608yC3fb0xBQ5VF0a
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.08.2018 11:53, David Hildenbrand wrote:
> When DATA exceptions and vector-processing exceptions (program interrup=
ts)
> are injected, the DXC/VXC is also to be stored in the fpc, if AFP is
> enabled in CR0.
>=20
> This can happen inside KVM when reinjecting an interrupt during program=

> interrupt intercepts. These are triggered for example when debugging th=
e
> guest (concurrent PER events result in an intercept instead of an
> injection of such interrupts).
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> Only compile-tested.

It baffles me that AFP is still a thing in zArch mode. I would have
expected it to be a default 1. But then again, I just found out about it.=


POP checks out:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


>=20
>  arch/s390/include/asm/ctl_reg.h | 1 +
>  arch/s390/kvm/interrupt.c       | 8 ++++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ct=
l_reg.h
> index 4600453536c2..88f3f14baee9 100644
> --- a/arch/s390/include/asm/ctl_reg.h
> +++ b/arch/s390/include/asm/ctl_reg.h
> @@ -11,6 +11,7 @@
>  #include <linux/const.h>
> =20
>  #define CR0_CLOCK_COMPARATOR_SIGN	_BITUL(63 - 10)
> +#define CR0_AFP_REGISTER_CONTROL	_BITUL(63 - 45)
>  #define CR0_EMERGENCY_SIGNAL_SUBMASK	_BITUL(63 - 49)
>  #define CR0_EXTERNAL_CALL_SUBMASK	_BITUL(63 - 50)
>  #define CR0_CLOCK_COMPARATOR_SUBMASK	_BITUL(63 - 52)
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index fcb55b02990e..5b5754d8f460 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -765,6 +765,14 @@ static int __must_check __deliver_prog(struct kvm_=
vcpu *vcpu)
>  		break;
>  	case PGM_VECTOR_PROCESSING:
>  	case PGM_DATA:
> +		if (vcpu->arch.sie_block->gcr[0] & CR0_AFP_REGISTER_CONTROL) {
> +			/* make sure the new fpc will be lazily loaded */
> +			save_fpu_regs();
> +			/* the DXC/VXC cannot make the fpc invalid */
> +			current->thread.fpu.fpc &=3D ~0xff00u;
> +			current->thread.fpu.fpc |=3D (pgm_info.data_exc_code << 8)
> +						   & 0xff00u;

Everything except that byte should be 0 anyway when it comes from
lowcore, why do you mask?

> +		}
>  		rc =3D put_guest_lc(vcpu, pgm_info.data_exc_code,
>  				  (u32 *)__LC_DATA_EXC_CODE);
>  		break;
>=20



--0jNstAGar3fITyMN608yC3fb0xBQ5VF0a--

--l4bQxt9GGF8Px9Rf8rR7Qe6dO42zMoX4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJbfTueAAoJEBcO/8Q8ZEV5UBcP9ilVHxrfn6HY5cD1l4nmOkE0
5/mopesnG+opPNTzwr6ywc92fmqrEp+v48T4oi50IGTrPS7HSWJLyVJ2L5YAw0Jg
ba+bgnbrFCVrPJEWaWDIBrFa3/qm84MFTBmJm1d25uVmlA/pVaMRWu735XBgkoB3
Tt+aQ66FHiMXDEYvX8HrpYjA6nNMpLh15lXnRROmS9XeYFXvYq3lO8dKGA+Jk1KW
D3lyFRn6/DbUbwEpS9zOj/C5WgzZWnLjTn4SpHSIyKmi855IHsST/w5ptS8UOt7h
U/s3dEPpK07fj1M4xa5KVwIFeqjSZz5XYg+hobnOpaBPvu09ujVLbr9QBwUDXnLq
d5nr7PaUIAI1uZUspZMRRw9ApOjbHJjHNLsror5nef26YdX5hP/1fXebP9ZIRb1T
pgUWVRZVd0MeVWQVg26jbFr1e2ZQPdQqts0uJQn2StjRLkk2LDnQDNMqp4tz0G2o
PAl45ABZj1oxdXjyvPnzCh/2u+Ktp/9GXpLk5X6+ZB9lVuKIf5npUE9JZnMXns/P
c4uMKCYrUKjXsJ331Jw+ttCVHGOi+7IyuQpM7HSPDwlEgxFh8Q1LDEnxWfnZaRZS
NGDCcSV7WrwoeR5OYDk2yPt1aE5P3PF1cecQVnYCcSlLCOw+RCVZwrGk+YWmFWpN
jwV+YmP043wz/HXHDTM=
=JTGO
-----END PGP SIGNATURE-----

--l4bQxt9GGF8Px9Rf8rR7Qe6dO42zMoX4V--

