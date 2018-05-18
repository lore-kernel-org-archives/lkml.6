Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeERTmP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:42:15 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:33904 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbeERTmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:42:11 -0400
X-Google-Smtp-Source: AB8JxZoTepiea5FRIctbn6lxAR+EfJ948W4JXkhh5/LIhrsZfGRSOFWzKViQM3vrYlXrVPqZ4r2aKsR8D2IgXsCC02I=
MIME-Version: 1.0
In-Reply-To: <20180511.155046.122041869811590666.davem@davemloft.net>
References: <1525548766-13017-1-git-send-email-wang6495@umn.edu> <20180511.155046.122041869811590666.davem@davemloft.net>
From: Wenwen Wang <wang6495@umn.edu>
Date: Fri, 18 May 2018 14:41:29 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fR_DwdPiQ_g4i5nN=adpxMKHi1RhVX6h=BgKfYw=dkkA@mail.gmail.com>
Message-ID: <CAAa=b7fR_DwdPiQ_g4i5nN=adpxMKHi1RhVX6h=BgKfYw=dkkA@mail.gmail.com>
Subject: Re: [PATCH] isdn: eicon: fix a missing-check bug
To: David Miller <davem@davemloft.net>
Cc: Kangjie Lu <kjlu@umn.edu>, Armin Schindler <mac@melware.de>,
        Karsten Keil <isdn@linux-pingi.de>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your suggestion, David! I will revise the patch and resubmit it.

Wenwen

On Fri, May 11, 2018 at 2:50 PM, David Miller <davem@davemloft.net> wrote:
> From: Wenwen Wang <wang6495@umn.edu>
> Date: Sat,  5 May 2018 14:32:46 -0500
>
>> To avoid such issues, this patch adds a check after the second copy in the
>> function diva_xdi_write(). If the adapter number is not equal to the one
>> obtained in the first copy, (-4) will be returned to divas_write(), which
>> will then return an error code -EINVAL.
>
> Better fix is to copy the msg header once into an on-stack buffer supplied
> by diva_write() to diva_xdi_open_adapter(), which is then passed on to
> diva_xdi_write() with an adjusted src pointer and length.
