Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AB8JxZpwHz9JZb8efv8SkhmmqM9nvGlvkCeTO7F+SxY0aDS+raPMMfRZ+aEW84RHhzE4tZZsp8yQ
ARC-Seal: i=1; a=rsa-sha256; t=1526391738; cv=none;
        d=google.com; s=arc-20160816;
        b=bkZfB+tJMbgCSSTFUdqRnozGkadwMvgpxmg8ZmRLFrXt/3beU568dkzRNpzP11A5IG
         KA2W5MY/a/XvtFq9WeWHnVnDpoiIhh3u8Vlj0d1iW9d2RNAHW6IyPmQZAPP9i+nrblfK
         pmErd0vz2ZPBnIRl7lhhJqeaJjvW+Pe3TMaQH326TY1vggUa6+j43xa9e3HFCOAHThR3
         LbmpvpB7X6PEfcNXQ8e/bq7W2qQdQYMhbsRiiNilCOSC5Q0FKbBYtmGfViwtoX+hjNC3
         bzY3fs5Axfg8jvOHqSG9Z+e0o5ucBNacyl4WK8FLaP/9PulMcK/Rh2UdD60wLNt+Eyn3
         N6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=QJhMVymbQTlB46wK54wC4bG5pUIkcRi06zZuWfkhE1g=;
        b=ZMSUWbY74tSBr4niVbDr8rBECyRV1biiEar2FpmC2xtB8Qq562FHf6aFCfHzRW+51y
         zbIWgoPXLmHJ9cQ5NN3eaXujM+g+SMwrj30OKT8EBcnyaQv7y9ZrsYTSCaUfMwimReNe
         x8BeGU4BzLllVRsOcZ9qgALHs2efwgAgyJ1BnkCRtqomRni2kc77w2FcK73Fep/5Y4d0
         hrG10zFKghtAkFjYhxwdoVroS8FCx3nXtCbHITZxBDuqslE/lPdY8ayt/VWhmAcxfYJb
         rRu3yT5aRG9DfNsP1QqjemscozGw7MOSFB5VyA22bvqlst12VtPGJnfAUHt8wAZ/g6LO
         DuJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=qVkgV8W1;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=qVkgV8W1;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Tue, 15 May 2018 14:41:45 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kim Phillips <kim.phillips@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
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
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
Message-ID: <20180515134144.GF16141@n2100.armlinux.org.uk>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600537743260441922?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 08:59:02AM +0200, Ulf Hansson wrote:
> On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> > This patch is provided in the context of allowing the Coresight driver
> > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > to bus_find_device() in of_coresight_get_endpoint_device() when
> > searching for a configurable endpoint device.  This patch allows
> > Coresight to reference amba_bustype when built as a module.
> 
> Sounds like you are fixing a bug, don't your want this to go for
> stable and then also add a fixes tag?

What bug is this fixing exactly that would qualify it for stable
backporting?

The lack of an export is never a bug unless there is some existing
user which requires it.  This is not the case here.

What Kim is doing in his new patch series is making Coresight - which
is currently only available as either disabled or built-in - possible
to be loaded as a module.  This is a new feature, and in the process
of creating this new feature, Kim needs a symbol that wasn't previously
needed to be exported.

I think it would be hard to argue that Coresight not being available
as a module is a bug worthy of backporting to older kernels.

Therefore, it is not a bug, and it certainly does not qualify for
backporting to stable trees:

 - It must be obviously correct and tested.

Probably.

 - It cannot be bigger than 100 lines, with context.

Is.

 - It must fix only one thing.

Does.

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).

Nope.

 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short, something
   critical.

Nope, not in any stable tree.

 - Serious issues as reported by a user of a distribution kernel may also
   be considered if they fix a notable performance or interactivity issue.
   As these fixes are not as obvious and have a higher risk of a subtle
   regression they should only be submitted by a distribution kernel
   maintainer and include an addendum linking to a bugzilla entry if it
   exists and additional information on the user-visible impact.

Hasn't been.

 - New device IDs and quirks are also accepted.

Is not that.

 - No "theoretical race condition" issues, unless an explanation of how the
   race can be exploited is also provided.

Is not that.

 - It cannot contain any "trivial" fixes in it (spelling changes,
   whitespace cleanups, etc).

Doesn't (so okay.)

 - It must follow the
   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
   rules.

Does.

 - It or an equivalent fix must already exist in Linus' tree (upstream).

Eventually.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
