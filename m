Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934889AbeEWV1w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 17:27:52 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:33174 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933195AbeEWV1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 17:27:48 -0400
Date: Wed, 23 May 2018 14:27:48 -0700
From: Vito Caputo <vcaputo@pengaru.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, daniel.vetter@ffwll.ch
Subject: Re: [REGRESSION] v4.17-rc4: xgalaga fails to start in fullscreen
 (default) mode
Message-ID: <20180523212748.6az5xkd472k6oe4k@shells.gnugeneration.com>
References: <20180521195320.6stbpnebgjowxwjp@shells.gnugeneration.com>
 <20180521215718.7zwhhdanpnibp6la@shells.gnugeneration.com>
 <20180523094919.s47ldq33hhbnodu2@shells.gnugeneration.com>
 <20180523131805.GK23723@intel.com>
 <20180523180600.n66ffkumkvhqnawk@shells.gnugeneration.com>
 <20180523182037.GO23723@intel.com>
 <20180523183900.ozvgdaniulspxn55@shells.gnugeneration.com>
 <20180523191222.GP23723@intel.com>
 <20180523201505.ydnrrnyscwqj2ewk@shells.gnugeneration.com>
 <20180523204125.GR23723@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523204125.GR23723@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:41:25PM +0300, Ville Syrjälä wrote:
