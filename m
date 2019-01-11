Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4870A20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcRADYVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfAKCQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:16:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36517 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfAKCQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:16:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so11873378edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJBh392TZ0mIKpFaEOwsbyJxjswov6B1In9yDZbmHRc=;
        b=YcRADYVncNbEwEW+1AY2gPuX5beQrnqHzBCo2xprSKQFBmqYZ01S3iN8uDGl43k/Cx
         asvl5snQM6f/URVSJHLlZZS72f60kqsOGZfqNf9IPHLxDv/QkkryYLNW+vEfxYZyTTB0
         5NkYIs1e04DPjAshpZNSo/TCn6c/BloEVy9Jlf3kULFAxtO75hPK3EpWi0eYNbkRm5i1
         wAbvDPywV84ZE+WwpS7BCs9ae4cBHSwliBuQhsQa3l/eGzWG55vQFfykmDYrdXSMsW+s
         augi0zxZtnBEME2FC0PB54EOno7tiL6vPIK43jE4LWY6ApjAnA3CbHfKiGA9KehDIRre
         LoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJBh392TZ0mIKpFaEOwsbyJxjswov6B1In9yDZbmHRc=;
        b=NMu6neRtVaqbHsANJpAKTZl7MOo8LXdYaWrgwmLS9eQ/A5vibIRjKfwRs8d5AGrAeh
         drMVicb27uA29+cXWKM9MPuIgIBVcfqaHpnQpkRFRyYcJcYV36Op51scT8uVtXgF21Je
         9vUzHl1B3NK7lL0HUfcLpm6doSXQp1wC3uTlQWOp48AxC4YkJHXOAmAY0pLIv3Mbnzey
         gHsFoEVBKnE8nX5rg5uR+r+ZT9MU/gJ2Fj01oovJ52QKyLSIcbe42I5kpgsPbcOlXiKN
         RdcdUKmez37mdvgAD91/iY6c39BdIbX8mHPAC42CikShoXzDDVQN+BzCoQUB7pbPJLFr
         k1Zg==
X-Gm-Message-State: AJcUukcgxYOUbxV+a1vlkCusgzqhBPFvOllaBN4H40bBVUox6sZtS+yI
        tN5+jLHU3z8jQU7p0U9iy7PPeCTvDzU=
X-Google-Smtp-Source: ALg8bN59xJqC5Q3mOktJob9sKKk5UROra81gaTmty4rTUiHnDsSmg26RaUdUevhvqWSw1Y5y02AHTg==
X-Received: by 2002:a50:d797:: with SMTP id w23mr11991072edi.19.1547172994821;
        Thu, 10 Jan 2019 18:16:34 -0800 (PST)
Received: from bebop (189.114.217.220.dynamic.adsl.gvt.net.br. [189.114.217.220])
        by smtp.gmail.com with ESMTPSA id ec19-v6sm1320260ejb.11.2019.01.10.18.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 18:16:33 -0800 (PST)
Date:   Fri, 11 Jan 2019 00:17:07 -0200
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        Michael Callahan <michaelcallahan@fb.com>,
        Omar Sandoval <osandov@fb.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: Re: [PATCH] blk_types.h: Use REQ_OP_WRITE in op_is_write
Message-ID: <20190111021704.GA1228567@bebop>
References: <20181222100356.559995-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222100356.559995-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Sat, Dec 22, 2018 at 08:03:54AM -0200, Marcos Paulo de Souza wrote:
> Instead of just using plain '1', as it improves readability.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  include/linux/blk_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 1dcf652ba0aa..905c666a0101 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -377,7 +377,7 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
>  
>  static inline bool op_is_write(unsigned int op)
>  {
> -	return (op & 1);
> +	return (op & REQ_OP_WRITE);
>  }
>  
>  /*
> -- 
> 2.16.4
> 

-- 
Thanks,
Marcos
