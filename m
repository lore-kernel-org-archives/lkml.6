Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeFAKXH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:23:07 -0400
Received: from 61.239-255-62.static.virginmediabusiness.co.uk ([62.255.239.61]:55927
        "EHLO office.gblabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFAKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:23:04 -0400
X-Footer: Z2JsYWJzLmNvLnVr
To: linux-man@vger.kernel.org, linux-mm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Alex Richman <alex.r@gblabs.co.uk>
Subject: mlock() confusing 1 half of system RAM limit
Message-ID: <c43ad840-dcab-b86f-bf15-ffb26b66d37b@gblabs.co.uk>
Date: Fri, 1 Jun 2018 10:53:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a 1/2 of system RAM limit when calling mlock().  mlock(2) says:
 > ENOMEM (Linux 2.4 and earlier) the calling process tried to lock more 
than half of RAM.
Which implies to me that the 1 half of system RAM limit should be only 
Linux 2.4 and earlier, but I'm running linux 4.4.127 and still seeing 
the limit.

This is on a system with 66007168 KB total memory, locking 33794621440 
bytes works, locking 33795653632 bytes does not work.

Anyone know if this is the man pages or the kernel or something unrelated?

More details here: 
https://stackoverflow.com/questions/50639709/mlock-of-large-shm-address-range-fails-with-enomem-even-with-lots-of-free-memo

Thanks,
- Alex.

-- 
Alex Richman
alex.r@gblabs.co.uk
Engineering
GB Labs
2 Orpheus House,
Calleva park,
Reading
RG7 8TA
Tel:+44 (0)118 455 5000
www.gblabs.com



The information contained in this message and any attachment may be proprietary, confidential and privileged.
If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering
this message to the intended recipient, you are hereby notified that any dissemination, distribution or copying
of this communication is strictly prohibited. If you received this communication in error, please contact me immediately,
and delete the communication (including attachments, if applicable) from any computer or network system.
