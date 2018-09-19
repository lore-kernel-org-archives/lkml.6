Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6E1ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E057C20858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E057C20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbeITDjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:39:11 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45834 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeITDjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:39:11 -0400
Received: by mail-qt0-f195.google.com with SMTP id l2-v6so1488293qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=XSdA0lrXGE/cJphbsqCiv/b4vdMeX3q4JFPTlEWK3SM=;
        b=QsgJWdIny99aNqL1OY2L17oLTsuT0rzFbg3UhqlSysr1NS/mVmNA4WeDr+N//q3T93
         BlZNUHwurS7ZNZcWT/cq7AeWoZCqhRSwXIjgSuM/o6+ARMTrMQvo4Hm32P4W4y6mBmX1
         GJud4J8DI0oNxjdgXc2KbsAPKLjjKarrBBRmdAju7fDQUScyV1Vec59FZc+WXsOoGH6o
         sKnShQgZb+lc5PRsu6Y37xbaDm6uNeApiQMoqzE7/BgLP2mw9b3nV2Hjjn6g2YzRGth8
         /mINTcOcnuG3MMwLVtpg7ofTmtskFpDBx45qT/0vWL6OPzNwWuOtev0Ugz2nLtAE/wob
         5kNA==
X-Gm-Message-State: APzg51C6z9ivCMT7F+2844MXRnNOArXkHRsXOJZyharq9FmN4ARFDlxz
        6BRlQnE4oAG4irjjDfALJQpuY2ldYEQ=
X-Google-Smtp-Source: ANB0VdbIXDkgIKNQakjaF6/KAPevOU4pbZX3r22Kh7gMVLe54jxnpYESLeZc/9MCR7jLs9ussup06A==
X-Received: by 2002:ac8:4283:: with SMTP id o3-v6mr23074763qtl.28.1537394355050;
        Wed, 19 Sep 2018 14:59:15 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id 39-v6sm4715312qku.18.2018.09.19.14.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 14:59:14 -0700 (PDT)
Message-ID: <c6ab617cee62c08ce5f81992e62d92dd6805cf7c.camel@redhat.com>
Subject: Re: [PATCH 1/6] drm/dp_mst: Introduce
 drm_dp_mst_connector_atomic_check() (fwd)
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Julia Lawall <julia.lawall@lip6.fr>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sean Paul <sean@poorly.run>,
        kbuild-all@01.org
Date:   Wed, 19 Sep 2018 17:59:13 -0400
In-Reply-To: <alpine.DEB.2.21.1809192237110.2433@hadrien>
References: <alpine.DEB.2.21.1809192237110.2433@hadrien>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oh, good catch! will fix and respin in just a little bit

On Wed, 2018-09-19 at 22:38 +0200, Julia Lawall wrote:
> Hello,
> 
> I don't think you can update the loop index variable in
> list_for_each_entry, because the mcro uses th index variable to get to the
> next element.  Perhaps list_for_each_entry_safe would be more suitable?
> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Thu, 20 Sep 2018 04:30:13 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [PATCH 1/6] drm/dp_mst: Introduce
>     drm_dp_mst_connector_atomic_check()
> 
> CC: kbuild-all@01.org
> In-Reply-To: <20180918230637.20700-2-lyude@redhat.com>
> References: <20180918230637.20700-2-lyude@redhat.com>
> TO: Lyude Paul <lyude@redhat.com>
> CC: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
> intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
> CC: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, 
> stable@vger.kernel.org, Sean Paul <sean@poorly.run>
> 
> Hi Lyude,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on drm-intel/for-linux-next]
> [also build test WARNING on v4.19-rc4 next-20180919]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system]
> 
> url:    
> https://github.com/0day-ci/linux/commits/Lyude-Paul/Fix-legacy-DPMS-changes-with-MST/20180919-203434
> base:   git://anongit.freedesktop.org/drm-intel for-linux-next
> :::::: branch date: 8 hours ago
> :::::: commit date: 8 hours ago
> 
> > > drivers/gpu/drm/drm_dp_mst_topology.c:3144:1-20: iterator with update on
> > > line 3145
> 
> # 
> https://github.com/0day-ci/linux/commit/f8df31d5221b9a6da6698d4a37e622253bb17cdc
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout f8df31d5221b9a6da6698d4a37e622253bb17cdc
> vim +3144 drivers/gpu/drm/drm_dp_mst_topology.c
> 
> 3f3353b7 Pandiyan, Dhinakaran 2017-04-20  3131
> f8df31d5 Lyude Paul           2018-09-18  3132  static bool
> f8df31d5 Lyude Paul           2018-09-
> 18  3133  drm_dp_mst_connector_still_exists(struct drm_connector *connector,
> f8df31d5 Lyude Paul           2018-09-18  3134  				
>   struct drm_dp_mst_topology_mgr *mgr,
> f8df31d5 Lyude Paul           2018-09-18  3135  				
>   struct drm_dp_mst_branch *mstb)
> f8df31d5 Lyude Paul           2018-09-18  3136  {
> f8df31d5 Lyude Paul           2018-09-18  3137  	struct drm_dp_mst_port
> *port;
> f8df31d5 Lyude Paul           2018-09-18  3138  	bool exists = false;
> f8df31d5 Lyude Paul           2018-09-18  3139
> f8df31d5 Lyude Paul           2018-09-18  3140  	mstb =
> drm_dp_get_validated_mstb_ref(mgr, mstb);
> f8df31d5 Lyude Paul           2018-09-18  3141  	if (!mstb)
> f8df31d5 Lyude Paul           2018-09-18  3142  		return false;
> f8df31d5 Lyude Paul           2018-09-18  3143
> f8df31d5 Lyude Paul           2018-09-18 @3144  	list_for_each_entry(port
> , &mstb->ports, next) {
> f8df31d5 Lyude Paul           2018-09-18 @3145  		port =
> drm_dp_get_validated_port_ref(mgr, port);
> f8df31d5 Lyude Paul           2018-09-18  3146  		if (!port)
> f8df31d5 Lyude Paul           2018-09-18  3147  			continue
> ;
> f8df31d5 Lyude Paul           2018-09-18  3148
> f8df31d5 Lyude Paul           2018-09-18  3149  		exists = (port-
> >connector == connector ||
> f8df31d5 Lyude Paul           2018-09-18  3150  			  (port-
> >mstb &&
> f8df31d5 Lyude Paul           2018-09-18  3151  			   drm_d
> p_mst_connector_still_exists(connector, mgr,
> f8df31d5 Lyude Paul           2018-09-18  3152  					
> 		     port->mstb)));
> f8df31d5 Lyude Paul           2018-09-18  3153
> f8df31d5 Lyude Paul           2018-09-18  3154  		drm_dp_put_port(
> port);
> f8df31d5 Lyude Paul           2018-09-18  3155  		if (exists)
> f8df31d5 Lyude Paul           2018-09-18  3156  			break;
> f8df31d5 Lyude Paul           2018-09-18  3157  	}
> f8df31d5 Lyude Paul           2018-09-18  3158
> f8df31d5 Lyude Paul           2018-09-18  3159  	drm_dp_put_mst_branch_de
> vice(mstb);
> f8df31d5 Lyude Paul           2018-09-18  3160  	return exists;
> f8df31d5 Lyude Paul           2018-09-18  3161  }
> f8df31d5 Lyude Paul           2018-09-18  3162
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

