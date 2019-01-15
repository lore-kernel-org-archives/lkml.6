Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6345820657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XckFj4as"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfAOBZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:25:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39636 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfAOBZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:25:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so459326pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dD3cXzqnTifY+DlmcmSOfw8BIYt+azZnh4seFWq2G0s=;
        b=XckFj4asqCdm0KPp7UyzwahbpUnMz2IpiJz/U8veQ3UZysx4Mzy0NoWlQhH3w3A2y8
         wktIeQOsaoZVP4lzwPfhC1W/+ZJbzKa9gvnx5lmaBln6eeC326pyhG1B7dvPA71iSrMt
         X56R+LVEfBDoKbBXRNRbWKHzwfkgLlmSFpNlApjhx1msBn4m72pmJaEDyNj1diHTtQTW
         Iw23K9L0Lv1tHpXIseWD8vSMAH3mu3gvB1IMW6lCmnoYnvNTTtr1bKhlKN4BfokjGyWG
         dBhLlGl7nVG3tSDBd3Q3+9oGGwpSnghrYxyEBYcqIli9gGVpB/+M+Hx19/G0pl6MuHPV
         znKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dD3cXzqnTifY+DlmcmSOfw8BIYt+azZnh4seFWq2G0s=;
        b=YzQz7PK8MONj3dww9etlVJT7YXyYT07JkljaHLYQybYatsAktX/dn6ud3EYgtYBbBX
         q2s8rU7H8DNG4jwlws63j/dG3Iv4flcrB/poi97PDjsmGhseCDtbADAXuIN/YmMY+8W3
         IuxBWPXbsIwFQnFQHheQTeBdkx3RfkzWDAT44qGtNP6J3fs2PRQiyz6tUlEOYtBEg5Ia
         mJrdUZBlgcWn3Ju54R/8VcItmbanvPyz4mfOMP9yiF/7JFzrqOlNY4CcFMnjg9ZoYDMs
         1U1cQGp/6//EvR5h/v8944SuyaL4p8vXT1Id1x9+iHXArMdbj2603JAys5BTWwxCNPzz
         Wceg==
X-Gm-Message-State: AJcUukcCopm37SegJ7CNF7o4I5LXUthJRH4H6MueqGTFdQ/oc5O9oMiU
        HyYPVazkgaR9OZglu1wUSJo=
X-Google-Smtp-Source: ALg8bN7eYhg0y/eztq5XYFV9qKFobuNKw7/p3lTnCe4ifa9SGW33swb6qwLhd6VDHzJYRiPImqyHkg==
X-Received: by 2002:a63:4d66:: with SMTP id n38mr1370207pgl.270.1547515541911;
        Mon, 14 Jan 2019 17:25:41 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b27sm1924251pfh.113.2019.01.14.17.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 17:25:41 -0800 (PST)
Date:   Mon, 14 Jan 2019 17:25:37 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/8] ASoC: change snprintf to scnprintf for possible
 overflow
Message-ID: <20190115012536.GA12096@Asurada-Nvidia.nvidia.com>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-4-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112152844.26550-4-w@1wt.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 04:28:40PM +0100, Willy Tarreau wrote:
> From: Silvio Cesare <silvio.cesare@gmail.com>
> 
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
> 
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
> 
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
> 
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
> 
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>

> Cc: Nicolin Chen <nicoleotsuka@gmail.com>

I think you probably need to run get_maintainer.pl for the patch
and should send to Mark Brown and CC alsa-devel. And for subject,
we usually use prefix "ASoC: imx-audmux:". Otherwise,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
