Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3452210-1525817691-2-13063088857700444477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525817690; b=SJsOKlnS9x9aiHHe1cfmgA9nf/u48jHzfnrXOqZW3kKMY/+icp
    gVEBtl5PJIHwGgkV5+s9n1MZUyTqj+QBDX/n8J9d3F02yPZruzHooht44d2+je70
    wONz/ohCYohDrioMLSEq+2ka7qd7RLq4gdYqSi+/wf+6MMAuWhOqYKAO9DqdIREg
    hoNRhayZPKmiIJg27dGgFkrqUR+nVcqfkU6PN3Q73xLH+6mU/4K1oJWvhF2qBdXT
    epa6hJpwsG0TCD5wIGeoeH4JORRrc/nXEc9mJzUgL/ud49q+prA3OL2daN4ML3lQ
    fRgMJO0pAGMRHaPg80q/E9CNVS8wvHJ2CAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1525817690; bh=7LtGWiyZkQ
    VmApG3bUcORJl1BPzVunaReD99yloeoQU=; b=c5q+BVZUUU0laBcpkBuRd6pI/x
    C0ggHho2RHwY7tkk5kvouiribTMPgi1pBYwSsadYy+uqx3DiDpOsyqMQe23EAiJy
    jtozEOjgTbfYbfgCw9LoW2V04B64sHeCd1Nb7Dkhoq4z7CaoyCXx1XEB2VHTQgT+
    zduvYKRdCG4T5eN6OURuJjVe5F3IC8aezjz+LCHqq3VpiEg42mqpdkigSHYRd7Da
    PWSXgxsFLqOUfopJjN3DDs9OYIW5gTW/be45QZqvjKM5eGEnVl/r0hjsntFes9jN
    cgajS6MXDitNI56xCp8FfXIBEUf3Xi0KTNg7jIrFX2+a1Gc37FIawHa5Pd1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rjwysocki.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rjwysocki.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBiNWyaB3HX4H/q73ZIW7jdO1cMaMKXynf7bJVg0j15urouIvbDPShW5y8L7FdkHYlfuPd8Ya55LtssFK8yh08O8U6D19FDyNDLK4MdkNydt0k2kFO85
    DXayLdgArQocxMLhMHKY4zTlmgwNhRHnXpe92QZglgExiYFAMZAHzGacpbE3iD0d5z9x8NuXAl8/uPnzBJk5FKyybE34gIiNYxf7rcy1DbjMq+beybhcLQhf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8 a=1XWaLZrsAAAA:8 a=EgrqCuNXr_ySHYQmKWwA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbeEHWOs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 18:14:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63400 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755489AbeEHWOr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 18:14:47 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Wed, 09 May 2018 00:14:22 +0200
Message-ID: <11148593.jpbL9ipGSX@aspire.rjw.lan>
In-Reply-To: <20180507214817.GC133147@bhelgaas-glaptop.roam.corp.google.com>
References: <20180507061120.3683-1-kai.heng.feng@canonical.com> <20180507214817.GC133147@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Monday, May 7, 2018 11:48:17 PM CEST Bjorn Helgaas wrote:
> On Mon, May 07, 2018 at 02:11:20PM +0800, Kai-Heng Feng wrote:
> > USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> > core: Drop run_wake flag from struct dev_pm_info").
> > 
> > The device in question is not power managed by platform firmware,
> > furthermore, it only supports PME# from D3cold:
> > Capabilities: [78] Power Management version 3
> >        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > 
> > Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> > After that commit, the device gets runtime suspended to D3hot, which can
> > not generate any PME#.
> > 
> > usb_hcd_pci_probe() unconditionally calls device_wakeup_enable(), hence
> > device_can_wakeup() in pci_dev_run_wake() always returns true.
> > 
> > So pci_dev_run_wake() needs to check PME wakeup capability as its first
> > condition.
> > 
> > In addition, change wakeup flag passed to pci_target_state() from false
> > to true, because we want to find the deepest state that the device can
> > still generate PME#. In this case, it's D0 for the device in question.
> > 
> > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
> > Cc: stable@vger.kernel.org # 4.13+
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rafael, can you queue this up?  de3ef1eb1cd0 went through your tree,
> and I don't really understand the patch, so I'll rely on your review.

I will, thanks!
