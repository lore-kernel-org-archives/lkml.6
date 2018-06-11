Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EPl8HHiZHluKSgAAmS7hNA
	; Mon, 11 Jun 2018 15:47:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5665F607BB; Mon, 11 Jun 2018 15:47:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR7iOfmw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D28ED600D0;
	Mon, 11 Jun 2018 15:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D28ED600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932966AbeFKPrC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:47:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46051 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753999AbeFKPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:46:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3-v6so31275690lfe.12;
        Mon, 11 Jun 2018 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I4jWLoawjjFsdp6i7l8jC2dt1EHm92Sjjp87D4VCHnA=;
        b=QR7iOfmw64LhAEgE4bDcIHJJhk8hdRN5kfrhUodu9cxOxKToAZmuPUb9wYfzMfRMJ5
         1eWCE8ylXj9QoHgfPE61wrGwfX8/FaVQZajhVQIsHIPZNjDWydUU8WxCMimzYcSCxFV3
         Lm3GHLFyKqKRFiZzIRGDKpkNH86OgSvJ26WHrVLFYuJ8JWkcf3AgtJyz3gcZIHRXwdMo
         /H3HhhmTQ2H+JtQ0rzwoXnFc8x9cHJcXj8RUOi1Hflkw7/3Uu/+aB2Utk8hDakw+PYDI
         MGk3em521qVJIuHC/+JiowIwQiOwva8jJiHitIDJ1IDJ6cjEjQlPpsQKYQDqwChZQHc5
         aTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I4jWLoawjjFsdp6i7l8jC2dt1EHm92Sjjp87D4VCHnA=;
        b=KvJYmUUSc3e9earP3ZJZFLB8EdNAHZzYd6+o83IHxZM63k+3OMH7sS1Vvp8ORKk0jT
         MlUOdXxReXYlZ2F83UEm0nCuzaXUvUdSkY0OBvPn6INmUAguQ9zaNQ2xcKcd+Vnqm0cp
         okyA3dx3Na2tVKUNTOxpW1kXVKbIpIvM5TeK9YvBlOs8eoNPyEtIKZDm08HC2QJd88Tt
         0eiwQm6Eeyn9Phpb1PEzW6Yc1wI07f43Cel31uBQTqHAvxdZ59SYlqxbLHjZSbq+hglU
         fjyfKVyWBup+ueK4f5ZvE8NNZGt5JI2oq3D+4Pa58mDkf+JN+aRXEqywADI+NqmUO7xf
         6NAg==
X-Gm-Message-State: APt69E2QlaORcxVONLZCaN+H2dCQQUa9TXCHXhorD4N1kZ+CAMDEgR5g
        4BWdpYhn18bbuTv9J/rH4dU=
X-Google-Smtp-Source: ADUXVKIKFv6W2AopBQicGiCuJspSXxn/oI5jcWy1eYuk7uGI8sztFLCc/L1TB7g8El3cqXSF036oxQ==
X-Received: by 2002:a19:d7aa:: with SMTP id q42-v6mr11049423lfi.75.1528732016226;
        Mon, 11 Jun 2018 08:46:56 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id q5-v6sm6456836ljq.33.2018.06.11.08.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:46:55 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fSP1d-0003kZ-Vo; Mon, 11 Jun 2018 17:46:34 +0200
Date: Mon, 11 Jun 2018 17:46:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Johan Hovold <johan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "Du, Changbin" <changbin.du@intel.com>, gregkh@linuxfoundation.org,
        alex.elder@linaro.org, kbuild test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com, lgirdwood@gmail.com,
        broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org,
        linux@armlinux.org.uk, linux-sparse@vger.kernel.org,
        mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org,
        changbin.du@gmail.com, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180611154633.GC13775@localhost>
References: <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
 <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
 <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
 <20180607091816.GT13775@localhost>
 <20180608160355.67712eb8@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608160355.67712eb8@vmware.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 04:03:55PM -0400, Steven Rostedt wrote:
> On Thu, 7 Jun 2018 11:18:16 +0200
> Johan Hovold <johan@kernel.org> wrote:
> 
> 
> > If you want to work around the warning and think you can do it in some
> > non-contrived way, then go for it.
> > 
> > Clearing the request buffer, checking for termination using strnlen, and
> > then using memcpy might not be too bad.
> > 
> > But after all, it is a false positive, so leaving things as they stand
> > is fine too.
> 
> Not sure how contrived you think this is, but it solves the warning
> without adding extra work in the normal case.
> 
> -- Steve
> 
> diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
> index 71aec14f8181..4fb9f1dff47d 100644
> --- a/drivers/staging/greybus/fw-management.c
> +++ b/drivers/staging/greybus/fw-management.c
> @@ -150,15 +150,18 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
>  	}
>  
>  	request.load_method = load_method;
> -	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> +	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE - 1);
>  
>  	/*
>  	 * The firmware-tag should be NULL terminated, otherwise throw error and
>  	 * fail.
>  	 */
> -	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
> -		dev_err(fw_mgmt->parent, "load-and-validate: firmware-tag is not NULL terminated\n");
> -		return -EINVAL;
> +	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 2] != '\0') {
> +		if (tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
> +			dev_err(fw_mgmt->parent, "load-and-validate: firmware-tag is not NULL terminated\n");
> +			return -EINVAL;
> +		}
> +		request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] = '\0';
>  	}

Well, I think it's quite far from obvious what is going on above, and
not least why things are being done this way (which a comment may help
with).

And just NUL-terminating the (automatic) buffer before returning wasn't
enough? Then it may be better to do away with strncpy completely.

But should we really be working around gcc this way? If the
implementation of this new warning isn't smart enough yet, should it not
just be disabled instead?

Thanks,
Johan
