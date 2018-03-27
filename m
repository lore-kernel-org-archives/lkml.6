Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48/cek29Nm6G+t9SX9h+zGBZgnGGy8zYJxjewjdRW29nVio4BT1hSvWKo5Vllv5bPuw9+GL
ARC-Seal: i=1; a=rsa-sha256; t=1522185598; cv=none;
        d=google.com; s=arc-20160816;
        b=KPK9X/NVFoXGyCKus/fWg3eWtwUu5BKEgsTmonildRImXqONhMmt6mF+Ea227E1ImL
         g9b+VIRmSXLx1bWPLNCexhyN7Qw9yT0ZwaV6FAXMwryg1zapjfvABoI8TjqaupVMhVB8
         J7LeCyNJR0Lo2G/J3GQp8+KfG8UW720/kHXYUmRK847z9qrmfFOwEme3ojiVs3PhsH5P
         af0YEWZk4QJLRsALR1PzqPnIK7gJiwjGxyn/0zt/GOWlfsyCnswBuHGNzJNMwkMMfM/I
         OliqM4E9rJLp7YLBMM6CyPViT7cS8raHRqKwlfqnhInIH8Y7EXmZpGROg+rrqAtw1HHg
         cRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=A/1Y66dywFKVhFUDeW6HkpHqq01ayHOWuuwGBMJdBwM=;
        b=x/kmoSXRALM//dzxEMBEbzdpHQHy53O3WQ5s9MzXJH6eBy84Td4NjfnhH2dIUVhb/V
         P758gwavpDwaRb9RtORC5qkXzhXL/V0L0qP4DKswmgmzkQ34LSAsdSSmASq6fXm5RVzf
         NsP1/ijNrBAOA6R/o9nIGvGp3NpSPCzwcYQcVL4OYRgc6eMpN04HHrTHsWut25YyWLpW
         XYN/XA2eUu2cWoDnue123pnAHZT/zBWFRbg28/kIa4ZAI54cEDYB4NJqM/Dpwsa4+Kgg
         qYGo5IOktMM9g4eMgsqqjYTqvEpUvJMSzApXA6arJ1jCM2U9+hvvlxoOi3g6OIkZozlU
         1o8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeC0VTq (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Mar 2018 17:19:46 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37533 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC0VTp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Mar 2018 17:19:45 -0400
Subject: Re: [PATCH v2 1/4] selftests/Makefile: append a slash to env variable
 OUTPUT
To: changbin.du@intel.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <1522120294-24926-1-git-send-email-changbin.du@intel.com>
 <1522120294-24926-2-git-send-email-changbin.du@intel.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <b473e652-0953-63ec-c4bf-5c9306dc4f67@kernel.org>
Date: Tue, 27 Mar 2018 15:19:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522120294-24926-2-git-send-email-changbin.du@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596059510890150071?=
X-GMAIL-MSGID: =?utf-8?q?1596127286575845007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/26/2018 09:11 PM, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> The tools/build/Makefile.build use 'OUTPUT' variable as below example:
> objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
> 
> So it requires the 'OUTPUT' already has a slash at the end.
> 
> This patch can kill below odd paths:
> make[3]: Entering directory '/home/changbin/work/linux/tools/gpio'
>   CC       /home/changbin/work/linux/tools/testing/selftests/gpiolsgpio.o
>   CC       /home/changbin/work/linux/tools/testing/selftests/gpiogpio-utils.o
>   LD       /home/changbin/work/linux/tools/testing/selftests/gpiolsgpio-in.o
> 
> A correct path should be:
> /home/changbin/work/linux/tools/testing/selftests/gpio/lsgpio.o
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>

Are you seeing this when you run "make kselftest" - if gpio is the
only test compile that fails, it should be fixed in gpio/Makefile,
not is the common Makefile.

thanks,
-- Shuah
