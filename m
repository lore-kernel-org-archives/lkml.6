Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w9qDIQYAGVvdEwAAmS7hNA
	; Thu, 07 Jun 2018 09:54:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B9BB360452; Thu,  7 Jun 2018 09:54:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6A26A60909;
	Thu,  7 Jun 2018 09:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A26A60909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=petrovitsch.priv.at
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeFGJyF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:54:05 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1862 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeFGJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:54:03 -0400
X-Greylist: delayed 2797 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2018 05:54:02 EDT
Received: from thorin.petrovitsch.priv.at (80-110-71-232.cgn.dynamic.surfer.at [80.110.71.232])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id w5793Kxi007971
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 7 Jun 2018 11:03:21 +0200
Message-ID: <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Du, Changbin" <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org,
        alex.elder@linaro.org, Johan Hovold <johan@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com, lgirdwood@gmail.com,
        broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org,
        linux@armlinux.org.uk, linux-sparse@vger.kernel.org,
        mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org,
        changbin.du@gmail.com, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Thu, 07 Jun 2018 11:03:19 +0200
In-Reply-To: <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
         <201806060501.btF3aJMZ%fengguang.wu@intel.com>
         <20180606095714.1d3c2def@vmware.local.home>
         <20180606142600.GN13775@localhost>
         <20180606142622.2338abf6@vmware.local.home>
         <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
         <20180607074628.kd3iyxevwj3ypzbr@intel.com>
         <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC-URT-Metrics: esgaroth.tuxoid.at 1060; Body=25 Fuz1=25 Fuz2=25
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 14:08 +0530, Viresh Kumar wrote:
> On 07-06-18, 15:46, Du, Changbin wrote:
> > I think if the destination is not a null terminated string (If I understand your
> > description below), memcpy can be used to get rid of such warning. The warning
> > makes sense in general as explained in mannual. Thanks!
> 
> The destination should be a null terminated string eventually, but we first need
> to make sure src is a null terminated string.

Is there strnlen() or memchr() in the kernel?
Then check the source before copying it.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
