Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-61510-1524317904-2-7424709475565743366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524317903; b=k4jRFcgdv1IW/YaCjYY4EuaRRCqa4wiamcl9o3LIYcoMIdQhDo
    iimsQ49jA9ea8h6VojHGQ+LKyuaxN1+3Cx15fafhJ0rfVSLf22MNfog4WSnh2CMg
    2SJCG0VUnmWfK4YYYHgMRxAZT+mcWgyQzI+aImL5wgi5oXyghVQ/auLL5t4iQ5K5
    Pu6Gf/cTWZhFhCvGVFin1uTOLUAx4DUbJsOBPoafoDRykUSXfPlNeS8zt5Hv2lZi
    WT9q6jQGuy+k5IbrMcLe2CrHmmkZThl4P31VKl/4c1k5w0ts2E0htzoXIamd/b3K
    ZkDMChT6ucnb8oV/tPx+kfyft47mD8TWWzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524317903; bh=0Me5g32u/Yl3/RiKhsnBJ3igxyeDIIRFRMC8J/yiLA
    U=; b=dNkf6CvITsIyZ4+pX+i7vq+H/4yIc0Lf5GNQjsT1Ldehi6bCGxsOfB0+Fi
    4SuNbCLYk+JJUnkbP2l5jNdM0WsPz4LwLYRcmbHO8RMkb0YBlVzl+dcwD12fBqA3
    3pp5X4rfLuGxQjTJg7CO1FnKIvd0m4hzYuNrZashtdY90nGVF1UOLDH4SPG8Luiz
    RS3+6BfJBhpqimmCTwZk0pOK8YZDMndD/ypTfS3P2JTSZw2NxN4YCdXtbeFqT+4v
    yGfVtzuRlPxZnuq5NUfMogckefR1ExsNXMyNUVel14gzs4C6EoTRc8TiEb7UazQd
    loxDeoE3Ndk6w/KJHjqKXWWeRa6g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=FYttoztN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qz45LbPj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=FYttoztN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qz45LbPj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLf9/NnskxpFdPMxtlJ0wpLpd/5Vp0SflmC0q07ainZUDBuKn+EYnUF/3Cyuw8tlQMm4AAdKZqGi5LBm6dH5lZwmX84VvHI7lKu7FZji06cpy3NsnrKd
    nP2qCE7v+LU5yjAWPeo27YOtBkQtChgO0+ZRkX6Bq9W5lwHG94cvQKHkdJcMF5QltyVv/yUuv9XQD30r2mBjdl+PzuegylNDn57ScxegSzAf/3Pl5HNQiKyn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=QCP6XK_uHr33rWS_clQA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeDUNiJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 09:38:09 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:45114 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752683AbeDUNiI (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 21 Apr 2018 09:38:08 -0400
X-Google-Smtp-Source: AIpwx4//CKpeEJ+7nDaH028PKZREthyyvQZUKw626yS2n1dH3j64Dfi0M66Pu3NZUuOfBFi1lHmiv2CVp1k+lzePbuQ=
MIME-Version: 1.0
In-Reply-To: <20180421085956.GA8081@kroah.com>
References: <Pine.LNX.4.44L0.1804201325430.1407-100000@iolanthe.rowland.org>
 <20180420180821.194380-1-ravisadineni@chromium.org> <20180421085956.GA8081@kroah.com>
From: Ravi Chandra Sadineni <ravisadineni@google.com>
Date: Sat, 21 Apr 2018 06:37:46 -0700
Message-ID: <CAOGSYL00=h-1x=jWuYQ8ucuOE79KN-17L-cCt8Tf1nCNioQxwA@mail.gmail.com>
Subject: Re: [PATCH V5] USB: Increment wakeup count on remote wakeup.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        chunfeng.yun@mediatek.com, johan@kernel.org,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Anton Bondarenko <anton.bondarenko.sama@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        mathias.nyman@linux.intel.com, felipe.balbi@linux.intel.com,
        Eugene Korenevsky <ekorenevsky@gmail.com>, peter.chen@nxp.com,
        joe@perches.com, Todd Broch <tbroch@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sure. Pushing it to the older kernels will definitely help.

Thanks,
Ravi

On Sat, Apr 21, 2018 at 1:59 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Apr 20, 2018 at 11:08:21AM -0700, Ravi Chandra Sadineni wrote:
>> On chromebooks we depend on wakeup count to identify the wakeup source.
>> But currently USB devices do not increment the wakeup count when they
>> trigger the remote wake. This patch addresses the same.
>>
>> Resume condition is reported differently on USB 2.0 and USB 3.0 devices.
>>
>> On USB 2.0 devices, a wake capable device, if wake enabled, drives
>> resume signal to indicate a remote wake (USB 2.0 spec section 7.1.7.7).
>> The upstream facing port then sets C_PORT_SUSPEND bit and reports a
>> port change event (USB 2.0 spec section 11.24.2.7.2.3). Thus if a port
>> has resumed before driving the resume signal from the host and
>> C_PORT_SUSPEND is set, then the device attached to the given port might
>> be the reason for the last system wakeup. Increment the wakeup count for
>> the same.
>>
>> On USB 3.0 devices, a function may signal that it wants to exit from device
>> suspend by sending a Function Wake Device Notification to the host (USB3.0
>> spec section 8.5.6.4) Thus on receiving the Function Wake, increment the
>> wakeup count.
>>
>> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
>> ---
>>
>> V5: Added the description of changes between different versions of patches.
>> V4: Moved the wakeup count increment logic to the existing if which is
>> safegaurded by hcd_root_hub_lock spinlock.
>> V3: Added a gaurd to check if rh_registered is set before accessing
>> root_hub pointer.
>> V2: Fixed the build failure error due to uninitialized dev pointer.
>
> Is this needed in older kernels?  Should I submit it to the stable
> trees?
>
> thanks,
>
> greg k-h
