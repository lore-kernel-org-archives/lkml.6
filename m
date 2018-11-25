Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA98C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090362082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ahNONecU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090362082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeKZIbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:31:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60924 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeKZIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:31:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAPLd01k069781;
        Sun, 25 Nov 2018 21:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=eKvPbzzzGFEKgdgh+YjIsRNapNnjTW6D3bs22BkHqRE=;
 b=ahNONecUgeiw1hzehBBTThK9MXSDIiS9xjkrSCZuFjRxD6WsqtAiPhUd+rS0LBNJIgDJ
 huBj9Txb979/G79pIhsTHq4kawUUqAXN/F8IGiHJDmOcm2wm2xEGO4oXk9lFw8dBMPK7
 H+yJ0xzF06YcfUZODZDf4gj9YycNNF20/uX3Fi1uH250HeOrN3+6Ue+urBwg//muZRJ9
 ZkWZGlkrHcQ7tQ9l28sqrpWjrDHMCnFOgRmQNo/rKnXTAiTCz+ZWQOMoPDhOJsMEGk/k
 0hqg2xlWK4dnO24qy/FtZxykGOO1HueJZSu6lbiRV/sNw91kKzXlpPHbFjcsT2L2x6Po PQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkq2se6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Nov 2018 21:39:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAPLcxWi032485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Nov 2018 21:38:59 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAPLcwxD001649;
        Sun, 25 Nov 2018 21:38:58 GMT
Received: from [192.168.14.112] (/109.65.235.154)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 25 Nov 2018 13:38:58 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] KVM: x86: Trace changes to active TSC offset regardless
 if vCPU in guest-mode
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1543168405-16768-1-git-send-email-pbonzini@redhat.com>
Date:   Sun, 25 Nov 2018 23:38:53 +0200
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <941567E8-FA38-4947-B9F9-529039ADDCEA@oracle.com>
References: <1543168405-16768-1-git-send-email-pbonzini@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9088 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811250132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 25 Nov 2018, at 19:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> For some reason, kvm_x86_ops->write_l1_tsc_offset() skipped trace
> of change to active TSC offset in case vCPU is in guest-mode.
> This patch changes write_l1_tsc_offset() behavior to trace any change
> to active TSC offset to aid debugging.  The VMX code is changed to
> look more similar to SVM, which is in my opinion nicer.
>=20
> Based on a patch by Liran Alon.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I would have applied this refactoring change on top of my original =
version of this patch. Easier to read and review.
But I guess it=E2=80=99s a matter of taste=E2=80=A6
Anyway, code looks correct to me. Therefore:
Reviewed-by: Liran Alon <liran.alon@oracle.com>

> ---
> 	Untested still, but throwing it out because it seems pretty
> 	obvious...
>=20
> arch/x86/kvm/svm.c |  9 +++++----
> arch/x86/kvm/vmx.c | 34 +++++++++++++++++-----------------
> 2 files changed, 22 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index a24733aade4c..0d1a74069a9e 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1456,10 +1456,11 @@ static u64 svm_write_l1_tsc_offset(struct =
kvm_vcpu *vcpu, u64 offset)
> 		g_tsc_offset =3D svm->vmcb->control.tsc_offset -
> 			       svm->nested.hsave->control.tsc_offset;
> 		svm->nested.hsave->control.tsc_offset =3D offset;
> -	} else
> -		trace_kvm_write_tsc_offset(vcpu->vcpu_id,
> -					   =
svm->vmcb->control.tsc_offset,
> -					   offset);
> +	}
> +
> +	trace_kvm_write_tsc_offset(vcpu->vcpu_id,
> +				   svm->vmcb->control.tsc_offset - =
g_tsc_offset,
> +				   offset);
>=20
> 	svm->vmcb->control.tsc_offset =3D offset + g_tsc_offset;
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 764c23dc444f..e7d3f7d35355 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -3466,24 +3466,24 @@ static u64 vmx_read_l1_tsc_offset(struct =
kvm_vcpu *vcpu)
>=20
> static u64 vmx_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
> {
> -	u64 active_offset =3D offset;
> -	if (is_guest_mode(vcpu)) {
> -		/*
> -		 * We're here if L1 chose not to trap WRMSR to TSC. =
According
> -		 * to the spec, this should set L1's TSC; The offset =
that L1
> -		 * set for L2 remains unchanged, and still needs to be =
added
> -		 * to the newly set TSC to get L2's TSC.
> -		 */
> -		struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
> -		if (nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING))
> -			active_offset +=3D vmcs12->tsc_offset;
> -	} else {
> -		trace_kvm_write_tsc_offset(vcpu->vcpu_id,
> -					   vmcs_read64(TSC_OFFSET), =
offset);
> -	}
> +	struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
> +	u64 g_tsc_offset =3D 0;
> +
> +	/*
> +	 * We're here if L1 chose not to trap WRMSR to TSC. According
> +	 * to the spec, this should set L1's TSC; The offset that L1
> +	 * set for L2 remains unchanged, and still needs to be added
> +	 * to the newly set TSC to get L2's TSC.
> +	 */
> +	if (is_guest_mode(vcpu) &&
> +	    (vmcs12->cpu_based_vm_exec_control & =
CPU_BASED_USE_TSC_OFFSETING))
> +		g_tsc_offset =3D vmcs12->tsc_offset;
>=20
> -	vmcs_write64(TSC_OFFSET, active_offset);
> -	return active_offset;
> +	trace_kvm_write_tsc_offset(vcpu->vcpu_id,
> +				   vcpu->arch.tsc_offset - g_tsc_offset,
> +				   offset);
> +	vmcs_write64(TSC_OFFSET, offset + g_tsc_offset);
> +	return offset + g_tsc_offset;
> }
>=20
> /*
> --=20
> 1.8.3.1
>=20



