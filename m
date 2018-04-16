Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+211jNeKJLGxQVEYJNAkUgvu9elzSCaBME+uHYPeXoSGA2FiEols3U8HADADB3oJMgf7CL
ARC-Seal: i=1; a=rsa-sha256; t=1523883018; cv=none;
        d=google.com; s=arc-20160816;
        b=IMKdFNDszCgxKZgxtiHnnEwbLd5ln2kEhQxCmEWk0wWHXVZEZB0ProRgWbmvFqDohK
         fTOW/cUrQueoKbt/yWZGKFOiL77feXoCMALKSfXp9kdRh/0Bui5jEPm4lcxITIP0E3E+
         x/PV1btSaO8nzEQ3tZslGFnZMktqfyfKjrOt5vmgb+NAru9j2wi4BsO8x8jxSh/eT/B4
         s0G2g808YPlQJako/JZKB+tKo3em/D14xdqv3+PsvDWZMArX/Tp23o9yX9niLJBgezH3
         pXhxZPLSs1tZDCPZUXsmkiO6hcfA0xKlDoWw2kwG7M0f+yUtsGKhuVsS5dp1R50ZIsXk
         nR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=zNpUKQnUGEix3hKiQlvoOeQPdq5wY0l8QK16GdF4G6E=;
        b=iX8RXa34RWgyyxLb1kLrvbGxvSDZZFsPc3iGR12hdwxjDAol9902/EetVZONHfP4/+
         DKr9S7cHO/+2ni9ECzzRD+Ag1pocPyjvNnqk8b4PSd5fXjOhc4x2b43MONXOreBsTvUz
         ckJkHoS5F/CM8/9mhk3FU3FEP6qi4AlgbQqGFQJFdUDh/WyX9fHwH01h+tw/WANGtHx0
         wraifemp1BPiW0DiNDPPVDcleo6pGOGHmL375C+NSIlVCtcbAJRtd5zAtAyUI0/Jqro4
         EtcK16rbvRsKLNc51ibBI+dt7J4sAw0qOCIimWjyM3zsQneBOP9bDEKPR7TmJWrIKRei
         RiCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeDPMtv (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 16 Apr 2018 08:49:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752040AbeDPMtt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Apr 2018 08:49:49 -0400
Date: Mon, 16 Apr 2018 14:49:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Libor =?utf-8?B?UGVjaMOhxI1law==?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
Message-ID: <20180416124947.4ehk7xbxoiqrklue@pathway.suse.cz>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1597907160305256718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 2018-04-12 10:54:31, Joe Lawrence wrote:
> Add a few livepatch modules and simple target modules that the included
> regression suite can run tests against.
> 
> 
> diff --git a/Documentation/livepatch/callbacks.txt b/Documentation/livepatch/callbacks.txt
> index c9776f48e458..6ca2801a6bb9 100644
> --- a/Documentation/livepatch/callbacks.txt
> +++ b/Documentation/livepatch/callbacks.txt
> @@ -116,490 +116,3 @@ virtnet_probe() initialized its driver's net_device features.  A

It might make sense to add a note about sample modules in
lib/livepatch/


> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 64155e310a9f..e4a0e81542ff 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1932,6 +1932,18 @@ config TEST_DEBUG_VIRTUAL
>  
>  	  If unsure, say N.
>  
> +config TEST_LIVEPATCH
> +	tristate "Test livepatching"
> +	default n
> +	depends on LIVEPATCH
> +	depends on m
> +	help
> +	  Test various kernel livepatching features for correctness.
> +	  The tests will load test modules that will be livepatched
> +	  in various scenarios.

It would be great to make a clue how to run the test. Something like:

	  To run tests call:

	  tools/testing/selftests/livepatch/test-callbacks.sh
	  tools/testing/selftests/livepatch/test-livepatch.sh
	  tools/selftests/livepatch/test-shadow-vars.sh

This is inspired by config TEST_KMOD description.


> +	  If unsure, say N.
> +
>  endif # RUNTIME_TESTING_MENU
>  
>  config MEMTEST
> diff --git a/lib/Makefile b/lib/Makefile
> index a90d4fcd748f..98a38441afb0 100644

Otherwise, it looks great to me. Thanks a lot for getting this
together.

Best Regards,
Petr
