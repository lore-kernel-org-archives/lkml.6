Return-Path: <jwboyer@kernel.org>
X-Google-Smtp-Source: AB8JxZpIzRoK3HTASF/bztONkRurj+oyUZCEeHHJATwLWSnEF+rVyK8SGlIFzUtndNKaaIbp8wwn
ARC-Seal: i=1; a=rsa-sha256; t=1526387588; cv=none;
        d=google.com; s=arc-20160816;
        b=QBpbxAT/DW9OsHc2LJy8kEFQOZM547jQh+hls90b8o26LMm8rrRo+LEXd9Tq/0tFHD
         X0/Zw4SWdTNzA+A9TIbERKfbrongBDTrTxAEDfRpR3Hxbh8mibJXUqBajVkmVkdZzvYY
         RC2rJim/V/Dj0d977C95nH61u7oUoAVpAqpKTihW4tBbPsoTr0QbdG00JuzqPHIRZICK
         uYjcoxme6ng/RkJpaXnY8ucFZOrCfYBNZQOfbT+DaTrQvamCv1g5mz0cTzf0nytch39s
         7KAOm0DPE/gieeD330ePe9YxvX3mKFXNQzwQ8mHRcVfcBOB+JHzDZt+E63YbHGCUunQu
         roOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5p8Fgm8aaJ/v5JL2r9zWZq2WU+sC+qx/5evnilxdFxU=;
        b=SU/o/yeyZQ4MYEhNS+6GsS1XP5lCEH3KnzJfon0ml71wzZ/JPlU6n9NInHJ50aUx0e
         AnvQjaJ9gzS3n+a1O15p2TBqRAPcqJINRThmqgH4Q760o2g0aEfK82uEzX5coS/JOge1
         4lPaz41s8hSbYBeI4ac+SBjGWUDCd7HtZvj68qk8F8apXQ4ZNkRXjYlWRdAb3Bfpx3up
         IcgfL7LXSFYpaFDLhV3k+5uEAbVR4g9uX5sU791U0fWPdc8VGswQDFo9bZmz0XslKXt6
         YRc4qvUOGsp4NDFoNQPoxM4ocXc/+iE2LW4NCTWeuJmlbXk/s+xqLybw2roU28KS4UbJ
         30iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MV3EF7Uu;
       spf=pass (google.com: domain of jwboyer@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jwboyer@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MV3EF7Uu;
       spf=pass (google.com: domain of jwboyer@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jwboyer@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
References: <20180509212212.GX27853@wotan.suse.de> <1525903617.3551.281.camel@linux.vnet.ibm.com>
 <20180509234814.GY27853@wotan.suse.de> <1525917658.3551.322.camel@linux.vnet.ibm.com>
 <20180510232639.GF27853@wotan.suse.de> <1526014826.3414.46.camel@linux.vnet.ibm.com>
 <20180511215250.GJ27853@wotan.suse.de> <1526302692.3898.145.camel@linux.vnet.ibm.com>
 <20180514192853.GM27853@wotan.suse.de> <1526349751.3937.78.camel@linux.vnet.ibm.com>
 <20180515032656.GR27853@wotan.suse.de>
In-Reply-To: <20180515032656.GR27853@wotan.suse.de>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 15 May 2018 08:32:55 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7QU0k91zvoBTAFzG+unkh-=-s9Lhk3hn3eTJhHo4ovCQ@mail.gmail.com>
Message-ID: <CA+5PVA7QU0k91zvoBTAFzG+unkh-=-s9Lhk3hn3eTJhHo4ovCQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] firmware: differentiate between signed regulatory.db
 and other firmware
To: mcgrof@kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Harald Hoyer <harald@redhat.com>,
	Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>, Casey Schaufler <casey@schaufler-ca.com>, ast@kernel.org,
	David Miller <davem@davemloft.net>, jeyu@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Matthew Garrett <mjg59@srcf.ucam.org>, Peter Jones <pjones@redhat.com>, takahiro.akashi@linaro.org,
	David Howells <dhowells@redhat.com>, Linux Wireless <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>, Seth Forshee <seth.forshee@canonical.com>,
	johannes.berg@intel.com, linux-integrity@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	Greg KH <gregkh@linuxfoundation.org>, andresx7@gmail.com,
	Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
	Justin Forbes <jforbes@redhat.com>, Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600533392498912134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 11:27 PM Luis R. Rodriguez <mcgrof@kernel.org>
wrote:

> On Mon, May 14, 2018 at 10:02:31PM -0400, Mimi Zohar wrote:
> > On Mon, 2018-05-14 at 19:28 +0000, Luis R. Rodriguez wrote:
> > > > - CONFIG_IMA_APPRAISE is not fine enough grained.
> > > >
> > > > The CONFIG_IMA_APPRAISE_FIRMWARE will be a Kconfig option.  Similar
> > > > Kconfig options will require kernel modules, kexec'ed image, and the
> > > > IMA policy to be signed.
> > >
> > > Sure, it is still unclear to me if CONFIG_IMA_APPRAISE_FIRMWARE will
be
> > > doing firmware verification in userspace or in the kernel.
> >
> > The kernel is verifying signatures.
> >
> > > > There are a number of reasons that the kernel should be verifying
> > > > firmware signatures (eg. requiring a specific version of the
firmware,
> > > > that was locally signed).
> > >
> > > Oh I agree, Linux enterprise distributions also have a strong reason
to
> > > have this, so that for instance we only trust and run vendor-approved
> > > signed firmware. Otherwise the driver should reject the firmware.
Every
> > > now and then enterprise distros may run into cases were certain
customers
> > > may run oddball firmwares, and its unclear if we expect proper
functionality
> > > with that firmware. Having some form of firmware signing would help
with
> > > this pipeline, but this is currently dealt with at the packaging, and
> > > noting other than logs ensures the driver is using an intended
firmware.
> > > But these needs *IMHO* have not been enough to push to generalize a
kernel
> > > firmware signing facility.
> >
> > In order for IMA-appraisal to verify firmware signatures, the
> > signatures need to be distributed with the firmware.  Perhaps this
> > will be enough of an incentive for distros to start including firmware
> > signatures in the packages.

> Best to poke the maintainers about that... We have been sending mixed
messages
> about firmware signing over years now. Josh, heads up the new one is we
can
> do firmware signing through IMA future CONFIG_IMA_APPRAISE_FIRMWARE. I'll
> bounce you a few emails related to this.

> > > If CONFIG_IMA_APPRAISE_FIRMWARE is going to provide this
functionality somehow
> > > I'm happy to hear it.
> >
> > The functionality has been there since commit 5a9196d ("ima: add
> > support for measuring and appraising firmware").  The
> > security_kernel_fw_from_file() hook was later replaced with the
> > generic security_kernel_read_file() hook.

> Groovy, its unclear from the code on that commit how this is done, so I
> suppose I need to study this a bit more. Josh, do you grok it?

I haven't looked to be honest.  I don't do much in the way of kernel
maintenance on the distro side any longer.  You already have David copied
and I've added Justin Forbes and Laura Abbott to cover Fedora.

One aspect that was always a concern to some is whether the firmware files
were modified directly to have the signature attached to them.  That may
run afoul of the "no modification" license that most blobs are shipped
under.  Does IMA have the signatures for the files stored in xattrs or in
some other detached manner?

josh
