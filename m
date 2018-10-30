Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1D7C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AC920664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPsFXy1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AC920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJaIoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbeJaIoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:44:06 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F57E20664;
        Tue, 30 Oct 2018 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540943309;
        bh=tQvdvlGKC1GYeWAqrIHE3DZX2qLlzwJgnExnwbLwi1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPsFXy1lqVid3qsFTFXsq3CfwvXYUgnkeV/XvwIerRdr7UWSKKXW7FY7Yonr/RmoX
         EzMcYZAPGZ5OFC6yMlwNqxi9vo82rNxigIvWPVrMpLb0Lshm8jMF82+kE8AUIZUoSy
         7nn/GEujdPuNz8sms4QLC6xn317H2AqdH+kgWMY0=
Date:   Tue, 30 Oct 2018 19:48:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v2] staging: vboxvideo: Remove
 unnecessary parentheses
Message-ID: <20181030234826.GE194472@sasha-vm>
References: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com>
 <20181030092539.GA10009@kroah.com>
 <20181030231757.24ooubt25oykmgkt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181030231757.24ooubt25oykmgkt@smtp.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 08:17:57PM -0300, Shayenne Moura wrote:
>On 10/30, Greg Kroah-Hartman wrote:
>> On Tue, Oct 23, 2018 at 02:43:04PM -0300, Shayenne da Luz Moura wrote:
>> > Remove unneeded parentheses around the arguments of ||. This reduces
>> > clutter and code behave in the same way.
>> > Change suggested by checkpatch.pl.
>> >
>> > vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
>> > crtc->x'
>> >
>> > Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
>> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> > ---
>> > Changes in v2:
>> >   - Make the commit message more clearer.
>>
>> This patch does not apply to the latest kernel tree at all :(
>>
>> Please fix up and resend.
>>
>> thanks,
>>
>> greg k-h
>
>Hi Greg!
>
>Sorry, I do not know what branch are expected to be used.
>I used the drm-misc-next to create this patch and I could not
>find any merge problem.
>
>Could you please tell me the details?

Hi Shayenne,

There's an easy trick for this: the kernel tree has a script that can
help you find both the relevant maintainers, and their development tree
for each file in the kernel.

Simply run:

	./scripts/get_maintainer.pl --scm -f [filename]

For example, in this case, you'd run:

	$ ./scripts/get_maintainer.pl --scm -f drivers/staging/vboxvideo/vbox_main.c
	Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM,commit_signer:10/10=100%)
	Hans de Goede <hdegoede@redhat.com> (commit_signer:7/10=70%,authored:6/10=60%,added_lines:31/37=84%,removed_lines:153/159=96%)
	Fabio Rafael da Rosa <fdr@pid42.net> (commit_signer:1/10=10%,authored:1/10=10%)
	Alexander Kapshuk <alexander.kapshuk@gmail.com> (commit_signer:1/10=10%,authored:1/10=10%)
	Nicholas Mc Guire <der.herr@hofr.at> (commit_signer:1/10=10%)
	Thomas Zimmermann <tzimmermann@suse.de> (authored:1/10=10%,added_lines:2/37=5%)
	Daniel Junho <djunho@gmail.com> (authored:1/10=10%,added_lines:2/37=5%)
	devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
	linux-kernel@vger.kernel.org (open list)
	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git

The list of people and mailing lists are the ones that should be the
recipients of your patch, and the last line is the git tree on which the
patch should be based on.

--
Thanks,
Sasha
