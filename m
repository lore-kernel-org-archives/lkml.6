Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93842C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F13D2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBT3u0RF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F13D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeIFACw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:02:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38163 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIFACw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:02:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so8870459wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYWnNOuDntYq+Cq7OYVtuPgtJ6lreVoeLPYwlJ4Uuw0=;
        b=IBT3u0RFqRM2OMqctjYqwYVYsuD2ijH/NyimLDWc4hLlOQhPY5kND5awhJaoPMCNOD
         fUywfxsVFRpFSckK1kg3/icSaModoyvxL358Q1t6EbR/LdrKfoJPBCwqkB6o9HbzfTSR
         /x7+RoNFmu/S3chNhp5FdQQPG8uh3QFpf+T42DnrSOqxEny0JhvDJv1JfECURpJJExku
         wOWYgtnnAyGoCQTBt8M0aYNvchWNdAxj0tSf4Z28px+dW74DwbtUZNCb4IOHRDlovQ5x
         1Gkn6+CoEDeqVAYNzXuB7RbDeAFIgHHN2mvyyl9OmlhMS2lnnWis5eC4uksmDJDx0U3y
         msNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYWnNOuDntYq+Cq7OYVtuPgtJ6lreVoeLPYwlJ4Uuw0=;
        b=NbklupxTmHCdCwuwLKrKnJteAQQNellCSzC+kkBFerD3WWwo5HzAdx9kpUdSivNnqQ
         F02I0MpQ+Oav0epQTVy0bZ2OjP1TGjueS/C/Jtl/if5+7I8v2MGIRvz5sSgclTi/O623
         OCfR3J8hD8kV+I2yZ1H0YmfBv1o5hPDfB3YTf9MocZ8DOgOPDogsojD+5ImjVqCgSC1L
         vtcNT0mruVT4jIxWMaEDsHe97DLjCzTGjbF3r6BdKq0KZ37TiOfojnfUpKCZ1OlJNJmT
         Hkr5srKc4yCwwuNoUUomynQiE75zcoI4MqOpTdHPej3UldPDWwWvxsfZI0CV6xseSBot
         kihA==
X-Gm-Message-State: APzg51A7DB3oVt3jps2ebm/DN+9fefgzAuTXGGzJr9Pn+Lsk+l+G3A2H
        9s54yPprhIAuEEZlZs+BUA==
X-Google-Smtp-Source: ANB0Vda+x933lpe4j0Gryr/utpy3IG8qLioLgHYH5xM7tVtvVGEiUiA6ca1VibmKk7lgp6f/cPKZZg==
X-Received: by 2002:a1c:e581:: with SMTP id c123-v6mr1179476wmh.85.1536175874702;
        Wed, 05 Sep 2018 12:31:14 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id r13-v6sm2325660wmf.35.2018.09.05.12.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:31:14 -0700 (PDT)
Date:   Wed, 5 Sep 2018 22:31:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Message-ID: <20180905193111.GA27217@avx2>
References: <20180905185922.GA25461@avx2>
 <20180905192636.GA13608@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905192636.GA13608@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 09:26:36PM +0200, Greg KH wrote:
> On Wed, Sep 05, 2018 at 09:59:22PM +0300, Alexey Dobriyan wrote:
> > > On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
> > > > 
> > > > Here's a set of patches that inserts a step into the build process to make
> > > > sure that the UAPI headers can all be built together with C++ (if the
> > > > compiler being used supports C++).  All but the final patch perform fixups,
> > > > including:
> > > 
> > > Wait, why do we care?  What has recently changed to start to directly
> > > import kernel uapi files into C++ code?
> > 
> > I think David is seriously trying to compile kernel with C++ compiler
> > and this is first step.
> > 
> > He isn't alone. Resistance is futile. :^)
> 
> "struct class" is going to be a hard one to overcome :)

"struct class" makes you hostis publicus #1 of the Linux++ empire. :^)
