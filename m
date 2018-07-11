Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B8EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89F2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eywXJhP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F89F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbeGKOON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:14:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36158 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGKOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:14:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id t3-v6so19308297eds.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6APg3PrnEBIVRJDMdP/Pwih/rIXKFddZwS2g7kQdwVY=;
        b=eywXJhP9aer0xLTNBNO0e+TP1mXetuiJGGgYGO3wCOVBNNnQPNMjcyTlyzuHT6bkcB
         5H2hl54xQ83bDnLUqo/Sjv07prvHzDdoiMQtiMOEtpu/NToKyQM6lZDlPAMT1Znv27X1
         hOlEs+uEz89GU+2dj0oQyh1wG6Y6c4RfIMZlAiPCY/P+DX3VzqxiZvdA7MW53yrG33KV
         dX5xBI8XdTaz+RZ+lPetNlHfAIXzmKmtPSEtoECFF95WSVrzyIB+tlDLxSDg2ME2b4m3
         oaXb+JBuNAlxDu9QYN605R8o+GstOiBSw935ROeoX0g/NEl7k80UL3Hab30xlS/Z5BQL
         zW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6APg3PrnEBIVRJDMdP/Pwih/rIXKFddZwS2g7kQdwVY=;
        b=n2QvjxwoXWUJAp75pkP5XvFTnCqzMDVgfVCcDfhmY/IwchwTWXQkg/2myoaFdz/REY
         90i/q/XDqFGaWto7Pg0NgsUTvgWa+QZN5Ro6p74V9sDvp1pmK6fX9Xbj16uCu36/XNKI
         KlvFSy2n9a0Sxwoa9psC3YTx0B3UnkiWXSs82BePEhUH2IiIWWKrsF9oxdwXvy1MhswC
         HmbCmHNTh6MqU73+MV9RZCBPr531mUZMF/YTN6N1+XJCmp6y1UEFeLQKbtNQ+z/TjFQy
         K9dmeOJmW+1wDrAT7Sc8gc/cWWfaVpTr0IVGzaFPlefCw8RfzcNyH8Mp/hUc4LOkaojY
         kR6Q==
X-Gm-Message-State: APt69E1M9tBR0570zmD6hAUHktxwna7hS2VVzAS7R72lE5jTz4GBts06
        gZuIQOKXhoMuWVB0GRGOEWo=
X-Google-Smtp-Source: AAOMgpeARgmKppaIA205rG99oIk35BDmLeT7lYOz15MUUyMFt6BADLWfln0CIeIJc287VOIIUA8FAg==
X-Received: by 2002:a50:b642:: with SMTP id c2-v6mr18128189ede.288.1531318180384;
        Wed, 11 Jul 2018 07:09:40 -0700 (PDT)
Received: from xux707-tw ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id k2-v6sm13175912edl.30.2018.07.11.07.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 07:09:39 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:09:37 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        aastha.gupta4104@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 3/8] staging:rtl8192u: Correct spacing before and
 after parenthesis - Style
Message-ID: <20180711140935.GC26416@xux707-tw>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
 <20180710150523.17384-4-johnfwhitmore@gmail.com>
 <20180711111349.GA28836@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711111349.GA28836@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 01:13:49PM +0200, Greg KH wrote:
> On Tue, Jul 10, 2018 at 04:05:18PM +0100, John Whitmore wrote:
> > Corrected coding style issues aroung opening and closed parenthesis. Spaces, or blank line, removed from after '(' or before ')'
> 
> Wrap your changelog text at 72 columns like your editor asked you to :(
> 
> I'll fix it up this time...

Oops sorry and thanks. I thought the magic number was 75 which I got from:

https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html

jwhitmore
