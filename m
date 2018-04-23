Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeDWGSs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:18:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751268AbeDWGSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:18:42 -0400
Subject: Re: [PATCH v2] KVM: s390: reset crypto attributes for all vcpus
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: rkrcmar@redhat.com, borntraeger@de.ibm.com, david@redhat.com,
        cohuck@redhat.com, pbonzini@redhat.com, pmorel@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com
References: <1524411423-18607-1-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date: Mon, 23 Apr 2018 08:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524411423-18607-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="siUMOUf8pPKFDDloiQ8bqiZWo9WzMbwO3"
X-TM-AS-GCONF: 00
x-cbid: 18042306-0040-0000-0000-000004506023
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042306-0041-0000-0000-000020F4C4DC
Message-Id: <55a601d8-8d36-4bd3-ae86-de1134d37d68@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--siUMOUf8pPKFDDloiQ8bqiZWo9WzMbwO3
Content-Type: multipart/mixed; boundary="7tFJlKXxNrUrepQIN7REdBkzahNc9OKrB";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: rkrcmar@redhat.com, borntraeger@de.ibm.com, david@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, pmorel@linux.vnet.ibm.com,
 pasic@linux.vnet.ibm.com
Message-ID: <55a601d8-8d36-4bd3-ae86-de1134d37d68@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: reset crypto attributes for all vcpus
References: <1524411423-18607-1-git-send-email-akrowiak@linux.vnet.ibm.com>
In-Reply-To: <1524411423-18607-1-git-send-email-akrowiak@linux.vnet.ibm.com>

--7tFJlKXxNrUrepQIN7REdBkzahNc9OKrB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.04.2018 17:37, Tony Krowiak wrote:
> Introduces a new function to reset the crypto attributes for all
> vcpus whether they are running or not. Each vcpu in KVM will
> be removed from SIE prior to resetting the crypto attributes in its
> SIE state description. After all vcpus have had their crypto attributes=

> reset the vcpus will be restored to SIE.
>=20
> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
> function to fix a reported issue whereby the crypto key wrapping
> attributes could potentially get out of synch for running vcpus.

And this time for real: Thanks, applied


>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
> v2 Changes:
> Fixed compile error, kvm_s390_vcpu_crypto_setup before declaration
>=20
>  arch/s390/kvm/kvm-s390.c |   17 ++++++++++++-----
>  arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>  2 files changed, 25 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fa355a6..e629ae1 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -791,11 +791,21 @@ static int kvm_s390_set_mem_control(struct kvm *k=
vm, struct kvm_device_attr *att
> =20
>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
> =20
> -static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_a=
ttr *attr)
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>  {
>  	struct kvm_vcpu *vcpu;
>  	int i;
> =20
> +	kvm_s390_vcpu_block_all(kvm);
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_s390_vcpu_crypto_setup(vcpu);
> +
> +	kvm_s390_vcpu_unblock_all(kvm);
> +}
> +
> +static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_a=
ttr *attr)
> +{
>  	if (!test_kvm_facility(kvm, 76))
>  		return -EINVAL;
> =20
> @@ -832,10 +842,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm,=
 struct kvm_device_attr *attr)
>  		return -ENXIO;
>  	}
> =20
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		kvm_s390_vcpu_crypto_setup(vcpu);
> -		exit_sie(vcpu);
> -	}
> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>  	mutex_unlock(&kvm->lock);
>  	return 0;
>  }
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 1b5621f..981e3ba 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -410,4 +410,17 @@ static inline int kvm_s390_use_sca_entries(void)
>  }
>  void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>  				     struct mcck_volatile_info *mcck_info);
> +
> +/**
> + * kvm_s390_vcpu_crypto_reset_all
> + *
> + * Reset the crypto attributes for each vcpu. This can be done while t=
he vcpus
> + * are running as each vcpu will be removed from SIE before resetting =
the crypt
> + * attributes and restored to SIE afterward.
> + *
> + * Note: The kvm->lock must be held while calling this function
> + *
> + * @kvm: the KVM guest
> + */
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>  #endif
>=20



--7tFJlKXxNrUrepQIN7REdBkzahNc9OKrB--

--siUMOUf8pPKFDDloiQ8bqiZWo9WzMbwO3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJa3Xq5AAoJEBcO/8Q8ZEV5oUcP+PD37x95pF3J6ls3+gB8vvP0
EnEnhLVgVp8Thx0qK/u/ekIzGFE2anu5n6ARJ3oxPggY9FS+VpPpwAu/JFLs/wl9
QDxlRkiokDe5rew54yg6S735D/YhI6rwuSF2ieyoe/2NEVpE+x5iUIcJ7XkJ6ctW
BeTXJEZzEf0T7VmMPD63B95cerZFudTaQfi6Da9EkQtxvJyH5FfEKIsbLU+s9KIz
/wEc5uwfNP1MJkaaul88TegZY0LG0+HB9vKeYdngoPXgyjAopeunwHxwHTBXHxmg
xvNeOGcjYrJ0AlWrprK1ui6FPNth8e8pUceG0aXyuwxNT/QysKdc5BCZ89sYNWwV
DzqYgftBv7HCdpS9VFFKEdmeMdMfiWYG7vVGk/j51VZ5wZj2UXSjEZ3yETnKz00C
LcCEu9Xzs3RRuevZsr+UoV036HPPyWSvsCYW77EbYRsgsRlrHqsnIMWuzRAu7pJ+
5IDcZK8GbDy0nTsysewZrEDCdHMcasWDmHMmQCPkyQXF3oAI3VUk05cAVQkvJMTp
kNg8mYuUiPeq/1IjwmmrZpATfeSM2PXrT0oUF7mlT9iD+SZYKzShao//JzZ6f28V
6/ImUTCqM1CaU//DO/eeUJI8s4NnxFCFRDxoqVYVbcMLhd3mzXB5NPY0+5QxaEkX
UfgAR7FEze/1MTSuqW8=
=f84s
-----END PGP SIGNATURE-----

--siUMOUf8pPKFDDloiQ8bqiZWo9WzMbwO3--
