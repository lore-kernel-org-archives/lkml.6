Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970953AbeEXPpL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:45:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50755 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966676AbeEXPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:45:10 -0400
Date: Thu, 24 May 2018 17:45:05 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH RFC] suspend: Prevent might sleep splats
Message-ID: <20180524154505.d5r77w7xinpbc36n@linutronix.de>
References: <20180524142426.jeyszeqdrjvb3tob@linutronix.de>
 <CAJZ5v0jyGVP4h6B=wkhHb7UV2yePHZVjkzodj0Djx-gUBxyMkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jyGVP4h6B=wkhHb7UV2yePHZVjkzodj0Djx-gUBxyMkA@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-24 17:07:16 [+0200], Rafael J. Wysocki wrote:
> On Thu, May 24, 2018 at 4:24 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > timekeeping suspend/resume calls read_persistent_clock() which takes
> > rtc_lock. That results in might sleep warnings because at that point
> > we run with interrupts disabled.
> >
> > We cannot convert rtc_lock to a raw spinlock as that would trigger
> > other might sleep warnings.
> >
> > As a workaround we disable the might sleep warnings by setting
> > system_state to SYSTEM_SUSPEND before calling sysdev_suspend() and
> > restoring it to SYSTEM_RUNNING afer sysdev_resume().
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Hmm.  Don't we also need to cover suspend-to-idle?

Well, if you agree with the approach then I would look into it.

Sebastian
