Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A02C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D3824CAF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR9CS2Id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D3824CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeGCMLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:11:54 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34326 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeGCMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:11:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id n96-v6so1420202lfi.1;
        Tue, 03 Jul 2018 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTib2x9GCmUCaliVG7ZVIPVVVTvQXxP9z15ypkIYe4Y=;
        b=bR9CS2IduYHd8vrttsYpJ1s9ZoD0eG+OGo1RLZ5hdhkWRCjgR6v6S/A097SRyah5PJ
         Gc2Ak58dn2rZdAjPrpjtXZu7+TFm85q27amh/3nKKw4GCiwAcYOJirTnCH+FISbRW2dD
         ld3+plS1kl2L4ZcucdbB1b3IVmEuWbNu2a0S4iJOYmeDQrxoNK/DhdGUwvzdlebc/FgI
         6Op1uuJEC/WXWJv/8bC4UC4MvrOXcl6iG3lOc6WJ+SAX0XwrbiLgDbjEypi6T29CdAnT
         D2H+iJpBsDnbfMPH/MmkNsHR5Zv+WHpSHCnpCd62psROqdxDUjC4VaafUpe2PFgiyctQ
         gdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTib2x9GCmUCaliVG7ZVIPVVVTvQXxP9z15ypkIYe4Y=;
        b=Qb6Dg/wwJLYJ5MMp5saqk9mpEo2Pe5irwVsRsNShg+4IFozueZGs59jvN/yLu1BICW
         bYiaXMpNULXPZAu/UCWQU1jDJ8rvkVz/R0QSOpQxBrRiZPdJ04074YLuQYnaMrYKYETq
         BScl4Cu3pheJUePen4R0NArAfFPzVy113CIsxYEl4uJTr/zGTINMta4q8nkBSpOdRexf
         1uHFP4yvymQdD6LnDlupffTvZNRviKwh+IZAub8/zJxIl33R7ZdA8mtgrULzRQ02HzQu
         hwfZijB7g+qkOg8dC6J4bQobHjByHm+fnnbOWmIRJ/HtlR6RqfHi8/VV7+foxEcN0Ow/
         3HkA==
X-Gm-Message-State: APt69E3/xIRWPA4MZ/zx1epWAEhBfSdqkiGs94qTzuhKSJh5jV83QBTd
        nFSZhM/wefzIhEuduPuhesk=
X-Google-Smtp-Source: AAOMgpe8bZ6Rt9C0t5a+58itAKDvd7Xt/aVijPCiHpwnrqQBb6DNorQyvcPAxBYQ2ZCuyE+lFpNTzQ==
X-Received: by 2002:a19:6801:: with SMTP id d1-v6mr7287277lfc.8.1530619911009;
        Tue, 03 Jul 2018 05:11:51 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id x9-v6sm226053lfb.46.2018.07.03.05.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 05:11:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1faK9n-0008LN-8F; Tue, 03 Jul 2018 14:11:43 +0200
Date:   Tue, 3 Jul 2018 14:11:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gnss: fix potential error pointer dereference
Message-ID: <20180703121143.GP9802@localhost>
References: <20180703115921.7h35wi73oym3use5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703115921.7h35wi73oym3use5@kili.mountain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 02:59:22PM +0300, Dan Carpenter wrote:
> The gnss_allocate_device() function returns a mix of NULL and error
> pointers on error.  It should only return one or the other.  Since the
> callers both check for NULL, I've modified it to return NULL on error.
> 
> Fixes: 10f146639fee ("gnss: add receiver type support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ouch, thanks for catching this!

I think you got the wrong commit for the fixes tag above, however. That
should be:

Fixes: 2b6a44035143 ("gnss: add GNSS receiver subsystem")

Not sure if you want to send a v2, or if Greg can fix that when
applying. Apart from that:

Acked-by: Johan Hovold <johan@kernel.org>

Johan
