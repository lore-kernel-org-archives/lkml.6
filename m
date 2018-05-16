Return-Path: <heikki.krogerus@linux.intel.com>
X-Cyrus-Session-Id: sloti22d1t05-139798-1526471901-2-11323114352586369484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.43', Host='mga05.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: heikki.krogerus@linux.intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526471900; b=RrrVZXFTR9KhWZTbEqZBbEyMOm5brX2kCRO+WQ8tTwkLEHfiA0
    jF93HHgt6iWes7Ks8NJvOTXR//HJ6o2hVlonJUnuEajet0bE0YZKdZRcYT2Uiymi
    LLU6OD5pwBxJJPmKgE+ACp6pTHz8wVODzjTRnZdY2pBkYZAO5RzyJdMAAlO2oKtU
    i+ZByIV35SqUYaZa0cIb0C445Bc2lwM5xgne9BWB4SAtJxLW37NkoaiYf61XDrji
    8bMpFZTktGDPm/s3QUyVYgReEvv8s75TFlIAUztWeJkjQP3L0OfJ+o4B1ZYiCwnw
    GrWypTWnQw9kwseS5GroYbbogamBfUOD89TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1526471900; bh=8HM6dvdN2vqNeOyn5F/7Tb4YIq1E64BLSMtYoChIaGg=; b=c
    VSEcuB80a1Lh4a3HNoA7yGXqFPJGYu+yFvGUe/E3mTIL4Vn1dWXFnYduhaZmpknA
    l2kSIQn9nwhDiQcUIps916vQRwQU57Qr5D7F4aSuHg/fCiDMG64vBh+qZrdEt0Mo
    914Rvb9L82PAwD4sD7xZ4cllDVyW24qbWea6cj+VwvbeoYcSWXOCd6LqsdPLVRBK
    urF7DVunP9LZBmofq79i93XBd1Cvu085xAddlUKs2xzcP1oQTYP4D9OSMHn/3135
    Ap0nCOaUtGS0/SDpRupyXcxAK7xnIuRN93V8y38oCcjACjnhlX5XHfLdZvfAYMPu
    t636odgHxX4tDRRAJ/VdQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.43 (mga05.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com
    smtp.helo=mga05.intel.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga05.intel.com x-ptr-lookup=mga05.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass
    smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.43 (mga05.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com
      smtp.helo=mga05.intel.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga05.intel.com x-ptr-lookup=mga05.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass
      smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB+9GPW7d/23XEPNbOZ3sbY6vKOr4KeMnzgQiFDhYktfRQEIw1YjnVZYkRmX1ccKD8TuDGPAZ78propqTtwX6EkFlQ1UDvhb+yQoNUDzkNyIbigBH6X6
    /ntQ1w9pOTK2bNM9/e45gQAMBt1TeZx6NIDrYqF9Sj2ryt5/B/6FdAgX2ZogMmnpllpPm0Yp/ivdK0+oiEb+kxsXlqLMKxGe+04=
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=YWhQVxBgbsGkxU+7CP83Mg==:117
    a=YWhQVxBgbsGkxU+7CP83Mg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=krp-EOMYRG6XRM1oiUEA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="55708588"
Date: Wed, 16 May 2018 14:58:14 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <greg@kroah.com>, Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Message-ID: <20180516115814.GB11469@kuha.fi.intel.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516080226.GC3536@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, May 16, 2018 at 10:02:26AM +0200, Greg KH wrote:
> On Tue, May 15, 2018 at 06:47:37PM +0200, Paul Menzel wrote:
> > Dear Greg,
> > 
> > 
> > As always, thank you for the prompt response.
> > 
> > 
> > On 05/15/18 18:00, Greg KH wrote:
> > > On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:
> > 
> > > > Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 with Debian
> > > > Sid/unstable.
> > > > 
> > > > ```
> > > > [???]
> > > > [    0.440240] usb: port power management may be unreliable
> > > > [    0.441358] usbcore: registered new interface driver usb-storage
> > > > [    0.441367] usbcore: registered new interface driver usbserial_generic
> > > > [    0.441369] usbserial: USB Serial support registered for generic
> > > > [    0.441383] ioremap error for 0x3f799000-0x3f79a000, requested 0x2, got
> > > > 0x0
> > > > [    0.441518] ucsi_acpi: probe of USBC000:00 failed with error -12
> > > > [???]
> > > > ```
> > > > 
> > > > 1.  Are the ioremap and ucsi_acpi error related or is a separate report
> > > > needed?
> > > 
> > > The ioremap error is what causes ucsi_acpi to fail the probe call (-12
> > > is "out of memory".)
> > > 
> > > > 2.  Do you know the reason for the ucsi_acpi error?
> > > 
> > > the call to ioremap failed.
> > > 
> > > Does this device really have a working typec connector?
> > 
> > Just to avoid misunderstandings, no device was connected to the laptop
> > during my test.
> > 
> > But, from other boots, the Dell docking station TB16 kind of works with it,
> > so I???d say the USB Type-C connector is working.
> 
> Ok, good, this might just be the acpi tables not set up properly for
> this type of connection.  Odd that the tables show it should work,
> Heikki should know more about this.

The firmware probable has not implemented UCSI on this board. I think
Dell always supplies the ACPI device node for UCSI in their acpi
tables. The _STA method in that device node is then used to inform the
OS if the interface exists or not. The return value for _STA comes
probable from BIOS, so this is most likely a BIOS problem.

Please note that UCSI will only supply status information to the
operating system, so the USB Type-C ports will function normally even
without it. The ports are handled in firmware on these platforms.

Paul, do you have the latest BIOS?


> > > Does normal USB devices work with it?
> > 
> > Sorry for being ignorant, but could you please tell me what normal USB
> > devices are?
> 
> If you plug a USB typeC device into this port, does it work?  A docking
> station is a little bit "different" in that it usually uses the PCIe
> connection, not the USB connectors.  Or at least that's how my Dell
> docking station works last time I tried it[1]
> 
> thanks,
> 
> greg k-h
> 
> [1] When the power supply for the docking station is bigger than the
>     laptop's power supply, you begin to wonder what is in that thing and
>     stop using it after a while...

Br,

-- 
heikki
