Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18235C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1FE2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3b3cwlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1FE2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJBMd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:33:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41661 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBMd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:33:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id q17-v6so44949plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 22:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rR4GFvITEV/G9vZIiFNoJD5BN60ysQSg2iTPtKS8bm4=;
        b=R3b3cwlHizh6wmYQOTtX/BOqSkxUxODKtDZr28j0ThzrygOx9L69gaeS9miOn7RsJZ
         E+FIaRtnwFsDvGMvQ7frmycpCZDI6UnzOG4hZRYMbTqIf9LuCTp5FvKF1GW2GdhvDMPg
         f+lUDNqVeKuxLs2R+X6vKno+XIna/ZIM8XL8Ct5EJdGREfBCsVGBn+YhrzrYBUxZeMUX
         FnWLUyTzozHzdBFXAHVTsYhq0MkxjanN//0Cl4/a1eXyNh9o0JKoiF2LHfcG6MsxWSSo
         bGO9Ndh7NOOpk3zROeRSIAiCSdHyty97H7cJvto6RuRfp6KbBy4tvFygq/9/dMdIctqf
         +Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rR4GFvITEV/G9vZIiFNoJD5BN60ysQSg2iTPtKS8bm4=;
        b=ewV0+UIuPCLmtsJzoFh29kLJHUo1IZdRQ65aggffNXhtXLZMTeeIHV8afMfI9oZt5o
         sl5BFyh2QbUYHkfo8z4clhAdgPBaShc0JKeVPVh5YE3COXg4ybJlnJiHjTGWcuikAP5B
         s7IbCDgk4U+eJCZEfoxl+Ud3VNg5EQWG2RSXkzKtV2RYlaEkKEG158KgGN98YtXWR/ZX
         W2zNLXGVDWIIehFrbYNBmrM/WzW9aHhIL/AYGmHTsRiZQLRum35f5+XwQAHbM7uercnb
         kaUPG7NRLR3em3MFBxcl0yTXeOcr1XpcUMxadU4M/i5Okzz2iSnxS/knD4vzGAnrrEpH
         rZ9g==
X-Gm-Message-State: ABuFfogRx6Qn2B4+a1CPulm8XulpdZMtW2t8IqPFWMWu7JMOFeTfgdJe
        o70N7RASH3ptPFwkaD2mivc=
X-Google-Smtp-Source: ACcGV62+SzY8fbkfbISlOR77ZvJmWsn29PuzYsXfT0tIBJIOaLVlDFfJEOsvUrZqzwBWl13Onv26ZQ==
X-Received: by 2002:a63:720e:: with SMTP id n14-v6mr13175826pgc.193.1538459522470;
        Mon, 01 Oct 2018 22:52:02 -0700 (PDT)
Received: from localhost ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id e2-v6sm17340172pgv.25.2018.10.01.22.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 22:52:01 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:51:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: Give error on attempt to set log buffer
 length to over 4G
Message-ID: <20181002055157.GC598@jagdpanzerIV>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/30/18 00:45), zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> Give explicit error for users who want to use larger log buffer.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: pmladek@suse.com
> Cc: sergey.senozhatsky@gmail.com
> Cc: rostedt@goodmis.org

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
So people will know who to blame ;)

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
