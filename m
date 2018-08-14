Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC5CC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985B22159D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcer+hL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985B22159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbeHNDJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:09:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44182 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNDJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:09:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so7568353plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGRmp7nJ4M6x9MMBOsxKewL1/+uFpgcN4t3zj8f+wRo=;
        b=Xcer+hL7dkchrrOsaEYD8sZbvW7HTmoNFCOgPQ+7oFGnzWugslLLwDbb4T0R/5O3Wz
         qYi4l5qGx4aBAki1NyoqTOErd/qyg7q0hsyvJsKqml2yo2wepfmx7jWhzwg41m/2VzBC
         yxaZ5t00yotYlzB7NU43yPGzwENhiEZ0ldYY9fJC2SpLxVYDiTQYAyg66IsyOe3KBsUc
         JFJAQreHRsoeaDN1ZBqVw+dGZUrwcE3nM7a9erS/fPiY85vn0qoJgHFjdso6k0bkzNKf
         aDYSkm5tZ3Ou39vvGC5ayI+JErZLjANXk6bktxQqdTRLzkPpdRO4wtiYhEr4ZhJnGHay
         wEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGRmp7nJ4M6x9MMBOsxKewL1/+uFpgcN4t3zj8f+wRo=;
        b=ZF+DqP+ehoW/9Yik4Arih+m6AcpOpwpdMSRP7hDwZxyRtUfskireZd00xHXvKvjkn+
         Y3nQVLld4yJsxvYY66gFuy5dV1zH/4xrnP1WThgdF3ygbjUNrK4zizoJ776E9s4qZHUk
         cJemkvswUiYwCM5zIdvjDifTJuPmkY5Ea4ZAVrwXDt+Fm+SaA83cHTS53wXtuiFXaFJm
         X1HuUrWBi2OQUDe4g2vsx3TjK2UzbCl4b+mv19tjkMIxyJXHlY3iYL22caSdplnu8LeO
         OL1go+rS6Y9TVLZWAGLBotb/+7+BT7HU1wSzUY76dNmJuBv2KX20sEsbjoFAdZ6Wh7uA
         Yqpw==
X-Gm-Message-State: AOUpUlEdZAQOhyJ9QiacbNXzFTscX9UR7xnA0aJhDJDXwq9xuZcWReN0
        qIYzEbbYTfizeoV5zaKsZcs=
X-Google-Smtp-Source: AA+uWPzH42lgkYfOK+PvxZdv2VwRDTaU1LKZcl9nxb/pYfTSXw8gpJp+DuJhUwxrDRZHik3tWpGLsQ==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17-v6mr18571359plo.9.1534206262732;
        Mon, 13 Aug 2018 17:24:22 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id b76-v6sm36629203pfj.184.2018.08.13.17.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 17:24:20 -0700 (PDT)
Date:   Tue, 14 Aug 2018 09:24:16 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     zhouxianrong <zhouxianrong@tom.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        zhouxianrong <zhouxianrong@huawei.com>
Subject: Re: [PATCH] zsmalloc: fix linking bug in init_zspage
Message-ID: <20180814002416.GA34280@rodete-desktop-imager.corp.google.com>
References: <20180810002817.2667-1-zhouxianrong@tom.com>
 <20180813060549.GB64836@rodete-desktop-imager.corp.google.com>
 <20180813105536.GA435@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813105536.GA435@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Mon, Aug 13, 2018 at 07:55:36PM +0900, Sergey Senozhatsky wrote:
> On (08/13/18 15:05), Minchan Kim wrote:
> > > From: zhouxianrong <zhouxianrong@huawei.com>
> > > 
> > > The last partial object in last subpage of zspage should not be linked
> > > in allocation list. Otherwise it could trigger BUG_ON explicitly at
> > > function zs_map_object. But it happened rarely.
> > 
> > Could you be more specific? What case did you see the problem?
> > Is it a real problem or one founded by review?
> [..]
> > > Signed-off-by: zhouxianrong <zhouxianrong@huawei.com>
> > > ---
> > >  mm/zsmalloc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > index 8d87e973a4f5..24dd8da0aa59 100644
> > > --- a/mm/zsmalloc.c
> > > +++ b/mm/zsmalloc.c
> > > @@ -1040,6 +1040,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
> > >  			 * Reset OBJ_TAG_BITS bit to last link to tell
> > >  			 * whether it's allocated object or not.
> > >  			 */
> > > +			if (off > PAGE_SIZE)
> > > +				link -= class->size / sizeof(*link);
> > >  			link->next = -1UL << OBJ_TAG_BITS;
> > >  		}
> > >  		kunmap_atomic(vaddr);
> 
> Hmm. This can be a real issue. Unless I'm missing something.
> 
> So... I might be wrong, but the way I see the bug report is:
> 
> When we link objects during zspage init, we do the following:
> 
> 	while ((off += class->size) < PAGE_SIZE) {
> 		link->next = freeobj++ << OBJ_TAG_BITS;
> 		link += class->size / sizeof(*link);
> 	}
> 
> Note that we increment the link first, link += class->size / sizeof(*link),
> and check for the offset only afterwards. So by the time we break out of
> the while-loop the link *might* point to the partial object which starts at
> the last page of zspage, but *never* ends, because we don't have next_page
> in current zspage. So that's why that object should not be linked in,
> because it's not a valid allocates object - we simply don't have space
> for it anymore.
> 
> zspage [      page 1     ][      page 2      ]
>         ...............................link
> 	                                   [..###]
> 
> therefore the last object must be "link - 1" for such cases.
> 
> I think, the following change can also do the trick:
> 
> 	while ((off + class->size) < PAGE_SIZE) {
> 		link->next = freeobj++ << OBJ_TAG_BITS;
> 		link += class->size / sizeof(*link);
> 		off += class->size;
> 	}
> 
> Once again, I might be wrong on this.
> Any thoughts?

If we want a refactoring, I'm not against but description said it tiggered
BUG_ON on zs_map_object rarely. That means it should be stable material
and need more description to understand. Please be more specific with
some example. The reason I'm hesitating is zsmalloc moves ZS_FULL group
when the zspage->inuse is equal to class->objs_per_zspage so I thought
it shouldn't allocate last partial object.

Thanks.
