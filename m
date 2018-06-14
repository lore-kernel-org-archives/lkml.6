Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DEB88C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7EA208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="rXBUrhON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7EA208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755212AbeFNLdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:33:39 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:31207 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754992AbeFNLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1528976014;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yQjqtCgQUJvh7Jr4sSLtXDQxyVrYNl28jWwBPm9MF2Q=;
        b=rXBUrhON3tn/lzdvbm2j7jizAKncKPtfEn1rqsVBqNG2xXRpDANZciNDlq3U0+7eVO
        OUtFLInJqmwcDkhWGOlEyIWji4JeZY/PkLPJ+ZHfOEyn1L0znn8R3+/jPtLZjDsPuhDX
        CmeXLmg+v+NHAzs1jSnzTDVQugGVMLZdcpGL13dyi1fGJgKLlQLbiIeVImirRImIPgar
        RLuuu/8SabiDCGv+NSNeXggTafvuqTI92nv3t9yFAmppOrIdubqZf5kKMhicyE2CsIM7
        SDGA+ecexIzAzO7+95Lkj7UExi1D/rXl2iUqvW4lt7SYG7NZzwIU4dBWa0DVkcIgA7rN
        1Eyw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdN2EjaY"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id 407f97u5EBXVRWX
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 14 Jun 2018 13:33:31 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] extcon: Release locking when sending the notification of connector state
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <9AEF5153-4234-4C30-984A-8A3D51D04623@goldelico.com>
Date:   Thu, 14 Jun 2018 13:33:30 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        stable <stable@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Giaccone <tony@giaccone.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <764C1A35-7D06-48AD-8809-0F6BB3526A23@goldelico.com>
References: <CGME20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d@epcas2p4.samsung.com> <1528949687-32002-1-git-send-email-cw00.choi@samsung.com> <5B22410C.9080002@samsung.com> <9AEF5153-4234-4C30-984A-8A3D51D04623@goldelico.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, Roger Quadros <rogerq@ti.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 14.06.2018 um 12:39 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Roger and Chanwoo,
>=20
>> Am 14.06.2018 um 12:18 schrieb Chanwoo Choi <cw00.choi@samsung.com>:
>>=20
>> + H. Nikolaus Schaller <hns@goldelico.com>
>>=20
>> On 2018=EB=85=84 06=EC=9B=94 14=EC=9D=BC 13:14, Chanwoo Choi wrote:
>>> Previously, extcon used the spinlock before calling the =
notifier_call_chain
>>> to prevent the scheduled out of task and to prevent the notification =
delay.
>>> When spinlock is locked for sending the notification, deadlock issue
>>> occured on the side of extcon consumer device. To fix this issue,
>>> extcon consumer device should always use the work. it is always not
>>> reasonable to use work.
>>>=20
>>> To fix this issue on extcon consumer device, release locking when =
sending
>>> the notification of connector state.
>>>=20
>>> Fixes: ab11af049f88 ("extcon: Add the synchronization extcon APIs to =
support the notification")
>>> Cc: stable@vger.kernel.org
>>> Cc: Roger Quadros <rogerq@ti.com>
>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>> drivers/extcon/extcon.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>>> index 8bff5fd18185..f75b08a45d4e 100644
>>> --- a/drivers/extcon/extcon.c
>>> +++ b/drivers/extcon/extcon.c
>>> @@ -433,8 +433,8 @@ int extcon_sync(struct extcon_dev *edev, =
unsigned int id)
>>> 		return index;
>>>=20
>>> 	spin_lock_irqsave(&edev->lock, flags);
>>> -
>>> 	state =3D !!(edev->state & BIT(index));
>>> +	spin_unlock_irqrestore(&edev->lock, flags);
>>>=20
>>> 	/*
>>> 	 * Call functions in a raw notifier chain for the specific one
>>> @@ -448,6 +448,7 @@ int extcon_sync(struct extcon_dev *edev, =
unsigned int id)
>>> 	 */
>>> 	raw_notifier_call_chain(&edev->nh_all, state, edev);
>>>=20
>>> +	spin_lock_irqsave(&edev->lock, flags);
>>> 	/* This could be in interrupt handler */
>>> 	prop_buf =3D (char *)get_zeroed_page(GFP_ATOMIC);
>>> 	if (!prop_buf) {
>>>=20
>=20
> I have tested on the Pyra handheld prototype and now it works. =
Plugging in an OTG cable
> enables/disables OTG power as expected and there are no kernel oops =
any more.

I did take some minutes to check and it now also works again on the =
OMAP5EVM.

BR,
Nikolaus=
