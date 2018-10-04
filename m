Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0229BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CED320877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATNLXE7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CED320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeJEEN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:13:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45227 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJEEN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:13:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so11397896wrw.12;
        Thu, 04 Oct 2018 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WT0xwDE2k48UmpozmoHuJLxV7m7Uv4n+3lX6lFZSCBQ=;
        b=ATNLXE7G2A1+3p91ehPazwa/rpMdi4Y0aB68xMcvoKSZNGMpBOYT2Jj5W1D5gKpHKv
         CnwEvNcMDOYdEG7kIkJRGKFo9TaNGMbGkoA9hSe650TFtJ0lTZP8H7rSEbSH90PMOZq9
         aDmffOT3s/9vP1cceAGYbPEEgwi1j0DIs+BmCXu3p0UmYSESCrPKcVXrkd2KxZLwQDK3
         K8eeP6uZmCfFZ221bnqUCGps9r/DBqG+z8WazHQR9FQnIcYJOkwkhWlI8FLdJN5Aq+0N
         MoKFJkTk4xaHfrmIDIvZDvJRH0JnBvHZ3LIUMdq00v/yyaHr5zkUsbQKybZnV7L64yNO
         49/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WT0xwDE2k48UmpozmoHuJLxV7m7Uv4n+3lX6lFZSCBQ=;
        b=psz6XW1lOad3O4MU69jiV5pxUsd68YoePouxZAgwTB/9ZG004ZiqU4AvhpLUe2WJLP
         a+u7qcUfWP+AThXXwOFgte/yV+Ff9UZKWPVRaJPp/3xbCxAATm7VPodt9f6PsqfQevEm
         tX2dPlynMbjP1vhZ8sEwOVdYmdmgBmTreAci2UtljCJ3TXmOpvd7peUsZrhumniAagXZ
         RviLE3FvKK26s8jrszKmDxu9aRku0Cxshutohm197iKUNHz5H2XfDkJJIbOQfcJ/Bdj4
         FSo9SXatl0u+BB1XBiCRRciufwuim1Kjmp7xlnv76gQz75YLFI/1XulzASg9p+OCsDGm
         MgQA==
X-Gm-Message-State: ABuFfoi1kKWyo2fXDut03T1gEsWZG9O8l24fOuWBVUbLlzBH9W4SMtdn
        7joDNoqgF/48J4x3VPJv2QA=
X-Google-Smtp-Source: ACcGV60wD+HG1BIMUvukyGHpBdypsTloA7PUrvK30z931U1lgcQLnfEmfOd5irKTEGLHOnxRn8q7ug==
X-Received: by 2002:a5d:67c8:: with SMTP id n8-v6mr6065657wrw.196.1538687926735;
        Thu, 04 Oct 2018 14:18:46 -0700 (PDT)
Received: from Ettosoft-T55 (208-202-243-213.terrecablate.net. [213.243.202.208])
        by smtp.gmail.com with ESMTPSA id t194-v6sm8476051wmd.48.2018.10.04.14.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 14:18:46 -0700 (PDT)
Date:   Thu, 4 Oct 2018 23:18:44 +0200
From:   ektor5 <ek5.chimenti@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     hverkuil@xs4all.nl, luca.pisani@udoo.org, jose.abreu@synopsys.com,
        sean@mess.org, sakari.ailus@linux.intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/2] Add SECO Boards CEC device driver
Message-ID: <20181004211842.qxfvojrcbsl7llsx@Ettosoft-T55>
References: <cover.1538474121.git.ek5.chimenti@gmail.com>
 <757ab7a8-4bb2-4573-5870-eae2b9745650@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757ab7a8-4bb2-4573-5870-eae2b9745650@baylibre.com>
User-Agent: NeoMutt/20180716-421-ff8684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:29:32PM +0200, Neil Armstrong wrote:
> Hi Ettore,
> 
> On 02/10/2018 18:59, ektor5 wrote:
> > This series of patches aims to add CEC functionalities to SECO
> > devices, in particular UDOO X86.
> > 
> > The communication is achieved via Braswell SMBus (i2c-i801) to the
> > onboard STM32 microcontroller that handles the CEC signals. The driver
> > use direct access to the PCI addresses, due to the limitations of the
> > specific driver in presence of ACPI calls.
> > 
> > The basic functionalities are tested with success with cec-ctl and
> > cec-compliance.
> 
> Glad to see another user of the i915 cec notifier !

Thanks to you for the patch! It works really well!

Ettore

> 
> Neil
> 
> > 
> > Ettore Chimenti (2):
> >   media: add SECO cec driver
> >   seco-cec: add Consumer-IR support
> > 
> >  MAINTAINERS                                |   6 +
> >  drivers/media/platform/Kconfig             |  21 +
> >  drivers/media/platform/Makefile            |   4 +
> >  drivers/media/platform/seco-cec/Makefile   |   1 +
> >  drivers/media/platform/seco-cec/seco-cec.c | 859 +++++++++++++++++++++
> >  drivers/media/platform/seco-cec/seco-cec.h | 143 ++++
> >  6 files changed, 1034 insertions(+)
> >  create mode 100644 drivers/media/platform/seco-cec/Makefile
> >  create mode 100644 drivers/media/platform/seco-cec/seco-cec.c
> >  create mode 100644 drivers/media/platform/seco-cec/seco-cec.h
> > 
> 
