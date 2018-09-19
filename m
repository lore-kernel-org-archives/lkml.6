Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D9FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4150214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+J92YQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4150214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeISIPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:15:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35745 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeISIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:15:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so1950679pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bNeTefKUd+LxqN7vrK/zspG7NrUiLeXoyMOycJqMg8g=;
        b=T+J92YQoMV4Y1IxH84RRbLIFszYtIlq8TWeYzfxh7HHVPnTKm8Y200m75S5HUBzTnO
         Hf0VHTV+9MERtV8FeRIZ4QCO6v0cm5K06qd5uWE8tZ8UyVNwgeF7MuILriw+HJnI1Ler
         qd0IRxEXmGFQTYQSBord1XdUDbDGe8uC0rz4vYHlvl+b+vE8eMcFQyPHZT+Znt01r0hc
         NKl9j+KBuOYwlYI62knyFOoy+gAQa10ZS5CH3M8sjzIGwcYfYdLyneWoKgbDTWNv00Gn
         rl+yl1xfLBn1MnUI7PoPiL3OD7JvjePwlGDljdegiYYDdibLOR9yi8smvYfgm/PVuG3p
         Wy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bNeTefKUd+LxqN7vrK/zspG7NrUiLeXoyMOycJqMg8g=;
        b=iatfxy6L//fta4P/GAXw+woH4OgaCjiWIKYveq9wvIMoDl33D01T6S8i4ILTo/+o79
         Jvg3uGpOubY50BzIMJi0oUEDLamBzLcvW3N2Dw7ayR8EvINXQhVixL8OhkwkQc2jAJ1B
         GayBVO30d1VZRflMVCutrxf9FiAoRXxMq7Jo6Jxr+1uHto+9O++BjCp+ZCVTmTmtLdNC
         07egaL1e09K6flD/BltR6LgKFMKr5ZmgpcR8Hhqn4DC58FynLTVoj+VDnpGFqvLYbC0l
         jUu6E5Fte4KbZIFpD/bwOmDjnYa74mx3R0xqkh72rSmEveHb3nItSSYBEhKDtGlt7Lsv
         5RrA==
X-Gm-Message-State: APzg51BnhzZnTMfzfWbewIn+KA4PvmH4bcm2EulstdaGAON8qTgN04hu
        kZJeadzBtJO0b96RClwrkLM=
X-Google-Smtp-Source: ANB0Vdbt/S682h9ccbvJzEXiyhFkgD4Zma4FYVsU35yJOgO++U2aqWIsNpUAv7N4fwVyBnm+OmWEQA==
X-Received: by 2002:a62:bd4:: with SMTP id 81-v6mr33859021pfl.67.1537324776752;
        Tue, 18 Sep 2018 19:39:36 -0700 (PDT)
Received: from localhost ([175.223.11.230])
        by smtp.gmail.com with ESMTPSA id k69-v6sm22541230pgd.9.2018.09.18.19.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:39:35 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:39:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180919023932.GA14090@jagdpanzerIV>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/19/18 10:27), He Zhe wrote:
> On 2018年09月19日 09:50, Sergey Senozhatsky wrote:
> > On (09/19/18 01:17), zhe.he@windriver.com wrote:
> >> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
> >>  /* save requested log_buf_len since it's too early to process it */
> >>  static int __init log_buf_len_setup(char *str)
> >>  {
> >> -	unsigned size = memparse(str, &str);
> >> +	unsigned size;
> > 	unsigned int size;
> 
> This is in v1 but then Steven suggested that it should be split out
> and only keep the pure fix part here.

Ah, I see.

Hmm... memparse() returns u64 value. A user *probably* can ask the kernel
to allocate log_buf larger than 'unsigned int'.

So may be I'd do two fixes here:

 First  - switch to u64 size.
 Second - check for NULL str.


Steven, Petr, what do you think?

	-ss
