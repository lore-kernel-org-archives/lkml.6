Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AIpwx4/giokH/ebgKts2h7oCBdgoMuRuhypcXkO+GDPO4oYhd66Q5mv/ITksz/pv/wpDao6weaUv
ARC-Seal: i=1; a=rsa-sha256; t=1523636834; cv=none;
        d=google.com; s=arc-20160816;
        b=aHdsOQRsoZI/wrxdk5WPImTXIaKLVLokZyUlHvLAgdos5XnL5L/ZtixEGSzjN6lA5D
         WmgRdOBC3PIOTrHlp2U78QNphDJEZKoDnvVCACpbNFwaLHcJXSptB9cCGSTH8YEO/M9T
         AQetcO/Oru8NBQA42Zu3ZzG0G38kVjBWjsDh+yZPnyaEWrBnkrfUxXzVml0FaBo2ztUb
         1LieMh+e5XOos9Fhu8QmINmSA3FgxQLxAu7sTps3jImwsL7AieCImp0ZWaUuPChSTJQz
         UMfAFrzRpOHQqBPVUaQFYf+mCXMtRaXYf1lGikgLDwLQL1dFgkE3Gk2i1gquKObrthZj
         R5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=D7WAtUwyjcm94FV0y5D+BsYJ/pofA3vnnpFQJ7GpjP4=;
        b=JWq5enIMFd95oKha8SxTlfWDMFQjJ4Gy8/Tj9zVfwjddG6wPeyInEgBhU4C5n29oEl
         EXjPoYNjEKswq/JufiL1E0SvBggjC9TqfBkh5A62mNXdOH2FOtquhPbdgA2FbVoK9JW1
         wJZf3kKqXdiYBbWe4v1ckE7LOHxPqwwPXxW+XTByvHNsH95VybuanEQ7Wm9BgDe95cDZ
         6WWd3jsZ2kh/tHxjIIh+hF5G3oFhwX4zr40zremefbgSbIfInPNhdakGHvlkBGJCX994
         VoDLWtrxFeS68VkAFArwowSeZgxQ73Cq6Li9efNKM32H1RySokqMxidDGd6qhlZfjtJv
         yyvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GpHACT2g;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GpHACT2g;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Fri, 13 Apr 2018 09:27:12 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v1 2/7] platform/mellanox: mlxreg-hotplug: Document fixes
 for hotplug private data
Message-ID: <20180413162712.GD27560@fury>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
 <1522144927-56512-3-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522144927-56512-3-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077329860971189?=
X-GMAIL-MSGID: =?utf-8?q?1597649017795412308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:02:02AM +0000, Vadim Pasternak wrote:
> Add missing description of dev, regmap, dwork_irq, after_probe in struct
> mlxreg_hotplug_priv_data.
> 
> Remove dwork field from the structure mlxreg_hotplug_priv_data itself and
> for the descriptions, since it is not used.
> 

A bit of a nit, but "Document..." implies no functional changes, but you are
changing the physical structure. This can have negative consequences in some
cases, even if the removed field is unused.

Someone reading through the git history might skip over patches starting with
"Document..." when looking for change which impacted behavior.

Again, for future submissions.

> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> ---
>  drivers/platform/mellanox/mlxreg-hotplug.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
> index ea9e7f4..b56953a 100644
> --- a/drivers/platform/mellanox/mlxreg-hotplug.c
> +++ b/drivers/platform/mellanox/mlxreg-hotplug.c
> @@ -59,9 +59,11 @@
>  /**
>   * struct mlxreg_hotplug_priv_data - platform private data:
>   * @irq: platform device interrupt number;
> + * @dev: basic device;
>   * @pdev: platform device;
>   * @plat: platform data;
> - * @dwork: delayed work template;
> + * @regmap: register map handle;
> + * @dwork_irq: delayed work template;
>   * @lock: spin lock;
>   * @hwmon: hwmon device;
>   * @mlxreg_hotplug_attr: sysfs attributes array;
> @@ -71,6 +73,7 @@
>   * @cell: location of top aggregation interrupt register;
>   * @mask: top aggregation interrupt common mask;
>   * @aggr_cache: last value of aggregation register status;
> + * @after_probe: flag indication probing completion;
>   */
>  struct mlxreg_hotplug_priv_data {
>  	int irq;
> @@ -79,7 +82,6 @@ struct mlxreg_hotplug_priv_data {
>  	struct mlxreg_hotplug_platform_data *plat;
>  	struct regmap *regmap;
>  	struct delayed_work dwork_irq;
> -	struct delayed_work dwork;
>  	spinlock_t lock; /* sync with interrupt */
>  	struct device *hwmon;
>  	struct attribute *mlxreg_hotplug_attr[MLXREG_HOTPLUG_ATTRS_MAX + 1];
> -- 
> 2.1.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
