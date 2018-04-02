Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeDBOdc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:33:32 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45076 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeDBOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:33:31 -0400
X-Google-Smtp-Source: AIpwx49kioX2s6gefQPOkJg2bwDE883wR4n+spriDcpdNmm3z7PVPdhF0B3y3FGcvqFUNqZwu5dGng==
Subject: Re: [BISECTED][REGRESSION] Hang while booting EeePC 900
To: Sitsofe Wheeler <sitsofe@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Asai Thambi SP <asamymuthupa@micron.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
References: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <de102067-b589-af05-ae71-496e948000f0@kernel.dk>
Date: Mon, 2 Apr 2018 08:33:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/18 8:35 AM, Sitsofe Wheeler wrote:
> Hi,
> 
> While trying to boot an EeePC 900 on the latest git mainline kernel a
> hang is encountered while systemd is starting services but this did
> not happen with 4.15. A bisection narrowed it down to the commit
> 358f70da49d77c43f2ca11b5da584213b2add29c ("blk-mq: make
> blk_abort_request() trigger timeout path"). Here's the bisection log:
> 
> git bisect bad 358f70da49d77c43f2ca11b5da584213b2add29c
> # first bad commit: [358f70da49d77c43f2ca11b5da584213b2add29c] blk-mq:
> make blk_abort_request() trigger timeout path

Are you using scsi-mq?

Would probably also be handy to see a dmesg log from a 4.15 boot,
and from a failed 4.16 boot.

-- 
Jens Axboe
