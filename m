Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D74C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83552082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83552082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeLEJHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:07:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:36561 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEJHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:07:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 01:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="asc'?scan'208";a="98790905"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2018 01:07:48 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        martin.petersen@oracle.com, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        v.anuragkumar@gmail.com, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
In-Reply-To: <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com>
Date:   Wed, 05 Dec 2018 11:07:44 +0200
Message-ID: <875zw82vfj.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
> The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
> for IOC/LST bit in the event->status and returns if IOC/LST bit is
> set. This logic doesn't work if multiple TRBs are queued per
> request and the IOC/LST bit is set on the last TRB of that request.
> Consider an example where a queued request has multiple queued TRBs
> and IOC/LST bit is set only for the last TRB. In this case, the Core
> generates XferComplete/XferInProgress events only for the last TRB
> (since IOC/LST are set only for the last TRB). As per the logic in
> dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
> IOC/LST bit and returns on the first TRB. This makes the remaining
> TRBs left unhandled.
> To aviod this, changed the code to check for IOC/LST bits in both
> event->status & TRB->ctrl. This patch does the same.
>
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
> Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
> ---
>  Changes in v7:
> 	1. None
>
>  Changes in v6:
> 	1. None
>
>  Changes in v5:
> 	1. None
>
>  Changes in v4:
> 	1. None
>
>  Changes in v3:
> 	1. None
>
>  Changes in v2:
> 	1. None
> ---
>  drivers/usb/dwc3/gadget.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 9ddc9fd..216179e 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2286,7 +2286,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(st=
ruct dwc3_ep *dep,
>  	if (event->status & DEPEVT_STATUS_SHORT && !chain)
>  		return 1;
>=20=20
> -	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
> +	if ((event->status & DEPEVT_STATUS_IOC) &&
> +	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
> +		return 1;

this shouldn't be necessary. According to databook, event->status
contains the bits from the completed TRB.  Which means that
event->status & IOC will always be equal to trb->ctrl & IOC.

Can you further describe the situation here? Perhaps share tracepoints
exposing the problem?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwHlWAACgkQzL64meEa
mQakLRAAqLqa9Raf/ti7hr+qpgDb7bHAKYuQi2oABRqiuFbCLvYMa6XQh3TIvPAJ
v3LYl1SoTMLNXHk96TmIojQvIrtC2tKuiYAr7No6YRTD9NXMsw/wJ8Wwrqq+nTxv
xwJwR+Obvlc/ApRDa3peVvEGrJwByug54mMUb2JE8jUNI2AXOJVx5XiaYYjGXr8A
XcrKGmwsSLrEROlh9GqLYqrwhRXo8ilPqbGoJdTQBoxwzbfK2+4xwjdAWlOBixz8
l6/LX2SxgOHlgdN/l0rBoRWqJjZEDmlCkB30knpD9RTGMTiYDBg0SOtRGa9XvRR3
xCWdsi867+Rkx8qXheYnHdwjkDdBH94+APVwgqdzJk3I9suO7S2HpXkTwU+xCExe
YfhsCxkL1jaXrtDUn8UXR4Fs5WLmo3yz2V4uDZ7zNK5gEGok64nJPX7ERuUJcHkk
NNV13UkQVymTfIPrR7/YznfNy+uMXGF3f+HivRmC9JvAt5wv6YExdSHZjkRH1T5T
ztuDiWWX6NZOp93N7hbqpON0L0XpIq7OE/l/uzN574iP1aa1B89zb0J2rOEyNU+l
xW+MprZiJx4kyFr8KqdDS1u17MDbvMbu4lq4wtDxAqsIehIaXbLDWuWZAVRUY2hK
WxdMJW+NN8jCM4ser1FDBvouNQcTMiKRuPR6/Txm5mKHutGtnI8=
=k4JX
-----END PGP SIGNATURE-----
--=-=-=--
