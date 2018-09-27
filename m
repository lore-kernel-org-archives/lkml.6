Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39960C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EF2216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMxkhYZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EF2216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeI1FEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:04:51 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36652 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1FEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:04:51 -0400
Received: by mail-oi1-f169.google.com with SMTP id p125-v6so3682053oic.3;
        Thu, 27 Sep 2018 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mVYNWuSjXdto/oU4h1FJrju/sv68BvjIZEJMVZP3A0k=;
        b=OMxkhYZ3c92tmN5yekixo+RuhECvU8ifP88vNZLv1RJJMpz3NE4GBol5w08KiVNMqp
         71aUfpwW8KLHfa2wRZjfC1LEYNcMdCSnQoZnmlZfa6XL+ZViG7JKj9Uz6T54+yVdxl6w
         XEdVTBxsbp8UBns9toxn9MhLwsb4rWqTTiKrZye0/8KPIcQzBkV/yZnm7q+/mDeELqrZ
         Q4XlpvAhg0DwDFNOXTObFUzA895rE1ANcldcbsETp1y9+H3RqZE9dmhKQqlx/ZJ9DZeh
         DOIpIJKT7WpYRGY+5s+SonGUroujs3gE5oAh/YYjQ0GsZ970hw+PV5zZdLvjv5wBOzIf
         tRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mVYNWuSjXdto/oU4h1FJrju/sv68BvjIZEJMVZP3A0k=;
        b=baKZFPRe97snd9Zm2w4XKVZgf9ONH9syOMqDeTwL91Y12TxZlD4EjH59evsz0w/xK9
         xcgT2p5AEl1PiJtjYjyz2M42bpC7bhzabOZB27/zomIKYFPVEIRyMebX3q7eHC7FZYux
         Hr6yjhLH2Pp61wVLxYL8V2BEqarMrOe91x1YngnvdEUioeQrusR6qGIRJnw/r377ViMp
         Ez55SOy/GuO6mKYXnLFircRspDRHq0TLcWbbYqzKHn7ggwXDmtLv9H/vXGpxP2dJ1/TK
         MJghcmRgOgSKHRJDzLopdKycr6Vid6XNmXUUl6H4ozrlkXbWldO++u89RbLJMdKuCIU8
         MENw==
X-Gm-Message-State: ABuFfohhDuAtZIbrX8lxEeQc1Sb+FoAXxWrgTc7mRMlVEuP/63bF5bgR
        3GRH6bBl9SO9wVfxkDzLFuBGLWLsGY2Rsnpxrk2uDAqn
X-Google-Smtp-Source: ACcGV61FAPJDu9SYTp69WuGHLYDXGlDwBenZ+23ZTIZF7ycf6wVtrDqNU3LbGSg/fb5bNTq6JiLqWfejxF7V56ZMDis=
X-Received: by 2002:aca:6c4f:: with SMTP id h76-v6mr4429243oic.214.1538088255411;
 Thu, 27 Sep 2018 15:44:15 -0700 (PDT)
MIME-Version: 1.0
From:   Ulf Magnusson <ulfalizer@gmail.com>
Date:   Fri, 28 Sep 2018 00:44:04 +0200
Message-ID: <CAFkk2KQ-sC=bAd9fCkOVPNmZn8m+EZfpZtirE+J5VpvW120sxQ@mail.gmail.com>
Subject: [ANNOUNCE] Kconfiglib menuconfig and documentation generation updates
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here's two small Kconfiglib (https://github.com/ulfalizer/kconfiglib) updates.

First, I've made it a lot easier to try out the menuconfig implementation on
the kernel. This will work now, in the kernel root:

  $ git clone https://github.com/ulfalizer/Kconfiglib.git
  $ git am Kconfiglib/makefile.patch
  $ make kmenuconfig

Here's an animation that demonstrates various menuconfig features:
https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/menuconfig.gif

Secondly, there's now a handy cross-referenced documentation generation script
available.

Example documentation output (warning: heavy page, lots of symbols):
https://docs.zephyrproject.org/latest/reference/kconfig/index.html

The script that generates the documentation:
https://github.com/zephyrproject-rtos/zephyr/blob/master/doc/scripts/genrest.py

The recently added Kconfig preprocessor has been implemented for a while now,
along with an extension that allows preprocessor functions to be defined in
Python.

I've also fixed some broken/incomplete behavior from the C tools, like not
being able to add symbols to choices by giving them a name and defining them in
multiple locations (though I think projects sometimes overdo multiple
definitions :). This is actually just a menuconfig hack that aggregates the
menu nodes from all choice definition locations when you enter a choice.

Zephyr and several smaller projects now use Kconfiglib exclusively.

Feedback appreciated!

Cheers,
Ulf
