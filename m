Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D09FC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA5A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUgMfWoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbeLUUqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:46:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38486 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeLUUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:46:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so4782463lfg.5;
        Fri, 21 Dec 2018 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YzTkR9BNBWUqZdu1WinO1y3fXqqcn1E1mNHboe8f5k8=;
        b=LUgMfWoopRUJkkXVRKrbYqfGi36+6m+5oCCltcop5jljtrlLowda6OVtJVgQVYLk6g
         GqLjVmcwMgnqhvaamDWjFtZJZzDofZspFTdoONQj7shqokI74QUAEIA9NG7kIcijwLBw
         RvfqeZIAM3ZhOhtZGHqO3ECOTsBglNldroT1tyhDH7ux/sJFHasYxd1D/MVkTQjzqDRl
         /kJZqJwwe3OoN7nxZ2znvmuwrw9wj9T1Zp2Mvsoi36dZOetesAP4GRBA3hbHgPy0MlKe
         /L61Qpp0rqjoDcSaIs7HaiYueL0is6lhArzs33mjnQ8X/rEu8whvQIqdw6WKz5gvHx4b
         wsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YzTkR9BNBWUqZdu1WinO1y3fXqqcn1E1mNHboe8f5k8=;
        b=RAe7iUPhP56ZHXCWi0ZD15VGE/vcmL6xugYQCnz8+I64zzxIU/zK9EB6PUKzHpKnez
         nDce3Gdy9YOEmg2EiSlRntgEJ+p4I5dAvjwLluw3TY1Y/LuijPqhkiO2nWzqSeiSXYaz
         XDSO67rfcmuZWIP/IjpzGYFdOp6d/7N+gWkKln6KSgqgFFCMeCROKKhXoJAI8ncw+py9
         TsZCt1IItWqxoN9LkZy+cR7vR4KLskH8PVP/YiQxuo5A2MGQvbuf9f5pmW9lOrtznFD+
         IVtyhvS2i8TWR1tGlcq4KRrGxW6ADF8wBXvUg0snPBHrmN7hUtuLM1xThFMPjNZjIPU2
         UDIg==
X-Gm-Message-State: AA+aEWYflkxS02xJO6EGcglXEmgJ1r0ZElS9EIdDxdFOz9BvQtI6/vTy
        cpCIMIa0J1fcpgHiOPW5+ZQ=
X-Google-Smtp-Source: AFSGD/WLuLixDjoz08kDRZT/mVNPx7aK8oeCqj9QgDMCuokmSWLjkPyFJC2rQ9iRNiVYu6DZZOmt4Q==
X-Received: by 2002:a19:8d01:: with SMTP id p1mr2112654lfd.149.1545425177149;
        Fri, 21 Dec 2018 12:46:17 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id p91sm5155852lfg.4.2018.12.21.12.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 12:46:16 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 22E2A460769; Fri, 21 Dec 2018 23:46:16 +0300 (MSK)
Date:   Fri, 21 Dec 2018 23:46:16 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] x86_64: memset_user()
Message-ID: <20181221204616.GC8441@uranus>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-2-igor.stoppa@huawei.com>
 <20181221182515.GF10600@bombadil.infradead.org>
 <20181221200546.GA8441@uranus>
 <20181221202946.GJ10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221202946.GJ10600@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 12:29:46PM -0800, Matthew Wilcox wrote:
> > > 
> > > That's inefficient.
> > > 
> > > 	pattern = (unsigned char)c;
> > > 	pattern |= pattern << 8;
> > > 	pattern |= pattern << 16;
> > > 	pattern |= pattern << 32;
> > 
> > Won't
> > 
> > 	pattern = 0x0101010101010101 * c;
> > 
> > do the same but faster?
> 
> Depends on your CPU.  Some yes, some no.
> 
> (Also you need to cast 'c' to unsigned char to avoid someone passing in
> 0x1234 and getting 0x4646464646464634 instead of 0x3434343434343434)

Cast to unsigned char is needed in any case. And as far as I remember
we've been using this multiplication trick for a really long time
in x86 land. I'm out of sources right now but it should be somewhere
in assembly libs.
