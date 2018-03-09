Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-123275-1520587611-2-16850709866412714262
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
    t=1520587610; b=hoxE3wd3lFMOV6frAnjVZU3iQWyN/Zi/sn8Ps6CnzCWFiTh
    M+ZIh6QPsFTnrp6y3LhlOOfZ0AYBYHyu5YOblXQRSmL6gZ6r4G9PDr1rzMn/Xp0t
    zNtGuCCCGYxO1ebgBSKZzsBlEnUaRc1vbm65YDaCO1wAn1cvUyAeuPkDbGAzI6QB
    Inbcv0c93OPuNFoxdwv/A/9vBfgPHdRKizfdkN8d5UTr4wA1Ql2M7NluqvFZ3L02
    DBbVCmgNfeqUgStVW+rbOXzJkwDKe+BwY5CATjTEiVUzKjTuBG/lxC3JEvnj1nx2
    nDYLVvQtdiRc6LGPF1i03c4iYHqo9IEGfShURvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520587610; bh=2fM50evyGAb3nWWlBtK1vLaqnKuIIL3fNlMI8tAlqCA=; b=w
    786Zb2FPz0SiHvaigVIWR4TD2f1ck2eR4JAnS6oc8W7lg16oBRpMLPiSSBEDl+sW
    bZBoANPRbCvsZjXWWTzeEvvEnG8xrAApXwrjCKDfDGe7o8s6XhVhCRAvfS3e4hII
    iytiNYR0Q6Cv8OJssb/gjiZuJ5eroWdFRTQ8bNQO9aXnzac0XzsCi7J1+x4GuU5+
    0hFP+GwZbf+tr8CdW+B8JSnHxFFXwY6UiIBNKzuNA2Zj/wsyUgbsAq8uChZkQMnB
    B6qBKYyhZ9NKwq94C/Y6IKiUgQSHximthy3O1NKY4guKBHOrb4XsLHEk9niaEGR1
    ZJ34nXjSblLGauiQ8/Phg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=pnSgs75W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=pnSgs75W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750883AbeCIJ0q (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:26:46 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:46950 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCIJ0q (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 04:26:46 -0500
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
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
From: Roger Quadros <rogerq@ti.com>
Message-ID: <f8edc87c-919f-46ab-f437-303dede74c82@ti.com>
Date: Fri, 9 Mar 2018 11:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87muzha9h4.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/03/18 11:23, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
> 
> <snip>
> 
>>>> When we set up the DWC3_DEPCMD_ENDTRANSFER command in
>>>> dwc3_stop_active_transfer(), we can do not set DWC3_DEPCMD_CMDIOC,
>>>> then there will no endpoint command complete interrupts I think.
>>>>
>>>> cmd |= DWC3_DEPCMD_CMDIOC;
>>>
>>> I remember some part of the databook mandating CMDIOC to be set. We
>>> could test it out without and see if anything blows up. I would,
>>> however, require a lengthy comment explaining that we're deviating from
>>> databook revision x.yya, section foobar because $reasons. :-)
>>>
>>
>> This is what the v3.10 databook says
>>
>> "When issuing an End Transfer command, software must set the CmdIOC
>> bit (field 8) so that an Endpoint Command Complete event is generated
>> after the transfer ends. This is necessary to synchronize the
>> conclusion of system bus traffic before the End Transfer command is
>> completed."
>>
>> with a note
>>
>> "If GUCTL2[Rst_actbitlater] is set, Software can poll the completion
>> of the End Transfer command by polling the command active bit to be
>> cleared to 0."
>>
>> fyi.
>>
>> Rst_actbitlater - "Enable clearing of the command active bit for the
>> ENDXFER command after the command execution is completed.  This bit is
>> valid in device mode only."
>>
>> So I'd prefer not to clear CMDIOC for all cases.
>>
>> Could we some how just tackle the dwc3_gadget_exit case like I did in
>> this patch?
> 
> if you can send a version that doesn't iterate over all endpoints twice,
> sure. We still need a comment somewhere, and I fear we may get
> interrupts later in some cases. How would we deal with that?
> 

how about explicitly masking that interrupt? Is it possible?

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
