Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E0AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41787206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1Ct3iNz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfBVVpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:45:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40038 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfBVVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:45:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so4241658qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=66VwxeAjA9qcjOpkMJ19PprPTGhjjSTVlBu4uVBTGjU=;
        b=1Ct3iNz1PDP7ijqGVeyx2MpPw4dkQfSt7CTuoWg90qkrGEPcIgEnNPrRa3e+fRGZnB
         PJy73ZRADYF1i+Cis2lLiK9KZbfXGbqlLkvafG8WrmW8UR4isrX7zj4HV5DS9YjBcZeh
         1Fs/RvKDGLnaI8ND2zqHzsgjAALmItqT3AqkwcFXcY4sU8KuEjFeJfkWE9KJKE10w/+v
         /rFjr+abhTVuoW+tWClmSWkngzI+p+aWje/0i6SVFJMUeN0lvJV2w6NFZ8zvz2ZmJbfD
         K+dgP6B7YOh/yDU8rAsnmpj/ST1IOqWUZBmN3jrV4DDLJ3PDCBdxJgsMTdeAdPPLIq5h
         t/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=66VwxeAjA9qcjOpkMJ19PprPTGhjjSTVlBu4uVBTGjU=;
        b=Gzi1ycFhGTlDXAMAAPKJWh9JvS6HGcTxEiozrTg9uhll3xA046V4+Ou7ZyU7lEgXbf
         enICRTAe87hFXmMxFo2Z5xRRFtTz/yyAu9Egylyy4dKdXz01OjSfuzgvT9+PasGflNrO
         mXJC0zqjwYT7Fu/8BZ1N00nW4nfRLQqd1K074Um0HxKPIUXZiIEJsBjhbALRRpAGU+Uy
         IQA4to0GEnaFyx9w8mB/ZcRij1wN+P2X76N6YFn/tvknFwo60b2jiZ4df9wk4Mqps4HZ
         gGmxRoLMhqjq3mqyQOtIPD9pPYaxbLuL0EclbKKoBuQkvoRmdeN3Nkc3YHNe+lj1GtKp
         DBfA==
X-Gm-Message-State: AHQUAuZ/4uID0WZilGiV0adfTXu1DjnMOWRLH/VRPNuiiMykoOCJ6E4G
        4uaAK8CJbGBJWA+JQXS87No+Qw==
X-Google-Smtp-Source: AHgI3IaFa/yvIwtrpWBzsWdwaNrDSP4ZVDkuY0QKMJtTLN75+oeX9Ztk6wAJ2p4Kn1ecTh/URCptyg==
X-Received: by 2002:a0c:d165:: with SMTP id c34mr4894294qvh.64.1550871915785;
        Fri, 22 Feb 2019 13:45:15 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 70sm3202928qkb.39.2019.02.22.13.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 13:45:15 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:45:11 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Joe Perches <joe@perches.com>
Cc:     syzbot <syzbot+8218a8a0ff60c19b8eae@syzkaller.appspotmail.com>,
        ast@kernel.org, christian@brauner.io, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, hawk@kernel.org,
        idosch@mellanox.com, john.fastabend@gmail.com, kafai@fb.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, petrm@mellanox.com,
        roopa@cumulusnetworks.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, xdp-newbies@vger.kernel.org,
        yhs@fb.com
Subject: Re: INFO: task hung in rtnetlink_rcv_msg
Message-ID: <20190222134511.13eb7a82@cakuba.netronome.com>
In-Reply-To: <e049375f676938b5ad64898ac928b27cd783dc2a.camel@perches.com>
References: <000000000000c07a5805827e85d5@google.com>
        <20190222120129.1f2f1c17@cakuba.netronome.com>
        <e049375f676938b5ad64898ac928b27cd783dc2a.camel@perches.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 12:14:57 -0800, Joe Perches wrote:
> On Fri, 2019-02-22 at 12:01 -0800, Jakub Kicinski wrote:
> > Hi!
> > 
> > Seems like something funny is going on with get_maintainer.pl since XDP
> > entry got added.  We seem to have been CCed on:  
> 
> I suggest removing the MAINTAINERS line with
> 
> 	K:	xdp
> 
> as xdp is a pretty generic file/patch content
> regex match for the K: type
> 
> $ git grep --name-only xdp | wc -l
> 236
> 
> Rather more files than desired.
> 
> The N: match is dubious too.
> 
> It's generally better to have specific lists of
> maintained file patterns rather than using the
> K: and N: pattern matches.
> 
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7ad97b235ec..aa703e2cb882 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16970,7 +16970,6 @@ F:	include/net/xdp.h
>  F:	kernel/bpf/devmap.c
>  F:	kernel/bpf/cpumap.c
>  F:	include/trace/events/xdp.h
> -K:	xdp
>  N:	xdp
>  
>  XDP SOCKETS (AF_XDP)

Thanks for the explanation, at least now I know why it happens! :)
I'll leave it to Daniel to decide if we really need it removed, 
so far the false positives weren't overwhelming, just surprising.
