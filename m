Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D61C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCF62086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="zUMxvs2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCF62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeIKXMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:12:53 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:38788 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:12:52 -0400
Received: by mail-pg1-f174.google.com with SMTP id t84-v6so10816199pgb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVpO1FZJ+pnY6ZJ2WnlooS92Vd3AlTYJ15/2NdHrnPY=;
        b=zUMxvs2VRMIP1s7GoUDGlV9bFhqBV9r2dE50ZP/jXNxBYNrQA5NKy4iJ+W5B4FmsWo
         N7MlTnZM/dS66k9etXDAffNgMA9ZVg0wZj1oLMTINFxUpa0h09DQgM7kweemKZmBynNB
         DtinXqmnAT7xFsruLp48YcAY3wGjXlIfmuxvYD5zL/j/g/v3InBsKwheVVn6Jo0JZMKs
         AMTDTgfhft9aluMIgvGjtzokFWzOy2E7SvJ03diuf0p1Kh3wbXz/hS0QW5QM8mQ23CDq
         Rc2PSFAxAc1gKUX6AWqD5sMS4ytOwsiJuCx9xqLiCHZloTNdbb/Hl3o982/jtjahSRtA
         WagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVpO1FZJ+pnY6ZJ2WnlooS92Vd3AlTYJ15/2NdHrnPY=;
        b=PchsFnEx6vZDUkNSNqt/0I9ZJ5t9hpYavbRWMNge+HRq02U+2GW5+CNUWA/sAYWF7U
         p+DBMxW9gevvBJkDxS+cOoiqg27IvIcx86L8Z0291wMbC8aC1pYX5BdhXsqOMLrm6wdR
         lMu46MURa0yA/9FrKWD7XD57xBKycbaLrmd/Zu2aejn0ALi6LmfMW+CIrAJWn4MEI78k
         lLONzvXav5NkvftCukR5KiAN69a2Ag96caMOpl3d5PG2NaYaN5TE2xWbR8+rT2HkxJKM
         LBKcNP94XqbEg7RAgRwZ8aAsDjRMIAy4EKR3P1BiXggaWmKPXc6qvAcBUVCu7LDZUEYQ
         xE5w==
X-Gm-Message-State: APzg51AcxDCnuIhGQSZ1C9sYC5LVUPTi5/qTI04joh+HPmRXg+m+4eWg
        PQNd5xiIssVzAgwSui7LHKUAmg==
X-Google-Smtp-Source: ANB0VdZBKP5j+EV7NYcvfFVkwfB0kVbgf4izWLJO3XfVU/OMNUGoXOucszCtgoQ5QO+1AuQCApi+2A==
X-Received: by 2002:a63:3dc6:: with SMTP id k189-v6mr29554883pga.191.1536689543931;
        Tue, 11 Sep 2018 11:12:23 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id u13-v6sm25400870pfn.59.2018.09.11.11.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:12:23 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:12:17 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vasily Khoruzhick <vasilykh@arista.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jim Westfall <jwestfall@surrealistic.net>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ihar Hrachyshka <ihrachys@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] neighbour: confirm neigh entries when ARP packet is
 received
Message-ID: <20180911111217.3e3679c5@xeon-e3>
In-Reply-To: <20180911180406.31283-1-vasilykh@arista.com>
References: <20180911180406.31283-1-vasilykh@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 11:04:06 -0700
Vasily Khoruzhick <vasilykh@arista.com> wrote:

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index aa19d86937af..56a554597db5 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1180,6 +1180,12 @@ int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new,
>  		lladdr = neigh->ha;
>  	}
>  
> +	/* Update confirmed timestamp for neighbour entry after we
> +	 * received ARP packet even if it doesn't change IP to MAC binding.
> +	 */
> +	if (new & NUD_CONNECTED)
> +		neigh->confirmed = jiffies;

You might want to do:
	if ((new & NUD_CONNECTED) && neigh->confirmed != jiffies)
		neigh->confirmed = jiffies;

This avoid poisoning the cacheline with unnecessary write.
