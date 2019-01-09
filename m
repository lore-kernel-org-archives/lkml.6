Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E76C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49BE2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGTY4DMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfAIFx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:53:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43525 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfAIFx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:53:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so3053872plb.10;
        Tue, 08 Jan 2019 21:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ni7wZKGihbWVu0WdWVEam0VFMbAaTZdaGVwlOJhePjg=;
        b=NGTY4DMZXPS5GwSu0I7Bf6L96TZfKF4uPsdNmDgpEJYU75kZC4UaJIsGzBxeuaycLp
         a3dYIhQTXcCzh4pszUVP3el50JAt0MDn/RpMJwYBJBQy9/CHAti4cVCSl/hSFYLpWuKH
         FrZPQtMH3Svw1TL+0upw9oWbHhlzI/wMo6KN0iGcIP/s4oWi7OaB5KWepzO1wV855InY
         VoykaDF4XUPC68dkqeD3dwwvy7m5tF/ZTAoG9m0+sG8B1oM7GsfhSXriOujhFxATyVIL
         /hPC3a3lNfzNiNZtvRGhmdc/drKGabVatVhIEhLcONGFYmgMfSi3tRBwNUKYKPKrWBX2
         uANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ni7wZKGihbWVu0WdWVEam0VFMbAaTZdaGVwlOJhePjg=;
        b=GbxJm2eAOLKogqFKK3cL4DHj4dhldLYKTP+A5DJWMw58KtVaz2TwjXRVWo/pWYSciS
         2tqX5YqCzw18SSoxyceHuls6tHEvZRJD0YrD69xhtKPAkVxs3hAFGZT328MxoifqoNTk
         VGl3csKYdwis6ZTkSXBFYr4E5pzs6w42f9H/GsjQ1T+t2TtjbIjEJuBmV8aozsvcllPu
         sZAzkzNim6vRr3RmhmxA4faqwwfgQdI2d3o3oCjFhEpk7TqhP+6z0YvO1qh3lILfD1Ab
         brJPgaj4E3GcOD9LGUBzgdq2zSODXwod+YjQrVdn856bjO8/lZGcvtY/4S1L5dLSifxV
         NB5Q==
X-Gm-Message-State: AJcUukdTLeywUo3s02a7Yw0ftyTys+OToch9lXvBNABnJHDPv5j0U9fI
        e4ors3Kij7yY1uq1eKBw03YT7rRh
X-Google-Smtp-Source: ALg8bN7uW4TFE7skipKWeLm1SCc5qKHJ7Tj58VURUCgy9fue7y63d7J7j46ClB+dTmU9qBvnz93RLw==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr4845911plb.306.1547013236877;
        Tue, 08 Jan 2019 21:53:56 -0800 (PST)
Received: from localhost ([175.223.22.241])
        by smtp.gmail.com with ESMTPSA id l85sm127356566pfg.161.2019.01.08.21.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 21:53:56 -0800 (PST)
Date:   Wed, 9 Jan 2019 14:53:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Helge Deller <deller@gmx.de>, James Bottomley <jejb@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] parisc: replace oops_in_progress manipulation with
 bust_spinlocks()
Message-ID: <20190109055353.GB28834@jagdpanzerIV>
References: <20190107095612.7086-1-sergey.senozhatsky@gmail.com>
 <d09f4a9a-f966-80d7-01e1-5d92401b5d7e@gmx.de>
 <20190109053941.GA28834@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109053941.GA28834@jagdpanzerIV>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't pay enough attention. Seems to be a temp problem
on parisc-linux.org side:

: There was a temporary problem delivering your message to jejb at parisc-linux.org.
:
: The response was:
:
: The recipient server did not accept our requests to connect.
: [mail.parisc-linux.org. 140.ZZZ.X.YY: generic::failed_precondition: connect error (0): error]

	-ss
