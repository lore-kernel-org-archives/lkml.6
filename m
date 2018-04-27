Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZqxWYIfE9SQxCRADgCmDqM10/jibap6Kxydz6mbyP/txv/QC7GP96io6NJvIH6vHkO/pCXo
ARC-Seal: i=1; a=rsa-sha256; t=1524814896; cv=none;
        d=google.com; s=arc-20160816;
        b=iPEaLzMLGcSPNjygm6JFW/rNYcNY8GNrMCXC/GJEsPyqBG7bq8xMilN8c//JEvNNPe
         JRji3p/SLoiVzWCT9fKOf6wB4ZkgDg2feRCh0M6bHeEi8V36pZvdHldPJE3uMCWwUSG3
         mP/fiQChfaHIrPR1jssOI2FqkSzBSN5Fg7MPzpbHHyG5djr0cS/oOrNXLqp87Qu25HB0
         ZLlKzsOPYszEfsa5FTPdbnZKZtyWrdX7KqB7dcCiQsGH5lwTGOOJeBhAxG+AYhAPhRX4
         V/A+NWGWo64WCFeWAZYHgIgGvpwX5NDpt4+EZdBk/mSuUwS6X54MgxSUs3GYm5Rn04k4
         CFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=HHXeaiIXJXA7r1mvQKucQGHM76KnkvR5mGfX4Yq4y+A=;
        b=S9kcjkTYmoAwhEKFCIoS6PM+hR1M7nr6f0D/CGhwn0QXFyvXrjgCJDj+kY6zG+SnFa
         GXLinaTlq5VoXF29S3//4Hir/lah9CXRzEKcTqKuq7dj/DfTuNR0+jS08C1OIvsbekBp
         a/o47P3HWC3vnMmobuDBrtaGefQmyOoEyPB0C3ekkMEa0OjyrvRGioSp8sgA1gfV1So2
         uI0WeKT0FpJ/7AtkTcSAZyI51zCbW21MDdLiyxlEaQMDyvaYdBlX/90OZuBK5QoJgTIR
         NmTG2dbEFxxcVqfQNFW/NixRZlwbBenekw9yod4J3q/zyrLNeW//JKIvIRRYUuu3/8Qv
         KECw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757499AbeD0Hlg (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 03:41:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757444AbeD0Hlf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 03:41:35 -0400
Date: Fri, 27 Apr 2018 09:41:30 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: Thomas Gleixner <tglx@linutronix.de>, shuah@kernel.org,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible BUG: selftest about raw_skew failed
Message-ID: <20180427074130.GN20050@localhost>
References: <CAG=yYwmQb-zuq3V9muu=xXsRGa3s1A=fFgz-XJchCiFd+GYUYQ@mail.gmail.com>
 <alpine.DEB.2.21.1804262327480.1596@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804262327480.1596@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598367547498408284?=
X-GMAIL-MSGID: =?utf-8?q?1598884305381030319?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 11:28:29PM +0200, Thomas Gleixner wrote:
> On Sat, 21 Apr 2018, Jeffrin Thalakkottoor wrote:
> > selftests: raw_skew
> > ========================================
> > WARNING: ADJ_OFFSET in progress, this will cause inaccurate results
> > Estimating clock drift: 17.910(est) 16.820(act) [FAILED]

Was ntpd, systemd-timesyncd, or some other NTP/PTP daemon running
shortly before or during the test?

The warning indicates that the clock was slewed by adjtime() or
adjtimex(), which makes the measurement of the frequency less accurate
and the test may fail.

Maybe this test and other tests that measure the frequency of the
system clock should be modified to SKIP when adjtimex() returns a
non-zero offset (or the frequency changes during the test)? 

-- 
Miroslav Lichvar
