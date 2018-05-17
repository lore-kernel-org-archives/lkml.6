Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1793992-1526547273-5-1513269126675344569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526547273; b=DoOOhyuQbyZ+b1XnQvJ7X8RQDXsG0w4zpj3vDlV4hf6wBwFgRE
    M2+QrVU0dlmRFXv1jGT9htc76gDz12qVR8klxrYpzMwOoRUsCnwIg3iCgOpAttoD
    GpLHT0azkrl70Yj8Pbx7vn3FMrxamYmnZ+gCZDbHnmQs0vEzvakA3jZPRXJNG2uJ
    Ppk+XIt2N4rhdIeHpdqlszMNu5n66veRMQ7lJVm2iaPpTD/HFBQG6V5XWAVPdhZg
    DsFZrucK5RNYL2tUGvcGoqvpIPHUXkjz3QRkTlH52Yt/jxj5t1mBGL2+ybI4FgXZ
    D8c/zQ+rAhYvkfRingjrnS8gkpuZIfWPZj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526547273; bh=Qns+h1/fzVh
    CPUxZkTg8TzEry8ZoIKovfIbTRPu3ees=; b=jI/BhpBo84nRXAt8XXs2drPGig3
    h2o/tb0+YiyCfONA895ii7nmrWo3OcYI/hm8bMMVjlIyH0uNXh3oMZsxmTBkSSl5
    lF8NZR878KYttjhQ+LNfuLq7kNHqAPfNVY6fx5HZ1qV7iZQliYhc3PeQKT0bMp+w
    vI8aX2D0/MxUkp2vSiW1Jouv/Zkc/34pQnssbzTlvHjUPiOC/kJw/yJ6qIGsSbvu
    vZDH/EY6TBsYk+J3FUCQ1S/8w4fglvBTK+WInfS+iqlGzwLAItXaY8nQM0u9bgMj
    cDXEWlPMRnF+smPo2Qw8jTig2VuYbIQOSd/AxDreGP1u5GgyAaZYvuBQD6A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=vUSJqf/G x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=vUSJqf/G x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLB5YyJncdG33vRGSoPE2RMsV45yrZTYuZpkJr4CQBopVtp1+Zyb3vvQSU73clDxunSxAmzI+xOc8/9w0KdcdVwMxM4S92VeddzCmvBDQkErCgkxi4bp
    hY/sSmlFkgpX04/9/QG9+3bg9dWxVBqeeT5oP9HhLBczI/r6AHvnrwOgAI1NVa0fpqOKHPL3BFmAHjAPHzabfy6ePxVCNl9BRFywUzfgDFNgSAGgerLBiW69
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=JQ2z6HDQrcEiCfJZzCoA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEQIyY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 04:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbeEQIyT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 04:54:19 -0400
Date: Thu, 17 May 2018 10:54:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+8e62ff4e07aa2ce87826@syzkaller.appspotmail.com
Subject: Re: [PATCH 4.4 53/97] ALSA: pcm: Fix UAF at PCM release via PCM
 timer access
Message-ID: <20180517085400.GA25318@kroah.com>
References: <20180422135304.577223025@linuxfoundation.org>
 <20180422135308.244077643@linuxfoundation.org>
 <1526503907.9159.150.camel@codethink.co.uk>
 <s5h36yr9rrg.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5h36yr9rrg.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 12:09:55AM +0200, Takashi Iwai wrote:
> On Wed, 16 May 2018 22:51:47 +0200,
> Ben Hutchings wrote:
> > 
> > On Sun, 2018-04-22 at 15:53 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Takashi Iwai <tiwai@suse.de>
> > > 
> > > commit a820ccbe21e8ce8e86c39cd1d3bc8c7d1cbb949b upstream.
> > >
> > > The PCM runtime object is created and freed dynamically at PCM stream
> > > open / close time.  This is tracked via substream->runtime, and it's
> > > cleared at snd_pcm_detach_substream().
> > > 
> > > The runtime object assignment is protected by PCM open_mutex, so for
> > > all PCM operations, it's safely handled.  However, each PCM substream
> > > provides also an ALSA timer interface, and user-space can access to
> > > this while closing a PCM substream.  This may eventually lead to a
> > > UAF, as snd_pcm_timer_resolution() tries to access the runtime while
> > > clearing it in other side.
> > > 
> > > Fortunately, it's the only concurrent access from the PCM timer, and
> > > it merely reads runtime->timer_resolution field.  So, we can avoid the
> > > race by reordering kfree() and wrapping the substream->runtime
> > > clearance with the corresponding timer lock.
> > [...]
> > 
> > This seems to depend on:
> > 
> > commit f65e0d299807d8a11812845c972493c3f9a18e10
> > Author: Takashi Iwai <tiwai@suse.de>
> > Date:   Wed Feb 10 12:47:03 2016 +0100
> > 
> >     ALSA: timer: Call notifier in the same spinlock
> > 
> > (But I'm not totally convinced that snd_pcm_timer_resolution() is
> > always called with the timer lock held, even after that.)

Good catch, I'll queue this up now, thanks.

greg k-h
