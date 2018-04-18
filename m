Date: Wed, 18 Apr 2018 17:52:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: dri-devel@lists.freedesktop.org, Borislav Petkov <bp@suse.de>,
	"Tobin C . Harding" <me@tobin.cc>,
	Alex Deucher <alexander.deucher@amd.com>,
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Cihangir Akturk <cakturk@gmail.com>, CK Hu <ck.hu@mediatek.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
	"David (ChunMing) Zhou" <David1.Zhou@amd.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	"Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Clark <robdclark@gmail.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Roger He <Hongbo.He@amd.com>,
	Roman Li <Roman.Li@amd.com>, Russell King <linux@armlinux.org.uk>,
	Samuel Li <Samuel.Li@amd.com>, Sandy Huang <hjc@rock-chips.com>,
	Sean Paul <seanpaul@chromium.org>, Shirish S <shirish.s@amd.com>,
	Sinclair Yeh <syeh@vmware.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Vincent Abriou <vincent.abriou@st.com>,
	VMware Graphics <linux-graphics-maintainer@vmware.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, etnaviv@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] drm: Print unadorned pointers
Message-ID: <20180418155209.GA1634@kroah.com>
References: <20180418092450.13798-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418092450.13798-1-abrodkin@synopsys.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 12:24:50PM +0300, Alexey Brodkin wrote:
> After commit ad67b74 ("printk: hash addresses printed with %p")
> pointers are being hashed when printed. However, this makes
> debug output completely useless. Switch to %px in order to see the
> unadorned kernel pointers.
> 
> This was done with the following one-liner:
>  find drivers/gpu/drm -type f -name "*.c" -exec sed -r -i '/DRM_DEBUG|KERN_DEBUG|pr_debug/ s/%p\b/%px/g' {} +
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tobin C. Harding <me@tobin.cc>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Cihangir Akturk <cakturk@gmail.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: "Heiko Stübner" <heiko@sntech.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: "Michel Dänzer" <michel.daenzer@amd.com>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Roger He <Hongbo.He@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Samuel Li <Samuel.Li@amd.com>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Shirish S <shirish.s@amd.com>
> Cc: Sinclair Yeh <syeh@vmware.com>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Tony Cheng <Tony.Cheng@amd.com>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: etnaviv@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 14 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 10 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c             | 18 ++++-----
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 +++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  2 +-
>  drivers/gpu/drm/armada/armada_gem.c                | 12 +++---
>  drivers/gpu/drm/drm_atomic.c                       | 44 +++++++++++-----------
>  drivers/gpu/drm/drm_bufs.c                         |  8 ++--
>  drivers/gpu/drm/drm_dp_mst_topology.c              |  4 +-
>  drivers/gpu/drm/drm_lease.c                        |  6 +--
>  drivers/gpu/drm/drm_lock.c                         |  2 +-
>  drivers/gpu/drm/drm_scatter.c                      |  4 +-
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  6 +--
>  drivers/gpu/drm/i810/i810_dma.c                    |  2 +-
>  drivers/gpu/drm/i915/i915_perf.c                   |  2 +-
>  drivers/gpu/drm/i915/intel_display.c               |  2 +-
>  drivers/gpu/drm/i915/intel_guc_ct.c                |  4 +-
>  drivers/gpu/drm/i915/intel_guc_submission.c        |  2 +-
>  drivers/gpu/drm/i915/intel_uc_fw.c                 |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c             |  2 +-
>  drivers/gpu/drm/mga/mga_warp.c                     |  2 +-
>  drivers/gpu/drm/msm/msm_drv.c                      |  4 +-
>  drivers/gpu/drm/qxl/qxl_cmd.c                      |  4 +-
>  drivers/gpu/drm/qxl/qxl_fb.c                       |  2 +-
>  drivers/gpu/drm/qxl/qxl_ttm.c                      |  2 +-
>  drivers/gpu/drm/radeon/radeon_display.c            |  2 +-
>  drivers/gpu/drm/radeon/radeon_dp_mst.c             | 12 +++---
>  drivers/gpu/drm/radeon/radeon_object.c             |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c      |  2 +-
>  drivers/gpu/drm/savage/savage_bci.c                |  2 +-
>  drivers/gpu/drm/sti/sti_gdp.c                      |  4 +-
>  drivers/gpu/drm/sti/sti_mixer.c                    |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  4 +-
>  drivers/gpu/drm/ttm/ttm_page_alloc.c               |  2 +-
>  drivers/gpu/drm/udl/udl_fb.c                       |  2 +-
>  drivers/gpu/drm/via/via_dma.c                      |  4 +-
>  drivers/gpu/drm/via/via_irq.c                      |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |  2 +-
>  45 files changed, 120 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1d6e1479da38..32e85fe83152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -438,7 +438,7 @@ static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
>  	if (!bo_va_entry)
>  		return -ENOMEM;
>  
> -	pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
> +	pr_debug("\t add VA 0x%llx - 0x%llx to vm %px\n", va,
>  			va + bo_size, vm);
>  
>  	/* Add BO to VM internal data structures*/

<snip>

As others have pointed out, please do not do this.  Use %pK as needed.
And perhaps revisit some of the "need" for these pointers at all in the
first place...

thanks,

greg k-h
