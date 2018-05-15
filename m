Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZqLlQ+1JZa/qnRfH/pnFEoEZkPTE0+0s7eJh0eat0NT8/353gnt2/eBZSl9i491xRp7imMR
ARC-Seal: i=1; a=rsa-sha256; t=1526395045; cv=none;
        d=google.com; s=arc-20160816;
        b=jtjw0NEbnm47+j/nQDC94iTBDx7+eZDYlMVwT0eYov3JWRVtFTczzSV+g2JAq1rpvN
         NvBQwZmFo6iU2du25R+HN2oxVq+0m4UDP+2Q94JzsrpDdHyhGCW15UWHckunH6I6ljoX
         4uM1KMbC0Grf21E1dc14Ubs+hQg24120w3NNt+sKgLZfOmpBdDpjTKO7f/sYFAgHlCEj
         bcOephpxobeqJXfosFcG2AxYgOs9AmIQH1NPrt8RizYeG+Na5j/ryqy+V5Gs3QhHMKpE
         ZBQONkTGgbhyPAlpdmlcJBPCYTcIZr/eEvY0Lx0MKIVZWWgrhwuZFhwKC9M4h052DIqV
         3HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=f4J5LiJKGOg5S0ezKI9laT3CySTeLlZ3uO7Va5ewNwM=;
        b=mn/SkNSgF4QWSQgp9/vO2SnWBHDIjW4S/1YkLiZcNy6OPQVRv8lvYp+JlxN40mde4W
         HmB0L/x7dhkkdSjG5sgmEG4MQFdcrXonhnWhmLYUMP9QcwtRB1QmBtUPghkTetyYQ3Oz
         F0QETm69Hi36RlwS0btvdTza29U/TuoPd+rP7i2t36CBDFsytfYTe2u6j6OMtknqt1B1
         VvQN9Oi41de4lP07PDkdNASMpKWu44rIwXFksdq4p/l9MhWXbWc8Q1HaEyQ3cGUu/wWU
         2uqD8p/nCuEJup76EirUqWLJsOS/pdo2tUroeRS7/y2Nf86KLVKO5ru0YFsFF8QsOj1w
         xvQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Tue, 15 May 2018 09:37:18 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kirill Tkhai <ktkhai@virtuozzo.com>, Mike Rapoport
 <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin
 <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>, Robin Murphy
 <robin.murphy@arm.com>, Thierry Reding <treding@nvidia.com>, Todd Kjos
 <tkjos@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
Message-Id: <20180515093718.19ca71295fc36fe65c5df021@arm.com>
In-Reply-To: <20180515134831.GG16141@n2100.armlinux.org.uk>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
	<CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
	<20180515081519.22751a39c49e63224da3acac@arm.com>
	<20180515134831.GG16141@n2100.armlinux.org.uk>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600541211228890108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 15 May 2018 14:48:31 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Tue, May 15, 2018 at 08:15:19AM -0500, Kim Phillips wrote:
> > On Tue, 15 May 2018 08:59:02 +0200
> > Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > 
> > > On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> > > > This patch is provided in the context of allowing the Coresight driver
> > > > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > > > to bus_find_device() in of_coresight_get_endpoint_device() when
> > > > searching for a configurable endpoint device.  This patch allows
> > > > Coresight to reference amba_bustype when built as a module.
> > > 
> > > Sounds like you are fixing a bug, don't your want this to go for
> > > stable and then also add a fixes tag?
> > 
> > How do you consider this a bug fix?  What commit would the fixes tag
> > reference?  The introduction of the amba bus?  Not only aren't busses
> > required to export their bus_type, but that commit predates git.
> 
> I do not consider it a bug fix (see my reply to Ulf) and I certainly

I agree this isn't a bug fix.

> The only problem which we're aware of is with Coresight, and only then
> when your patches to allow Coresight to be modular are merged.  That's

Just to clarify: the Coresight modularization patch depends on this
patch, so this patch is to be merged first.

Cheers,

Kim
