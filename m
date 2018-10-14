Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1F2C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F620835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ro7LCiAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8F620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeJNPIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:08:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeJNPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:08:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9E7KWth090057;
        Sun, 14 Oct 2018 07:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=x1rPStnyMjgTZ4kR6etWB0TFzQLk4cy1o7iAyMPR8Vo=;
 b=Ro7LCiAdB43Hgv9VAbgRuwwoo7nGoz/tvkwJLuKy3j7bitZKDEZ+2cSIX2wYLRDCTjC8
 8+bn/O6I+ifjC9ZwEv4/7hFQOrR1EOtCdtYhKm4n6xRiJbuhiRHBi039uY42lugiJ+67
 yw0Xte6X4P5YTH47Cuvc4QwzEDpNHhK+7+6L0YAXZ/pHxCU5f08WMQ3sKH2tvjPodQ63
 Y39eRtFhkCqrOp1q/g9DtCsmrdATn4VGH9oLAWmm7OCvNrpAhMs5yTir0HlalJ1jPIBV
 g2ZSs3Mr+XPejy7vLLWEZPtUrKRPnJVvi2O0RiErPB2WqgGtUUspqH898xM5nWodTu3i 7w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n38npmcvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Oct 2018 07:27:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9E7QvEd010730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Oct 2018 07:26:57 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9E7Qq6c027817;
        Sun, 14 Oct 2018 07:26:53 GMT
Received: from [192.168.14.112] (/79.182.224.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Oct 2018 07:26:51 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
Date:   Sun, 14 Oct 2018 10:26:41 +0300
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org, catalin.marinas@arm.com,
        will.deacon@arm.com, jhogan@kernel.org, ralf@linux-mips.org,
        paul.burton@mips.com, paulus@ozlabs.org, benh@kernel.crashing.org,
        mpe@ellerman.id.au, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@linuxdriverproject.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
To:     lantianyu1986@gmail.com
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9045 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=865
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810140071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
>=20
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>=20
> This patch is to add wrapper functions for tlb_remote_flush_with_range
> callback.
>=20
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change sicne V3:
>       Remove code of updating "tlbs_dirty"
> Change since V2:
>       Fix comment in the kvm_flush_remote_tlbs_with_range()
> ---
> arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 40 insertions(+)
>=20
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index c73d9f650de7..ff656d85903a 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
> static union kvm_mmu_page_role
> kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
>=20
> +
> +static inline bool kvm_available_flush_tlb_with_range(void)
> +{
> +	return kvm_x86_ops->tlb_remote_flush_with_range;
> +}

Seems that kvm_available_flush_tlb_with_range() is not used in this =
patch=E2=80=A6

> +
> +static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
> +		struct kvm_tlb_range *range)
> +{
> +	int ret =3D -ENOTSUPP;
> +
> +	if (range && kvm_x86_ops->tlb_remote_flush_with_range)
> +		ret =3D kvm_x86_ops->tlb_remote_flush_with_range(kvm, =
range);
> +
> +	if (ret)
> +		kvm_flush_remote_tlbs(kvm);
> +}
> +
> +static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
> +		struct list_head *flush_list)
> +{
> +	struct kvm_tlb_range range;
> +
> +	range.flush_list =3D flush_list;
> +
> +	kvm_flush_remote_tlbs_with_range(kvm, &range);
> +}
> +
> +static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
> +		u64 start_gfn, u64 pages)
> +{
> +	struct kvm_tlb_range range;
> +
> +	range.start_gfn =3D start_gfn;
> +	range.pages =3D pages;
> +	range.flush_list =3D NULL;
> +
> +	kvm_flush_remote_tlbs_with_range(kvm, &range);
> +}
> +
> void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value)
> {
> 	BUG_ON((mmio_mask & mmio_value) !=3D mmio_value);
> --=20
> 2.14.4
>=20

