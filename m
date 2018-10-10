Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A4EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8270C2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfDF9hZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8270C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJJMH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:07:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38634 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJJMH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:07:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so1898297plr.5;
        Tue, 09 Oct 2018 21:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6iQMS6k+ft+38zYvnYydH29GFFaar9ix12xEzaKsbkk=;
        b=MfDF9hZ/d9s930ycO84n0Hqf7UIl1J9Yhn4XLs2e+Ad95RqyY1BaRhjnQo7qeTbkQy
         uOmMJryPETcCFhguL4BWWNwaHrGDSxgM0H9M7vlTD2rlxn55LLdkgN/n6J1v8SC084b9
         ssFFW7ndngTvoh9oHgEPu0zm1G8et8dH8X6Hqjp6kCJlOuixIcIGSpEI4hpgpQy7nNkR
         4xnhgD/G2fIhUo8Z5Q6I+S3T3tczJrFCpuXFp6upclER80lCd93TAdzRFCSh7meI6fOP
         aAogMIMyZbxHM/YyKNrAmZSAMPswpyAf7R7Pmno3qbxACsAexQ2fmIMsKyDbCZzveZ5W
         SGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6iQMS6k+ft+38zYvnYydH29GFFaar9ix12xEzaKsbkk=;
        b=r9LN2ZH+08QlpG4Lsodd3GxqOwK+V+f7GEl8cwgPfWL9ZGPWu0m2hipErdC8f9pL1h
         5uRQKEvYtVpqKQGbHHXSNCtc1BT8yEuRzve6NRTKpO3IomgYdhIcHSoTJ1dnutmzPzQr
         lH2YL3ftJ59eKaTsscsUUhWFpr+76qn8uXxjRJDf6+S+UPE3LQAzp6bCWdBRhPmEF7K5
         G7Gc8hwrMs4EY0URwWEKnAG7rzrbuwLbOrWMhCQPg1qvhYWx96diyZnwhANHw1fBJgyJ
         oe/UlavIMfHRL8KopB0JJvOCqR4QibDs6gNK9oX6JJ11waWoJg8pg9RrDxlo2aLcW9dy
         zq0A==
X-Gm-Message-State: ABuFfoj9lman4zFKKlpxFmeAVc/P3Rt94tZ3cGbzZdj/gh5LvHay+ll0
        LIlF3qr+eJgeuIRQ1IGI5uFkQBRM
X-Google-Smtp-Source: ACcGV61r/CTuk3MMJapf2YhOQDPqPC1tTzdyBZQKJsAk3oF26v+HdC61zFOMdOmPezKgyxbwEB8BHA==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1-v6mr31794562plb.129.1539146859814;
        Tue, 09 Oct 2018 21:47:39 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:4706])
        by smtp.gmail.com with ESMTPSA id l83-v6sm55676568pfi.172.2018.10.09.21.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 21:47:38 -0700 (PDT)
Date:   Tue, 9 Oct 2018 21:47:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     valdis.kletnieks@vt.edu, wang6495@umn.edu, kjlu@umn.edu,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: btf: Fix a missing check bug
Message-ID: <20181010044735.akxel4pjncafpjcf@ast-mbp.dhcp.thefacebook.com>
References: <1538943795-30895-1-git-send-email-wang6495@umn.edu>
 <CAPhsuW5vnVjRS7DWFYPSmq5G-dAFxOrHCAOMkK-iaOoirzMazQ@mail.gmail.com>
 <43898.1539033428@turing-police.cc.vt.edu>
 <CAPhsuW5nPGMOEMKa1UFwgquoUeYiUV8i8nVgWfM6McH2Ri1esg@mail.gmail.com>
 <9337.1539047240@turing-police.cc.vt.edu>
 <CAPhsuW7-Xa=_2BTATEhthWnyfETPv173p_cG2YrcCZ0BOsS9ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7-Xa=_2BTATEhthWnyfETPv173p_cG2YrcCZ0BOsS9ow@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:55:15PM -0700, Song Liu wrote:
> On Mon, Oct 8, 2018 at 6:07 PM <valdis.kletnieks@vt.edu> wrote:
> >
> > On Mon, 08 Oct 2018 17:44:46 -0700, Song Liu said:
> >
> > > I think I get the security concept here. However, hdr_len here is only used to
> > > copy the whole header into kernel space, and it is not used in other
> > > logic at all.
> > > I cannot image any security flaw with either hdr_len > btf->hdr->hdr_len case or
> > > hdr_len < btf->hdr->hdr_len. Could you please provide more insights on what
> > > would break by malicious user space?
> >
> > Say the biggest allowed value for hdr_len is 128.  We check the value, the user has 98.
> > They then stuff 16,383 into there.
> >
> > Now here's the problem - hdr_len is a local variable, and evaporates when the function
> > returns.  From here on out, anybody who cares about the header length will use the
> > value in btf->hdr_len....
> >
> > (And yes, somebody *does* care about the length, otherwise we wouldn't need a field
> > saying what the length was....)
> >
> > Now think how many ways that can go pear-shaped.  You copied in 98 bytes, but outside
> > the function, they think that header is almost 4 pages long.  Does that ever get used as
> > a length for kmemcpy()?  Or a limit for a 'for (i=start; i< (start+hdr->hdr_len); i++)' that
> > walks across a variable length header?
> >
> > Can you cook up a way to have a good chance to oops the kernel when it walks off the
> > page you allocated the 98 bytes on?  Can you use it to export chunks of memory out to
> > userspace?  Lots and lots of ways for this to kersplat a kernel...;
> 
> In current code, I don't thing any malicious hdr_len value could pass
> btf_check_sec_info().
> On the other hand, I agree this is a good-to-have check.
> 
> Acked-by: Song Liu <songliubraving@fb.com>

I agree with Song's analysis that the current shape of code in
btf_check_sec_info() has us covered, but it's a good coding style
to check for TOCTOU like this, hence applied to bpf-next.

