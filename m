Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D2DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137E12087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAPN5dSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137E12087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeLCQ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeLCQ4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:56:22 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5DE720834;
        Mon,  3 Dec 2018 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543856179;
        bh=YGliquOUTG2uj3g3cmaeEk5nuBYZGoG5SpaBAf0Vv2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAPN5dSvsBhxzBsH74bILnpwyZAPPWqAqS33qZJLNVqfykjFW+31NscB3UjIWKG1+
         wNpkH5mlR/wz7vLhd2A7q5iuH5doWYFrnBH48aIIiQ3tXHWBbH9jjeqsBLuxOpsPqZ
         ssPSozH+1v3n+ehIdpe37k7KqYYWn5his9jqpCWg=
Date:   Mon, 3 Dec 2018 11:56:15 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>, amir73il@gmail.com,
        Dave Chinner <david@fromorbit.com>,
        stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, dchinner@redhat.com,
        darrick.wong@oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, mcgrof@kernel.org,
        linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com
Subject: Re: XFS patches for stable
Message-ID: <20181203165615.GL235790@sasha-vm>
References: <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm>
 <CAOQ4uxhCH3oxVWDMVRcXMZO3JSTCA1Pp5AYnHP5pDxyNktqONw@mail.gmail.com>
 <20181202152547.GI221015@sasha-vm>
 <20181202161016.GA27696@infradead.org>
 <20181202200819.GA3932@kroah.com>
 <CAFLxGvyx-n4fUbsv+PrAebAPRe=yGV1zLRA44XnOwtMaubS8cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFLxGvyx-n4fUbsv+PrAebAPRe=yGV1zLRA44XnOwtMaubS8cg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:41:27PM +0100, Richard Weinberger wrote:
>On Sun, Dec 2, 2018 at 9:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Sun, Dec 02, 2018 at 08:10:16AM -0800, Christoph Hellwig wrote:
>> > As someone who has done xfs stable backports for a while I really don't
>> > think the autoselection is helpful at all.
>>
>> autoselection for xfs patches has been turned off for a while, what
>> triggered this email thread was a core vfs patch that was backported
>> that was not obvious it was created by the xfs developers due to a
>> problem they had found.
>
>Sorry for hijacking this thread.
>Can you please also disable autoselection for MTD, UBI and UBIFS?
>
>fs/ubifs/
>drivers/mtd/
>include/linux/mtd/
>include/uapi/mtd/

Sure, done!

--
Thanks,
Sasha
