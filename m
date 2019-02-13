Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7087C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F46218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNQC9hIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfBMAsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:48:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44276 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfBMAsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:48:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id p4so288098plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 16:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=54iEXpIIINx6ekpNfXFod7edpsR3F9pxXBIcNtz4yC0=;
        b=LNQC9hIxf14HO75u+gwTUs4DSFQAKw+fUBKBOs47JEFYx1i0uPhh3plyWfCuqdqWeJ
         +zOg+CuxChA3bRkrYZwu7sXh7ZY1PmVKIh7Gov6BTxIukVJgSHcMuv3QuNsfFvbrcYvP
         gw/lHa0HklwltBAckoG8UdmB7bJg8Fe6+6rBIZ+X5eIEQ0lEzAUNPozHnhAzIxfXqDJ7
         Tzf4TdiG1baUO7b0QFvUZFFpjL36JkIUjfL8j0IxyGeR5C0pbELbgYH9i0rckacj17Np
         nbluc/Usuy30cJWhyk+ffEPKbCZReC4LsLzCvNRsvgV6yVDU/onz9ytINZi9XRDxiTmE
         zNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54iEXpIIINx6ekpNfXFod7edpsR3F9pxXBIcNtz4yC0=;
        b=LxTqQ6Hxv3pamWF9cTxshO+nx54doEgFV0VrmPkY+/0SnWRR+eCxDQImN35O3GPaga
         nqAScjera67K2yUhxY4/fIrIaAGs70tKWRiGK/XyCDn4zJOaE1da+rrgs1JFlThe9YUG
         nS5eEw03xnPUPSFnWGSiIkbR/4p7QkcU9RdCQOLWfyOwl9bE9QRK2GGoBYZ7FYWwS5es
         iyNZs2uFs5T+fwKNpSt/REd8xjR2liUc03913MDqSwcI+l7fWhgZ4b82RAN8DR+4TqlN
         97T3h04/k+zN3JyxhAGdrXabsP0MTtEd8oIjboPPEE/aUcmFjslnIP+cM9rNbcRaE/B3
         ksmA==
X-Gm-Message-State: AHQUAua3W8X0FQfkbBrXWPmBNx+YRGNHnoCfgHosD9gElOMdJoZ16q35
        YAE0WwwEfFLF7+FHBRg8kKo=
X-Google-Smtp-Source: AHgI3IbADUqCB731eEJXxcYiyYM0o2Dk96Ao672x5A6l/VnU1UqPLatIhdya9+fGWFXUMWZS1mlk2g==
X-Received: by 2002:a17:902:b402:: with SMTP id x2mr6814216plr.53.1550018888233;
        Tue, 12 Feb 2019 16:48:08 -0800 (PST)
Received: from localhost ([39.7.15.189])
        by smtp.gmail.com with ESMTPSA id o25sm20786047pfk.185.2019.02.12.16.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 16:48:07 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:48:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190213004804.GA2992@jagdpanzerIV>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/13/19 02:11), Xiang Xiao wrote:
>
> Because log may already add the timestamp sometime
>

We have module_param(printk_time) which enables/disables
timestamps. And a .config option. And a kernel boot param.
Why would you want KERN_NOTIME?

	-ss
