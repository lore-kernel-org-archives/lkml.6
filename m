Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DF7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76892148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="flwi+lIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76892148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeHVSyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:54:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36318 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbeHVSyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:54:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7MFT5ug082113;
        Wed, 22 Aug 2018 15:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FBZ+DLj0T4735VC9G63MoVvpdbDPcnStwwa4InsAwG4=;
 b=flwi+lIYTyUXwCxZvG+UxBvwTNSXa1oniWPFMR3yQFSh8ejDO5ZIp6uiy0dWQvCi/w1G
 lZf3hAUD2b/5wUleUQxaoPLuvOISRgbxlYwmajL1ipTJ0K4gF9czOYhZ0YKhdpGkYHIy
 8esqVItR1WvgSQASlZtEQKrLLx3PaLK7dW1Pmh74GVtrtO/dSNsB6Yti/RuLODWXIfp9
 vhQNFDVW4WWpFjc38rEPv4Wi3I6SHjqk/Kt1RLpZEMLZdk6E1Pi1YvdfuzaP4wRAmoCv
 z2SH7zDDnA6d+L7LYsp7dnEGLpYtxhNU/CJTz6QakQgrDIwjvGD9EYGcFlYj1vWlcU34 pA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kxavttyy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 15:29:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7MFTFCF014249
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 15:29:15 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7MFTEAF011604;
        Wed, 22 Aug 2018 15:29:14 GMT
Received: from char.us.oracle.com (/10.152.35.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Aug 2018 08:29:14 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id B58E06A010D; Wed, 22 Aug 2018 11:29:13 -0400 (EDT)
Date:   Wed, 22 Aug 2018 11:29:13 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bsd@redhat.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: fixes for vmentry_l1d_flush module parameter
Message-ID: <20180822152913.GC2616@char.us.oracle.com>
References: <1534949580-38261-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534949580-38261-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8993 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 04:53:00PM +0200, Paolo Bonzini wrote:
> Two bug fixes:
> 
> 1) missing entries in the l1d_param array; this can cause a host crash
> if an access attempts to reach the missing entry. Future-proof the get
> function against any overflows as well.  However, the two entries
> VMENTER_L1D_FLUSH_EPT_DISABLED and VMENTER_L1D_FLUSH_NOT_REQUIRED must
> not be accepted by the parse function, so disable them there.
> 
> 2) invalid values must be rejected even if the CPU does not have the
> bug, so test for them before checking boot_cpu_has(X86_BUG_L1TF)
> 
> ... and a small refactoring, since the .cmd field is redundant with
> the index in the array.
> 
> Reported-by: Bandan Das <bsd@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: a7b9020b06ec6d7c3f3b0d4ef1a9eba12654f4f7
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

with one little nitpick 
> ---
>  arch/x86/kvm/vmx.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index c76ca8c4befa..8dae47e7267a 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -198,12 +198,14 @@
>  
>  static const struct {
>  	const char *option;
> -	enum vmx_l1d_flush_state cmd;
> +	bool for_parse;
>  } vmentry_l1d_param[] = {
> -	{"auto",	VMENTER_L1D_FLUSH_AUTO},
> -	{"never",	VMENTER_L1D_FLUSH_NEVER},
> -	{"cond",	VMENTER_L1D_FLUSH_COND},
> -	{"always",	VMENTER_L1D_FLUSH_ALWAYS},
> +	[VMENTER_L1D_FLUSH_AUTO]	 = {"auto", true},
> +	[VMENTER_L1D_FLUSH_NEVER]	 = {"never", true},
> +	[VMENTER_L1D_FLUSH_COND]	 = {"cond", true},
> +	[VMENTER_L1D_FLUSH_ALWAYS]	 = {"always", true},
> +	[VMENTER_L1D_FLUSH_EPT_DISABLED] = {"EPT disabled", false},
> +	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required", false},

Ingo likes these to have tabs. Any chance you could do:

	[VMENTER_L1D_FLUSH_NOT_REQUIRED] = {"not required",	false},

or so?

>  };
>  
>  #define L1D_CACHE_ORDER 4
> @@ -287,8 +289,9 @@ static int vmentry_l1d_flush_parse(const char *s)
>  
>  	if (s) {
>  		for (i = 0; i < ARRAY_SIZE(vmentry_l1d_param); i++) {
> -			if (sysfs_streq(s, vmentry_l1d_param[i].option))
> -				return vmentry_l1d_param[i].cmd;
> +			if (vmentry_l1d_param[i].for_parse &&
> +			    sysfs_streq(s, vmentry_l1d_param[i].option))
> +				return i;
>  		}
>  	}
>  	return -EINVAL;
> @@ -298,13 +301,13 @@ static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
>  {
>  	int l1tf, ret;
>  
> -	if (!boot_cpu_has(X86_BUG_L1TF))
> -		return 0;
> -
>  	l1tf = vmentry_l1d_flush_parse(s);
>  	if (l1tf < 0)
>  		return l1tf;
>  
> +	if (!boot_cpu_has(X86_BUG_L1TF))
> +		return 0;
> +
>  	/*
>  	 * Has vmx_init() run already? If not then this is the pre init
>  	 * parameter parsing. In that case just store the value and let
> @@ -324,6 +327,9 @@ static int vmentry_l1d_flush_set(const char *s, const struct kernel_param *kp)
>  
>  static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
>  {
> +	if (WARN_ON_ONCE(l1tf_vmx_mitigation >= ARRAY_SIZE(vmentry_l1d_param)))
> +		return sprintf(s, "???\n");
> +
>  	return sprintf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
>  }
>  
> -- 
> 1.8.3.1
> 
