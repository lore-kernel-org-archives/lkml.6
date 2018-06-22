Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8E724A0B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="t8gdJ7xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8E724A0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934178AbeFVXkz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:40:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40858 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933816AbeFVXkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:40:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id j20-v6so825591qtn.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=gYja3w8tNCXTv8jxC1dnLtY9/e2awhcDEG3Qo+rdcoA=;
        b=t8gdJ7xk3MAur4unKFi8aHTYA4kfuY9PKwdHsuEIyGU7pudBOUN/q1onxZjAI9r3Lg
         Ri2GivMe9oyAuyexYj8ET2I3J/AoHMb811+uiNcopK6YdTTjhynFoC7fpGb9XuNky/se
         41SjqD9jkL8p62TaUc9ctIfZ+hjc88tv1epHf/Fk04kaj5xp+tmPsyS6FUcK2qRPJfaj
         C5Q/7vqk8vCOaZQzJpjRCmJNt5i5Z/ZMtq09Xim4I7kcfGdhyE5EglBGXb/+at7slGzR
         uflkw+uO1uIo8iQGRknNp1vB5V0qYZSZcq6r+5iV454gXQB01WbRFbyTXgA2+Scaz2lL
         rUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=gYja3w8tNCXTv8jxC1dnLtY9/e2awhcDEG3Qo+rdcoA=;
        b=VsP2gxqaQg4w2T6PagEhhoQPTZMhB72Ry+RHpobwmRRITXr4zJYMurdTWsARf0bPk6
         86cCIqaxpMT2GPyYUQ2Rhy6Udiza5IWFM8U3SY/syNvWfiSVtsFaVd735nF4PWx7Uupe
         cGTwbJqrwrF39DBwnD0l+S8uDqs4UNrR+E0euq/9YZeO0l0NAb6zKt2pY2bVR72G6vEW
         FE21fTCsswko4Qh7r2s+FeA3maKkdhd4rxr9f/aqFhnuDE9ekUhUorihyEsQ/443fJJv
         0IYlTEu0yTzaew/3jxQ/9IJ9nzIYAY+d6ey3lZrbzZELYsdtrZUowGM8S6V2el5Wjgsk
         vlmQ==
X-Gm-Message-State: APt69E1LRnwL9gzj18vc0K5bbj6gArtq6WRFO4vZ1/yY08dUjaYezHsO
        KyJ7y9JwBWbq84YdJveS6mSj5Q==
X-Google-Smtp-Source: AAOMgpeqH9gyXysKNEUC3b9hu3iWcr1NSmx0xGMu97eextkZ5JHwfuQN8RlKxlN6pQ3y0/bAa/XV+g==
X-Received: by 2002:ac8:1a3b:: with SMTP id v56-v6mr3191418qtj.316.1529710852720;
        Fri, 22 Jun 2018 16:40:52 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id x53-v6sm1126583qtx.20.2018.06.22.16.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 16:40:52 -0700 (PDT)
Date:   Fri, 22 Jun 2018 16:40:48 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622164048.6283b469@cakuba.netronome.com>
In-Reply-To: <20180622231940.fvkxfqccvyf5uewk@kafai-mbp.dhcp.thefacebook.com>
References: <20180621145935.41ff8974@cakuba.netronome.com>
        <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
        <20180621160719.2cfb4b58@cakuba.netronome.com>
        <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
        <20180621172523.6cd00ed1@cakuba.netronome.com>
        <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
        <20180622114032.162b2a76@cakuba.netronome.com>
        <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
        <20180622142743.2b890d0f@cakuba.netronome.com>
        <20180622144952.353d50c0@cakuba.netronome.com>
        <20180622231940.fvkxfqccvyf5uewk@kafai-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 16:19:40 -0700, Martin KaFai Lau wrote:
> On Fri, Jun 22, 2018 at 02:49:52PM -0700, Jakub Kicinski wrote:
> > On Fri, 22 Jun 2018 14:27:43 -0700, Jakub Kicinski wrote:  
> > > BTF in JSON is very useful, and will help people who writes simple
> > > orchestration/scripts based on bpftool *a* *lot*.  I really appreciate
> > > this addition to bpftool and will start using it myself as soon as it
> > > lands.  I'm not sure why the reluctance to slightly change the output
> > > format?  
> > 
> > Ohh, maybe that's the misunderstanding, you only implemented JSON so
> > you wanted it to be as readable and clean as possible.  Hence the hex
> > output and cutting out the old cruft!  That perspective makes sense!
> > But I think we should keep JSON for machines (but including BTF
> > formatted values) and let's make the plain text output nice and clean,
> > agreed.  
> Right, it is what my earlier comment meant on "this ascii output is
> for human".  We merely call it json because we are reusing
> the json's meaning on {}, [] and int since it fits nicely
> on what we want to achieve, readability.  Other than that,
> it does not have to follow other json's requirements.
> We can call it whatever except json to avoid wrong
> user expectation.  Putting it under "-j"/"-p" was a mistake.
> Hence, I said this patch belongs to the 'plaintext" output.

Yes, that were the confusion came from, right.  I'm personally not sold
on JSON as "human readable" but I'm very far from a UI guru so up to
you :)  

I think it may be good to intentionally do non-JSON things, like use
hex integers, don't put quotes around strings, or always add a comma
after value, so people can't use it as JSON even if they try.

Basic printer is trivial to write, I'm concerned that the reuse of JSON
writer to create a user-readable output will bite us on the posterior
later on...
