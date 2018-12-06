Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D056C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6ED20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6ED20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bananateam.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLFQvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:51:02 -0500
Received: from mail.bananateam.nl ([213.125.76.250]:43428 "EHLO
        mail.bananateam.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeLFQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:51:01 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 11:51:00 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.bananateam.nl (Postfix) with ESMTP id C95D2334E625
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 17:42:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at bananateam.nl
Received: from mail.bananateam.nl ([127.0.0.1])
        by localhost (mail.bananateam.nl [127.0.0.1]) (amavisd-new, port 59111)
        with ESMTP id JezrnmimSfXR for <linux-kernel@vger.kernel.org>;
        Thu,  6 Dec 2018 17:42:37 +0100 (CET)
Received: from bcld-builder3.citrus.local (unknown [171.33.224.226])
        by mail.bananateam.nl (Postfix) with ESMTPSA id 65A48334E611
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 17:42:37 +0100 (CET)
To:     linux-kernel@vger.kernel.org
From:   Ferry van Steen <ferry@bananateam.nl>
Subject: No screen on Mac 18,1 / A1418 since kernel 4.17.x
Message-ID: <479de488-dc78-c58f-d31c-140aa7fc1c72@bananateam.nl>
Date:   Thu, 6 Dec 2018 17:42:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have received a Mac 18,1 (A1418), from a customer, on which we are 
unable to get any screen since seemingly 4.17.x (tested with 4.17.16).

4.16.16 works fine. Tried several 4.17, 4.18 and 4.19 releases (latest 
4.19.4), none of these show any output on the screen after the bootloader.

We've tested mostly with Fedora 27/28/29 kernels, but also with Ubuntu 
18.04 LTS (which uses 4.15.x and works fine and so does Fedora's 4.16.16 
(fc28)).

Bit at a loss on how to proceed with this. First off, I'm not a 
driver-/kernel developer. I can compile kernels and capture debug output 
etc. No clue on how to capture the debug output on this machine however. 
The machine has USB, but 'lspci -vv' doesn't show any debug capabilities 
on the USB ports, if it did we would probably be able to acquire a 
NET20DC for debugging, but I doubt it's possible if the capability isn't 
listed (never done debugging via USB/NET20DC). There's no serial port 
(not on the outside at least). We boot a somewhat modified version of 
Fedora (most of the modification being that it runs entirely from RAM, 
the initrd is the actual filesystem, no difference trying to boot it 
from a USB stick / filesystem on a disk or NFS / stock Fedora with 
kernels 4.17.x or higher).

Sending stuff to netconsole doesn't seem possible either. One of the 
first things it's supposed to do, if the kernels comes up, is acquiring 
DHCP. No DHCP request can be captured with these kernels from the NIC, 
kernel seems to get stuck way before then thus. We also have a script in 
place that if a FAT32 formatted USB stick is inserted with in the root a 
file with a certain name, it should dump the logs to the stick. This 
doesn't happen either, which we presume is another indicator that the 
kernel locks up / panics.

As stated I'm not a developer. Applying patches, building kernels, 
running them and probably debugging some stuff with perhaps (slight?) 
hints are things I probably can do (quite sure on the first 3, done 
those before many times :)). If there's anybody willing to help with 
this, please let me know.

Not sure how long we can borrow this hardware btw. Probably a couple of 
weeks, but will be required to send it back to the customer eventually.

As I have no clue on how to proceed due to the lack of screen / ability 
to capture anything, I've gathered, from Ubuntu 18.04 live USB:

lspci -vv
dmidecode
lsusb -vv
dmesg
journalctl

Whom can be downloaded from https://freaky.bananateam.nl/mac-a1418.txz

Thanks in advance and kind regards,

