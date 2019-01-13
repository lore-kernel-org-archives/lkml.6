Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1078AC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB78921721
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 07:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547365473;
	bh=nYmVZABU9dkXmf6iSqQAB7PKg77TItmmy2vOKr+MQaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kZmwGWYePQx50o3o+ZrmEB13NM9fJre39cid6MhNva+HhTFjm4bLENVdI4klv7L6j
	 nCUWwZs5UQ8LsdJLD0FDILan4KoyWeRY1EWMJkGW1svpqj+tn0dUKBegDgT+LVGfG3
	 EcuAmw0Snb2zvixxIA+Z+/HSKj788DLVpozKTP54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfAMHod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 02:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfAMHoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 02:44:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9E320873;
        Sun, 13 Jan 2019 07:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547365471;
        bh=nYmVZABU9dkXmf6iSqQAB7PKg77TItmmy2vOKr+MQaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDiYw3aqG1TpqW5dxIXqVSQJbEpgEnJW+ajDsEiIgQIhNyniuQ3cWgs+DOUui0O6Q
         h04wMZg4qJYiI6Hsf/Sir6U4LgEXDtCuNRiI4QQ0RYm37GmGDkdXWUQuwR0oT/g1qH
         s2kLZal/eZmOvGSLoglSlHibqFM68NsVD8L5mIcA=
Date:   Sun, 13 Jan 2019 08:44:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/47] 3.18.132-stable review
Message-ID: <20190113074428.GA8937@kroah.com>
References: <20190111130956.170952125@linuxfoundation.org>
 <f762fe50-0a19-8649-acd0-e3c947e80c4e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f762fe50-0a19-8649-acd0-e3c947e80c4e@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 09:42:21AM -0800, Guenter Roeck wrote:
> On 1/11/19 6:07 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.132 release.
> > There are 47 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Jan 13 13:09:31 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 217 pass: 202 fail: 15
> Failed tests:
> 	sparc32:SPARCClassic:nosmp:scsi:hd
> 	sparc32:SPARCbook:nosmp:scsi:cd
> 	sparc32:LX:nosmp:noapc:scsi:hd
> 	sparc32:SS-4:nosmp:initrd
> 	sparc32:SS-5:nosmp:scsi:hd
> 	sparc32:SS-10:nosmp:scsi:cd
> 	sparc32:SS-20:nosmp:scsi:hd
> 	sparc32:SS-600MP:nosmp:scsi:hd
> 	sparc32:Voyager:nosmp:noapc:scsi:hd
> 	sparc32:SS-4:smp:scsi:hd
> 	sparc32:SS-5:smp:scsi:cd
> 	sparc32:SS-10:smp:scsi:hd
> 	sparc32:SS-20:smp:scsi:hd
> 	sparc32:SS-600MP:smp:scsi:hd
> 	sparc32:Voyager:smp:noapc:scsi:hd
> 
> The failed sparc32 tests are really nothing new, but were discovered due
> to more extensive testing. Observed behavior is a boot hang. sparc32 images
> in v3.18.y (and v3.16.y) have probably been non-functional since commit
> 16c193364b4d ("sparc: Harden signal return frame checks."). The problem
> was fixed upstream with commit 07b5ab3f71d3 ("sparc32: Fix inverted
> invalid_frame_pointer checks on sigreturns"), and applying the same
> commit to v3.18.y (and v3.16.y) fixes the problem.

I'll queue that patch up after this release, thanks.

And thanks for the results of all of the other kernel trees as well.

greg k-h