> On Wed, May 23, 2018 at 01:15:05PM -0700, Vito Caputo wrote:
> > On Wed, May 23, 2018 at 10:12:22PM +0300, Ville Syrjälä wrote:
> > > On Wed, May 23, 2018 at 11:39:00AM -0700, Vito Caputo wrote:
> > > > On Wed, May 23, 2018 at 09:20:37PM +0300, Ville Syrjälä wrote:
> > > > > On Wed, May 23, 2018 at 11:06:00AM -0700, Vito Caputo wrote:
> > > > > > On Wed, May 23, 2018 at 04:18:05PM +0300, Ville Syrjälä wrote:
> > > > > > > On Wed, May 23, 2018 at 02:49:19AM -0700, Vito Caputo wrote:
> > > > > > > > On Mon, May 21, 2018 at 02:57:18PM -0700, Vito Caputo wrote:
> > > > > > > > > On Mon, May 21, 2018 at 12:53:20PM -0700, Vito Caputo wrote:
> > > > > > > > > > Hello all,
> > > > > > > > > > 
> > > > > > > > > > 4.17-rc4 (my latest kernel ATM) consistently fails to start xgalaga
> > > > > > > > > > without -window.  I will try find time to build the latest rc this
> > > > > > > > > > evening.
> > > > > > > > > > 
> > > > > > > > > > > ~$ xgalaga
> > > > > > > > > > > X Error of failed request:  BadValue (integer parameter out of range for operation)
> > > > > > > > > > >   Major opcode of failed request:  152 (XFree86-VidModeExtension)
> > > > > > > > > > >   Minor opcode of failed request:  10 (XF86VidModeSwitchToMode)
> > > > > > > > > > >   Value in failed request:  0x120004e
> > > > > > > > > > >   Serial number of failed request:  199
> > > > > > > > > > >   Current serial number in output stream:  203
> > > > > > > > > > 
> > > > > > > > > > Haven't dug into this much yet, only did a perfunctory check by booting into a
> > > > > > > > > > few older kernels (4.11, 4.12, 4.16) and the problem is absent on all of them.
> > > > > > > > > > It appears to be a 4.17-specific regression right now.
> > > > > > > > > > 
> > > > > > > > > > Also observed, though this is surely a different regression, the game
> > > > > > > > > > ran like molasses with -window, showing some prominent kworkers in top:
> > > > > > > > > > 
> > > > > > > > > >   692 vc        20   0  312852  45884  20556 R  32.0  1.2   0:08.69 Xorg           
> > > > > > > > > >   102 root      20   0       0      0      0 R  11.2  0.0   0:01.43 kworker/1:3    
> > > > > > > > > >    94 root      20   0       0      0      0 I   8.9  0.0   0:00.83 kworker/0:2    
> > > > > > > > > >   696 vc        20   0   39948   4124   2912 S   1.0  0.1   0:05.57 vwm            
> > > > > > > > > >   902 vc        30  10   46372   4144   3500 S   0.7  0.1   0:00.08 xgalaga        
> > > > > > > > > >   891 vc        30  10   44924   3868   3156 R   0.3  0.1   0:00.09 top            
> > > > > > > > > >   903 vc        30  10    4180   1184   1100 S   0.3  0.0   0:00.01 xgal.sndsrv.oss
> > > > > > > > > > 
> > > > > > > > > > The windowed performance issue was observed on the older kernels tested
> > > > > > > > > > as well, though 4.11 felt better and didn't have the busy kworkers.
> > > > > > > > > > 
> > > > > > > > > > I have not attempted to play xgalaga for ages, but it used to be perfectly
> > > > > > > > > > playable on this machine in windowed mode when I last did.
> > > > > > > > > > 
> > > > > > > > > > Machine is the venerable Thinkpad X61s, 1.8Ghz, Debian 9, config attached.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Just built and booted v4.17-rc6, still broken.
> > > > > > > > 
> > > > > > > > Bisected to:
> > > > > > > > 
> > > > > > > > e995ca0b8139c5f6807095464e969931b443f55a is the first bad commit
> > > > > > > > commit e995ca0b8139c5f6807095464e969931b443f55a
> > > > > > > > Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > > > > Date:   Tue Nov 14 20:32:58 2017 +0200
> > > > > > > > 
> > > > > > > >     drm/i915: Provide a device level .mode_valid() hook
> > > > > > > >     
> > > > > > > >     We never support certain mode flags etc. Reject those early on in the
> > > > > > > >     mode_config.mode_valid() hook. That allows us to remove some duplicated
> > > > > > > >     checks from the connector .mode_valid() hooks, and it guarantees that
> > > > > > > >     we never see those flags even from user mode as the
> > > > > > > >     mode_config.mode_valid() hooks gets executed for those as well.
> > > > > > > >     
> > > > > > > >     Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > > > >     Link: https://patchwork.freedesktop.org/patch/msgid/20171114183258.16976-11-ville.syrjala@linux.intel.com
> > > > > > > >     Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > > > > 
> > > > > > > Hmm. I guess xgalaga passes some garbage in via xf86vidmode which
> > > > > > > the ddx doesn't validate before passing it on to the kernel. So far
> > > > > > > I can't reproduce the problem here unfortnately.
> > > > > > > 
> > > > > > > Can you try the following patch and reproduce the problem with
> > > > > > > drm.debug=0xe passed to the kernel so that we can seewhat the bad
> > > > > > > modeline looks like?
> > > > > > > 
> > > > > > 
> > > > > > dmesg after xgalaga fails:
> > > > > > 
> > > > > > ```
> > > > > > [   75.617448] [drm:drm_mode_convert_umode] Bad user mode:
> > > > > > [   75.617455] [drm:drm_mode_debug_printmodeline] Modeline 57:"800x600" 0 81000 800 832 928 1080 600 600 602 625 0x0 0x25
> > > > > 
> > > > > 0x20 == dblscan
> > > > > 
> > > > > > [   75.617458] [drm:drm_mode_setcrtc] Invalid mode
> > > > > > ```
> > > > > > 
> > > > > > xrandr --verbose:
> > > > > > 
> > > > > > ```
> > > > > > Screen 0: minimum 320 x 200, current 1024 x 768, maximum 8192 x 8192
> > > > > > LVDS-1 connected primary 1024x768+0+0 (0x44) normal (normal left inverted right x axis y axis) 246mm x 184mm
> > > > > > 	Identifier: 0x41
> > > > > > 	Timestamp:  23375
> > > > > > 	Subpixel:   horizontal rgb
> > > > > > 	Gamma:      1.0:1.0:1.0
> > > > > > 	Brightness: 1.0
> > > > > > 	Clones:    
> > > > > > 	CRTC:       0
> > > > > > 	CRTCs:      0 1
> > > > > > 	Transform:  1.000000 0.000000 0.000000
> > > > > > 	            0.000000 1.000000 0.000000
> > > > > > 	            0.000000 0.000000 1.000000
> > > > > > 	           filter: 
> > > > > > 	EDID: 
> > > > > > 		00ffffffffffff0030ae004000000000
> > > > > > 		3010010380191278eafe609555518726
> > > > > > 		22505421080001010101010101010101
> > > > > > 		01010101010128150040410026301888
> > > > > > 		3600f6b800000018ed10004041002630
> > > > > > 		18883600f6b9000000180000000f0061
> > > > > > 		43326143280f01000daf0714000000fe
> > > > > > 		004e31323158352d4c303620202000ed
> > > > > > 	scaling mode: Full aspect 
> > > > > > 		supported: Full, Center, Full aspect
> > > > > > 	non-desktop: 0 
> > > > > > 		range: (0, 1)
> > > > > > 	link-status: Good 
> > > > > > 		supported: Good, Bad
> > > > > >   1024x768 (0x44) 54.160MHz -HSync -VSync *current +preferred
> > > > > >         h: width  1024 start 1048 end 1184 total 1344 skew    0 clock  40.30KHz
> > > > > >         v: height  768 start  771 end  777 total  806           clock  50.00Hz
> > > > > >   1024x768 (0x45) 65.000MHz -HSync -VSync
> > > > > >         h: width  1024 start 1048 end 1184 total 1344 skew    0 clock  48.36KHz
> > > > > >         v: height  768 start  771 end  777 total  806           clock  60.00Hz
> > > > > >   1024x768 (0x46) 43.330MHz -HSync -VSync
> > > > > >         h: width  1024 start 1048 end 1184 total 1344 skew    0 clock  32.24KHz
> > > > > >         v: height  768 start  771 end  777 total  806           clock  40.00Hz
> > > > > >   960x720 (0x47) 117.000MHz -HSync +VSync DoubleScan
> > > > > >         h: width   960 start 1024 end 1128 total 1300 skew    0 clock  90.00KHz
> > > > > >         v: height  720 start  720 end  722 total  750           clock  60.00Hz
> > > > > >   928x696 (0x48) 109.150MHz -HSync +VSync DoubleScan
> > > > > >         h: width   928 start  976 end 1088 total 1264 skew    0 clock  86.35KHz
> > > > > >         v: height  696 start  696 end  698 total  719           clock  60.05Hz
> > > > > 
> > > > > Where are all these dblscan modes coming from?
> > > > > 
> > > > > Did you add them manually or are they being automatically
> > > > > generated by something?
> > > > > 
> > > > 
> > > > This is pure automagic xserver-xorg-video-intel on i915 drm/kms.
> > > > 
> > > > After booting back into a working 4.16 kernel I see the same xrandr --verbose
> > > > list with all the DoubleScan modes, with which xgalaga is functional.
> > > > 
> > > > There's this in the Xorg.log:
> > > > 
> > > > ```
> > > > [    12.856] (II) intel(0): Output LVDS1 using monitor section Monitor0
> > > > [    12.857] (--) intel(0): found backlight control interface /sys/class/backlight/acpi_video0
> > > > [    12.882] (II) intel(0): Output VGA1 has no monitor section
> > > > [    12.883] (II) intel(0): EDID for output LVDS1
> > > > [    12.883] (II) intel(0): Manufacturer: LEN  Model: 4000  Serial#: 0
> > > > [    12.883] (II) intel(0): Year: 2006  Week: 48
> > > > [    12.883] (II) intel(0): EDID Version: 1.3
> > > > [    12.883] (II) intel(0): Digital Display Input
> > > > [    12.883] (II) intel(0): Max Image Size [cm]: horiz.: 25  vert.: 18
> > > > [    12.883] (II) intel(0): Gamma: 2.20
> > > > [    12.883] (II) intel(0): DPMS capabilities: StandBy Suspend Off
> > > > [    12.883] (II) intel(0): Supported color encodings: RGB 4:4:4 YCrCb 4:4:4 
> > > > [    12.883] (II) intel(0): First detailed timing is preferred mode
> > > > [    12.883] (II) intel(0): redX: 0.585 redY: 0.335   greenX: 0.319 greenY: 0.529
> > > > [    12.883] (II) intel(0): blueX: 0.149 blueY: 0.135   whiteX: 0.312 whiteY: 0.328
> > > > [    12.883] (II) intel(0): Supported established timings:
> > > > [    12.883] (II) intel(0): 640x480@60Hz
> > > > [    12.883] (II) intel(0): 800x600@60Hz
> > > > [    12.883] (II) intel(0): 1024x768@60Hz
> > > > [    12.883] (II) intel(0): Manufacturer's mask: 0
> > > > [    12.883] (II) intel(0): Supported detailed timing:
> > > > [    12.883] (II) intel(0): clock: 54.2 MHz   Image Size:  246 x 184 mm
> > > > [    12.883] (II) intel(0): h_active: 1024  h_sync: 1048  h_sync_end 1184 h_blank_end 1344 h_border: 0
> > > > [    12.883] (II) intel(0): v_active: 768  v_sync: 771  v_sync_end 777 v_blanking: 806 v_border: 0
> > > > [    12.883] (II) intel(0): Supported detailed timing:
> > > > [    12.883] (II) intel(0): clock: 43.3 MHz   Image Size:  246 x 185 mm
> > > > [    12.883] (II) intel(0): h_active: 1024  h_sync: 1048  h_sync_end 1184 h_blank_end 1344 h_border: 0
> > > > [    12.883] (II) intel(0): v_active: 768  v_sync: 771  v_sync_end 777 v_blanking: 806 v_border: 0
> > > > [    12.883] (II) intel(0): Unknown vendor-specific block f
> > > > [    12.883] (II) intel(0):  N121X5-L06
> > > > [    12.883] (II) intel(0): EDID (in hex):
> > > > [    12.883] (II) intel(0):     00ffffffffffff0030ae004000000000
> > > > [    12.883] (II) intel(0):     3010010380191278eafe609555518726
> > > > [    12.883] (II) intel(0):     22505421080001010101010101010101
> > > > [    12.883] (II) intel(0):     01010101010128150040410026301888
> > > > [    12.883] (II) intel(0):     3600f6b800000018ed10004041002630
> > > > [    12.883] (II) intel(0):     18883600f6b9000000180000000f0061
> > > > [    12.883] (II) intel(0):     43326143280f01000daf0714000000fe
> > > > [    12.883] (II) intel(0):     004e31323158352d4c303620202000ed
> > > > [    12.883] (II) intel(0): Not using default mode "320x240" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "400x300" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "400x300" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "512x384" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "640x480" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "640x512" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "800x600" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "896x672" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "928x696" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "960x720" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "576x432" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "680x384" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "680x384" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "700x525" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "720x450" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "800x512" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "840x525" (doublescan mode not supported)
> > > > [    12.883] (II) intel(0): Not using default mode "840x525" (doublescan mode not supported)
> > > > [    12.884] (II) intel(0): Not using default mode "960x540" (doublescan mode not supported)
> > > > [    12.884] (II) intel(0): Not using default mode "960x600" (doublescan mode not supported)
> > > 
> > > So first it rejected them all, but somehow later they get added back?
> > > Very odd.
> > > 
> > > Hmm. Must be coming from that default modes thing...
> > > 
> > > Looks pretty much like ddx bug to me. Does the following ddx patch get
> > > rid of the bogus dblscan modes?
> > > 
> > 
> > <snip>
> > 
> > No, that didn't seem to change anything.  After some digging, I found:
> > 
> > xorg-server-1.19.2/hw/xfree86/drivers/modesetting/drmmode_display.c::drmmode_output_init():
> > 
> > ```
> > 1796     drmmode_output->output_id = mode_res->connectors[num];
> > 1797     drmmode_output->mode_output = koutput;
> > 1798     drmmode_output->mode_encoders = kencoders;
> > 1799     drmmode_output->drmmode = drmmode;
> > 1800     output->mm_width = koutput->mmWidth;
> > 1801     output->mm_height = koutput->mmHeight;
> > 1802 
> > 1803     output->subpixel_order = subpixel_conv_table[koutput->subpixel];
> > 1804     output->interlaceAllowed = TRUE;
> > 1805     output->doubleScanAllowed = TRUE;
> > 1806     output->driver_private = drmmode_output;
> > ```
> 
> That's the modesetting ddx. Irrelevant as long as you're using the intel
> ddx.
> 

