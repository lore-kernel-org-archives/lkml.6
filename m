Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A776C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1171F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aefkn7m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfAWSSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:18:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45240 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfAWSSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:18:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NI44sD067414;
        Wed, 23 Jan 2019 18:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=PEO+aGSI1e6bWoYsMqiXF8S8alvOI+II99jL3BO+F04=;
 b=aefkn7m1rJuJvC8gQzjvQnxfYkJbaU0QKakIE5UhXRj4EDh0nExflBDXcDCWZCuAj7JI
 CSusHqIt/nvEpbwZUb8q1eYVqwSZPh9DPGZof6EY4ovZRtkXdReZD+fpQ78Z+2ing8st
 0I2S4QEnbAycNgc0PNIaZL+kOwxYEs38ruxUziOh3I5mpByxAFgarbJ2G+VMtPK+KgB2
 BdpHBli5SSBeKf2d0XeZmN46wFfIIyjF7SGYAeWrbqZBYCvlN47QK/puB+A5zvJIjMLC
 zgntOzR034pU60Ye+Zm2lCCZlHoaG4w8R1t9Lq0ZwHu5FrkiEzUJVy2TGc9NGe6ajmaQ Xg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2q3sdekrbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:18:24 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NIINXK019577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:18:24 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NIIM4v020326;
        Wed, 23 Jan 2019 18:18:22 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 10:18:22 -0800
Date:   Wed, 23 Jan 2019 13:18:09 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 13/13] KVM/nVMX: Use page_address_valid in a few more
 locations
Message-ID: <20190123181807.GS19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-14-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-14-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:13AM +0100, KarimAllah Ahmed wrote:
> Use page_address_valid in a few more locations that is already checking for
> a page aligned address that does not cross the maximum physical address.

Where is this page_address_valid declared? The latest linus's tree does
not have it, nor does your patchset?
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  arch/x86/kvm/vmx/nested.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index ccb3b63..77aad46 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4203,7 +4203,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
>  	 * Note - IA32_VMX_BASIC[48] will never be 1 for the nested case;
>  	 * which replaces physical address width with 32
>  	 */
> -	if (!PAGE_ALIGNED(vmptr) || (vmptr >> cpuid_maxphyaddr(vcpu)))
> +	if (!page_address_valid(vcpu, vmptr))
>  		return nested_vmx_failInvalid(vcpu);
>  
>  	if (kvm_read_guest(vcpu->kvm, vmptr, &revision, sizeof(revision)) ||
> @@ -4266,7 +4266,7 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
>  	if (nested_vmx_get_vmptr(vcpu, &vmptr))
>  		return 1;
>  
> -	if (!PAGE_ALIGNED(vmptr) || (vmptr >> cpuid_maxphyaddr(vcpu)))
> +	if (!page_address_valid(vcpu, vmptr))
>  		return nested_vmx_failValid(vcpu,
>  			VMXERR_VMCLEAR_INVALID_ADDRESS);
>  
> @@ -4473,7 +4473,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  	if (nested_vmx_get_vmptr(vcpu, &vmptr))
>  		return 1;
>  
> -	if (!PAGE_ALIGNED(vmptr) || (vmptr >> cpuid_maxphyaddr(vcpu)))
> +	if (!page_address_valid(vcpu, vmptr))
>  		return nested_vmx_failValid(vcpu,
>  			VMXERR_VMPTRLD_INVALID_ADDRESS);
>  
> -- 
> 2.7.4
> 
