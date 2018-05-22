Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2627688-1526999110-2-16126083297330498556
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
    1526999110; b=eSEidhDwvpt8loaYfOdyQXzNWgcyZSDlyRzcNs5Ju5cMxmhul0
    8LrUwCzT1NoKW3yN2SRA79FaJTgzRfT6TsugWVJU6Fuy4aEvhU2ClOgKe2NCdEeI
    62ZduTOHDxqVlbOcdaamtp0ZdVL29HG2IH+0dZxoSZ8HJqZqy3to5w6NDbBcCVyG
    7BrSDDhHFWxoiKwwslxEyeQ5gq3YNmAa8oQdVC6PXcmN0a8f1sSjXbgdAJWsKr5q
    uRJLBN2CwAHqVjbKW+3jxBlCGmIMZcIFCkSr+V9CWOTlsPqmom4VG+Cg+hUhyHWx
    FgbJzSDUHgWFQ1GTEX38uZOAsbaUBID1FUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=fm2; t=1526999110; bh=H5P2LNR4JT2EXA0gTLqv4Tz
    sxT7tIxvlcTYggn2Vjxk=; b=hyPRsC0Rat6qJZib4WlFQaL3wTIF2IQnmreevu8
    Fjsj89OAThgmUdjI01timuMkrp6l5QQKpa2IauvlOcx4jt7Xbia85kuiFa2QoXIS
    SDIEetvt+PBRqe8oWuV9spQip3MOFLDpzl9sAYtwiU3Ap5a06OStrprcQTf6OPwQ
    FFqWCgK6zD7rwFNxjCEyP2uqmbVDWt7sHdx0Uq243XEkEAc0Fn289IttX7ZQOdHZ
    hUBtcCG+5IurqV7NLCbHcIO8nyCa8cHubKqE37Oe5pGUwLm7iKe0vNoOmYz9Jjgl
    hZ6EYrpL+w8BO2vGftB00lCiG0fh42MFJhjuJIDtj6uqq+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=synopsys.com header.i=@synopsys.com header.b=NASOVZRX
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=synopsys.com header.i=@synopsys.com header.b=NASOVZRX
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
X-CM-Envelope: MS4wfAw3ZsQ40SgENcRP22s2hPNcNAuS0YzfgONU10E9xr9VhXp/DMYfDpKyp9OSwiGtax0QXzxz/wSEnuMSulWdxKjyCFBxmvs6dFyCpqeUiQ1QDT3tT0a1
    97536u2VRLXr7uoMhrsL8LqVOK2Go95bq7yWWSegEChUfsobyZZM9uSgNez8nMIsithGPE7S4zSb/CS66X7PmNaerdeqdjznMYNp4Pu2b1MUaAs6luGdjui6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=2AxsI-llnUoA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=jIQo8A4GAAAA:8 a=VwQbUJbxAAAA:8
    a=4fsD5RWkkhMDKuSQGLYA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeEVOY4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 10:24:56 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:49522 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeEVOYz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 10:24:55 -0400
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: John Stultz <john.stultz@linaro.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
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
Date: Tue, 22 May 2018 14:24:47 +0000
Message-ID: <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
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
Please provide log with debug enabled configuration.=0A=
=0A=
On 5/21/2018 11:41 PM, John Stultz wrote:=0A=
> On Mon, May 21, 2018 at 1:45 AM, Minas Harutyunyan=0A=
> <Minas.Harutyunyan@synopsys.com> wrote:=0A=
>> Hi John,=0A=
>>=0A=
>> On 5/19/2018 4:49 AM, John Stultz wrote:=0A=
>>> In 4.17-rc, commit 03ea6d6e9e1f ("usb: dwc2: Enable power down")=0A=
>>> caused the HiKey board to not correctly handle switching between=0A=
>>> usb-gadget and usb-host mode.=0A=
>>>=0A=
>>> Unplugging the OTG port would result in:=0A=
OTG port you mean MicroAB, Correct?=0A=
dwc2 driver loaded when some device connected to OTG port?=0A=
And below message printed after disconnect the device from OTG port?=0A=
=0A=
>>> [   42.240973] dwc2 f72c0000.usb: dwc2_restore_host_registers: no host =
registers to restore=0A=
>>> [   42.249066] dwc2 f72c0000.usb: dwc2_host_exit_hibernation: failed to=
 restore host registers=0A=
>>>=0A=
>>> And the USB-host ports would not function.=0A=
USB-host ports - you mean 2 USB A-ports, connected to TS3USB221 HUB?=0A=
Switching ports between OTG and Host ports via TS3USB221 Switch =0A=
performing automatically or by some SW tool?=0A=
=0A=
>>>=0A=
>>> And plugging in the OTG port, we would see:=0A=
>>> [   46.046557] WARNING: CPU: 3 PID: 6 at drivers/usb/dwc2/gadget.c:260 =
dwc2_hsotg_init_fifo+0x194/0x1a0=0A=
>>> [   46.055761] CPU: 3 PID: 6 Comm: kworker/u16:0 Not tainted 4.17.0-rc5=
-00030-ge67da8c #231=0A=
>>> [   46.055767] Hardware name: HiKey Development Board (DT)=0A=
>>> [   46.055784] Workqueue: dwc2 dwc2_conn_id_status_change=0A=
>>> ...=0A=
>>>=0A=
>> Could you please send full log to debug.=0A=
> =0A=
> Full dmesg log attached.=0A=
> =0A=
> I unplugged the usb-otg port at 136=0A=
> and replugged it back in at 141=0A=
> =0A=
> =0A=
>>>        p->uframe_sched =3D false;=0A=
>>>        p->change_speed_quirk =3D true;=0A=
>>> +     p->power_down =3D false;=0A=
>>=0A=
>> power_down declared as int, suggested to update as follow:=0A=
>>          p->power_down =3D DWC2_POWER_DOWN_PARAM_NONE;=0A=
>>=0A=
>> This can be accepted as temporary solution until we will fully debug=0A=
>> hibernation feature for HiKey platform.=0A=
> =0A=
> Ok, will re-send with the suggested change above.=0A=
> =0A=
> thanks=0A=
> -john=0A=
> =0A=
=0A=
