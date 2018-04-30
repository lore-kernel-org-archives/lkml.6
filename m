Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeD3HNQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:13:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60569 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeD3HNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:13:15 -0400
Date: Mon, 30 Apr 2018 09:13:10 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alexander Popov <alex.popov@linux.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, sil2review@lists.osadl.org,
        Dmitry Vyukov <dvyukov@google.com>, syzkaller@googlegroups.com
Subject: Re: [v2 1/1] i2c: dev: prevent ZERO_SIZE_PTR deref in
 i2cdev_ioctl_rdwr()
Message-ID: <20180430071310.7s7glgig3cilw4dj@pengutronix.de>
References: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
 <20180427120658.wi32f7margtfazzp@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427120658.wi32f7margtfazzp@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 02:06:58PM +0200, Wolfram Sang wrote:
> On Thu, Apr 19, 2018 at 03:29:22PM +0300, Alexander Popov wrote:
> > i2cdev_ioctl_rdwr() allocates i2c_msg.buf using memdup_user(), which
> > returns ZERO_SIZE_PTR if i2c_msg.len is zero.
> > 
> > Currently i2cdev_ioctl_rdwr() always dereferences the buf pointer in case
> > of I2C_M_RD | I2C_M_RECV_LEN transfer. That causes a kernel oops in
> > case of zero len.
> > 
> > Let's check the len against zero before dereferencing buf pointer.
> > 
> > This issue was triggered by syzkaller.
> > 
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> 
> Applied to for-current with the arithmetic expression changed to '< 1'
> to keep in sync with the previous one. Will push out soon, so you can
> double check if you are interested.

Thanks, I like it. An added bonus is also that you don't need to think
about the type of msgs[i].len and what happens if it is negative.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
