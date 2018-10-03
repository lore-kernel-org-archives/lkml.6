Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228D22082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdnoSgOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228D22082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJCTU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:20:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44913 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCTU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:20:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so1471684pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zTzqnry2MP/0u4Z02VTY//eyGXEVIXc4Bu+DvxEDLKs=;
        b=YdnoSgOAbLJRKRLLJeMA2awdLFgL9EkGZIgFq+pi/WeJ2jcci727A2qZb7Sd2lYtBt
         yJnkcb4H3q6ElqQ1aHX0FVQG8KerYwzQ1saPa1fmwmdcabNe4ME2IIyR5ZiDv1vnInl5
         xMnfZUXhKRpjP8BSxy7qWC69iFQ1NSaY9AM9xKh7MyxCYl/kjW4xIJ2NnYY62+fZPFl1
         i6Mp+lqTfQ+E7D9i5RGSLbx8gjmee3zlT570UPGpwRwTOhFeZ/VUkc5j2Vwkb7dN2yQg
         jKyxj644LH/qlkFXvx1zusaqhTC3MeiO4XRQzcv8cpTXTQe1uLTk/cLPuMbbyjivxywo
         hE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTzqnry2MP/0u4Z02VTY//eyGXEVIXc4Bu+DvxEDLKs=;
        b=ewveOr4kYJ5YRmcmiqeU21wPBk6wR3V/1ugeH1MicEsknyG35Cn/JMNmtI/KRvuiHW
         EJwgie8s4g/fWBn3N192eH87ViQdCFKYEZg7A+eHheBtFJ0k2bmngXcE5OQFWAb5mGHE
         0muh/koXuThCCj2Fp+3IHqeU1mgt2H5dQABxmjVKRnnGqke9poCQSzuC9ha1xqtOZsto
         TPh9W+Wp2FjupoTgl6t3PSzMx7TpNzri669dvYpWhQjEAfMMOIpoKhu/IdFLbT7yznCd
         6mUoVE38sXveRmP3h8J3O+fdIowT2qUckwpRvueqnnx0ZtXEXQYecvKnUmZdPuxlEDax
         KIig==
X-Gm-Message-State: ABuFfojDfOZ7kPNhoIJDxCgo2AQQhVtergVn6YHQrsTZtFuhHrRjtVfn
        bX3hKbfcnATV4dEi/dCMt24=
X-Google-Smtp-Source: ACcGV639Wc0+TyaEIDT20MOLq13b/bLlm6KIkULZ3ae2bquCD2+nAWrKZNOrLdVNqZyApwtKZf0mCA==
X-Received: by 2002:a62:cc0e:: with SMTP id a14-v6mr1371156pfg.131.1538569934315;
        Wed, 03 Oct 2018 05:32:14 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id r65-v6sm3131339pfj.5.2018.10.03.05.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 05:32:13 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 3 Oct 2018 21:32:06 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zsmalloc: fix fall-through annotation
Message-ID: <20181003123206.GC30267@tigerII.localdomain>
References: <20181003105114.GA24423@embeddedor.com>
 <20181003122656.GA30267@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003122656.GA30267@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, Cc-ing Andrew

message id: lkml.kernel.org/r/20181003105114.GA24423@embeddedor.com


---

On (10/03/18 21:26), Sergey Senozhatsky wrote:
> On (10/03/18 12:51), Gustavo A. R. Silva wrote:
> Replace "fallthru" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough

Hmm, comments as annotations?


> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
