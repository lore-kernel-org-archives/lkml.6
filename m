Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2697678-1517843802-2-8003435596012891126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517843801; b=vk/9w6N90IauCgzwORC85BoUpb7gmICqiA/MBMj+Iq51spj
    e++7Zj+oRQQWj7VL2eJXyeNkNAIN55i4xuIAKSkND7yW2EpjTpky8Gm0bt93xPoc
    EKMVJBohXJB8SXYFhIY24BO8UCVaObbDd7iUKw/LlQNgfbWMxqIi05Aw4lyDcwzZ
    kSjildB+mBke8l6wwqZzYyNwl1kK/uq+s2f+w9GerSPKa4FbPMkT20nUw1kA8GuU
    gqPyYPRxlVmBsZG5gO78RdftP3gNVRj3WfbWNZbfUbxde85i0PkTapgxMQ8F4cdp
    YDduu6Qau0XYinvnJPC2ot6j35dlVQ16l5koPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:to:cc:references:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517843801; bh=8fAJC9dvMcYJuaUhljK5IG9l6zqvk/qRQGvE6B76WWw=; b=K
    ewNfEZ0Y2veiZ91lcF91bATm8hBqD84AZlibzYtMFB3WBmYxAOAdYkd16A1SwYX6
    S61Hl/aP58XAYc68HKQskllAwf4hoqCKovKTy/4fmN+oYxAXx+CBry6Aei0yApAs
    Pt7XuDOWAY3Q0aXBZaaM63fu2rSDll8Bn/oP4q93G4/3tdQxN4o5N4tvOajxK9jn
    tQg4+4YP2ZnbpN9QgP6EPZ6MMe9nzzWNij55wEo+fYyqYa5skobMGZKSz/m9zqtO
    YKY9kosXcLhgkvBFS3YMyz0quv+1Qjf/fyg9xE/bKtzyj+Sb+fQzfdv1RBEis3vB
    1xYfo/TV6MPyBn0u5PBNA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeBEPQg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 10:16:36 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:45564 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbeBEPQg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Feb 2018 10:16:36 -0500
Reply-To: shuah@kernel.org
Subject: Re: [PATH 0/4] usbip: make vhci_hcd.* objects independent of
 vhci_hcd.0
To: Salvador Fandino <salva@qindel.com>, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, valentina.manea.m@gmail.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180130083630.26501-1-salva@qindel.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <de022e9c-c42b-9af9-b118-6f7de336dc66@kernel.org>
Date: Mon, 5 Feb 2018 08:16:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180130083630.26501-1-salva@qindel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
> controllable through attributes inside its own sysfs directory.
> 
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
> Cheers.
> 

I will take a look at these in the next week or so.

thanks,
-- Shuah

