Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967227AbeEYQOm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:14:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34763 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966725AbeEYQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:14:39 -0400
X-Google-Smtp-Source: ADUXVKK0+c1rQoY800n90FpSQd+2xGdCOdz8qrkznVJDFVqQyXPi+chyERvgYZS2UdnIqLIPl9J2tqLJmURFPrNIoVM=
MIME-Version: 1.0
In-Reply-To: <20180525155228.GA17043@kroah.com>
References: <20180525153841.3314617-1-arnd@arndb.de> <20180525155228.GA17043@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 25 May 2018 18:14:37 +0200
X-Google-Sender-Auth: RDoT-0Q2lfVcKnRasKWWpaSf8_Q
Message-ID: <CAK8P3a0g6gz=nSgPx3y+_XHM0VkdgSdZepws+XN5Mk95y7i0Zg@mail.gmail.com>
Subject: Re: [PATCH] staging: typec: rt1711h: fix tcpci dependency
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        ShuFan Lee <shufan_lee@richtek.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 5:52 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, May 25, 2018 at 05:38:25PM +0200, Arnd Bergmann wrote:
>> Using 'select' instead of the normal 'depends on' causes
>> a build issue with CONFIG_I2C=m:
>>
>> WARNING: unmet direct dependencies detected for TYPEC_TCPCI
>>   Depends on [m]: STAGING [=y] && TYPEC_TCPM [=y] && I2C [=m]
>>   Selected by [y]:
>>   - TYPEC_RT1711H [=y] && STAGING [=y] && TYPEC_TCPM [=y]
>>
>> Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/staging/typec/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I think that this is already fixed in linux-next with some patches that
> I queued up there yesterday.  When did you last see this problem?

It's on linux-next, but since there hasn't been a release this week,
I'm sure you are right that this was already fixed.

      Arnd
