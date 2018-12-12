Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D064C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0EF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544597762;
	bh=lZ679hDVvrUvAqmBXMlH7aCdQqjZLsv3zNL2zB69Z8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=jlHJ2BnFOH4jMCarSgXXpkvcqyeeBapqbe5YD7ywMiK7tf4G/Mzu403mGtO1JCHLG
	 WNhMyWUcMcOXBxkgMJ/WfaJ4lrWf0xel1Zf4EpgOBvd4wq8W3kGdj6iEtJ8TB+53Qa
	 q3ejVGVmTxMPWW0dsRVbydP574R08orL9VoYF9jo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0EF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLLG4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:56:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:10734 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeLLG4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:56:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 22:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="asc'?scan'208";a="303126965"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 11 Dec 2018 22:55:55 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Peter Chen <hzpeterchen@gmail.com>, pawell@cadence.com
Cc:     devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        lkml <linux-kernel@vger.kernel.org>, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com> <1544445555-17325-3-git-send-email-pawell@cadence.com> <87h8fkmfar.fsf@linux.intel.com> <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com> <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com>
Date:   Wed, 12 Dec 2018 08:55:51 +0200
Message-ID: <877egfmdxk.fsf@linux.intel.com>
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

Peter Chen <hzpeterchen@gmail.com> writes:

>> >> +            tmode =3D le16_to_cpu(ctrl->wIndex);
>> >> +
>> >> +            if (!set || (tmode & 0xff) !=3D 0)
>> >> +                    return -EINVAL;
>> >> +
>> >> +            switch (tmode >> 8) {
>> >> +            case TEST_J:
>> >> +            case TEST_K:
>> >> +            case TEST_SE0_NAK:
>> >> +            case TEST_PACKET:
>> >> +                    cdns3_set_register_bit(&priv_dev->regs->usb_cmd,
>> >> +                                           USB_CMD_STMODE |
>> >> +                                           USB_STS_TMODE_SEL(tmode -=
 1));
>> >
>> >I'm 90% sure this won't work. There's a reason why we only enter the
>> >requested test mode from status stage. How have you tested this?
>>
>
> What's the reason?
> It can work although the code is a little different with above, I
> tested it using USBxHSETT tool at Windows.

put a sniffer. Status stage won't complete

>> >> +    irqreturn_t ret =3D IRQ_NONE;
>> >> +    unsigned long flags;
>> >> +    u32 reg;
>> >> +
>> >> +    priv_dev =3D cdns->gadget_dev;
>> >> +    spin_lock_irqsave(&priv_dev->lock, flags);
>> >
>> >you're already running in hardirq context. Why do you need this lock at
>> >all? I would be better to use the hardirq handler to mask your
>> >interrupts, so they don't fire again, then used the top-half (softirq)
>> >handler to actually handle the interrupts.
>>
>
> This controller may be ran at SMP environment, register and flag access
> needs to be protected among CPUs running.

in hardirq context? When interrupts are already disabled?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwQsPcACgkQzL64meEa
mQaFMhAAivaFXmE5zk1145Lxf0qGZfICtUAOftRLhjxoE8QiyVaONzDrWmSfVZOV
BFxf5p2YunTi5DEk2o/YVvDnmqmg5ctc5MASUeyuvBskEK8xAj5pcJ3zC4fGc10F
roSp3Lh8VPvTy9p9Plzj6wqtCf6cGQGdmFhZU9m8uOBH+5venL7+l2Nr/i+YwFyN
iq8s6YxT/qVNr311BZFokIH3ddfUNWRrizVfgfYORHU4NrSw5XV8185YvpRmZgbf
Ji8F6PNxtwkdVDhYlBcdApxMTpwsz8ZksPuJ8g8NhRoyksxL4J02qQUykMcSEkDS
h4H4+kMJWF+lC6a9Aj6KbaECK6IglZrkn7XLZURUmV6GxduvuiRWQ/FjAMbvrsYa
DjSPCyrIH1SODNw26ij0N/EYtGMQqkM5voRYN1fDb+u1dTT8ZTYZAYbHMAUDX+Kv
Fd3CZjeG7mQGWq7ctGWTKZAOA539rBczTN12YquxGneXa7xMjh4PuUfi6hqA9nxP
4S/+yyu51P1qrdCFjKcbiSd/SrPnOLLtKmb2tppokczi2H51XubfZcSNLha2OCfs
edcJQnY1XSbB+fHuZ3mKtwP+5RzhTnSEvAor96/hz6WPGh2W2xgySWieoRR2jauO
oOawN3NoHxsj8MTILERYcMKE3mfTZclHEv7Q58KjZTlssnudmDo=
=kGLu
-----END PGP SIGNATURE-----
--=-=-=--
