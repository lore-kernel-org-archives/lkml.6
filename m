Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V77tB9mxGFsATgAAmS7hNA
	; Thu, 07 Jun 2018 04:17:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 025D0608B8; Thu,  7 Jun 2018 04:17:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgqIEDTs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 55B4F60115;
	Thu,  7 Jun 2018 04:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55B4F60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeFGERY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 00:17:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41452 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbeFGERX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 00:17:23 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so5191649plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 21:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B30T/MR3oOIEVwdYJwa4azGY1N0gbhZXwu5qbrxKnNA=;
        b=GgqIEDTsLXciUpO5wdEIxmnYQXy3U5T5I0d+dWEBsymqaFC9o3T7qwSoLKMpxE15aO
         S7OqTK+q2S/fWEgkRYI1GLUdkWJlerBHEfCUHZHta7UpC1Eps67URp2BV0tm+EpXvzOn
         CjAsADKymcNCpgGbMOUc9wJ/TLloyq8gKG3HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B30T/MR3oOIEVwdYJwa4azGY1N0gbhZXwu5qbrxKnNA=;
        b=Ay1QkJUJGUhRFZ+9JRQz1S2DB7HD7GiTAHtDsdOsuICeSMeI69w7l8SRxaow0YPjcX
         J69nUTKxdU7dtsfypoB93nq5igPhHmkK9mKLH8wyL0hG4019AJ9KRp4hfgwUT6zMNbZI
         64k7Cxjna1XlIIrFTv+t3YxmMixzPzp2hhBY1iGr77JFelOQzpqyUtmY7oHZggR5Zkd/
         DHxjNFWVK2Qgu0ohVg/f+WvLcb6sCv92rT0KoLQClBLFbJXt0o9u5by17wEcxlk5AW9g
         TUq3vDDXNOI8Ul7aRhEezvnULoZmZ33YDSu82XP+FiLhQYtdZ3dbR0cBg3OMD0P4j7Nm
         FllA==
X-Gm-Message-State: APt69E26NDPaX6RlTDTTK4EiwRRdBxwSziV1kyIJNtld/iYp3mqqXAci
        udp5WI/04gHrf24bVX4mEDBC/w==
X-Google-Smtp-Source: ADUXVKJtT5DSPqppXJCe6/+fJAovyoyu86Ju63TqkPmSEJpRWzWIr+Hb+0Y0c6MiSpKUm87LsBMknA==
X-Received: by 2002:a17:902:650a:: with SMTP id b10-v6mr323796plk.45.1528345042356;
        Wed, 06 Jun 2018 21:17:22 -0700 (PDT)
Received: from localhost ([122.172.63.23])
        by smtp.gmail.com with ESMTPSA id u65-v6sm47016596pgb.36.2018.06.06.21.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 21:17:20 -0700 (PDT)
Date: Thu, 7 Jun 2018 09:47:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gregkh@linuxfoundation.org, alex.elder@linaro.org,
        Johan Hovold <johan@kernel.org>,
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
Message-ID: <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606142622.2338abf6@vmware.local.home>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Greg/Alex,

@Fegguang/build-bot: I do see mention of Greg and /me in your initial email's
body saying TO: Viresh, CC: Greg, but I don't see any of us getting cc'd in your
email. Bug ?

On 06-06-18, 14:26, Steven Rostedt wrote:
> On Wed, 6 Jun 2018 16:26:00 +0200
> Johan Hovold <johan@kernel.org> wrote:
> 
> > Looks like the greybus code above is working as intended by checking for
> > unterminated string after the strncpy, even if this does now triggers
> > the truncation warning.

So why exactly are we generating a warning here ? Is it because it is possible
that the first n bytes of src may not have the null terminating byte and the
dest may not be null terminated eventually ?

Maybe I should just use memcpy here then ?

But AFAIR, I used strncpy() specifically because it also sets all the remaining
bytes after the null terminating byte with the null terminating byte. And so it
is pretty easy for me to check if the final string is null terminated by
checking [max - 1] byte against '\0', which the code is doing right now.

I am not sure what would the best way to get around this incorrect-warning.

And I am wondering on why buildbot reported the warning only for two instances
in that file, while I have done the same thing at 4 places.

> Ah, yes I now see that. Thanks for pointing it out. But perhaps it
> should also add the "- 1" to the strncpy() so that gcc doesn't think
> it's a mistake.

The src string is passed on from a firmware entity and we need to make sure the
protocol (greybus) is implemented properly by the other end. For example, in the
current case if the firmware sends "HELLOWORLD", its an error as it should have
sent "HELLWORLD\0". But with what you are saying we will forcefully make dest as
"HELLWORLD\0", which wouldn't be the right thing to do as we will miss the bug
present in firmware.

-- 
viresh
