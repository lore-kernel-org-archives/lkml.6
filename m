Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id h01RMKnnGFsgSgAAmS7hNA
	; Thu, 07 Jun 2018 08:07:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A7DE1608B8; Thu,  7 Jun 2018 08:07:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeQHy++5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0DD67605A2;
	Thu,  7 Jun 2018 08:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DD67605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeFGIHB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:07:01 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45138 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbeFGIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:06:54 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3-v6so13190773lfe.12;
        Thu, 07 Jun 2018 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j6pocmaE0MbgvzVSlpiEwKgfHOL7BITAEFG8A1KENrc=;
        b=JeQHy++55qjc/T7np7k9jQAa3wwjhG7yuELEt/IFiI8aeCvMCIv1rDQ2Ashr3YYeHS
         fkzzPVflbAR9u6qEv7oHNPNiqag56TEDo22hYCgYOBVj6H/wTN9cO5uFoVE/Z60sSAfx
         onsYPusVHXuikJmXTMhPnkglnEvUdAF5EDVT3ffBCTiu+LmZnXirO847QEun/lSK3XH9
         QMfUVgr9lXhWWmvwCri+fwYVAk544/+hxkDRy83ziVf+0xqTt9dRmgy+6nLYVmYJOu+L
         Oxod/6fJFIsiwq8ul1cbhyYL+Dk2IwZnevST8DCRwRXsoC7wYwvw/ZFVpq87Cv0pKYz1
         OBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6pocmaE0MbgvzVSlpiEwKgfHOL7BITAEFG8A1KENrc=;
        b=DeWiUCXjHAmTiRgZgDtv/J+e4Tt+tC28gppA3bRpR+OTiwaH6n/AYTSAnapfUYXLmn
         DzFFDl9DFiWAAzfDPxePvPjVB57A3ENyICXj+FAsQgDZnBgjdakE9h/E4ajKCrmDp/He
         Sq75qg4ka2OiXNIIc1zzJmL9RHi/C/LfChQOvd2HPwT4TlW3HMAQKZLgheIkz568deSw
         H6FCtjXvwIZGCZL8El1KwQmJ15hpxeWjehD/O7+1nCd0adTQLkpDrF9B12vFjCVcxVy6
         OlOXrmXeZ1OCvCeL3+iwt9tJ2pP1S7AJpc8psD5TQwCcSz2gYly5c1w4xIIjvrWGuHo5
         ZUnQ==
X-Gm-Message-State: APt69E1Zv2htocMclmCtWkepi2cKWvgzigupOp8Pvn+Pnd2JPSI1ZmAW
        BUV2JazseGRsHYY60MU9XnupHH6t
X-Google-Smtp-Source: ADUXVKL2KnqYhgC6MQL+FuYkoDvlCllYcbjYxKKRy73mGdUgkv8XGf9MFI1/ZfQ6m411Gvz1AfNqiw==
X-Received: by 2002:a19:d7aa:: with SMTP id q42-v6mr622352lfi.75.1528358812382;
        Thu, 07 Jun 2018 01:06:52 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id n84-v6sm3269588lfi.19.2018.06.07.01.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 01:06:51 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fQpwL-0008VD-Q1; Thu, 07 Jun 2018 10:06:37 +0200
Date: Thu, 7 Jun 2018 10:06:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org,
        alex.elder@linaro.org, Johan Hovold <johan@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com, lgirdwood@gmail.com,
        broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org,
        linux@armlinux.org.uk, changbin.du@intel.com,
        linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org,
        akpm@linux-foundation.org, changbin.du@gmail.com,
        tglx@linutronix.de, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180607080637.GQ13775@localhost>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:47:18AM +0530, Viresh Kumar wrote:

> On 06-06-18, 14:26, Steven Rostedt wrote:
> > On Wed, 6 Jun 2018 16:26:00 +0200
> > Johan Hovold <johan@kernel.org> wrote:
> > 
> > > Looks like the greybus code above is working as intended by checking for
> > > unterminated string after the strncpy, even if this does now triggers
> > > the truncation warning.
> 
> So why exactly are we generating a warning here ? Is it because it is possible
> that the first n bytes of src may not have the null terminating byte and the
> dest may not be null terminated eventually ?

Yes, new warning in GCC 8:

	https://gcc.gnu.org/onlinedocs/gcc-8.1.0/gcc/Warning-Options.html#index-Wstringop-truncation

> Maybe I should just use memcpy here then ?

No, as you note below, you use strncpy to clear the rest of the buffer.

> But AFAIR, I used strncpy() specifically because it also sets all the remaining
> bytes after the null terminating byte with the null terminating byte. And so it
> is pretty easy for me to check if the final string is null terminated by
> checking [max - 1] byte against '\0', which the code is doing right now.
> 
> I am not sure what would the best way to get around this incorrect-warning.

It seems gcc just isn't smart enough in this case (where you check for
overflow and never use a non-terminated string), but it is supposed to
detect when the string is unconditionally terminated. So perhaps just
adding a redundant buf[size-1] = '\0' before returning in the error path
or after the error path would shut it up. But that's a bit of a long
shot, I admit.

Probably best to leave things as they are, and let the gcc folks find a
way to handle such false positives.

Thanks,
Johan
