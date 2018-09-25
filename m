Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FCAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954D420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954D420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeIYPsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:48:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeIYPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:48:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1091115A;
        Tue, 25 Sep 2018 09:41:49 +0000 (UTC)
Date:   Tue, 25 Sep 2018 11:41:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Keys: fix C++ reserved word issue
Message-ID: <20180925094147.GC21972@kroah.com>
References: <alpine.LRH.2.21.1809250738020.27047@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1809250738020.27047@namei.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:40:06AM +1000, James Morris wrote:
> Please pull this revert and update, from David Howells:
> 
> "Here's a pair of fixes that need to go upstream asap, please:
> 
>  (1) Revert an incorrect fix to the keyrings UAPI for a C++ reserved word
>      used as a struct member name.  This change being reverted breaks
>      existing userspace code and is thus incorrect.
> 
>      Further, *neither* name is consistent with the one in the keyutils
>      package public header.
> 
>  (2) Fix the problem by using a union to make the name from keyutils
>      available in parallel and make the 'private' name unavailable in C++
>      with cpp-conditionals."
> 
> ---
> The following changes since commit 02214bfc89c71bcc5167f653994cfa5c57f10ff1:
> 
>   Merge tag 'media/v4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-09-24 15:16:41 +0200)

{sigh}

$ date --date="2018-09-25 07:40:06 +1000" +%s
1537825206
$ date --date="2018-09-24 15:16:41 +0200" +%s
1537795001
$ bc <<< "1537825206-1537795001"
30205
$ date -ud "@30205" +'%H hours %M minutes %S seconds'
08 hours 23 minutes 25 seconds

8.5 hours seems like a short amount of time for something to sit in a
tree before asking for it to be merged.  Wait, it's actually less than
that, I just took into account the longest possible time it could have
been in your tree.

I'll wait a few days on this one...

thanks,

greg k-h
