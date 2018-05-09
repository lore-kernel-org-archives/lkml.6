Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934565AbeEILwb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:52:31 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:39432 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934502AbeEILw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:52:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180509115226epoutp01aa9e3b0202a4e5f708e083aef6fa8e50~s97ig0koW0345803458epoutp01R
X-AuditID: b6c32a4a-a79ff700000010d4-f8-5af2e0f93899
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc: sst2005@gmail.com, Satendra Singh Thakur <satendra.t@samsung.com>
Subject: Re: [PATCH 00/13] drm/kms/mode: using helper func
 drm_display_mode_to/from_videomode for calculating timing parameters
Date: Wed,  9 May 2018 17:22:05 +0530
Message-Id: <1525866725-16685-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525777110-11378-1-git-send-email-satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeUwTURDG83a32wWtri3EsVFsNl6o1LZpYVHridp4hWiiSY3BDbwASlvs
        tngkKp6BqngHrcTghVYjGMRbPECteCEBQRJFIiQYD4xFiFeiXRfifzPf+33vm0yGIdXbaC2T
        6fRgt1PI4uhI6kp1bGzcj9aQ3XCskOL/XNlH8g3dX2i++Gg/vrytUcHX3yii+fqtdYg/XHub
        4PO/+Wn+Qu12ij/zpImcFmmr7CmmbNf9b5S2tzuDhO3SqU22gopzyNZVHpNM2/HkDCykYbcO
        O1NdaZnOdCs3b3HKzBRLvMEYZ0zkEzidU3BgK5c0PzludmZWeDBOlyNkecNSsiCK3IQpk90u
        rwfrMlyix8otMxpNeqMhQW8ymfRmy/KJJksYWYEzGosaiOy7I9e+u7ooF50f5kMRDLBmaGuv
        o3woklGzNxFcq33S24QQfLoXpCRKzfYg6Ho1pM+R295IyFAlgkrfA6XcdCM4WF1BShQdpjqK
        Diukhyh2OwEFW+poH2IYkp0Fp4tGSbqG3YxgS6ADSTrFjoTShhmSV8XOhp+3e2g5LQaan+f/
        +zOCnQMHTl2mJS+wFTR8u/9OIXmBTYIj/iiZ18CHYIVSrrXQ1VnZy29F0Fp6XCk3uxDk5T/s
        pabCtoN3KXm4WCi7MUGWrfDixW6FVJPsANj9q52Qs1SQt0MtIyMg8L6a7Mv6XexTyLUNasoP
        EHI9HZ51XqTlBfkRBDvLlHvRcP//tGKEzqEhOFt0pGPRkm1y4jV6UXCIXme6PtXlKEf/LnDs
        3Guo5Pn8KsQyiOuvgutf7WqFkCOuc1QhYEguSjXvdciuVqUJ69ZjtyvF7c3CYhWyhBe7j9RG
        p7rC9+z0pBjNiQZzfHyC0WBINHODVc01LXY1my548CqMs7G7z0cwEdpc5L+zIHfXz1uaDaE1
        3paSp4MCqZtOXAzUGwqrA1rdse47jg0l9pxbk1oGPmL3JyzxfP8Y8ye6Q5kYaG1aejTm4dXP
        wviFo6uWH2mK5mo0GrLk7P1FNau5Zp2dsLETk2aU9isQx3wpGzg07/TSk22mQ6Fh4wqD9MvW
        PY/xScNG6/7VKzlKzBCMY0m3KPwFTXA7/pcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSvO73B5+iDPZutbH4v20is8WVr+/Z
        LBbM5rbY9Pgaq8XlXXPYLC43X2S0mHF+H5NF55dZbBZrz7eyWCw/fZ3Zgctj77cFLB47Z91l
        97jffZzJY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKuDbnClPBAdWKR9uDGhhXy3Yx
        cnJICJhINDy5xtTFyMUhJLCbUeL8olUsEAkpiWVvtrFB2MISK/89Z4co+swo8en0W2aQBBtQ
        9/M5M1hBEiICvUwSj1ZvYAdJMAu4S9yb8wvMFhaol7h6qBVoBQcHi4CqxLorTiBhXgE3iV/7
        vkEtkJO4ea4TbCYnUOvkJVvB4kJANedXHGSfwMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5x
        aV66XnJ+7iZGcGBqae1gPHEi/hCjAAejEg+vxM6PUUKsiWXFlbmHGCU4mJVEeL3vfIoS4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwDiL1yTOeyXTt3n7
        fH6Wzfxz5Fxr/CTVoPCVXH9FOMPubYiXlSjiU5i9yfpIzhWF/+xLk8rjttecbeoVyNY/eCpN
        d2r95Y9mhaYVhkrRSV/zb3RUhhb/sl92835f7Ozyx3feZSvopU6u5pC3l5m4Yml1d8Sd6s49
        s6KdjnWbTrCtvRdonWtqqcRSnJFoqMVcVJwIAL5iwAZIAgAA
X-CMS-MailID: 20180509115224epcas5p1c958418bc36fd224e8d36b9511c5beea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180509115224epcas5p1c958418bc36fd224e8d36b9511c5beea
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180509115224epcas5p1c958418bc36fd224e8d36b9511c5beea
X-RootMTR: 20180509115224epcas5p1c958418bc36fd224e8d36b9511c5beea
References: <1525777110-11378-1-git-send-email-satendra.t@samsung.com>
        <CGME20180509115224epcas5p1c958418bc36fd224e8d36b9511c5beea@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2018 at 16:28:30 +0530, Satendra Singh Thakur wrote:
