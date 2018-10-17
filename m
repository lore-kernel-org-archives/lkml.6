Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EECC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECC7214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5190NtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECC7214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeJQLTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:19:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeJQLTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h3t6EuSSgkqDJ2lDi1LClScf/NqJPqymNF27LiwgZao=; b=O5190NtNN5n7j0g6RG+Kgtzou
        Z3pcUSHOw1Wgs5XdNWN3XjM1WLHqjb5LPeEejyxFoXyrArL5RMyNArx5EDI9ghSvambsmJwte+/Os
        jkZ9EHMfYpNJvLqFbOcBzmVyWYnfU9yM/mXu287EVbGrvmO9Xbc0sA4dK+uNEWJSfKOmbxh2NrhSf
        vo62EYRjM1jlIkKlzeX64WmmECiCIqBMgH334vNGyu58+S/b10QYPK2RoNxMRFGRh1TBOBSCZjnTF
        MsyqtQM86kCZWgn996PBF1cr7m4kvcEsHQRx5u6G1iEIeX6d/1gsdq6tOhIhYvy5S/6mPjxQ1izGY
        4AJpv8MMA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCcTC-0000Le-5u; Wed, 17 Oct 2018 03:26:02 +0000
Subject: Re: [PATCH] docs: Introduce deprecated APIs list
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20181017021708.GA22211@beast>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aed0041d-7c28-4dfb-91b5-fc83174d8744@infradead.org>
Date:   Tue, 16 Oct 2018 20:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017021708.GA22211@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/18 7:17 PM, Kees Cook wrote:
> As discussed in the "API replacement/deprecation" thread[1], this
> makes an effort to document what things shouldn't get (re)added to the
> kernel, by introducing Documentation/process/deprecated.rst. It also
> adds the overflow kerndoc to ReST output, and tweaks the struct_size()
> documentation to parse correctly.
> 
> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005282.html
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/driver-api/basics.rst  |  3 +
>  Documentation/process/deprecated.rst | 99 ++++++++++++++++++++++++++++
>  Documentation/process/index.rst      |  1 +
>  include/linux/overflow.h             |  2 +-
>  4 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/process/deprecated.rst


> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 40b48e2133cb..2f224f43dd06 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -291,7 +291,7 @@ static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
>  }
>  
>  /**
> - * struct_size() - Calculate size of structure with trailing array.
> + * function struct_size() - Calculate size of structure with trailing array.

That syntax is not explained nor documented in Documentation/doc-guide/kernel-doc.rst.

Is the root problem that the function name begins with "struct"?
Please explain in the patch description.

>   * @p: Pointer to the structure.
>   * @member: Name of the array member.
>   * @n: Number of elements in the array.


thanks.
-- 
~Randy
