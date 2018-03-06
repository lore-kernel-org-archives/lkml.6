Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-540544-1520347323-2-5455294082508172487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520347323; b=FOCsEXLPufIgNlaFzkNh4mC3/Yo1HbN8lU2KQLKmghSwPF1
    0wCpb6npADOEmAJQz8mu3BrsLUdbBF4I5SYk294orxwYAs7UGct5s6nTHeVYccyQ
    uLxjfVVcz43bTmJBml00SPetejthC0CsgnOol4zu+YKLThbiosFUqoLTHH+OwVp6
    XyZTNAxyTlCqF1GV17L4K13YFl3cxabTHQkE53BgFvuqdDvi+mFwO0snG6VQtU7A
    PqQ1ZrtlCFw59cfXsQHieBiw6b8cCKKfP5yJpMEZCFKe29Ns1rTD7TT+uLDmfcda
    NBX4e34o2/scl+vl4iNSy2XrRLRiRHppqf+qZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520347323; bh=CQRcwUZh8+R4DVCEJ64l07Z5qpe7SWy2UQ+Gu8
    n88G8=; b=V+L7GOxCQeWfXFiUh4gH7ZLDICP7iOA+vAGIgbnqjNlnkt9vNM5IwL
    m2m7RRDFX9lr60Lwty7g95A+GN4Xc8qKMboFyO5d9mA1AB5nWwRCwL8zshPANzoZ
    LBY12cGfrNCPnLTPUck9/dBDlIt9hLq5ESJJ162ZKT5tOlfXDSgKQFFpEb3RxPDW
    gZH3z5liBLj4Ac3aqZ0AvQ253S0K+X4r/q3KpZJVs6kN8i4AU7k4pJBPBVarR0xh
    Y2GD5bHzeRBmxneT1pgC6Wu39g4bkr73lTRSAkCEwDdWKZym9kJGG6oQLy9NBxqS
    yOky62H84Pa1/IbbY5C/fngPwbNtVTBQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933128AbeCFOlN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 09:41:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932801AbeCFOlK (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 6 Mar 2018 09:41:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4C621796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELu5wCdGzMt0+dbm6uLekVMg4crQNJd12rqscGuCpMbZZXrCjahtpwQFc2Fxl4b4up5cOx3uBsiIAsOhF1w2pAw=
MIME-Version: 1.0
In-Reply-To: <ae4c741e-d5aa-4a8c-4029-1dff6bef2cdd@arm.com>
References: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
 <1519897899-8577-2-git-send-email-amelie.delaunay@st.com> <20180306015743.uazy4e5quil2ijy2@rob-hp-laptop>
 <ae4c741e-d5aa-4a8c-4029-1dff6bef2cdd@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Mar 2018 08:40:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+iPZN-RV61+AFcRg-eKORQDQ9-4s4-vaFOrCqWBK8PDg@mail.gmail.com>
Message-ID: <CAL_Jsq+iPZN-RV61+AFcRg-eKORQDQ9-4s4-vaFOrCqWBK8PDg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: ehci: add optional external vbus
 supply property
To: Robin Murphy <robin.murphy@arm.com>
Cc: Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 8:09 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 06/03/18 01:57, Rob Herring wrote:
>>
>> On Thu, Mar 01, 2018 at 10:51:38AM +0100, Amelie Delaunay wrote:
>>>
>>> On some boards, especially when vbus supply requires large current,
>>> and the charge pump on the PHY isn't enough, an external vbus power
>>> switch
>>> per port may be used.
>>> Add portN_vbus-supply property to usb-ehci bindings. As the number of
>>> ports
>>> depends on the ehci controller, and the port on which an external vbus
>>> supply depends on the platform, <portN> is used to make it generic.
>>>
>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>> ---
>>>   Documentation/devicetree/bindings/usb/usb-ehci.txt | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>> b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>> index 3efde12..cd576db 100644
>>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>> @@ -19,6 +19,7 @@ Optional properties:
>>>    - phys : phandle + phy specifier pair
>>>    - phy-names : "usb"
>>>    - resets : phandle + reset specifier pair
>>> + - portN_vbus-supply : phandle of regulator supplying vbus for port N
>>
>>
>> Just make this an array with the index being the port (and drop
>> "portN_").
>
>
> Does that still work if there is an external supply for port 1 but none for
> port 0? I believe that was brought up as a possibility before.

Yes, if you use 0 or -1 to skip over an index.

Really, this should go in the connector node instead because Vbus is
supplied to the connector, not the host controller. The connector
binding is on its way into mainline.

Rob
