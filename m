Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-168483-1522848844-2-15321903226160478971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522848844; b=tiedbr5yn7gZaHC9pD/bgx2IXrnHFSUdgOy7jxZnCeAf/dUPn8
    iGIYi/PJLktC0ZrMgVQCZeuaaa1K2d8xi8prVSsmrk+aP0Xb7lXAMspIeQyeNN04
    PNJn9NLEfMKnP/1UOfkDENYmgkDQfj1nBFj7Goag/J1FwF+0GSIzftBxS3h0ZhDq
    l0/C2faMXAgkcLHLjS+X3LjI+zWNN9W8MI9IrU3enNAFhLzZs8uYBq4dQiDlYKit
    DqvigddiwOR34XCfCoaLXf45C38EzlWOTfPVFqrA/h1uUJV4tv9mI1vURy2WZGpz
    5dIoop7u5XV+O+70OT08W2wvcu6bS8Lly+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522848844;
    bh=eFMlHiIjHWt7TCSAq6X2Wb5qEHvJgFtLUNu2NjErWxs=; b=oVTEhJSxU18f
    CXcYaEM3QDPo95k+TOB94zqRfQJ3PLsHJEm1KSsQOup0s9l05Aeb/PHuY9A6m7ot
    vXwKb8T3kpbnqD2thv4Y3NIzNv4lpOsYRXKbddbqy5QfinX3SNcwYDug59L7767G
    yj6PpXd77O8f53PWECjahjbHq1YxrR1JbxogOFG7qwgzXk1+quA8gyG+/dk3IyPr
    HUmhjroTBNGLFRgBDGWdSOCLKpF2nF7HqHbFG+aic6SK0ddeUyRp0b7/0rnRQPxy
    PISDQ/IQsKoq9wHxpUwidFBXdRIIshYjaIFwKjkRwD1QVxW55tlBEQkuCwhpE8VW
    B6MAv0kzIg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HmuZdx1O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a4jwzRLg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HmuZdx1O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a4jwzRLg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNvpVjBloY5m1LjJNK0uRVa3bLXZ7wCU+UuS5N1SC9BRVM0FH6BaYWvZbEKyDhqpvzxaNPKb+Ef6M90aOnR64zl0/a1LurVdk1/fsE96tJLCwU/diatb
    wCovStBbbkjtF1Z5y6tdXDfOV9erTpDAlovujKsGz9YghXRkb94bDEPXy+DMyTT+h6fohuwaYYle3rkNCYgDpTEqSyjV+uSbQ1OKuC21FKHPVn9QluI8mZS6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8b9GpE9nAAAA:8 a=QX4gbG5DAAAA:8 a=VwQbUJbxAAAA:8 a=jO5mabuwXh7oHejXD1gA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=T3LWEMljR5ZiDmsYVIUa:22
    a=AbAUZ8qAyYyZVLSsDulk:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeDDNdg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 09:33:36 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:38415 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeDDNde (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 09:33:34 -0400
X-Google-Smtp-Source: AIpwx4/rkLjWymEWQ1H65KYF7iymht+IRdG/k85/StFLGiPQRyCG3onpVYx84grRDZyVqhpyeYuRUrhAe0N5IE70VO8=
MIME-Version: 1.0
In-Reply-To: <2158461.zz8sS7CZ86@diego>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <20180326090001.57627-1-tomeu.vizoso@collabora.com> <2158461.zz8sS7CZ86@diego>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 4 Apr 2018 15:33:13 +0200
X-Google-Sender-Auth: PgSHV90QVGysqHZ3ucdMmcz0Dqc
Message-ID: <CAAObsKDAGC86EeQCQ5WzCi=VQmKe1Fs_Zhsaqf698d2tg9-fCw@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: open list <linux-kernel@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Could this patch be picked up, please?

Thanks,

Tomeu

On 26 March 2018 at 13:51, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> Am Montag, 26. M=C3=A4rz 2018, 11:00:01 CEST schrieb Tomeu Vizoso:
>> devm_regulator_get_optional returns -ENODEV if the regulator isn't
>> there, so if that's the case we have to make sure not to leave -ENODEV
>> in the regulator pointer.
>>
>> Also, make sure we return 0 in that case, but correctly propagate any
>> other errors. Also propagate the error from _dwc2_hcd_start.
>>
>> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus
>> supply") Cc: Amelie Delaunay <amelie.delaunay@st.com>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
