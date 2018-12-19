Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5932F218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rW/9IbiE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yEmFog/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeLSPGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:06:09 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35015 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbeLSPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:06:08 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 19DAE21BC4;
        Wed, 19 Dec 2018 10:06:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 Dec 2018 10:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wMqe4oHeF7qvj89izhHwd37gQVY
        wsCmKRVlt429pDPI=; b=rW/9IbiEeTKL10Z6iCguGrB4vsfzEM6Dl3/GudRqbJO
        ILcngeqA3bdYwY1FpAzApWO1lGVsiSjN6lMKUoCaA187270YRwJ1P8KCqjFOW+mm
        V9CWm2gmXd2lWbN5G61oJtpAoYyL4PhB/06hWZ5MRTh6+Jw6YQSpUMch2axt+FVC
        yv489rfe/xpZA4FTXPOmiT/chpMY/pfmEpQFzIRQc0iywuA0h3/7NnyxtdYIiqY4
        WZwAHKgRNr54iNAlNAaI/uq6ICvA8TAM4LSpOSVrCGi5Q4jYpPTJQgaCSl/LqcTz
        AULHdUY7dVCXzTlGG0p1tQiY9oX5ooRPl6jebFlYxKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wMqe4o
        HeF7qvj89izhHwd37gQVYwsCmKRVlt429pDPI=; b=yEmFog/WoAdnc7xT2kcDmi
        +H7XW6JivVAj/7/rgnIzCJ+ABPOQTxpK40I6SoZKbTL0ltHkIRRV1EFMU3zeC0cX
        2yVaxHoYqEb8UWy6OfKiEW7w7CfobK5iF5WTfHr/0QfjAAWhkjAMty9CaCzgp54E
        M5dVFBGLeDQvwf4pHc7joyF5blAJBK0luH8NbcNVF7R2lVFw1pqEegi3aecpcapn
        W9nZw8CNXEXk7kQBNtVdoEH+AMq0HuQsEP+CsvDAt0Au71gr1zN9joKY/XwiYY7E
        0o6Rrc9pUwiR+TFfUxjTkCIs0hckneWDXC0fJi0iIp/3CuuaPX3Ll8jrYmyhYmFA
        ==
X-ME-Sender: <xms:Xl4aXLqCZNtCrlB65Yo5FJO6ev9QE8rzVMSA2eJP3MtqwrNoLz6HCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudejtddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomh
    epifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeei
    rdekledruddtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Xl4aXMHmgJC45mzVbsCb1j8oAVxmTx9WI78ku8P9fXed_5u-wq6VDg>
    <xmx:Xl4aXFtaLjiiMhd7hqqOoCD0XWBctiwArmh71YRJYeIO-b0ubrGNfw>
    <xmx:Xl4aXHRIiEV2J5Fj8CZM-M0KRXZ37ygeDOmIFPkLjui7QtNVFZF8aA>
    <xmx:X14aXF8c2-Yk3SlI37-5Bbh_PX_--5WSsDC6XfPPxNHBeGD5tjCMvA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D70BB102A0;
        Wed, 19 Dec 2018 10:06:05 -0500 (EST)
Date:   Wed, 19 Dec 2018 16:06:04 +0100
From:   Greg KH <greg@kroah.com>
To:     Praveen Kumar <kpraveen.lkml@gmail.com>
Cc:     kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/modules not showing any output
Message-ID: <20181219150604.GB25653@kroah.com>
References: <CABcWhv5QApdqti+fhGuH-3puhk89n2jgfziV2zG3H8Y59RE63A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABcWhv5QApdqti+fhGuH-3puhk89n2jgfziV2zG3H8Y59RE63A@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 06:52:39PM +0530, Praveen Kumar wrote:
> Hi All,
> 
> Compiled the vanila kernel 4.20.0-rc6 build, and was trying to get
> module information, but /proc/modules is not showing any output ( both
> on arm64 and x86_64 )
> 
> root@ubuntu:~# uname -a
> Linux ubuntu 4.20.0-rc6-00082-g65e08c5e8631 #7 SMP PREEMPT Fri Dec 14
> 15:54:30 IST 2018 aarch64 aarch64 aarch64 GNU/Linux
> 
> root@ubuntu:~# cat /proc/modules
> root@ubuntu:~#
> 
> Tried with older version 4.4.162-78-default modules were properly shown.
> 
> Can you please help if there is something which I am missing during
> compilation or is there any potential bug here ? Thanks in advance.

Are you sure your .config file has enabled modules?  Have you actually
loaded any?  If you do not load any, nothing will show up in that proc
file :)

thanks,

greg k-h
