Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3294DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C629D2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxVPAGH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C629D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeICSi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:38:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50177 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeICSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:38:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1387137wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YYvuE2p7XKZLDZsmuOPxtSmrOTzfho+3vfTdkCBoOUo=;
        b=rxVPAGH5b0KwujJ1tw3iV9JFy0r3l7Kv/7iX+BW1k2/dIatho3C6kKmyqwhHJjHGJg
         LxkDLmE+1zlbisFIcM4I4O1V+/ksD7+bBDeYFI5syUCEML4tJewarbJFyHFRWwZ+16w/
         xtKAwibfLJ46xa/jX3f4tglcx7jcqfRQQOSwd1KJxuHFoe3MyLxFyujJMlg7X/rf/8hN
         wTglfQ61SQ90Kj+Cs1VjzJFTSNkrONwsJFhjdPl25Sgg0kqy6hPR9HNwZobH2uVdDN2U
         pLEGowtc3T0ZNgLDSxwxpEwsnBl/n8fI64CinnHfetZAjWLmKgl7VmXz5zpPbE4W1it3
         cF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YYvuE2p7XKZLDZsmuOPxtSmrOTzfho+3vfTdkCBoOUo=;
        b=KX+0vojtznpfwZJgQG0N1puPDCfja8LNmVs6ZL99Kggflj9kQ1V+z+AHTsrehsKHdc
         lfeUhto7zl7a4mPUmRnuc4ldjx96NUuCdWXzUJ4Z/gDYAwrL6PCJZbL3W4JYNukrkuIa
         bVg8/24xldKCYa0D1r5iif7AAXEIDIQl0Zxfoq1RE3TPISAKnqg7HFrLoidbm4MqwJIG
         1BHjujP+8YnmbovlpJJs8q8sQmAgo8xagIGnLafYtNMImY6QhSqKFDzHareAgyWchlkm
         Wj1mdc0cAVxeouM1jZkVtKjmNRTZI+BuTCPrXts+/27li/IxcV4a5cIDlX3ldse6SDlm
         NNCQ==
X-Gm-Message-State: APzg51CnA5jJzZ3/G+K+zOQAy7Etde8lzwOKdg+ukU3mQste1ottqqlg
        +x0tjg1OYkN3XcM3MzT+7GHMo0w=
X-Google-Smtp-Source: ANB0VdZPTh6icplb9CHoaFwY+D3egMlg/f9RZq+1JUp+d/xmrda6u2NwRSM2pLr00/yqgcLsTV5MPA==
X-Received: by 2002:a1c:82c8:: with SMTP id e191-v6mr5035211wmd.35.1535984282124;
        Mon, 03 Sep 2018 07:18:02 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id y206-v6sm13550237wmg.14.2018.09.03.07.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:18:01 -0700 (PDT)
Date:   Mon, 3 Sep 2018 17:17:59 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 01/13] seq_file: rewrite seq_puts() in terms of
 seq_write()
Message-ID: <20180903141759.GA11586@avx2>
References: <20180827231503.26899-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote:

> > If execution speed is really an issue, as
> > almost all of the uses are for const strings,
> > why not use a #define and avoid the runtime
> > cost of strlen where possible.
> 
> fyi: an x86-64 defconfig increases < .5 kb and
> presumably is faster for most all seq_puts uses

> -void seq_puts(struct seq_file *m, const char *s);
> +#define seq_puts(m, s) seq_write(m, s, strlen(s))

I don't know, seq_puts() patch was last minute observation.
It is independent of _print_integer() stuff.

Your version should be "static inline" of course.
