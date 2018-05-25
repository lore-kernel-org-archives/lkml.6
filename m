Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935438AbeEYGqs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:46:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38658 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeEYGqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:46:44 -0400
X-Google-Smtp-Source: ADUXVKKvEsW3fehb9z2EEVoXmHO+Md+CJ+lDOLBX8+1wsfYHRVeKlaJDN6cKezgsdFJcROpx63fJ1g==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] gpu: Consistently use octal not symbolic permissions
To: Joe Perches <joe@perches.com>, Russell King <linux@armlinux.org.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Rob Clark <robdclark@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Roger He <Hongbo.He@amd.com>, Dave Airlie <airlied@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org
References: <9b0f5f5cf6bccc003beef82f0972be655613075d.1527193246.git.joe@perches.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f87bca9e-1371-31a1-726a-4beee425cdfa@gmail.com>
Date: Fri, 25 May 2018 08:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9b0f5f5cf6bccc003beef82f0972be655613075d.1527193246.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well I think we rejected that multiple times now.

At least I find the symbolic permissions easier to read and I absolutely 
don't see any reason why we should only use one form.

Christian.

Am 24.05.2018 um 22:22 schrieb Joe Perches:
> There is currently a mixture of octal and symbolic permissions uses
> in files in drivers/gpu/drm and one file in drivers/gpu.
>
> There are ~270 existing octal uses and ~115 S_<FOO> uses.
>
> Convert all the S_<FOO> symbolic permissions to their octal equivalents
> as using octal and not symbolic permissions is preferred by many as more
> readable.
>
> see: https://lkml.org/lkml/2016/8/2/1945
>
> Done with automated conversion via:
> $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
>
> Miscellanea:
>
> o Wrapped modified multi-line calls to a single line where appropriate
> o Realign modified multi-line calls to open parenthesis
> o drivers/gpu/drm/msm/adreno/a5xx_debugfs.c has a world-writeable
>    debug permission for "reset" - perhaps that should be modified
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 98 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  9 +-
>   drivers/gpu/drm/armada/armada_debugfs.c            |  4 +-
>   drivers/gpu/drm/drm_debugfs.c                      |  6 +-
>   drivers/gpu/drm/drm_debugfs_crc.c                  |  4 +-
>   drivers/gpu/drm/drm_sysfs.c                        |  2 +-
>   drivers/gpu/drm/i915/gvt/firmware.c                |  2 +-
>   drivers/gpu/drm/i915/i915_debugfs.c                |  8 +-
>   drivers/gpu/drm/i915/i915_perf.c                   |  2 +-
>   drivers/gpu/drm/i915/i915_sysfs.c                  | 22 ++---
>   drivers/gpu/drm/i915/intel_pipe_crc.c              |  2 +-
>   drivers/gpu/drm/msm/adreno/a5xx_debugfs.c          |  5 +-
>   drivers/gpu/drm/msm/msm_perf.c                     |  4 +-
>   drivers/gpu/drm/msm/msm_rd.c                       |  4 +-
>   drivers/gpu/drm/nouveau/nouveau_debugfs.c          |  2 +-
>   drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    | 11 ++-
>   .../drm/omapdrm/displays/panel-sony-acx565akm.c    |  6 +-
>   .../drm/omapdrm/displays/panel-tpo-td043mtea1.c    | 10 +--
>   drivers/gpu/drm/radeon/radeon_pm.c                 | 26 +++---
>   drivers/gpu/drm/radeon/radeon_ttm.c                |  4 +-
>   drivers/gpu/drm/sti/sti_drv.c                      |  2 +-
>   drivers/gpu/drm/tinydrm/mipi-dbi.c                 |  4 +-
>   drivers/gpu/drm/ttm/ttm_bo.c                       |  2 +-
>   drivers/gpu/drm/ttm/ttm_memory.c                   | 12 +--
>   drivers/gpu/drm/ttm/ttm_page_alloc.c               |  6 +-
>   drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |  6 +-
>   drivers/gpu/drm/udl/udl_fb.c                       |  4 +-
>   drivers/gpu/host1x/debug.c                         | 12 +--
>   30 files changed, 138 insertions(+), 146 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f5fb93795a69..7b29febff511 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -830,7 +830,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
>   		ent = debugfs_create_file(debugfs_regs_names[i],
> -					  S_IFREG | S_IRUGO, root,
> +					  S_IFREG | 0444, root,
>   					  adev, debugfs_regs[i]);
>   		if (IS_ERR(ent)) {
>   			for (j = 0; j < i; j++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b455da487782..fa55d7e9e784 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -905,39 +905,39 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   	return -EINVAL;
>   }
>   
> -static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, amdgpu_get_dpm_state, amdgpu_set_dpm_state);
> -static DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(power_dpm_state, 0644, amdgpu_get_dpm_state, amdgpu_set_dpm_state);
> +static DEVICE_ATTR(power_dpm_force_performance_level, 0644,
>   		   amdgpu_get_dpm_forced_performance_level,
>   		   amdgpu_set_dpm_forced_performance_level);
> -static DEVICE_ATTR(pp_num_states, S_IRUGO, amdgpu_get_pp_num_states, NULL);
> -static DEVICE_ATTR(pp_cur_state, S_IRUGO, amdgpu_get_pp_cur_state, NULL);
> -static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_force_state,
> -		amdgpu_set_pp_force_state);
> -static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_table,
> -		amdgpu_set_pp_table);
> -static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_dpm_sclk,
> -		amdgpu_set_pp_dpm_sclk);
> -static DEVICE_ATTR(pp_dpm_mclk, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_dpm_mclk,
> -		amdgpu_set_pp_dpm_mclk);
> -static DEVICE_ATTR(pp_dpm_pcie, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_dpm_pcie,
> -		amdgpu_set_pp_dpm_pcie);
> -static DEVICE_ATTR(pp_sclk_od, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_sclk_od,
> -		amdgpu_set_pp_sclk_od);
> -static DEVICE_ATTR(pp_mclk_od, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_mclk_od,
> -		amdgpu_set_pp_mclk_od);
> -static DEVICE_ATTR(pp_power_profile_mode, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_power_profile_mode,
> -		amdgpu_set_pp_power_profile_mode);
> -static DEVICE_ATTR(pp_od_clk_voltage, S_IRUGO | S_IWUSR,
> -		amdgpu_get_pp_od_clk_voltage,
> -		amdgpu_set_pp_od_clk_voltage);
> +static DEVICE_ATTR(pp_num_states, 0444, amdgpu_get_pp_num_states, NULL);
> +static DEVICE_ATTR(pp_cur_state, 0444, amdgpu_get_pp_cur_state, NULL);
> +static DEVICE_ATTR(pp_force_state, 0644,
> +		   amdgpu_get_pp_force_state,
> +		   amdgpu_set_pp_force_state);
> +static DEVICE_ATTR(pp_table, 0644,
> +		   amdgpu_get_pp_table,
> +		   amdgpu_set_pp_table);
> +static DEVICE_ATTR(pp_dpm_sclk, 0644,
> +		   amdgpu_get_pp_dpm_sclk,
> +		   amdgpu_set_pp_dpm_sclk);
> +static DEVICE_ATTR(pp_dpm_mclk, 0644,
> +		   amdgpu_get_pp_dpm_mclk,
> +		   amdgpu_set_pp_dpm_mclk);
> +static DEVICE_ATTR(pp_dpm_pcie, 0644,
> +		   amdgpu_get_pp_dpm_pcie,
> +		   amdgpu_set_pp_dpm_pcie);
> +static DEVICE_ATTR(pp_sclk_od, 0644,
> +		   amdgpu_get_pp_sclk_od,
> +		   amdgpu_set_pp_sclk_od);
> +static DEVICE_ATTR(pp_mclk_od, 0644,
> +		   amdgpu_get_pp_mclk_od,
> +		   amdgpu_set_pp_mclk_od);
> +static DEVICE_ATTR(pp_power_profile_mode, 0644,
> +		   amdgpu_get_pp_power_profile_mode,
> +		   amdgpu_set_pp_power_profile_mode);
> +static DEVICE_ATTR(pp_od_clk_voltage, 0644,
> +		   amdgpu_get_pp_od_clk_voltage,
> +		   amdgpu_set_pp_od_clk_voltage);
>   
>   static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>   				      struct device_attribute *attr,
> @@ -1320,22 +1320,22 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>    *
>    */
>   
> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, amdgpu_hwmon_show_temp, NULL, 0);
> -static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, amdgpu_hwmon_show_temp_thresh, NULL, 0);
> -static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, amdgpu_hwmon_show_temp_thresh, NULL, 1);
> -static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, amdgpu_hwmon_get_pwm1, amdgpu_hwmon_set_pwm1, 0);
> -static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, amdgpu_hwmon_get_pwm1_enable, amdgpu_hwmon_set_pwm1_enable, 0);
> -static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, amdgpu_hwmon_get_pwm1_min, NULL, 0);
> -static SENSOR_DEVICE_ATTR(pwm1_max, S_IRUGO, amdgpu_hwmon_get_pwm1_max, NULL, 0);
> -static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, amdgpu_hwmon_get_fan1_input, NULL, 0);
> -static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, amdgpu_hwmon_show_vddgfx, NULL, 0);
> -static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, amdgpu_hwmon_show_vddgfx_label, NULL, 0);
> -static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, amdgpu_hwmon_show_vddnb, NULL, 0);
> -static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, amdgpu_hwmon_show_vddnb_label, NULL, 0);
> -static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 0);
> -static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);
> -static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 0);
> -static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, amdgpu_hwmon_show_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_crit, 0444, amdgpu_hwmon_show_temp_thresh, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, 0444, amdgpu_hwmon_show_temp_thresh, NULL, 1);
> +static SENSOR_DEVICE_ATTR(pwm1, 0644, amdgpu_hwmon_get_pwm1, amdgpu_hwmon_set_pwm1, 0);
> +static SENSOR_DEVICE_ATTR(pwm1_enable, 0644, amdgpu_hwmon_get_pwm1_enable, amdgpu_hwmon_set_pwm1_enable, 0);
> +static SENSOR_DEVICE_ATTR(pwm1_min, 0444, amdgpu_hwmon_get_pwm1_min, NULL, 0);
> +static SENSOR_DEVICE_ATTR(pwm1_max, 0444, amdgpu_hwmon_get_pwm1_max, NULL, 0);
> +static SENSOR_DEVICE_ATTR(fan1_input, 0444, amdgpu_hwmon_get_fan1_input, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in0_input, 0444, amdgpu_hwmon_show_vddgfx, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in0_label, 0444, amdgpu_hwmon_show_vddgfx_label, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_input, 0444, amdgpu_hwmon_show_vddnb, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_label, 0444, amdgpu_hwmon_show_vddnb_label, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power1_average, 0444, amdgpu_hwmon_show_power_avg, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power1_cap_max, 0444, amdgpu_hwmon_show_power_cap_max, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power1_cap_min, 0444, amdgpu_hwmon_show_power_cap_min, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power1_cap, 0644, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
>   
>   static struct attribute *hwmon_attributes[] = {
>   	&sensor_dev_attr_temp1_input.dev_attr.attr,
> @@ -1388,13 +1388,13 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   	     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
>   	    (!adev->powerplay.pp_funcs->get_fan_control_mode &&
>   	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
> -		effective_mode &= ~S_IRUGO;
> +		effective_mode &= ~0444;
>   
>   	if ((!adev->powerplay.pp_funcs->set_fan_speed_percent &&
>   	     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
>   	    (!adev->powerplay.pp_funcs->set_fan_control_mode &&
>   	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
> -		effective_mode &= ~S_IWUSR;
> +		effective_mode &= ~0200;
>   
>   	if ((adev->flags & AMD_IS_APU) &&
>   	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 49cad08b5c16..22c56367ee8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -553,8 +553,7 @@ static int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   
>   	sprintf(name, "amdgpu_ring_%s", ring->name);
>   
> -	ent = debugfs_create_file(name,
> -				  S_IFREG | S_IRUGO, root,
> +	ent = debugfs_create_file(name, S_IFREG | 0444, root,
>   				  ring, &amdgpu_debugfs_ring_fops);
>   	if (!ent)
>   		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 69a2b25b3696..696a2617930f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2160,11 +2160,10 @@ static int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
>   	struct dentry *ent, *root = minor->debugfs_root;
>   
>   	for (count = 0; count < ARRAY_SIZE(ttm_debugfs_entries); count++) {
> -		ent = debugfs_create_file(
> -				ttm_debugfs_entries[count].name,
> -				S_IFREG | S_IRUGO, root,
> -				adev,
> -				ttm_debugfs_entries[count].fops);
> +		ent = debugfs_create_file(ttm_debugfs_entries[count].name,
> +					  S_IFREG | 0444, root,
> +					  adev,
> +					  ttm_debugfs_entries[count].fops);
>   		if (IS_ERR(ent))
>   			return PTR_ERR(ent);
>   		if (ttm_debugfs_entries[count].domain == TTM_PL_VRAM)
> diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
> index 6758c3a83de2..9be396e4b6dd 100644
> --- a/drivers/gpu/drm/armada/armada_debugfs.c
> +++ b/drivers/gpu/drm/armada/armada_debugfs.c
> @@ -118,12 +118,12 @@ int armada_drm_debugfs_init(struct drm_minor *minor)
>   	if (ret)
>   		return ret;
>   
> -	de = debugfs_create_file("reg", S_IFREG | S_IRUSR,
> +	de = debugfs_create_file("reg", S_IFREG | 0400,
>   				 minor->debugfs_root, minor->dev, &fops_reg_r);
>   	if (!de)
>   		return -ENOMEM;
>   
> -	de = debugfs_create_file("reg_wr", S_IFREG | S_IWUSR,
> +	de = debugfs_create_file("reg_wr", S_IFREG | 0200,
>   				 minor->debugfs_root, minor->dev, &fops_reg_w);
>   	if (!de)
>   		return -ENOMEM;
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index b2482818fee8..84c91018a398 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -99,7 +99,7 @@ int drm_debugfs_create_files(const struct drm_info_list *files, int count,
>   			ret = -1;
>   			goto fail;
>   		}
> -		ent = debugfs_create_file(files[i].name, S_IFREG | S_IRUGO,
> +		ent = debugfs_create_file(files[i].name, S_IFREG | 0444,
>   					  root, tmp, &drm_debugfs_fops);
>   		if (!ent) {
>   			DRM_ERROR("Cannot create /sys/kernel/debug/dri/%pd/%s\n",
> @@ -357,13 +357,13 @@ int drm_debugfs_connector_add(struct drm_connector *connector)
>   	connector->debugfs_entry = root;
>   
>   	/* force */
> -	ent = debugfs_create_file("force", S_IRUGO | S_IWUSR, root, connector,
> +	ent = debugfs_create_file("force", 0644, root, connector,
>   				  &drm_connector_fops);
>   	if (!ent)
>   		goto error;
>   
>   	/* edid */
> -	ent = debugfs_create_file("edid_override", S_IRUGO | S_IWUSR, root,
> +	ent = debugfs_create_file("edid_override", 0644, root,
>   				  connector, &drm_edid_fops);
>   	if (!ent)
>   		goto error;
> diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
> index 9f8312137cad..63dd290963a7 100644
> --- a/drivers/gpu/drm/drm_debugfs_crc.c
> +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> @@ -344,12 +344,12 @@ int drm_debugfs_crtc_crc_add(struct drm_crtc *crtc)
>   	if (!crc_ent)
>   		return -ENOMEM;
>   
> -	ent = debugfs_create_file("control", S_IRUGO, crc_ent, crtc,
> +	ent = debugfs_create_file("control", 0444, crc_ent, crtc,
>   				  &drm_crtc_crc_control_fops);
>   	if (!ent)
>   		goto error;
>   
> -	ent = debugfs_create_file("data", S_IRUGO, crc_ent, crtc,
> +	ent = debugfs_create_file("data", 0444, crc_ent, crtc,
>   				  &drm_crtc_crc_data_fops);
>   	if (!ent)
>   		goto error;
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index b3c1daad1169..c64019f14c79 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -50,7 +50,7 @@ static char *drm_devnode(struct device *dev, umode_t *mode)
>   	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
>   }
>   
> -static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
> +static CLASS_ATTR_STRING(version, 0444, "drm 1.1.0 20060810");
>   
>   /**
>    * drm_sysfs_init - initialize sysfs helpers
> diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
> index a73e1d418c22..33b8c4f38fd8 100644
> --- a/drivers/gpu/drm/i915/gvt/firmware.c
> +++ b/drivers/gpu/drm/i915/gvt/firmware.c
> @@ -60,7 +60,7 @@ gvt_firmware_read(struct file *filp, struct kobject *kobj,
>   }
>   
>   static struct bin_attribute firmware_attr = {
> -	.attr = {.name = "gvt_firmware", .mode = (S_IRUSR)},
> +	.attr = {.name = "gvt_firmware", .mode = 0400},
>   	.read = gvt_firmware_read,
>   	.write = NULL,
>   	.mmap = NULL,
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 13e7b9e4a6e6..1796626a858f 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -4851,7 +4851,7 @@ int i915_debugfs_register(struct drm_i915_private *dev_priv)
>   	struct dentry *ent;
>   	int ret, i;
>   
> -	ent = debugfs_create_file("i915_forcewake_user", S_IRUSR,
> +	ent = debugfs_create_file("i915_forcewake_user", 0400,
>   				  minor->debugfs_root, to_i915(minor->dev),
>   				  &i915_forcewake_fops);
>   	if (!ent)
> @@ -4863,7 +4863,7 @@ int i915_debugfs_register(struct drm_i915_private *dev_priv)
>   
>   	for (i = 0; i < ARRAY_SIZE(i915_debugfs_files); i++) {
>   		ent = debugfs_create_file(i915_debugfs_files[i].name,
> -					  S_IRUGO | S_IWUSR,
> +					  0644,
>   					  minor->debugfs_root,
>   					  to_i915(minor->dev),
>   					  i915_debugfs_files[i].fops);
> @@ -4979,11 +4979,11 @@ int i915_debugfs_connector_add(struct drm_connector *connector)
>   
>   	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
>   	    connector->connector_type == DRM_MODE_CONNECTOR_eDP)
> -		debugfs_create_file("i915_dpcd", S_IRUGO, root,
> +		debugfs_create_file("i915_dpcd", 0444, root,
>   				    connector, &i915_dpcd_fops);
>   
>   	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
> -		debugfs_create_file("i915_panel_timings", S_IRUGO, root,
> +		debugfs_create_file("i915_panel_timings", 0444, root,
>   				    connector, &i915_panel_fops);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 019bd2d073ad..8e5009445963 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -3148,7 +3148,7 @@ static int create_dynamic_oa_sysfs_entry(struct drm_i915_private *dev_priv,
>   {
>   	sysfs_attr_init(&oa_config->sysfs_metric_id.attr);
>   	oa_config->sysfs_metric_id.attr.name = "id";
> -	oa_config->sysfs_metric_id.attr.mode = S_IRUGO;
> +	oa_config->sysfs_metric_id.attr.mode = 0444;
>   	oa_config->sysfs_metric_id.show = show_dynamic_id;
>   	oa_config->sysfs_metric_id.store = NULL;
>   
> diff --git a/drivers/gpu/drm/i915/i915_sysfs.c b/drivers/gpu/drm/i915/i915_sysfs.c
> index e5e6f6bb2b05..a8e25465bf1a 100644
> --- a/drivers/gpu/drm/i915/i915_sysfs.c
> +++ b/drivers/gpu/drm/i915/i915_sysfs.c
> @@ -100,11 +100,11 @@ show_media_rc6_ms(struct device *kdev, struct device_attribute *attr, char *buf)
>   	return snprintf(buf, PAGE_SIZE, "%u\n", rc6_residency);
>   }
>   
> -static DEVICE_ATTR(rc6_enable, S_IRUGO, show_rc6_mask, NULL);
> -static DEVICE_ATTR(rc6_residency_ms, S_IRUGO, show_rc6_ms, NULL);
> -static DEVICE_ATTR(rc6p_residency_ms, S_IRUGO, show_rc6p_ms, NULL);
> -static DEVICE_ATTR(rc6pp_residency_ms, S_IRUGO, show_rc6pp_ms, NULL);
> -static DEVICE_ATTR(media_rc6_residency_ms, S_IRUGO, show_media_rc6_ms, NULL);
> +static DEVICE_ATTR(rc6_enable, 0444, show_rc6_mask, NULL);
> +static DEVICE_ATTR(rc6_residency_ms, 0444, show_rc6_ms, NULL);
> +static DEVICE_ATTR(rc6p_residency_ms, 0444, show_rc6p_ms, NULL);
> +static DEVICE_ATTR(rc6pp_residency_ms, 0444, show_rc6pp_ms, NULL);
> +static DEVICE_ATTR(media_rc6_residency_ms, 0444, show_media_rc6_ms, NULL);
>   
>   static struct attribute *rc6_attrs[] = {
>   	&dev_attr_rc6_enable.attr,
> @@ -237,7 +237,7 @@ i915_l3_write(struct file *filp, struct kobject *kobj,
>   }
>   
>   static const struct bin_attribute dpf_attrs = {
> -	.attr = {.name = "l3_parity", .mode = (S_IRUSR | S_IWUSR)},
> +	.attr = {.name = "l3_parity", .mode = 0600},
>   	.size = GEN7_L3LOG_SIZE,
>   	.read = i915_l3_read,
>   	.write = i915_l3_write,
> @@ -246,7 +246,7 @@ static const struct bin_attribute dpf_attrs = {
>   };
>   
>   static const struct bin_attribute dpf_attrs_1 = {
> -	.attr = {.name = "l3_parity_slice_1", .mode = (S_IRUSR | S_IWUSR)},
> +	.attr = {.name = "l3_parity_slice_1", .mode = 0600},
>   	.size = GEN7_L3LOG_SIZE,
>   	.read = i915_l3_read,
>   	.write = i915_l3_write,
> @@ -460,9 +460,9 @@ static DEVICE_ATTR_RW(gt_min_freq_mhz);
>   static DEVICE_ATTR_RO(vlv_rpe_freq_mhz);
>   
>   static ssize_t gt_rp_mhz_show(struct device *kdev, struct device_attribute *attr, char *buf);
> -static DEVICE_ATTR(gt_RP0_freq_mhz, S_IRUGO, gt_rp_mhz_show, NULL);
> -static DEVICE_ATTR(gt_RP1_freq_mhz, S_IRUGO, gt_rp_mhz_show, NULL);
> -static DEVICE_ATTR(gt_RPn_freq_mhz, S_IRUGO, gt_rp_mhz_show, NULL);
> +static DEVICE_ATTR(gt_RP0_freq_mhz, 0444, gt_rp_mhz_show, NULL);
> +static DEVICE_ATTR(gt_RP1_freq_mhz, 0444, gt_rp_mhz_show, NULL);
> +static DEVICE_ATTR(gt_RPn_freq_mhz, 0444, gt_rp_mhz_show, NULL);
>   
>   /* For now we have a static number of RP states */
>   static ssize_t gt_rp_mhz_show(struct device *kdev, struct device_attribute *attr, char *buf)
> @@ -555,7 +555,7 @@ static ssize_t error_state_write(struct file *file, struct kobject *kobj,
>   
>   static const struct bin_attribute error_state_attr = {
>   	.attr.name = "error",
> -	.attr.mode = S_IRUSR | S_IWUSR,
> +	.attr.mode = 0600,
>   	.size = 0,
>   	.read = error_state_read,
>   	.write = error_state_write,
> diff --git a/drivers/gpu/drm/i915/intel_pipe_crc.c b/drivers/gpu/drm/i915/intel_pipe_crc.c
> index 39a4e4edda07..2a34ac8e319b 100644
> --- a/drivers/gpu/drm/i915/intel_pipe_crc.c
> +++ b/drivers/gpu/drm/i915/intel_pipe_crc.c
> @@ -903,7 +903,7 @@ int intel_pipe_crc_create(struct drm_minor *minor)
>   		struct pipe_crc_info *info = &i915_pipe_crc_data[i];
>   
>   		info->dev_priv = dev_priv;
> -		ent = debugfs_create_file(info->name, S_IRUGO,
> +		ent = debugfs_create_file(info->name, 0444,
>   					  minor->debugfs_root, info,
>   					  &i915_pipe_crc_fops);
>   		if (!ent)
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> index 059ec7d394d0..c4373a5a18be 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> @@ -177,9 +177,8 @@ int a5xx_debugfs_init(struct msm_gpu *gpu, struct drm_minor *minor)
>   		return ret;
>   	}
>   
> -	ent = debugfs_create_file("reset", S_IWUGO,
> -		minor->debugfs_root,
> -		dev, &reset_fops);
> +	ent = debugfs_create_file("reset", 0222, minor->debugfs_root,
> +				  dev, &reset_fops);
>   	if (!ent)
>   		return -ENOMEM;
>   
> diff --git a/drivers/gpu/drm/msm/msm_perf.c b/drivers/gpu/drm/msm/msm_perf.c
> index 5ab21bd2decb..ad1cffe72bf4 100644
> --- a/drivers/gpu/drm/msm/msm_perf.c
> +++ b/drivers/gpu/drm/msm/msm_perf.c
> @@ -220,8 +220,8 @@ int msm_perf_debugfs_init(struct drm_minor *minor)
>   	mutex_init(&perf->read_lock);
>   	priv->perf = perf;
>   
> -	ent = debugfs_create_file("perf", S_IFREG | S_IRUGO,
> -			minor->debugfs_root, perf, &perf_debugfs_fops);
> +	ent = debugfs_create_file("perf", S_IFREG | 0444, minor->debugfs_root,
> +				  perf, &perf_debugfs_fops);
>   	if (!ent) {
>   		DRM_ERROR("Cannot create /sys/kernel/debug/dri/%pd/perf\n",
>   				minor->debugfs_root);
> diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
> index 3aa8a8576abe..c6172980951d 100644
> --- a/drivers/gpu/drm/msm/msm_rd.c
> +++ b/drivers/gpu/drm/msm/msm_rd.c
> @@ -253,8 +253,8 @@ static struct msm_rd_state *rd_init(struct drm_minor *minor, const char *name)
>   
>   	init_waitqueue_head(&rd->fifo_event);
>   
> -	ent = debugfs_create_file(name, S_IFREG | S_IRUGO,
> -			minor->debugfs_root, rd, &rd_debugfs_fops);
> +	ent = debugfs_create_file(name, S_IFREG | 0444, minor->debugfs_root,
> +				  rd, &rd_debugfs_fops);
>   	if (!ent) {
>   		DRM_ERROR("Cannot create /sys/kernel/debug/dri/%pd/%s\n",
>   				minor->debugfs_root, name);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 963a4dba8213..7e6b2cca241e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -200,7 +200,7 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
>   
>   	for (i = 0; i < ARRAY_SIZE(nouveau_debugfs_files); i++) {
>   		dentry = debugfs_create_file(nouveau_debugfs_files[i].name,
> -					     S_IRUGO | S_IWUSR,
> +					     0644,
>   					     minor->debugfs_root, minor->dev,
>   					     nouveau_debugfs_files[i].fops);
>   		if (!dentry)
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> index 428de90fced1..2ed5d90b62ae 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> @@ -569,12 +569,11 @@ static ssize_t dsicm_show_ulps_timeout(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%u\n", t);
>   }
>   
> -static DEVICE_ATTR(num_dsi_errors, S_IRUGO, dsicm_num_errors_show, NULL);
> -static DEVICE_ATTR(hw_revision, S_IRUGO, dsicm_hw_revision_show, NULL);
> -static DEVICE_ATTR(ulps, S_IRUGO | S_IWUSR,
> -		dsicm_show_ulps, dsicm_store_ulps);
> -static DEVICE_ATTR(ulps_timeout, S_IRUGO | S_IWUSR,
> -		dsicm_show_ulps_timeout, dsicm_store_ulps_timeout);
> +static DEVICE_ATTR(num_dsi_errors, 0444, dsicm_num_errors_show, NULL);
> +static DEVICE_ATTR(hw_revision, 0444, dsicm_hw_revision_show, NULL);
> +static DEVICE_ATTR(ulps, 0644, dsicm_show_ulps, dsicm_store_ulps);
> +static DEVICE_ATTR(ulps_timeout, 0644,
> +		   dsicm_show_ulps_timeout, dsicm_store_ulps_timeout);
>   
>   static struct attribute *dsicm_attrs[] = {
>   	&dev_attr_num_dsi_errors.attr,
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
> index 92fe125ce22e..37a34d55eb99 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
> @@ -492,10 +492,8 @@ static ssize_t show_cabc_available_modes(struct device *dev,
>   	return len < PAGE_SIZE ? len : PAGE_SIZE - 1;
>   }
>   
> -static DEVICE_ATTR(cabc_mode, S_IRUGO | S_IWUSR,
> -		show_cabc_mode, store_cabc_mode);
> -static DEVICE_ATTR(cabc_available_modes, S_IRUGO,
> -		show_cabc_available_modes, NULL);
> +static DEVICE_ATTR(cabc_mode, 0644, show_cabc_mode, store_cabc_mode);
> +static DEVICE_ATTR(cabc_available_modes, 0444, show_cabc_available_modes, NULL);
>   
>   static struct attribute *bldev_attrs[] = {
>   	&dev_attr_cabc_mode.attr,
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
> index c08e22b43447..e06fe61f8c7e 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
> @@ -268,12 +268,10 @@ static ssize_t tpo_td043_gamma_store(struct device *dev,
>   	return count;
>   }
>   
> -static DEVICE_ATTR(vmirror, S_IRUGO | S_IWUSR,
> -		tpo_td043_vmirror_show, tpo_td043_vmirror_store);
> -static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
> -		tpo_td043_mode_show, tpo_td043_mode_store);
> -static DEVICE_ATTR(gamma, S_IRUGO | S_IWUSR,
> -		tpo_td043_gamma_show, tpo_td043_gamma_store);
> +static DEVICE_ATTR(vmirror, 0644,
> +		   tpo_td043_vmirror_show, tpo_td043_vmirror_store);
> +static DEVICE_ATTR(mode, 0644, tpo_td043_mode_show, tpo_td043_mode_store);
> +static DEVICE_ATTR(gamma, 0644, tpo_td043_gamma_show, tpo_td043_gamma_store);
>   
>   static struct attribute *tpo_td043_attrs[] = {
>   	&dev_attr_vmirror.attr,
> diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
> index 4b6542538ff9..45801c27d23b 100644
> --- a/drivers/gpu/drm/radeon/radeon_pm.c
> +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -655,10 +655,10 @@ static ssize_t radeon_hwmon_get_pwm1(struct device *dev,
>   	return sprintf(buf, "%i\n", speed);
>   }
>   
> -static DEVICE_ATTR(power_profile, S_IRUGO | S_IWUSR, radeon_get_pm_profile, radeon_set_pm_profile);
> -static DEVICE_ATTR(power_method, S_IRUGO | S_IWUSR, radeon_get_pm_method, radeon_set_pm_method);
> -static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR, radeon_get_dpm_state, radeon_set_dpm_state);
> -static DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(power_profile, 0644, radeon_get_pm_profile, radeon_set_pm_profile);
> +static DEVICE_ATTR(power_method, 0644, radeon_get_pm_method, radeon_set_pm_method);
> +static DEVICE_ATTR(power_dpm_state, 0644, radeon_get_dpm_state, radeon_set_dpm_state);
> +static DEVICE_ATTR(power_dpm_force_performance_level, 0644,
>   		   radeon_get_dpm_forced_performance_level,
>   		   radeon_set_dpm_forced_performance_level);
>   
> @@ -699,13 +699,13 @@ static ssize_t radeon_hwmon_show_temp_thresh(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
>   }
>   
> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, radeon_hwmon_show_temp, NULL, 0);
> -static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, radeon_hwmon_show_temp_thresh, NULL, 0);
> -static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, radeon_hwmon_show_temp_thresh, NULL, 1);
> -static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, radeon_hwmon_get_pwm1, radeon_hwmon_set_pwm1, 0);
> -static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, radeon_hwmon_get_pwm1_enable, radeon_hwmon_set_pwm1_enable, 0);
> -static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, radeon_hwmon_get_pwm1_min, NULL, 0);
> -static SENSOR_DEVICE_ATTR(pwm1_max, S_IRUGO, radeon_hwmon_get_pwm1_max, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, radeon_hwmon_show_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_crit, 0444, radeon_hwmon_show_temp_thresh, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, 0444, radeon_hwmon_show_temp_thresh, NULL, 1);
> +static SENSOR_DEVICE_ATTR(pwm1, 0644, radeon_hwmon_get_pwm1, radeon_hwmon_set_pwm1, 0);
> +static SENSOR_DEVICE_ATTR(pwm1_enable, 0644, radeon_hwmon_get_pwm1_enable, radeon_hwmon_set_pwm1_enable, 0);
> +static SENSOR_DEVICE_ATTR(pwm1_min, 0444, radeon_hwmon_get_pwm1_min, NULL, 0);
> +static SENSOR_DEVICE_ATTR(pwm1_max, 0444, radeon_hwmon_get_pwm1_max, NULL, 0);
>   
>   
>   static struct attribute *hwmon_attributes[] = {
> @@ -749,13 +749,13 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   	     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
>   	    (!rdev->asic->dpm.fan_ctrl_get_mode &&
>   	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
> -		effective_mode &= ~S_IRUGO;
> +		effective_mode &= ~0444;
>   
>   	if ((!rdev->asic->dpm.set_fan_speed_percent &&
>   	     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
>   	    (!rdev->asic->dpm.fan_ctrl_set_mode &&
>   	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
> -		effective_mode &= ~S_IWUSR;
> +		effective_mode &= ~0200;
>   
>   	/* hide max/min values if we can't both query and manage the fan */
>   	if ((!rdev->asic->dpm.set_fan_speed_percent &&
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 8689fcca051c..71b2bed0b983 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -1136,13 +1136,13 @@ static int radeon_ttm_debugfs_init(struct radeon_device *rdev)
>   	struct drm_minor *minor = rdev->ddev->primary;
>   	struct dentry *ent, *root = minor->debugfs_root;
>   
> -	ent = debugfs_create_file("radeon_vram", S_IFREG | S_IRUGO, root,
> +	ent = debugfs_create_file("radeon_vram", S_IFREG | 0444, root,
>   				  rdev, &radeon_ttm_vram_fops);
>   	if (IS_ERR(ent))
>   		return PTR_ERR(ent);
>   	rdev->mman.vram = ent;
>   
> -	ent = debugfs_create_file("radeon_gtt", S_IFREG | S_IRUGO, root,
> +	ent = debugfs_create_file("radeon_gtt", S_IFREG | 0444, root,
>   				  rdev, &radeon_ttm_gtt_fops);
>   	if (IS_ERR(ent))
>   		return PTR_ERR(ent);
> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> index 90c46b49c931..fafa9a781493 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -104,7 +104,7 @@ static int sti_drm_dbg_init(struct drm_minor *minor)
>   	if (ret)
>   		goto err;
>   
> -	dentry = debugfs_create_file("fps_show", S_IRUGO | S_IWUSR,
> +	dentry = debugfs_create_file("fps_show", 0644,
>   				     minor->debugfs_root, minor->dev,
>   				     &sti_drm_fps_fops);
>   	if (!dentry) {
> diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> index 4d1fb31a781f..55bd38f1507b 100644
> --- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> +++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> @@ -1055,10 +1055,10 @@ int mipi_dbi_debugfs_init(struct drm_minor *minor)
>   {
>   	struct tinydrm_device *tdev = minor->dev->dev_private;
>   	struct mipi_dbi *mipi = mipi_dbi_from_tinydrm(tdev);
> -	umode_t mode = S_IFREG | S_IWUSR;
> +	umode_t mode = S_IFREG | 0200;
>   
>   	if (mipi->read_commands)
> -		mode |= S_IRUGO;
> +		mode |= 0444;
>   	debugfs_create_file("command", mode, minor->debugfs_root, mipi,
>   			    &mipi_dbi_debugfs_command_fops);
>   
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 5d8688e522d1..90843d7d10a8 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -47,7 +47,7 @@ static void ttm_bo_global_kobj_release(struct kobject *kobj);
>   
>   static struct attribute ttm_bo_count = {
>   	.name = "bo_count",
> -	.mode = S_IRUGO
> +	.mode = 0444
>   };
>   
>   /* default destructor */
> diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
> index 450387c92b63..e17a58dc90f5 100644
> --- a/drivers/gpu/drm/ttm/ttm_memory.c
> +++ b/drivers/gpu/drm/ttm/ttm_memory.c
> @@ -54,23 +54,23 @@ struct ttm_mem_zone {
>   
>   static struct attribute ttm_mem_sys = {
>   	.name = "zone_memory",
> -	.mode = S_IRUGO
> +	.mode = 0444
>   };
>   static struct attribute ttm_mem_emer = {
>   	.name = "emergency_memory",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   static struct attribute ttm_mem_max = {
>   	.name = "available_memory",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   static struct attribute ttm_mem_swap = {
>   	.name = "swap_limit",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   static struct attribute ttm_mem_used = {
>   	.name = "used_memory",
> -	.mode = S_IRUGO
> +	.mode = 0444
>   };
>   
>   static void ttm_mem_zone_kobj_release(struct kobject *kobj)
> @@ -170,7 +170,7 @@ static struct kobj_type ttm_mem_zone_kobj_type = {
>   
>   static struct attribute ttm_mem_global_lower_mem_limit = {
>   	.name = "lower_mem_limit",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   
>   static ssize_t ttm_mem_global_show(struct kobject *kobj,
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> index 06c94e3a5f15..942d051e6833 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> @@ -131,15 +131,15 @@ struct ttm_pool_manager {
>   
>   static struct attribute ttm_page_pool_max = {
>   	.name = "pool_max_size",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   static struct attribute ttm_page_pool_small = {
>   	.name = "pool_small_allocation",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   static struct attribute ttm_page_pool_alloc_size = {
>   	.name = "pool_allocation_size",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   
>   static struct attribute *ttm_pool_attrs[] = {
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> index f63d99c302e4..251343f816e1 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> @@ -178,15 +178,15 @@ static struct ttm_pool_manager *_manager;
>   
>   static struct attribute ttm_page_pool_max = {
>   	.name = "pool_max_size",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   static struct attribute ttm_page_pool_small = {
>   	.name = "pool_small_allocation",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   static struct attribute ttm_page_pool_alloc_size = {
>   	.name = "pool_allocation_size",
> -	.mode = S_IRUGO | S_IWUSR
> +	.mode = 0644
>   };
>   
>   static struct attribute *ttm_pool_attrs[] = {
> diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
> index 2ebdc6d5a76e..463fb16659d8 100644
> --- a/drivers/gpu/drm/udl/udl_fb.c
> +++ b/drivers/gpu/drm/udl/udl_fb.c
> @@ -28,8 +28,8 @@
>   static int fb_defio = 0;  /* Optionally enable experimental fb_defio mmap support */
>   static int fb_bpp = 16;
>   
> -module_param(fb_bpp, int, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
> -module_param(fb_defio, int, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
> +module_param(fb_bpp, int, 0660);
> +module_param(fb_defio, int, 0660);
>   
>   struct udl_fbdev {
>   	struct drm_fb_helper helper;
> diff --git a/drivers/gpu/host1x/debug.c b/drivers/gpu/host1x/debug.c
> index 329e4a3d8ae7..d80e258f972f 100644
> --- a/drivers/gpu/host1x/debug.c
> +++ b/drivers/gpu/host1x/debug.c
> @@ -177,20 +177,20 @@ static void host1x_debugfs_init(struct host1x *host1x)
>   	/* Store the created entry */
>   	host1x->debugfs = de;
>   
> -	debugfs_create_file("status", S_IRUGO, de, host1x, &host1x_debug_fops);
> -	debugfs_create_file("status_all", S_IRUGO, de, host1x,
> +	debugfs_create_file("status", 0444, de, host1x, &host1x_debug_fops);
> +	debugfs_create_file("status_all", 0444, de, host1x,
>   			    &host1x_debug_all_fops);
>   
> -	debugfs_create_u32("trace_cmdbuf", S_IRUGO|S_IWUSR, de,
> +	debugfs_create_u32("trace_cmdbuf", 0644, de,
>   			   &host1x_debug_trace_cmdbuf);
>   
>   	host1x_hw_debug_init(host1x, de);
>   
> -	debugfs_create_u32("force_timeout_pid", S_IRUGO|S_IWUSR, de,
> +	debugfs_create_u32("force_timeout_pid", 0644, de,
>   			   &host1x_debug_force_timeout_pid);
> -	debugfs_create_u32("force_timeout_val", S_IRUGO|S_IWUSR, de,
> +	debugfs_create_u32("force_timeout_val", 0644, de,
>   			   &host1x_debug_force_timeout_val);
> -	debugfs_create_u32("force_timeout_channel", S_IRUGO|S_IWUSR, de,
> +	debugfs_create_u32("force_timeout_channel", 0644, de,
>   			   &host1x_debug_force_timeout_channel);
>   }
>   
