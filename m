Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D369C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FD82086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BPL5SQFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfANFfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:35:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43852 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfANFfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=No+UT8kRyaUrJuX+S0DHglEjzE8Waqv2HxDQ0s83kC8=; b=BPL5SQFgcjkaeSEH+9eyyYlWsp
        la3pcpYIdxfJOOEtD0jWxeVgjeq2rqI8+qcG8XksrvifqovH7r30fkiXZI/Y36UcLpVSirhf6uvxg
        9jd89Nd6sNHvfeUmcijAT6egXdcm6hJ4aGwK+siidZHib9n50cVG9Tnr8vdEwNaJMMHWnfcJ/VFSz
        ihkz9NIYHfRjkoH5m2V/+lsIqECXus508L/SQzb1xmBpfhBt5r7Qx6mlG880HeeAS8kGR+E8SUfpk
        nZYl0aWvasEp0Qpajz2u3zpSgQlF8RTFeWdh7qvPIHD5xfUT2oHwAjbVEh7OObl6bgh399jktVKrp
        FRv/chJA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giuto-0002Uw-Kf; Mon, 14 Jan 2019 05:35:00 +0000
Subject: Re: [PATCH resend] w1: add missing kernel-doc entry for
 of_match_table
To:     LKML <linux-kernel@vger.kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <60723da5-8ef1-80bf-8b30-95e87173c884@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7910f5d3-69a7-00b2-e211-a67d6c1837a3@infradead.org>
Date:   Sun, 13 Jan 2019 21:34:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <60723da5-8ef1-80bf-8b30-95e87173c884@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

also adding Mr. Corbet.

On 11/1/18 4:41 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning for missing struct member description:
> 
> ../include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Evgeniy Polyakov <zbr@ioremap.net>
> ---
>  include/linux/w1.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20181101.orig/include/linux/w1.h
> +++ linux-next-20181101/include/linux/w1.h
> @@ -266,6 +266,7 @@ struct w1_family_ops {
>   * @family_entry:	family linked list
>   * @fid:		8 bit family identifier
>   * @fops:		operations for this family
> + * @of_match_table:	Open Firmware device matching table
>   * @refcnt:		reference counter
>   */
>  struct w1_family {
> 
> 
> 


-- 
~Randy
