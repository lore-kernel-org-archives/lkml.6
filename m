Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-398581-1526892359-2-16543954276906778274
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526892359; b=iNqVhARwPCfm4dYuHhNJXPjBZ6fI3MM59J8ELT/UN42N9BdCad
    J1nytX7WhmOOtRCyz7mKimJw/hU5j8YZZlj/GmOoGnvH6hh70buqCPivW/sdqnok
    3SfWvwgmVvIpi6iTZGxUI/MuCnXDkrF1iUuKZKa5JdZ0XpyOE+R8/ccHOL45AnY3
    hXNMrDVqSXS0oFV9gqp/3kPFqtFrNi/hQ9kIE9nA2tTgPfV6CXcladCmsKO2cuj2
    drfpATBrT2U8s2+mzJVQPkkjcC0vbWkbS4I1h/tMUJGJIg1NAxNq1yhcHSM2Hbwd
    HtyMuTZ/2L6p03JirtSh/UJxuMWiQjmZiQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=fm2; t=1526892359; bh=NEac8tbhoI2J2MlQU6DpINT
    qu/H8fAC1KN6lN4Cjz/U=; b=AfXooY4m4R22XBGBsL5ImhyPR+casfCGgLeIKUz
    27IWbm2PoMl1k0LT97jz9n4WPNuH+wFqXlVvolRdsalFTK8zOfqZAgh/zXd0c9wm
    UKdNVl73gMHT8JI8hOAu3uiaWGYcYMks5QoFs9oHqNI+29gQGbPpeglBBxI8HOcL
    BIl59OoXS5S2bUVHm+KSeZa8d7H5eUSUshNlx9yTtXWkMA6b85osk4yxDN9eaagS
    ORX9zD4HU1CPgOounRnF08BmCUFhRAlank0WFqHrn+JRoTxGYkpAguAQwSS4queD
    Bl94dfgM6kqbuEiHHqhkusQCN0bHHPp80nVh2d16QKJQNIA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=synopsys.com header.i=@synopsys.com header.b=PDvuEsnf
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=synopsys.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=synopsys.com header.i=@synopsys.com header.b=PDvuEsnf
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=synopsys.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBW4C2uu7DC5RAW1dLPVNiJIwBv5SqLJTmZOKLoFcdW7xsigihUIyDDhd9Z4Ogn9WIj/VWQZp8ik9zaC4VWlhjvpxLNBR1JMQ3HubgwyFfwQOIqzxSrE
    /CRBkRoUh4rfKf7nJrRhoMBLlT+J4O07QomXdFSTuH5qargQzJhGTfBkc8YkTciv1tZR3SjgY+ijCeaT1jNeWa8jmiRHum279Sn/dF+ZYyDHwnBKQ3lexMFw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=2AxsI-llnUoA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=4WqKlYufkJSlZLaDPeMA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=Lf5xNeLK5dgiOs8hzIjU:22 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbeEUIpl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 04:45:41 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:43415 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEUIpk (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 21 May 2018 04:45:40 -0400
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        Vardan Mikayelyan <mvardan@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Topic: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Index: AQHT7ws4+xyvQUj0rEqQiAqvmDphzw==
Date: Mon, 21 May 2018 08:45:35 +0000
Message-ID: <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.67]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi John,=0A=
=0A=
On 5/19/2018 4:49 AM, John Stultz wrote:=0A=
> In 4.17-rc, commit 03ea6d6e9e1f ("usb: dwc2: Enable power down")=0A=
> caused the HiKey board to not correctly handle switching between=0A=
> usb-gadget and usb-host mode.=0A=
> =0A=
> Unplugging the OTG port would result in:=0A=
> [   42.240973] dwc2 f72c0000.usb: dwc2_restore_host_registers: no host re=
gisters to restore=0A=
> [   42.249066] dwc2 f72c0000.usb: dwc2_host_exit_hibernation: failed to r=
estore host registers=0A=
> =0A=
> And the USB-host ports would not function.=0A=
> =0A=
> And plugging in the OTG port, we would see:=0A=
> [   46.046557] WARNING: CPU: 3 PID: 6 at drivers/usb/dwc2/gadget.c:260 dw=
c2_hsotg_init_fifo+0x194/0x1a0=0A=
> [   46.055761] CPU: 3 PID: 6 Comm: kworker/u16:0 Not tainted 4.17.0-rc5-0=
0030-ge67da8c #231=0A=
> [   46.055767] Hardware name: HiKey Development Board (DT)=0A=
> [   46.055784] Workqueue: dwc2 dwc2_conn_id_status_change=0A=
> ...=0A=
> =0A=
Could you please send full log to debug.=0A=
=0A=
=0A=
> Thus, this patch sets the hisi params to disable the power_down=0A=
> flag by default, and gets thing working again.=0A=
> =0A=
> Cc: John Youn <johnyoun@synopsys.com>=0A=
> Cc: Vardan Mikayelyan <mvardan@synopsys.com>=0A=
> Cc: Artur Petrosyan <arturp@synopsys.com>=0A=
> Cc: Grigor Tovmasyan <tovmasya@synopsys.com>=0A=
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>=0A=
> Cc: linux-usb@vger.kernel.org=0A=
> Signed-off-by: John Stultz <john.stultz@linaro.org>=0A=
> ---=0A=
>   drivers/usb/dwc2/params.c | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index f03e418..96b1b25 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -70,6 +70,7 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsot=
g)=0A=
>   		GAHBCFG_HBSTLEN_SHIFT;=0A=
>   	p->uframe_sched =3D false;=0A=
>   	p->change_speed_quirk =3D true;=0A=
> +	p->power_down =3D false;=0A=
=0A=
power_down declared as int, suggested to update as follow:=0A=
	p->power_down =3D DWC2_POWER_DOWN_PARAM_NONE;=0A=
=0A=
This can be accepted as temporary solution until we will fully debug =0A=
hibernation feature for HiKey platform.=0A=
=0A=
>   }=0A=
>   =0A=
>   static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)=0A=
> =0A=
=0A=
