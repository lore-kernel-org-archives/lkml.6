Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0BBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081812082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544990111;
	bh=efKtOVfyA8RIrxpSE0kjM7/gS+j6CDncFFH8B/6G9zs=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=KyxBMM4GX0lkpSrZBKAej3hHgdoRsZA2//iz3DafR6ZiM9FnRZdEb+FJAn4082U2F
	 PaLCMwPMnJtIalV+lnVNowK0Cy2/vVuI1/5Nw4IlHh/XSNa3RF4pxM2cez2Uc4uz5q
	 gkLDrt7yonlArajT6BUC9hku1XRkM4En3TzSgXzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbeLPTzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:55:09 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:41666 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeLPTzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:55:09 -0500
Received: by mail-qt1-f175.google.com with SMTP id l12so10009666qtf.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 11:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+VoJTO7+0aCtAMTLuSAi4R6E/aMB39NLKOiE3Qh1Ag=;
        b=BOpd6iaKUuDw6ggNwMiB/9vpSIKjhQ71Bmt/dK4XT02BVrz7/ivXIONNx5NHSFpx8P
         xR1aOpVPWD8vK/vLYWB5dVvq2aSGL/qZz4V21ScPJpCq7Ge0ytO/dxPc/jE8baj0Sxx5
         SMKXLiUAOZqNe+0Ltk9ujxpavpbWexiRH+zTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+VoJTO7+0aCtAMTLuSAi4R6E/aMB39NLKOiE3Qh1Ag=;
        b=uWrt98xId7Z06CFBsCyM4cr5T+/eCbQkMnIfQ1h3UtirkAfLd/fNhmS5lAQVmtpefs
         pmxyDFbGygwfYeLHUN3uLdmzsXhhwwCmex7OjvmFFxdiZucIvjU0wbgQIS5DQzxCDcjC
         htNVFAb5WN4jC8bd7VZrFNOEm4GtBlcUZvp3agS1bNsmLPKyXaf/8iLzOmzSIPbgASDI
         M797Wx9s6a5AeEoMZmwelzMGUw5RHV8BdpR3vXfqjuwx37th58wcwAt9WEkeQmtBw5dZ
         /nGvKWRgli0jD+OY6g1DWVJvM21L83+k+RWugpAa+Qc7Q6GZ+PR5ZyhDdcq500vyhrVp
         Zb1w==
X-Gm-Message-State: AA+aEWacYGi0Zvda8AyCR7KaPWMcm/DFd7UdXp/6g0Mgvn7UD3m5GD+l
        jePYHkQIgliI7G7RtuXQzvzPEQ==
X-Google-Smtp-Source: AFSGD/WTNeboOHaPS6kzVdhAVuj4P1dEulWSEmpwmWiojFGFk9DmFOU1zk1bKgO+b06lcP/5i520Uw==
X-Received: by 2002:ac8:3b52:: with SMTP id r18mr10612644qtf.81.1544990108358;
        Sun, 16 Dec 2018 11:55:08 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id r56sm6545046qtj.30.2018.12.16.11.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 11:55:07 -0800 (PST)
Date:   Sun, 16 Dec 2018 14:55:05 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20181216195505.GB7732@pure.paranoia.local>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <c7865616af2eab80f5e5a4cf756ba430f2293499.camel@perches.com>
 <20181216192135.hc7gykmwkfgil2j5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181216192135.hc7gykmwkfgil2j5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 09:21:35AM -1000, Joey Pabalinas wrote:
> That was my first attempt, but the ducumentation for the public-inbox
> format is sort of terrible, 

I'm surprised you think so, because it's basically a simple file called
"m" that is updated on each commit and contains the body of the
message.

> and after a few hours trying to convert it to Maildir I just gave up.

It's as easy as something like this:

for commit in $(git rev-list master); do:
  git show $commit:m > maildir/new/$commit
done

You have to do it per each of the shards for the complete archive.

-K
