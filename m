Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AB8JxZrp2Vm3PMJqz4C9My5SZTZDo4xmO7hbEE0CxurFjBdLD1gYSAnvq5c83eIX4tiGOk7jTrJX
ARC-Seal: i=1; a=rsa-sha256; t=1525981491; cv=none;
        d=google.com; s=arc-20160816;
        b=mc+TOb4F0/4Kc0t5z5AuYNJ+mXYDEjvw06zMdmvu4WtJcZCyo/BH+eN8+UdYzkj2fE
         voDZHNCExuRsPTAyMIloTZk8CAesJJoxwYttAo+o240dylsMOw2/XW07KZqultbXOqbQ
         CpkVK5ZzSmr8sCgACwPO0rvgsrjwF2oSSk8D5Wldyh2ybEjcpsgJkF7x+rORNtZKSlzT
         16cSn7fboZLif68fjDCvynGmnG4VQ2yi9WqPkW7Fk3b017hWN2YF0RYeN2PR6FwvyLxc
         pxrBQoabKGbqeST0Ao++Oz4hOgv0bBrpPdzuf6omRq8dWKoJKnECfQ1wgq38rtqxrI9c
         cOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=AGl+2Ras8V2s0pKHtlF6LM/9tZk4b0vPr/MfRyErHf8=;
        b=C8tStQVyqDMSDR2TfygBp/fsNPgSSEwX0Br9/f7Y2f8oePIj9AGvuJR2v8Il9Ta9kg
         WEGEETvSq9neWt7PXrq8fbndcDrE3hIlHB0/iCI3lcFo3ooMA2dQByJ11qC7UTAfmUyg
         CMgXxbnLbsdqgZTV5SBkzMm8WQsv8IvbCaxPAalYMaWOOQUtzbkjUhCfdV3c9caad3ry
         /NsaHI3Oc+m4/HcuOIZdqV9U1YXRVHxF7GrqoxsfZ3tdZUg3CZOsbX8JLnms6cglK0as
         rfI+jQFyZQt91Ovd+rPd240JZ9n1OzNwqJBpal9D+5awGi1uVjeRi+M+3pndvKHFzzvO
         NRNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=MeUiilBM;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=MeUiilBM;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Thu, 10 May 2018 20:44:22 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
Message-ID: <20180510194422.GX16141@n2100.armlinux.org.uk>
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com>
 <20180509152505.GA25559@xps15>
 <87k1scs0f8.fsf@xmission.com>
 <20180510084057.GT16141@n2100.armlinux.org.uk>
 <CANLsYkwaNmZCUjwJXK0X1ia+RnzumfbpB8EvZJ-HDtOHj8rafQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwaNmZCUjwJXK0X1ia+RnzumfbpB8EvZJ-HDtOHj8rafQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1600107568651331733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 01:39:18PM -0600, Mathieu Poirier wrote:
> Hi Russell,
> 
> On 10 May 2018 at 02:40, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> > This does not leak information from other namespaces because of the
> > uniqueness of the global PID.  However, what it does leak is the value
> > of the global PID which is meaningless in the namespace.  So, before
> > the event stream is delivered to userspace, this value needs to be
> > re-written to the namespace's PID value.
> 
> Unfortunately that can't be done.  The trace stream is compressed and
> needs to be decompressed using an external library.  I think the only
> option is to return an error if a user is trying to use this feature
> from a namespace.

That sounds like a sensible approach, and that should get rid of the
vpid stuff too.

Eric, would this solve all your concerns?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
