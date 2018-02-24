Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227iFFwjYhWegCijrmLA4NxOX75yJdK7GdpfwhfVr+E158IC5OWNH8CTsrKP/AfyNHvQuf4j
ARC-Seal: i=1; a=rsa-sha256; t=1519508574; cv=none;
        d=google.com; s=arc-20160816;
        b=fYdZyWDpeWVEbhUJ642jU21uTc/nqpMKdJ8ZyZTE+WG2vb9IpNsmyL8zS7hvXYuByG
         AaaqCL2ApauH/gzP5XSPqDlbIan9Guv/pWWK/NuX4VnHFdGd1l8pYbL6+w2YnZHBmgPt
         aRKB9alT6s2kCm6oEAF9XDT2uuSKgjx8HGZscyql/200x6vKvmYloFX8Jltfqj0X9wx/
         kloDbNFzSIbSd3a8A3uY88eamCTHGsemLxaxj+BAIbC8M036J8itVbyCJatHWewby40i
         /mYoEDBw7zzpP1/7GPQS4JS4HL4f+z0CG+AQSJ2MKESZpVrUcDMQjvYGcfy86euv0DH9
         5kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=a8jp2c2mWHJYrDfPJzcmk8s4fI0CzKkTGAmbHSI26N4=;
        b=H2biQAIgwqRyTUpzE+zfafMonxrkv5PtgPBeFKZfaMJg+UCKA6TH24KS/UJ3IvaUpB
         YedE7zJfE+y1dRoYNZyO4Z8g3vCWGQVm5iIqtoSH8m6jAeVeA5CbHa0CC2pE8q1F5qIO
         /mNVif45mxvDovtaSoJ2oJuUENbx6kZ9u4qG9b1TkL96cKgYnBhTioeH35WQ4tGyv26W
         c9vx6UKs4gRAr/jEFMEIqng4apGfUEWEiiChiihaebQ02pm8TqJt3BRiMx69cElxRewY
         2AsEXo9UuIJXWKADcn9+cyznTb+8qs6h5NZFwbbxlpZDdMISOiKcuO48zLCZUMeK58LJ
         kMYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=oW2+Xicz;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=oW2+Xicz;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBXVmx (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 16:42:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbeBXVmx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 16:42:53 -0500
Date: Sat, 24 Feb 2018 13:42:44 -0800
From: Darren Hart <dvhart@infradead.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: shuah@kernel.org, tbird20d@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests: futex Makefile add top level TAP header
 echo to RUN_TESTS
Message-ID: <20180224214244.GA31352@fury>
References: <cover.1519423340.git.shuahkh@osg.samsung.com>
 <bec2e6c01cbf3b2f6dc49e022a2a7543fc7f3182.1519423341.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec2e6c01cbf3b2f6dc49e022a2a7543fc7f3182.1519423341.git.shuahkh@osg.samsung.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231540843660776?=
X-GMAIL-MSGID: =?utf-8?q?1593320223326019795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 03:11:40PM -0700, Shuah Khan wrote:
> Add top level TAP header echo, testname and separator line to make
> the output consistent with the common run_tests target.

No objection to the changes, but I'll echo Ingo's request for a more
detailed justification for why these changes are warranted. We've seen
this a few times with recent changes to kselftests, I think too much
might be being assumed regarding the individual test author's tracking
of the core of the kselftests ongoing work.

> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  tools/testing/selftests/futex/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
> index cea4adcd42b8..3e9a9d7b4de1 100644
> --- a/tools/testing/selftests/futex/Makefile
> +++ b/tools/testing/selftests/futex/Makefile
> @@ -18,6 +18,9 @@ all:
>  	done
>  
>  override define RUN_TESTS
> +	@echo "TAP version 13";
> +	@echo "selftests: futex";
> +	@echo "========================================";
>  	@cd $(OUTPUT); ./run.sh
>  endef
>  
> -- 
> 2.14.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
