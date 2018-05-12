Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2004258-1526161386-2-14547950732383124185
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526161385; b=cGGk1jMTkkk3nn7Ovny/iA84inetUR6k7Rd7UlsdU7CN6ddCcU
    kM8qW6mZm3vP/nZpN7Af/oGU/kCz4euA348xpMllG2IgNpCgcMVi8rDe2+jqtD6S
    Vj7R6b67BrCtZiIQYbtzi6oNbuXytb99Eiw3YZULym12U10A1yAKP8iboE3pJFb2
    F1+jn8rAm38tTG7AM+puwf9mVNIlbEJan3uyeEmxM67KPphNBSIlLXOtwgflUama
    Pvfwit3URXEfoXrL5/1IenUWBxuv97CxHCCrOsrtDtQN+y0MQ0tC722nSb7QaPcR
    9/1WyXUXbjnxrryKRLaPzN8IFj5FokUPAt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526161385;
    bh=x07R/DoKh3YoLMjGHYvuohD2Bw8v9Sms1e6NWOyTYyI=; b=X2FktxOcUX+j
    Mfkc976Xu2iPXf0IzzkkcfTFMrvOZlniUe1I+ekEIBEb90oefD25Ba5S+Pe2M3xN
    K/2O9JBGS3sqjC5DsfhNwLfvmFdggqzUD1/C63PO+2ixIjZWVi/ggIQpSIVS1aiB
    ez2LC0b+gjS6tUlNYPKt1JwfbypBp2cEFPJBkkPdC37smAlACQ8X3Ue4nfCCvw2a
    Ldfvbn7jaSN25mMKCvJBhTRVJF7t4+BgTy5rr6kgt/s1kYk1QKbt2QD682PIy0fE
    Yeg6t+/amdLugdu3s74PBbw0J7DyWIhSru2M++S4CG7V8OsEG5XFYWlCTFa3xCxN
    xz0vWDyBGw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=ckq3cmTr x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=h/nC5/CZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=ckq3cmTr x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=h/nC5/CZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ5z0zrGl2taIlcMCC2MT8bvGD95IcEGyoUSgqMBvnmldee9Xu4F59pI+IxYggh6QP1KOgW8IUcWI/Th0yl40wgEuhDRcFxo48AwzC2aUHdllFBRF32c
    vI71Hq6fLoAwtUwGe1SC1ususNcf1FfphTK6B2XynU0i1s+UOOLSH2Db2/XNEZVCx9TGCRK0WIO7vdR77vZa6UzMzG5400VzPQeEY44FMdrzyf+32SMY9ngw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=OLL_FvSJAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=X1Zf5DBFUIsa1X5ofl8A:9
    a=sc6mgbmQs-_EJgeQ:21 a=UeyeAVEBq06Efh57:21 a=QEXdDO2ut3YA:10
    a=feEL07qbdoQA:10 a=x8gzFH9gYPwA:10 a=eT3a9dkrNrAA:10
    a=oIrB72frpwYPwTMnlWqB:22 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeELVmw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 17:42:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46348 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeELVmv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 12 May 2018 17:42:51 -0400
X-Google-Smtp-Source: AB8JxZpuakkeFjYH1gi6rWqqHXb0bIL2hpOuWUdU0x7NkONO/q6lOc76j2YjA7Gr1zSqE5CTtqnM2g==
Subject: Re: [RFC PATCH v3 0/5] usb: typec: Support for Alternate Modes
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f82856a4-5841-0656-e9a5-68b035ca91df@roeck-us.net>
Date: Sat, 12 May 2018 14:42:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/11/2018 06:18 AM, Heikki Krogerus wrote:
> Hi,
> 
> This is the third version of my proposal for more complete alternate
> mode support. In this version I'm including a proposal for the mux
> handling. Basically, I'm proposing that every supported alternate will
> have its own mux handle. That should allow us to support multiple
> alternate modes at the same time. There is also a small change to how
> I handled enter/exit mode commands. Now the alternate mode drivers
> will need to check if Enter Mode command ACK/NAK. The ->enter callback
> is not called in those cases separately. The typec_altmode_enter/exit
> functions are used only when the command is initiated. Other than
> that, only minor tuning.
> 

