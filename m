Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E280FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898122083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIYmHLVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898122083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJBM3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:29:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39275 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeJBM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:29:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so33690plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 22:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JgDsBxPeytEC/nz/ujn0yIVSp58qhyVSH03xckvGZCs=;
        b=jIYmHLVa41oq90j+c4R8mFTEBJcp66UMyGwAf+vG8kk0/v6XdvomOiBDJxPJ5uQTiK
         qV/n6DeszHxd2cs3siO4PxwacJMYd0fpMGV79ZCOThjbtClwe33NcRho1/dBInn5MayD
         FA8NkWL87Y8WdYW8CjMSmlFtvkHH0oPg8Q8tDWyjDTMtPRX+B8fBtOTJa+ui8tEJESdK
         K8QXUtyl5pYcXdp6aL66bmhYuiy1R3s57QwTM4V3g+MsWeXUL6rDtk5wE3jEYhKqM5wo
         Mt+90uE9/pPgGhV4LP+ArARmS26nnBVgyEzSFeadJzzwUKoNpnNV4iL1vLgPJUc1ft8g
         bwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JgDsBxPeytEC/nz/ujn0yIVSp58qhyVSH03xckvGZCs=;
        b=jt45Adcfk1h8iN8c5cJa6+rcGMBbpaiW6AZrRLc58DvsdCSphxhZ0ZylTFvR6xl7fc
         UTP0LKjMYXt+vJl9N4YifTWCMSVWVAczp9RyiVp2JoFFWqzAl2o4uzM1hq5c/SKOnkfS
         MMZ9ZZe7pWgn1eEfu90V4iFc4J47yrDCyibMqlYJ0C7PfwzHRuTJ3ajsB/accBXiOymf
         9kLVT5fXxG+cJaeUmxIbZp3U7FMQEI0/l9DNsgdvLqx6zUWYvLQ9ufzCk3F1wIkp8czJ
         vy5BEfCTO8mcD2YUxyDH03egoORHmvOZCZ0LxNVNFfuYsTqcroBPKSwahXr70hc3bTrH
         w4sg==
X-Gm-Message-State: ABuFfog/7TjVEJAyZKQSE9R4o2ilBjMZWvo5Fu+0hiwsj3rfMPcYSBUV
        DZtTln2E4MnDZk4HqNcmxv0=
X-Google-Smtp-Source: ACcGV61EmfSFed9zthkTErlMO9sIa6L8D4jmCp6cXI/XVmjBBcI+rWRcYXV0illdc+AriQyfk+LcDA==
X-Received: by 2002:a62:6f43:: with SMTP id k64-v6mr14457693pfc.87.1538459297967;
        Mon, 01 Oct 2018 22:48:17 -0700 (PDT)
Received: from localhost ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id m124-v6sm20502619pfm.164.2018.10.01.22.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 22:48:16 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:48:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20181002054812.GA598@jagdpanzerIV>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/30/18 00:45), zhe.he@windriver.com wrote:
> 
> This patch adds a check to prevent the panic.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: stable@vger.kernel.org
> Cc: pmladek@suse.com
> Cc: sergey.senozhatsky@gmail.com
> Cc: rostedt@goodmis.org

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
