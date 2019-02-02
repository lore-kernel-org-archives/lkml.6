Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98328C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6465421479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I8gZvm1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfBBAqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:46:17 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:36146 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfBBAqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:46:17 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B51AC24E25B2;
        Fri,  1 Feb 2019 16:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549068376; bh=wTRDhBl1wvFPAAb1ltqnMnYAY1edk7rJrtMc48Tc/xA=;
        h=From:To:CC:Subject:Date:References:From;
        b=I8gZvm1m/ERHuYj8iDYcmt3PZR/9JdaTF/eJ/TG+S5Wq3X2pJ7qoS9UZX6JyhzlXA
         rwq1rdRMqAePqemdzB0U2V5F3EitRHZacXZYRhtyzNudy5Bc3r6fO+sKY3Lydnu3o9
         uNEyAHnBY0qdbuFZ+4wzmzb6GrPLrV4Cyzc/aYJeG/NNEBI2tiwLxNKZ+bNC2sUWc/
         y7IHgrOMDHwYfafptCePBVc4GE0hFAbo7ZJDlF9245inEhh66P7bKlnSIHARxaWnwB
         y7amapCYYm/iMR5lU+RY5cWFFkQxIB5v9wyCIaz0dlZnhiGGcEAGOooT2nI3N/1P7Q
         6m7JSqKadcw1Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D329DA0066;
        Sat,  2 Feb 2019 00:46:15 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri, 1
 Feb 2019 16:46:14 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Thinh Nguyen" <thinh.nguyen@synopsys.com>,
        Chen Yu <chenyu56@huawei.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
Thread-Topic: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
Thread-Index: AQHUuozT6kyyipjNNU6b/TjVOcoaGw==
Date:   Sat, 2 Feb 2019 00:46:14 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639BF47B@us01wembx1.internal.synopsys.com>
References: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
 <CALAqxLVtQPgHgo+nNQCQ3JPm3_-3nAyyCOy6p2KbqWFyL-dqcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
John Stultz wrote:=0A=
> On Fri, Feb 1, 2019 at 4:18 PM John Stultz <john.stultz@linaro.org> wrote=
:=0A=
>> Hey all,=0A=
>>   Since the 5.0 merge window opened, I've been tripping on frequent=0A=
>> dwc3 crashes on reboot and suspend, which I've added an example to the=
=0A=
>> bottom of this mail.=0A=
>>=0A=
>> I've dug in a little bit and sort of have a sense of whats going on.=0A=
>>=0A=
>> In ffs_epfile_io():=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pu=
b_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_usb_gadget_function_=
f-5Ffs.c-23n1065&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Du9FYoxKtyhjrGFcy=
ixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DIkgcuoe1TJkip3EVA2Cce33perU7WerY9a24BCFW4DM=
&s=3D3gJjzpAGPdj79ROPvlM1ziRTY-4u6VRFRwKWbz5X_SA&e=3D=0A=
>>=0A=
>> The completion done is setup on the stack:=0A=
>>   DECLARE_COMPLETION_ONSTACK(done);=0A=
>>=0A=
>> Then later we setup a request and queue it:=0A=
>>   req->context  =3D &done;=0A=
>>   ...=0A=
>>   ret =3D usb_ep_queue(ep->ep, req, GFP_ATOMIC);=0A=
>>=0A=
>> Then wait for it:=0A=
>>   if (unlikely(wait_for_completion_interruptible(&done))) {=0A=
>>     /*=0A=
>>     * To avoid race condition with ffs_epfile_io_complete,=0A=
>>     * dequeue the request first then check=0A=
>>     * status. usb_ep_dequeue API should guarantee no race=0A=
>>     * condition with req->complete callback.=0A=
>>     */=0A=
>>     usb_ep_dequeue(ep->ep, req);=0A=
>>     interrupted =3D ep->status < 0;=0A=
>>   }=0A=
>>=0A=
>> The problem is, that we end up being interrupted, supposedly dequeue=0A=
>> the request, and exit.=0A=
>>=0A=
>> But then (or in parallel) the irq triggers and we try calling=0A=
>> complete() on the context pointer which points to now random stack=0A=
>> space, which results in the panic.=0A=
>>=0A=
>> It seems like something is wrong with usb_ep_dequeue not really=0A=
>> stopping the irq from happening?=0A=
>>=0A=
>> If I revert all the changes to dwc3 back to 4.20, I don't see the issue.=
=0A=
>>=0A=
>> I'll do some bisection to try to narrow things down, but I wanted to=0A=
>> see if this was a known issue or if anyone had immediate ideas as to=0A=
>> what might be wrong.=0A=
> Bisecting the changes down, it seems like its due to commit=0A=
> fec9095bdef4e ("usb: dwc3: gadget: remove wait_end_transfer").=0A=
>=0A=
> It doesn't happen all the time, so I'll need to run some more testing,=0A=
> but so far I've not been able to trigger it backing out the patches to=0A=
> that point.=0A=
>=0A=
> thanks=0A=
> -john=0A=
>=0A=
=0A=
Yeah, it sounds like the same issue. You can review the discussion here:=0A=
https://www.spinics.net/lists/linux-usb/msg176110.html=0A=
=0A=
Thinh=0A=
