Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A95C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CE321479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Fok6HRAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfBBBbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:31:08 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:42488 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfBBBbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:31:08 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id CA35310C1BA9;
        Fri,  1 Feb 2019 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549071067; bh=VQQsVmj3NZN9anLxhdOdeLyPLcdiTOpUVz5Af3AiM2A=;
        h=From:To:CC:Subject:Date:References:From;
        b=Fok6HRAzfmM6x3U57/MtH95FrxWjj4SeaI+KcCmdHf5kcjGK/+OKo5Uc1BxNXTvHN
         aQmjkXdpIdpEq3gIziJzRrhwzyDyz4DcIsd1QzQRHGSVNd2sQFd9IKRTb4xFQsya4z
         EluYfuuDeXZetW0DYHQ12cA0UjYym5lBMecdWLWNJVFTO7dlQcVZMDfKbvCdMXl49E
         8Ca+BIfH7pVi7HI07ro/uC6LF4l0lzY71U3s8fCkiOP+7QVaee2f4f66UxuSqK070d
         7pvqqJ8z+cLqp+j3z0MGOR8nqWzxQ0vqZXTzx1JP0O/7Si6CnSBI1OWe0Np3u+KgaP
         GfH1s8a6sOSIg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 031E0A0095;
        Sat,  2 Feb 2019 01:31:06 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Fri, 1 Feb 2019 17:31:06 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        "Jack Pham" <jackp@codeaurora.org>, Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
Thread-Topic: Frequent dwc3 crashes on suspend or reboot since 5.0-rc1
Thread-Index: AQHUuozT6kyyipjNNU6b/TjVOcoaGw==
Date:   Sat, 2 Feb 2019 01:31:05 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639C0508@us01wembx1.internal.synopsys.com>
References: <CALAqxLXy1zSTSoDEfYN0VJBbf=Q0N6kH+S_1hTTgEb6dQi0XrQ@mail.gmail.com>
 <CALAqxLVtQPgHgo+nNQCQ3JPm3_-3nAyyCOy6p2KbqWFyL-dqcQ@mail.gmail.com>
 <30102591E157244384E984126FC3CB4F639BF47B@us01wembx1.internal.synopsys.com>
 <CALAqxLWHO_UrYYD65DTf3SBj_nyPA9r0TG0xFCci0zRXLszVwQ@mail.gmail.com>
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

John Stultz wrote:=0A=
> On Fri, Feb 1, 2019 at 4:46 PM Thinh Nguyen <thinh.nguyen@synopsys.com> w=
rote:=0A=
>> John Stultz wrote:=0A=
>>> On Fri, Feb 1, 2019 at 4:18 PM John Stultz <john.stultz@linaro.org> wro=
te:=0A=
>>> Bisecting the changes down, it seems like its due to commit=0A=
>>> fec9095bdef4e ("usb: dwc3: gadget: remove wait_end_transfer").=0A=
>>>=0A=
>>> It doesn't happen all the time, so I'll need to run some more testing,=
=0A=
>>> but so far I've not been able to trigger it backing out the patches to=
=0A=
>>> that point.=0A=
>> Yeah, it sounds like the same issue. You can review the discussion here:=
=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.spinics.net_l=
ists_linux-2Dusb_msg176110.html&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Du=
9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DNafAczsBrlszpsknN68eiuJOr8zY=
yB34O0R9NCF3-pc&s=3DExaEPcrEUReFA79ZWRHG9MELb9eead_QxKiTu1ea8Eg&e=3D=0A=
> Unfortunately, merging in=0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_balbi_usb.git&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=
=3Du9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DNafAczsBrlszpsknN68eiuJO=
r8zYyB34O0R9NCF3-pc&s=3DVLaXOrfcXp-6oljE2fC9rBEsPfYTZ6CxKqiQOhW_QKE&e=3D=0A=
> testing/next seems to trigger a different issue:=0A=
>=0A=
> [   38.585141] OOM killer enabled.=0A=
> [   38.585143] Restarting tasks ...=0A=
> [   38.585874] ------------[ cut here ]------------=0A=
> [   38.585882] ep1out: request 0000000000000000 already in flight=0A=
> [   38.585944] WARNING: CPU: 7 PID: 2545 at=0A=
> drivers/usb/dwc3/gadget.c:1430 dwc3_gadget_ep_queue+0x1d4/0x200=0A=
> [   38.585946] Modules linked in:=0A=
> [   38.585960] CPU: 7 PID: 2545 Comm: adbd Tainted: G S=0A=
> 5.0.0-rc4-00110-gad0e691 #509=0A=
> [   38.585963] Hardware name: HiKey960 (DT)=0A=
> [   38.585968] pstate: 80400085 (Nzcv daIf +PAN -UAO)=0A=
> [   38.585972] pc : dwc3_gadget_ep_queue+0x1d4/0x200=0A=
> [   38.585976] lr : dwc3_gadget_ep_queue+0x1d4/0x200=0A=
> [   38.585978] sp : ffffff80149fbb40=0A=
=0A=
It looks like the gadget driver tried to queue request twice.=0A=
=0A=
> Let me know if you have other ideas to try!=0A=
>=0A=
>=0A=
=0A=
Try to revert this patches series (3 patches) from Felipe testing/next=0A=
to see if that helps:=0A=
https://patchwork.kernel.org/patch/10764297/=0A=
=0A=
Thinh=0A=
=0A=
