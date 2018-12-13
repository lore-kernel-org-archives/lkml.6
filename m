Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047E620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ssi.gouv.fr header.i=@ssi.gouv.fr header.b="qJOY8rrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047E620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssi.gouv.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbeLMPR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:26 -0500
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:57048 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:24 -0500
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id 8B35CD0006B;
        Thu, 13 Dec 2018 16:17:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1544714250;
        bh=EuHsQ6GWc5Tr1uLB3uYwH7N2PEOAZlS73ksHrDAeF7I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=qJOY8rrX9R0loICN/+LuPkbU3OvJbhY8HFfhiTZH+chZISDjn8Ne4fDNMml/1xIAo
         OduGR46t4GbNgamspNNkw7Krv0IvKyLnKvfh9vWbt6OjLh8xM70KOPdkHw9YBGxMZw
         AlQcM8dHWFRuQ3ddBjVArp4U2RVHlACmANXKSAypn+7vyYIzOkjU64+TLeG20hxvU3
         2muBIE7loR2C0imVHGZlzwYpViafP+UVXUM1XF/jPIJvuFI/6bOe50BcrH9Ub8NNGY
         I17iR5MIVhRxerIAI4OiqLYjWJfwPR+NB2a9MwNJiq4NwRDDnwkWph0PRbUTiQTzHo
         SKSrgXXvHhRXg==
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
To:     Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC:     <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        <kernel-hardening@lists.openwall.com>, <linux-api@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181213030228.GM6830@bombadil.infradead.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <374ea88c-edc5-f1a6-3637-748635e1e7df@ssi.gouv.fr>
Date:   Thu, 13 Dec 2018 16:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20181213030228.GM6830@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/12/2018 04:02, Matthew Wilcox wrote:
> On Wed, Dec 12, 2018 at 09:17:07AM +0100, Mickaël Salaün wrote:
>> The goal of this patch series is to control script interpretation.  A
>> new O_MAYEXEC flag used by sys_open() is added to enable userland script
>> interpreter to delegate to the kernel (and thus the system security
>> policy) the permission to interpret scripts or other files containing
>> what can be seen as commands.
> 
> I don't have a problem with the concept, but we're running low on O_ bits.
> Does this have to be done before the process gets a file descriptor,
> or could we have a new syscall?  Since we're going to be changing the
> interpreters anyway, it doesn't seem like too much of an imposition to
> ask them to use:
> 
> 	int verify_for_exec(int fd)
> 
> instead of adding an O_MAYEXEC.
> 

Adding a new syscall for this simple use case seems excessive. I think
that the open/openat syscall familly are the right place to do an atomic
open and permission check, the same way the kernel does for other file
access. Moreover, it will be easier to patch upstream interpreters
without the burden of handling a (new) syscall that may not exist on the
running system, whereas unknown open flags are ignored.
