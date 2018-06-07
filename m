Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id j33dHYT4GFsAVgAAmS7hNA
	; Thu, 07 Jun 2018 09:19:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0B4B1607F7; Thu,  7 Jun 2018 09:19:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6FxfGxg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E6473606DD;
	Thu,  7 Jun 2018 09:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6473606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeFGJTa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:19:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42637 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeFGJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:19:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so4606862pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zUteiuLZGZl1vPXeKOE12kMgvdfGFTtlrpEiUqgjJ9Y=;
        b=H6FxfGxgAwB/jvB/2LihDTFAGXV03CzcadEVInmZ/Q/9N7cTx2EA29gPWtB62N9XPE
         o314pwz8lpb2q6eTK2tvbUDl0U5QiHGpEbl/obGmr5ZdtmjD605YYuk9/J37l0uQdwvZ
         UGsmSMdHa+XNYE0dms4E0FJzv5reO76jmJx7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zUteiuLZGZl1vPXeKOE12kMgvdfGFTtlrpEiUqgjJ9Y=;
        b=XMTe8B4NycZpv3HqXT+kuoQaW0+sualJMrpFdd72Iimj/+goQnz0zlXp6t/0TjFkQc
         sMyofIhJsSUXteEJyku+UHlpaoMiRGJq4jBis7TzNPrf8iZ3sgFzFt1A37K2XcEbvP/g
         tLC9nhbSmrn4+YaJe0NAa7Gde0Zu4Euky3/Fl7iVE8pooNxSBZmkrPRSLOeMdnQWGzNk
         3HUPkefjXborG1trE1p1PZ1sk95lo1EaM+zgz5Yet+YxWvISq9yTgrOpbJu09WJNBK5b
         I+GnmbuaMAXesSzOgfCQbDJGqkqa5cFd6p2oa1uWnS9cGh0a6UqwTaccwmDUQE4a4hyx
         xUBw==
X-Gm-Message-State: APt69E1llaoQoC4HyRDphbxH8r4Sk4Wh7OJRu18C27GMQuNp/V1aMKRi
        xr5Vy4XU+kc+4sdqrl1DrJqmFA==
X-Google-Smtp-Source: ADUXVKLA7CqBDm8P4M23o8R8ho+kCaG76nKfnFmGt4IT5TeKgPjNZCT+Fn4ojY/bVCnwEAtQpnETMA==
X-Received: by 2002:a62:db05:: with SMTP id f5-v6mr1026059pfg.123.1528363166013;
        Thu, 07 Jun 2018 02:19:26 -0700 (PDT)
Received: from localhost ([122.172.167.207])
        by smtp.gmail.com with ESMTPSA id h124-v6sm3199478pfc.100.2018.06.07.02.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 02:19:25 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:49:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "Du, Changbin" <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gregkh@linuxfoundation.org, alex.elder@linaro.org,
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
Message-ID: <20180607091923.n5q5uzsxuymy3vov@vireshk-i7>
References: <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
 <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
 <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
 <20180607091816.GT13775@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607091816.GT13775@localhost>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-18, 11:18, Johan Hovold wrote:
> If you want to work around the warning and think you can do it in some
> non-contrived way, then go for it.
> 
> Clearing the request buffer, checking for termination using strnlen, and
> then using memcpy might not be too bad.
> 
> But after all, it is a false positive, so leaving things as they stand
> is fine too.

Leave it then :)

-- 
viresh
