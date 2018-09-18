Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02EBECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D67521471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1nNmqYD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D67521471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeIRIKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:10:18 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34884 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIRIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:10:18 -0400
Received: by mail-qt0-f173.google.com with SMTP id j7-v6so400152qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 19:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=uhZtkHSpXX133fPIuV6zCz/NSCnTt1F/5Lk50DIbj/k=;
        b=1nNmqYD9fol0fzvqRkqGlTvQHkYf7xKcKpQxY86IhXNHzyE33xZNC34rtMY+cqGTQP
         vWSunv1xSsssADP4nvwvolMxrZNEb93iBl7leGToPNt4MrNb0oeJ0kvrsiE9hsJX81a2
         +d/piJE4c8ym57b8XWQSDNKio73+iJByZ8QP4Q69myyrFJHhhNFVOerX3gqqN9dRs+uR
         S2P7ilyJmn14RLENoFa37I1/9C6cAzTkvEwL9gz1C4HxPIKl88vWE5KwzWue7OwKryGP
         6UxhKI0dRLBEqmg8MAhWwNcyu67id2mPRm4L44pZ2R0vqIVPLbTqa3P1t+26kDZWUnAD
         AIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=uhZtkHSpXX133fPIuV6zCz/NSCnTt1F/5Lk50DIbj/k=;
        b=Hv7a/r4yWhhU6vICzLsNrtrfYiYZ1bbrQP/bUC9qP7ZDzrulDYY78bQbDdkfMa+/X8
         4BfCwqK+fqK9XfK7HwKxngJR9cnufXRwMqypeLCEv6jsdMWDkgQR6Mr+PvrciGQzPZfJ
         sY7vVjefFBnrKRNOkAIVKfg+tOsvCPmlm8SuL2jrvLSUeS2JAybtmsGwrFBAjQhPxrIZ
         IN7Rvsh45qzLNfFuWX04mw0xD+BOQ6+RJhbge6zxaoNjA+oSm3iWchEquIQVXAs7TBPf
         aQdDwtNHjIv0FbhY2h/5t6yfdyeCfhvk7a6LkvYNiY5aWi3g4Z52sOI7JfoO8oIbReDr
         IGTg==
X-Gm-Message-State: APzg51AtYlP20xjHBrNHAIt52GWGWqqGIp1HY5rHsQc0X0ILLHl8JUPD
        TD7nRnh4Wjf7ZsVCVx0DDTisew==
X-Google-Smtp-Source: ANB0VdZTtg8MQ/Mlzjxu45s2EqyycF0xAf2UtJmbzel96tdTiRIQrHh0QU9/mXmyrWZFpooBnctQsw==
X-Received: by 2002:ac8:1699:: with SMTP id r25-v6mr19936647qtj.23.1537238399169;
        Mon, 17 Sep 2018 19:39:59 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e206-v6sm8602337qkb.4.2018.09.17.19.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 19:39:58 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:39:52 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC/fix] Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180917193952.6709fd1b@cakuba.netronome.com>
In-Reply-To: <20180918005256.7uutwda4s3ofoxpd@ast-mbp>
References: <20180910172903.GB15516@kernel.org>
        <20180911122218.0d2eb3f9@cakuba>
        <20180911121543.GB22689@kernel.org>
        <20180911212451.hvnyfwyvcs4yojqy@ast-mbp>
        <20180913183240.GF30969@kernel.org>
        <20180913185629.su22fnimluoezntg@ast-mbp>
        <20180917151636.GA21790@kernel.org>
        <20180918005256.7uutwda4s3ofoxpd@ast-mbp>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 17:52:59 -0700, Alexei Starovoitov wrote:
> LGPL-2.1 in the above?

Could we possibly make it dual licensed LGPL + BSD?
 
> The rest looks good to me.
> Should we take it via bpf-next tree?
> If you feel there is an urgency to fix musl build, we can take it via
> bpf tree too.
>
> Jakub, thoughts? you've been messing with strerror last..

Sorry for the mess, I didn't know libc compat is such a pain.

I kind of knowingly ignored the existing str_error_r(), as it didn't
seem excessively clean.  Yet, two months later I have no better
ideas..  We could as well switch back to the XSI version, which we used
before I needed access to reallocarray() (I mean change the str_error()
to be a plain XSI wrapper).

Perhaps placing the new helper in libbpf_errno.c file would make
sense?  The only reason for this separate file to exist is in fact to
make use of XSI-compliant strerror_r().

Also, I need to go relicense tools/include/tools/libc_compat.h ASAP
too :S
