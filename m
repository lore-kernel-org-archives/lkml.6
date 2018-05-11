Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeEKIBO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:01:14 -0400
Received: from www84.your-server.de ([213.133.104.84]:49589 "EHLO
        www84.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbeEKIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:01:10 -0400
Message-ID: <1526023986.28429.1.camel@seibold.net>
Subject: Re: Is read barrier missed in kfifo?
From: Stefani Seibold <stefani@seibold.net>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, rostedt@goodmis.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 11 May 2018 09:33:06 +0200
In-Reply-To: <5382d3a8-08e0-5429-0cd3-36f9c69197e1@gmail.com>
References: <5382d3a8-08e0-5429-0cd3-36f9c69197e1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: stefani@seibold.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My guts thinks you are right. Feel free to send a patch...

Am Freitag, den 11.05.2018, 15:25 +0800 schrieb Xiao Guangrong:
> Hi,
> 
> Currently, there is no read barrier between reading the index
> (kfifo.in) and fetching the real data from the fifo.
> 
> I am afraid that will cause the vfifo is observed as not empty
> however the data is not actually ready for read. Right?
> 
> Thanks!
