Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C504C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4BF206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550859467;
	bh=APIt6uYYZTYXab6r82KKFiC7kwns/nJwl9ifWgi4Seo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L2afLUc576/KOBEplSK7h3nHvF/MvknqUfsqKSGhwbCAj8zuc0mkK9eEMEbN8B7/B
	 cfKVPZeHPUallSCPqrPYcXCslKKAD/wsNlrZBkbBbkRK3iD6QWZUNIYzeZsoRi+GJa
	 X2cF0ElYlpAcbKkwb3HfJ5sSP+XqSN7DO2QYs1cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfBVSRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:17:46 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45595 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfBVSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:17:45 -0500
Received: by mail-yw1-f65.google.com with SMTP id r188so1041239ywb.12;
        Fri, 22 Feb 2019 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0bawKPdSciLwxYkj5tT0CcwjFzFD912EtDh0Rtp/xl0=;
        b=UUIgJ9YCbjXdf5DGn47xL/rjuyMZs7+Z8zc/LuZDzDKENNi95g3fuW7QPG8JOJyyga
         D65YjVCHZRrD36AzY13M4HPg8nKmaW5e2CPnXU3IPK14ACiMw4irkqoL0+AUgMMK5H5w
         +K/qzCE3dzl0kNlm9trrgVWusOuf3yiSD+QexEthHcF+tz/tvEFrCY4mE00nRql/YQaE
         5Z/mdn5M/QRpfv6AMOut0G22KGtmb9/T4C1NGcvsOuhFA8vVmCqCFZ/sRJnsIPcf2KIS
         0ocbx997oHZ/C99HtIkcDywlGg2CWHZ84z3awRuOLjGK1PQHL875nmBAMeP3nmcorP1/
         HTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bawKPdSciLwxYkj5tT0CcwjFzFD912EtDh0Rtp/xl0=;
        b=DBJcAPqNtHOn9SJqXOcJb9vwj58aLfS4JnCWuuCIrxjX9Tf2TZqb4JRFZXD6m64Ho1
         z89vEWPWtBPiywJSiIZAB3VtLK0OaBqMAFiYx+1EtuPOoS9GktH9sL3ZoKzzdVEip0MN
         bIej+S2COFPo2Iai81DifH0zUVPNTT/U+w+1ENV/u8tertcvuGMEvuc8xLM+uqrN7tOj
         kXWJ+bfdoFMU+l6wxAa3RImontgLFo/ONpI5XyCcEf4xxSMfGTNnvfsAYbMbcB4VACBE
         0AS7H+QAC97t7Tgf0TBvx+2wTkXcy4Sjc9YIGpUihD1iH2LLjqo5ooUO0yXb/8Mlmu4/
         GETg==
X-Gm-Message-State: AHQUAuY2dvhVMD7pwaBfsBLu4ayl675puim1utqx60r/vCU41enIFaOf
        7wxMl/V37SfrtmjW3qYF74U=
X-Google-Smtp-Source: AHgI3IYKASMv4UO1BtNteeuWVbB3VxlR2ScrjXm6pRnG8vNDWKBJBdv1Prjmg6h9Tw5OmHI1yG622Q==
X-Received: by 2002:a81:5c89:: with SMTP id q131mr4208715ywb.90.1550859464560;
        Fri, 22 Feb 2019 10:17:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1:6831])
        by smtp.gmail.com with ESMTPSA id l73sm748003ywc.70.2019.02.22.10.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:17:43 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:17:40 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, Roman Gushchin <guroan@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Message-ID: <20190222181740.GZ50184@devbig004.ftw2.facebook.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190220143748.GA9477@redhat.com>
 <20190220220020.GA16335@castle.DHCP.thefacebook.com>
 <20190221162923.GA26064@redhat.com>
 <20190221173422.GY50184@devbig004.ftw2.facebook.com>
 <20190222163441.GA5596@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222163441.GA5596@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Oleg.

On Fri, Feb 22, 2019 at 05:34:42PM +0100, Oleg Nesterov wrote:
> > ptrace support is a lot less important than kill for sure but if at
> > all possible I think it'd be better to have it
> 
> Tejun, I agree it would be better. I did not argue with that.
> 
> The question is how this can be implemented. And how much uglifications^W
> complications in the core kernel code this needs.

Yeah, sure thing.  It's always a trade-off but given that this is
something we're gonna expose to userspace as an API which will be
difficult to change too noticeably once released, I think it'd be
worthwhile to spend some effort to get the visible semantics right.

> > To summarize, the ideal result is the frozen state to be "stuck in
> > jobctl stop loop"
> 
> Not sure I understand, but I don't think this can work...
> 
> Let me repeat, imo the freezer should be "reliable", it shouldn't stuck
> in CGRP_FREEZE state forever if, say, it races with vfork(). And personally
> I think this is more important than (very limited) ptrace support.

Absolutely, it makes no sense to ship it otherwise.  I don't think
anyone is saying that we can ship it while it doesn't work reliably.

> So I think it too should somehow interact with freezable_schedule/etc.

You mean freezer_do_not_count(), right?  As long as the task is
guaranteed to be trapped by signal stop afterwards (and they are), we
likely can use them the same way.  The only thing to be careful about
would be ensuring that we don't end up flipping group level frozen
state inbetween.  Would something like that work?

Thanks.

-- 
tejun
