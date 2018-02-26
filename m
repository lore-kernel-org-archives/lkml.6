Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeBZKOx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:14:53 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:56566 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751548AbeBZKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:14:50 -0500
Subject: Re: DM Regression in 4.16-rc1 - read() returns data when it shouldn't
To: Mike Snitzer <snitzer@redhat.com>
Cc: Milan Broz <gmazyland@gmail.com>, NeilBrown <neilb@suse.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <5fca4e3f-536c-9c52-31bb-927e8ab5b6c8@leemhuis.info>
 <20180219171531.GA27498@redhat.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <3fa615bf-8239-f189-8557-cb2d072181c0@leemhuis.info>
Date: Mon, 26 Feb 2018 11:14:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219171531.GA27498@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1519640090;c2f3a2cb;
X-HE-SMSGID: 1eqFnz-0005io-CP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike! On 19.02.2018 18:15, Mike Snitzer wrote:
> On Mon, Feb 19 2018 at  8:44am -0500,
> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> 
>> JFYI: This issues is tracked in the regression reports for Linux 4.16
>> (http://bit.ly/lnxregrep416 ) with this id:
>> Linux-Regression-ID: lr#9e195f
>> Please include this line in the comment section of patches that are
> […]
> The fix was already merged by Linus on Friday, see:
> git.kernel.org/linus/8dd601fa8317243be887458c49f6c29c2f3d719f

Ohh, thx for the pointer. Could you please next time add a tag like

Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first
tree walk")

to the commit? For details see
Documnetation/process/submitting-patches.rst section 2 and 13:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

That would have saved both of us this conversation. In addition I head
that at least one big Linux distributor is using those tags when
backporting changes to make sure all relevant fixes for a particular
backported commit get backported as well.

> But moving forward I have no interest in sprinkling external metadata
> references in Linux commit headers. 
> 
> Seems more like you're engineering something that gives you, and
> possibly a select few others, meaning but that is make work for all
> Linux maintainers.

I just asked you to help me make regression tracking work a little bit
easier. I'm neither planing to enforce this nor in a position to do so,
thus feel free to not do what I asked for; that's totally fine for me.
Especially as those tags are only a interim solution afaics (one that I
don't like to much myself; but they sometimes help connecting the
various dots in the phase where the commit that introduced a regression
is not yet known).

Ciao, Thorsten
