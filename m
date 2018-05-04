Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3900284-1525419372-2-6983737619280913038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525419371; b=DSJ0nUCS8I67BCsIhGbMGXCIGxcbOVIGW8orpUuaUcZWu/4wJP
    qTzvXChslEQqKHDD5BJDyUSXdxnsQ8hdFPfeR/kLsvekk9kCT1fJTuiyXdfoEYcM
    9hffs63CIEIkoxSBwZTDbWQAeS2utYggz3zgPJgVtlV1avWSFD00CrNA1RYfPt22
    6h+Ah9uaI/NhAxqhMs7GGH0P37pzIyGQbGWcuJD5tC8B6PhzcvZSZgXKfNG62SxZ
    22Nu6HfRfiER3siwOTcckn6eg/gtDJLgPJBBHeifa6DnD+hj1Qkb4MUw4lUZOMpK
    Kniz41hASKvzRPPZyBsL2EVy5hOns2O6dwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1525419371; bh=gP7tlMLh9
    q2GlMeI9wbGbSwYfG1h2youDfXTq4chMtc=; b=QWQKahUVtigSXITQzAPE9U011
    /U5PcdfGBU52yDLnJVWFwpdQjaXABrO52P/MWf7uZ4tbgNnf6BrKRZvxvmDzqWzM
    CURW2TBJqn410yW6dfieFazPSdmWko3zqKbFeTz3ekv3FbCIf/0rSF8o0dmZSAjX
    7YvSXmYlNznGGPAICamJ28t9l4J/TG0Qn8goazo14z8KmqZfmlusA0CnSywQ0Awq
    efmZmkLe83+0t3+nteWfbiaIe1ahiKSXz2OOP3TrsVsHVk3uZLjBb81JAmx+5Ke2
    krvhDKMR2/nmlba+iVxmXRIB72OrCpZl7O92ABAQHUnxiwvIJg/4c9gaRNh5w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=fiYwaLX7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=fiYwaLX7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGYaEu21uoKgIUxH9EXHENjaasuvQ6y+wz6ARa6wv6DmK/UVUjNBRaEdGe8ydiDvU2plRAjLbzgtAkz0bqZDV96IJFeUJMro74DI50ls6YZ0dQhFpL3v
    fqi61Rb0nKi0LhBz/ejUGpIVIghEiYCEoKh5iTNqUR/r5IWInXGyfr6vE8l9ZmVU2GnTwO8UY59vDZHFfJygaC9/yRMIfha6FgFGKoZ5rce2Q49TJgBskSlC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=p-nOP-kxAAAA:8 a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=1XWaLZrsAAAA:8 a=O8VsJjXCY-HYt-ho1OIA:9 a=CjuIK1q_8ugA:10
    a=XN2wCei03jY4uMu7D0Wg:22 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEDHgJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 03:36:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56029 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeEDHgJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 May 2018 03:36:09 -0400
X-Google-Smtp-Source: AB8JxZp0qdwbBd5f6SEYAxZOdzB24DBgD7r1q1X65UB4ULsQtl1YRZSa5mwvRYYBSLKI9xOVOSqBRA==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1772514.uJjIhrptf1@aspire.rjw.lan>
Date: Fri, 4 May 2018 15:36:01 +0800
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2A1C2E74-BC05-48B5-A4D4-DEDBFD797D53@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com>
 <10732937.eAR6mAEfiz@aspire.rjw.lan>
 <20180426135545.GB225403@bhelgaas-glaptop.roam.corp.google.com>
 <1772514.uJjIhrptf1@aspire.rjw.lan>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rafael,

> On Apr 26, 2018, at 10:36 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, April 26, 2018 3:55:45 PM CEST Bjorn Helgaas wrote:
>> On Fri, Apr 13, 2018 at 09:29:56AM +0200, Rafael J. Wysocki wrote:
>>> On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
>>>> Hi Bjorn and Rafael,
>>>>
>>>>> On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng  
>>>>> <kai.heng.feng@canonical.com>
>>>>> wrote:
>>>>>
>>>>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
>>>>> core: Drop run_wake flag from struct dev_pm_info").
>>>>>
>>>>> The device in question is not power managed by platform firmware,
>>>>> furthermore, it only supports PME# from D3cold:
>>>>> Capabilities: [78] Power Management version 3
>>>>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>>>>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>>>
>>>>> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
>>>>> After that commit, the device gets runtime suspended, so it does not
>>>>> respond to any PME#.
>>
>> Apologies for my lack of PM expertise.  I don't think the device would
>> *respond* to PME#, would it?  I would think the device would
>> potentially *generate* a PME#.
>

Do you want me to send another version with updated commit message?

I can also split it to two commits if you desire.

Kai-Heng

> Right.
>
>> And I guess since this device can generate PME# only from D3cold, the
>> implication is that runtime suspending the device may put it into D1,
>> D2, or D3hot, but not D3cold?  Is that an axiom of the runtime suspend
>> design?
>
> No, it isn't.
>
> Runtime PM is expected to only put devices into D-states from where they
> can generate PME.
>
> Before the problematic change it would just hold the device in question  
> in D0,
> but after that change the device will be suspended (in which case it will  
> end
> up in D3hot which is incorrect).
>
>>>>> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
>>>>> device_can_wakeup() in pci_dev_run_wake() always returns true.
>>
>> I think "mandatorily" means "always" or "unconditionally", right?
>>
>>>>> So pci_dev_run_wake() needs to check PME wakeup capability as its first
>>>>> condition.
>>>>>
>>>>> In addition, change wakeup flag passed to pci_target_state() from false
>>>>> to true, because we want to find the deepest state that the device can
>>>>> still generate PME#.
>>
>> Is this a separate bug fix?  I don't understand how it fits in here
>> because the wakeup flag means "Whether or not wakeup functionality
>> will be enabled for the device", and you're not changing anything
>> about whether wakeup functionality will be enabled.
>
> For runtime PM the "wakeup" argument of pci_target_state() should always be
> "true", so technically this may be regarded as a separate issue, but this
> change is needed as a functional fix for the device in question along with
> the reordering.
>
> Since technically there is a state from which the device can signal PME,
> device_can_wakeup() returns "true" for it, but this isn't sufficient for
> pci_dev_run_wake() to return "true" (because that state is D3cold and
> the platform cannot power-manage the device, so the device cannot be put
> into D3cold directly).  That's the first thing that needs to be changed.
>
> On top of that, we need to look for a state from which the device can
> generate PME.
>
>>>>> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct
>>>>> dev_pm_info")
>>>>> Cc: stable@vger.kernel.org # 4.13+
>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> ---
>>>>> v3: State the reason why the wakeup flag gets changed.
>>>>>
>>>>> v2: Explicitly check dev->pme_support.
>>>>
>>>> If this patch is good enough, I am hoping it can get merged in v4.17.
>>>
>>> OK
>>>
>>> Bjorn, if you want to take this:
>>>
>>>  Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Otherwise please let me know and I'll queue it up.
>>
>> de3ef1eb1cd0 went through your tree, so I think this fix should go
>> through your tree, too.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> OK
>
>> Not directly related to this patch, but I think these comments in
>> pci_target_state() are slightly misleading:
>>
>>    * Call the platform to choose the target state of the device
>>    * and enable wake-up from this state if supported.
>>
>>    * Find the deepest state from which the device can generate
>>    * wake-up events, make it the target state and enable device
>>    * to generate PME#.
>>
>> AFAICT, pci_target_state() does not actually "enable wake-up from this
>> state" or "enable device to generate PME#".
>
> Right, the comments appear to be stale, I'll send a patch to update them.
>
> Thanks,
> Rafael
