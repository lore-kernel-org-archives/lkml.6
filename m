Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30FEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29FE2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OngK7OC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29FE2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJBMd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:33:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35486 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:33:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8-v6so46692plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASclitxP4ojBfuMP7sz80xPe9QWH2DERcsfoYODRUJ4=;
        b=OngK7OC7AKvwTmMX4cP/WIP6h66kgMq2jYJX4m3cEXJ212ykFHsdJOMlMrVgm8/tL/
         QcGVuqSxMx5+Cy3tm6n2W8+DFrELF801nlUY5gONNGuF9CQG3zBbIVgItAXqV8Ks4I+/
         /rElefV378K+9d4u6N9adg06FMwywbCeMuL4yOzLGYdPRSqj0ybCQGDXQXCA4vqIc2EV
         3NiobeGtD5By2UvZ09KLLcyHyBdXQEA26otMtau9BZY2FkUilGi83KL7/Jj1QKQ3GKH0
         FvZ2IuITSWVa6i0ThBqcIGBp83pE08IUdcMZFMLx4m88FDjDc9msRViH2UPK04nx/PkY
         Y8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASclitxP4ojBfuMP7sz80xPe9QWH2DERcsfoYODRUJ4=;
        b=h0OXvrkfr93YObYRZGpYyYxzdmtUefWa6DYwparJeRKCwvTQ82YDUYhsvXZM/DIFzL
         5ZCPXPuyNLbEI3IzwiqG0K9cKOlz89jrhvCGTZHOcmFKhxKBaSThcjAYOiRxl6rbwQ9O
         uPoffgF3YTwuusXcyGJrn1Yi5h+cFbLoO+z1cmrXmgPsQSsRXU1XKhoVxy0iqStPb6LQ
         d5rOHIfkJ/+fvtgBQBzemQanOLFGXqQdKwE97q/M31Bu1wo1a2gdb+ywQWivdzDLWfID
         PWS0pvqRU5UB6CHrmyuRAYgjjs41vZLro479MrQrFJVByFPYDkeYYvzkgFEgTj4roS//
         /xzw==
X-Gm-Message-State: ABuFfoicqsZL8Yj3g/g3FKgs7qzWRFCmf5ytSaxyPNQiS5Rvxnq2tySN
        Qc459JBb4hpIL7xlVuhZ+Qg=
X-Google-Smtp-Source: ACcGV601GCkWHRWQBufAWQLdvvBpwO/giIjIi0Prm+XqFvWjp7Q0gk1HXSR+X9yvQuK1aUofksXu9w==
X-Received: by 2002:a17:902:6689:: with SMTP id e9-v6mr15103197plk.115.1538459549324;
        Mon, 01 Oct 2018 22:52:29 -0700 (PDT)
Received: from localhost ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id u184-v6sm29804954pgd.27.2018.10.01.22.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 22:52:28 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:52:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] printk: Add KBUILD_MODNAME and remove a redundant
 print prefix
Message-ID: <20181002055224.GD598@jagdpanzerIV>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-3-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538239553-81805-3-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/30/18 00:45), zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> Add KBUILD_MODNAME to make prints more clear.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: pmladek@suse.com
> Cc: sergey.senozhatsky@gmail.com
> Cc: rostedt@goodmis.org

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
