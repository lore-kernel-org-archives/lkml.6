Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF4FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7035263EC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSajE4re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7035263EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964982AbeFZB35 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:29:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45359 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934280AbeFZB3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:29:55 -0400
Received: by mail-pl0-f66.google.com with SMTP id o18-v6so6996592pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=35Db5uOYBVJLufO+VJ9Tis1pNy9EvXpMLP2zfhUlN6U=;
        b=dSajE4rejC+j7XcVMJjcE9S7knVa9MUwHkV7ywFo+p0hWoFcAJ2qCyR5Vq8AP3HG6P
         1Iwk9Kekodv2qNv5pNUPvC48bevvjGDGQGU/PtZxOh2AI2ebO1D7Ddlga8AKlnEFZPIp
         RDMvw92RPmv/R8atnzukYsqiyxiXKEoqLdb1ht/VbtFiNeoHAZqvn1dN9Hnmx83R/gT8
         odlqGp/DtAwvErDSshsZWhkzO3RGMUoSMvNzLtj+ej8Zq7U9Fx8hsK4qakxTj8v91F9A
         aFUv5goA3WoEL3AwI0/c2xEgL4BHqhspTILrL/0ReJi7I3DRRY5bohwMJeTXdYRtlwj4
         T2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=35Db5uOYBVJLufO+VJ9Tis1pNy9EvXpMLP2zfhUlN6U=;
        b=rKku1KhX9jP8SZGt0DLqYIDVinrzPu5ephwJOxYfvqnicpI3S7DXZcHvWdZ1o64nG7
         DKs1h+TLtSo5o3zgwQrEZHhcidDvCbtgfPkOiFKFEhQvdlpTOdXCNdEc3eEaA4hU9lHd
         8JsDYpzsl4ueeZz2Udbnv82fQ+jX5kxgFQrC9ox1FJNCvnn43zZAzDqJaNmS1mod4bpE
         lWouzZjY1GrVaXwNGI7HFW8VMIxx3j2Vppe9Vcvu4lF0xakANp/hYWn6Q4csRPiKnC8+
         OJ2PZJP3wjNpZeGKj/ceRMZQfR64SgjaMsFKbaqYEnA9cK5YGyADH8De4ooG86ThkHaO
         gn9Q==
X-Gm-Message-State: APt69E0/SG5EnZTIX/N2JYb17dbpQA40O6fOAk5p0T4NLX4teipBipRd
        6ddBOytGd87NooVNt/7ffsM=
X-Google-Smtp-Source: ADUXVKJFaDqgaJj6zxpfx33lI4WP5pJLLjwx7YrbHgS0Fqox5pNlc5tA34cKsPyqyyZMYgl/+a5v3g==
X-Received: by 2002:a17:902:2702:: with SMTP id c2-v6mr14501818plb.297.1529976595369;
        Mon, 25 Jun 2018 18:29:55 -0700 (PDT)
Received: from localhost ([175.223.48.122])
        by smtp.gmail.com with ESMTPSA id c4-v6sm256587pgv.86.2018.06.25.18.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 18:29:54 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:29:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, sergey.senozhatsky.work@gmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] arch/x86: get rid of KERN_CONT in show_fault_oops()
Message-ID: <20180626012951.GA11229@jagdpanzerIV>
References: <20180625123808.227417-1-dvyukov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625123808.227417-1-dvyukov@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/18 14:38), Dmitry Vyukov wrote:
> From: Dmitry Vyukov <dvyukov@google.com>
> 
> KERN_CONT leads to split lines in kernel output
> and complicates useful changes to printk like
> printing context before each line.
> 
> Only acceptable use of continuations is basically
> boot-time testing.
> 
> Get rid of it.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

FWIW, looks good to me

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
