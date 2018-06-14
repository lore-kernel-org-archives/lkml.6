Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BED84C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBA0208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VNpXl7PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBA0208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965113AbeFNW7B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:59:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52438 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965006AbeFNW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:58:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EMseCj060712;
        Thu, 14 Jun 2018 22:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=Ua8LaoEj+JFWy2U6Ax73/afU6To0x4Tfu0DwAY+2R54=;
 b=VNpXl7PTfQydTx1UC9GHArd02UGVH35WfDOA4orpq35M5iTdaRkZfcaee/gHOg4+vBei
 BjoQHEXZmzw+eYA+nW8VnzzrW9f0vodVcsoiuMJoxGLtRkwKZce/grgfd/xIu0lzghLW
 gT01mSu/YaL/Ft7lxSoBEPVfcCNUsVYWJWzZuG8xa3EqJzWmqfKJNkj83hiPosq2l14z
 L1/gOleb/4lKPnuOunfrKMKyqPTwqu1KeFlV/+QL0p34ZEF6KUX5owHee++7iWtG+/2o
 vosS5DM7hsO+FxhvyeN3xhVviLhhSQBBV1lngKCpiz/2X/pdDtG8A3T+hj044UMJewSV yg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jk0xrexqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 22:58:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5EMwfGw014877
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 22:58:41 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5EMweKV030696;
        Thu, 14 Jun 2018 22:58:40 GMT
MIME-Version: 1.0
Message-ID: <b569a42b-605e-45e0-b292-5aeddfee80ad@default>
Date:   Thu, 14 Jun 2018 15:58:40 -0700 (PDT)
From:   Liran Alon <liran.alon@oracle.com>
To:     <vkuznets@redhat.com>
Cc:     <mmorsy@redhat.com>, <rkagan@virtuozzo.com>, <jmattson@google.com>,
        <Michael.H.Kelley@microsoft.com>, <kys@microsoft.com>,
        <rkrcmar@redhat.com>, <cavery@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <sthemmin@microsoft.com>,
        <haiyangz@microsoft.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/5] KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS
 capability
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- vkuznets@redhat.com wrote:

