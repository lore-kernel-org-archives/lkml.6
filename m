Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A553C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DEE20817
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwxv5BA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DEE20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeKMFgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:36:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45963 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMFgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:36:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so1532183pfd.12;
        Mon, 12 Nov 2018 11:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e+s2I9Yq1FpzeVRD1c7iIW3m4QnsUyryofOfuPHhcVo=;
        b=Rwxv5BA+cwQu1/5Cv0BzEwjGm97lW5Ok9LSRxxmXtbuhMBtYzj+pf/8tSVWXC044la
         zUeJW8CzbgRwSMsDKJQAKqgYzw5mvLTf+SBJGIKwk/v5LuKLeUZgGgJRx6ZJS/Lgu0AV
         AEb5K9dTf0y3I7CmN1L+sJo5osedD+jqxBGntt6kzszuFv5Pb+7TY/6bzEYshXAkIC7g
         yml3smfZ5Gdkc3f5yO4V43QXy79BCRjeMyvOQA2bStWuFB4gP9aFFnBasqNeexNWmGfn
         3Q8Eeo6jPgRFyPC/+3u4UNSgll5JfWb+dI0OpQibYrGmKBqxNu9kOcj5n8xfDVe9OTSr
         3aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e+s2I9Yq1FpzeVRD1c7iIW3m4QnsUyryofOfuPHhcVo=;
        b=Uci8+gD1MVbFJ9ovLO0hQFLbBg62YbetcdSJv5T/ZZDx9ZJRglsJ5sEYN6cJzfroq1
         FNHkchUB1G7O/QZz3VrAu13Okqj0Q/J70I1KayvL82XU1390NnRFp0TFDendcgVmhFNp
         aTutCYd2MXiq9wNQTMN+yZ6vu+Xq7Xf/Y/36FCSeIiZ5WuUUXN31dpdkHvk8OFMUiSpF
         YUsyUot2jRbckRXq7J1fZ64HHO9bl2wOm34xGcOpOO5IepRnffchmDbGp7UtqwW+wgBY
         YaJ9qGsYKh+UkCUcZUN1WaunWjDtEP7QDaEC1gnM+CUUiQqZxaXMnFoAhgqLg25PzYik
         PrNQ==
X-Gm-Message-State: AGRZ1gLyFpXWVXeF0SLG5vPYEhbhfJbGIsaU4FdPxuEt7YKRArMBOYRv
        8tqUMDBgzqYvZs467V74W1o=
X-Google-Smtp-Source: AJdET5frrloqJ4jMBVMDXlhlVu7Sx3oXcn3UKGY7Fbq6dauTSSCtfP0FQeQKgbuFxO+OTzp0WRo4NA==
X-Received: by 2002:a63:5153:: with SMTP id r19mr1917475pgl.281.1542051714590;
        Mon, 12 Nov 2018 11:41:54 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c12-v6sm7106872pfb.174.2018.11.12.11.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 11:41:53 -0800 (PST)
Date:   Mon, 12 Nov 2018 11:41:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: atkbd: clean up indentation issue, add missing
 tab in an if statement
Message-ID: <20181112194151.GG192687@dtor-ws>
References: <20181101151224.14840-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101151224.14840-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 03:12:24PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to clean up indentation issues, add missing tab
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/atkbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 7e75835e220f..850bb259c20e 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -841,7 +841,7 @@ static int atkbd_select_set(struct atkbd *atkbd, int target_set, int allow_extra
>  	if (param[0] != 3) {
>  		param[0] = 2;
>  		if (ps2_command(ps2dev, param, ATKBD_CMD_SSCANSET))
> -		return 2;
> +			return 2;
>  	}
>  
>  	ps2_command(ps2dev, param, ATKBD_CMD_SETALL_MBR);
> -- 
> 2.19.1
> 

-- 
Dmitry
