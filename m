Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDDECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CF0208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cko9XV+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CF0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeISHZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:25:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38913 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeISHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:25:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id i190-v6so1916986pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 18:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ojPp0tj0FKNKpyJOtWSVuqtxiQJwUqDJKD6Sfm7jraE=;
        b=Cko9XV+WxNtCa9TT7Fw7Y9zgxax7fPVC7yzKhqXz4tghiQPX8/mJPYhN1ycqUb+XVH
         yse8weYJDzA4Nbf3I4TsnJNrt0tITfpca/mgbAXEWSV5Xi+jXZCoQgqS2Adl8IYz6M6t
         3gYz2jej2FJFAy6uL+zpMldGpCGmGwmhZzTH9rutjFzYfG3qgrkwgqSUSjrx+isxQyQr
         MYyyZ5uRWLsljs2UAcEDoJhlnkQn2rQJ0ca769abc7M0kN0+BZCZWDXYzRE9bvJOL6Zg
         +vg0sUobxXNhEWyvpL5vFeVEGKYlYp3NCrqEumen8BaYwaJ3SDQOpZs21P0SqwZbCISk
         Zb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ojPp0tj0FKNKpyJOtWSVuqtxiQJwUqDJKD6Sfm7jraE=;
        b=dBFw1OnzODjjktN3YZQtAX4tvxJkalgRpKDWbp6EjsSZDJn/YYk7ow7B0ZyhFEfX/5
         4A650/85VP2qONQSAzVy/ila9pTHQI5D8C1xnBHCR1epxG4+d2CHgtzP3cKtM9nyORQa
         3BmMT4Z2c4By781yCNSXywVWNGa5umd6fdMO6VCmOVOYlOI6v/bbPls4iLENlg56tj2t
         4WU1j4wxm/vzyQJULy77QWXMTIvyYHNyKgV25YzSk5V7kLHryNklayIAD73c4Pwln1/N
         EwyGhUJ+olm53CiA3JUEUUYp3juA404ntCh08QeEAZagG1frNQ+jm4/2KskdfK1csHAk
         58nA==
X-Gm-Message-State: APzg51AewI5MJjdEq0Xp7pDxw193k2ga7W+ujCNM1wAZFdjZNLBIJGug
        qefUfMYFFdrj8IGZbT6VTeM=
X-Google-Smtp-Source: ANB0VdbTye1wX/1vxzvcC7/b+BM95iGW3VrQr9rGuJ8hBrsATcqlOZ3fbS+ctQcX2G1WGAOYO+MOCg==
X-Received: by 2002:a63:24c4:: with SMTP id k187-v6mr30406144pgk.162.1537321834478;
        Tue, 18 Sep 2018 18:50:34 -0700 (PDT)
Received: from localhost ([175.223.11.230])
        by smtp.gmail.com with ESMTPSA id s27-v6sm42690754pfk.133.2018.09.18.18.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 18:50:33 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:50:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180919015030.GA423@jagdpanzerIV>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/19/18 01:17), zhe.he@windriver.com wrote:
> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
>  /* save requested log_buf_len since it's too early to process it */
>  static int __init log_buf_len_setup(char *str)
>  {
> -	unsigned size = memparse(str, &str);
> +	unsigned size;

	unsigned int size;

> +	if (!str) {
> +		pr_err("Config string not provided\n");

pr_debug() may be?

It's not clear from this error message which one of the "config strings"
was not provided. Besides, I think "config string" is misleading and in
fact it's a "boot command line parameter". But, dunno, I guess I'd just
drop that print out.

Otherwise,

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
