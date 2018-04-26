Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756592AbeDZO1h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:27:37 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:41194 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756467AbeDZO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:27:28 -0400
Date: Thu, 26 Apr 2018 10:27:19 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] 4.17-rc2: Could not determine valid watermarks for
 inherited state
Message-ID: <20180426142719.fzivt2e6kialcbp4@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
References: <20180423152713.2rrwwye3wfstbv5v@codemonkey.org.uk>
 <20180426131045.GH23723@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426131045.GH23723@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Note: SpamAssassin invocation failed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 04:10:45PM +0300, Ville Syrjälä wrote:
 > On Mon, Apr 23, 2018 at 11:27:13AM -0400, Dave Jones wrote:
 > > This warning just started appearing during boot on a machine I upgraded
 > > to 4.17-rc2.  The warning seems to have been there since 2015, but it
 > > has never triggered before today.
 > 
 > Looks like we have bug open about this. I just asked for more
 > information there:
 > https://bugs.freedesktop.org/show_bug.cgi?id=105992#c5
 > 
 > If you can also boot with drm.debug=0xe maybe we can see some more
 > details about the supposedly bad watermarks.


[    1.153294] calling  drm_kms_helper_init+0x0/0x15 @ 1
[    1.153768] initcall drm_kms_helper_init+0x0/0x15 returned 0 after 0 usecs
[    1.154242] calling  drm_core_init+0x0/0xea @ 1
[    1.154760] initcall drm_core_init+0x0/0xea returned 0 after 53 usecs
[    1.156781] [drm:intel_pch_type] Found LynxPoint PCH
[    1.157254] [drm:intel_power_domains_init] Allowed DC state mask 00
[    1.158717] [drm:i915_driver_load] ppgtt mode: 1
[    1.159187] [drm:intel_uc_sanitize_options] enable_guc=0 (submission:no huc:no)
[    1.159665] [drm:i915_driver_load] guc_log_level=0 (enabled:no verbosity:-1)
[    1.160247] [drm:i915_ggtt_probe_hw] GGTT size = 2048M
[    1.160720] [drm:i915_ggtt_probe_hw] GMADR size = 256M
[    1.161189] [drm:i915_ggtt_probe_hw] DSM size = 64M
[    1.162126] fb: switching to inteldrmfb from EFI VGA
[    1.163161] fb: switching to inteldrmfb from VGA16 VGA
[    1.163511] [drm] Replacing VGA console driver
[    1.163819] [drm:i915_gem_init_stolen] Memory reserved for graphics device: 65536K, usable: 64512K
[    1.163868] [drm:intel_opregion_setup] graphic opregion physical addr: 0xd9a13018
[    1.163908] [drm:intel_opregion_setup] Public ACPI methods supported
[    1.163924] [drm:intel_opregion_setup] SWSCI supported
[    1.168084] [drm:intel_opregion_setup] SWSCI GBDA callbacks 00000cb3, SBCB callbacks 00300483
[    1.168107] [drm:intel_opregion_setup] ASLE supported
[    1.168120] [drm:intel_opregion_setup] ASLE extension supported
[    1.168136] [drm:intel_opregion_setup] Found valid VBT in ACPI OpRegion (Mailbox #4)
[    1.168325] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.168341] [drm] Driver supports precise vblank timestamp query.
[    1.168357] [drm:intel_bios_init] Set default to SSC at 120000 kHz
[    1.168373] [drm:intel_bios_init] VBT signature "$VBT HASWELL        ", BDB version 174
[    1.168392] [drm:intel_bios_init] BDB_GENERAL_FEATURES int_tv_support 0 int_crt_support 1 lvds_use_ssc 0 lvds_ssc_freq 120000 display_clock_mode 0 fdi_rx_polarity_inverted 0
[    1.168425] [drm:intel_bios_init] crt_ddc_bus_pin: 5
[    1.171131] [drm:intel_opregion_get_panel_type] Ignoring OpRegion panel type (0)
[    1.171151] [drm:intel_bios_init] Panel type: 2 (VBT)
[    1.171164] [drm:intel_bios_init] DRRS supported mode is static
[    1.171185] [drm:intel_bios_init] Found panel mode in BIOS VBT tables:
[    1.171203] [drm:drm_mode_debug_printmodeline] Modeline 0:"1024x768" 0 65000 1024 1048 1184 1344 768 771 777 806 0x8 0xa
[    1.171227] [drm:intel_bios_init] VBT initial LVDS value 300
[    1.171242] [drm:intel_bios_init] VBT backlight PWM modulation frequency 200 Hz, active high, min brightness 0, level 255, controller 0
[    1.171272] [drm:intel_bios_init] Found SDVO panel mode in BIOS VBT tables:
[    1.171289] [drm:drm_mode_debug_printmodeline] Modeline 0:"1600x1200" 0 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x8 0xa
[    1.171314] [drm:intel_bios_init] DRRS State Enabled:1
[    1.171327] [drm:intel_bios_init] No SDVO device info is found in VBT
[    1.171344] [drm:intel_bios_init] Port B VBT info: DP:0 HDMI:0 DVI:1 EDP:0 CRT:0
[    1.171362] [drm:intel_bios_init] VBT HDMI level shift for port B: 6
[    1.171377] [drm:intel_bios_init] Port D VBT info: DP:0 HDMI:1 DVI:1 EDP:0 CRT:0
[    1.171395] [drm:intel_bios_init] VBT HDMI level shift for port D: 11
[    1.171470] [drm:intel_dsm_detect] no _DSM method for intel device
[    1.171492] [drm:i915_driver_load] rawclk rate: 125000 kHz
[    1.171524] [drm:intel_power_well_enable] enabling always-on
[    1.171549] [drm:intel_power_well_enable] enabling display
[    1.172946] [drm:intel_fbc_init] Sanitized enable_fbc value: 0
[    1.172964] [drm:intel_print_wm_latency] Primary WM0 latency 20 (2.0 usec)
[    1.172981] [drm:intel_print_wm_latency] Primary WM1 latency 4 (2.0 usec)
[    1.172997] [drm:intel_print_wm_latency] Primary WM2 latency 36 (18.0 usec)
[    1.173014] [drm:intel_print_wm_latency] Primary WM3 latency 90 (45.0 usec)
[    1.173030] [drm:intel_print_wm_latency] Primary WM4 latency 160 (80.0 usec)
[    1.173047] [drm:intel_print_wm_latency] Sprite WM0 latency 20 (2.0 usec)
[    1.173063] [drm:intel_print_wm_latency] Sprite WM1 latency 4 (2.0 usec)
[    1.173080] [drm:intel_print_wm_latency] Sprite WM2 latency 36 (18.0 usec)
[    1.173096] [drm:intel_print_wm_latency] Sprite WM3 latency 90 (45.0 usec)
[    1.173112] [drm:intel_print_wm_latency] Sprite WM4 latency 160 (80.0 usec)
[    1.173129] [drm:intel_print_wm_latency] Cursor WM0 latency 20 (2.0 usec)
[    1.173145] [drm:intel_print_wm_latency] Cursor WM1 latency 4 (2.0 usec)
[    1.173161] [drm:intel_print_wm_latency] Cursor WM2 latency 36 (18.0 usec)
[    1.173177] [drm:intel_print_wm_latency] Cursor WM3 latency 90 (45.0 usec)
[    1.173194] [drm:intel_print_wm_latency] Cursor WM4 latency 160 (80.0 usec)
[    1.173211] [drm:intel_modeset_init] 3 display pipes available.
[    1.173617] [drm:intel_dump_cdclk_state] Current CDCLK 540000 kHz, VCO 0 kHz, ref 0 kHz, bypass 0 kHz, voltage level 0
[    1.173642] [drm:intel_update_max_cdclk] Max CD clock rate: 540000 kHz
[    1.173658] [drm:intel_modeset_init] Max dotclock rate: 540000 kHz
[    1.174020] [drm:intel_crt_reset] crt adpa set to 0xf40000
[    1.174051] [drm:intel_hdmi_init_connector] Adding HDMI connector on port B
[    1.174073] [drm:intel_hdmi_init_connector] Using DDC pin 0x5 for port B (VBT)
[    1.174159] [drm:intel_hdmi_init_connector] Adding HDMI connector on port D
[    1.174180] [drm:intel_hdmi_init_connector] Using DDC pin 0x6 for port D (VBT)
[    1.174565] [drm:intel_modeset_setup_hw_state] pipe A active planes 0x1
[    1.174588] [drm:intel_modeset_setup_hw_state] pipe A active planes 0x1
[    1.174605] [drm:intel_modeset_setup_hw_state] pipe A active planes 0x1
[    1.174621] [drm:intel_modeset_setup_hw_state] [CRTC:39:pipe A] hw state readout: enabled
[    1.174645] [drm:intel_modeset_setup_hw_state] pipe B active planes 0x0
[    1.174662] [drm:intel_modeset_setup_hw_state] pipe B active planes 0x0
[    1.174679] [drm:intel_modeset_setup_hw_state] pipe B active planes 0x0
[    1.174696] [drm:intel_modeset_setup_hw_state] [CRTC:51:pipe B] hw state readout: disabled
[    1.174719] [drm:intel_modeset_setup_hw_state] pipe C active planes 0x0
[    1.174736] [drm:intel_modeset_setup_hw_state] pipe C active planes 0x0
[    1.174754] [drm:intel_modeset_setup_hw_state] pipe C active planes 0x0
[    1.174770] [drm:intel_modeset_setup_hw_state] [CRTC:63:pipe C] hw state readout: disabled
[    1.174791] [drm:intel_modeset_setup_hw_state] WRPLL 1 hw state readout: crtc_mask 0x00000001, on 1
[    1.174813] [drm:intel_modeset_setup_hw_state] WRPLL 2 hw state readout: crtc_mask 0x00000000, on 0
[    1.174836] [drm:intel_modeset_setup_hw_state] SPLL hw state readout: crtc_mask 0x00000000, on 0
[    1.174856] [drm:intel_modeset_setup_hw_state] LCPLL 810 hw state readout: crtc_mask 0x00000000, on 1
[    1.174878] [drm:intel_modeset_setup_hw_state] LCPLL 1350 hw state readout: crtc_mask 0x00000000, on 1
[    1.174899] [drm:intel_modeset_setup_hw_state] LCPLL 2700 hw state readout: crtc_mask 0x00000000, on 1
[    1.174922] [drm:intel_modeset_setup_hw_state] [ENCODER:65:CRT] hw state readout: disabled, pipe A
[    1.174948] [drm:intel_modeset_setup_hw_state] [ENCODER:66:DDI B] hw state readout: enabled, pipe A
[    1.174970] [drm:intel_modeset_setup_hw_state] [ENCODER:72:DDI D] hw state readout: disabled, pipe A
[    1.175005] [drm:intel_modeset_setup_hw_state] [CONNECTOR:64:VGA-1] hw state readout: disabled
[    1.175033] [drm:intel_modeset_setup_hw_state] [CONNECTOR:67:HDMI-A-1] hw state readout: enabled
[    1.175056] [drm:intel_modeset_setup_hw_state] [CONNECTOR:73:HDMI-A-2] hw state readout: disabled
[    1.175131] [drm:intel_dump_pipe_config] [CRTC:39:pipe A][setup_hw_state]
[    1.175149] [drm:intel_dump_pipe_config] output_types: HDMI (0x40)
[    1.175164] [drm:intel_dump_pipe_config] cpu_transcoder: A, pipe bpp: 24, dithering: 0
[    1.175184] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[    1.175199] [drm:intel_dump_pipe_config] requested mode:
[    1.175213] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 85754 1366 1436 1579 1792 768 771 774 798 0x40 0x5
[    1.175238] [drm:intel_dump_pipe_config] adjusted mode:
[    1.175252] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 85754 1366 1436 1579 1792 768 771 774 798 0x40 0x5
[    1.175278] [drm:intel_dump_pipe_config] crtc timings: 85754 1366 1436 1579 1792 768 771 774 798, type: 0x40 flags: 0x5
[    1.175302] [drm:intel_dump_pipe_config] port clock: 85754, pipe src size: 800x600, pixel rate 85754
[    1.175324] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x05560300, enabled
[    1.175344] [drm:intel_dump_pipe_config] ips: 0, double wide: 0
[    1.175360] [drm:intel_dump_pipe_config] dpll_hw_state: wrpll: 0xb065066a spll: 0x0
[    1.175378] [drm:intel_dump_pipe_config] planes on this crtc
[    1.175393] [drm:intel_dump_pipe_config] [PLANE:28:primary A] disabled, scaler_id = 0
[    1.175412] [drm:intel_dump_pipe_config] [PLANE:31:sprite A] disabled, scaler_id = 0
[    1.175431] [drm:intel_dump_pipe_config] [PLANE:36:cursor A] disabled, scaler_id = 0
[    1.175451] [drm:intel_dump_pipe_config] [CRTC:51:pipe B][setup_hw_state]
[    1.175467] [drm:intel_dump_pipe_config] output_types:  (0x0)
[    1.175482] [drm:intel_dump_pipe_config] cpu_transcoder: B, pipe bpp: 0, dithering: 0
[    1.175501] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[    1.175516] [drm:intel_dump_pipe_config] requested mode:
[    1.175530] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[    1.175550] [drm:intel_dump_pipe_config] adjusted mode:
[    1.175563] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[    1.175583] [drm:intel_dump_pipe_config] crtc timings: 0 0 0 0 0 0 0 0 0, type: 0x0 flags: 0x0
[    1.175604] [drm:intel_dump_pipe_config] port clock: 0, pipe src size: 0x0, pixel rate 0
[    1.175624] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[    1.175644] [drm:intel_dump_pipe_config] ips: 0, double wide: 0
[    1.175659] [drm:intel_dump_pipe_config] dpll_hw_state: wrpll: 0x0 spll: 0x0
[    1.175676] [drm:intel_dump_pipe_config] planes on this crtc
[    1.175691] [drm:intel_dump_pipe_config] [PLANE:40:primary B] disabled, scaler_id = 0
[    1.175710] [drm:intel_dump_pipe_config] [PLANE:43:sprite B] disabled, scaler_id = 0
[    1.175729] [drm:intel_dump_pipe_config] [PLANE:48:cursor B] disabled, scaler_id = 0
[    1.175748] [drm:intel_dump_pipe_config] [CRTC:63:pipe C][setup_hw_state]
[    1.175765] [drm:intel_dump_pipe_config] output_types:  (0x0)
[    1.175779] [drm:intel_dump_pipe_config] cpu_transcoder: C, pipe bpp: 0, dithering: 0
[    1.175798] [drm:intel_dump_pipe_config] audio: 0, infoframes: 0
[    1.175813] [drm:intel_dump_pipe_config] requested mode:
[    1.175827] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[    1.175847] [drm:intel_dump_pipe_config] adjusted mode:
[    1.175860] [drm:drm_mode_debug_printmodeline] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
[    1.175880] [drm:intel_dump_pipe_config] crtc timings: 0 0 0 0 0 0 0 0 0, type: 0x0 flags: 0x0
[    1.175901] [drm:intel_dump_pipe_config] port clock: 0, pipe src size: 0x0, pixel rate 0
[    1.175920] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[    1.175941] [drm:intel_dump_pipe_config] ips: 0, double wide: 0
[    1.175956] [drm:intel_dump_pipe_config] dpll_hw_state: wrpll: 0x0 spll: 0x0
[    1.175973] [drm:intel_dump_pipe_config] planes on this crtc
[    1.175987] [drm:intel_dump_pipe_config] [PLANE:52:primary C] disabled, scaler_id = 0
[    1.176007] [drm:intel_dump_pipe_config] [PLANE:55:sprite C] disabled, scaler_id = 0
[    1.176025] [drm:intel_dump_pipe_config] [PLANE:60:cursor C] disabled, scaler_id = 0
[    1.176046] [drm:intel_modeset_setup_hw_state] LCPLL 810 enabled but not in use, disabling
[    1.176065] [drm:intel_modeset_setup_hw_state] LCPLL 1350 enabled but not in use, disabling
[    1.176085] [drm:intel_modeset_setup_hw_state] LCPLL 2700 enabled but not in use, disabling
[    1.176131] [drm:i9xx_get_initial_plane_config] pipe A/primary A with fb: size=800x600@32, offset=0, pitch 3200, size 0x1d4c00
[    1.176161] [drm:i915_gem_object_create_stolen_for_preallocated] creating preallocated stolen object: stolen_offset=0x0000000000000000, gtt_offset=0x0000000000000000, size=0x00000000001d5000
[    1.176312] [drm:intel_alloc_initial_plane_obj.isra.127] initial plane fb obj         (ptrval)
[    1.176351] [drm:intel_modeset_init] pipe A active planes 0x1
[    1.176456] [drm:drm_atomic_helper_check_plane_state] Plane must cover entire CRTC
[    1.176481] [drm:drm_rect_debug_print] dst: 800x600+0+0
[    1.176494] [drm:drm_rect_debug_print] clip: 1366x768+0+0
[    1.176553] WARNING: CPU: 1 PID: 1 at drivers/gpu/drm/i915/intel_display.c:14584 sanitize_watermarks+0x17b/0x1c0
[    1.177379] [drm:i915_gem_init_ggtt] clearing unused GTT space: [1d6000, 80000000]
[    1.182941] [drm:i915_ppgtt_create] Allocated pde space (2M) at GTT entry: 7fe00
[    1.182962] [drm:i915_ppgtt_create] Adding PPGTT at offset 7fe00000
[    1.182995] [drm:i915_gem_contexts_init] logical context support initialized
[    1.183528] [drm:intel_engine_init_common] rcs0 hws offset: 0x7fdee000
[    1.183597] [drm:intel_engine_create_scratch] rcs0 pipe control offset: 0x7fded000
[    1.183863] [drm:intel_engine_init_common] bcs0 hws offset: 0x7fdec000
[    1.184149] [drm:intel_engine_init_common] vcs0 hws offset: 0x7fdeb000
[    1.184405] [drm:intel_engine_init_common] vecs0 hws offset: 0x7fdea000
[    1.184461] [drm:sandybridge_pcode_read] warning: pcode (read from mbox 1a) mailbox access failed for intel_init_gt_powersave: -6
[    1.184500] [drm:intel_init_gt_powersave] Overclocking supported, max: 1100MHz, overclock: 1100MHz
[    1.184584] [drm:init_workarounds_ring] rcs0: Number of context specific w/a: 0
[    1.184778] [drm:sandybridge_pcode_read] warning: pcode (read from mbox 5) mailbox access failed for intel_enable_gt_powersave: -6
[    1.185079] [drm:intel_fbdev_init] found possible fb from plane A
[    1.185096] [drm:intel_fbdev_init] pipe B not active or no fb, skipping
[    1.185112] [drm:intel_fbdev_init] pipe C not active or no fb, skipping
[    1.185128] [drm:intel_fbdev_init] checking plane A for BIOS fb
[    1.185143] [drm:intel_fbdev_init] fb not wide enough for plane A (5464 vs 3200)
[    1.185161] [drm:intel_fbdev_init] BIOS fb not suitable for all pipes, not using
[    1.186926] [drm] Initialized i915 1.6.0 20180308 for 0000:00:02.0 on minor 0
[    1.187837] [drm:intel_opregion_register] 3 outputs detected
[    1.201504] [drm:drm_setup_crtcs] 
[    1.201552] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:64:VGA-1]
[    1.201560] [drm:intel_crt_detect] [CONNECTOR:64:VGA-1] force=1
[    1.201596] [drm:intel_crt_detect] trigger hotplug detect cycle: adpa=0xf40000
[    1.212014] [drm:intel_crt_detect] ironlake hotplug adpa=0xf40000, result 0
[    1.212034] [drm:intel_crt_detect] CRT not detected via hotplug
[    1.237855] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [EDID reports a digital panel]
[    1.237885] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:64:VGA-1] status updated from unknown to disconnected
[    1.237940] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:64:VGA-1] disconnected
[    1.237964] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:67:HDMI-A-1]
[    1.237993] [drm:intel_hdmi_detect] [CONNECTOR:67:HDMI-A-1]
[    1.263907] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    1.263938] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK on first message, retry
[    1.264150] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    1.264171] [drm:drm_dp_dual_mode_detect] DP dual mode HDMI ID:  (err -6)
[    1.264190] [drm:drm_detect_monitor_audio] Monitor has basic audio support
[    1.264208] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:67:HDMI-A-1] status updated from unknown to connected
[    1.264234] [drm:drm_add_display_info] non_desktop set to 0
[    1.264248] [drm:drm_add_display_info] HDMI: DVI dual 0, max TMDS clock 0 kHz
[    1.264276] [drm:drm_add_edid_modes] ELD monitor LC-32SV29U
[    1.264291] [drm:drm_add_edid_modes] HDMI: latency present 0 0, video latency 0 0, audio latency 0 0
[    1.264313] [drm:drm_add_edid_modes] ELD size 36, SAD count 1
[    1.264327] [drm:drm_add_display_info] non_desktop set to 0
[    1.264342] [drm:drm_add_display_info] HDMI: DVI dual 0, max TMDS clock 0 kHz
[    1.264718] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:67:HDMI-A-1] probed modes :
[    1.264746] [drm:drm_mode_debug_printmodeline] Modeline 78:"1366x768" 60 85750 1366 1436 1579 1792 768 771 774 798 0x48 0x5
[    1.264771] [drm:drm_mode_debug_printmodeline] Modeline 81:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    1.264798] [drm:drm_mode_debug_printmodeline] Modeline 112:"1920x1080" 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    1.264824] [drm:drm_mode_debug_printmodeline] Modeline 82:"1920x1080i" 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[    1.264851] [drm:drm_mode_debug_printmodeline] Modeline 113:"1920x1080i" 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[    1.264877] [drm:drm_mode_debug_printmodeline] Modeline 94:"1920x1080" 50 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[    1.264904] [drm:drm_mode_debug_printmodeline] Modeline 79:"1920x1080i" 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
[    1.264930] [drm:drm_mode_debug_printmodeline] Modeline 111:"1920x1080" 30 74250 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    1.264956] [drm:drm_mode_debug_printmodeline] Modeline 124:"1920x1080" 30 74176 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    1.264982] [drm:drm_mode_debug_printmodeline] Modeline 110:"1920x1080" 25 74250 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[    1.265009] [drm:drm_mode_debug_printmodeline] Modeline 109:"1920x1080" 24 74250 1920 2558 2602 2750 1080 1084 1089 1125 0x40 0x5
[    1.265035] [drm:drm_mode_debug_printmodeline] Modeline 123:"1920x1080" 24 74176 1920 2558 2602 2750 1080 1084 1089 1125 0x40 0x5
[    1.265061] [drm:drm_mode_debug_printmodeline] Modeline 103:"1280x720" 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[    1.265086] [drm:drm_mode_debug_printmodeline] Modeline 117:"1280x720" 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[    1.265112] [drm:drm_mode_debug_printmodeline] Modeline 80:"1280x720" 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
[    1.265137] [drm:drm_mode_debug_printmodeline] Modeline 89:"1024x768" 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[    1.265162] [drm:drm_mode_debug_printmodeline] Modeline 90:"1024x768" 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[    1.265188] [drm:drm_mode_debug_printmodeline] Modeline 91:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[    1.265213] [drm:drm_mode_debug_printmodeline] Modeline 92:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[    1.265237] [drm:drm_mode_debug_printmodeline] Modeline 93:"800x600" 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
[    1.265262] [drm:drm_mode_debug_printmodeline] Modeline 83:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[    1.265286] [drm:drm_mode_debug_printmodeline] Modeline 84:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[    1.265311] [drm:drm_mode_debug_printmodeline] Modeline 97:"720x576" 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
[    1.265335] [drm:drm_mode_debug_printmodeline] Modeline 98:"720x576i" 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
[    1.265360] [drm:drm_mode_debug_printmodeline] Modeline 118:"720x480" 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
[    1.265385] [drm:drm_mode_debug_printmodeline] Modeline 104:"720x480" 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
[    1.265410] [drm:drm_mode_debug_printmodeline] Modeline 119:"720x480i" 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
[    1.265435] [drm:drm_mode_debug_printmodeline] Modeline 105:"720x480i" 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
[    1.265460] [drm:drm_mode_debug_printmodeline] Modeline 85:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
[    1.265484] [drm:drm_mode_debug_printmodeline] Modeline 86:"640x480" 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
[    1.265509] [drm:drm_mode_debug_printmodeline] Modeline 114:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[    1.265533] [drm:drm_mode_debug_printmodeline] Modeline 87:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    1.265558] [drm:drm_mode_debug_printmodeline] Modeline 88:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[    1.265583] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:HDMI-A-2]
[    1.265602] [drm:intel_hdmi_detect] [CONNECTOR:73:HDMI-A-2]
[    1.265799] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    1.265818] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    1.266012] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    1.266031] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    1.266051] [drm:intel_hdmi_set_edid] HDMI GMBUS EDID read failed, retry using GPIO bit-banging
[    1.266072] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus dpd. force bit now 1
[    1.266917] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    1.266937] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus dpd. force bit now 0
[    1.267135] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    1.267153] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    1.267348] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    1.267367] [drm:drm_dp_dual_mode_detect] DP dual mode HDMI ID:  (err -6)
[    1.267384] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:HDMI-A-2] status updated from unknown to disconnected
[    1.267410] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:HDMI-A-2] disconnected
[    1.267431] [drm:drm_setup_crtcs] connector 64 enabled? no
[    1.267445] [drm:drm_setup_crtcs] connector 67 enabled? yes
[    1.267459] [drm:drm_setup_crtcs] connector 73 enabled? no
[    1.267489] [drm:intel_fb_initial_config] Not using firmware configuration
[    1.267509] [drm:drm_setup_crtcs] looking for cmdline mode on connector 67
[    1.267526] [drm:drm_setup_crtcs] looking for preferred mode on connector 67 0
[    1.267543] [drm:drm_setup_crtcs] found mode 1366x768
[    1.267557] [drm:drm_setup_crtcs] picking CRTCs for 8192x8192 config
[    1.267580] [drm:drm_setup_crtcs] desired mode 1366x768 set on crtc 39 (0,0)
[    1.267610] [drm:intelfb_create] no BIOS fb, allocating a new one
[    1.268152] [drm:intelfb_create] allocated 1366x768 fb: 0x00256000
[    1.268423] fbcon: inteldrmfb (fb0) is primary device
[    1.268835] [drm:intel_atomic_check] [CONNECTOR:67:HDMI-A-1] checking for sink bpp constrains
[    1.268839] [drm:intel_atomic_check] clamping display bpp (was 36) to EDID reported max of 24
[    1.268850] [drm:intel_hdmi_compute_config] picking bpc to 8 for HDMI output
[    1.268853] [drm:intel_hdmi_compute_config] forcing pipe bpp to 24 for HDMI
[    1.268855] [drm:intel_atomic_check] hw max bpp: 36, pipe bpp: 24, dithering: 0
[    1.268859] [drm:intel_dump_pipe_config] [CRTC:39:pipe A][modeset]
[    1.268862] [drm:intel_dump_pipe_config] output_types: HDMI (0x40)
[    1.268865] [drm:intel_dump_pipe_config] cpu_transcoder: A, pipe bpp: 24, dithering: 0
[    1.268867] [drm:intel_dump_pipe_config] audio: 1, infoframes: 1
[    1.268869] [drm:intel_dump_pipe_config] requested mode:
[    1.268872] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 85750 1366 1436 1579 1792 768 771 774 798 0x48 0x5
[    1.268874] [drm:intel_dump_pipe_config] adjusted mode:
[    1.268876] [drm:drm_mode_debug_printmodeline] Modeline 0:"1366x768" 60 85750 1366 1436 1579 1792 768 771 774 798 0x48 0x5
[    1.268879] [drm:intel_dump_pipe_config] crtc timings: 85750 1366 1436 1579 1792 768 771 774 798, type: 0x48 flags: 0x5
[    1.268882] [drm:intel_dump_pipe_config] port clock: 85750, pipe src size: 1366x768, pixel rate 85750
[    1.268884] [drm:intel_dump_pipe_config] pch pfit: pos: 0x00000000, size: 0x00000000, disabled
[    1.268886] [drm:intel_dump_pipe_config] ips: 0, double wide: 0
[    1.268889] [drm:intel_dump_pipe_config] dpll_hw_state: wrpll: 0xb065066a spll: 0x0
[    1.268891] [drm:intel_dump_pipe_config] planes on this crtc
[    1.268895] [drm:intel_dump_pipe_config] [PLANE:28:primary A] FB:76, fb = 800x600 format = XR24 little-endian (0x34325258)
[    1.268897] [drm:intel_dump_pipe_config] [PLANE:31:sprite A] disabled, scaler_id = 0
[    1.268900] [drm:intel_dump_pipe_config] [PLANE:36:cursor A] disabled, scaler_id = 0
[    1.269713] [drm:intel_find_shared_dpll] [CRTC:39:pipe A] allocated WRPLL 1
[    1.269715] [drm:intel_reference_shared_dpll] using WRPLL 1 for pipe A
[    1.269944] [drm:intel_disable_pipe] disabling pipe A
[    1.285289] [drm:intel_disable_shared_dpll] disable WRPLL 1 (active 1, on? 1) for crtc 39
[    1.285306] [drm:intel_disable_shared_dpll] disabling WRPLL 1
[    1.285317] [drm:intel_atomic_commit_tail] [ENCODER:65:CRT]
[    1.285320] [drm:intel_atomic_commit_tail] [ENCODER:66:DDI B]
[    1.285321] [drm:intel_atomic_commit_tail] [ENCODER:72:DDI D]
[    1.285324] [drm:verify_single_dpll_state.isra.79] WRPLL 1
[    1.285328] [drm:verify_single_dpll_state.isra.79] WRPLL 2
[    1.285331] [drm:verify_single_dpll_state.isra.79] SPLL
[    1.285335] [drm:verify_single_dpll_state.isra.79] LCPLL 810
[    1.285337] [drm:verify_single_dpll_state.isra.79] LCPLL 1350
[    1.285339] [drm:verify_single_dpll_state.isra.79] LCPLL 2700
[    1.285342] [drm:intel_enable_shared_dpll] enable WRPLL 1 (active 1, on? 0) for crtc 39
[    1.285344] [drm:intel_enable_shared_dpll] enabling WRPLL 1
[    1.285557] [drm:intel_enable_pipe] enabling pipe A
[    1.285577] [drm:intel_audio_codec_enable] ELD on [CONNECTOR:67:HDMI-A-1], [ENCODER:66:DDI B]
[    1.285579] [drm:hsw_audio_codec_enable] Enable audio codec on pipe A, 36 bytes ELD
[    1.285612] [drm:audio_config_hdmi_pixel_clock] HDMI audio pixel clock setting for 85750 not found, falling back to defaults
[    1.285621] [drm:audio_config_hdmi_pixel_clock] Configuring HDMI audio for pixel clock 25200 (0x00010000)
[    1.285623] [drm:hsw_audio_config_update] using automatic N
[    1.302372] [drm:verify_connector_state.isra.118] [CONNECTOR:67:HDMI-A-1]
[    1.302383] [drm:intel_atomic_commit_tail] [CRTC:39:pipe A]
[    1.302404] [drm:verify_single_dpll_state.isra.79] WRPLL 1
[    1.372031] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    1.387208] [drm:drm_fb_helper_hotplug_event.part.22] 
[    1.388659] [drm:drm_setup_crtcs] 
[    1.388684] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:64:VGA-1]
[    1.390212] [drm:intel_crt_detect] [CONNECTOR:64:VGA-1] force=1
[    1.391691] [drm:intel_crt_detect] ironlake hotplug adpa=0xf40000, result 0
[    1.393166] [drm:intel_crt_detect] CRT not detected via hotplug
[    1.419124] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [EDID reports a digital panel]
[    1.419992] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:64:VGA-1] disconnected
[    1.420853] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:67:HDMI-A-1]
[    1.421665] [drm:intel_hdmi_detect] [CONNECTOR:67:HDMI-A-1]
[    1.449504] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    1.450576] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK on first message, retry
[    1.452321] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    1.453794] [drm:drm_dp_dual_mode_detect] DP dual mode HDMI ID:  (err -6)
[    1.454600] [drm:drm_detect_monitor_audio] Monitor has basic audio support
[    1.456223] [drm:drm_add_display_info] non_desktop set to 0
[    1.457803] [drm:drm_add_display_info] HDMI: DVI dual 0, max TMDS clock 0 kHz
[    1.459418] [drm:drm_add_edid_modes] ELD monitor LC-32SV29U
[    1.461006] [drm:drm_add_edid_modes] HDMI: latency present 0 0, video latency 0 0, audio latency 0 0
[    1.463451] [drm:drm_add_edid_modes] ELD size 36, SAD count 1
[    1.464266] [drm:drm_add_display_info] non_desktop set to 0
[    1.465935] [drm:drm_add_display_info] HDMI: DVI dual 0, max TMDS clock 0 kHz
[    1.466345] [drm:drm_mode_debug_printmodeline] Modeline 81:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    1.467612] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    1.467618] [drm:drm_mode_debug_printmodeline] Modeline 112:"1920x1080" 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    1.467620] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    1.469380] [drm:drm_mode_debug_printmodeline] Modeline 82:"1920x1080i" 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[    1.471192] [drm:drm_mode_prune_invalid] Not using 1920x1080i mode: VIRTUAL_X
[    1.472933] [drm:drm_mode_debug_printmodeline] Modeline 113:"1920x1080i" 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[    1.474775] [drm:drm_mode_prune_invalid] Not using 1920x1080i mode: VIRTUAL_X
[    1.474780] [drm:drm_mode_debug_printmodeline] Modeline 94:"1920x1080" 0 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[    1.476620] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    1.476625] [drm:drm_mode_debug_printmodeline] Modeline 79:"1920x1080i" 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
[    1.478525] [drm:drm_mode_prune_invalid] Not using 1920x1080i mode: VIRTUAL_X
[    1.478530] [drm:drm_mode_debug_printmodeline] Modeline 111:"1920x1080" 0 74250 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    1.480460] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    1.480885] [drm:drm_mode_debug_printmodeline] Modeline 124:"1920x1080" 30 74176 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    1.482466] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    1.482471] [drm:drm_mode_debug_printmodeline] Modeline 110:"1920x1080" 0 74250 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[    1.484498] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    1.486557] [drm:drm_mode_debug_printmodeline] Modeline 109:"1920x1080" 0 74250 1920 2558 2602 2750 1080 1084 1089 1125 0x40 0x5
[    1.488646] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    1.488651] [drm:drm_mode_debug_printmodeline] Modeline 123:"1920x1080" 24 74176 1920 2558 2602 2750 1080 1084 1089 1125 0x40 0x5
[    1.490775] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    1.490785] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:67:HDMI-A-1] probed modes :
[    1.497013] [drm:drm_mode_debug_printmodeline] Modeline 78:"1366x768" 60 85750 1366 1436 1579 1792 768 771 774 798 0x48 0x5
[    1.497022] [drm:drm_mode_debug_printmodeline] Modeline 103:"1280x720" 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[    1.497030] [drm:drm_mode_debug_printmodeline] Modeline 117:"1280x720" 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[    1.497040] [drm:drm_mode_debug_printmodeline] Modeline 80:"1280x720" 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
[    1.505328] [drm:drm_mode_debug_printmodeline] Modeline 89:"1024x768" 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[    1.514063] [drm:drm_mode_debug_printmodeline] Modeline 90:"1024x768" 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[    1.516415] [drm:drm_mode_debug_printmodeline] Modeline 91:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[    1.516417] [drm:drm_mode_debug_printmodeline] Modeline 92:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[    1.518780] [drm:drm_mode_debug_printmodeline] Modeline 93:"800x600" 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
[    1.518783] [drm:drm_mode_debug_printmodeline] Modeline 83:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[    1.528456] [drm:drm_mode_debug_printmodeline] Modeline 84:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[    1.530928] [drm:drm_mode_debug_printmodeline] Modeline 97:"720x576" 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
[    1.530931] [drm:drm_mode_debug_printmodeline] Modeline 98:"720x576i" 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
[    1.530933] [drm:drm_mode_debug_printmodeline] Modeline 118:"720x480" 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
[    1.530935] [drm:drm_mode_debug_printmodeline] Modeline 104:"720x480" 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
[    1.530937] [drm:drm_mode_debug_printmodeline] Modeline 119:"720x480i" 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
[    1.530939] [drm:drm_mode_debug_printmodeline] Modeline 105:"720x480i" 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
[    1.530942] [drm:drm_mode_debug_printmodeline] Modeline 85:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
[    1.530944] [drm:drm_mode_debug_printmodeline] Modeline 86:"640x480" 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
[    1.530946] [drm:drm_mode_debug_printmodeline] Modeline 114:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[    1.530948] [drm:drm_mode_debug_printmodeline] Modeline 87:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    1.530950] [drm:drm_mode_debug_printmodeline] Modeline 88:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[    1.530955] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:HDMI-A-2]
[    1.533435] [drm:intel_hdmi_detect] [CONNECTOR:73:HDMI-A-2]
[    1.536080] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    1.538487] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    1.541071] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    1.543415] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    1.545933] [drm:intel_hdmi_set_edid] HDMI GMBUS EDID read failed, retry using GPIO bit-banging
[    1.548393] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus dpd. force bit now 1
[    1.551593] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    1.553133] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus dpd. force bit now 0
[    1.553313] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    1.555523] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    1.557929] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    1.559991] [drm:drm_dp_dual_mode_detect] DP dual mode HDMI ID:  (err -6)
[    1.562189] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:HDMI-A-2] disconnected
[    1.564342] [drm:drm_setup_crtcs] connector 64 enabled? no
[    1.566463] [drm:drm_setup_crtcs] connector 67 enabled? yes
[    1.568569] [drm:drm_setup_crtcs] connector 73 enabled? no
[    1.570690] [drm:intel_fb_initial_config] Not using firmware configuration
[    1.572744] [drm:drm_setup_crtcs] looking for cmdline mode on connector 67
[    1.574784] [drm:drm_setup_crtcs] looking for preferred mode on connector 67 0
[    1.576832] [drm:drm_setup_crtcs] found mode 1366x768
[    1.578896] [drm:drm_setup_crtcs] picking CRTCs for 1366x768 config
[    1.578917] [drm:drm_setup_crtcs] desired mode 1366x768 set on crtc 39 (0,0)
[    2.240332] [drm:drm_fb_helper_hotplug_event.part.22] 
[    2.243312] [drm:drm_setup_crtcs] 
[    2.246212] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:64:VGA-1]
[    2.249129] [drm:intel_crt_detect] [CONNECTOR:64:VGA-1] force=1
[    2.252091] [drm:intel_crt_detect] ironlake hotplug adpa=0xf40000, result 0
[    2.252882] [drm:intel_crt_detect] CRT not detected via hotplug
[    2.279580] [drm:intel_crt_detect_ddc] CRT not detected via DDC:0x50 [EDID reports a digital panel]
[    2.281451] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:64:VGA-1] disconnected
[    2.283292] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:67:HDMI-A-1]
[    2.285098] [drm:intel_hdmi_detect] [CONNECTOR:67:HDMI-A-1]
[    2.312744] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    2.314723] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK on first message, retry
[    2.316882] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    2.318829] [drm:drm_dp_dual_mode_detect] DP dual mode HDMI ID:  (err -6)
[    2.320790] [drm:drm_detect_monitor_audio] Monitor has basic audio support
[    2.321622] [drm:drm_add_display_info] non_desktop set to 0
[    2.322440] [drm:drm_add_display_info] HDMI: DVI dual 0, max TMDS clock 0 kHz
[    2.323275] [drm:drm_add_edid_modes] ELD monitor LC-32SV29U
[    2.324092] [drm:drm_add_edid_modes] HDMI: latency present 0 0, video latency 0 0, audio latency 0 0
[    2.324926] [drm:drm_add_edid_modes] ELD size 36, SAD count 1
[    2.325750] [drm:drm_add_display_info] non_desktop set to 0
[    2.326568] [drm:drm_add_display_info] HDMI: DVI dual 0, max TMDS clock 0 kHz
[    2.327783] [drm:drm_mode_debug_printmodeline] Modeline 81:"1920x1080i" 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
[    2.328646] [drm:drm_mode_prune_invalid] Not using 1920x1080i mode: VIRTUAL_X
[    2.329505] [drm:drm_mode_debug_printmodeline] Modeline 94:"1920x1080" 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    2.330401] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    2.331286] [drm:drm_mode_debug_printmodeline] Modeline 95:"1920x1080i" 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[    2.332209] [drm:drm_mode_prune_invalid] Not using 1920x1080i mode: VIRTUAL_X
[    2.333135] [drm:drm_mode_debug_printmodeline] Modeline 113:"1920x1080" 0 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[    2.334104] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    2.335079] [drm:drm_mode_debug_printmodeline] Modeline 132:"1920x1080" 0 74250 1920 2558 2602 2750 1080 1084 1089 1125 0x40 0x5
[    2.336088] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    2.337095] [drm:drm_mode_debug_printmodeline] Modeline 133:"1920x1080" 0 74250 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
[    2.338127] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    2.339150] [drm:drm_mode_debug_printmodeline] Modeline 134:"1920x1080" 0 74250 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    2.340214] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    2.341186] [drm:drm_mode_debug_printmodeline] Modeline 135:"1920x1080" 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    2.342185] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    2.343179] [drm:drm_mode_debug_printmodeline] Modeline 136:"1920x1080i" 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
[    2.344203] [drm:drm_mode_prune_invalid] Not using 1920x1080i mode: VIRTUAL_X
[    2.345219] [drm:drm_mode_debug_printmodeline] Modeline 146:"1920x1080" 24 74176 1920 2558 2602 2750 1080 1084 1089 1125 0x40 0x5
[    2.346257] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    2.347291] [drm:drm_mode_debug_printmodeline] Modeline 147:"1920x1080" 30 74176 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    2.348354] [drm:drm_mode_prune_invalid] Not using 1920x1080 mode: VIRTUAL_X
[    2.349424] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:67:HDMI-A-1] probed modes :
[    2.350513] [drm:drm_mode_debug_printmodeline] Modeline 78:"1366x768" 60 85750 1366 1436 1579 1792 768 771 774 798 0x48 0x5
[    2.351599] [drm:drm_mode_debug_printmodeline] Modeline 103:"1280x720" 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[    2.352680] [drm:drm_mode_debug_printmodeline] Modeline 117:"1280x720" 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[    2.353752] [drm:drm_mode_debug_printmodeline] Modeline 80:"1280x720" 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
[    2.354833] [drm:drm_mode_debug_printmodeline] Modeline 89:"1024x768" 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[    2.355913] [drm:drm_mode_debug_printmodeline] Modeline 90:"1024x768" 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[    2.356987] [drm:drm_mode_debug_printmodeline] Modeline 91:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[    2.358055] [drm:drm_mode_debug_printmodeline] Modeline 92:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[    2.359130] [drm:drm_mode_debug_printmodeline] Modeline 93:"800x600" 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
[    2.360202] [drm:drm_mode_debug_printmodeline] Modeline 83:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[    2.361252] [drm:drm_mode_debug_printmodeline] Modeline 84:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[    2.362306] [drm:drm_mode_debug_printmodeline] Modeline 97:"720x576" 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
[    2.363358] [drm:drm_mode_debug_printmodeline] Modeline 98:"720x576i" 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
[    2.364413] [drm:drm_mode_debug_printmodeline] Modeline 118:"720x480" 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
[    2.365472] [drm:drm_mode_debug_printmodeline] Modeline 104:"720x480" 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
[    2.366530] [drm:drm_mode_debug_printmodeline] Modeline 119:"720x480i" 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
[    2.367587] [drm:drm_mode_debug_printmodeline] Modeline 105:"720x480i" 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
[    2.368633] [drm:drm_mode_debug_printmodeline] Modeline 85:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
[    2.369680] [drm:drm_mode_debug_printmodeline] Modeline 86:"640x480" 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
[    2.370733] [drm:drm_mode_debug_printmodeline] Modeline 114:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
[    2.371778] [drm:drm_mode_debug_printmodeline] Modeline 87:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    2.372823] [drm:drm_mode_debug_printmodeline] Modeline 88:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[    2.373865] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:HDMI-A-2]
[    2.374910] [drm:intel_hdmi_detect] [CONNECTOR:73:HDMI-A-2]
[    2.376126] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    2.377171] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    2.378363] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    2.379367] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    2.380379] [drm:intel_hdmi_set_edid] HDMI GMBUS EDID read failed, retry using GPIO bit-banging
[    2.381371] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus dpd. force bit now 1
[    2.383140] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    2.384113] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus dpd. force bit now 0
[    2.385255] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    2.386215] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    2.387321] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    2.388240] [drm:drm_dp_dual_mode_detect] DP dual mode HDMI ID:  (err -6)
[    2.389143] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:73:HDMI-A-2] disconnected
[    2.390055] [drm:drm_setup_crtcs] connector 64 enabled? no
[    2.390933] [drm:drm_setup_crtcs] connector 67 enabled? yes
[    2.391787] [drm:drm_setup_crtcs] connector 73 enabled? no
[    2.392632] [drm:intel_fb_initial_config] Not using firmware configuration
[    2.393456] [drm:drm_setup_crtcs] looking for cmdline mode on connector 67
[    2.394266] [drm:drm_setup_crtcs] looking for preferred mode on connector 67 0
[    2.395058] [drm:drm_setup_crtcs] found mode 1366x768
[    2.395826] [drm:drm_setup_crtcs] picking CRTCs for 1366x768 config
[    2.396591] [drm:drm_setup_crtcs] desired mode 1366x768 set on crtc 39 (0,0)


