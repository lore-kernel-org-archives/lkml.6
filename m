Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C84C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA821477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgVFZztl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFA821477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeINAUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:20:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39511 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeINAUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:20:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so7626591wrw.6;
        Thu, 13 Sep 2018 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DlYs6PXEw5sA9Kll0NgD3Ey8M1e1VvrRjB7oR+/Z0XQ=;
        b=MgVFZztlI7XvR0IZ0rFohtV/qzhQowEr6iLl0LCPq0fmUuE79Dt5HO+CEiTOXOY9gT
         wxTKXVtJudFHbHMAQP0Oc9ThrzqsLt9g41Gar76GioyUM5AvxxQMgq0Gypb63EDI/y8V
         zHyTOr5nfYJXLvywkCNeu/8dsLuGd2zw6ckQPO7eanciYhZj7+NoGkhxFQW47IcF/UM6
         vfyqVW6cp/ymJr6uu/O8JeFydTGNyvSQnVJVyFL0h1E52t57uIRxswQkcUA2wHsCQQXQ
         LU433y/A6IRBK51lQaIEk7bPgTzWw0DeRSf9rE421FXsXHW0dNN5N2udalXy0gFEF5WM
         ZYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DlYs6PXEw5sA9Kll0NgD3Ey8M1e1VvrRjB7oR+/Z0XQ=;
        b=VlHJn1VWzMcTEbbzoZXaRwCEZXHgRgQkZnbhVb05z6WS7h/8xfJ658yvNFAVRyUBuk
         aANmYYoUQnBVhSuBf1DGSTDQlXRByZRnf2zxN8XQvIpGHdFaDY7YWhpjDgUHmxi9Dr7C
         KfOBgDVGXiqBQKK+THxNqV/8EuUlfLP/P7ssj3gcYqybAg6sD1Rtvy5t2aF285h906+O
         uitCk9gmSoDO8W7Hk6B3X7X/Ht18+TPgNuIZSTzS97Q60qb9lIKvPWf+jwwT6DthENRM
         z8TT3txuhTHc5eu47kHXx8knRcO5e1O5Kf5uYn3SS9dxlN8hFijJoJ70kw3FkAeSdH21
         SSLw==
X-Gm-Message-State: APzg51BfTzE6rxIUFQ4CKKBjUR5GRvpJr7NK96RWbeNExENRbF8QEFHU
        g4daUmlZVKbwKkLn7WvwmbxOAKbC2yJhdw==
X-Google-Smtp-Source: ANB0VdY27HS27ZKTSZ7soPuE/aDvY6MkVJsUt8IPUu/kQ1LqdEEez3eB/hb2rvBYovRACalU+IId6w==
X-Received: by 2002:a1c:1dc9:: with SMTP id d192-v6mr7131424wmd.140.1536865802779;
        Thu, 13 Sep 2018 12:10:02 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm8244447wma.33.2018.09.13.12.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 12:10:02 -0700 (PDT)
Date:   Thu, 13 Sep 2018 12:10:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/78] 4.9.127-stable review
Message-ID: <20180913191000.GA30873@flashbox>
References: <20180913131805.732342940@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:30:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.127 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 15 13:17:41 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
