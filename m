Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E92C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EEF2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrXR0tGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfBEIez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:34:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38661 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBEIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:34:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1180103pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vr4fVT+hNY5Y7ABVbkztYRm+pgJ5HItCTKaQ9rit0g0=;
        b=rrXR0tGyTfHkW7OrBvGKgWNM3nLM4lLsDEzttZ0xhfb2hi7iDDrStn4CR8Zg2QWSY2
         2/f9DRZAvNjcbk8kkh5oWRDHnpoMqekprAxZG319tK69nX1qjyppkkIcwNEBN26l49h+
         awPE/mT213lWupD+9Ca/uyWW484+OtMYaoN0bHj79wwacEj9l4BYYW+1sCUmTJlTfuku
         6nxvzbeIuyLrB5X5U4KkJpYT0FbzIFE72AgcnY5Tt3rUnbDD6/0M6JIy+mlmbdq9AaCD
         PBixe40CsRyUuqmW5GZy91FqHfq4svkQE82noxTmkr9eXVJuWmH/0ZAzc7hlQABHdx0A
         pvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vr4fVT+hNY5Y7ABVbkztYRm+pgJ5HItCTKaQ9rit0g0=;
        b=juRfHPzbwwSYEmtkcejnWqfMqYXwNdS0Ix+0rK20S41J6wiZdUmah2WYAayZ5VJcv5
         e5jVAASSkcHj1n920zBkIaz3Ax6HELRtqF6UjgXVHemHZkhmzwbLGp3ifQaTqttpcQut
         PqI5VQ/L0FsFz3mVNexz/gUMga6DguvgzZjsDPU24p5IY1SgXbeL1Xnei5kouNgfmd4S
         vcc4Cpj38twNLgP1U48u3Cc0nSUpTbLmMYtSO5ykPh4kLrNlg/yWZ/RNCT3QUdLU6H+r
         z59jWNdWy0lrjlfQc+80tCmkUbiHOClh+RcH3DGswEFVpOR1PXKzp4lw2Rcm9GVsPAII
         4rKw==
X-Gm-Message-State: AHQUAubJJMAVwgNP6NiVF3DLP6TXQuOOxp0oe4zh6fIl5z/+45CUpdor
        02z5hUw8OUc1F3ud9OOj3zg=
X-Google-Smtp-Source: AHgI3Ia4i+v9d/EE0tzzG37Oa/hukOjQhDcAtlbSXvMYKiuz8r9dVH4h+vlAg8sCBBH1Xle7TbF2dA==
X-Received: by 2002:a62:2044:: with SMTP id g65mr3749012pfg.127.1549355693335;
        Tue, 05 Feb 2019 00:34:53 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w184sm2754333pgd.34.2019.02.05.00.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 00:34:52 -0800 (PST)
Date:   Tue, 5 Feb 2019 00:34:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1 3/3] cap11xx: fix potential user-after-free on module
 unload
Message-ID: <20190205083451.GC118684@dtor-ws>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-4-TheSven73@googlemail.com>
 <20190205081846.GA118684@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205081846.GA118684@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:18:46AM -0800, Dmitry Torokhov wrote:
> Hi Sven,
> 
> On Mon, Feb 04, 2019 at 05:09:52PM -0500, Sven Van Asbroeck wrote:
> > The work which is scheduled by led_classdev->brightness_set() is
> > potentially left pending or running until after the driver module
> > is unloaded.
> > 
> > Fix by using resource-controlled version of INIT_WORK().
> 
> I believe this is wrong way of fixing this. The LED classdev objects are
> refcounted, and may live beyond the point where we unwibd devm stack,
> so we are still left with the same use-after-free that we currently
> have.

Hmm, I take it back, it looks like the lifetime of the outer structure
is limited to the time while driver is bound. I still wonder if using
set_brightness_blocking() would be better fix?

> 
> This is a general issue with LED subsystem as it provides no callback
> for properly tearing down device structures, but I think in this
> particular case we can simply switch from set_brightness() to
> set_brightness_blocking() which will use the work item internal to the
> LED classdev and that one is being shut down properly.
> 
> Jacek, does the above sound right?
> 

-- 
Dmitry
