Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2076AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF28221721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="DxlYtOd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBGXf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:35:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34054 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGXf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:35:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so758806plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+aPOwnMFp8bu6vZZzfOnbCeBjCpP04GBCVrSz8rPbT0=;
        b=DxlYtOd2Xq4WoHQFeA7jkN/lO8RATCcqe0jpVwb3Ep0OEyFANttpxjLmFxhNdxB08V
         h58RU8o6Co3XGXFVyqK/yQfJHPDVjIj9tiFAHhkarle9uI7+4rD0d6B0vt94Fy0s1CR3
         F9Uhi6YOqQRAALsizAgvS+bjC1R50No6FTN36d214bJpAEbjzPOfp0Y7+a5S8ZmAMTLM
         HdovSp8e07WGNkZwI0O+RrKOwdBX6BGK3MSxSyPw/1Rh8W1hOSz6s9SkuEniI5bjuKbh
         OM8AcFme0/hzRD7pSv+ROY7UgVVDzuHcgTupxKZn6Ruapka9F18fs1LTAb32nQKXNZdu
         ugbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+aPOwnMFp8bu6vZZzfOnbCeBjCpP04GBCVrSz8rPbT0=;
        b=IYKTrV5wkY9IolcLCC2p95xfRaEcBBidAUWKcm72nrUX50qVQXuZEASeZ48GS47ZuH
         pBGfKSjgATnYGfKC67SIkvz2UrPzbtNLLvTM3kL1O+z4s/T91T9gSmb00u6Ba6fSD5bL
         O6964MgH13HIZSh21SGrkakc9S+1peOTniQ253CbHPDc6hckOzGT9Ncg3JWWu8DTiXyW
         MUxGOe59MV2mvfWMYrBfSG8K0WF5dA/Mgc5rdBQ6XxdddrbntqZkbF8As2iY9S/ULfFq
         /IYnB5M6p/FEyXdkM3idpi7wtJefjD0M2t7KspVRIjodw7zMI6LX4HTJGnmjStiTQu+g
         ae2w==
X-Gm-Message-State: AHQUAuYZnsYw7TXk7HK6H2WtzBHhKhe3taBfkrum325ZuIAuOmD8NK+Y
        1SP//DhozVzN8gjM+QMIkW5WoARaSXE=
X-Google-Smtp-Source: AHgI3Ib6qC3CSf3tnDwLWIDmG5YzNLtlu/6kJFlRARCzi7QJmlrbammwhWqEQpD6L1my93RQhHJ5kQ==
X-Received: by 2002:a17:902:280b:: with SMTP id e11mr19255193plb.269.1549582557857;
        Thu, 07 Feb 2019 15:35:57 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:8c6e:807f:2169:b182])
        by smtp.gmail.com with ESMTPSA id j9sm300005pfi.86.2019.02.07.15.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 15:35:56 -0800 (PST)
Date:   Thu, 7 Feb 2019 16:35:55 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Message-ID: <20190207233555.GA5122@cisco>
References: <20190207225026.11723-1-tobin@kernel.org>
 <20190207225026.11723-4-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207225026.11723-4-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:50:26AM +1100, Tobin C. Harding wrote:
> Currently if user passes an output file to the script via
> --output-raw we do not handle expansion of tilde.
> 
> Use perl function glob() to expand tilde in output file name.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  scripts/leaking_addresses.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> index ef9e5b2a1614..ce545ca3fb70 100755
> --- a/scripts/leaking_addresses.pl
> +++ b/scripts/leaking_addresses.pl
> @@ -150,7 +150,7 @@ if (!(is_supported_architecture() or $opt_32bit or $page_offset_32bit)) {
>  }
>  
>  if ($output_raw) {
> -	open my $fh, '>', $output_raw or die "$0: $output_raw: $!\n";
> +	open my $fh, '>', glob($output_raw) or die "$0: $output_raw: $!\n";

Seems like you might also have the same problem with $input_raw? I
wonder if you can just do this in GetOptions somehow, so that all
users of these further down in the script don't have to remember to do
this.

Cheers,

Tycho
