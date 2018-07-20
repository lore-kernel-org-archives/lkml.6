Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD889ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5851620673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVffmKaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5851620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeGTLEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:04:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45457 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeGTLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:04:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id j143-v6so1430565lfj.12;
        Fri, 20 Jul 2018 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zs+u+LKAHbPI+veyDNpITYz4ztIDThBPrqpba+h/i/c=;
        b=tVffmKaS1AB8YJYaC3myP2p7n1ypNpzmFQZ8aiPEnPkGC/wio1Ij2TSHl1ro7b96xw
         1aYfCTra1gh8pZstw8rop1RnyKgaCf0uFDAmtfohm9Fw3uP6M4EGvPGvP77zCFam8EoY
         YQlADWMdaAi+V2DDZwPlRyTLP6P80X72TMYt6anjMErbBT7gahVN9F65tHJy69sQeTlm
         ZKqe46RKz9H4jSAcVhj54hfJANhzszq22+4b43NOI7DsgXW6jyXKYit5zIYKX9lAJXqa
         9UKNcaIulQMb6kXCDNfaFkfcMP5porrigHbdutbRweC9eVYIw2bnOmKxaLqqEk2FLa86
         3KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zs+u+LKAHbPI+veyDNpITYz4ztIDThBPrqpba+h/i/c=;
        b=KwvWkVhXVIYsIgRHEyUAIpCg5j5rSPLG9VcU0EEsVnJPT+yTGYefyG7EYH8zl2Ch4f
         rVjP3MjQByKyL90kKNooj0LWeW291ftjCcDl+XI9YhZU/gp9Qjk3ItKD1NKdtStYdyf3
         DPLxZ/VBhJNshVbUBnKFTn11zsFeQahkXW5wF2e1vTTLm5hp++fa/dSBEkhZNvlQDd8z
         A5KiaCBurEYvaX0bBAliKJzDszk0FaJBN5gZfE/95pLZHNoIxcS6XlemWMZa7WQ7viJI
         9oxLLVou0MQekKIVPTWTX3ejduFZpnShhX/C8TPtG0GrfgTPO9asKbZA4vgdnlRC3AhX
         BRHA==
X-Gm-Message-State: AOUpUlE8kjNp8oypvC/l3yJzkU4U4Vd3GN08Zvnlp87atnSGXBX/Bzar
        urLdzTFXRN+N/TLOmUbu9x0=
X-Google-Smtp-Source: AAOMgpeoEOv4qNMgicayTT9bt22XxA95QarIdem5NH6u71FYlo9mqsUObyq8cthz+3Y6V5GTE7gnpA==
X-Received: by 2002:a19:1604:: with SMTP id m4-v6mr992794lfi.120.1532081805814;
        Fri, 20 Jul 2018 03:16:45 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id b14-v6sm234628lfa.62.2018.07.20.03.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 03:16:44 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fgSSb-000492-Lq; Fri, 20 Jul 2018 12:16:30 +0200
Date:   Fri, 20 Jul 2018 12:16:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: cp210x: Implement GPIO support for
 CP2102N
Message-ID: <20180720101629.GB19245@localhost>
References: <20180718212004.11852-1-pados@pados.hu>
 <ea05b80064d32c7beef3f2039adb89aa@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea05b80064d32c7beef3f2039adb89aa@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:38:12PM +0000, Karoly Pados wrote:
> Hello Johan,
> 
> I hope maybe after you come back from your vacation you can still
> merge this into 4.19, I guess the merge window will still be open.

You shouldn't make assumptions about peoples vacation plans. ;)

> Given that there are
> about another 5 weeks until 4.19rc1 merge window closes,
> I didn't think I'd be late with this patch, I am sorry.

New code must be ready and reviewed well in time before the merge window
*opens*. So generally you cannot expect anything you post this week to
be included in 4.19.

> However, as already explained to you, it'd be very important
> for me to get this patch at least into 4.19, as otherwise the
> time I loose is much greater than a single release cycle (due
> to distro cycles), and I have actually a crowdfunding product
> depending on this.

I know, and I already cut some corners for you with the baud-rate
handling changes even though this is strictly not a valid reason to
change the normal procedures.

That being said, I took a look at your gpio patch today and as it looks
like you've addressed the major concerns with v1, and done so in a clean
way, I'll make an exception.

I'll post some review comments, but I've already fixed up the patch
myself. It's mostly style issues, but I did also find two bugs.

I do need you to respin the commit message, though; a commit message
should be self-contained and not rely on external discussions to make
sense (you can of course still refer/link to it). Patch-revision info
should generally go below the cut-off line, unless it is useful to have
it recorded.

Can you post a reworked commit message today so I can include this in my
4.19 updates?

Thanks,
Johan
