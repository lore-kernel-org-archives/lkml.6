Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720AAC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2D218C4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhDXgCw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD2D218C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeF1CjI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:39:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40522 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeF1CjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:39:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so1860502pfe.7;
        Wed, 27 Jun 2018 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sRpLM6ISnOPdLdnljjGPhVlm5Cod5S2x57VNM395Yyc=;
        b=UhDXgCw5lkRynYxYkpfizXmRN72aYmRFBbPT1sBSLh1xzSf+tfNpC/mPTJmMjvANvO
         6LlXvki+MlQ4CJliJxL3pjz0urWVm85QNbSgHvQZWDmVGRIOEm70ULMxtwsqpHDOzcVH
         3c8Niv1RLwuKnuOyYpvq25QW0bOsa/11A/FaEDESnT4Kms/tsCrzfDQlzCmUIz6EItD7
         XIbRIEcnbId713h5qkDNU/usAX9sOevCP6SfCFv6Sf/gLD4dBL3vsR6jm0zMtUMC7HBL
         840CGyA8fd0qKL1nwOSzvjJj+UD6C2inFpUyxIOj0XBQ1aBr52H7BDJ8MXDCb5dB1fz4
         19mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sRpLM6ISnOPdLdnljjGPhVlm5Cod5S2x57VNM395Yyc=;
        b=LDqKT30dQMPagIaxb4Zbs15VXfndf6kRDRYbITb1byILiySfWGqRaTopl5hOajYk4N
         S57Q05qcmtUo+c/NkSBSjpJsK3GLA6/iIqb0ohMOHEK95EmWRoC+wZrmK1EQJeC7I1Ad
         It/l6hJH7uH4+xHiqtYKBPulztdxBwGGSatiZct4mjzi2EhZR3WRVnFhnUEs48XRLoDq
         Ehnh2iEU5349OiXcEEcyVI46MSmCeCx+BSlLrQVa4kE4zJw6tmribmFvpykAmRGPtnXd
         CWqQuJsOwjn3DoaokX+JulHXVUu3v8kabRErNTsvEVepB8/QijdBTyfmwXjARiSD8zLJ
         dnng==
X-Gm-Message-State: APt69E2R4xm64+EMf6rcffaXyXbm0g1jRutFWx32Mk0f2iBJ3BUvbuC2
        tJWeTOi8Tky2Suvc75h9p0E=
X-Google-Smtp-Source: AAOMgpeiAIAb+T3f3NosdUW1cN5VERiSKC9IK5+2oxgj0JcWEUNIhVeYT8tCENOYks8kRbPe2GhhuA==
X-Received: by 2002:aa7:8713:: with SMTP id b19-v6mr464871pfo.151.1530153545994;
        Wed, 27 Jun 2018 19:39:05 -0700 (PDT)
Received: from localhost ([110.70.27.221])
        by smtp.gmail.com with ESMTPSA id a11-v6sm7331600pgq.32.2018.06.27.19.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 19:39:04 -0700 (PDT)
Date:   Thu, 28 Jun 2018 11:39:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] printk: Deadlock in NMI regression
Message-ID: <20180628023902.GE481@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627140817.27764-1-pmladek@suse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/27/18 16:08), Petr Mladek wrote:
> 
>  kernel/printk/printk.c      | 57 +++++++++++++++++++++++++++-----------------
>  kernel/printk/printk_safe.c | 58 +++++++++++++++++++++++++++++----------------

Shall we just merge these two?

	-ss
