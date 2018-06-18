Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F8A208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="FgPjp8OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F8A208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934976AbeFRMGY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:06:24 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:58854 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933523AbeFRMGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:06:21 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 418V2c6Rmwz8tRC;
        Mon, 18 Jun 2018 13:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1529323048; bh=MxjZcdeRY7G5x3V5BtTCnBoM9udfpkuhM0wrH1Q4qzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From:To:CC:
         Subject;
        b=FgPjp8OAJDBuP2fYOxDg5BUGcyKf8p5kmRt1QycbwJX7kMwMIWlehhteGgGTOV5Yl
         r0NZlW2rku8O3lk9peda2SfO62FEZmGyvlH0bPyPdHD94sVUr2cDsNWvTpEPcbc6V7
         09xtuFCPHbuGp5QC5k69+KF9ng2G6/zGAWmQTOVZEeqeNe1HZCuwp3WANdDmg7Jgg/
         GqTmVgN5OGTKXJ0yT9Pa+0He1dRQk6FTNCiL9GU+M9sPuq+0Ok05Osiuokr0nuOAGA
         mz+EFHhq4l4Oa2njlxJZl4IerkJazstPZLtWe1QTEPb+in+nLIo9tB8Hu/MNGa+CED
         oKPIM4o7MpKGQ==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.11.37
Received: from faumail.fau.de (smtp-auth.fau.de [131.188.11.37])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18kroqRz9YKsjYofxwTYxBqpLN41XPtGKk=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 418V2Z5tWlz8tHN;
        Mon, 18 Jun 2018 13:57:26 +0200 (CEST)
Received: from
 a2Y6Te8RWnpr5V3V47pc6V1emFjD8jwbj6m7TKOYrtIt5NbZ9MXcNM8mpm75XPVz
 by faumail.uni-erlangen.de
 with HTTP (HTTP/1.1 POST); Mon, 18 Jun 2018 13:57:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 18 Jun 2018 13:57:26 +0200
From:   "Sommer, Roman" <roman.sommer@fau.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>,
        Daniel Graefe <daniel.graefe@fau.de>,
        Bhumika Goyal <bhumirks@gmail.com>,
        =?UTF-8?Q?Fabi=C3=A1n_Inostroza?= <soulsonceonfire@gmail.com>,
        linux-kernel@i4.cs.fau.de, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        =?UTF-8?Q?Hans_P=2E_M=C3=B6ller_Ebner?= <hmoller@uc.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sound/usb/line6: fix some styling issues
In-Reply-To: <s5h8t7cz8cm.wl-tiwai@suse.de>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
 <s5h8t7cz8cm.wl-tiwai@suse.de>
Message-ID: <dfb7ed2f90fb8fbc2164385f7403c8a4@fau.de>
X-Sender: roman.sommer@fau.de
User-Agent: Roundcube Webmail/1.2.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-18 12:39, Takashi Iwai wrote:
> On Mon, 18 Jun 2018 12:29:36 +0200,
> Roman Sommer wrote:
>> 
>> CC: Jaroslav Kysela <perex@perex.cz>
>> CC: Takashi Iwai <tiwai@suse.com>
>> CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Kate Stewart <kstewart@linuxfoundation.org>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
>> CC: Bhumika Goyal <bhumirks@gmail.com>
>> CC: Philippe Ombredanne <pombredanne@nexb.com>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CC: alsa-devel@alsa-project.org
>> CC: linux-kernel@vger.kernel.org
>> 
>> 
>> This patchseries addresses some styling issues in sound/usb/line6 
>> found by
>> checkpatch.
> 
> Are you working further on this driver to fix any real bugs (or
> implements something new), or it's an action "just because checkpatch
> tells"?  I'd take such cleanup patches only for the former case.
> 

Hi Takashi,

I do intend to work on a few issues as I have some Line6 USB devices 
that
don't work as expected (or at all).
But for now this is just a cleanup patch and I don't want to promise
anything at this point.
Still my interest to use those devices is a strong
motivator.

I'd be glad if you would consider accepting the patch anyway.


Cheers,
Roman
