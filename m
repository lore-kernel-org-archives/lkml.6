Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeAaSyy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:54:54 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:43861 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeAaSyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:54:53 -0500
Date: Wed, 31 Jan 2018 10:54:48 -0800
From: Darren Hart <dvhart@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: dell-laptop: Guard SMBIOS calls with a
 mutex
Message-ID: <20180131185448.GE8676@fury>
References: <1517267756-29878-1-git-send-email-mario.limonciello@dell.com>
 <20180130110247.5w4qreycdp2o5pjw@pali>
 <30071dd5d1574ef9bf85eb34fda1277f@ausx13mpc120.AMER.DELL.COM>
 <CAHp75Vd4N2DNpnFgE-k85Kz7_sZ=SH=-L8sagLkFx=WMj8xW=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd4N2DNpnFgE-k85Kz7_sZ=SH=-L8sagLkFx=WMj8xW=Q@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 05:39:58PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 30, 2018 at 5:35 PM,  <Mario.Limonciello@dell.com> wrote:
> 
> >> >     dell_set_arguments(0x2, 0, 0, 0);
> >> >     ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
> >>
> >> Hi! I'm looking at this code, and do we need shared global buffer with
> >> mutex protection at all? Is not buffer allocated on stack enough?
> >
> > Oh you mean rather than create buffer mutex to just remove global
> > buffer and allocate in each function?  That seems like a workable
> > approach to me too.
> >
> > I'm fine with either way.
> >
> > Andy or Darren, what's your preference in this area?
> 
> It reminds me USB stuff where buffer for transfer is allocated on heap
> before performing communication.
> So, it looks similar to some extent and I have no objection on that
> kind of approach.

Late to the party it seems, but FWIW:

I don't see a significant advantage of a global buffer. It doesn't *need* to be
global, and the locking just adds complexity. The heap solution seems much
preferable to me.

-- 
Darren Hart
VMware Open Source Technology Center
