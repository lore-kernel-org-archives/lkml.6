Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FD3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D9C208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhqSRaF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D9C208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754971AbeFRGjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:39:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36464 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754865AbeFRGjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:39:21 -0400
Received: by mail-pf0-f196.google.com with SMTP id a12-v6so7660717pfi.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dnIBCdAIbeMag2SAjkgfsqJoh4QkXpbwNd1Z7eY2C34=;
        b=JhqSRaF3+7mBswCVZWeb8NEOZ3nL2GegGaIQgihpqy+JKaSd9OhR5atAnsAERmCjgf
         HmJCEwpCNoeypyVVPmqd8Dh9TfXg9lsZ8kwZdHUD/LMaTELxGFtpPBmi/LX/UkwxGiAP
         wYHfy8R/zv55evFBfATXWtoUsD0C/ojNCaV/UJ9fGbGTijQ/T93tQa+1IExs3GPqzPz/
         r0NKWu7/EzNhh7RWa+ox5n8EHw+MWe1ogUUR66gXrU2PnIuxdjWTOXnJntqZgGRQ+8qv
         sPrTWaDp6Zwa1zPhXqpTwDE/f0E/P3VKlCYEPbqq+crqnpEV/bVl0pKzh9AwElnUkapc
         GGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dnIBCdAIbeMag2SAjkgfsqJoh4QkXpbwNd1Z7eY2C34=;
        b=HTXqT1lQyx3uewYVMyhi3nKXc5xuiy3MDyaIo4whHkN/y2LWiC/EtmUFgVO+8CKvQU
         hw/9Bjh+zv71A5NfY1tEsHgNP7k/OHc8V73198fqVxmSWxmkfhBT06njCrbADtde7wVU
         rMHoQbagTAI8LT+2cvjZFE68wPOKGuHe22eRef0f+06s7Y2HGjwd72ACKfPvdVjrwb9s
         qKC6A6vpwTMIQUymAtCYxpxU6ZKD8RILpjre0XSE1Iy/qlprRYbR2An0gkLZfREpEb9X
         X2oy/OSRo5pFsapkrKR43rmNd19BkahRmB1Gq//pJZMdaom3jgGd19bxGwoJurNzD3An
         p+KA==
X-Gm-Message-State: APt69E1lD9lcgUURATeIgliZFOAP5MBGyqQvRdfNlU23nm5yxxDrslIx
        XeNLeVviLOkd4+yEmsX8gBE=
X-Google-Smtp-Source: ADUXVKK5W/HhYP+r9whSVaBQxLbREQWrbUeAZyG6xJigolNFLJWuN1PdEaWrqqjDMKPkOeY10p/9dw==
X-Received: by 2002:a62:154a:: with SMTP id 71-v6mr12388128pfv.170.1529303960890;
        Sun, 17 Jun 2018 23:39:20 -0700 (PDT)
Received: from localhost ([110.70.54.122])
        by smtp.gmail.com with ESMTPSA id f11-v6sm15992925pgo.62.2018.06.17.23.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:39:19 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:39:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not call console drivers from
 printk_safe context
Message-ID: <20180618063916.GD27996@jagdpanzerIV>
References: <20180424022802.1330-1-sergey.senozhatsky@gmail.com>
 <20180424105104.792d2d80@gandalf.local.home>
 <20180425144813.lfhvuwsf2cebwarm@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425144813.lfhvuwsf2cebwarm@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/25/18 16:48), Petr Mladek wrote:
> 
> So I agree that printk_safe context does not help much. And I fine
> with this patch.
> 

Petr, do you want me to resend the patch with the updated commit message?

	-ss
