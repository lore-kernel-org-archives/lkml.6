Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3FEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26925208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzoYpSKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26925208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeGKB7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:59:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43365 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732348AbeGKB7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:59:44 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so8426600plj.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2w1aJop1sirH3bK/AuALMb6SNUKpMIMLYbYzrgE11p4=;
        b=RzoYpSKlqJuGSM8mC/6MXsKSgtnBtNM4JmyGu03hSJ0PE50wdoeSN1Wx6C491w8+IN
         L38sTqvNfC8BbFAplKWuJ5tmxUmM4z575qYk5ObmQnxf23e8qUof8kvU4NPj4lKMGt8N
         MAHB0xbsGelWobh9VI8TqyOLQB9OXBkRtoJo8vwIaXrb3XuBlURiEay8yuhXvzfxWul+
         vFhvcCHQ5pW12kecFx+pyAEZu2fyi7nR3S0mxkq0HYhLuPiElSNM01zP3xV/sB6jnVRm
         Bq62bQuUQbfjW2rbrvl7J5faC+6PbETJeTtyECmR7fmunjrCqLHpYs6ICEEXOyMMeZky
         qDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2w1aJop1sirH3bK/AuALMb6SNUKpMIMLYbYzrgE11p4=;
        b=F9Ofy7I0IYAu8SO8x2riuwAsGnniFgQbsFUm5aCimsDjjcpUFntCJY2W1u1ZMa5tDB
         3hfVHgFATMVv3gctmykQtLGXG+rbb+AeeHjWJXXMA3aI4hPYFmelFjT0k1GQVdLHvw1k
         iOYpJTu0g90qPRO4YuduvFjj9lt/DhojHEMW2xkzAicd6vxTA/4xpI8j71wERP5kXyMC
         YXekGaCLmJGHaUAeRXaVpzyyNQ5bTdCTnsaExNmuqGyJg3lwVwE5O1/WZOnORs5exT6Z
         eG+GKskQKParNoKznmR3tDzHlFvrScWw35YmqHtYmdfXfrb/Uvyj1IvnUrraa5+54Vxz
         T5Hg==
X-Gm-Message-State: APt69E0IMHliuoLZ51KjJaG22AzpK/ym8zNb1tAovGWU3nuUMJ0Bz1Cj
        Zro7UldthgTH53HvnzjNwj4=
X-Google-Smtp-Source: AAOMgpcbyIP+z9RIz8l1i5/9QC5g5napvtLDeTtliw6sVUMiDch8J1HyB65BcrLk08qu0BBq0VrS/A==
X-Received: by 2002:a17:902:381:: with SMTP id d1-v6mr26948889pld.309.1531274273798;
        Tue, 10 Jul 2018 18:57:53 -0700 (PDT)
Received: from localhost ([175.223.23.177])
        by smtp.gmail.com with ESMTPSA id c85-v6sm68862359pfd.110.2018.07.10.18.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 18:57:52 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:54:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>,
        Namit Gupta <gupta.namit@samsung.com>,
        Nikitas Angelinas <nikitas.angelinas@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: remove unused suppress_message_printing()
Message-ID: <20180711015424.GA13382@jagdpanzerIV>
References: <20180710152216.2393454-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710152216.2393454-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/10/18 17:22), Arnd Bergmann wrote:
> Moving the call to suppress_message_printing() into the '#ifdef CONFIG_PRINTK'
> section means that the alternative definition is now unused when PRINTK is
> disabled:
> 
> kernel/printk/printk.c:2033:13: error: 'suppress_message_printing' defined but not used [-Werror=unused-function]
> 
> This removes the stub function.
> 
> Fixes: 375899cddcbb ("printk: make sure to print log on console.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Arnd, thanks for the patch. I think we got the same report yesterday
(0-day build bot) and Petr have addressed the warning already.

	-ss
