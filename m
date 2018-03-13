Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeCMQ7U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:59:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40368 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeCMQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:59:17 -0400
X-Google-Smtp-Source: AG47ELtEV5V/KrC26CFhNSOGTJrdHeoHT14Onr+3xt5u6hDj9u7zRA4QfcObjB2l+ksERolvjoP/1w==
Date: Tue, 13 Mar 2018 22:29:06 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: ds1803: remove VLA usage
Message-ID: <20180313165906.GA11317@himanshu-Vostro-3559>
References: <20180313152343.GA31789@embeddedgus>
 <20180313162454.GA8769@himanshu-Vostro-3559>
 <be9b8f8d-929f-1c0b-334f-583d1c57460c@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be9b8f8d-929f-1c0b-334f-583d1c57460c@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:31:19AM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 03/13/2018 11:24 AM, Himanshu Jha wrote:
> >Hi Gustavo,
> >
> >On Tue, Mar 13, 2018 at 10:23:43AM -0500, Gustavo A. R. Silva wrote:
> >>In preparation to enabling -Wvla, remove VLA. In this particular
> >>case use macro ARRAY_SIZE so the length of array _result_ can be
> >>computed at preprocessing time.
> >>
> >>The use of stack Variable Length Arrays needs to be avoided, as they
> >>can be a vector for stack exhaustion, which can be both a runtime bug
> >>or a security flaw. Also, in general, as code evolves it is easy to
> >>lose track of how big a VLA can get. Thus, we can end up having runtime
> >>failures that are hard to debug.
> >>
> >>Also, fixed as part of the directive to remove all VLAs from
> >>the kernel: https://lkml.org/lkml/2018/3/7/621
> >>
> >>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>---
> >
> >It is already applied as I had sent the patch few days ago.
> >https://lkml.org/lkml/2018/3/10/164
> >
> >I specifically CC'ed you and Kees to avoid the patch collisions.
> >
> 
> I see. Can you please update this spreadsheet:
> 
> https://docs.google.com/spreadsheets/d/1OcfyKK8pJ24esYhSEsW4Q2boZE7UTGbYsSEEtFXf7U0/edit

Updated!

Also,

drivers/iio/humidity/hts221_i2c.c:43:2: warning: ISO C90
forbids variable length array ‘send’ [-Wvla]

This was already removed in recent commit when regmap API was used.

"6217792 iio: humidity: hts221: add regmap API support"

For this I added a short note in the *Notes* column.

-- 
Thanks
Himanshu Jha
