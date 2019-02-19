Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1583C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8679F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550579735;
	bh=94KYfdjRTCoMl5GwVRsZK0Jb4ndcsByz3DsQnr3gjE0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=p7fpKUfzu/ibVwycv2I6hVcnpkiMF3oIXYeiymiqXFcvoWAZvDQZV6yedDsQWQUxS
	 p6WxNU89CVvrWbYMoq0quDB+hvwMZai8bXZlPOreMSON6yVj1liJPowa4SNEjNaeBQ
	 NT7jIJPBU+NYBCFK+L5KEpX2v3SaxyxPePvzqAGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfBSMfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSMfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:35:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62902146F;
        Tue, 19 Feb 2019 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550579733;
        bh=94KYfdjRTCoMl5GwVRsZK0Jb4ndcsByz3DsQnr3gjE0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=COwXW/0s5oKwObjG2fvLa56kfhh2dfiaMBFnpk4bRhwE9Mlctl1AblxT6JUkYl7rA
         S4MH5yexxPrirBRrx6oN6+SU/n15MkTZ78FxEBSdUsvnXGS3yYtkHzXKPiaBqQRBhx
         hdava1MVFInmVTAWScnfRTdJrIqyyfnvlXsDva5c=
Date:   Tue, 19 Feb 2019 13:35:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dim-tools@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PULL] topic/mei-hdcp
Message-ID: <20190219123530.GA4626@kroah.com>
References: <20190219071619.GA11016@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219071619.GA11016@phenom.ffwll.local>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 08:55:27AM +0100, Daniel Vetter wrote:
> Hi all,
> 
> topic/mei-hdcp-2019-02-19:
> Prep patches + headers for the mei-hdcp/i915 component interfaces
> 
> Also contains the prep work in the component helpers plus adjustements
> for the snd-hda/i915 component interface.
> 
> Plus one small static inline in the drm_hdcp.h header that both i915
> and mei_hdcp will need.
> 
> Joonas, please pull into drm-intel-next-queued so I can apply the i915
> hdcp patches.
> 
> Greg/Arnd, I think there's two options to get the mei-hdcp patches landed
> into drivers-misc:
> - You pull this topic pull and then apply the mei-hdcp patches on top in
>   char-misc-next.
> - I also pull in char-misc-next to get at 32ea33a04484 ("mei: bus: export
>   to_mei_cl_device for mei client devices drivers") and then apply all the
>   mei-hdcp stuff into a new topic branch.
> 
> I think 2nd option would be better, allows us to integration test easier,
> and we'll have a topic branch in case we need a fixup spanning mei-hdcp
> and i915. Also would allow me to start merging the patches, since I think
> it's too late for 5.1.

No objection from me, pull away!

greg k-h
