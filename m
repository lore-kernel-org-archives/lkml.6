Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919BEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601222148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJvqwYD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfA1Kvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:51:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33551 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfA1Kvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:51:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so7584095plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 02:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M8ezxNGupAHHpc32iPpZgAv3IiyPrJkuzF6rIk7b3TQ=;
        b=CJvqwYD2yJQR56tXxuDAf1kdxqupWqfoDj9ZobiZwgYnpykD7ah7/Gw16z4hnqywuD
         JoadQdg050WOqRuZ80C/Gp7EUoZ5bCKmi8yBfqBp/NaI9pyjZME47o4Mh8S8gh6HkuCR
         gYK25nuPbcAiZm78Xz9mrSXy7D6ii3E+c2h57QJXkBgcxdH2LaG71mGL/33OG4ts9nJ/
         QJPfr8i3+PWIPxX1xbNCEnScPWXPAkKmJBRRapEW+5PD7GC72DA9l0vX32EADwGxherI
         PfU/ZcaqUcSDD6DnjADNh1p9mqyMmQP13CWT+tQbL50cx7AwM/Cf6fIX3tCDKOxF/0oW
         kjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8ezxNGupAHHpc32iPpZgAv3IiyPrJkuzF6rIk7b3TQ=;
        b=kRu3z3osMY2MD8b57Gmmr//Y6jBflVo7wfmYBK2vrIev8JtGJ0mLLyz+5smXOcky/u
         WS0++p63dc3YqxyzvvHj4AApb/zF1GdH5jZ3w3WmZGy+Hl5VVMjSB5f5BqhMQWl9k+Aa
         IbwfZh0cPyy8IQkl696GfKe+zW04JOUer3ZqGdT6GS/Cl/Lop5hLQLvETOk9mZWN0RXX
         nN3d9aMGuqY7ABJqy7CF5fiQQp+p7gX5gAZIRcVbmnyhY6+Qeqq45gHvSgWSr3v4rmqm
         ySqim8ZQeaHIsxkGifYvFFMq5UwqGN5LajtLgDiujomMaPbUNfUsUjn7WtQ7w84Bw+wD
         hhog==
X-Gm-Message-State: AJcUukdZstsJErodEVwX8xQPiO8qBaX7ODeAky/LABxm46oH3ykJCU0u
        6HDbYwBq7Tf2NstHtsQ5faI=
X-Google-Smtp-Source: ALg8bN74wlw5FkaY8hLiqNa+DuChUQRq+NfU2l46nz12khc07xl2+h7cPMbra4yaCoQ4rnsWjm7eUA==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr21502584plo.112.1548672713025;
        Mon, 28 Jan 2019 02:51:53 -0800 (PST)
Received: from localhost ([175.223.18.40])
        by smtp.gmail.com with ESMTPSA id z9sm82328766pfd.99.2019.01.28.02.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 02:51:51 -0800 (PST)
Date:   Mon, 28 Jan 2019 19:51:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [linux-next] kcompactd0 stuck in a CPU-burning loop
Message-ID: <20190128105148.GA15887@jagdpanzerIV>
References: <20190128085747.GA14454@jagdpanzerIV>
 <5e98c5e9-9a8a-70db-c991-a5ca9c501e83@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e98c5e9-9a8a-70db-c991-a5ca9c501e83@suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/28/19 10:18), Vlastimil Babka wrote:
> On 1/28/19 9:57 AM, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > next-20190125
> > 
> > kcompactd0 is spinning on something, burning CPUs in the meantime:
> 
> Hi, could you check/add this to the earlier thread? Thanks.
> 
> https://lore.kernel.org/lkml/20190126200005.GB27513@amd/T/#u

Hi,

Will reply here.
Thanks for  the link, Vlastimil.

Will "test" Jan's patch (don't have a reproducer yet).
So far, I can confirm that

	echo 3 > /proc/sys/vm/drop_caches

mentioned in that thread does "solve" the issue.

	-ss