and the i915 spew:



[    1.155231] calling  i915_init+0x0/0x4d @ 1
[    1.158717] [drm:i915_driver_load] ppgtt mode: 1
[    1.159665] [drm:i915_driver_load] guc_log_level=0 (enabled:no verbosity:-1)
[    1.160247] [drm:i915_ggtt_probe_hw] GGTT size = 2048M
[    1.160720] [drm:i915_ggtt_probe_hw] GMADR size = 256M
[    1.161189] [drm:i915_ggtt_probe_hw] DSM size = 64M
[    1.163819] [drm:i915_gem_init_stolen] Memory reserved for graphics device: 65536K, usable: 64512K
[    1.171492] [drm:i915_driver_load] rawclk rate: 125000 kHz
[    1.171572] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.176161] [drm:i915_gem_object_create_stolen_for_preallocated] creating preallocated stolen object: stolen_offset=0x0000000000000000, gtt_offset=0x0000000000000000, size=0x00000000001d5000
[    1.176553] WARNING: CPU: 1 PID: 1 at drivers/gpu/drm/i915/intel_display.c:14584 sanitize_watermarks+0x17b/0x1c0
[    1.176791]  i915_driver_load+0x9b9/0xf30
[    1.177379] [drm:i915_gem_init_ggtt] clearing unused GTT space: [1d6000, 80000000]
[    1.182941] [drm:i915_ppgtt_create] Allocated pde space (2M) at GTT entry: 7fe00
[    1.182962] [drm:i915_ppgtt_create] Adding PPGTT at offset 7fe00000
[    1.182995] [drm:i915_gem_contexts_init] logical context support initialized
[    1.186926] [drm] Initialized i915 1.6.0 20180308 for 0000:00:02.0 on minor 0
[    1.201464] i915 device info: pciid=0x0402 rev=0x06 platform=HASWELL gen=7
[    1.201481] i915 device info: is_mobile: no
[    1.201492] i915 device info: is_lp: no
[    1.201513] i915 device info: is_alpha_support: no
[    1.201515] i915 device info: has_64bit_reloc: no
[    1.201542] i915 device info: has_aliasing_ppgtt: yes
[    1.201570] i915 device info: has_csr: no
[    1.201572] i915 device info: has_ddi: yes
[    1.201573] i915 device info: has_dp_mst: yes
[    1.201599] i915 device info: has_reset_engine: no
[    1.201600] i915 device info: has_fbc: yes
[    1.201656] i915 device info: has_fpga_dbg: yes
[    1.201667] i915 device info: has_full_ppgtt: yes
[    1.201679] i915 device info: has_full_48bit_ppgtt: no
[    1.201692] i915 device info: has_gmch_display: no
[    1.201704] i915 device info: has_guc: no
[    1.201714] i915 device info: has_guc_ct: no
[    1.201725] i915 device info: has_hotplug: yes
[    1.201736] i915 device info: has_l3_dpf: yes
[    1.201747] i915 device info: has_llc: yes
[    1.201758] i915 device info: has_logical_ring_contexts: no
[    1.201771] i915 device info: has_logical_ring_elsq: no
[    1.201784] i915 device info: has_logical_ring_preemption: no
[    1.201798] i915 device info: has_overlay: no
[    1.201809] i915 device info: has_pooled_eu: no
[    1.201820] i915 device info: has_psr: yes
[    1.201831] i915 device info: has_rc6: yes
[    1.201842] i915 device info: has_rc6p: no
[    1.201852] i915 device info: has_resource_streamer: yes
[    1.201865] i915 device info: has_runtime_pm: yes
[    1.201877] i915 device info: has_snoop: no
[    1.201888] i915 device info: unfenced_needs_alignment: no
[    1.201901] i915 device info: cursor_needs_physical: no
[    1.201913] i915 device info: hws_needs_physical: no
[    1.201926] i915 device info: overlay_needs_physical: no
[    1.201938] i915 device info: supports_tv: no
[    1.201950] i915 device info: has_ipc: no
[    1.201960] i915 device info: slice mask: 0001
[    1.201972] i915 device info: slice total: 1
[    1.201983] i915 device info: subslice total: 1
[    1.201995] i915 device info: slice0 1 subslices mask=0001
[    1.202008] i915 device info: slice1 0 subslices mask=0000
[    1.202021] i915 device info: slice2 0 subslices mask=0000
[    1.202034] i915 device info: slice3 0 subslices mask=0000
[    1.202048] i915 device info: slice4 0 subslices mask=0000
[    1.202061] i915 device info: slice5 0 subslices mask=0000
[    1.202074] i915 device info: slice6 0 subslices mask=0000
[    1.202087] i915 device info: EU total: 10
[    1.202098] i915 device info: EU per subslice: 10
[    1.202110] i915 device info: has slice power gating: no
[    1.202123] i915 device info: has subslice power gating: no
[    1.202136] i915 device info: has EU power gating: no
[    1.202149] i915 device info: CS timestamp frequency: 12500 kHz
[    1.202224] initcall i915_init+0x0/0x4d returned 0 after 45438 usecs
[    1.263907] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    1.263938] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK on first message, retry
[    1.264150] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    1.265799] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    1.265818] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    1.266012] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    1.266031] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    1.266072] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus dpd. force bit now 1
[    1.266917] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    1.266937] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus dpd. force bit now 0
[    1.267135] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    1.267153] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    1.267348] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    1.372031] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    1.391511] hub 4-0:1.0: USB hub found
[    1.449504] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    1.450576] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK on first message, retry
[    1.452321] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    1.536080] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    1.538487] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    1.541071] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    1.543415] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    1.548393] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus dpd. force bit now 1
[    1.551593] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    1.553133] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus dpd. force bit now 0
[    1.553313] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    1.555523] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    1.557929] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    1.891537] r8169 0000:04:00.0 eth1: link down
[    2.312744] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    2.314723] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK on first message, retry
[    2.316882] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpb] NAK for addr: 0040 w(1)
[    2.339150] [drm:drm_mode_debug_printmodeline] Modeline 134:"1920x1080" 0 74250 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[    2.376126] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    2.377171] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    2.378363] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0050 w(1)
[    2.379367] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    2.381371] [drm:intel_gmbus_force_bit] enabling bit-banging on i915 gmbus dpd. force bit now 1
[    2.383140] [drm:drm_do_probe_ddc_edid] drm: skipping non-existent adapter i915 gmbus dpd
[    2.384113] [drm:intel_gmbus_force_bit] disabling bit-banging on i915 gmbus dpd. force bit now 0
[    2.385255] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
[    2.386215] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK on first message, retry
[    2.387321] [drm:do_gmbus_xfer] GMBUS [i915 gmbus dpd] NAK for addr: 0040 w(1)
