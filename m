Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3243332-1523345540-2-842821115231886289
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_TVD_MIME_EPI 0.01, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523345540; b=TfXyBTiF9YyhtlKVPxUo9nQZ7mo8n+yp2Rk+4AhbQNisyvHjGj
    XXlXacFG3MiTHYJg8YxG9uMsbUFGMsgoNBG5B4vzgM+U5XLTIEMTFur67kTWt43W
    hqhunelzO6rJykVQPqVTqiJbQlvN89TsMzdbp6IcD0E14sm8osDU+Yeyld5Pdy8q
    HiObqPFFqT7F9bA8XOwADu/UVc/1//Cz1CSZdHZA75ng1OnzMcQ+vUQtIibPQ4Hl
    kJpVBynf2/9YbWabmunatWiZi9rxAWa4juzJkRcIEfpO0KC0IplFoqa6N60Njp5N
    OMLXQQcapmy6YtGjb/4Tub3CmVqqVHi3Q2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1523345540; bh=LK9C50M/IuX416NXMHLMLiO562nHcXgiPy2SiVw2+I
    A=; b=ZoYTPDaAw2GNCwYw/lznn0PicLIuCXlMGtDzoMIxxTsA31AxD/t8XCHPh7
    7AkB5c62JpvC7IFjxwzHrczwQd5ub92CwnYXZYDmlqqUp9VosBd+8b6wicm4XV2Z
    Krvfi7Ic2UfJSxLr5VRwObh0jGYMGeI/yfDBPyatJbJ/63qauN1IrRTajMmmTuPU
    ofQBceV/9WCEO3onA2KMNiZ4q4AHpn8lRYDBas/NsZ+b2H6ZpkNm3sCfKOLMTr6e
    5/GZK6TGG7uBPngTBNmTlizPDnsuE09W2XVStTUGkr6Z2MFbg+S8KtFF9mDH7ekV
    YmhfjDK3p0LDYgxrNQYr8Y7k59FQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNfzlPDykQdR4rHyevIR+kSt7uoCboAtyHSgVdyq603AVE2TsvP/eOXov4UtAcAuFtYsB4Gy4NrQWTejAdgrvBOA42zOKvzaN9id7Ml4YF7XJcsd+p9e
    5oxrz0Ih0QD6tOYakZQVidiBRBwjRGYyhzjB/8coSaaMJqGv01uPukyJGJD5on/2LriulY7vFxMCXOiZRnhHevCeTuCAa9IMCUjXbw1f+jU9lcjyazOuuatP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=jIQo8A4GAAAA:8
    a=m5CLeHLidHpJT6plOkQA:9 a=soZIWM8GMSwtKbCxheMA:9 a=ONNS8QRKHyMA:10
    a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeDJHcH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:32:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:16805 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752469AbeDJHcF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 10 Apr 2018 03:32:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="asc'?scan'208";a="46585091"
From: Felipe Balbi <balbi@kernel.org>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Roger Quadros <rogerq@ti.com>
Cc: "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <410670D7E743164D87FA6160E7907A560113AE789A@am04wembxb.internal.synopsys.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com> <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com> <87y3isffog.fsf@linux.intel.com> <5ea0ad17-d538-72ec-ed59-004242c4cd26@ti.com> <410670D7E743164D87FA6160E7907A560113ABB478@am04wembxa.internal.synopsys.com> <87zi38438h.fsf@linux.intel.com> <410670D7E743164D87FA6160E7907A560113ABBA4B@am04wembxa.internal.synopsys.com> <87d100qwc5.fsf@linux.intel.com> <410670D7E743164D87FA6160E7907A560113ABC945@am04wembxa.internal.synopsys.com> <410670D7E743164D87FA6160E7907A560113ABCA0A@am04wembxa.internal.synopsys.com> <410670D7E743164D87FA6160E7907A560113AE789A@am04wembxb.internal.synopsys.com>
Date: Tue, 10 Apr 2018 10:31:13 +0300
Message-ID: <87r2nnldq6.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
>>>>>>> Actually to fix this issue I updated condition of wait function
>>>>>>> from:
>>>>>>> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>>>>>>> to:
>>>>>>> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING & DWC3_EP_ENABLED)
>>>>>>
>>>>>> you're not fixing anything. You're, essentially, removing the entire
>>>>>> end transfer pending logic.
>>>>> yes, you are right, but how to overcome this infinite loop? Replace
>>>>> wait_event_lock_irq() by  wait_event_interruptible_lock_irq_timeout()?
>>>>
>>>> The best way here would be to figure why we're missing command complete
>>>> IRQ in those cases. According to documentation, we *should* receive th=
at
>>>> interrupt, so why is it missing?
>>>>
>>>
>>> Additional info on test. Core configuration is HS only mode, test speed
>>> HS, core version v2.90a. Maybe it will help to understand cause of issu=
e.
>>> BTW, currently to pass above describe ISOC OUT test we just commented
>>> wait_event_lock_irq() in dwc3_gadget_ep_dequeue() function and
>>> successfully received request completion in function driver.
>>> Thanks,
>>> Minas
>>>
>>=20
>> One more info: while function driver call dequeue, host periodically
>> send control read command to get status of test from function - test In
>> Progress or Finished.
>> Thanks,
>> Minas
>>=20
>
> Your last dwc3 patch series allow us to successfully dequeuing remaining=
=20
> requests without falling in to infinite loop.

that's cool, thanks :-) I'll just fix the documentation bug I introduced
heh :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlrMaEEACgkQzL64meEa
mQbvnA/8CBNEQFELdDhKM52NnWdqdhpXAXtNPB2xvWMPhXMXyT10H8aM5S6y1S5I
VNIAk3GcZqWf2Y9aVO362zVhXk0G6MCwtr9oOtd7s2QN/WV6MSPzlRmeyjvT7he2
LN2jOp//hmd1dLhPQfWddB81DQ3ghw2RVXPvo6J7A+ImKnRyAFMQ/3U3/oGUOJMG
6/tPviQ7goLpdg4aQE3n9wCfFPx1IOBWNdduOUq1to6pcseWNGIk0DFS/WcXLz5u
BgtguW8NXbP7XbwThoBpxAC0j1YzD7w8d7l9VfgEM8j8OtUjK2Q0EtlGtVahWqlF
OESUhPUO0Nic87r8FCPPe20hN6T2MZLZJdHLc7EacVSPnYKSLB9PfjhJ7Vx1169f
ufSt0WaPyZDmMM8FyO/7SuxR1a+I5+uVgk+8y/Zkl3vqnbNBetjZSQrQELxJV6dr
W4dzmXfr4WDdN6D++VOTmPGENwcxKOR+LPG+3smfjVIiZIAiNCrGGqSGWfB9PIVP
0hzOMinhjpLpEjFfL6rjjPWI6RN/amDXtLtq4gfXr7Cc24MSHf/x9FHBZm+0djlU
aVN2jS4+C3Ls1fEQz7Ka5ixQf3kAFcVCQB+apvZHK7/5+2im23AoQC9/PPtIkf/J
EH43bpX5M6soi1jnarF4lu8lPPIvwhX4XIXmRj1eNHc6ZTpG4OM=
=l7az
-----END PGP SIGNATURE-----
--=-=-=--