I like the both the idea and the approach. I browsed through the code,
but I don't see anything obviously wrong with it. Too bad I wont have
the time for an actual alternate mode implementation. Are you working
on one, by any chance ? I would like to see this move forward, and an
actual implementation would help to get there.

Thanks,
Guenter

> 
> v2 commit message:
> 
> This is second version of my proposal for more complete USB Type-C
> Alternate Mode support. The original proposal can be read from here:
> https://www.spinics.net/lists/linux-usb/msg161098.html
> 
> These patches now depend on series from Hans where he is introducing
> mux handling support for USB Type-C and USB in general:
> https://lkml.org/lkml/2018/3/2/340
> 
> The major difference compared to v1 is that I'm proposing change to
> the sysfs ABI we have for the alternate mode devices. The files are
> not changed, but they are moved to the parent directory from the
> mode<index> folder. Since the alternate mode devices are not yet used
> and in practice not supported in mainline, I felt brave enough to
> propose that.
> 
> The reason for removing the mode<index> folder is because as in patch
> 1/3 I now create a device for every mode of every SVID, there will
> never be more then one mode folder. I.e. the folder serves no purpose.
> The mode<index> is still kept for now, but it's just deprecated.
> 
> There are no alternate mode drivers included yet in this version.
> 
> 
> Original commit message (subject was "usb: typec: alternate mode
> bus"):
> 
> The bus allows SVID specific communication with the partners to be
> handled in separate drivers for each alternate mode.
> 
> Alternate mode handling happens with two separate logical devices:
> 1. Partner alternate mode devices which represent the alternate modes
>     on the partner. The driver for them will handle the alternate mode
>     specific communication with the partner using VDMs.
> 2. Port alternate mode devices which represent connections from the
>     USB Type-C port to devices on the platform.
> 
> The drivers will be bind to the partner alternate modes. The alternate
> mode drivers will need to deliver the result of the negotiated pin
> configurations to the rest of the platform (towards the port alternate
> mode devices). This series includes API for that, however, not the
> final implementation yet.
> 
> The connections to the other devices on the platform the ports have
> can be described by using the remote endpoint concept [1][2] on ACPI
> and DT platforms, but I have no solution for the "platform data" case
> where we have neither DT nor ACPI to describe the connections for us.
> 
> [1] Documentation/devicetree/bindings/graph.txt
> [2] Documentation/acpi/dsd/graph.txt
> 
> 
> Heikki Krogerus (5):
>    usb: typec: mux: Get the mux identifier from function parameter
>    usb: typec: Register a device for every mode
>    usb: typec: Bus type for alternate modes
>    usb: typec: pi3usb30532: Start using generic state values
>    usb: typec: tcpm: Support for Alternate Modes
> 
>   Documentation/ABI/obsolete/sysfs-class-typec |  48 ++
>   Documentation/ABI/testing/sysfs-bus-typec    |  51 ++
>   Documentation/ABI/testing/sysfs-class-typec  |  62 +--
>   Documentation/driver-api/usb/typec_bus.rst   | 136 ++++++
>   drivers/usb/typec/Makefile                   |   2 +-
>   drivers/usb/typec/bus.c                      | 423 +++++++++++++++++
>   drivers/usb/typec/bus.h                      |  38 ++
>   drivers/usb/typec/class.c                    | 472 ++++++++++++-------
>   drivers/usb/typec/mux.c                      |   6 +-
>   drivers/usb/typec/mux/pi3usb30532.c          |  11 +-
>   drivers/usb/typec/tcpm.c                     | 179 +++++--
>   include/linux/mod_devicetable.h              |  15 +
>   include/linux/usb/tcpm.h                     |   9 -
>   include/linux/usb/typec.h                    |  51 +-
>   include/linux/usb/typec_altmode.h            | 142 ++++++
>   include/linux/usb/typec_mux.h                |   2 +-
>   scripts/mod/devicetable-offsets.c            |   4 +
>   scripts/mod/file2alias.c                     |  13 +
>   18 files changed, 1347 insertions(+), 317 deletions(-)
>   create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
>   create mode 100644 Documentation/driver-api/usb/typec_bus.rst
>   create mode 100644 drivers/usb/typec/bus.c
>   create mode 100644 drivers/usb/typec/bus.h
>   create mode 100644 include/linux/usb/typec_altmode.h
> 