> On Thu, May 07, 2018 at 15:46:02 +0200, Daniel Vetter wrote:
> > On Thu, May 03, 2018 at 01:53:55PM +0530, Satendra Singh Thakur wrote:
> > > 1.There is a function in drm-core to calculate display timing parameters:
> > > horizontal front porch, back porch, sync length,
> > > vertical front porch, back porch, sync length and
> > > clock in Hz.
> > > However, some drivers are still calculating these parameters themselves.
> > > Therefore, there is a duplication of the code.
> > > This patch series replaces this redundant code with the function
> > > drm_display_mode_to_videomode.
> > > This removes nearly 100 redundant lines from the related drivers.
> > > 2.For some drivers (sun4i) the reverse helper
> > > drm_display_mode_from_videomode is used.
> > > 3.For some drivers it replaces arithmatic operators (*, /) with shifting
> > > operators (>>, <<).
> > > 4.For some drivers DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags.
> > > 5.These changes apply to following crtc and encoder drivers:
> > > atmel-hlcdc
> > > bridge-tc358767
> > > exynos-dsi
> > > fsl-dcu
> > > gma500-mdfld_dsi_dpi
> > > hisilicon-kirin_dsi, ade
> > > meson-encoder
> > > pl111-display
> > > sun4i-tv
> > > ti lcdc
> > > tegra dc
> > > mediatek dpi dsi
> > > bridge-adv7533
> > 
> > The drm_mode_to_videomode helper is meant for interop between drm and v4l,
> > which have different internal structures to represent modes.
> > 
> > For drivers that only use drm I think the better option would be to add
> > these fields to struct drm_display_mode as another set of crtc_* values
> > (the computed values are stored in crtc_ prefixed members). And compute
> > front/back porch in drm_mode_set_crtcinfo.
> > 
> > Then we can use these new drm_display_mode->crtc_h|vfront|back_porch
> > fields in all the drivers you're changing. This way you avoid having to
> > change all the drm drivers to use v4l #defines.
> > 
> > Thanks,
> > Daniel
>
> Hi Daniel,
> Thanks for the comments.
> I will look into it.
> 
> Thanks
> -Satendra

Hi Daniel,
Thanks for the comments.
Please find below my understanding in this direction.

1. Currently struct videomode is being used in 50 drm drivers and 14 fbdev drivers.
   Since, it's already being used by so many drm drivers, that is the reason 
   these fbdev objects (struct videmode and func drm_display_mode_to_videomode) were used in this patch series.

2. Anyway, if fbdev related objects (struct/func) are not encouraged in drm drivers, then we may add 
   h/v front/back porches in struct drm_display_mode as adviced by you.

3. We can calculate these params in func drm_mode_set_crtcinfo at the end of it.
   int drm_mode_set_crtcinfo ()
   {
   .
   .
   crtc_hfront_porch = crtc_hsync_start - crtc_hdisplay;
   crtc_vfront_porch = crtc_vsync_start - crtc_vdisplay; 
   .
   .
   crtc_clock_hz = crtc_clock*1000;
   };

4. Normally mode is programmed in HW in following callbacks of crtc and encoder drivers
   -mode_set
   -mode_set_nofb
   -atomic_enable

   
   Normally drm_mode_set_crtcinfo is used in
   -mode_fixup callbacks (CBs) 
   of encoder and crtc drivers.

   if mode_fixup CBs are called before mode_set CBs then
   drm_mode_set_crtcinfo is right place to calculate sync/porch params. 
   We can use crtc_hfront/back_porches directly and program them to HW
   in above mentioned callbacks.
   
   int my_mode_set () 
   {
   	REG_WRITE(crtc_hfront_porch);
        REG_WRITE(crtc_hback_porch);
        .
        .
   } 	

 6.  However, if these params are being modified after calling drm_set_crtcinfo as mentioned below:

   bool amdgpu_atombios_encoder_mode_fixup(struct drm_encoder *encoder,
				 const struct drm_display_mode *mode,
				 struct drm_display_mode *adjusted_mode)
   {
	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);

	/* set the active encoder to connector routing */
	amdgpu_encoder_set_active_device(encoder);
	***drm_mode_set_crtcinfo(adjusted_mode, 0);****

	/* hw bug */
	if ((mode->flags & DRM_MODE_FLAG_INTERLACE)
	    && (mode->crtc_vsync_start < (mode->crtc_vdisplay + 2)))
		adjusted_mode->crtc_vsync_start = adjusted_mode->crtc_vdisplay + 2;

  Then we may need to define new func like

  void drm_calc_hv_porches_sync()
  {
   crtc_hfront_porch = crtc_hsync_start - crtc_hdisplay;
   crtc_vfront_porch = crtc_vsync_start - crtc_vdisplay; 
   .
   . 
   crtc_clock_hz = crtc_clock*1000;
  }  and call this func in mode_set*, atomic_enable CBS before programming the HW with this mode.

  
  Should I create patches around this idea ?
  Please let me know your comments. 


Thanks
-Satendra
