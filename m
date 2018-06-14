Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A7CD5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506B8208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="anGatiq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506B8208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965149AbeFNXkc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:40:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48780 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965031AbeFNXka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:40:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5ENdpO4150106;
        Thu, 14 Jun 2018 23:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=BF9BPGgLgmM4WWI7UP4UCodlcGl+hvZLZIT/8jdv5nM=;
 b=anGatiq1YFojKlXL70mc0OzRcfOHACy2thDaE/UMiZ/fj+VUEPL2oEySKok7Uvdi2WW4
 iT8bnQxyolPheARbele0HpJAlI4L/8o9yDpks89fvRWiFC12N3b3FGLxjSmZnjtd+cnk
 o+x/pCCYmeASkpC+fqhA41hVWj15+YGqQgk4ntLpXKD/0pPM4ojzN+y2gwVfzq84bWPh
 DhxebOm532yWQYII9U/l3ZPBaoRVEinxuYA6IrUJTgOhhBoQRIHVFLiOJ0QOTgYqclWN
 rqCAyUrSeh7gTqgRhoCpqSl49UE68Z+92HsDiclF/laRxchF0H/kmtOu4X9D2ZZpQTGh mA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jk0xrq05j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 23:40:14 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5ENeCbA023884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 23:40:13 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5ENeCLe015926;
        Thu, 14 Jun 2018 23:40:12 GMT
MIME-Version: 1.0
Message-ID: <efe3a337-efe0-4d40-a50b-216406fdadc7@default>
Date:   Thu, 14 Jun 2018 16:40:12 -0700 (PDT)
From:   Liran Alon <liran.alon@oracle.com>
To:     <vkuznets@redhat.com>
Cc:     <mmorsy@redhat.com>, <rkagan@virtuozzo.com>, <jmattson@google.com>,
        <Michael.H.Kelley@microsoft.com>, <kys@microsoft.com>,
        <rkrcmar@redhat.com>, <cavery@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <sthemmin@microsoft.com>,
        <haiyangz@microsoft.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/5] KVM: hyperv: define VP assist page helpers
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- vkuznets@redhat.com wrote:

> From: Ladi Prosek <lprosek@redhat.com>
>=20
> The state related to the VP assist page is still managed by the LAPIC
> code in the pv_eoi field.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 23 +++++++++++++++++++++--
>  arch/x86/kvm/hyperv.h |  4 ++++
>  arch/x86/kvm/lapic.c  |  4 ++--
>  arch/x86/kvm/lapic.h  |  2 +-
>  arch/x86/kvm/x86.c    |  2 +-
>  5 files changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 14e0d0ae4e0a..fdf659ca6167 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -688,6 +688,24 @@ void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)
>  =09=09stimer_cleanup(&hv_vcpu->stimer[i]);
>  }
> =20
> +bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu)
> +{
> +=09if (!(vcpu->arch.hyperv.hv_vapic &
> HV_X64_MSR_VP_ASSIST_PAGE_ENABLE))
> +=09=09return false;
> +=09return vcpu->arch.pv_eoi.msr_val & KVM_MSR_ENABLED;
> +}
> +EXPORT_SYMBOL_GPL(kvm_hv_assist_page_enabled);
> +
> +bool kvm_hv_get_assist_page(struct kvm_vcpu *vcpu,
> +=09=09=09    struct hv_vp_assist_page *assist_page)
> +{
> +=09if (!kvm_hv_assist_page_enabled(vcpu))
> +=09=09return false;
> +=09return !kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data,
> +=09=09=09=09      assist_page, sizeof(*assist_page));
> +}
> +EXPORT_SYMBOL_GPL(kvm_hv_get_assist_page);
> +
>  static void stimer_prepare_msg(struct kvm_vcpu_hv_stimer *stimer)
>  {
>  =09struct hv_message *msg =3D &stimer->msg;
> @@ -1048,7 +1066,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu,
> u32 msr, u64 data, bool host)
> =20
>  =09=09if (!(data & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE)) {
>  =09=09=09hv->hv_vapic =3D data;
> -=09=09=09if (kvm_lapic_enable_pv_eoi(vcpu, 0))
> +=09=09=09if (kvm_lapic_enable_pv_eoi(vcpu, 0, 0))
>  =09=09=09=09return 1;
>  =09=09=09break;
>  =09=09}
> @@ -1061,7 +1079,8 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu,
> u32 msr, u64 data, bool host)
>  =09=09hv->hv_vapic =3D data;
>  =09=09kvm_vcpu_mark_page_dirty(vcpu, gfn);
>  =09=09if (kvm_lapic_enable_pv_eoi(vcpu,
> -=09=09=09=09=09    gfn_to_gpa(gfn) | KVM_MSR_ENABLED))
> +=09=09=09=09=09    gfn_to_gpa(gfn) | KVM_MSR_ENABLED,
> +=09=09=09=09=09    sizeof(struct hv_vp_assist_page)))
>  =09=09=09return 1;
>  =09=09break;
>  =09}
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 837465d69c6d..db825bb7efc7 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -62,6 +62,10 @@ void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu);
>  void kvm_hv_vcpu_postcreate(struct kvm_vcpu *vcpu);
>  void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu);
> =20
> +bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu);
> +bool kvm_hv_get_assist_page(struct kvm_vcpu *vcpu,
> +=09=09=09    struct hv_vp_assist_page *assist_page);
> +
>  static inline struct kvm_vcpu_hv_stimer *vcpu_to_stimer(struct
> kvm_vcpu *vcpu,
>  =09=09=09=09=09=09=09int timer_index)
>  {
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 776391cf69a5..b6d6a36f1a33 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2540,7 +2540,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu,
> u32 reg, u64 *data)
>  =09return 0;
>  }
> =20
> -int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data)
> +int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned
> long len)
>  {
>  =09u64 addr =3D data & ~KVM_MSR_ENABLED;
>  =09if (!IS_ALIGNED(addr, 4))
> @@ -2550,7 +2550,7 @@ int kvm_lapic_enable_pv_eoi(struct kvm_vcpu
> *vcpu, u64 data)
>  =09if (!pv_eoi_enabled(vcpu))
>  =09=09return 0;
>  =09return kvm_gfn_to_hva_cache_init(vcpu->kvm,
> &vcpu->arch.pv_eoi.data,
> -=09=09=09=09=09 addr, sizeof(u8));
> +=09=09=09=09=09 addr, len);
>  }
> =20
>  void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index ed0ed39abd36..ff6ef9c3d760 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -120,7 +120,7 @@ static inline bool
> kvm_hv_vapic_assist_page_enabled(struct kvm_vcpu *vcpu)
>  =09return vcpu->arch.hyperv.hv_vapic &
> HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
>  }
> =20
> -int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data);
> +int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned
> long len);
>  void kvm_lapic_init(void);
>  void kvm_lapic_exit(void);
> =20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 06dd4cdb2ca8..a57766b940a5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2442,7 +2442,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu,
> struct msr_data *msr_info)
> =20
>  =09=09break;
>  =09case MSR_KVM_PV_EOI_EN:
> -=09=09if (kvm_lapic_enable_pv_eoi(vcpu, data))
> +=09=09if (kvm_lapic_enable_pv_eoi(vcpu, data, sizeof(u8)))
>  =09=09=09return 1;
>  =09=09break;
> =20
> --=20
> 2.14.4

Reviewed-By: Liran Alon <liran.alon@oracle.com>
