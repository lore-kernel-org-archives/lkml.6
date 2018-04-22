Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeDVTz4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 15:55:56 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45967 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753417AbeDVTzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 15:55:55 -0400
Subject: =?UTF-8?Q?Re:_How_to_disable_Linux_kernel_self-extraction_=28KERNEL?=
 =?UTF-8?B?X0daSVAsIEtFUk5FTF9CWklQMiwg4oCmKT8=?=
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
References: <9468be0e-5eb9-246c-e60e-3d8019a42fd1@molgen.mpg.de>
 <20180422102033.GB26243@amd>
From: Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>
Message-ID: <b22efb58-b63e-7130-f2d7-a9d28225ef9b@molgen.mpg.de>
Date: Sun, 22 Apr 2018 21:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422102033.GB26243@amd>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Pavel,


Am 22.04.2018 um 12:20 schrieb Pavel Machek:
> On Fri 2018-04-20 16:36:00, Paul Menzel wrote:

>> I try to decrease boot time, and my system has an SSD and enough space, so
>> loading 18 instead of 12 MB doesn’t make a difference, but the
>> self-extraction is noticeable. So, I like to disable it.
> 
> How long does GZIP extraction take on your hardware?

It’s hard to measure – at least I didn’t find a way to do so –, but 
counting from the last GRUB message to the first message of Linux (with 
`quiet` removed from the the command line), it takes roughly *two* seconds.

```
$ ls -l /boot/vmlinuz-4.15.0-3-686-pae
-rw-r--r-- 1 root root  3987200 Apr 19 12:13 /boot/vmlinuz-4.15.0-3-686-pae
$ ls -lh /boot/vmlinuz-4.15.0-3-686-pae
-rw-r--r-- 1 root root 3,9M Apr 19 12:13 /boot/vmlinuz-4.15.0-3-686-pae
$ time scripts/extract-vmlinux vmlinuz-4.15.0-3-686-pae > bla.txt

real    0m1,204s
user    0m1,041s
sys     0m0,245s
```

As another data point, my self-built (*bigger*) image with XZ used for 
compression.

```
$ ls -lh /boot/vmlinuz-4.16.0+
-rw-r--r-- 1 root root 6,1M Apr 14 10:48 /boot/vmlinuz-4.16.0+
$ time /usr/src/linux-headers-4.17.0-rc1+/scripts/extract-vmlinux 
vmlinuz-4.16.0+ > bla.txt

real    0m2,190s
user    0m1,792s
sys     0m0,500s
```

So, it’s really noticeable if the rest of the system starts in less then 
five seconds to a login prompt, or you are trying to achieve to display 
the LUKS passphrase dialog more or less instantly.


Kind regards,

Paul
