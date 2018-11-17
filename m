Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DCAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 05:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20902082A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 05:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoypZPSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20902082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbeKQPbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 10:31:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42802 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbeKQPbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 10:31:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so8038122pga.9;
        Fri, 16 Nov 2018 21:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAIqBYriKNQ992Kcz0ngZT/o9iu+6/qb/zJzVCiLEAU=;
        b=SoypZPSG4DT/3j74xRVa9NZ1FDd4orLeDorIZ6hpZ8SQJHb0eavbN5Z7erAr9HnN5a
         IHX2mWQPETbZjJU+0KkE3Y7z4DD/vhiCZMYTB+Y5OksmL710UZUmPCOAtxIC46GxDewX
         Zj3Xn1ryPZjEbWujnYUoL1YaMY05lyYgZ+vAo0stjzQbtMh3aR8PzGeS/oCZH1iiNUcz
         wp3Qh9PS+LKty1FAZXuvEfTfU/JKbhttLoUILCmvNisNYuF/CbWMVaBuZMXDxaPqJtPH
         2kMulYEJ965cApBAzrPb5ggj+Z4k7voHh+vZgp1nYrhPoAkpuAs0jMAurzdvLK/tMqWx
         SvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAIqBYriKNQ992Kcz0ngZT/o9iu+6/qb/zJzVCiLEAU=;
        b=g5mLePY7aVtM0ekRcTfzGWrQc0EfOJELmo4tUIgZmm3sCPtuYIhphBt4HUxMl9coiz
         Eyggy7bo2x13pj7CWJQ2a+m1BzKgfLiMDO2I6cq8XxxDMgjQnP8GRNcvZSInNBxbbguD
         C+sJxLiCjdn8b60y9GA6G8rWP3CY07LHHR0nWB/UGD1CQK21RAQar/x11Lub/2JOgBRe
         +M/Hi9vJ+EZRqaMoEBAeMU/VJywC0ucEuJ856i3pyHKGCDZLdSnx7xt9Jew7EiWOzQ9s
         IIj2spWuEKiDdSMNp/9LPh6l2F3E8Q80mQz3fpJFmY61G5P5iBiLZwmKm/EBYQlLTc6H
         9ssw==
X-Gm-Message-State: AGRZ1gIjmsyuIc1keqANetBOQZXVi+e+RSUsxibYvpwVax5FUtFaqIsw
        JtZoSY5yq2i3Fw2c9eBbdfU=
X-Google-Smtp-Source: AJdET5enM8re6TUCubttR0z5k8STHbNVRR4uZNalRxLzYCGjNlKqjv1JN+s/GLf66f0rZKzQFY7GRw==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr1488368pfl.106.1542431735359;
        Fri, 16 Nov 2018 21:15:35 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:eb1f])
        by smtp.gmail.com with ESMTPSA id l2-v6sm29361048pgp.20.2018.11.16.21.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 21:15:34 -0800 (PST)
Date:   Fri, 16 Nov 2018 21:15:32 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Edward Cree <ecree@solarflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH bpf] bpf: fix off-by-one error in adjust_subprog_starts
Message-ID: <20181117051530.kycxzjwbqee6nu2s@ast-mbp.dhcp.thefacebook.com>
References: <bce0322a-6392-3fd4-a6fb-562160c26198@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce0322a-6392-3fd4-a6fb-562160c26198@solarflare.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:00:07PM +0000, Edward Cree wrote:
> When patching in a new sequence for the first insn of a subprog, the start
>  of that subprog does not change (it's the first insn of the sequence), so
>  adjust_subprog_starts should check start <= off (rather than < off).
> Also added a test to test_verifier.c (it's essentially the syz reproducer).
> 
> Fixes: cc8b0b92a169 ("bpf: introduce function calls (function boundaries)")
> Reported-by: syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com
> Signed-off-by: Edward Cree <ecree@solarflare.com>

thanks for quick analysis and fix.
Applied, Thanks

