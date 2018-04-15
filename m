Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeDOWZZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 18:25:25 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:48318 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDOWZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 18:25:24 -0400
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1523831124; a=rsa-sha256;
        cv=none;
        b=bYgnlQUnYC8H9Y22tEPtQUnIaEbGNmUluxmmnm4dDEATgHDhkWlQ94Sc1t45aF4GK5nqhc1AfnkDzpSFL2DSnh6dyKw2yP7VdruL9exwl8Z0WxtAMSESdavfcZ0KwwFpS+oN0mez8sJCGAxZJ93uYBH71S/uPRcqlOAl7mt2xOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1523831124;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=mULl4NtigtnlCQSIdqHnjwB/gY6ou5IL8zcM5A/0W+0=;
        b=K2jTp2dyzA88REGkka19E8yFC93Z2+TNOUbzVeImUNZHfMOWsxCJtPi2khdvxdirkz8Is4
        vuyrzAmrNu3NJT9PkHgGwjrS/0diAKfvp0X6hNz0GKTCX3oSRSlu9QK9Y00y7eNw7gAGfP
        Zs+aGE0EIggGZy+JNWwCO1pYGJL4tXk=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 9164733ADA5
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Passing luks passphrase from grub to systemd
Date: Mon, 16 Apr 2018 00:25:22 +0200
Message-ID: <2907407.5HaPOCmciK@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> as I'm stuck with a (non-EFI x86_64) system with encrypted root
> partition, I have to enter the passphrase twice (grub needs it for
> getting the kernel etc., systemd needs it for mounting the root
> partition). This can be quite inconvenient, especially if the passphrase
> is long and contains special characters, and grub assumes a different
> keyboard layout.

Just fill another LUKS slot with a randomly generated key file and add that 
file to your initramfs (which already resides on encrypted /boot, right?). If 
your distro cannot do that, you should probably fixing things there, not 
adding ugly hacks to the kernel.

Check how it is implemented in Arch, for instance [1]. I'm not sure whether 
this is currently possible with openSUSE, though.

Regards,
  Oleksandr

[1] https://klmlinks.wordpress.com/2016/03/
