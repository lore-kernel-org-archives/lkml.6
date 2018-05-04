Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEDL26 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:28:58 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34296 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeEDL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:28:56 -0400
X-Google-Smtp-Source: AB8JxZradVhDAPbSTqXzd6OkTseETv8ISoVxhpQHSB8BGGnDm2YLStHj+3wk2W7ChqRIN1CAFo5utg==
Subject: Re: [PATCH v1 1/5] drm/tegra: dc: Balance IOMMU group refcounting
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180503234723.4368-1-digetx@gmail.com>
 <20180503234723.4368-2-digetx@gmail.com> <20180504104515.GM13459@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <940fd992-b40c-a6f7-d527-7e0e356eeb44@gmail.com>
Date: Fri, 4 May 2018 14:28:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504104515.GM13459@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 13:45, Thierry Reding wrote:
> On Fri, May 04, 2018 at 02:47:19AM +0300, Dmitry Osipenko wrote:
>> Remove unneeded iommu_group_get() and add missing iommu_group_put(),
>> correcting IOMMU group refcount. This is a minor correction / cleanup that
>> doesn't really fix anything because Tegra's IOMMU driver are built-in and
>> hence groups refcounting can't hold IOMMU driver from unloading.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/dc.c  | 35 +++++++++++++++++------------------
>>  drivers/gpu/drm/tegra/dc.h  |  2 +-
>>  drivers/gpu/drm/tegra/drm.h |  2 +-
>>  3 files changed, 19 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
>> index d7a0f62c6e2e..9fc34c6a7218 100644
>> --- a/drivers/gpu/drm/tegra/dc.c
>> +++ b/drivers/gpu/drm/tegra/dc.c
>> @@ -1927,7 +1927,6 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
>>  static int tegra_dc_init(struct host1x_client *client)
>>  {
>>  	struct drm_device *drm = dev_get_drvdata(client->parent);
>> -	struct iommu_group *group = iommu_group_get(client->dev);
>>  	unsigned long flags = HOST1X_SYNCPT_CLIENT_MANAGED;
>>  	struct tegra_dc *dc = host1x_client_to_dc(client);
>>  	struct tegra_drm *tegra = drm->dev_private;
>> @@ -1939,20 +1938,21 @@ static int tegra_dc_init(struct host1x_client *client)
>>  	if (!dc->syncpt)
>>  		dev_warn(dc->dev, "failed to allocate syncpoint\n");
>>  
>> -	if (group && tegra->domain) {
>> -		if (group != tegra->group) {
>> -			err = iommu_attach_group(tegra->domain, group);
>> +	if (tegra->domain) {
>> +		dc->group = iommu_group_get(client->dev);
>> +
>> +		if (dc->group && dc->group != tegra->dc_group) {
>> +			err = iommu_attach_group(tegra->domain, dc->group);
>>  			if (err < 0) {
>>  				dev_err(dc->dev,
>>  					"failed to attach to domain: %d\n",
>>  					err);
>> +				iommu_group_put(dc->group);
>>  				return err;
>>  			}
>>  
>> -			tegra->group = group;
>> +			tegra->dc_group = dc->group;
>>  		}
>> -
>> -		dc->domain = tegra->domain;
>>  	}
>>  
>>  	if (dc->soc->wgrps)
>> @@ -2017,13 +2017,13 @@ static int tegra_dc_init(struct host1x_client *client)
>>  	if (!IS_ERR(primary))
>>  		drm_plane_cleanup(primary);
>>  
>> -	if (group && dc->domain) {
>> -		if (group == tegra->group) {
>> -			iommu_detach_group(dc->domain, group);
>> -			tegra->group = NULL;
>> +	if (dc->group) {
>> +		if (dc->group && dc->group == tegra->dc_group) {
> 
> You can drop the dc->group check from the second conditional.

Indeed.

>> +			iommu_detach_group(tegra->domain, dc->group);
>> +			tegra->dc_group = NULL;
>>  		}
>>  
>> -		dc->domain = NULL;
>> +		iommu_group_put(dc->group);
>>  	}
>>  
>>  	return err;
>> @@ -2032,7 +2032,6 @@ static int tegra_dc_init(struct host1x_client *client)
>>  static int tegra_dc_exit(struct host1x_client *client)
>>  {
>>  	struct drm_device *drm = dev_get_drvdata(client->parent);
>> -	struct iommu_group *group = iommu_group_get(client->dev);
>>  	struct tegra_dc *dc = host1x_client_to_dc(client);
>>  	struct tegra_drm *tegra = drm->dev_private;
>>  	int err;
>> @@ -2045,13 +2044,13 @@ static int tegra_dc_exit(struct host1x_client *client)
>>  		return err;
>>  	}
>>  
>> -	if (group && dc->domain) {
>> -		if (group == tegra->group) {
>> -			iommu_detach_group(dc->domain, group);
>> -			tegra->group = NULL;
>> +	if (dc->group) {
>> +		if (dc->group && dc->group == tegra->dc_group) {
>> +			iommu_detach_group(tegra->domain, dc->group);
>> +			tegra->dc_group = NULL;
>>  		}
>>  
>> -		dc->domain = NULL;
>> +		iommu_group_put(dc->group);
>>  	}
>>  
>>  	host1x_syncpt_free(dc->syncpt);
>> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
>> index ca5cac6bf8ea..5ca4e07333bb 100644
>> --- a/drivers/gpu/drm/tegra/dc.h
>> +++ b/drivers/gpu/drm/tegra/dc.h
>> @@ -94,7 +94,7 @@ struct tegra_dc {
>>  
>>  	const struct tegra_dc_soc_info *soc;
>>  
>> -	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>>  };
>>  
>>  static inline struct tegra_dc *
>> diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
>> index 4f41aaec8530..7777640a6911 100644
>> --- a/drivers/gpu/drm/tegra/drm.h
>> +++ b/drivers/gpu/drm/tegra/drm.h
>> @@ -46,7 +46,7 @@ struct tegra_drm {
>>  	struct drm_device *drm;
>>  
>>  	struct iommu_domain *domain;
>> -	struct iommu_group *group;
>> +	struct iommu_group *dc_group;
> 
> It's not obvious to me why this needs to be renamed.

tegra->group is only used by the dc.c and seems its sole purpose is to avoid
re-attaching DC group if DC0 and DC1 share the same group, like DC's on newer
Tegra's do. I think it's better to rename 'group' to 'dc_group' for the clarity.