Hmm, that should have been obvious given the path, clearly I'm not
familiar with how this is structured.  Xorg cannot start without
modesetting_drv.so, even when using intel_drv.so, so I thought they were
more intimately sharing functionality.

I wonder why the change didn't work then; intel_output_init() doesn't
set doubleScanAllowed=TRUE and xf86OutputCreate() uses calloc() so...

If you want me to test another patch I'm happy to.  Even if the kernel
stays compatible with the bug, it still makes sense to fix userspace.

> > 
> > I don't see anywhere that sets interlaceAllowed or doubleScanAllowed to FALSE,
> > except xserver-xorg-video-intel/src/legacy/i810/i810_driver.c.
> > 
> > So your change never invalidates the doublescan modes, because they're allowed
> > for the output.
> > 
> > Assuming this can be corrected by disallowing these for the output
> > somewhere appropriate, isn't this still a userspace-breaking kernel
> > regression?
> 
> I suppose.
> 
> > 
> > It seems to me like the kernel should just ignore the doublescan mode
> > flag and continue if a non-doublescan equivalent mode exists, given the
> > userspace situation this change uncovered.
> 
> The only reason why ignoring it has worked is due to the panel fitter
> being used on LVDS outputs. For other output types anyone trying to
> use doublescan would probabably have gotten a fail or black/bogus
> output.
> 
> This is the annoying part. I guess we want to ignore it for LVDS & co.
> but reject it for everything else. Which means we have to allow it
> into the kernel and reject it later. I guess for now we'll want to
> move the check back into the connector .mode_valid() hooks and later
> on we have to figure out how we can actually use those hooks to also
> validate the user mode (which has been on the TODO list for
> several years).
> 

This sounds like a reasonable interim solution.

Thanks,
Vito Caputo
