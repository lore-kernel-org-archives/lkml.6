Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165183AbeCBTTs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:19:48 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:45989 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161195AbeCBTTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:19:46 -0500
X-Google-Smtp-Source: AG47ELv6AaaRpyIk6Av5kv2Ilz/nQjEiAYyhtP2ob217AZ30uPHDu0EpQnPA5OsFzBORA1zOBChBPFUTfX+Xz4cOJ6I=
MIME-Version: 1.0
In-Reply-To: <20180302101150.4mrrms3sn6spnicu@ninjato>
References: <20180227154213.3023-1-jglauber@cavium.com> <20180302101150.4mrrms3sn6spnicu@ninjato>
From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Fri, 2 Mar 2018 11:19:45 -0800
Message-ID: <CAAek22H_WBejypWH=GCV7iCFCaJ46HZZ=NdPtj-iaFipqATAFA@mail.gmail.com>
Subject: Re: [PATCH] i2c: octeon: Prevent error message on bus error
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jan Glauber <jglauber@cavium.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 2:11 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Feb 27, 2018 at 04:42:13PM +0100, Jan Glauber wrote:
> > The error message:
> >
> > [Fri Feb 16 13:42:13 2018] i2c-thunderx 0000:01:09.4: unhandled state: 0
> >
> > is mis-leading as state 0 (bus error) is not an unknown state.
> >
> > Return -EIO as before but avoid printing the message. Also rename
> > STAT_ERROR to STATE_BUS_ERROR.
> >
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
>
> Applied to for-current, thanks!

Did you also pick up the i2c-xlp9xx patches for current?

Similar set of issues there.

Multiple people have now tested them and reported they resolve issues
with IPMI SSIF on ThunderX2 platforms.

Thanks,
Phil P.

-- 
Philip Pokorny, RHCE
Chief Technology Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

Changing the world through technical innovation