> Enlightened VMCS is opt-in. The current version does not contain all
> fields supported by nested VMX so we must not advertise the
> corresponding VMX features if enlightened VMCS is enabled.
>=20
> Userspace is given the enlightened VMCS version supported by KVM as
> part of enabling KVM_CAP_HYPERV_ENLIGHTENED_VMCS. The version is to
> be advertised to the nested hypervisor, currently done via a cpuid
> leaf for Hyper-V.
>=20
> Suggested-by: Ladi Prosek <lprosek@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |   3 +
>  arch/x86/kvm/svm.c              |   9 +++
>  arch/x86/kvm/vmx.c              | 138
> ++++++++++++++++++++++------------------
>  arch/x86/kvm/x86.c              |  15 +++++
>  include/uapi/linux/kvm.h        |   1 +
>  5 files changed, 105 insertions(+), 61 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/kvm_host.h
> b/arch/x86/include/asm/kvm_host.h
> index 0ebe659f2802..d7e8f7155d79 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1095,6 +1095,9 @@ struct kvm_x86_ops {
>  =09int (*mem_enc_unreg_region)(struct kvm *kvm, struct kvm_enc_region
> *argp);
> =20
>  =09int (*get_msr_feature)(struct kvm_msr_entry *entry);
> +
> +=09int (*nested_enable_evmcs)(struct kvm_vcpu *vcpu,
> +=09=09=09=09   uint16_t *vmcs_version);
>  };
> =20
>  struct kvm_arch_async_pf {
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index d9305f1723f5..6dc42c870565 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -7009,6 +7009,13 @@ static int svm_unregister_enc_region(struct kvm
> *kvm,
>  =09return ret;
>  }
> =20
> +static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
> +=09=09=09=09   uint16_t *vmcs_version)
> +{
> +=09/* Intel-only feature */
> +=09return -ENODEV;
> +}
> +
>  static struct kvm_x86_ops svm_x86_ops __ro_after_init =3D {
>  =09.cpu_has_kvm_support =3D has_svm,
>  =09.disabled_by_bios =3D is_disabled,
> @@ -7135,6 +7142,8 @@ static struct kvm_x86_ops svm_x86_ops
> __ro_after_init =3D {
>  =09.mem_enc_op =3D svm_mem_enc_op,
>  =09.mem_enc_reg_region =3D svm_register_enc_region,
>  =09.mem_enc_unreg_region =3D svm_unregister_enc_region,
> +
> +=09.nested_enable_evmcs =3D nested_enable_evmcs,
>  };
> =20
>  static int __init svm_init(void)
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 48989f78be60..51749207cef1 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -648,6 +648,13 @@ struct nested_vmx {
> =20
>  =09bool change_vmcs01_virtual_apic_mode;
> =20
> +=09/*
> +=09 * Enlightened VMCS has been enabled. It does not mean that L1 has
> to
> +=09 * use it. However, VMX features available to L1 will be limited
> based
> +=09 * on what the enlightened VMCS supports.
> +=09 */
> +=09bool enlightened_vmcs_enabled;
> +
>  =09/* L2 must run next, and mustn't decide to exit to L1. */
>  =09bool nested_run_pending;
> =20
> @@ -1186,6 +1193,49 @@ DEFINE_STATIC_KEY_FALSE(enable_evmcs);
> =20
>  #define KVM_EVMCS_VERSION 1
> =20
> +/*
> + * Enlightened VMCSv1 doesn't support these:
> + *
> + *=09POSTED_INTR_NV                  =3D 0x00000002,
> + *=09GUEST_INTR_STATUS               =3D 0x00000810,
> + *=09APIC_ACCESS_ADDR=09=09=3D 0x00002014,
> + *=09POSTED_INTR_DESC_ADDR           =3D 0x00002016,
> + *=09EOI_EXIT_BITMAP0                =3D 0x0000201c,
> + *=09EOI_EXIT_BITMAP1                =3D 0x0000201e,
> + *=09EOI_EXIT_BITMAP2                =3D 0x00002020,
> + *=09EOI_EXIT_BITMAP3                =3D 0x00002022,
> + *=09GUEST_PML_INDEX=09=09=09=3D 0x00000812,
> + *=09PML_ADDRESS=09=09=09=3D 0x0000200e,
> + *=09VM_FUNCTION_CONTROL             =3D 0x00002018,
> + *=09EPTP_LIST_ADDRESS               =3D 0x00002024,
> + *=09VMREAD_BITMAP                   =3D 0x00002026,
> + *=09VMWRITE_BITMAP                  =3D 0x00002028,
> + *
> + *=09TSC_MULTIPLIER                  =3D 0x00002032,
> + *=09PLE_GAP                         =3D 0x00004020,
> + *=09PLE_WINDOW                      =3D 0x00004022,
> + *=09VMX_PREEMPTION_TIMER_VALUE      =3D 0x0000482E,
> + *      GUEST_IA32_PERF_GLOBAL_CTRL     =3D 0x00002808,
> + *      HOST_IA32_PERF_GLOBAL_CTRL      =3D 0x00002c04,
> + *
> + * Currently unsupported in KVM:
> + *=09GUEST_IA32_RTIT_CTL=09=09=3D 0x00002814,
> + */
> +#define EVMCS1_UNSUPPORTED_PINCTRL (PIN_BASED_POSTED_INTR | \
> +=09=09=09=09    PIN_BASED_VMX_PREEMPTION_TIMER)
> +#define EVMCS1_UNSUPPORTED_2NDEXEC=09=09=09=09=09\
> +=09(SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |=09=09=09=09\
> +=09 SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |=09=09=09\
> +=09 SECONDARY_EXEC_APIC_REGISTER_VIRT |=09=09=09=09\
> +=09 SECONDARY_EXEC_ENABLE_PML |=09=09=09=09=09\
> +=09 SECONDARY_EXEC_ENABLE_VMFUNC |=09=09=09=09=09\
> +=09 SECONDARY_EXEC_SHADOW_VMCS |=09=09=09=09=09\
> +=09 SECONDARY_EXEC_TSC_SCALING |=09=09=09=09=09\
> +=09 SECONDARY_EXEC_PAUSE_LOOP_EXITING)
> +#define EVMCS1_UNSUPPORTED_VMEXIT_CTRL
> (VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
> +#define EVMCS1_UNSUPPORTED_VMENTRY_CTRL
> (VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)
> +#define EVMCS1_UNSUPPORTED_VMFUNC (VMX_VMFUNC_EPTP_SWITCHING)
> +
>  #if IS_ENABLED(CONFIG_HYPERV)
>  static bool __read_mostly enlightened_vmcs =3D true;
>  module_param(enlightened_vmcs, bool, 0444);
> @@ -1278,69 +1328,12 @@ static void evmcs_load(u64 phys_addr)
> =20
>  static void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
>  {
> -=09/*
> -=09 * Enlightened VMCSv1 doesn't support these:
> -=09 *
> -=09 *=09POSTED_INTR_NV                  =3D 0x00000002,
> -=09 *=09GUEST_INTR_STATUS               =3D 0x00000810,
> -=09 *=09APIC_ACCESS_ADDR=09=09=3D 0x00002014,
> -=09 *=09POSTED_INTR_DESC_ADDR           =3D 0x00002016,
> -=09 *=09EOI_EXIT_BITMAP0                =3D 0x0000201c,
> -=09 *=09EOI_EXIT_BITMAP1                =3D 0x0000201e,
> -=09 *=09EOI_EXIT_BITMAP2                =3D 0x00002020,
> -=09 *=09EOI_EXIT_BITMAP3                =3D 0x00002022,
> -=09 */
> -=09vmcs_conf->pin_based_exec_ctrl &=3D ~PIN_BASED_POSTED_INTR;
> -=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D
> -=09=09~SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
> -=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D
> -=09=09~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
> -=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D
> -=09=09~SECONDARY_EXEC_APIC_REGISTER_VIRT;
> -
> -=09/*
> -=09 *=09GUEST_PML_INDEX=09=09=09=3D 0x00000812,
> -=09 *=09PML_ADDRESS=09=09=09=3D 0x0000200e,
> -=09 */
> -=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D ~SECONDARY_EXEC_ENABLE_PML;
> +=09vmcs_conf->pin_based_exec_ctrl &=3D ~EVMCS1_UNSUPPORTED_PINCTRL;
> +=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D ~EVMCS1_UNSUPPORTED_2NDEXEC;
> =20
> -=09/*=09VM_FUNCTION_CONTROL             =3D 0x00002018, */
> -=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D
> ~SECONDARY_EXEC_ENABLE_VMFUNC;
> +=09vmcs_conf->vmexit_ctrl &=3D ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
> +=09vmcs_conf->vmentry_ctrl &=3D ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
> =20
> -=09/*
> -=09 *=09EPTP_LIST_ADDRESS               =3D 0x00002024,
> -=09 *=09VMREAD_BITMAP                   =3D 0x00002026,
> -=09 *=09VMWRITE_BITMAP                  =3D 0x00002028,
> -=09 */
> -=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D ~SECONDARY_EXEC_SHADOW_VMCS;
> -
> -=09/*
> -=09 *=09TSC_MULTIPLIER                  =3D 0x00002032,
> -=09 */
> -=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D ~SECONDARY_EXEC_TSC_SCALING;
> -
> -=09/*
> -=09 *=09PLE_GAP                         =3D 0x00004020,
> -=09 *=09PLE_WINDOW                      =3D 0x00004022,
> -=09 */
> -=09vmcs_conf->cpu_based_2nd_exec_ctrl &=3D
> ~SECONDARY_EXEC_PAUSE_LOOP_EXITING;
> -
> -=09/*
> -=09 *=09VMX_PREEMPTION_TIMER_VALUE      =3D 0x0000482E,
> -=09 */
> -=09vmcs_conf->pin_based_exec_ctrl &=3D ~PIN_BASED_VMX_PREEMPTION_TIMER;
> -
> -=09/*
> -=09 *      GUEST_IA32_PERF_GLOBAL_CTRL     =3D 0x00002808,
> -=09 *      HOST_IA32_PERF_GLOBAL_CTRL      =3D 0x00002c04,
> -=09 */
> -=09vmcs_conf->vmexit_ctrl &=3D ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> -=09vmcs_conf->vmentry_ctrl &=3D ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> -
> -=09/*
> -=09 * Currently unsupported in KVM:
> -=09 *=09GUEST_IA32_RTIT_CTL=09=09=3D 0x00002814,
> -=09 */

The creation of the EVMCS1_UNSUPPORTED_* macros and the refactor to evmcs_s=
anitize_exec_ctrls()
should be done in a separate patch in this series before this one.

>  }
>  #else /* !IS_ENABLED(CONFIG_HYPERV) */
>  static inline void evmcs_write64(unsigned long field, u64 value) {}
> @@ -1354,6 +1347,27 @@ static inline void
> evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
>  static inline void evmcs_touch_msr_bitmap(void) {}
>  #endif /* IS_ENABLED(CONFIG_HYPERV) */
> =20
> +static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
> +=09=09=09       uint16_t *vmcs_version)
> +{
> +=09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +
> +=09/* We don't support disabling the feature for simplicity. */
> +=09if (vmx->nested.enlightened_vmcs_enabled)
> +=09=09return 0;
> +
> +=09vmx->nested.enlightened_vmcs_enabled =3D true;
> +=09*vmcs_version =3D (KVM_EVMCS_VERSION << 8) | 1;

Please add a comment here explaining the "<< 8) | 1" part.

> +
> +=09vmx->nested.msrs.pinbased_ctls_high &=3D ~EVMCS1_UNSUPPORTED_PINCTRL;
> +=09vmx->nested.msrs.entry_ctls_high &=3D
> ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
> +=09vmx->nested.msrs.exit_ctls_high &=3D ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
> +=09vmx->nested.msrs.secondary_ctls_high &=3D
> ~EVMCS1_UNSUPPORTED_2NDEXEC;
> +=09vmx->nested.msrs.vmfunc_controls &=3D ~EVMCS1_UNSUPPORTED_VMFUNC;
> +
> +=09return 0;
> +}
> +
>  static inline bool is_exception_n(u32 intr_info, u8 vector)
>  {
>  =09return (intr_info & (INTR_INFO_INTR_TYPE_MASK |
> INTR_INFO_VECTOR_MASK |
> @@ -13039,6 +13053,8 @@ static struct kvm_x86_ops vmx_x86_ops
> __ro_after_init =3D {
>  =09.pre_enter_smm =3D vmx_pre_enter_smm,
>  =09.pre_leave_smm =3D vmx_pre_leave_smm,
>  =09.enable_smi_window =3D enable_smi_window,
> +
> +=09.nested_enable_evmcs =3D nested_enable_evmcs,
>  };
> =20
>  static int __init vmx_init(void)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a57766b940a5..51488019dec2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2873,6 +2873,7 @@ int kvm_vm_ioctl_check_extension(struct kvm
> *kvm, long ext)
>  =09case KVM_CAP_HYPERV_VP_INDEX:
>  =09case KVM_CAP_HYPERV_EVENTFD:
>  =09case KVM_CAP_HYPERV_TLBFLUSH:
> +=09case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
>  =09case KVM_CAP_PCI_SEGMENT:
>  =09case KVM_CAP_DEBUGREGS:
>  =09case KVM_CAP_X86_ROBUST_SINGLESTEP:
> @@ -3650,6 +3651,10 @@ static int kvm_set_guest_paused(struct kvm_vcpu
> *vcpu)
>  static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  =09=09=09=09     struct kvm_enable_cap *cap)
>  {
> +=09int r;
> +=09uint16_t vmcs_version;
> +=09void __user *user_ptr;
> +
>  =09if (cap->flags)
>  =09=09return -EINVAL;
> =20
> @@ -3662,6 +3667,16 @@ static int kvm_vcpu_ioctl_enable_cap(struct
> kvm_vcpu *vcpu,
>  =09=09=09return -EINVAL;
>  =09=09return kvm_hv_activate_synic(vcpu, cap->cap =3D=3D
>  =09=09=09=09=09     KVM_CAP_HYPERV_SYNIC2);
> +=09case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> +=09=09r =3D kvm_x86_ops->nested_enable_evmcs(vcpu, &vmcs_version);
> +=09=09if (!r) {
> +=09=09=09user_ptr =3D (void __user *)(uintptr_t)cap->args[0];
> +=09=09=09if (copy_to_user(user_ptr, &vmcs_version,
> +=09=09=09=09=09 sizeof(vmcs_version)))
> +=09=09=09=09r =3D -EFAULT;
> +=09=09}
> +=09=09return r;
> +
>  =09default:
>  =09=09return -EINVAL;
>  =09}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index b6270a3b38e9..5c4b79c1af19 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
>  #define KVM_CAP_HYPERV_TLBFLUSH 155
> +#define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 156
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20
> --=20
> 2.14.4

Besides above comments,
Reviewed-By: Liran Alon <liran.alon@oracle.com>
