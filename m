Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeCMIie convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:38:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42367 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeCMIic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:38:32 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Atheros 1525/QCA6174 BT issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <s5hd108fkaa.wl-tiwai@suse.de>
Date: Tue, 13 Mar 2018 09:38:30 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Ivan Levshin <ivan.levshin@microfocus.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D8E4DA1B-060E-45F4-9B26-E3FAEE652D03@holtmann.org>
References: <s5hd10fkm49.wl-tiwai@suse.de>
 <184DA6FB-F23C-4C37-B89B-FE865DC9731C@holtmann.org>
 <s5h1sgvkjup.wl-tiwai@suse.de> <s5hfu54fljg.wl-tiwai@suse.de>
 <2D7B44D5-BF8C-42EE-A315-64DE11D25C79@holtmann.org>
 <s5hd108fkaa.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

>>>>>> we've got a but report about the broken Atheros BT on the recent
>>>>>> kernels:
>>>>>> http://bugzilla.opensuse.org/show_bug.cgi?id=1082504
>>>>>> 
>>>>>> In short, btusb can't load the patch ar3k/AthrBT_0x00000200.dfu, and
>>>>>> this could be worked around by the patch to move 0cf3:3004 blacklist
>>>>>> entry to use BTUSB_QCA_ROM instead of BTUSB_ATH3012.
>>>>>> 
>>>>>> And this looks like a long-standing problem, at least for over two
>>>>>> years.  Many web pages suggest the same patch, but it's never merged
>>>>>> to upstream.
>>>>>> 
>>>>>> So this made me wonder what's going on.  I see that the BTUSB_ATH3012
>>>>>> quirk was originally introduced just for this chip id (0cf3:3004).
>>>>>> Is it a different variant from the original chip that causes a
>>>>>> problem?
>>>>> 
>>>>> not all patches from distro kernel are sent upstream. I have not heard of this specific issues, but happy to accept patches to get it fixed.
>>>> 
>>>> OK, basically it's like below.
>>>> But, as mentioned, this made me wonder whether it's the right fix.
>>>> The BTUSB_ATH3012 quirk was introduced exactly for this chip ID
>>>> (0cf3:3004), and now this chip is moved to another quirk...
>>>> 
>>>> If this is the right move, I can re-submit via git-send-email, too.
>>>> Just let me know.
>>> 
>>> Marcel, could you take a look at this?
>>> If it sucks, let's seek for a better solution.
>> 
>> wasn’t the confusion that this is fixed with a recent kernel? I am lost in this thread. I mean if people add Tested-by, then I can take this as well. Otherwise we might need someone from Qualcomm to shed some light into these.
> 
> Well, *this* thread is likely different from the recent other
> threads.
> 
> Isn't 4.15.7 recent enough?  At least, it already contains the
> backport of relevant fixes:
>    Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
>    Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a
>      "rewritten" version
> 
> (And it's not Yoga but MSI GS40 laptop, so DMI doesn't matter.)
> According to Ivan, the reporter of the bug (now Cc'ed), 4.15.7 didn't
> work without the patch, so the problem is still there, as it seems.
> 
> In anyway, I'm going to build a kernel with my patch on top of 4.15.9
> for testing again.  Maybe also a patched 4.16-rc5 kernel, too.  If
> it's confirmed, will report back with tested-by tag.

I think there are two patches that are not yet in Linus’ tree and waiting in Dave’s net tree. We actually removed the Yoga DMI entry again since it was found that it is not needed. However there is a Dell OptiPlex entry that was needed.

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=0c6e526646c04ce31d4aaa280ed2237dd1cd774c

Regards

Marcel
