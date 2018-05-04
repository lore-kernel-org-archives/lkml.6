Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEDJCT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:02:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50097 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeEDJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:02:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180504090215epoutp03b8dcb794d62906c656159dbd45c3bfd3~rZYhbPpaO1119111191epoutp03M
X-AuditID: b6c32a4b-19dff70000001094-c0-5aec2196806b
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: liviu.dudau@arm.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>
Subject: Re: [PATCH v1] drm/kms/mode: added a new helper for calculating
 videomode from crtc's display mode
Date: Fri,  4 May 2018 14:32:03 +0530
Message-Id: <1525424523-3367-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525419600-1774-1-git-send-email-satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmhu40xTdRBmubtCyufH3PZrHp8TVW
        i8u75rBZHFjazmKx9nwriwOrx5p5axg97ncfZ/LYvKTeo2/LKkaPz5vkAlijUm0yUhNTUosU
        UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
        9O1sivJLS1IVMvKLS2yVog0NjfQMDcz1jIyM9ExMY62MTIFKElIzDnbcZi3YLlFxt/8pcwPj
        ceEuRk4OCQETie1ve9i6GLk4hAR2M0rce7QIyvnEKNG88CGU841R4uaxM4wwLT/eH2WBSOxl
        lFi8sY0RwvnKKDF9+QxWkCo2oKrncyBsEYE6iQUvHoJ1MwsYSSx9vp4ZxBYWyJVoanzPBmKz
        CKhKLOltAavhFXCV2HJ5GRPENjmJm+c6weo5Bdwk5nesBdssITCBTWLb8x9sEEUuEk2LF7NC
        2MISr45vYYewpSQ+v9vLBtHQzCjxYN1Cdginh1Gio/MYVJW9RMuUA0BjOYDO05RYv0sfImwr
        sWlfI9TVfBK9v58wgZRICPBKdLQJQZSoSKx8cZgZZtefBV1QN3hIbLrcywJhO0r8n38FGlwz
        GSWWX21ln8AoPwth2wJGxlWMkqkFxbnpqcWmBcZ5qeV6xYm5xaV56XrJ+bmbGMHpTMt7B+Om
        cz6HGAU4GJV4eHfYvo4SYk0sK67MPcQowcGsJMI76xBQiDclsbIqtSg/vqg0J7X4EKMpMGgn
        MkuJJucDU21eSbyhiaWBiZmZuaGBgaWJkjjvzZP3ooQE0hNLUrNTUwtSi2D6mDg4pRoYOWq6
        S060XTnFZ5Vbd+Uhd8RcxZeKc7pd9V3jNq4rSq+NZtHWaV6/Oc7//l61vY1mGj363dX/lkrL
        XOETvF4YNjt6XZNr+/RsaSfZxatq3TqvsfdetnbI8Wu5+Wm7uu9mRfveuaEG0Rb+c13KDF8v
        i2gUn1a2bf/5dOObWqWfVFJT9s00VlNiKc5INNRiLipOBABgPm79fQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSvO40xTdRBsuXslpc+fqezWLT42us
        Fpd3zWGzOLC0ncVi7flWFgdWjzXz1jB63O8+zuSxeUm9R9+WVYwenzfJBbBGcdmkpOZklqUW
        6dslcGUc7LjNWrBdouJu/1PmBsbjwl2MnBwSAiYSP94fZeli5OIQEtjNKLHz8DFWiISUxLI3
        29ggbGGJlf+es0MUfWaUeHXkMliCDaj7+ZwZrCAJEYEmRon+h89ZQBLMAkYSS5+vZwaxhQWy
        Jb4/mAU2lUVAVWJJbwsjiM0r4Cqx5fIyJogNchI3z3WC1XMKuEnM71gLNkcIqGbhnf2MExj5
        FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA4xLa0djCdOxB9iFOBgVOLh3WH7
        OkqINbGsuDL3EKMEB7OSCO+sQ0Ah3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1Kz
        U1MLUotgskwcnFINjBUa8RMzfQLXB0x1iVg3i59pz/cMrb6inZc109c8+B6z6oMV07v+f6oJ
        Wt9mdV+SjduwoOjeu6NTGwraQlk6Dk6zvbN5t9/3WOFH7A/9cp707xY4tz3NeYK2oNbpmRPd
        RLfNaTnevv7v/VlnLP7cyryZqJL+cHWsTeC5s0v1nt7aGZJ02f/qBDYlluKMREMt5qLiRAAH
        GplrLQIAAA==
