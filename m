Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03400C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73122171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bNxxNJsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeLZIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:52:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLZIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:52:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBQ8mvCu100393;
        Wed, 26 Dec 2018 08:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=veyBVi6sHKmAnV6/gYzRk36+44e0qVjHOoyZROTRmSQ=;
 b=bNxxNJsGnxlB/s48NVxM2bP0eq9uDw+jV61zcL0a9wgxgNoxdaHcYIGgGRZaESPUkkOX
 Q0BZ71oQR9VHjqJGG+S0nvs1b4cD1/xVYIRmBcwlsB1EmGAG/sA7q6Gf1iIQ5ZOeybsg
 DSj36J9uLyQxR3G7/ZXgtd4UGxTzVGPrUmOp2xDdWqXB5AeCaIXbRr7bIUUe9xfca+Vz
 6FivhJjeTMeskMxJsBd1l7K2Vl8h2iV+cgEQWmU8iG3kXBYx8CFrNrOQmWSE1en5KD4V
 EMFdZ26niefcs7miIQhIl0SS6obCYqWWY7hCQtKq/am+Vmq9Uk1BhEWhC5Lrj043yL/2 aA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2phcptrvm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Dec 2018 08:52:45 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBQ8qi1X022901
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Dec 2018 08:52:44 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBQ8qhBb010146;
        Wed, 26 Dec 2018 08:52:43 GMT
Received: from [10.0.5.57] (/213.57.127.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Dec 2018 00:52:43 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v1 3/8] kvm:vmx  Enable loading CET state bit while guest
 CR4.CET is being set.
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20181226081532.30698-4-weijiang.yang@intel.com>
Date:   Wed, 26 Dec 2018 10:52:38 +0200
Cc:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9307C088-C8F8-4587-ABB4-3CADF2CC3117@oracle.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-4-weijiang.yang@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9117 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=938
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812260082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 26 Dec 2018, at 10:15, Yang Weijiang <weijiang.yang@intel.com> =
wrote:
>=20
> This bit controls whether guest CET states will be loaded on guest =
entry.
>=20
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
> arch/x86/kvm/vmx.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 7bbb8b26e901..25fa6bd2fb95 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -1045,6 +1045,8 @@ struct vcpu_vmx {
>=20
> 	bool req_immediate_exit;
>=20
> +	bool vcpu_cet_on;
> +
> 	/* Support for PML */
> #define PML_ENTITY_NUM		512
> 	struct page *pml_pg;
> @@ -5409,6 +5411,23 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, =
unsigned long cr4)
> 			return 1;
> 	}
>=20
> +	/*
> +	 * When CET.CR4 is being set, it means we're enabling CET for

You probably meant to write here CR4.CET.

> +	 * the guest, then enable loading CET state bit in entry =
control.
> +	 * Otherwise, clear loading CET bit to disable guest CET.
> +	 */
> +	if (cr4 & X86_CR4_CET) {
> +		if (!to_vmx(vcpu)->vcpu_cet_on) {
> +			vmcs_set_bits(VM_ENTRY_CONTROLS,
> +				      VM_ENTRY_LOAD_GUEST_CET_STATE);
> +			to_vmx(vcpu)->vcpu_cet_on =3D 1;
> +		}
> +	} else if (to_vmx(vcpu)->vcpu_cet_on) {
> +		vmcs_clear_bits(VM_ENTRY_CONTROLS,
> +				VM_ENTRY_LOAD_GUEST_CET_STATE);
> +		to_vmx(vcpu)->vcpu_cet_on =3D 0;
> +	}
> +
> 	if (to_vmx(vcpu)->nested.vmxon && !nested_cr4_valid(vcpu, cr4))
> 		return 1;
>=20
> --=20
> 2.17.1
>=20

I haven=E2=80=99t seen a patch in the series that modifies kvm_set_cr4() =
to verify CR4.CET is not set when CET is not reported as supported by =
CPUID.
I think that is missing from the series.

-Liran


