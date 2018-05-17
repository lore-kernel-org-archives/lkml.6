Return-Path: <heikki.krogerus@linux.intel.com>
X-Cyrus-Session-Id: sloti22d1t05-2184840-1526565498-2-8662560773668232207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='134.134.136.24', Host='mga09.intel.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: heikki.krogerus@linux.intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526565496; b=kJ8H9KRovOGPJ7xteghSqIUJzjkCN8VLD4pSsEX1Aw3v8qGfVD
    z5iMvV6UCK3xhDcNqffkqBG1K9vL2pRLXRbNmRS/A0ikfQbndoiltk8h70vB6ROP
    gQ/kh5HhTyp12V0EixKBNUaV4RFpbxVW7IQHR1UvK0pelhNbzA7uaJzPuPLgEP+o
    NIXDmUWuH27TJk3ABF9F4he9LG81iuvqY4l2PqUBKsTVNrM2LPoG3xIGRqxkF7iP
    HqNhHIOSY/zBKg/9lAcB6WPuttMTAH+xoXuXtWKTiRsHTUbTmQwT4eqlPlGYcInf
    e1DVXJKtYyM1HSfkblbAXBD5rRaH5xm+9AJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1526565496; bh=jrudEtUFmshTdV+P0O2DVI/thzCVp0z0zvPRqolcoM0=; b=M
    fgFtSuk6Dktaml28Qgd91dmuHDbHOb+nf2K4T2y4rU9IPIoDKBR6juxG0o4100yj
    hAeherIGcVbIMejDgBkGbDdNOUGqzCVsPaoenmy1YkLBp0UdTSBRGum3Dt7txtgS
    bJhoi/l3e2w4Dj4fVlDRMVUmmrgQrya9ASG3Q3CIb8gfON2wfQwn+RqqRFCEpcnq
    wh6h1xJ9M2WMZX/UCDDtB7KqJdNjBwaFaSlWzDdqhAa3xo8TagyqlG8f6aa1i0AD
    J0+EukKOswCUwZWGKEP0+W6vBtPm1DfcLm2wPeykHxlXkubQ3b1YGfelQZQ6q85r
    7C0Gg1zBend2aH5QDAqlw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.24 (mga09.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com
    smtp.helo=mga09.intel.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga09.intel.com x-ptr-lookup=mga09.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass
    smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.24 (mga09.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com
      smtp.helo=mga09.intel.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga09.intel.com x-ptr-lookup=mga09.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass
      smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLxpCbM6baSZTCMYwnBeIzOlrr82gyumJmKiu6zivF0InSkIEjvsJFvJkYL8onxHtHZO78nYvhZJVHJSQU2MydDlnfaAtkgMPJz5FsuKZGmJ4crkkIJC
    lXavwOLGP7fyeuDA8vJIBxJxrX31jFE/GuixwWe8vy/mlaHtXh1hYUyJIxiHeahbNkFkEtJlkcCHcOejyn2Qunul9n6SQVMomZQ=
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=NbiJzzs714t695yxpfMljw==:117
    a=NbiJzzs714t695yxpfMljw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iLNU1ar6AAAA:8 a=MdHgQ7hJP3j2gb_iERoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,410,1520924400";
   d="scan'208";a="56104192"
Date: Thu, 17 May 2018 16:58:09 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Mario.Limonciello@dell.com
Cc: greg@kroah.com, pmenzel+linux-usb@molgen.mpg.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Message-ID: <20180517135809.GG11469@kuha.fi.intel.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com>
 <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
 <20180517085930.GD11469@kuha.fi.intel.com>
 <91a3c211cc8547ccb8eab844abd3b095@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a3c211cc8547ccb8eab844abd3b095@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mario,

On Thu, May 17, 2018 at 01:01:20PM +0000, Mario.Limonciello@dell.com wrote:
> > > Heikki,
> > >
> > > I confirmed with internal team that UCSI is implemented on XPS 9370
> > > and was confirmed to be working properly with Windows 10 RS2+.
> > 
> > Just to double check: "UCSI was confirmed working properly", so not
> > "the Type-C ports were confirmed working properly"?
> 
> UCSI was confirmed working properly.  FWIW it's a certification requirement
> in Windows.

OK, thank you for confirming that.

> > > The reason that _STA is responding on this device node now but wasn't
> > > previously is it wasn't exposed in Linux until 4.16 when the Win 10 RS2
> > > OSI string started to respond.
> > 
> > OK.
> > 
> > > Intel should internally have some XPS 9370 you can remotely access if
> > > you would like to poke around ACPI tables some.
> > 
> > I will try get access to XPS 9370, but with the acpi tables, if
> > somebody could just send me acpidump, that would be enough:
> > 
> >         % acpidump -o xps9370_acpi.dump

I now have the XPS 9370 ACPI tables.


Br,

-- 
heikki
