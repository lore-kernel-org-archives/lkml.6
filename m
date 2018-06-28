Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0637C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4C6258C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLbmvqpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4C6258C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeF1CKv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:10:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36475 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752544AbeF1CKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:10:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so1951351plp.3;
        Wed, 27 Jun 2018 19:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VIBf4Leu3QmbfKoZUklrw7xSHoQYg7k9Z1G9Qt5K4cM=;
        b=MLbmvqpIVnAEolp8dUkpRUKCmb+KBOvVwEDhqpcL66LPpqt6iqyE74AQc1f06CFAAG
         agbUphHv34V1B0RhGNOSvozE5AEMFKrkGLe/eyE+WIpRFXhzxr7r5Y+8OfVrGgw/whea
         uy29CVg+0o2dL5Ewpo6rebrMZN1FCs2yJi0YGHAJW4vvFcB8j8BpDxNfMizC414Hmw26
         RI97blQPmzKGTCI08i89IrfH3HKrcDdxe8Wq3uIDneRBT3Sf3CrjGoqrStIEVI55K0lC
         L6oq9L2U4Tz4xVE1iyDScFZlwTDfWrUTb/tjRQyGbk8hRTp1WrI1yJqIz2twTorZ5sLW
         j3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VIBf4Leu3QmbfKoZUklrw7xSHoQYg7k9Z1G9Qt5K4cM=;
        b=S1hxDRBTuyMX0yJOtkfEnshro7fD23mhETSKja3j/1SJc+bOaF9cJTeWigXvHCYP9n
         cpVbvH+Z4YV26Y3dYFWKoofz1Fl7I4FAxQK79mq8Yzlmy/oVpis0j2vc5nvv33XBqUPA
         esHkvlDVFgzziy3M1+bm7FBuynwaX/lqMofT9dO+bO80tP4jFoTosss++yH1dFJf2Iwx
         4psD7/zsVMJXm42ihw8qW2qp9gwLVDjKaJEG6HCwrnLsckCZZp/ObwxQcCMinB6z+tSw
         A4zrADaxLu391H83k3LkXC5k5zgaSD6DYI4AikEPjV4NIWyXoCCEocmpyYOUfLJ65Vm+
         mkWA==
X-Gm-Message-State: APt69E1XkJ3zWTK7R6SJYiojQzVsC1hM7NJk+Nu+HnydzEaQviXuh3cb
        5N/xFlLlMKH2O3Y20LP09g0=
X-Google-Smtp-Source: AAOMgpfMxn7oECLIMBdMRgXe6IvmOkUFWsXfFck8S/FDkdvLsA3wcGZuYHDjbiQcgYEYmlc34sjmqA==
X-Received: by 2002:a17:902:5481:: with SMTP id e1-v6mr1931304pli.7.1530151846895;
        Wed, 27 Jun 2018 19:10:46 -0700 (PDT)
Received: from localhost ([110.70.27.221])
        by smtp.gmail.com with ESMTPSA id y2-v6sm12634335pfk.82.2018.06.27.19.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 19:10:45 -0700 (PDT)
Date:   Thu, 28 Jun 2018 11:10:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] printk: Split the code for storing a message into
 the log buffer
Message-ID: <20180628021043.GA481@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627140817.27764-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627140817.27764-2-pmladek@suse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/27/18 16:08), Petr Mladek wrote:
[..]
>  	if (dict)
>  		lflags |= LOG_PREFIX|LOG_NEWLINE;
>  
> -	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
> +	return log_output(facility, level, lflags,
> +			  dict, dictlen, text, text_len);
> +}
			  YAYY!


Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
