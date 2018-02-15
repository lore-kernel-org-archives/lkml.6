Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2077773-1518716119-2-17403548892721072780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518716119; b=Gf57FIpQwOurR/o2nvjHsreEq8ZabKWPFDjVeyF00woTRyT
    lR78XjBA4f6SDsRW/dDbmSU25SUzYyYDnsAAwz2lGe7wYkFcqmA56Owi1Q2WdT6K
    dAAykM3FHpqkr4gwyAL4VuwPC7hk2IdWLGpaidZCcbDc6jEBtOfOd2sn9H34VVeQ
    u7sJQ/GHGEU4cpjUbbnlO51WZIMsQsNe3tU7JBbkKbhDo/ODxG45BkH8SrUyhCuT
    R5NACiMbRZ4RyjZfegROYEK/b4902c6/7SAWqaLVSC2DV6jc8GntXcp2H9Dcjpo6
    W5SdVT4StqaCE9Kl58KSm9XvqjycHq39uWE8hmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518716119; bh=TQYqbr8YtfxnsfYXWPJ7krgsf2
    +OUDHK+XMx5T1T4P8=; b=AnZvRZx9Wz8P4qiwr8n1ULfm4Jm2sb7uACn7Z+9N0B
    f6e3rYczp/dX9CDbP+ye64uM1kGQuw76K1IUal8i0v4N31nIUhReDatLMZnykMbV
    3x2REtL1hMlg3Upa1p68IBSZHv68HYYnyPbNwfkn16R2TDdP18PUoeNxuUxkbKId
    qHv4HvkmSjwlMOMRx658V6RJnA+7lSzLAzd/puuKI1qGgJOMye1ykyW/r/QWf7RB
    c5iJ1vi13ad0yKmEMg1dADGluq3EUi4gOvRnNA2reuTXlhjffu93QWIao3mLw8EH
    gBetqpsLg+JBzGDHG5kLULDc9LxIof6YOTprhae6suqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427362AbeBORfC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 12:35:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427356AbeBORfA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 12:35:00 -0500
Date: Thu, 15 Feb 2018 18:35:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: JackStocker <jackstocker.93@gmail.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dmitry Fleytman <dmitry@daynix.com>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Sandeep Singh <sandeep.singh@amd.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add delay-init quirk for Corsair K70 RGB keyboards
Message-ID: <20180215173500.GA11409@kroah.com>
References: <AE53BCA5-F49A-41ED-B6F4-1B5FF8B4391F@canonical.com>
 <1517763059-9334-1-git-send-email-jackstocker.93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517763059-9334-1-git-send-email-jackstocker.93@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 04:50:58PM +0000, JackStocker wrote:
> Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
> Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
> start correctly at boot.
> 
> Device ids found here:
> usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
> usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 3-3: Product: Corsair K70 RGB Gaming Keyboard
> 
> Signed-off-by: JackStocker <jackstocker.93@gmail.com>

I need a "real" name here please.

thanks,

greg k-h
