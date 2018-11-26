Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7785EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BE420873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/qL5f+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BE420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeK0JdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:33:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36579 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeK0JdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:33:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so2094196plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihR7io+e8Iz8+7hd5geWfSmbj+8hTSTxUWKmuTexxcI=;
        b=p/qL5f+G9xYIij2oomEDfpNlM1/EqQH7/BvOMGAJSPbRV55KUg8yvs+7Dk6e2RVPm6
         Voi7LtAPmB29u5XQPoYgO3/yLE3oqAxepggwIUER4Adf8BYIejVJb3XmCaqEiNYkY7gh
         U+udfPucK0IKNQ6drqZcj2AveRsCasiyECetLTonZsBASNAMsgYu1eCc37vLnXLQEDJ4
         +x98CFsNUEYa2HJMZJ9lKwjqq55HMjCB6N23QdJr5g2QAoUJ555bqWMpOW29GhQdzGk9
         z/e4ClutpzEpBhthSi+nipaQU0IDQ0phsYx1xWvRwOtvlCcqYStHIZiGj3TQih+v01iJ
         BxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ihR7io+e8Iz8+7hd5geWfSmbj+8hTSTxUWKmuTexxcI=;
        b=LkQvOPNazpNI/q2BaWdflWXM/AVri1PYSyUaxtruXUak8V9TWgjPp344u5mreZgW46
         Leens2EiGpMrBYT+jOULLa0YsL1vdtnwT03FMhy6bwrQNT0cKWEZiIDcB7pcJvl28yvN
         hDST/cf6TCa25muO4ziEezF3AsqR8fnBIYp4rsrseDwmEaeIQ1c0v/FcAT8OWXYwp1xw
         0ooXcbf+LLGrfpv4ZRwYNk118R60avuIJwU4pV0003aq0R9MoSJwz3OogNFkLNpL6Uf0
         TICacwM4W8cUkc1xQJN5zfNgotdgjdKELJIu/cVUo4FESqLAu6bzBmGrv3CUt3MSa+GD
         pjFw==
X-Gm-Message-State: AA+aEWbLyxfFWi0j7YIR84pFADtuD96G0AnJ7vMSpDYsUyi1fHSY43wk
        M1Ol3HSu1jMoYOUGwQ0aKIT37Q==
X-Google-Smtp-Source: AFSGD/VumM+qzvvrsbnRkv3vZisPOP6yvSmBeR6i8xVEpYcuf48K2AjjbDeLGRCqA2CAt/s8zHKu7w==
X-Received: by 2002:a17:902:468:: with SMTP id 95mr22494048ple.3.1543271850500;
        Mon, 26 Nov 2018 14:37:30 -0800 (PST)
Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:2:5c1d:6557:d90c:ea99])
        by smtp.gmail.com with ESMTPSA id n68sm2577987pfb.62.2018.11.26.14.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 14:37:29 -0800 (PST)
Subject: Re: [PATCH 1/3] kvm: make KVM_CAP_ENABLE_CAP_VM architecture agnostic
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Xiao Guangrong <guangrong.xiao@linux.intel.com>
References: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
 <1543251253-24762-2-git-send-email-pbonzini@redhat.com>
From:   Junaid Shahid <junaids@google.com>
Organization: Google
Message-ID: <d8bf0505-16ee-550b-cc0a-901c6717591a@google.com>
Date:   Mon, 26 Nov 2018 14:37:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543251253-24762-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/2018 08:54 AM, Paolo Bonzini wrote:
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index cd209f7730af..1071c10cf1c7 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1129,10 +1129,15 @@ documentation when it pops into existence).
>  
>  4.37 KVM_ENABLE_CAP
>  
> -Capability: KVM_CAP_ENABLE_CAP, KVM_CAP_ENABLE_CAP_VM
> -Architectures: x86 (only KVM_CAP_ENABLE_CAP_VM),
> -	       mips (only KVM_CAP_ENABLE_CAP), ppc, s390
> -Type: vcpu ioctl, vm ioctl (with KVM_CAP_ENABLE_CAP_VM)
> +Capability: KVM_CAP_ENABLE_CAP
> +Architectures: mips, ppc, s390
> +Type: vcpu ioctl
> +Parameters: struct kvm_enable_cap (in)
> +Returns: 0 on success; -1 on error
> +
> +Capability: KVM_CAP_ENABLE_CAP_VM
> +Architectures: all
> +Type: vcpu ioctl

I suppose that this should be "vm ioctl".

>  Parameters: struct kvm_enable_cap (in)
>  Returns: 0 on success; -1 on error
...

Reviewed-by: Junaid Shahid <junaids@google.com>
