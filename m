Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D552ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2E4208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2E4208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeGNIDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:03:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeGNIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:03:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC3F28A5;
        Sat, 14 Jul 2018 07:44:52 +0000 (UTC)
Date:   Sat, 14 Jul 2018 09:44:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 12/18] staging: gasket: annotate ioctl arg with __user
Message-ID: <20180714074450.GA22469@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-13-toddpoynor@gmail.com>
 <20180714063502.GF20451@kroah.com>
 <CAO3upobyf9JpKLSoSPeVfNGOh6R0cud=hT+bhA=U2kNkGEJ-aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3upobyf9JpKLSoSPeVfNGOh6R0cud=hT+bhA=U2kNkGEJ-aw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 12:12:38AM -0700, Todd Poynor wrote:

HTML email gets rejected by the mailing lists :(

Please fix your email client to not do that.

> On Fri, Jul 13, 2018 at 11:35 PM, Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
>     On Fri, Jul 13, 2018 at 10:58:10PM -0700, Todd Poynor wrote:
>     > From: Todd Poynor <toddpoynor@google.com>
>     >
>     > For sparse checking.
>     >
>     > Reported-by: Dmitry Torokhov <dtor@chromium.org>
>     > Signed-off-by: Zhongze Hu <frankhu@chromium.org>
>     > Signed-off-by: Todd Poynor <toddpoynor@google.com>
>     > ---
> 
>     Are you sure this patch even applies?  What tree did you make it
>     against?
> 
> 
> I'm working in linux-next at tag next-20180713, which is also tagged master at
> this writing. 
> 
> I think I'm following http://www.kroah.com/log/linux/linux-staging-update.html,
> but if I'm off in the weeds do clue me in, thanks. 

That's something I wrote 9 years ago :)

Anyway, yes, linux-next is usually the right place to work off of, but
it lags my staging.git tree usually by at least a day, maybe two,
depending on when I push and when -next picks my tree up.  Also there is
the lag of the weekend when -next is not being generated.

Normally that is fine, except for when working on code that is "fast
moving".  This driver has had lots of submissions against it lately as
there are loads of "low hanging fruit" that people easily see to fix up.
Look at the mailing list archives for this week alone for all of those
patches.

When working on something that lots of other people are working on, pay
attention to the patches on the mailing list and work off of my
staging.git tree, usually the staging-next branch, but sometimes
staging-testing is needed if lots of patches are being sent rapidly.

>     I ask because this fragment:
>    
>     > @@ -12,6 +12,7 @@
>     >   * GNU General Public License for more details.
>     >   */
> 
>     is no longer in the tree.
> 
> 
> Sorry, which tree?  I've made sure my linux-next is up-to-date and I still see
> this code.

Look at my staging-next branch in staging.git.  It's long-gone :)

thanks,

greg k-h
