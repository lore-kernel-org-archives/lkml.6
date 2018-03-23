Return-Path: <felipe.balbi@linux.intel.com>
X-Google-Smtp-Source: AG47ELtUcSWa9izazXVwEwRXBlIv/bMcHWktGXgheTsbYkE0YMDPa7+RwHI/fvHY94b05YZK0qD9
ARC-Seal: i=1; a=rsa-sha256; t=1521804578; cv=none;
        d=google.com; s=arc-20160816;
        b=MUuHgbdvl66iDhcKd4b0sCCEiG5afDAdSL3htNncwMObtsbpaXEhQTxdBk2LDXmBWz
         EhKYPvJh5+LuCEfIUtTZaVq2ByT2NVds1V+H5dJ2jJ/l5fsHnkp3m2RnXIoVwERG80o/
         bIEaeKFQjvubDjzANltyLZY46v16mfWTDZUgAuYKKhaAvIMEulSfNcH3+tOZoeX74z0r
         spjVeP6dvYiVBPdqPc1yTKgRybuRHxDzpUFdUbalIpl5Blvq3EbzEZyZ2A8wN6/HbV6U
         hbZg88VPCsMutCTG/8DWsv28zXWD0xl1rgJFAqU9Ep7AgKpZ0T/z6ytbJuAiEn7yB77N
         5SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=vEZFL3+d0EaRbQJU7MtdOagD1hFWllj5KhtSFHSp+qE=;
        b=J+aYmWojHKc0jQMcYL/2wPGdbV4P3FrbCnGyXBlJcB03bP6oi4d41J/nzyAt2sUvOk
         tQ9oqmFYp1JYh4f9+G4dkBhpMr/5vKa8jVq535vCMS/XAxP1BTO2Hg4c/FeWLvTdNr8B
         sSmMAi6HE3eSo/Edwwnfr17UvC59+U8tj7IJt+esDgjryot4X3ZIiGGkckpUb8OLRSqK
         f7aJcRi41/kTYFW5pbOr7okzbrYsThpekbXDghQt0sjReshv3HH6H9ELFd+6RV7wA171
         LN9hCONy5TC7YMYpwaDtr/ACFBOw9n48j3DQVxrmv+GfupCe5oFlWI1IWcKX7aIxSxZa
         XJ1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,349,1517904000";
   d="asc'?scan'208";a="40566852"
From: Felipe Balbi <balbi@kernel.org>
To: Anurag Kumar Vulisha <anuragku@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>, Ajay Yugalkishore Pandey <APANDEY@xilinx.com>, "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
In-Reply-To: <MWHPR02MB2816D32AE891F329232DA730A7D40@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1521442253-15906-1-git-send-email-anuragku@xilinx.com> <87fu4wqwis.fsf@linux.intel.com> <MWHPR02MB2816D32AE891F329232DA730A7D40@MWHPR02MB2816.namprd02.prod.outlook.com>
Date: Fri, 23 Mar 2018 13:29:08 +0200
Message-ID: <87lgejni7v.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595347861307192100?=
X-GMAIL-MSGID: =?utf-8?q?1595727757202258062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


(please configure your email client to break lines at 80 columns ;-)

Hi,

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
> Hi Felipe,
>
> Thanks for reviewing the patch , please find my comments inline

no issues :-)

>>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>>> This patch fixes two issues
>>>
>>> 1. The code logic in dwc3_prepare_one_trb() incorrectly uses the
>>> address and length given in req packet even for scattergather lists.
>>> This patch correct's the code to use sg->address and sg->length when
>>> scattergather lists are present.
>>>
>>> 2. The present code correctly fetches the req's which were not queued
>>> from the started_list but fails to start from the sg where it
>>> previously stopped queuing because of the unavailable TRB's. This
>>> patch correct's the code to start queuing from the correct sg in sglist.
>>
>>these two should be in separate patches, then.
>>
> Will create separate patches in next version

thanks, that helps :-)

