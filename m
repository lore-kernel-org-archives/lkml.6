Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeFDKRo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:17:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751854AbeFDKRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:17:43 -0400
Date: Mon, 4 Jun 2018 12:17:41 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCHv1] timekeeping: Update multiplier when NTP frequency is
 set directly
Message-ID: <20180604101741.GB27828@localhost>
References: <20180529105343.26870-1-mlichvar@redhat.com>
 <CALAqxLWV2d6yTeAK7j31Nvu33TqLmPLNDvzzSu0TSnDEUhVc1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWV2d6yTeAK7j31Nvu33TqLmPLNDvzzSu0TSnDEUhVc1A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:42:05AM -0700, John Stultz wrote:
> On Tue, May 29, 2018 at 3:53 AM, Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > -void update_wall_time(void)
> > +static void timekeeping_advance(bool force_update)
> 
> This is kind of a nit, but mind switching out bool for an enum?  Using
> something like TK_ADV_NORMAL and TK_ADV_FORCE?
> 
> > +void update_wall_time(void)
> > +{
> > +       timekeeping_advance(false);
> > +}
> 
> The enum makes usage like timekeeping_advance(false) a little less
> opaque to the reader ("Wait, don't advance? Let me go look at the
> function").
> 
> We got bitten by this earlier when we had the old
> "timekeeping_update(tk, true, false, true)" usage.

Ok. That make sense. I'll send a v2.

Thanks,

-- 
Miroslav Lichvar
