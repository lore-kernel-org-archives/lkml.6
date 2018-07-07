Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FDC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8347622469
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL/2mRN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8347622469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeGGGzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 02:55:54 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:46310 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeGGGzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 02:55:52 -0400
Received: by mail-qt0-f173.google.com with SMTP id h5-v6so11731054qtm.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1x4fe9p/L2D2yO575EoiyX+ffq1m/HZm1pUCM+we77o=;
        b=rL/2mRN2KT/HpCL8AdNJUQQ/QZBit/aiuB//kMJzkmeSGAouJlkk3YdmWYjAE+2R9S
         bYJAyckjkLn8SDSPGOoI6962WOtSIwBz0l3o16PFCCTlh5A6+pJCVRIOMl5IifRnlfvo
         gunJm619F3Oeflwz4P1iY7J5teY0mPNuuYnIROoBQ3JELPzwpNSv9QAYUh7Zna5YATwJ
         SVDXis81fG5Ygj9bfw3oUQQxvjt76471QqWY/REcJmUjA9Fywrrl9kCs7gWJexgwX6hj
         xS11cPuVFWw2ymhj+60LDuBI6ZIgvtpvStEeoA/qX3j9tVdBVTT9zsg0u6SMmFmYK4Xu
         pYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1x4fe9p/L2D2yO575EoiyX+ffq1m/HZm1pUCM+we77o=;
        b=Isr0Yusf9r15Tl/jhptAbZvLPmwJ7NhXtU081vVvY1bzkQ3wpfyGcfAHNmwmP2rn/G
         59ESVNrOQxS8nGhMEkXJVOwjcvbyHXndbVmiHBMfcx7e0H6V1nmKa0MPTov2+mJnCqvf
         SZygIahzbSp1xcmknH8qA9K6Y/zLVMBIHeGspWKDYqrkw0H1Xn/IXWmkzW5WWQlw14QQ
         wu5O8EyuvY2F/dqwf+/EVYXkE6u6EgZOz56IDeQZ+NngIgUf4wjVPGxjIVlf/iWIKjtn
         NqXjnnpNgEbzZxWw2UYfs5Djx5u1bMbwm0PnBzMhs05NsPdgnZIfSLHSvVW1iCbPRa8T
         tX3g==
X-Gm-Message-State: APt69E2qZD/KH1vhhWqgSg89EI0YNuaqI5oLaeEoi0mJJHELnxrjtdzk
        ZpudJ5FX1Uzj/KifXJi+OMw=
X-Google-Smtp-Source: AAOMgpfGohIvqU3krgyqx8TCoXv7DPrISdFYW+H+ZUo36u8kJTg1opKwIsRU/umS9L90iZfkkFNK2w==
X-Received: by 2002:a0c:f90e:: with SMTP id v14-v6mr11133330qvn.207.1530946552289;
        Fri, 06 Jul 2018 23:55:52 -0700 (PDT)
Received: from peter-ThinkPad-X220-Tablet (pool-108-18-228-108.washdc.fios.verizon.net. [108.18.228.108])
        by smtp.gmail.com with ESMTPSA id h22-v6sm6288803qkj.84.2018.07.06.23.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 23:55:51 -0700 (PDT)
Date:   Sat, 7 Jul 2018 02:55:50 -0400
From:   Peter Vernia <peter.vernia@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Replace unsigned with unsigned
 int
Message-ID: <20180707065550.GA26252@peter-ThinkPad-X220-Tablet>
References: <1530834355-8833-1-git-send-email-peter.vernia@gmail.com>
 <20180706153749.GA10530@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706153749.GA10530@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 05:37:49PM +0200, Greg Kroah-Hartman wrote:
> Someone else sent this same change before you did, sorry :(
Thanks for the review anyway. I realize now that I was looking at the wrong tree.
