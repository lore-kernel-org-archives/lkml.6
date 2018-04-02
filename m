Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeDBXXt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:23:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:7787 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeDBXXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:23:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,397,1517904000";
   d="scan'208";a="29600029"
From: "Pandiyan, Dhinakaran" <dhinakaran.pandiyan@intel.com>
To: "lyude@redhat.com" <lyude@redhat.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [Intel-gfx] [PATCH v5 04/10] drm/dp_mst: Remove all evil
 duplicate state pointers
Thread-Topic: [Intel-gfx] [PATCH v5 04/10] drm/dp_mst: Remove all evil
 duplicate state pointers
Thread-Index: AQHTytmlqZMEUtTlhkevI0UOVXQ3zw==
Date: Mon, 2 Apr 2018 23:23:45 +0000
Message-ID: <1522712898.10101.49.camel@dk-H97M-D3H>
References: <20180402224800.16080-1-lyude@redhat.com>
         <20180402224800.16080-5-lyude@redhat.com>
In-Reply-To: <20180402224800.16080-5-lyude@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.17]
Content-Type: text/plain; charset="utf-8"
Content-ID: <75970147815C6B40843A8732E555C61C@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32NNqxn025366

On Mon, 2018-04-02 at 18:47 -0400, Lyude Paul wrote:
> There's no reason to track the atomic state three times. Unfortunately,
> this is currently what we're doing, and even worse is that there is only
> one actually correct state pointer: the one in mst_state->base.state.
> mgr->state never seems to be used, along with the one in
> mst_state->state.
> 

Looks like the redundancy got introduced when struct drm_private_state
was added.

Reviewed-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>

> This confused me for over 4 hours until I realized there was no magic
> behind these pointers. So, let's save everyone else from the trouble.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>.
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  include/drm/drm_dp_mst_helper.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 41a8f08da05d..035963fbcd9d 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -409,7 +409,6 @@ struct drm_dp_payload {
>  struct drm_dp_mst_topology_state {
>  	struct drm_private_state base;
>  	int avail_slots;
> -	struct drm_atomic_state *state;
>  	struct drm_dp_mst_topology_mgr *mgr;
>  };
>  
> @@ -497,11 +496,6 @@ struct drm_dp_mst_topology_mgr {
>  	 */
>  	int pbn_div;
>  
> -	/**
> -	 * @state: State information for topology manager
> -	 */
> -	struct drm_dp_mst_topology_state *state;
> -
>  	/**
>  	 * @funcs: Atomic helper callbacks
>  	 */
