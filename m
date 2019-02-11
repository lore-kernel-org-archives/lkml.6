Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77D1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BAA2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mg4M3c4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfBKXK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:10:29 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:34630
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbfBKXK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549926625; bh=RbZTTlJJHZ2TKiMRzWETCDAlGSq36U+ITQSW5SleAAs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mg4M3c4cVaBlH0H6VHSN07pfRZJGZ5OAv0KTFuU91yRxvpw7+EF9IFEYe6Rh/O77ftMH0WHkQ/t0wxNP31PfFVhwT+sQ3zuhH8DSVu0oK5hI3CsCyCqAK5tMI8i/CxQp0vdQzL62wGw3X4h+GrK80K6lQrU+fyVCLqllRsI/MJbJtclxNyZjBI73ndjN5IXGauiLVbxhg/j471pgQcjrYWrfDQ5v4zcn6KNDfgAx3NPDWpkyMrxl5TG+rcq56FWKQ6tpeBzUzsIpI4vyik/USDfPnoREq0/Y+t50pHJm85CEIloNLMCk6dawZHA4etro96YvHWzXjNUUP9+x5FTWDg==
X-YMail-OSG: _aeHQR8VM1mobTPDy6VKNXFh_R3OTUa7G7UQ19RnEjUlkpG7S9xBklEf2.kqQhq
 ndCxBXN2A48nkRlBB6XLwyr7FPY8whEc4ZkTf4.HjMzBWyJ4qmjPEtoTSvze8B5jwV02wMAnm6JT
 gw1hn8yxPTvHq4BmArUwLSqXiY0LFW17qkQuly2gPphoqs8RknNaAUs9W4MlvPcFWOYmOrMAMnSB
 2dZbDPt5FEgN1jDdje6IW1puVto2TF5WUDOC.RUQNMALUPXKKtEotyyHhYiyxPWfKxv71xllqUIx
 K4lBHnY5liqa.wr651haDlq7m0Cno3XhByY2HZuuXYW8dDdkiv8MnCxfr0aLA7lFHpvEUhrh8DJp
 tkBOkH7TIzp5qeEL4H_pt4urlGh0yDCarq7dZVeAbWNzVK0Lf_LkhnuvOi5MWxcC0yqmirN1NjhE
 JDdh8ANGoOIP8u45zswR8f.drMd07FnccV46yBheTmRevH6AltCOuDdDc5sXOoF.w9DjqLaTbb9n
 3up6TKcNL620lIwnaWchP0i0Pia.3SgI9Vhi4CtVfV_1fsnZ0g7qWyYosnNz25g1T_fJb03H0VK4
 hS35sVKMJsRxpp5bgfx6DNVcWemXPlhALlp1BZ.idjXCOjxpVXyCHHBkH0GCrP3eh94zIKoljHzw
 1f.0C_WPstylum3ZKoiaWxe9o0lfN3W8mRhkZuwBf1Qg8XDodeUYB_MDyulmXrNN0.QuZb1u.iB0
 1g9QVPMzugQGD9fLE6v57BqGSOTOrNiO55gXNA9datCPKqmy94FfH971py3LyDjupw8ZmOnjroab
 1RzHSnfeouigOcUxqNZNT4Jj9.0YYSwfGa6k_zS55xy1hnIow2kGi.mYrAW4AEjHjGFl7UMIuJug
 oNHi5iOcJ4O1tO_hgGzCQpQoRt61JKt8ZkUp0uV3N0iTt6b9Q67b3wqldTp0BeLVxa50A_9V6D97
 Gfkx9xDi4BRsV13xbggUto7oZ3d1r7OwqQO9pitTJAtXm1w6edO1Axy_G430fS1agnaw738C2HUl
 Bnpgkl33KxvRParVvpvo2R1A99xA6mycRIodie06_mIsUkc7cKypKpXqL.Gdmv5NQdD561PNmOAc
 tlyyM8wnRxS_LAo5.aa__IE9ObhqVX1ElaA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 11 Feb 2019 23:10:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 26a66dbf95c268d7b84dc9a6f21c5cef;
          Mon, 11 Feb 2019 23:10:23 +0000 (UTC)
Subject: Re: [PATCH] LSM: Ignore "security=" when "lsm=" is specified
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
References: <20190211225403.GA7769@beast>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <74310e83-a258-e9c0-7d98-8b2cc5ced3a4@schaufler-ca.com>
Date:   Mon, 11 Feb 2019 15:10:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211225403.GA7769@beast>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/2019 2:54 PM, Kees Cook wrote:
> To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> used on the command line, and report that it is happening.
>
> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/security.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 3147785e20d7..e6153ed54361 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -288,9 +288,13 @@ static void __init ordered_lsm_init(void)
>  	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
>  				GFP_KERNEL);
>  
> -	if (chosen_lsm_order)
> +	if (chosen_lsm_order) {
> +		if (chosen_major_lsm) {
> +			pr_info("security= is ignored because of lsm=\n");

This is a little awkward. How about "lsm= supersedes security=".

> +			chosen_major_lsm = NULL;
> +		}
>  		ordered_lsm_parse(chosen_lsm_order, "cmdline");
> -	else
> +	} else
>  		ordered_lsm_parse(builtin_lsm_order, "builtin");
>  
>  	for (lsm = ordered_lsms; *lsm; lsm++)
