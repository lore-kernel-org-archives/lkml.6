Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeEKHZv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:25:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43661 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeEKHZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:25:50 -0400
X-Google-Smtp-Source: AB8JxZpAL3qOHHwUQZxagb0GafChdWqetyKGtEApzg9Vg3pY5TNODdBkVDb4zkAsjaaidjmOH2PFaQ==
To: paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, rostedt@goodmis.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, stefani@seibold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Subject: Is read barrier missed in kfifo?
Message-ID: <5382d3a8-08e0-5429-0cd3-36f9c69197e1@gmail.com>
Date: Fri, 11 May 2018 15:25:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Currently, there is no read barrier between reading the index
(kfifo.in) and fetching the real data from the fifo.

I am afraid that will cause the vfifo is observed as not empty
however the data is not actually ready for read. Right?

Thanks!
