Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86FEC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD722084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD722084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeJEGER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:04:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEGER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:04:17 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.40])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w94N8NZn2917259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 4 Oct 2018 16:08:25 -0700
Subject: Re: [PATCH 5/5] arch/xtensa, termios: use <asm-generic/termbits.h>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-serial@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        linux-xtensa@linux-xtensa.org, Jiri Slaby <jslaby@suse.com>
References: <20181004222953.2229-1-hpa@zytor.com>
 <20181004222953.2229-6-hpa@zytor.com>
 <CAMo8BfJRvmNu=oHb4MaB_M7mdR5dMZRgfHb-Me8En3OoUe5m8g@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e2439721-ff84-6943-2295-b7fb2d082ef9@zytor.com>
Date:   Thu, 4 Oct 2018 16:08:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJRvmNu=oHb4MaB_M7mdR5dMZRgfHb-Me8En3OoUe5m8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/18 15:35, Max Filippov wrote:
> 
> Looks good. But why not removing the header entirely and adding
> generic-y += termbits.h
> to arch/xtensa/include/uapi/asm/Kbuild?
> 

Good idea.  Should do that for others that also have the same #include.

	-hpa
