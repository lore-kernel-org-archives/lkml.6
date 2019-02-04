Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC147C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC152082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278847;
	bh=lPoe+g7976HZM3Wflp+i3lOrzb9dHIxt0nGKNKriNho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L5HQTz8uMyezOAJOLu9S6JMx5EEtm1LgWwlqHN3tZlfHfNRLNvnwizVFbXxet4pcx
	 jMc5PsG8duqe9w09M/3RV+bYUB+2qZBH7votx2D3or5eknlHXxVlknRFzdw79wIluZ
	 ouIWsTbG1cvff9C/kVXSrndTzbPA3yhKlPh+bM1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfBDLOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:32788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfBDLOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:14:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A6320815;
        Mon,  4 Feb 2019 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549278844;
        bh=lPoe+g7976HZM3Wflp+i3lOrzb9dHIxt0nGKNKriNho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UT87ASq1R3rzxe+RMNbHMDfJ5zBNZKmk0zZUPGACd7ArtBrbx2cu/WF2aaoxOPqEF
         R5vRtoBqRKudTplqKTAZNRmVj9HuTmv0xSp92rcpkFeEFmC25hjRQgw+zAeSO5DITU
         wFQwKlUK3RIgMsUqSj3f880TLlTn9K7uu0rs65Kc=
Date:   Mon, 4 Feb 2019 12:05:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Emil Velikov <emil.velikov@collabora.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>
Subject: Re: [PATCH 1/2] staging/vboxvideo: don't set dev_priv_size = 0
Message-ID: <20190204110532.GB19811@kroah.com>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:31:13AM +0100, Daniel Vetter wrote:
> The compiler already clears this for us.
> 
> More important, someone might look what this is actually used for,
> and freak out about the dragon staring back at them.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Nicholas Mc Guire <der.herr@hofr.at>
> Cc: Emil Velikov <emil.velikov@collabora.com>
> Cc: Fabio Rafael da Rosa <fdr@pid42.net>
> ---
>  drivers/staging/vboxvideo/vbox_drv.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
