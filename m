Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A57C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6F420672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TieKyCFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6F420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeJ2CS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeJ2CS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:18:57 -0400
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A75D020672;
        Sun, 28 Oct 2018 17:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540748020;
        bh=uWN6Gyqq3mDErRCL8UdqxMm9hLXg10TdRLITzXJmefo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TieKyCFvq/S9C0w4wBVXbX7RcB+g2PrHNLB9oso+AsMhC/efFOZvWVS9oqK7xEQQa
         7MJcXIHjXC0/AqiocjNs8EH5VpbgQSHLDKWts4gaXCve0JZVjt+qSSsEuHinkiAl+w
         57gHdyA/tPh91d+pV/cqJl4dEt5o20lrtzDGbtqk=
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event parser
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
 <20181028040135.717a7b5d@vmware.local.home>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <2ea8d301-c140-f256-e8d0-20b107fcb1be@kernel.org>
Date:   Sun, 28 Oct 2018 11:33:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181028040135.717a7b5d@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2018 02:01 AM, Steven Rostedt wrote:
> On Mon, 22 Oct 2018 00:07:50 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Hi,
>>
>> I found another bug in synthetic event. This is a small fix, but
>> confusingly, there is also a bug in a test case.
>>
>> Steve, since the testcase bugfix ([2/2]) breaks the test result
>> unless corresponding fix ([1/2]), I would like to ask you to send
>> these fixes from your tree.
> 
> Hi Masami,
> 
> I'm currently in travel mode, but I'm letting you know that I'll be
> working on these today. It might take a bit to get out.
> 
> I'll add them on top of my linux-next code, and include them in the
> pull request I'm hoping to do on Tuesday.
> 
> -- Steve
> 

Hi Steve,

Are there any dependencies on my pull request I sent to Linus? It hasn't
been pulled in yet. If there is one, could please you mention that in your
pull request for this.

thanks,
-- Shuah
