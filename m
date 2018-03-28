Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49eXBXP0o2PjcyYPZZ6IODUHCIF0l3ASCrOEDa+D67Dh7dVawlrqDRlMQyU1qypTR+FHdg/
ARC-Seal: i=1; a=rsa-sha256; t=1522202091; cv=none;
        d=google.com; s=arc-20160816;
        b=qbH2bJH0tuxFzI651Ih3VJTgme8kO0GrymywaGyK7iU9QN+AnExZ3fBKUKnbX3sc2H
         xByCqu8MCRAu98aeiUhf4XEpAsGkz0dSTEJgiyOFmNHbwRYM+Depffgosuo6cQTCnJO/
         MBfQANgqqcdDVVCLkVIBQmdV5k/lHU44xgPELpCMCrqgOSRt+OQ4qfYuefHLgU4jDdgw
         yt8hVcORYYIAdAAqOqE6R/8kj53bnyoWQU65WUN/2pb2NZ79DxesKHVHA5bFC+4NUGS7
         4G+CZ1td9bvzyqy4FeMz5tXReZC9qRRQYRMmyvvLgdC64ffWYPPI7t0sCdty/6ah6H2J
         GJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=WQ8Oo/CVWts2yWaDhYYTL4b7QzxCFikhFpDPRv6xLI0=;
        b=LdIPCDhTRElts+JM0DoTUCjbLyzVx12Le2wKYSkmpNd/+8SB6AxYnNyVdR/YNZ1jcx
         kXZNYLGePy4nEAA1avPg3YUTTMxOPeIN7bnzX4tDWkmXHWxwTIU4Z17VTbmHZ/LEXub/
         qBq8kwSF47m8F1ZkHg9AYPJqaZLm58SHM0lk9BeXD609v570nzCxTueEHoRBtbgQ7vku
         K5qTjis8QSAjaXfAYk0RIaWwSYAOmila9G77vifpS/r/LVAd75l5qFI9ra+RdSyOr6/H
         kb82L56kqQG9rasLinrmBcDC0iuIbtg9/7005091No0xWL/gX5bD18m9x5gXtkcNOiD3
         LHwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeC1Byv (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Mar 2018 21:54:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:55246 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752311AbeC1Byu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Mar 2018 21:54:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,369,1517904000";
   d="scan'208";a="42756744"
Date: Wed, 28 Mar 2018 09:45:25 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Shuah Khan <shuah@kernel.org>
Cc: changbin.du@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v2 1/4] selftests/Makefile: append a slash to env
 variable OUTPUT
Message-ID: <20180328014525.bl3iih4xvo74wedb@intel.com>
References: <1522120294-24926-1-git-send-email-changbin.du@intel.com>
 <1522120294-24926-2-git-send-email-changbin.du@intel.com>
 <b473e652-0953-63ec-c4bf-5c9306dc4f67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b473e652-0953-63ec-c4bf-5c9306dc4f67@kernel.org>
User-Agent: NeoMutt/20180323-6-5ca392
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596059510890150071?=
X-GMAIL-MSGID: =?utf-8?q?1596144580430792552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 03:19:26PM -0600, Shuah Khan wrote:
> On 03/26/2018 09:11 PM, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > The tools/build/Makefile.build use 'OUTPUT' variable as below example:
> > objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
> > 
> > So it requires the 'OUTPUT' already has a slash at the end.
> > 
> > This patch can kill below odd paths:
> > make[3]: Entering directory '/home/changbin/work/linux/tools/gpio'
> >   CC       /home/changbin/work/linux/tools/testing/selftests/gpiolsgpio.o
> >   CC       /home/changbin/work/linux/tools/testing/selftests/gpiogpio-utils.o
> >   LD       /home/changbin/work/linux/tools/testing/selftests/gpiolsgpio-in.o
> > 
> > A correct path should be:
> > /home/changbin/work/linux/tools/testing/selftests/gpio/lsgpio.o
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> 
> Are you seeing this when you run "make kselftest" - if gpio is the
> only test compile that fails, it should be fixed in gpio/Makefile,
> not is the common Makefile.
>
I only saw error in gpio, but I also saw some kselftest Makefiles having string concatenation
as '$(OUTPUT)$(dir)'. So the rule is not aligned all over. They just didn't produce any errors
so far.

By the way, is there a basic test for kselftest infrastructure? It seems it was always
reporting error when building it :(

> thanks,
> -- Shuah

-- 
Thanks,
Changbin Du
