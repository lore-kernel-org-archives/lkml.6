Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD8620818
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfBQTOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:14:00 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:47430 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBQTOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:14:00 -0500
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id x1HJD3U6014430;
        Sun, 17 Feb 2019 19:13:03 GMT
From:   Nix <nix@esperi.org.uk>
To:     Greg KH <greg@kroah.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 4.20.7: pl2303 not working (post-4.19 regression) (limited info so far, not yet bisected)
References: <87o97bu2bt.fsf@esperi.org.uk> <20190216194758.GA10756@kroah.com>
Emacs:  a real time environment for simulating molasses-based life forms.
Date:   Sun, 17 Feb 2019 19:13:52 +0000
In-Reply-To: <20190216194758.GA10756@kroah.com> (Greg KH's message of "Sat, 16
        Feb 2019 20:47:58 +0100")
Message-ID: <877edytehb.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC-wuwien-Metrics: loom 1290; Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Feb 2019, Greg KH told this:

> On Sat, Feb 16, 2019 at 04:26:30PM +0000, Nix wrote:
>> So I just tried to connect up to my ancient Soekris firewall's serial
>> console to try to bisect a problem where it stopped booting in 4.20, and
>> found I couldn't.
>> 
>> minicom says:
>> 
>> minicom: cannot open /dev/ttyUSB0: Input/output error
>> 
>> and in the dmesg we see
>> 
>> [705576.028170] pl2303 ttyUSB0: failed to submit interrupt urb: -28
>>
>> Booting to 4.19, everything works fine. (A random GalliumOS Chromebook
[...]
>
> bisection would be great, thanks!

Rrrg. This is going to be harder than I thought. Rebooting, everything
works fine! So this is something that kicks in after something less than
eight days uptime, consistently on every box I own, but is fine on
reboot.

I'm still fairly sure this is a regression -- my machines are often up
for a lot longer than that and I've never seen this before I upgraded to
4.20.x -- but I don't think I'm going to identify it by mindless
bisection. I might have to actually *think* about it.
