Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B7ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B002083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B002083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=youngman.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJZG1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:27:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:38782 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeJZG1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:27:16 -0400
X-Greylist: delayed 2236 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 02:27:16 EDT
Received: from [81.157.153.73] (helo=[192.168.1.82])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1gFmyi-0005Bd-Ac; Thu, 25 Oct 2018 22:15:40 +0100
Subject: Re: [RFC] dm-bow working prototype
To:     Paul Lawrence <paullawrence@google.com>
References: <20181023212358.60292-1-paullawrence@google.com>
 <CAE8gLhmtrfprc93-XfomNEK5ZgxA_RFA0DnFrEnHjB0q31wkyg@mail.gmail.com>
 <d00e361b-b849-3139-7e7a-02f05f3794c3@google.com>
Cc:     dm-devel@redhat.com, Linux kernel <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5BD2327B.1040908@youngman.org.uk>
Date:   Thu, 25 Oct 2018 22:15:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <d00e361b-b849-3139-7e7a-02f05f3794c3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/18 19:13, Paul Lawrence wrote:
>> I have some questions about dm-bow:
>> – How file system agnostic this feature is planned to be? While it is
>> designed with ext4 in mind, is it going to work when used over other
>> file systems, like FAT or BTRFS for example?

> So long as the file system supports fstrim, it should work. If the file
> system creates a lot of churn say by running garbage collection, I'd not
> recommend it. And I really don't see the use case if the file system has
> any sort of snapshot capability - that will always be a superior
> solution to a block level one IMO.

Sorry for being dense, but why is this posted to linux-raid, then? Raid
does not support fstrim, and is filesystem-agnostic.

I can imagine people here being interested, but it feels to me as though
your functionality is completely orthogonal to raid. Sorry.

Cheers,
Wol
