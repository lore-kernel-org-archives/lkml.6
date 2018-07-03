Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF83CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBDF2476D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="f4kwmdcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBDF2476D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeGCWiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:38:50 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39436 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbeGCWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:38:48 -0400
Received: by mail-qk0-f193.google.com with SMTP id f3-v6so1922767qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=+AAQ7N8BQGhW7wqaEfiqBI1gAX4dwFSK/GZoCVlqqEE=;
        b=f4kwmdcKnU0H4qBjhpKQVmm5Cv7f1qeg0Pu30PzH/7LzMQYu3KjrvpLJkCbdaN2Ha/
         iZCjxDR1G/ObV3OfmyZmwB1Kr4WrUlGKuYdUB4gtZXGzahG8IHdxY825b5ziFojPLPr7
         zbYpYKQozTwwZmwzxbNtotcYOWYZhGwxZZeqr0TZPmMVIb3DcesHGDXnm1Rg0EQUQogX
         665wbQke5jGRhe4ZXKhz+BadSb0PWiTBMR992Uzp7m95AvO8xbtlLGXBwOgyi4CXjSB8
         o4AeykecrxEQObTCt20udAikE5Vay/BgZPcXyhdlv5eR36yOoRhjoQjqb2EzZ7VMS1ZD
         SOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+AAQ7N8BQGhW7wqaEfiqBI1gAX4dwFSK/GZoCVlqqEE=;
        b=ZaDBOl7tFOeIO8n4QHu8M2vOsN3xHGx5jR5iq8b5hOn0TmRv03p7q9LpcQhD8K57zh
         fz4GTikOB2PcP5Q12qcupStrCCF/mlBUSMy96gmOUrEmgFpldKF4YJri9sTp6jo3vvoj
         /+felW0Ac7/Z2lmTEhXAyXKxQfipwvgSUrzuLxochHRCmpyq8FRscReQSmyjtEhpU+ik
         bgWPCCegjPDxBIFsoMsdlgdKx/zDXqjeJ9+5iNJIy6fOhW9hRY9pKHj0cBUeAwOb+8UP
         HzBM/sQKi3uO9aoWr9o79bpe9OIAGSuZD8z2PV1KxHOuNjSgn6E1JVDTQJ29n8kmczZ0
         NSpg==
X-Gm-Message-State: APt69E0UhRZsHCqL90SnrinIZyUybJxsO8BpBy4FMqd+bvLc2BxWQZuj
        dWbJNCseYWDBhftlQVwe8r76Dw==
X-Google-Smtp-Source: AAOMgperS9E9ijCE6yt847XtOZRk1Jses2F7ETI8Oy8Gq/7K9dsvlLhFVXxALqYlgeyQNXVCsza3lQ==
X-Received: by 2002:a37:5b83:: with SMTP id p125-v6mr3293355qkb.196.1530657528177;
        Tue, 03 Jul 2018 15:38:48 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id p56-v6sm1827670qtc.7.2018.07.03.15.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:38:48 -0700 (PDT)
Date:   Tue, 3 Jul 2018 15:38:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>, Martin KaFai Lau <kafai@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: btf: add btf print functionality
Message-ID: <20180703153843.7a3425af@cakuba.netronome.com>
In-Reply-To: <20180703152331.151d1c4b@cakuba.netronome.com>
References: <20180702183913.669030439@fb.com>
        <20180702191324.570616684@fb.com>
        <20180702220659.6baa77ba@cakuba.netronome.com>
        <20180703214559.GA4448@w1t1fb>
        <20180703152331.151d1c4b@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 15:23:31 -0700, Jakub Kicinski wrote:
> > > > +			else
> > > > +				jsonw_printf(jw, "%hhd", *((char *)data));    
> > > 
> > > ... I think you need to always print a string, and express it as
> > > \u00%02hhx for non-printable.    
> > Okay that makes sense  
> 
> Yeah, IDK, char can be used as a byte as well as a string.  In eBPF
> it may actually be more likely to just be used as a raw byte buffer...

Actually, what is the definition/purpose of BTF_INT_CHAR?  There seems
to be no BTF_INT_SHORT and BTF_INT_SIGNED can simply be of size 8...
Is normal int only used for bitfields of size 8 and BTF_INT_CHAR for
char variables?

The kernel seems to be rejecting combinations of those flags, is
unsigned char going to not be marked as char then?

> Either way I think it may be nice to keep it consistent, at least for
> the JSON output could we do either always ints or always characters?

