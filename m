Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4717C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6033120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOHx8U+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6033120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeIJRRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:17:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38234 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:17:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so21717452wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xGEQtVUL5KUj7KumBs5QrkZmdZt0IcLI30ieZY3U8co=;
        b=SOHx8U+ncgs3/maNgGDqvBT9fb8ATo4OYkPGCP4op/pUP1hOlX9Sf/QCi3I3q96VSc
         0O6mJU1f7wpN1Xy5fuPFtIwhbnEW6kAvmQmGzdPqtQKPNxLYXAqwZUvbvsI/+jwSXIcO
         nU5hF5iFIGQ0EH4VtP0oTVvM6s+QDIgxJl1AUEZ6txlxRNbCmXgGcNLFKw1K68xwajef
         V23oM0eWLFA0n9/wB/MKua/yoS4Dh2loFklKQYnw2jnu6DUV+bHyXTno9+KsYyF3j2R5
         fBihylw6ntuDaXKptI3dUDFjKXQ0Flz/HLXH99UgVS1oprXKr7VMazCRXVaeclJEsk7n
         46dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xGEQtVUL5KUj7KumBs5QrkZmdZt0IcLI30ieZY3U8co=;
        b=Wdwqsv6QzSBX+H6T+VVZ3rfEQCirneEqdVuFpexAHAa0eJfYmNsfeNHtOk4/Kqvuay
         NDfZxJeOvvCjcXMKfjPfKkH1Tldv/wHybGmfVMkT/7uvnXNun5XVAtP21nCDAsPd5fb2
         SEqdzq49Y3+lSGJEDSKUytm6/3F0Cwro7XvwPIDsrymmbVOQ/BbA6o2LGUZRG7y++Rgb
         i5ZPaROw99tLVCHI9X/AX0oc7sJjkHfxGFjKehpJMb1kP2d6woHB9wAmMj1Bk79Yl1Oc
         UgST6/tOhfxJt+VfAoENXML8BkUa9OrFYROWhqYlhdjz9ardSJDw5TuFlR5k4n5doim+
         Egbw==
X-Gm-Message-State: APzg51CXZwabRs+EgIx6rlUn3Z2TFmx+t3piUfnaHQQ/8bXi3xxTi3UL
        ip1qIjd/FJo/WZkB8cYD1nY=
X-Google-Smtp-Source: ANB0VdbXgS8PF5zTlJLms+/7Ffyw7OnWABx8S2YCZi9M6RvKsBOv0nIxMvb3ssrqQCiQXsQGZN/jCg==
X-Received: by 2002:adf:eb87:: with SMTP id t7-v6mr15353595wrn.123.1536582239534;
        Mon, 10 Sep 2018 05:23:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x125-v6sm14734048wmg.27.2018.09.10.05.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 05:23:58 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:23:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip 5/5] kprobes: Don't call BUG_ON if there is a kprobe
 in use on free list
Message-ID: <20180910122356.GA70908@gmail.com>
References: <153484425558.5385.1484910606397784412.stgit@devbox>
 <153484439807.5385.8446592533176849097.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153484439807.5385.8446592533176849097.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Instead of calling BUG_ON, if we find a kprobe in use on free kprobe
> list, just remove it from the list and keep it on kprobe hash list
> as same as other in-use kprobes.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 63c342e5e6c3..e3420364b415 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -546,8 +546,14 @@ static void do_free_cleaned_kprobes(void)
>  	struct optimized_kprobe *op, *tmp;
>  
>  	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
> -		BUG_ON(!kprobe_unused(&op->kp));
>  		list_del_init(&op->list);
> +		if (!kprobe_unused(&op->kp)) {
> +			/*
> +			 * This must not happen, but if there is a kprobe
> +			 * still in use, keep it on kprobes hash list.
> +			 */
> +			continue;

If this is an 'impossible' code path then I think it would make sense to add a WARN_ON_ONCE() 
here.

Thanks,

	Ingo
