Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB63CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B3F20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLkNBCDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B3F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbeKADeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:34:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37325 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbeKADeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:34:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id g9-v6so17603265wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/R2L5HQBXDw0/Xg4fnjvJK8AaWmqirCcYNNkoKNJKAg=;
        b=bLkNBCDRaKK4gdmyHB2oyDMSFmccY9LiIIyiXs/KFFz8qWYYWwN75L7DgnuvxEKoxH
         gONKR6T2lgmiciAVvMwO6bv7BIHWaM5TH+xQvV1cKiIhfRgzXlmOvKFlfjveJbcsrMXB
         eHFUW+jOvpOENRc7QlCIqKTRtRCF7FNMcBjFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/R2L5HQBXDw0/Xg4fnjvJK8AaWmqirCcYNNkoKNJKAg=;
        b=Okt4ezvnYNZmj3L7CScJAh+hlrrYLLS74XKIKe8U85KIZ8zj/ENwfvZ/eegOGr2zX2
         MtBxmcvpiPTtdw1CyBAcR7mfe9yL0OZ6LUNlyaItsEUd/i/SqYzEvN6Xd7VqPu4PcCkd
         aQj1d6IKeU7f6UW+P88tAhFjn5Xq+s5eGqtmV63754tplm2JEfBs5bAomKGZpBphP7Wa
         5ytNBUkWNobJFtglrjGVhMP6yfPll/yAzXgfES7wVbN+wCE0i9oxS6S3kG7lGK8eUQTO
         aJIKBRjvFp6fV4hNXNzbbKOZdm/ktCjUS/T6nxqNeRGZ2TOW082ItEVUyjWsSLbgLphx
         +pmw==
X-Gm-Message-State: AGRZ1gLgEAcHF6LKc5VXWZRdbEci6LvDipTG0M0wq7IrKeqcvtAtr0J2
        It5xD7vZNL68Y+spVn10dRTsmCXGFPYwl0zVTsiOrw==
X-Google-Smtp-Source: AJdET5dDOqCIsaUtnWCguW515rIR3eIV96QWY0/f13u9vgvPOeQbM3SamH2gm0rOMvasjx9OcehUY8yjk8LJQA6TEww=
X-Received: by 2002:adf:e28d:: with SMTP id v13-v6mr3704207wri.139.1541010903226;
 Wed, 31 Oct 2018 11:35:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 11:35:01
 -0700 (PDT)
In-Reply-To: <20181031182107.726051323@linutronix.de>
References: <20181031182107.726051323@linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 31 Oct 2018 11:35:01 -0700
Message-ID: <CALAqxLVXZEFHmNBrDC+csQYwft4zHA=kB8oXfA66m-p3kKUf6Q@mail.gmail.com>
Subject: Re: [patch 0/9] time: Add SPDX identifiers and cleanup boilerplates
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Peter Anvin <hpa@zytor.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        David Riley <davidriley@chromium.org>,
        Colin Cross <ccross@android.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:21 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Add SPDX identifiers to all files in kernel/time and remove the license
> boiler plates.
>
> Aside of that use the chance to get rid of (stale) file references and tidy
> up the top of file comments as they are touched anyway by this work.
>
> This work is based on a script and data from Philippe Ombredanne, Kate
> Stewart and myself. The data has been created with two independent license
> scanners and manual inspection.


Looks ok by me.

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
