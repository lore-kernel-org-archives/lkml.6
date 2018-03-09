Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-186549-1520591980-2-16913418379597484461
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520591980; b=KMULbdG8DsQXXjDCi/9uMPWTMGxkR6pEh4yICsqVqxTafBw
    g6Wm9x/ENWURFiKc+bJXEgiS9YxtPIURrXQJbyJ8QiiiYL+NAS1wuQVk2gG9rAWf
    1V9hJuzquhfACR2T+hFDExrUOzKK/3aCeggOp+rzPpl2vVpaGv5Il0SId8whBzDm
    0kgqC9a4/0CT9YEURv5uVBHRz+CFX4YQOvwf1NwgAexfKACnmA6+uGU5stGLgdrD
    e/iFe83bb7zXz3QlYmxJNCbpvTPu9ObTBtQxXF2bYsjxunTR8vCYG2ETyjCQltoJ
    nsGl4UmecfSvgBoq1MqNp8vYnHGMsC/R2bYXzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520591980; bh=bhh+ohmVVYhYKdJ2COqx6sd8LgVYtiwWQEGUM9
    ID7SA=; b=Vhynof5aBWt8CjDHsHi5v7ukI37gK3OCQCn/dMkczc/QMcZgcAP6rc
    GR5p3Scdco3+BYmY1MnrnSQRw9w2tHw+bKX/KQJ2MFathtaHxF/lI/+9e08NJ685
    eCzIrIswic0n4uQmO8npAd6wdbOXo/Or9jJnFlRPQxFOy1oP6DwRlahOdIIZZIEw
    KHemm2CGXOivz10UNpTvpHH6WlFlP8n0FtokSHd26jumQ8Y8F9b9y56h3SH+/B5v
    yLHcygLzNYgGMzkNtTxUy/GPqAXCvqIY4Q4a2ZfFyLQNR1mTWt5Rl7JBTGlqLLQS
    IQwwaC6jQ+iGyZSVsTYRNj+14FBwRwSw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750920AbeCIKj0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 05:39:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:53880 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbeCIKjZ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 9 Mar 2018 05:39:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,445,1515484800";
   d="asc'?scan'208";a="210192023"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <2b0a25a3-e720-136c-106f-42515247ec8a@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <87sh9l5z4l.fsf@linux.intel.com> <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com> <87po4i3o1v.fsf@linux.intel.com> <a907787a-dea2-5f15-3d25-693680a42b71@ti.com> <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com> <87k1uq3ho6.fsf@linux.intel.com> <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com> <CAMz4kuJpBXY92zhG7s_VRkpcTHeLCE_vBLLSFVxLWjN2GQvyyw@mail.gmail.com> <87h8puwyn5.fsf@linux.intel.com> <5bc56ef5-66b1-d40c-1639-e748fe18cdbd@ti.com> <87muzha9h4.fsf@linux.intel.com> <f8edc87c-919f-46ab-f437-303dede74c82@ti.com> <2b0a25a3-e720-136c-106f-42515247ec8a@ti.com>
Date: Fri, 09 Mar 2018 12:39:14 +0200
Message-ID: <87efkta5yl.fsf@linux.intel.com>
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

Roger Quadros <rogerq@ti.com> writes:
>>>>>> When we set up the DWC3_DEPCMD_ENDTRANSFER command in
>>>>>> dwc3_stop_active_transfer(), we can do not set DWC3_DEPCMD_CMDIOC,
>>>>>> then there will no endpoint command complete interrupts I think.
>>>>>>
>>>>>> cmd |=3D DWC3_DEPCMD_CMDIOC;
>>>>>
>>>>> I remember some part of the databook mandating CMDIOC to be set. We
>>>>> could test it out without and see if anything blows up. I would,
>>>>> however, require a lengthy comment explaining that we're deviating fr=
om
>>>>> databook revision x.yya, section foobar because $reasons. :-)
>>>>>
>>>>
>>>> This is what the v3.10 databook says
>>>>
>>>> "When issuing an End Transfer command, software must set the CmdIOC
>>>> bit (field 8) so that an Endpoint Command Complete event is generated
>>>> after the transfer ends. This is necessary to synchronize the
>>>> conclusion of system bus traffic before the End Transfer command is
>>>> completed."
>>>>
>>>> with a note
>>>>
>>>> "If GUCTL2[Rst_actbitlater] is set, Software can poll the completion
>>>> of the End Transfer command by polling the command active bit to be
>>>> cleared to 0."
>>>>
>>>> fyi.
>>>>
>>>> Rst_actbitlater - "Enable clearing of the command active bit for the
>>>> ENDXFER command after the command execution is completed.  This bit is
>>>> valid in device mode only."
>>>>
>>>> So I'd prefer not to clear CMDIOC for all cases.
>>>>
>>>> Could we some how just tackle the dwc3_gadget_exit case like I did in
>>>> this patch?
>>>
>>> if you can send a version that doesn't iterate over all endpoints twice,
>>> sure. We still need a comment somewhere, and I fear we may get
>>> interrupts later in some cases. How would we deal with that?
>>>
>>=20
>> how about explicitly masking that interrupt? Is it possible?
>>=20
>
> Other easy option is to use wait_event_interruptible_lock_irq_timeout()
> instead of wait_event_lock_irq() in dwc3_gadget_stop().
>
> Is a 200ms timeout sufficient? And after the first timeout we assume all
> will timeout so no point in waiting 200ms for each endpoint.

We can do that. And I think some 5ms is more than enough :-) I'd be
surprised if it takes anything over some 200us for the EndTransfer
command to complete.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqiZFIACgkQzL64meEa
mQbvSw//dF6NeOBwsZBreTUH6be2VxQ2K1AVWrhcbAMFQAV1vHE3IGxqFn0LGtag
+kszazE4oiqs3zCjrFRxVibOT8UrNIpx/Ud0Bl/CSC2ot3yLzJkbaNHYtcrNCYPH
Bo2K63hZ+GH+06mJYBgknVik970rAHV95y1yCSj4g+cDGZxyO+TviJbxCMSMPMrv
qLCvY7itOuiXhDfTGDTsTslDq+t/dxcTugxHHt+6WD3LSuYVBs45Ebo00IqgK65b
O2guCFM+MRKw2PEAiHwFnmknOxmfg6M4miQKtQThRvwtTsftiy2b9pInv0tiE6yt
1NzFjdOSVvKoaurQVvWUmxX87a++vf1GqeB/jUQKfbK9kGNFH9mbSchzfo3LE3mk
zf2YkfLu+X3eE5wOboKoTOsj5YL7DF8ikGVUD8R8OyVEZKTPCG++T3i6MQRNJiqy
gMlbb50prIcGwQveiA4nBSbBrj8klbHb9lWwqYyaiLvjGXM+gcpfCalK/Ww6v2Pj
oK58wSSS0yCdPKpu6Z9qJoUnYtQ5ZlyQHhXtbHLZdSGt/RpfshyIMGr9nJu7eqfP
XOm93YwfbrK6LxGeX5xPKmuYUFpApql8JUe0DNoR+GZpggj2hIG7NQqV2iPJfvoJ
XdSoSIxiWm8AtvRBUMfeby5OJtHBycB1iPwZd4zaYbjycRvOEws=
=Co6l
-----END PGP SIGNATURE-----
--=-=-=--
