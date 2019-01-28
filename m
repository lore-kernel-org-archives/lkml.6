Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFDFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1047220989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="eIpQPffV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfA1RWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:22:48 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:37488 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfA1RWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:22:46 -0500
Received: by mail-yb1-f174.google.com with SMTP id 2so6988301ybw.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AM9RpxkGBW+7XEPrSlC6CHVHJx/N04UabApqCOfk8XQ=;
        b=eIpQPffVfxWr8E9yEMG3n0ynn3souEVAqDMvhCDryU50yKrbIpNetlBt3VoYaoyPUk
         LF10fkm4gH6A9Fa58g8EoXcbtB9qogyY4EVpjtPzp3kcu/yL/74AAVAx57wwPp/4/8Rn
         UrfcMDOGHii4dtnXYeEHe8H1/i962cJG4m0+lU8R5RlzafxoaETi9fVq2xnftuf91c3m
         WSCsCGm/WwzX/TkB32vfcjHehPm8zF01H1uJXzUcHUmTLAzfR4BMvKocYgxHmJpLHVHj
         LntedwSFKNnehqZSLKAArolfqAehbmnZRj+Yw9TLIcY/kWajBlK6cz24rEnqBkqvJHI9
         qcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AM9RpxkGBW+7XEPrSlC6CHVHJx/N04UabApqCOfk8XQ=;
        b=oKVbc7ceKjbbthZKMfy0H/nFsoYRthfwbrSp4yArGuxSkKX47sszE+OBDMQlGBIeXU
         F/52DhYZQcrsm6LKGGN2RRNCys/Wkrr1NFJ/K3FYUBTCZ24oeXTINozS4XDWLeWzmDda
         4X47TDOjnNOLRK5o99/cbX1GX5+q81Yy3NWHlsTKAAMpSNwmdZZJeK+7y/XwQ9u+FhaI
         8uF4Ei5Da84Wt2Yxeim6xZGAiN7Bs2ROkvG84JLAlap7yXF808FOO+ksftsQSXhv7arn
         t4wVcDWOPD4JDdxMG6OD+iYXxW/uBrCFesakuER1k1DMWD3/FaKK6nSuaK+k5x+3ox9V
         H0yA==
X-Gm-Message-State: AJcUukcqp7i6VFrPGRXvQo6gNY/HmPVZvvid/EEC36NpZFV5uwO5GkJw
        atqcIDS4jmccs5qvaerCrhkzKw==
X-Google-Smtp-Source: AHgI3IZM1o+tnMWKnNc4fk/XGgJqN4m/F5bj+p0HNH6ZsqJIhHGKhBrlICXkVaJkIlQHWg5C0p3RVQ==
X-Received: by 2002:a25:b1a6:: with SMTP id h38mr4475201ybj.58.1548696164804;
        Mon, 28 Jan 2019 09:22:44 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:4cb8:dc46:1786:8038])
        by smtp.gmail.com with ESMTPSA id f62sm14397783ywd.68.2019.01.28.09.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 09:22:43 -0800 (PST)
Date:   Mon, 28 Jan 2019 10:22:42 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 4.14 revert "seccomp: add a selftest for get_metadata"
Message-ID: <20190128172242.GA4170@cisco>
References: <8d246df3cdf19608cb6a043bf1dabe8f0adcae6d.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d246df3cdf19608cb6a043bf1dabe8f0adcae6d.camel@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:13:11PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> Hi Greg,
> 
> Can you please revert this commit in 4.14?
> 
> commit e65cd9a20343ea90f576c24c38ee85ab6e7d5fec
> Author: Tycho Andersen <tycho@tycho.ws>
> Date:   Tue Feb 20 19:47:47 2018 -0700
> 
>     seccomp: add a selftest for get_metadata
>     
>     [ Upstream commit d057dc4e35e16050befa3dda943876dab39cbf80 ]
>     
>     Let's test that we get the flags correctly, and that we preserve
> the filter
>     index across the ptrace(PTRACE_SECCOMP_GET_METADATA) correctly.
> 
> 
> 
> PTRACE_SECCOMP_GET_METADATA was only added in 4.16
> (26500475ac1b499d8636ff281311d633909f5d20)
> 
> 
> And it's also breaking seccomp_bpf.c compilation for me:
> 
> seccomp_bpf.c: In function ‘get_metadata’:
> seccomp_bpf.c:2878:26: error: storage size of ‘md’ isn’t known
>   struct seccomp_metadata md;

Yes, agreed. The get_metadata() stuff went in for 4.16, so anything
before that won't have the struct. Sorry if I missed the stable commit
before.

Cheers,

Tycho
