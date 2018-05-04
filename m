Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4069134-1525427763-2-2958093576294350526
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525427762; b=LshDHYFUnGQIxqlWRwl4hSUrcbUPse362uEPCz/P8j+fKaCYm3
    utow32/fG0iEABKvB3ThCOB8A0rqDn6GDMyCPaflnKpgB5cn9cJs/dkaXjse6jV2
    tVn47wVj/A1VQU+WKCrkyhcvZjxQznrJ1J0URSTqQXf1oRQqYKcxYdKWuxsuECCm
    El2iLVSaTqhTRYKRSRs813K5c2F2ui3sxGUmIJb9xz/WyxG8F75pn6E138u8IHRB
    RXL7Cxgv9w7ylPNj/UZCMjjeKPMGLDDQWmnTayTDaneyEgvolXJ+eOzx+dfdCPXv
    cdwRezeRmekx8U59c/nFJ9+dg/N6jYGXRITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1525427762; bh=UNRUOOks0o
    10q7tK5ecvuZt1s1yy64jHCkzsUt1s0v4=; b=GQ1kmRl2kiQxfIDDbUtydcUHPs
    2QlgHO7BtLootNBcv+dnmBR9YF420lSUtRhZdgQV9c0PLClsgDFBZaQCi/orNxCg
    M+bD4bmM5/1ZaGCC7kdUmtmpOIQTplqLc0A3EvNdYlhXEKkR62BCbDAkNjzH/YEq
    SNEaEk/NtMOKQibllQdfS5kN7UHt5iUJg8U1pJFWYsU1frWNv+8QWGkUgIoStMjP
    w7ZvESz7wl/SXWLfKufGC8Se6m/gObmCxmmp+Muaaij56GbuHSGnWN9Lunmj9DM7
    7EoixIidE/Wmf0aIj/I/bVY14eY93QxtHO82taLlhAjHTK6mkU0/+q84tijA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfIAWXjbErg3nsozFKKBUZ/f1/lCps7xK/ick9jtB0vb6dS2k+AFtJik0KlE7jkBaxt7oT3/m8G+352LbjTFi6k3baNdZpTfZ8i3ZzViemYlgpIcDXB7I
    S8Uc8Qhm4zvnZNzurNSLD0IDvzcKN3j4Cg198FiC3EeYb5TxQ3IH0+Kytk77N/L/YowNov51ayHPpG1knTDbWMf0w+WoOoR8d8eRWgVhnejCnvawGXOzORcx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=p-nOP-kxAAAA:8 a=DfNHnWVPAAAA:8 a=QiE8qkGwkVkNpV2-sJQA:9 a=CjuIK1q_8ugA:10
    a=XN2wCei03jY4uMu7D0Wg:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeEDJ4B (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 05:56:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44831 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDJ4A (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 May 2018 05:56:00 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Fri, 04 May 2018 11:55:40 +0200
Message-ID: <2469353.zD9Qx4KGm6@aspire.rjw.lan>
In-Reply-To: <2A1C2E74-BC05-48B5-A4D4-DEDBFD797D53@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com> <1772514.uJjIhrptf1@aspire.rjw.lan> <2A1C2E74-BC05-48B5-A4D4-DEDBFD797D53@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, May 4, 2018 9:36:01 AM CEST Kai Heng Feng wrote:
> Hi Rafael,
> 
> > On Apr 26, 2018, at 10:36 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, April 26, 2018 3:55:45 PM CEST Bjorn Helgaas wrote:
> >> On Fri, Apr 13, 2018 at 09:29:56AM +0200, Rafael J. Wysocki wrote:
> >>> On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> >>>> Hi Bjorn and Rafael,
> >>>>
> >>>>> On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng  
> >>>>> <kai.heng.feng@canonical.com>
> >>>>> wrote:
> >>>>>
> >>>>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> >>>>> core: Drop run_wake flag from struct dev_pm_info").
> >>>>>
> >>>>> The device in question is not power managed by platform firmware,
> >>>>> furthermore, it only supports PME# from D3cold:
> >>>>> Capabilities: [78] Power Management version 3
> >>>>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >>>>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >>>>>
> >>>>> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> >>>>> After that commit, the device gets runtime suspended, so it does not
> >>>>> respond to any PME#.
> >>
> >> Apologies for my lack of PM expertise.  I don't think the device would
> >> *respond* to PME#, would it?  I would think the device would
> >> potentially *generate* a PME#.
> >
> 
> Do you want me to send another version with updated commit message?

Yes, please.

> I can also split it to two commits if you desire.

No, that's not necessary.

Thanks,
Rafael
