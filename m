Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-186549-1520589020-2-3880856111903987836
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520589020; b=QxqWidQcytpOu4Dnz+3Ir97ooH/NIr/EZ4iFJatFAsvHGrR
    UGL6tqEVr1y22NonqZ2uatkm5e/ok1LU7CQilg7NCMKHnBdMkcWMwlegXQrJsHtg
    H1sZMVg+0qCwJO5NdExPFdctLdNRz2y9aKnnT2Vka/Q7OJOZWw0oKLKwvHo8hj8R
    ac2fhCneecsVLI6VLqr4nr+fE3NFlfh7cBG/kohGGVm5DYiov306qKp5RlavYG9Z
    4WGqP5v55vaBpLCQtC4rWzotve4U7PW2sFuMN72gjwn7ZAJyCJnnnG99LvqU5q1Z
    5WCf7F4NW8+W/DFrtKRFBp7miAQ+mFA7wnkY4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520589020; bh=5uEolOCajRFR2Hl7YSzO35mkBJYVjyAkP/qu46l4fvU=; b=J
    tl81ABAVkoIAsrvq+HTZBV/5i3Dm61iWQ00TYiTJIF+t1XsbueYc2d3Hc1vnIPgK
    WqBP4Wz2SwqU17RuhlpA60t3pUTDpvdMy/tnTIrn4v0CbEg6LNwMMPeJT3vHwKpz
    Q/f8/Cd4eAS49m4vaJAd4muCGSHCNUnWY4ge9fvqMpj8P1M4sNI+Y0k+VmaAErpf
    bD2B6a16c633ZrXa4tuDsNDpRTj8pMSpyMoCym6iM4BbS97TwItdBYSWwx7MTkOe
    z7/upJXeGqGX+xpvEtmVn8WTyOOm4JIE1w8dj2msvz5GxMQzKoEqriVDTXBvntfj
    ck9yFBBbmXw9HZ138h6/w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=ER+VF6pz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=ER+VF6pz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeCIJuE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:50:04 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:47797 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeCIJuA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 04:50:00 -0500
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
From: Roger Quadros <rogerq@ti.com>
To: Felipe Balbi <balbi@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
CC: USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <87sh9l5z4l.fsf@linux.intel.com>
 <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com>
 <87po4i3o1v.fsf@linux.intel.com>
 <a907787a-dea2-5f15-3d25-693680a42b71@ti.com>
 <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com>
 <87k1uq3ho6.fsf@linux.intel.com>
 <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com>
 <CAMz4kuJpBXY92zhG7s_VRkpcTHeLCE_vBLLSFVxLWjN2GQvyyw@mail.gmail.com>
 <87h8puwyn5.fsf@linux.intel.com>
 <5bc56ef5-66b1-d40c-1639-e748fe18cdbd@ti.com>
 <87muzha9h4.fsf@linux.intel.com>
 <f8edc87c-919f-46ab-f437-303dede74c82@ti.com>
Message-ID: <2b0a25a3-e720-136c-106f-42515247ec8a@ti.com>
Date: Fri, 9 Mar 2018 11:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f8edc87c-919f-46ab-f437-303dede74c82@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/03/18 11:26, Roger Quadros wrote:
> On 09/03/18 11:23, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Roger Quadros <rogerq@ti.com> writes:
>>
>> <snip>
>>
>>>>> When we set up the DWC3_DEPCMD_ENDTRANSFER command in
>>>>> dwc3_stop_active_transfer(), we can do not set DWC3_DEPCMD_CMDIOC,
>>>>> then there will no endpoint command complete interrupts I think.
>>>>>
>>>>> cmd |= DWC3_DEPCMD_CMDIOC;
>>>>
>>>> I remember some part of the databook mandating CMDIOC to be set. We
>>>> could test it out without and see if anything blows up. I would,
>>>> however, require a lengthy comment explaining that we're deviating from
>>>> databook revision x.yya, section foobar because $reasons. :-)
>>>>
>>>
>>> This is what the v3.10 databook says
>>>
>>> "When issuing an End Transfer command, software must set the CmdIOC
>>> bit (field 8) so that an Endpoint Command Complete event is generated
>>> after the transfer ends. This is necessary to synchronize the
>>> conclusion of system bus traffic before the End Transfer command is
>>> completed."
>>>
>>> with a note
>>>
>>> "If GUCTL2[Rst_actbitlater] is set, Software can poll the completion
>>> of the End Transfer command by polling the command active bit to be
>>> cleared to 0."
>>>
>>> fyi.
>>>
>>> Rst_actbitlater - "Enable clearing of the command active bit for the
>>> ENDXFER command after the command execution is completed.  This bit is
>>> valid in device mode only."
>>>
>>> So I'd prefer not to clear CMDIOC for all cases.
>>>
>>> Could we some how just tackle the dwc3_gadget_exit case like I did in
>>> this patch?
>>
>> if you can send a version that doesn't iterate over all endpoints twice,
>> sure. We still need a comment somewhere, and I fear we may get
>> interrupts later in some cases. How would we deal with that?
>>
> 
> how about explicitly masking that interrupt? Is it possible?
> 

Other easy option is to use wait_event_interruptible_lock_irq_timeout()
instead of wait_event_lock_irq() in dwc3_gadget_stop().

Is a 200ms timeout sufficient? And after the first timeout we assume all
will timeout so no point in waiting 200ms for each endpoint.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