X-CMS-MailID: 20180504090214epcas5p4e9c362da6cc7b65effcc042fc4f82d2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180504090214epcas5p4e9c362da6cc7b65effcc042fc4f82d2a
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180504090214epcas5p4e9c362da6cc7b65effcc042fc4f82d2a
X-RootMTR: 20180504090214epcas5p4e9c362da6cc7b65effcc042fc4f82d2a
References: <1525419600-1774-1-git-send-email-satendra.t@samsung.com>
        <CGME20180504090214epcas5p4e9c362da6cc7b65effcc042fc4f82d2a@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 11:36:39 +0100, Liviu Dudau wrote:
> On Thu, May 03, 2018 at 11:28:37AM +0530, Satendra Singh Thakur wrote:
> > 1.
> > -Added a new helper drm_display_mode_crtc_to_videomode
> > -This helper calculates mode parameters like
> >   horizontal front_porch, back_porch, sync length
> >   vertical front_porch, back_porch, sync length
> >   using crtc_* fields of struct drm_display_mode
> > -It uses following fields of crtc mode
> >  horizontal sync start/end, active and total length
> >  vertical sync start/end, active and total length
> > 2.
> > -Most of the driver use user-supplied mode for calculating videomode
> > -However, few drivers use HW (crtc) mode for calculating videomode
> > -This helper will be useful for such drivers
> > 3.
> > -Currently following drivers will be using this new helper
> > -arm hdlcd
> > -atmel hlcdc
> > -exynos 5433 decon
> > -exynos7 decon
> > -exynos fimd
> > 4.
> > -This patch removes related duplicate code from above mentioned drivers
> > 
> > Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> > Cc: Madhur Verma <madhur.verma@samsung.com>
> > Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
> > ---
> >  drivers/gpu/drm/arm/hdlcd_crtc.c               |  8 +-------
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  7 +------
> >  drivers/gpu/drm/drm_modes.c                    | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/exynos/exynos5433_drm_decon.c  | 22 ++++++++++------------
> >  drivers/gpu/drm/exynos/exynos7_drm_decon.c     | 23 ++++++++++-------------
> >  drivers/gpu/drm/exynos/exynos_drm_fimd.c       | 22 +++++++++-------------
> >  include/drm/drm_modes.h                        |  2 ++
> >  7 files changed, 53 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > index cf5cbd6..d20e471 100644
> > --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> > +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > @@ -130,13 +130,7 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> >  	struct videomode vm;
> >  	unsigned int polarities, err;
> >  
> > -	vm.vfront_porch = m->crtc_vsync_start - m->crtc_vdisplay;
> > -	vm.vback_porch = m->crtc_vtotal - m->crtc_vsync_end;
> > -	vm.vsync_len = m->crtc_vsync_end - m->crtc_vsync_start;
> > -	vm.hfront_porch = m->crtc_hsync_start - m->crtc_hdisplay;
> > -	vm.hback_porch = m->crtc_htotal - m->crtc_hsync_end;
> > -	vm.hsync_len = m->crtc_hsync_end - m->crtc_hsync_start;
> > -
> > +	drm_display_mode_crtc_to_videomode(m, &vm);
> >  	polarities = HDLCD_POLARITY_DATAEN | HDLCD_POLARITY_DATA;
> >  
> >  	if (m->flags & DRM_MODE_FLAG_PHSYNC)
>
> For the HDLCD part:
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> If you're not sending the final version through drm-misc then let me
> know and I can pick up the HDLCD part separately.
>
> Best regards,
> Liviu
>
>

Hi Mr Liviu,
Thanks for accepting the patch.
I don't know how to send patch through drm-misc.
You may please go ahead and pick HDLCD part separately.

Thanks
-Satendra
