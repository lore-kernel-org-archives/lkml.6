Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13507C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7252086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kOzsVder";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nl8IjlmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7252086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeIJN0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:26:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39217 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727652AbeIJN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:26:21 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 611A521CB9;
        Mon, 10 Sep 2018 04:33:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 10 Sep 2018 04:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Qjc1zXmugchSaraIWDkK/T/xg1Q0/l5ZyeveNsfD8+A=; b=kOzsVder
        U0TD/TvC9eGRAcqVisgvfdvvi7eDKuzmxE2yn+idArFC0IEZvVM0uOoQCKs46Q7u
        K1x6sjI7ISc7fQ+HBjsf3N4XBiItf+9MiYvLUpMkMNe0pHKxlQVnBpbU9a+25e/D
        CsIhbRI9rhcQ+QmJrM1rF9gE9IuDLdGmeu8ozNciYnD74b/M/Jd/39X8SeasVo2r
        x0YZG/xkxu/ER/CGnCfVdtODPIC0vm6J9Y7A6QW5SeO/Tzev8vJ/ADJ5v9o2Rzuh
        DtUh9Uk6XhbPBC5mzK+/aC3336PordYg/mH3RoxusGcc/3/j2r7J3/8FAMq8RF9q
        wCriUpZt+XjBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=Qjc1zXmugchSaraIWDkK/T/xg1Q0/
        l5ZyeveNsfD8+A=; b=Nl8IjlmO/+21DCvSVYkxoyUJI4Ue0wjEJxLBalgdBVvjK
        IREy5PfTokbexaT3E0fOW5BCMfrtbRIXeonr1iJmgWIxh7IVTRvD3pBJvI2mCV10
        3EOAboHJW0JR9yVMRAEv+7JFYneC6ilPLKDK7nF/ZVOM06ellfdK85aIIKzGQUcD
        gHBtwV2wXbSIH6T65iehDwu4RkNgvqGymJu7QpryzIa8ft/UIc8GiLQx7TOJ0NDI
        Kii+Nvk5t/0uRaI9wSGC2OHlc7hxNWKR5anHQFQrlvasm1xH4PHZMTF8a2Xh3Nnx
        MVIuZp+J1cOKVxguP+iI0FMkJ3dStK63CP86zzCtA==
X-ME-Proxy: <xmx:VCyWW4qxJsWXdWMB7OIrpfisfm1kuCraI0mQIIGfxGkE6u4XLEO05w>
    <xmx:VCyWWw6YAQsYiog4UumkKzNLuXXXdfRQMDRpk2ZXpuL8wpxgTMfj1Q>
    <xmx:VCyWW_ctdlrIudLZhN9qJhwmSB38h8x4_W9FTGfKmQb5iVFjVsWZhw>
    <xmx:VCyWW17qANKGTv6pfJH00oZ3FAoXL-1l_I0C5auaudn7BIrHI2Za2w>
    <xmx:VCyWW2sSURdL2u2_FnV-M2OyU9VyWh1Y_T-ATm32P2ETlwuE1igwPA>
    <xmx:VCyWW800kQgWGmCf7wpjTRefDPKlHbRLgmnFSMKU7Kepi5BTiQ2gtg>
X-ME-Sender: <xms:VCyWW6zn99TureJmRvg-kCA69s5Tv9-Oos-xZ1wNkbcjsEQHVE17tA>
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92742E48FF;
        Mon, 10 Sep 2018 04:33:23 -0400 (EDT)
Date:   Mon, 10 Sep 2018 10:33:22 +0200
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     Ray Clinton <mr.ray.clinton@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: comedi: Correct multiline dereference as
 per TODO
Message-ID: <20180910083322.GA29149@kroah.com>
References: <CAPMnawtav+8OX4+iPA+RDBXJZ7OR==noksxxtNLzzTTCPcb-NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMnawtav+8OX4+iPA+RDBXJZ7OR==noksxxtNLzzTTCPcb-NQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:32:09PM -0400, Ray Clinton wrote:
> Hi,
> 
> I've been working on the correcting the checkpatch.pl failures found in
> staging/drivers/staging/comedi of 4.18.0 and have a few patches to submit
> for review.
> 
> The files that I changed are:
> 
> drivers/dt3000.c
> drivers/ni_labpc_common.c
> drivers/ni_mio_common.c
> drivers/dt3000.c
> 
> While there were a few warnings/checks checkpatch.pl brings up the only
> one that the Internet told me was ok to work on were dereferences that
> happened over multiple lines. For each of the files above that was the issue
> and it was always due to the author trying to stay within the 80 character
> line width limitation. I did my best to remove the warning while keeping the
> code readable.
> 
> **PLEASE**: any feedback on what I could do better in the patches, in the
> emails, anything, would be much appreciated.

You sent 4 patches with the identical Subject: line, which isn't
something that I can apply.  Please make the subjects unique, as they
all do unique things, right?

thanks,

greg k-h
