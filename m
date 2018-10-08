Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAF4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C042086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUlvSU0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C042086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJHWMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:12:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43192 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJHWMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:12:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so10205785plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GWoveWWGGwUZeu4tZ41IH6sdZzafw2X+fl1rxLbRXKo=;
        b=KUlvSU0R/aSmap0aRZhsImI9svhbbzq1BNI1pP+5tg8d5yc937yM6ugGa347qTHcRh
         RhSqhDtB3410JM5620/AaB4SIpE5b0sPC8TEUvlk5sMvTNcmhFcctSlm314u7zly+hrp
         XF1WXD00ige247hW9OMUh8A4pkdMZnUTPewqIzJdGd68Jc76cbUpQy0HjO0HpUuNCqjs
         Z2lrC95/w71j87TMBlKW0Froed0acfXJ4FHzB+VGj9psu1RE14hzbL/GZq7NmfuYkLTe
         GXOOeTEegUCm/x1P8H+yuLv9DNDbKRYZs155SP60cQfyuHaW/C6qWjFfAf3xy/T0iK35
         bfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GWoveWWGGwUZeu4tZ41IH6sdZzafw2X+fl1rxLbRXKo=;
        b=ILB++tkZ0lZ4HpqoMh+Mrz821286y9SFnOOopg1im96xO0U1RDOqmbgg9c/ysT9lNb
         Ts28VJc9NTPaXeK80g3ZtIifSAzpLuqrpLcwLBenN3Svj/3yOPx50H13hfaPF9MXT/jm
         huJQewPfF/l+z2s5B6zYwhp5H8ayS2rNTj01l1HO4/3KbFu1eQ0Fjxf0Gcv+00fxEk5B
         3vkYQBjAziZ+tWgXEnOK/50KIfAMt6pdk5n2kwztX75N7LH3CEpeM6F6vTnBN2QOS2da
         9xF6G+VEyPYpUjcBUhPVE4uMBgcbHUTP3ECzFlUCsidgvNJ1IJl3R+RUc70jea1tF5j/
         BSZA==
X-Gm-Message-State: ABuFfogqADNk0zyFfLY4qX/TTpNvLja420+d6iOE4Y9ftYPGwzoaZLiE
        e0x3Nw7KVcMyy5zu48gBlpw=
X-Google-Smtp-Source: ACcGV6302qonD8yM3XdOGq8+4A9Xsg4JrpcWUERJZy7taluS+bXnBNhFFWvVEY8QUeEMwkiKEsQ5cg==
X-Received: by 2002:a17:902:24b:: with SMTP id 69-v6mr10290315plc.280.1539010794385;
        Mon, 08 Oct 2018 07:59:54 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id p62-v6sm28659104pfp.111.2018.10.08.07.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 07:59:53 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 8 Oct 2018 23:59:50 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     zhe.he@windriver.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: Give error on attempt to set log buffer
 length to over 4G
Message-ID: <20181008145950.GA1473@tigerII.localdomain>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
 <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/08/18 15:59), Petr Mladek wrote:
> I tried this patch with log_buf_len=5G. The kernel did not crash
> but dmesg shown some mess. There are several 32-bit variables
> to store the size, for example:
> 
> static u32 log_buf_len = __LOG_BUF_LEN;
> u32 log_buf_len_get(void)
> static u32 log_first_idx;
> static u32 log_next_idx;
> 
> I guess that the code somewhere does not detect an overflows
> correctly.
> 
> I am not motivated enought to add support for such huge message
> buffer. Therefore I suggest to limit it to 32G for now.

Yeah, I think we gonna have problems even with a 4G logbuf and a 32-bit
user-space doing syslog(int len).

I agree on the "not motivated enough" part ;)

	-ss
