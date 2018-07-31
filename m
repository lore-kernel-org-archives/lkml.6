Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341EFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78D3208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgb1a+64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78D3208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbeGaP2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:28:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50763 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbeGaP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:28:03 -0400
Received: by mail-it0-f65.google.com with SMTP id g191-v6so4557537ita.0;
        Tue, 31 Jul 2018 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MsWTfsjAe9tdj0vWsmQqyuldAqrZWREFX3gBaZYrrUw=;
        b=tgb1a+64NhXFAz2xMwumwqZIe3kdA50NeVerWBvsvQf4elq+s0JhrYzWavmTnO0gDE
         wTqVruooAGJZ1p8TKlV7Uqive5nhq61zwz+Eq2aHtoQRRHYvGWPwCUwuBODCs97cN7Lw
         5FhCf6+IeIirTbdaP3A3gZTldcIsKQZd+MdMIoWbV2XE0gR8BMlXffIYo3eXT4GxjPwf
         WehZroNi+M9uXNbUWURfc3up6hgqbkYZYxXgITcDZg6S1254hD4wy2xR8wpA0v55251j
         OdC0SIb7EKvGNaO7j0n7l2yq5TqdzxinC83/bGHT45Ocjd6SLjeZyyOrV8/qs3FUH2ZV
         ETYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MsWTfsjAe9tdj0vWsmQqyuldAqrZWREFX3gBaZYrrUw=;
        b=ta51x82zpyU/RHBQh7zML8X17GSulq9Tvuiu165KmXj50Xv67SNzG027jAwwZaiFfO
         v1afaNDD3xt5lERoOVPcQ9ZeWwrR8mm2gLubWx8YVmt9XOTvaLq69GcIMGchNVm2VIxR
         FRv4DxvQzyLddcgaZbFU35qBeOY3nT5FJN4zHcWLmzPqImMmGYH9ReW8wXFVJUoSX3Gb
         OljlQotXC8iOyMJniSvfvHhOu2v26uiDguITW4iOLcGfUZxZkZUjmtX+tfTdbRJ6E/+a
         jGaNYMqL5Yxzd1H3cg9KbgU78GyMFf3wjPelIVeicU7MEUkntvLFJyNYdnLMqyB2yEzH
         DNxA==
X-Gm-Message-State: AOUpUlHRw/fJs5Of49s94/0xGWbjooS7FSWn5ah0WN6zs0ssA/ilYi5k
        CLgGxM1McrnP5iwMAHFw3xdUavN6
X-Google-Smtp-Source: AAOMgpeZwVebw9BwnnI+ruTRuo6dvl+NPyPkcXN8uOoYK0BXt7v82cdhHEs4H1TfZhN6aCga3sNBfg==
X-Received: by 2002:a24:61c4:: with SMTP id s187-v6mr3172421itc.153.1533044857814;
        Tue, 31 Jul 2018 06:47:37 -0700 (PDT)
Received: from gouda.nowheycreamery.com (99-9-112-69.lightspeed.livnmi.sbcglobal.net. [99.9.112.69])
        by smtp.gmail.com with ESMTPSA id 64-v6sm6095494iou.36.2018.07.31.06.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:47:37 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the nfs-anna tree
To:     David Wysochanski <dwysocha@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180730185200.0d836ca7@canb.auug.org.au>
 <1533027885.3710.2.camel@redhat.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Message-ID: <35966b8f-43c9-ed1c-215e-f26a0fc1395b@gmail.com>
Date:   Tue, 31 Jul 2018 09:46:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533027885.3710.2.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 07/31/2018 05:04 AM, David Wysochanski wrote:
> On Mon, 2018-07-30 at 18:52 +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the nfs-anna tree, today's linux-next build (powerpc
>> ppc44x_defconfig, sparc defconfig) produced this warning:
>>
>> net/sunrpc/stats.c: In function 'rpc_clnt_show_stats':
>> /home/sfr/next/next/net/sunrpc/stats.c:258:32: warning: excess elements in struct initializer
>>    struct rpc_iostats stats = { 0 };
>>         
> 
> Apologies I did not see this before submission.
> 
> The below fixup compiles without warning for me on ppc64le.
> 
>    struct rpc_iostats stats = {};

Can you resend the patch with that change, please?

Thanks,
Anna

> 
> 
>>                         ^
>>
>> Introduced by commit
>>
>>   c3b588a2d5be ("sunrpc: Change rpc_print_iostats to rpc_clnt_show_stats and handle rpc_clnt clones")
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
