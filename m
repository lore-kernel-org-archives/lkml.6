Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-46781-1519173378-2-9770524184931340219
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519173378; b=kpdTAlc97aWIoM2AYPzsDoL0hf5GxRl11pJV4c0xSI648vT
    fmRUJHJ3IeTtVkfCunCSSOZRFf6iQEKHoM0+4T+zGltTyRg4jTnMoQV7yzh41777
    95emb5O5AdkQgfIY576ZvuZLhZgv/jNVx/somsOVt96IDkPomdLNCKAW7nYQa/Ku
    YMv6ABE0+QBqwavq2UAFDmRwNkiltQPUdO1kSj++Fj/XJOttKSjCdzd6DMIw6u1m
    wczuJoWstHOPzp9rFSW/C8xia2JmQzNs26x0pykhv728neHQ2qK9o93YmMwh7FFh
    KfUztpzK7Lrihfnbgez89lvYHt4VSqkJ5ARLQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:to:cc:references:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519173378; bh=PCyBYJt72mShEQe8/ubFRMcetOKK3q8C6FHfUXWIa2c=; b=b
    4Z6RC2LWX62xKuwOu6fQSpKkMcho5NOasTrFnVDdhr5IyyJVtSrhcDCE0Tq77rIS
    WsG5zPTaqMtdmVqsfrGhHgdMwbAO7ZoJFpqaXzLoCmPArtMRv2JdLHl9SW2S7ujS
    sKwhVJ2BGILteyz1ZPyX/781oLYbLZrCRpw71w6UVNVgOpYyDYnCv4bgyMiX4bAt
    26XWD80rwjoB2Rj4eJA50a9pbDAReenMJHzmzBqprGWmGIocnEU3a4Bin26YxwBV
    bsY9SD5Hr8ooFr601lv2WS8X7fhorvHTX6Is4rouswRm9XRbxWhqWDCAFIadp6sx
    xSZCx/p+VSWAr1EouYQ6g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbeBUAgE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 19:36:04 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:39694 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeBUAgD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 19:36:03 -0500
Reply-To: shuah@kernel.org
Subject: Re: [PATH 0/4] usbip: make vhci_hcd.* objects independent of
 vhci_hcd.0
To: Salvador Fandino <salva@qindel.com>, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, valentina.manea.m@gmail.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180130083630.26501-1-salva@qindel.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <391a54d5-73ac-3bd5-49ca-114639ea69fd@kernel.org>
Date: Tue, 20 Feb 2018 17:35:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180130083630.26501-1-salva@qindel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Salvador,

On 01/30/2018 01:36 AM, Salvador Fandino wrote:
> Let me start by explaining the problem that have motivated me to write
> this patches:
> 
> I work on the QVD, a virtual desktop platform for Linux. This software
> runs Linux desktops (i.e. XFCE, KDE) and their applications inside LXC
> containers, and makes then available through the network to remote
> users.
> 
> Supporting USB devices is a common feature customers have been
> requesting us for a long time (in order to use, for instance, remote
> signature pads, bar-code scanners, fingerprint readers, etc.). So, we
> have been working on that feature using the USB/IP layer on the
> kernel.
> 
> Connecting and disconnecting devices and transferring data works
> seamless for the devices listed above. But we also want to make the
> usbip operations private to the container where they are run.  For
> instance, it is unacceptable for our product, that one user could list
> the devices connected by other users or access them.
> 
> We can control how can access every device using cgroups once those
> are attached, but the usbip layer is not providing any mechanism for
> controlling who can attach, detach or list the devices.

Did you explore a solution to add a mechanism for access control to
usbip?

> 
> So, we got the idea that in order to enforce that remote usbip devices
> are only visible inside the container where they were imported, we
> could conveniently mount-bind inside every container just one of the
> vhci_hcd directories below /sys/devices/platform. So that it is as if
> every container had a vhci_hcd just for itself (and also, we restrict
> access to the matching USB ports in cgroups).
> 
> Unfortunately, all the vhci_hcd.* devices are controlled through
> attributes in vhci_hcd.0 making our approach fail and so... well, that
> is what this patch series changes. It makes every vhci_hcd device
> controllable through attributes inside its own sysfs directory.> 
> The first patch, does that in the kernel, and the second and third
> patches change user space, adapting the libusbip and the usbip tools
> code respectively.
> 
> Then there is a fourth patch, that allows to create much more USB
> hubs per machine. It was limited to 64 and we are running thousands of
> containers (every one requiring a hub) per host.
> 
> These changes are not completely backward compatible. In the sysfs
> side, besides moving around the attribute files, now the port numbers
> go from 0 to CONFIG_USBIP_VHCI_HC_PORTS * 2 - 1 and are reused for
> every vhci_hcd device. I could have maintained the absolute numeration
> but I think reusing the numbers is a better and simpler approach.

Not being able to maintain backwards compatibility is an issue. This is
a considerable change to the user interface.

> 
> I have considered that until very recently, support for vhci_hcd
> devices above the .0 was broken in the uspip tools (see
> 1ac7c8a78be85f84b019d3d2742d1a9f07255cc5 "usbip: fix usbip attach to
> find a port that matches the requested speed") and that has been the
> place where I have set the bar for backward compatibility: usage of
> the tools must remain unchanged for accessing "vhci_hcd.0", but may
> require changes otherwise. The same is true for the library functions
> which now provides new functions for selecting the target vhci_hcd
> device. The old functions now always target "vhci_hcd.0".
> 
> So, for instance, now, "usbip port" by default only shows "vhci_hcd.0"
> ports but "usbip port -a" shows all of them, and, for instance, "usbip
> port -i 4", shows the ports in "vhci_hcd.4".
> 

I am going to play with these patches and how extensive the changes are
for users. In the meantime, maybe you can explore alternatives that don't
break backwards compatibility.

thanks,
-- Shuah


