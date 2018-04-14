Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2106243-1523713737-2-1867009068084487281
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523713737; b=QCAAyY1mL1Mrm+pm6dFk+nO2LLQ4q0h0/T8AF4Er7JTmarni7V
    C/9qK2wPULscCdgaYyg/JQkpNXgaEHkegNKxQ15+q8y+Sma5/vEvlzSdH6YnRzV6
    GtaSjxg4BBUpF3PXGy1d/I4s0KyUK2+WcofvYZQCBdVE4KqR4YSMzOXVvy6UuNBj
    kFLdww4K0obQPEkY54a+6iFX5LNs0BBly6aj/C+zMwXCt70BkN91H+klmIYsFDTi
    N1U6bsbTuqZEnrAevkaqnC27LMnVBx77/8apyd6HzC1vBz5igV2xU251AvUq5LW1
    Ip+2+aoY14xvB/T3sAkPqXltNL5m/OyJajrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523713737; bh=wZ1fWzxR7mpurxwebLdhKgzTOkLwOU
    sGqj1LwqGJziE=; b=N08qztIBNdHUEqBXsjaVOBcSo4zLTVloaOgJfek5riLeNa
    w81WNi4kUGgFxYIYZW21c4ZsY0M1OAEui8hgonPERZiaNp05DhRlHHQhAs9LUVCG
    lLKmkBAQl80NC6uwZPcXUHYdMcXiK5ZWNvt61wRyNRxhvgh63TcJIGGC1S/ISuPN
    ZHs8x7J2zPjnDCx55UH9lx+Bpjj/pBXlKC4TF1k1H5kKUGMCc+Ax4wurdV0ihD8n
    7ummf0SnPRIraVcWOspBcHyjNI6YIo4MXRWpmrnK6vcmFeAHWtykJtF3+72cdohy
    lqAW+Q+hDgEOOD3E7GAW4urAotsnUJNLA2L87Bug==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHja9sVG1icwmT7Fj75Yi+3rgIZPvc9DDN78oVnBhRsO8xy/Y0Cqgrb3pubbAaeLwT6yszrstrMP18TblgPwYoO8tEf0Hc7+ceMljbMh0GSwZ3wgQM5T
    QgeC2fslaKGi2Ibn6w7XdLMEAfIStFgsid5hBAiN5eF0AmBLXiZez1zA8xrXN7tX7H808N5EyWtAZzA0KHtj5/WgP8Y4tnkrb/vmJdfpk+VnApCVlwDAQzIB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=1XWaLZrsAAAA:8 a=LpQP-O61AAAA:8 a=Nja1KH_pl1zFA9gb5KkA:9
    a=EQvkpSDWe1rQJqji:21 a=P-7isGxgqr1950Y-:21 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbeDNNsl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 14 Apr 2018 09:48:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeDNNsk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Apr 2018 09:48:40 -0400
Date: Sat, 14 Apr 2018 15:48:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: Greg Hackmann <ghackmann@google.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "xhci: plat: Register shutdown for xhci_plat"
Message-ID: <20180414134830.GA24944@kroah.com>
References: <20180413002951.155762-1-ghackmann@google.com>
 <F4A1736F-B00A-4EA6-94CD-BCD6CC7758C3@gmail.com>
 <20180413062128.GA22147@kroah.com>
 <663D81E0-C7F1-42BC-950C-803E508BD4ED@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663D81E0-C7F1-42BC-950C-803E508BD4ED@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 12:34:00PM +0530, Harsh Shandilya wrote:
> On 13 April 2018 11:51:28 AM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >On Fri, Apr 13, 2018 at 08:12:31AM +0530, Harsh Shandilya wrote:
> >> On 13 April 2018 5:59:51 AM IST, Greg Hackmann <ghackmann@google.com>
> >wrote:
> >> >Pixel 2 field testers reported that when they tried to reboot their
> >> >phones with some USB devices plugged in, the reboot would get wedged
> >> >and
> >> >eventually trigger watchdog reset.  Once the Pixel kernel team found
> >a
> >> >reliable repro case, they narrowed it down to this commit's 4.4.y
> >> >backport.  Reverting the change made the issue go away.
> >> 
> >> Are you allowed to make the repro steps public? I'm writing this from
> >> a walleye and would be grateful if I could test for this in the
> >> modifed tree I'm running atm.  -- 
> >
> >I was told the steps are pretty simple:
> >	- reboot the phone a lot
> >eventually it will hang.  There's a fix in the code aurora kernel tree
> >for this that they never sent upstream for some odd reason (they sent
> >the first patch, why not the second?)
> >
> >I'll go revert this for now, thanks for the patch!
> >
> >greg k-h
> 
> That'd make sense, I only tried rebooting like five times before I had to run for a class.
> 
> As far as CAF is concerned, I feel the not submitting upstream,
> working extra to write patches which have usually better variants
> already upstream, seems to be common. All USB changes were dropped
> when they merged kernel-common into msm-3.18 with no real explanation
> which has been an annoyance more than once during merging -stable in
> my fork of msm-3.18. While I understand their situation of maintaining
> upwards of 5 million lines of code not upstream, it still feels sloppy
> to not merge stable updates and do extra work instead. /* End rant */

CAF fixed this back on Feb 1 in their tree, yet did not send that
upstream, or to anyone else:
	https://source.codeaurora.org/quic/la/kernel/msm-4.4/commit/?h=LV.HB.1.1.5-03810-8x96.0&id=a7a5307ee04ad349d365ad50f304605a9cd9bd0a

Feel free to rant some more, I'm going to go revert the original
upstream patch as that is half-completed, and obviously broken :(

thanks,

greg k-h
