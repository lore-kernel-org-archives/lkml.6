Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F50208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2HOxADL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F50208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbeLFMjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:39:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37837 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFMjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:39:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so122497plr.4;
        Thu, 06 Dec 2018 04:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAfVv1fXHChlj28NnvOrL7tpwgLJsRHjjgNzvpVju8o=;
        b=D2HOxADLF2fsEv0xXLeW5eBheQji0nm+s1fEv3STh6PobmuCrlpu16FtDwIfAMjxD+
         SpduyqtLAjyD3AxpdeeURZYUGjY9Yx3fiHOOoppXEPnoCUQc/4c/IfYRZ18KArxRh23H
         o0R3nmpyWG9KK1Ns7iFFjUzMOlrTZGRZNkbZcKGdAlg8FH25zxtq+//RcHYGZeXNRra6
         0o4Xkj+kWQcZW9Zf0JKLN11u8nDsJggxR4KSZaNHHeRmB26xvoPBxQ+U9toRrOxG3gQW
         mngd0kYyI36y9Gyn7hW6HnmrlahyM0aJtdbmD8idP4107NyTh/f82F3xPkXUFhNHIjhD
         Cg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAfVv1fXHChlj28NnvOrL7tpwgLJsRHjjgNzvpVju8o=;
        b=ZJF7A5oaFzksDxXLlMsuIbpG/koe6RRAko/WR5tQXb+PQc7dOGOUYEGtFOr5sSXFIU
         tAOmY9RRKVzWQfWqdc8i+Oy8LnYdvL/0HhZVPl9QjUt2qdbyk6dS4gcxisnCxVFQ69sH
         yJwDFJGNOLQK1J4FVdd3St+cNXD4FoHkR/leYnlEAsDFokobikG/LQGAk7UDItifu2Ht
         3jc3PNA9nIxMhPgDzp85y058NTDf22agj1V6vR+bMW1WtKw+a8CjiQpts0CwmX2Ic2z+
         /MwD/kSLZpkNEPnuoK52ZxIR+U+Ft1lJPFGM8MNL0QLeDdI6qdjUAT+OFgNoAUqY77EQ
         JjMg==
X-Gm-Message-State: AA+aEWbzs9U9C7kH3OQfX14//UFP+t43va6hAUK+aadiVD6trotokjVA
        lRWt/Q/J9pLigoxpDV3A6Ts=
X-Google-Smtp-Source: AFSGD/UTcoAVhaJqxeWwENXrr4PtUL32R+o79kJIiI2iUUiKvZq+xY94VmzcUb/nwLdCzR5xF+qX3A==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr28855122pld.337.1544099982501;
        Thu, 06 Dec 2018 04:39:42 -0800 (PST)
Received: from bytedancedeMacBook-Air.local ([203.12.205.220])
        by smtp.gmail.com with ESMTPSA id n66sm453760pfk.19.2018.12.06.04.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:39:41 -0800 (PST)
Date:   Thu, 6 Dec 2018 20:39:26 +0800
From:   Xiaozhou Liu <lxz1983@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into
 __KERNEL__
Message-ID: <20181206123926.q5gd5u62vg2u7s5w@bytedancedeMacBook-Air.local>
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
 <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
 <20181129021635.rzmehzzfgt2jvpgi@bytedancedeMacBook-Air.local>
 <CANiq72=uwbHqPB_1b7q+dD7FaqZ+HOmOvXMPX3d=z7-xqzwFzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=uwbHqPB_1b7q+dD7FaqZ+HOmOvXMPX3d=z7-xqzwFzQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:42:11AM +0100, Miguel Ojeda wrote:

> Exactly, thanks a lot for clarifying it up (we should put this in the
> commit message, I would say). That also answers my question: it is
> clear everything should be back into __KERNEL__. The only worry is
> that the v4.19 release contained 815f0ddb346c, so it has them exposed,
> so someone could have started relying on them. Or, more likely, the
> exposed macros could break some source code out there. Hm... Should a
> "fix" be backported?

What about letting v4.19 maintainers make the decision?

Should I send a v2 patch updating the comments and Acked-by (you)?


Thanks,
Xiaozhou

