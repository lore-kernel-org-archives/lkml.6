Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966708AbeBNDRX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:17:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966588AbeBNDRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:17:22 -0500
Date: Tue, 13 Feb 2018 21:17:20 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Marc Haber <mh+linux-kernel@zugschlus.de>,
        =?utf-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "KVM-ML (kvm@vger.kernel.org)" <kvm@vger.kernel.org>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VMs freezing when host is running 4.14
Message-ID: <20180214031720.jq6c6yv652wt5r6u@treble>
References: <20171121161821.b6k3hdl3wgia5f5q@torres.zugschlus.de>
 <20171122093945.5afa2di2g7qhf4eb@torres.zugschlus.de>
 <CAD9gYJK7TOnfp+fnAyisYRQf--_TQv8J7h+kWH6KL98xNUH0bA@mail.gmail.com>
 <20171201144358.7yffztjhylfxxytn@torres.zugschlus.de>
 <20180108091025.2sup55jlpzbouo3d@torres.zugschlus.de>
 <20180211133941.gayg52r3bqbtptvm@torres.zugschlus.de>
 <20180214020445.ebu4fhnmogqehunb@treble>
 <20180214025635.2lmvriql7uuzfop4@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214025635.2lmvriql7uuzfop4@hz-desktop>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:56:35AM +0800, Haozhong Zhang wrote:
> On 02/13/18 20:04 -0600, Josh Poimboeuf wrote:
> > On Sun, Feb 11, 2018 at 02:39:41PM +0100, Marc Haber wrote:
> > > Hi,
> > > 
> > > after in total nine weeks of bisecting, broken filesystems, service
> > > outages (thankfully on unportant systems), 4.15 seems to have fixed the
> > > issue. After going to 4.15, the crashes never happened again.
> > > 
> > > They have, however, happened with each and every 4.14 release I tried,
> > > which I stopped doing with 4.14.15 on Jan 28.
> > > 
> > > This means, for me, that the issue is fixed and that I have just wasted
> > > nine weeks of time.
> > > 
> > > For you, this means that you have a crippling, data-eating issue in the
> > > current long-term releae kernel. I do sincerely hope that I never have
> > > to lay my eye on any 4.14 kernel and hope that no major distribution
> > > will release with this version.
> > 
> > I saw something similar today, also in kvm_async_pf_task_wait().  I had
> > -tip in the guest (based on 4.16.0-rc1) and Fedora
> > 4.14.16-300.fc27.x86_64 on the host.
> 
> Could you check whether this patch [1] on the host kernel fixes your
> issue?  Paolo had sent it to the stable tree and it may take a while
> to be merged in the next 4.14 stable release (perhaps in this week).
> 
> [1] https://patchwork.kernel.org/patch/10155177/

Unfortunately I don't know how to recreate it, the VM had been sitting
in idle for over an hour when it happened.  I'll leave it running
overnight without the patch and see if it happens again.

-- 
Josh
