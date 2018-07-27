Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED3BC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0720673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB0720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeG0ITW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:19:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:10349 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeG0ITW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:19:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 23:58:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="asc'?scan'208";a="57567311"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2018 23:58:51 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
In-Reply-To: <CAD=FV=WjMVhc=h+YJLmW6jQ0aS+qc1ZQU5DCx2F8B7hKc4v8ZA@mail.gmail.com>
References: <20180706162154.196345-1-dianders@chromium.org> <87o9eu1cup.fsf@linux.intel.com> <CAD=FV=WjMVhc=h+YJLmW6jQ0aS+qc1ZQU5DCx2F8B7hKc4v8ZA@mail.gmail.com>
Date:   Fri, 27 Jul 2018 09:55:32 +0300
Message-ID: <87pnz9yxp7.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Doug Anderson <dianders@chromium.org> writes:
> On Thu, Jul 26, 2018 at 3:59 AM, Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
>> Douglas Anderson <dianders@chromium.org> writes:
>>
>>> While looking at a dwc2 recently, I noticed that some platforms still
>>> have the uframe scheduler off.  As far as I know, nothing good can
>>> come out of having the uframe scheduler off.  Let's turn it on
>>> everywhere.  Assuming this all works out then some time in the future
>>> we can gut all the old code that handles the old non-uframe scheduler
>>> and make everything simpler.
>>>
>>> NOTE: I don't have access to any of the platforms that I'm changing
>>> here, so I'm hoping to see a Tested-by from those on the list.
>>>
>>>
>>> Douglas Anderson (4):
>>>   usb: dwc2: Turn on uframe_sched on "bcm" platforms
>>>   usb: dwc2: Turn on uframe_sched on "his" platforms
>>>   usb: dwc2: Turn on uframe_sched on "amlogic" platforms
>>>   usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms
>>
>> care to resend without RFT prefix and with collected acks, tested-bys, e=
tc?
>
> Done with a prefix of 'REPOST' to hopefully make it obvious nothing
> changed between the RFT and this version.  There were only two
> test-by, but as mentioned in the updated cover letter:
>
> Since there should be nothing platform specific about the uFrame
> scheduler presumably this should mean we're good to go?  Specificaly
> note that in at least one of the "Tested-by" reports this patch caused
> a notable improvement.
>
>
> BTW: I'm pleased to have you apply the patches, but I notice that
> get_maintainer no longer flags you as the person to post dwc2 patches
> to.  From linux-next:
>
> $ ./scripts/get_maintainer.pl -f drivers/usb/dwc2
> Minas Harutyunyan <hminas@synopsys.com> (maintainer:DESIGNWARE USB2
> DRD IP DRIVER)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> linux-usb@vger.kernel.org (open list:DESIGNWARE USB2 DRD IP DRIVER)
> linux-kernel@vger.kernel.org (open list)

I need to add dwc2 to the gadget framework part of MAINTAINERS. I'll do
that at some point.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltaweQACgkQzL64meEa
mQZeQg//fpx6aH57cgQVkHE4v3J3icKrd3OFRIBYy8MRvDWPlK5Q2KuJCEjzpP+0
IHHHf+mye3lWnFVG4eVvzaZdlY0NvfRVtFUUnZtYA0UJqOv5VkuHa5t8dQCnKxZW
f4PIeW5qg3iTfe1JpajeL0RWV4KQYm4OuYGGrvB/rOhBxGBVRGvxdXzz+tvZX02m
rUMbDOLiATSZ6hhUoTndDPzOKaaETHHJ6fBfBaRnNTEeUBmfc+Xcw/kv8dBv2rbV
5PcwyBl1Joi9leLZLB04IF6rpcRHh+Df/2LKc/LxpCqCQBa7Cl7Sj14ZSgJBnVie
eDEkxniSKsPRzi2dqPi0sE5KXQf2kv2r2QdYMBQfN7CKNjGyjjjNtF8D6S5BQSxG
JbGZBFO/B1wlZ57j9j/Iu/9r8IBXHtVSvQxzWnw1mgGruGOptwC3uqAFFU6idBoD
tlpIj5wMDQTwpO6FXpvafJRFEE6F+N3mTvlNqTM/ZT2f1gGf7q0OouCEFp2DL7+D
cLpBTpePL4kodbBzhPFbM2kBqKtn3wmMZxYADYVSszkSwkVotYKyH4aIMB/7j7e1
vpzAXjfuvRv1r/83EGCZkzd6rVaeUZP2WrrX89oGx5H1VHRdx9wvp3fkA49UQjwT
jNpaKaiaPCzFRLW1cmrLJ0E1Kk27/cEp4f5K/+6rt8CQYtX242o=
=ZKgS
-----END PGP SIGNATURE-----
--=-=-=--
