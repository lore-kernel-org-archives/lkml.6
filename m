Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id l6wZJG74GFu2TgAAmS7hNA
	; Thu, 07 Jun 2018 09:18:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7191A607F7; Thu,  7 Jun 2018 09:18:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXTEo4OJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DE98E60115;
	Thu,  7 Jun 2018 09:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE98E60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeFGJSf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:18:35 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40736 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753301AbeFGJSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:18:32 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so13530462lfc.7;
        Thu, 07 Jun 2018 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1TpRIKE/7wxlbt7AoPHCf6M4St6zmDa2kXZGtSc/FWE=;
        b=IXTEo4OJvtaTSVWVwCKMpSdj84yTv6DXzmYTGJD7tOas1Gv23MH6y7YNg8ZXcuzM+x
         BE2inub7wtd0QGpWumhgBOiM2OW/6oP1H0mPdHzdIJDDJKcAn+2xzisEEgEzVFGzBubO
         VaZzIu7cOjwqsQyWajCKmnS8p4ZSYscPSvm5Zs2b6NAj/PpfYsLszP/D+4dJuDVKbcBe
         iRbMG+/RtSfuRKLWb4N7XxTuW9utziQNsjvzOEnxEOo+Ud4Q6R9dVQq1WYzmV5GkY7Gp
         IsSwp5s+4EZl6CkTcb+4ZGeXZ3R6rJWWvxL/382EGNTGQl0wbSEli05WlNlnk993rFw/
         9vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1TpRIKE/7wxlbt7AoPHCf6M4St6zmDa2kXZGtSc/FWE=;
        b=YRBIuesjmzRpzYTUIyU0IZbeHy8MVH8Ree/iWsKJGoSIUCq6hCyS388Qw0AjxfvfaP
         WZMOTM6gHFTI2t9aCxArLIaQbq2E5XWZzgq8ikO2d+fM9NwKYfbJYWlm2Yk4DKeoOuAL
         DEJclc1IE5ILZoYs6aMUc1ApmtcRTufPLMf4pFnvQnHyuagsng5roBcTa2sb7w2p1lmm
         22Q7vuXNGDj4/WP/htxTYPkts3hM3e1eZJWwTYcnLZ9UbMyKy1Zf12p3CPekSkB2Eyzs
         wicS6OdUqHmdq9KKLUDi1OuXUk1nFprSP3L9iRBmRZ/pBvUp6UPt+YFeeazF8RXTrVMW
         +W1A==
X-Gm-Message-State: APt69E2oRQfWFW185d097jTWL289aYgwLyQsxFuOJWd2g/xleuJrT29w
        SsqUfDCI3UV7D+8JN0ZChRI=
X-Google-Smtp-Source: ADUXVKJ7Mv/sPiW71AiwykcLkF3wQiZDf2n4R0LWVaKyjB0+lSvOZ3dSqJfKCF7yVdZalzyLxaPLuQ==
X-Received: by 2002:a2e:2bcb:: with SMTP id r72-v6mr930855ljr.133.1528363110786;
        Thu, 07 Jun 2018 02:18:30 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id o11-v6sm3617314lji.0.2018.06.07.02.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 02:18:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fQr3g-0000KQ-9w; Thu, 07 Jun 2018 11:18:16 +0200
Date: Thu, 7 Jun 2018 11:18:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "Du, Changbin" <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gregkh@linuxfoundation.org, alex.elder@linaro.org,
        Johan Hovold <johan@kernel.org>,
        kbuild test robot <lkp@intel.com>,
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
Message-ID: <20180607091816.GT13775@localhost>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
 <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
 <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 02:40:25PM +0530, Viresh Kumar wrote:
> On 07-06-18, 11:03, Bernd Petrovitsch wrote:
> > On Thu, 2018-06-07 at 14:08 +0530, Viresh Kumar wrote:
> > > On 07-06-18, 15:46, Du, Changbin wrote:
> > > > I think if the destination is not a null terminated string (If I understand your
> > > > description below), memcpy can be used to get rid of such warning. The warning
> > > > makes sense in general as explained in mannual. Thanks!
> > > 
> > > The destination should be a null terminated string eventually, but we first need
> > > to make sure src is a null terminated string.
> > 
> > Is there strnlen() or memchr() in the kernel?
> > Then check the source before copying it.
> 
> It would be extra work, but memchr can be used to work around this I believe.
> 
> @Johan ??

If you want to work around the warning and think you can do it in some
non-contrived way, then go for it.

Clearing the request buffer, checking for termination using strnlen, and
then using memcpy might not be too bad.

But after all, it is a false positive, so leaving things as they stand
is fine too.

Thanks,
Johan
