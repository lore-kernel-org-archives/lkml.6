Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E022C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757A721748
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+Jyls/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757A721748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeHMNeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:34:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34774 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbeHMNeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:34:14 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so6745224plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0nGJpjY169I6SpZjZI1Z5T7E+hiXUYsrQIoNX0mVWik=;
        b=h+Jyls/YQXcA3gZQuykzxU1KOXWNI6oDmEvpovoWC2N8hv/JI1dvrCxe+yLzMLHSAN
         Rm8JdA0hCG0xMxJI5vr7H3gaBHRe2xoTJ/Ui4mXN8PaZD+MZqRo25SJNR1FaQ9eXAknj
         T9s0SqMZQP21eBFKuZ2bG7uUcEKidif/kYFYIsMle/GkFhAwMtXTonS/LpSzlpgHpLM9
         7CbpmjeWoNBaMkJkvohb2t0I/WkaKIJtXkf+ZDI2rogVWMnHLPaIk0BLkFMpK1Sz8ilh
         YVrwPtFBlHDqXiXwO63ooo6rMfY6hamfigtNsaz2KFKe17Wv44vXkIr256XVICCH57N0
         FeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0nGJpjY169I6SpZjZI1Z5T7E+hiXUYsrQIoNX0mVWik=;
        b=OR7Y/eDUpYdGV/wFyqXgpO5HNOiaVwRoJahzcqHPBnrrTKvKxkfyBGT4tPmvVIkx61
         2PZBmcAIE508HY0MXcVynZgDe5lCATF3T5SQ0kmgW5XTTcAmlC29YRdQhMCmn8k91VJV
         IKaNN4sDwdQtFg9Var1wwmenz0y+qa9cj7WOjtKZrayZqejFhTq2eCOpOK1vmGTjkb7Q
         fUQJrR5t63cwc+ezLdgWlh7Riz/TDP1b54khQEmy6byjF9end36m5od/sUP4dwAFBx8+
         b2okERf9LI6XCFT+E1Dm68vVKBEsc2GuvP8Ry2X8LGueoZKn1byzaF0/8/KjP0QF3HUt
         YG9A==
X-Gm-Message-State: AOUpUlFy/0RCXVC5A1lvlbvYy+CVRtgXiRulyfQCA5bghOV3qLYBv/sN
        gZxd7GIpwhS03KEn9Plvg1o=
X-Google-Smtp-Source: AA+uWPwHWbd+UMj9ObxnlHOXL+lJjFxjt1HJLPsCNZXzw+BIQZHNcnWRqiRhPIbsgsuuXqyIcZbQVQ==
X-Received: by 2002:a17:902:201:: with SMTP id 1-v6mr16502203plc.310.1534157550458;
        Mon, 13 Aug 2018 03:52:30 -0700 (PDT)
Received: from localhost ([110.70.54.242])
        by smtp.gmail.com with ESMTPSA id x184-v6sm22103383pfd.169.2018.08.13.03.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 03:52:28 -0700 (PDT)
Date:   Mon, 13 Aug 2018 19:55:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     zhouxianrong <zhouxianrong@tom.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com,
        zhouxianrong <zhouxianrong@huawei.com>
Subject: Re: [PATCH] zsmalloc: fix linking bug in init_zspage
Message-ID: <20180813105536.GA435@jagdpanzerIV>
References: <20180810002817.2667-1-zhouxianrong@tom.com>
 <20180813060549.GB64836@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813060549.GB64836@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/13/18 15:05), Minchan Kim wrote:
> > From: zhouxianrong <zhouxianrong@huawei.com>
> > 
> > The last partial object in last subpage of zspage should not be linked
> > in allocation list. Otherwise it could trigger BUG_ON explicitly at
> > function zs_map_object. But it happened rarely.
> 
> Could you be more specific? What case did you see the problem?
> Is it a real problem or one founded by review?
[..]
> > Signed-off-by: zhouxianrong <zhouxianrong@huawei.com>
> > ---
> >  mm/zsmalloc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 8d87e973a4f5..24dd8da0aa59 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -1040,6 +1040,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
> >  			 * Reset OBJ_TAG_BITS bit to last link to tell
> >  			 * whether it's allocated object or not.
> >  			 */
> > +			if (off > PAGE_SIZE)
> > +				link -= class->size / sizeof(*link);
> >  			link->next = -1UL << OBJ_TAG_BITS;
> >  		}
> >  		kunmap_atomic(vaddr);

Hmm. This can be a real issue. Unless I'm missing something.

So... I might be wrong, but the way I see the bug report is:

When we link objects during zspage init, we do the following:

	while ((off += class->size) < PAGE_SIZE) {
		link->next = freeobj++ << OBJ_TAG_BITS;
		link += class->size / sizeof(*link);
	}

Note that we increment the link first, link += class->size / sizeof(*link),
and check for the offset only afterwards. So by the time we break out of
the while-loop the link *might* point to the partial object which starts at
the last page of zspage, but *never* ends, because we don't have next_page
in current zspage. So that's why that object should not be linked in,
because it's not a valid allocates object - we simply don't have space
for it anymore.

zspage [      page 1     ][      page 2      ]
        ...............................link
	                                   [..###]

therefore the last object must be "link - 1" for such cases.

I think, the following change can also do the trick:

	while ((off + class->size) < PAGE_SIZE) {
		link->next = freeobj++ << OBJ_TAG_BITS;
		link += class->size / sizeof(*link);
		off += class->size;
	}

Once again, I might be wrong on this.
Any thoughts?

	-ss
