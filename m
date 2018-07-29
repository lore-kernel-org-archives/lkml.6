Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD78C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E66A20870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emxGoW/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E66A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeG2Wrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:47:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35228 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2Wrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:47:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so11497222wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8EySZ4vgZsmg970tasfOYFjq5bfh61vWfjpmqXy2Edo=;
        b=emxGoW/kMUOrEi93BrlZExasVWHbXGgVNuXOxZ0zibSfAGM9A6qCBAJeHsNyyk9d0D
         owKj4k26FLh5vl+jgd8RDxwlmHQ9x3cstSWysBd2RLdUTbKqlzpsybZMadfkdohUh02O
         ai71Zy+qhDiHf7FSGfTyAmeP5LqFvY6C96bnlOfy4WhAMSXdtnN5dUdJg/xsUGb2S9w0
         J2LPuu3OClnAuaGu/CbnPzNPETBPhoUBbucYkjp6WgAt5Ubt1fh5MvQk9pa8JIwZG697
         tGOqD3tffVLTZmZctcL0gOQrA5sI/LA82uyLRb9zvF8DJ8nid12JCRkwIpxcpeSfH/hS
         1miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8EySZ4vgZsmg970tasfOYFjq5bfh61vWfjpmqXy2Edo=;
        b=DqIb7vk8b+f5FG9KxdIrKp6Rhkeo12gMtTUpmRKeF82z2lw46Bj2GeSO0lEycGxrJ2
         5oGEvNVv3cb7fo+323+zumzA17PecGOyXHgX8lHnmPTWdoZ84rb+U559TX7IS790ZIum
         X4EAaWvq6FTzwB03K2SU0KU1NJk2p6vo0a5iSGsumjSpOlcuQGSWwAzjqyOTvPHANCIf
         MG7tPAxQwf96DNhJTWkXh4CvgSpR2iVhyPCpff2DjXOwVkyBi3KDUL/Vz4MAjEU9JdZ1
         jBo2Pq1Arw4d7Rfanep4vUAa4DfQeC1uJyqcOMHXA701U7B0/KGXJc7TqviY9w9t4Ceb
         6UaQ==
X-Gm-Message-State: AOUpUlH14yo7F6MoMVWmVqN37wL+l7u1GJcCrqcsRZ0sOovuLeZwFSHy
        BjA/Dr89zDY9CfGUPJRczWU=
X-Google-Smtp-Source: AAOMgpe5DZg+UdM/QMIx0iB/gTLPPtbq2A4ZG9D3kIlZTfmI4TM37jApVe3r8BmzG+NfMlzHkyaubA==
X-Received: by 2002:a1c:1bc8:: with SMTP id b191-v6mr12796585wmb.10.1532898942103;
        Sun, 29 Jul 2018 14:15:42 -0700 (PDT)
Received: from xux707-tw (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id r17-v6sm8838198wrt.44.2018.07.29.14.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:15:41 -0700 (PDT)
Date:   Sun, 29 Jul 2018 22:15:42 +0100
From:   John Whitmore <arigead@gmail.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 02/08] staging:rtl8192u: Rename ACI_AIFSN - Style
Message-ID: <20180729211540.GB10968@xux707-tw>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
 <20180729210534.10617-5-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729210534.10617-5-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:05:15PM +0100, John Whitmore wrote:
> Rename the union ACI_AIFSN to aci_aifsn and remove the typedef directive.
> 
> The removal of the typedef clears the checkpatch issue with defining
> new types. The renaming is to adhere to the coding style where types
> are name in lower case.
> 
> These changes are coding style changes which should have no impact on
> runtime execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 6 +++---
>  drivers/staging/rtl8192u/r8192U_dm.c             | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Again :(

Ignore - Sorry sent by mistake, forgot to clean out previous patches.