>>> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
>>> ---
>>>  drivers/usb/dwc3/core.h   |  4 ++++
>>>  drivers/usb/dwc3/gadget.c | 42
>>> ++++++++++++++++++++++++++++++++++++------
>>>  2 files changed, 40 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
>>> 860d2bc..2779e58 100644
>>> --- a/drivers/usb/dwc3/core.h
>>> +++ b/drivers/usb/dwc3/core.h
>>> @@ -718,7 +718,9 @@ struct dwc3_hwparams {
>>>   * @list: a list_head used for request queueing
>>>   * @dep: struct dwc3_ep owning this request
>>>   * @sg: pointer to first incomplete sg
>>> + * @sg_to_start: pointer to the sg which should be queued next
>>>   * @num_pending_sgs: counter to pending sgs
>>> + * @num_queued_sgs: counter to the number of sgs which already got
>>> + queued
>>
>>this is the same as num_pending_sgs.
>
> num_pending_sgs is initially pointing to num_mapped_sgs, which gets
> decremented in dwc3_cleanup_done_reqs().
>
> Consider a case where the driver failed to queue all sgs into TRBs
> because of insufficient TRB number. For example, lets assume req has 5
> sgs and only 3 got queued. In this scenario ,when the
> dwc3_cleanup_done_reqs() gets called the value of num_pending_sgs =3D
> 5. Since the value of num_pending_sgs is greater than 0,
> __dwc3_gadget_kick_transfer() gets called with num_pending_sgs =3D 5-1 =3D
> 4.
>
> Eventually __dwc3_gadget_kick_transfer() calls
> dwc3_prepare_one_trb_sg() which has for_each_sg() call which loops for
> num_pending_sgs times (4 times in our example). This is incorrect,
> ideally it should be called only for 2 times because we have only 2
> sgs which previously were not queued.
>
> So, we added an extra flag num_queued_sgs which counts the number of
> sgs that got queued successfully and make for_each_sg() loop for
> num_mapped_sgs - num_queued_sgs times only . In our example case with
> the updated logic, it will loop for 5 - 3 =3D 2 times only. Because of
> this reason added num_queued_sgs flag. Please correct me if I am
> wrong.

That's true. Seems like we do need a new counter.

>>> static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep
>>> *dep,
>>>
>>>                 req->request.actual =3D length - req->remaining;
>>>
>>> -               if ((req->request.actual < length) && req->num_pending_=
sgs)
>>> -                       return __dwc3_gadget_kick_transfer(dep);
>>> +               if (req->request.actual < length ||
>>> + req->num_pending_sgs) {
>>
>>why do you think this needs to be || instead of &&? If actual =3D=3D leng=
th we're
>>done, there's nothing more left to do. If there is either host sent more =
data than
>>it should, or we miscalculated num_pending_sgs, or we had the wrong length
>>somewhere in some TRBs. Either of those cases is an error condition we do=
n't
>>want to hide. We want things to fail in that case.
>>
>
> Consider the same example that we had previously discussed, among the
> 5 sgs only 3 sgs got queued and all 3 sgs got completed
> successfully. The req->remaining field represents the size of TRB
> which was not transferred. In this example , as 3 sgs got completed
> successfully the req-> remaining =3D 0. So , request.actual =3D length - 0
> (req->remaining) which means request.actual =3D=3D length.  Because of
> this , the condition check if ((req->request.actual < length) &&
> req->num_pending_sgs) ) fails even though we have req->num_pending_sgs
> > 0.  So, corrected the logic to always kick transfer for two
> conditions 1) if req->num_pending_sgs > 0 2) if ((req->request.actual
> < length) && req->num_pending_sgs)) condition satisfies. Please
> correct me If my understanding is wrong.

fair enough, but then we miss an important (IMO, that is) error case. If
req->num_pending_sgs > 0 && actual =3D=3D length, then something is super
wrong. We may just add it as an extra check:

	dev_WARN_ONCE(.... actual =3D=3D len && num_pending_sgs);

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlq05QQACgkQzL64meEa
mQbM7g/5AQv+Frju8/J533L3swPgo9RWikfNL+rETtyu7X15f+KE7pQ4Za77BIrf
PNJrzit1LNSrQ/ruwW3iMBtGxxER6jUWf+hx5yNBllhM2u6y4Tv2qwm3bC+8m4se
8BFcvxSylQH6oT9C9FbrNkvb4aDDCp9xsObNfYpix0GoRcHRGxVSSbz9YlBDAXKK
jkRsD7e24pHwkx/EPGc4ShrU3u5/ifpCZZg2uRqnSFtJUxTWMMHjgONbiCRVTbKW
al3Qvj2hKazOWbtxSMerK3sBRFuynFh4GA9fSDKLcJykR34zRGpBSLgciSuLU0+v
Zqk7E335NKjMxIND/6v7M9h7Vlc8bjSSIB64N9Pa781EiZDGuWLE1X1Rbupx5F7E
ST6YMlzCLeCfsBtfkfvuZLVR3hfi7RfDj2WwAEzg8fJfdFQ/+llUk0wOg1PRwH4j
1dCXtLGc4V8TQUr35+qxhrb2KM//5XXSib+amUGMiJDxg85hHOKHxvhPY/G4Mfk6
Qg99bAjFQ/b7INAweJntMO+axc29SQhPtYP9p2w+ZuCYd0NNYSjWfVBYGw1Uo+Eb
FJcnmpIFpVfTDldbgOcifIRiD+F4TPqlywvN8fKR8/FbawYzUnLAV5s6A16hHsbm
w5kkSHRiL2Uq1hKhlPb1ZJOokr58ySvQ1fQnOSwi0xmQ4KzKaSk=
=v/i4
-----END PGP SIGNATURE-----
--=-=-=--
