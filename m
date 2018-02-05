Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBEXZ2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:25:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46287 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBEXZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:25:17 -0500
X-Google-Smtp-Source: AH8x227i8le/Tk1hlSQSL+ZyxqyWvSIo2uFmr5ttxNx+QJe6CabOl/atwEAvtfRUD4JJpqIQa4Le5g==
Date: Mon, 5 Feb 2018 15:25:14 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, Daniel Ribeiro <drwyrm@gmail.com>
Cc: ilya.muromec@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] drivers/input/misc/pcap: a possible sleep-in-atomic bug in
 pcap_keys_handler
Message-ID: <20180205232514.GE46524@dtor-ws>
References: <9af81fe8-e07c-9161-2d85-3eb23a198ec9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af81fe8-e07c-9161-2d85-3eb23a198ec9@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2017 at 04:32:01PM +0800, Jia-Ju Bai wrote:
> According to drivers/input/misc/pcap_keys.c, the kernel module may sleep in
> the interrupt handler.
> The function call path is:
> pcap_keys_handler (interrupt handler)
>   ezx_pcap_read
>     mutex_lock --> may sleep
> 
> I do not find a good way to fix it, so I only report.
> This possible bug is found by my static analysis tool (DSAC) and checked by
> my code review.

Let's see if Daniel's email still work. I am not sure how it worked to
begin with, given that we've been taking that mutex since very
beginning, and pcap_isr_work() disables local interrupts...

Thanks.
 
-- 
Dmitry
