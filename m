Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6ECC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B122081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="USltu++3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B122081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeKBXpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:45:44 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35456 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKBXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:45:44 -0400
Received: by mail-wm1-f51.google.com with SMTP id q12-v6so2107225wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VORLg5HdEm4dvNK7QaZUPmhFNxhcm4h6TKBft12XFvs=;
        b=USltu++3yH+GvXXMM8obQsJ0Yc2OTIetBKZE/bsWaYSOwdd+dQeHuA6yJ7hLk7IqhB
         Wewn16rXCC9soXGnCGyR4qE2d8+nbut2v0es7c1wXxtJB7TXuXraVi0IUgD0W9+yfiBO
         q2KE8XD9pjuYbh9SEvP7ivWFQu11YwERpXFQXxgz8fLLBNbHFj/x8W2f3iq/qQ1xlkBA
         b9bbca985vr2vZXLxTL00h7kGnyxbpL/uQpoSKtsHg/Tjx1Z0ik9e5Zc+fNx4f1UZKQH
         zoc6QPakpgekSV6GHQUnPLSXvYkTCW5YXf8U9hKf3Cyf8/toqQIy7XVgE3u3/3x+jQzT
         nMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VORLg5HdEm4dvNK7QaZUPmhFNxhcm4h6TKBft12XFvs=;
        b=avT6YBbGr3zTI3Kw4N6d/hTRcsbuDWMM/7qUFsfaurqlB4h1riBAAzflsxk4RsF3kQ
         cSkv1y4mYAdzb15rq9GAsJ0i3wmS2tvhzVkl19x8voamfkGmuQdCQGIJ3QnNCEVTelnw
         7CdHt2EH3zrzPn915uKwl6xl6TVrhpqiNtOoXVgdCe2u8qIiBRmtBgmYzPKLbW8HdTqt
         FQHPWq8hc+jNOkbgXfYL1Lc3uGaF7EhLMQio0Pcap0AX4X6AsINnXodlYY6REeBDJRBQ
         dN2vK12bRbXWwFIifB8lqoAlkYZ2Ljt8pmGaYhmXrw9TLzGnL21n7J7VQzWeSXennqOQ
         dyIA==
X-Gm-Message-State: AGRZ1gIObC37oB4i5rP363QjaVUDiZb8MpiP2MZ7pxU19XqKfTCNVHot
        sZSghikkr5iFr9cA6kRsFTKHB0onRic=
X-Google-Smtp-Source: AJdET5dT9zeeTFJF1VWxFGLKHdFHYNvTaDUqi9fYE0XmRNnpcbxJHCMgjK4VgKKQmfuyQ9nvyRSJsg==
X-Received: by 2002:a1c:868e:: with SMTP id i136-v6mr3243wmd.122.1541169503378;
        Fri, 02 Nov 2018 07:38:23 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id 140-v6sm24888643wmx.34.2018.11.02.07.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 07:38:22 -0700 (PDT)
Date:   Fri, 2 Nov 2018 15:32:14 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Vadim Fedorenko <junk@yandex-team.ru>
Subject: Re: [PATCH] macvlan: use per-cpu queues for broadcast and multicast
 packets
Message-ID: <20181102143214.GA2199@nanopsycho.orion>
References: <154116580015.953950.9450253307804393677.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154116580015.953950.9450253307804393677.stgit@buzz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Nov 02, 2018 at 02:36:40PM CET, khlebnikov@yandex-team.ru wrote:
>Reported-add-tested-by: Vadim Fedorenko <vfedorenko@yandex-team.ru>

This is supposed to be split into 2 tags.
