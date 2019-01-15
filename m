Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9803CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636D620657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="cFFo0enK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfAOJEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:04:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41007 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbfAOJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:04:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so1424731lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 01:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dLgVhkEpwKrEww2s+xVUkpzSW6S/MsBrC2BC0XW0zWI=;
        b=cFFo0enKWQvo+50UnTKSgKaimlo+rtBPE6LnSb1H/89zOnAmdpkUrPpgCbyn+6pkCe
         30KmxViW827zu20t8Zlj/bE2TMDAGslcWedJJPVRSDlz4DRz2mYkBwQS6/6qMqNyiLuv
         63RCpRDjfBm3VWKIvTtHuW3nC80umKo7H75dfr2e74Qn3ncgeIiYwfov6OB2aeCCMvFH
         z4C+J+QjxDDOHaqgBYeoi03ayFgnjJ9DFR7JTL1ZOiRaN4pOOm/dRBJZMHpO/7Sl0V+h
         Cc0GOGUx2FBfK/77Nl29q5ET/QyjkD31fkjNL44PkghMK3SQ/BmulMP+j4SXrD3YFjGx
         MmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dLgVhkEpwKrEww2s+xVUkpzSW6S/MsBrC2BC0XW0zWI=;
        b=a2ZBS1Zkjpaon5pquohqfSPd52/Um/gFnNNChhfKYC2CslmnDpwxjQ9ljlbIsFqaV0
         HeULovvAylDdmA/Tu6Oemv+XwqZ3S6yWh+eShxAS5x4BXXgQX7b6gH3UT396idQmpYBB
         NIl/ya91Lxq9N2489V+oseUe7pgv9oPzJTWHIw5Wbxn/xNLqKphKYic2Jb1cKBCFVamm
         GDmSXQPL2rNbDTyaTikMMdJqBbCmZYSXkN0Wr38yGUyICeo/bD+146fIZ62kUQUXpqzo
         1xGxx/D5FYYf99KSejJ4T6azMnGQAT/Ww3MOd0qvP+q4bNRNCMreoTPD+QYPKgeRsQ31
         aBHA==
X-Gm-Message-State: AJcUukeV0l4DF/Mn3rg5ROUY8Vdx1OENGU/+Lymiv612xjnIwCq/GfcI
        dvAPo6a9xXveAMpoW93J68Odz/iBax0=
X-Google-Smtp-Source: ALg8bN4GUvWlafXgcPdOPcxQX4rsgK2TBk8qjTrmKIu9kwsBiJwQSf7FLuAMdRqtc+rToEmoXNnWxg==
X-Received: by 2002:a19:d242:: with SMTP id j63mr2133017lfg.26.1547543047518;
        Tue, 15 Jan 2019 01:04:07 -0800 (PST)
Received: from [192.168.0.199] ([31.173.81.70])
        by smtp.gmail.com with ESMTPSA id b22sm514319lfg.32.2019.01.15.01.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 01:04:06 -0800 (PST)
Subject: Re: [PATCH 2/2] bpf: annotate implicit fall through
To:     Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190114202941.16183-1-malat@debian.org>
 <20190114202941.16183-2-malat@debian.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <476963d1-fc1a-b185-6b33-c780fbb009c5@cogentembedded.com>
Date:   Tue, 15 Jan 2019 12:03:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114202941.16183-2-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.2019 23:29, Mathieu Malaterre wrote:

> There is a plan to build the kernel with -Wimplicit-fallthrough and
> thise place in the code produced a warnings (W=1).

    This?

> In this particular case change a ‘:’ with a ‘,’ so as to match the
> regular expression expected by GCC.
> 
> This commit remove the following warning:
> 
>    net/core/filter.c:5310:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   net/core/filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 447dd1bad31f..c8069a142994 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5309,7 +5309,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>   	case BPF_FUNC_trace_printk:
>   		if (capable(CAP_SYS_ADMIN))
>   			return bpf_get_trace_printk_proto();
> -		/* else: fall through */
> +		/* else, fall through */

    The other patches seem to just drop "else:"...

>   	default:
>   		return NULL;
>   	}
> 

MBR, Sergei
