Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA75C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1CE208E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaRT/mE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1CE208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755263AbeFRPh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752849AbeFRPhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:37:25 -0400
Received: from jouet.infradead.org (unknown [187.65.76.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC391208A5;
        Mon, 18 Jun 2018 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529336245;
        bh=p7oJ4/FI75CilAmQ8QJTHel+mPrEsWaGX4MfD7s6Beo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JaRT/mE4Ht9aNT4QBkjbrWP0heu6DRM17O0+ztMl63OjGaKTICd+xfnND7IJtapK7
         E/IPEqsP/7pMYkdt+DCl+xxeDUAT8cWq3u7D5XE3FnINtLEAy3FaSIb1ce/jSNE0Pv
         1kTWj6zkTBXbHD/N3e4XnZF8ZmDoNeVBI2zPCLug=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 88B451457B8; Mon, 18 Jun 2018 12:37:22 -0300 (-03)
Date:   Mon, 18 Jun 2018 12:37:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: perf tools: LIBCLANGLLVM=1 build broken with llvm 7/clang 6
Message-ID: <20180618153722.GD20477@kernel.org>
References: <20180616122608.GM30043@kernel.org>
 <91a76633-54e4-984d-cb68-ca0445146b15@fb.com>
 <20180618143139.GA20477@kernel.org>
 <9dcfeab4-3324-1e26-74b5-4d182a47f834@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dcfeab4-3324-1e26-74b5-4d182a47f834@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 18, 2018 at 08:10:27AM -0700, Yonghong Song escreveu:
> On 6/18/18 7:31 AM, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Jun 16, 2018 at 10:20:21AM -0700, Yonghong Song escreveu:
> > > There is an interface change in llvm 7.0 (trunk) for function
> > > llvm::TargetMachine::addPassesToEmitFile. The following patch
> > > should fix the problem.
> > 
> > Please submit it, I just tested and the the build finishes Ok.
> 
> The formal patch is here:
> https://lkml.org/lkml/2018/6/16/92

Thanks, hadn't noticed, applied,

- Arnaldo
