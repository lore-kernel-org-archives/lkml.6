Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1A1C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530C320824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="P8M/O4UL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530C320824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJXR63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:58:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51626 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeJXR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:58:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so4587654wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/7S/afXrqf0jMyOibonXJpUE1HxzeHH0oIsO1EtkRw=;
        b=P8M/O4ULzssgmInq5u59Xn+3WFU8EyzWSIOEj0jvROrC7ramp5md63XC6DmSf0N3lg
         X2qfAfNDh0CZNqzBuCUxJkD1N/gw312LK3O1h/mFW904qZ5Q6A/XDejes23skaxvkZ2a
         LLM2JpD6yil8AoBQ7N8d3h9dn6yILnjbrAOgx2BqJOBSOPMd8epKEgh7xsqBS6wOxiMk
         d95+ff3eB/wtsxt2yRjSelHRdlGx1qYGQli+/8b/JtWqYCzwKGbwqyan9xL/n9ShFpvj
         E5tL1QB8h5KGB/K3y6KtjPfXmLOa4aa8StTEh71liMPSgRQia7nYHUIvwnNnhDMuluAe
         vu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/7S/afXrqf0jMyOibonXJpUE1HxzeHH0oIsO1EtkRw=;
        b=WiwJ76pqTK9CS4YLZgvmiUZ+AbMQKfdSX6S1sDjLMg1tPokciUb24q5O8HCLgXaBma
         d3dvyJH4AqMhYCYFR+kpp0QEGhlGnLx1sv6TZj7k+vwtb5E9Cl37PBzB6Cj0gakXEAZq
         GkFk/mzSksuJtICe6CSM96m9JZeqK+fMg3iDSENsrDdwBHKwphrLOQxI8KOacWNZ+7sm
         Tw1DNzzbWY6E3RttkoTGEYLVKBe2sQuyWIvi9PL81/Gz6z80sU3rYdieFh2gPEbAergm
         495LWeD04y78/OMb69VLFkn2C/yAmE6F/QyUO+PSa8sOZB/yx4d8HIsbIbZsdc26sf4n
         ttUQ==
X-Gm-Message-State: AGRZ1gIhDTCFCSBxdJpOk64WqjH2YWu2lX5ftzXG8byHMGITiiRMw/8S
        a88x8R2Ppc/38+0U13o5MJBM/Q==
X-Google-Smtp-Source: AJdET5cDqTflHFwFcQV/PL975AAD/p4ucBjxzt/uacUS65LYn8YdAky8W5ysoZ+ZIiveJSANPPcifw==
X-Received: by 2002:a1c:4a:: with SMTP id 71-v6mr1737456wma.96.1540373466278;
        Wed, 24 Oct 2018 02:31:06 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id g4-v6sm2805350wrr.95.2018.10.24.02.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 02:31:05 -0700 (PDT)
Date:   Wed, 24 Oct 2018 10:31:03 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
Message-ID: <20181024093103.GA19623@pathfinder>
References: <20181023201953.GA15687@pathfinder>
 <CAOQ4uxjfChxZyAUiYKQ-UiVjmxsosR+KG1ZSBu2TOeuAX3vJnA@mail.gmail.com>
 <20181024082134.GA14565@pathfinder>
 <CAOQ4uxjQwE2nhS7KccL_P+jUnz4vGwTpxjQquvbaZ0zZpJqGtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjQwE2nhS7KccL_P+jUnz4vGwTpxjQquvbaZ0zZpJqGtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:20:14PM +0300, Amir Goldstein wrote:
> On Wed, Oct 24, 2018 at 11:21 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> > Dear Amir,
> >
> > Yes, I applied each patch manually to my tree, fixed it up where needed,
> > then after rebuilding and testing each one I committed it and regenerated
> > each patch. Thank you very much for your advice, I will take it into
> > account and make the necessary changes. In the meantime, do I add other
> > tags in the order they are received also (such as Reviewed-by:) and am
> > I safe to add these in when I re-send the patches with the changes you
> > and others have suggested (or would that offend people that have
> > offered the tags)?
> >
> 
> Reviewed-by before of after Signed-off-by.
> I prefer Signed-off-by last which conceptually covers the entire patch,
> the commit message including all the review tags that you may have added.
> 
> Some developers add Reviewed-by after Signed-off-by signifying the
> order that things happened, so choose your own preference.
> 
> As a reviewer, and I speak only for myself, if I offered my Reviewed-by
> I expect it to be removed if a future revision of the patch has changed
> so I have an indication of patches that I need to re-review.
> But if the patch changed very lightly, like small edits to commit message
> and code nits in general, that would not invalidate my review.
> When in doubt, you can always explicitly ask the reviewer.
> 
> Thanks,
> Amir.

Dear Amir,

Thanks - I am just going to fix up the commit messages as you suggested
using git am etc. The content of the patches themselves will not change
(until further feedback is received).

Regards,
Phil
