Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE4CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DF020835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DF020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIADlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:41:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32981 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeIADlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:41:00 -0400
Received: by mail-qt0-f194.google.com with SMTP id r37-v6so16416138qtc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=zB7iD8p188SZNm/FFxlGdixvR9R3jsYIHO5pDhIS/VI=;
        b=Nryt1Foeek87KY7xH1y9RagkKbmS/8MvU7AMW9VczmX5GdsnPrUUmFwuH7TD5W2oou
         PswUppsMcFVlQwqaR03bs4RZjmNt0BL7iO+iAtbQD+8gTz7uYBN+qPDU10bi87etuq/M
         g8qFM3o3VYIcUaqpRMxhJYn/ioh9/iXjDBrCc1L1EwebcW6kvOoy8VskPXtDvp55AuVf
         YCeVzdsY4HHVEb2ttixXY8wqVxkptwpnApTvl4nACqU3iXztV+rWHQmyBDy395izzsEi
         Y0YF0HUC95y6aUo+s1LGhSH0wrMf4VRWcYSvfYYHVVf125FColTDGaCyXBLfFfgFaqtr
         YIuw==
X-Gm-Message-State: APzg51Dd8y0OX0PtaFFgD7nMZXgX2i2eTRQgKe1QqQ/mkMddUEOukLPf
        f+JwhUWZLZgxxmwvoYeqhO0YYA==
X-Google-Smtp-Source: ANB0VdZelwzQ4fBagWmuE5SFByPNMxRii/hl1Aq2MaN4Hvv7ilNJpZkLPosp62jANjKqtavG+eH4zQ==
X-Received: by 2002:aed:20f1:: with SMTP id 104-v6mr18633213qtb.81.1535758272989;
        Fri, 31 Aug 2018 16:31:12 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id l23-v6sm7233782qta.30.2018.08.31.16.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 16:31:12 -0700 (PDT)
Message-ID: <01d972a4942f28e38b4e8e3b3d05d0be3ff3449a.camel@redhat.com>
Subject: Re: [PATCH 1/4] drm/debugfs: Add support for dynamic debugfs
 initialization
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>
Date:   Fri, 31 Aug 2018 19:31:10 -0400
In-Reply-To: <20180831085317.GQ21634@phenom.ffwll.local>
References: <20180828003635.8200-1-lyude@redhat.com>
         <20180828003635.8200-2-lyude@redhat.com>
         <20180831085317.GQ21634@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 10:53 +0200, Daniel Vetter wrote:
> On Mon, Aug 27, 2018 at 08:36:24PM -0400, Lyude Paul wrote:
> > Currently all debugfs related initialization for the DRM core happens in
> > drm_debugfs_init(), which is called when registering the minor device.
> > While this works fine for features such as atomic modesetting and GEM,
> > this doesn't work at all for resources like DP MST topology managers
> > which can potentially be created both before and after the minor
> > device has been registered.
> > 
> > So, in order to add driver-wide debugfs files for MST we'll need to be
> > able to handle debugfs initialization for such resources. We do so by
> > introducing drm_debugfs_callback_register() and
> > drm_debugfs_callback_unregister(). These functions allow driver-agnostic
> > parts of DRM to add additional debugfs initialization callbacks at any
> > point during a DRM driver's lifetime.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Daniel Stone <daniel@fooishbar.org>
> 
> So the debugfs lifetime rules are indeed silly and broken. I'm not sure
> this is what we want to do though:
> 
> - Thanks to Noralf's cleanup you don't need a debugfs cleanup callback
>   anymore really, it will auto-clean-up on device unregistration.
This is true, but the cleanup there is more-so to handle the theoretical case
that a driver uninitializes an MST topology mgr before the rest of debugfs is
torn down.
> 
> - For stuff tied to connectors we have the connector->register/unregister
>   callbacks. Imo connector-related debugfs stuff, like for mst, should be
>   put there.

Since this would tie the lifetime of the debugfs files we make to the lifetime
of the connector, as it should be, we'd be able to pull off a much nicer
debugfs hierarchy:

/sys/kernel/debug/dri/0
   DP-1
      edid_override
      dp_mst
         status
   DP-2
      edid_override
      dp_mst
         status
   DP-3
      edid_override
      dp_mst
         status

The only thing I don't like about that approach though is that now we've given
up on the idea of these debugfs nodes being added to drivers using MST
automatically, since drivers wanting this would have to add calls into
late_register/early_unregister.

Since I think this would probably be useful for more then just connectors,
what if we added some sort of similar dynamic initialization system that could
be used per-DRM object? That way drivers would still get the debugfs files for
free, and we'd get a nice hierarchy and a sane way for DRM helpers to add
additional debugfs files to drivers for free. Assumably, such a system would
be added in addition to a device-wide dynamic init system like the one this
patch adds.
> 
> - debugfs_init is a dead idea, as you point out it's fundamentally racy.
> 
> - Dropping the silly notion that we have to duplicate all debugfs entries
>   per-minor would be really sweet (last time I checked there's not a
>   single debugfs file that's actually different per minor).

Yeah I'm down for this as well, I've never once seen anything actually use the
minor debugfs files. Plus, we're supposed to be able to do whatever we want in
debugfs anyway! So I don't see the harm in just gutting the duplicate minor
debugfs stuff entirely
> 
> Cheers, Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_debugfs.c  | 173 +++++++++++++++++++++++++++++++--
> >  drivers/gpu/drm/drm_drv.c      |   3 +
> >  drivers/gpu/drm/drm_internal.h |   5 +
> >  include/drm/drm_debugfs.h      |  27 +++++
> >  include/drm/drm_file.h         |   4 +
> >  5 files changed, 203 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> > index 6f28fe58f169..a53a454b167f 100644
> > --- a/drivers/gpu/drm/drm_debugfs.c
> > +++ b/drivers/gpu/drm/drm_debugfs.c
> > @@ -39,6 +39,13 @@
> >  
> >  #if defined(CONFIG_DEBUG_FS)
> >  
> > +struct drm_debugfs_callback {
> > +	void (*init)(void *data);
> > +	void (*cleanup_cb)(void *data);
> > +	void *data;
> > +	struct list_head list;
> > +};
> > +
> >  /***************************************************
> >   * Initialization, etc.
> >   **************************************************/
> > @@ -67,6 +74,113 @@ static const struct file_operations drm_debugfs_fops =
> > {
> >  	.release = single_release,
> >  };
> >  
> > +/**
> > + * drm_debugfs_register_callback - Register a callback for initializing
> > + *                                 dynamic driver-agnostic debugfs files
> > + * @minor: device minor number
> > + * @init: The callback to invoke to perform the debugfs initialization
> > + * @cleanup_cb: The callback to invoke to cleanup any resources for the
> > + * callback
> > + * @data: Data to pass to @init and @cleanup_cb
> > + * @out: Where to store the pointer to the callback struct
> > + *
> > + * Register an initialization callback with debugfs. This callback can be
> > used
> > + * to creating debugfs nodes for DRM resources that might get created
> > before
> > + * the debugfs node for @minor has been created.
> > + *
> > + * When a callback is registered with this function before the debugfs
> > root
> > + * has been created, the callback's execution will be delayed until all
> > other
> > + * debugfs nodes (including those owned by the DRM device's driver) have
> > been
> > + * instantiated. If a callback is registered with this function after the
> > + * debugfs root has been created, @init and @cleanup_cb will be executed
> > + * immediately without creating a &struct drm_debugfs_callback.
> > + *
> > + * In the event that debugfs creation for the device fails; all
> > registered
> > + * debugfs callbacks will have their @cleanup_cb callbacks invoked
> > without
> > + * having their @init callbacks invoked. This is to ensure that no
> > resources
> > + * are leaked during initialization of debugfs, even if the
> > initialization
> > + * process fails. Likewise; any callbacks that are registered after DRM
> > has
> > + * failed to initialize it's debugfs files will have their @cleanup_cb
> > + * callbacks invoked immediately and all of their respective resources
> > + * destroyed.
> > + *
> > + * Implementations of @cleanup_cb should clean up all resources for the
> > + * callback, with the exception of freeing the memory for @out. Freeing
> > @out
> > + * will be handled by the DRM core automatically.
> > + *
> > + * Users of this function should take care to add a symmetric call to
> > + * @drm_debugfs_unregister_callback to handle destroying a registered
> > callback
> > + * in case the resources for the user of this function are destroyed
> > before
> > + * debugfs root is initialized.
> > + *
> > + */
> > +int
> > +drm_debugfs_register_callback(struct drm_minor *minor,
> > +			      void (*init)(void *),
> > +			      void (*cleanup_cb)(void *),
> > +			      void *data, struct drm_debugfs_callback **out)
> > +{
> > +	int ret = 0;
> > +
> > +	mutex_lock(&minor->debugfs_callback_lock);
> > +	if (minor->debugfs_callbacks_done) {
> > +		/* debugfs is already setup, so just handle the callback
> > +		 * immediately
> > +		 */
> > +		if (minor->debugfs_root)
> > +			(*init)(data);
> > +		(*cleanup_cb)(data);
> > +		goto out_unlock;
> > +	}
> > +
> > +	*out = kzalloc(sizeof(**out), GFP_KERNEL);
> > +	if (!*out) {
> > +		ret = -ENOMEM;
> > +		goto out_unlock;
> > +	}
> > +
> > +	(*out)->init = init;
> > +	(*out)->cleanup_cb = cleanup_cb;
> > +	(*out)->data = data;
> > +	list_add(&(*out)->list, &minor->debugfs_callback_list);
> > +
> > +out_unlock:
> > +	mutex_unlock(&minor->debugfs_callback_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(drm_debugfs_register_callback);
> > +
> > +/**
> > + * drm_debugfs_unregister_callback - Unregister and release the resources
> > + *                                   associated with a debugfs init
> > callback
> > + * @minor: device minor number
> > + * @cb: A pointer to the &struct drm_debugfs_callback struct returned by
> > + * drm_debugfs_register_callback(). May be NULL
> > + *
> > + * Unregisters a &struct drm_debugfs_callback struct with debugfs and
> > destroys
> > + * all of it's associated resources. This includes a call to the
> > callback's
> > + * @cleanup_cb implementation.
> > + *
> > + * Once the debugfs root is initialized or has failed initialization, all
> > + * registered callbacks are automatically destroyed. If this function is
> > + * called after that point; it will automatically be a no-op.
> > + */
> > +void
> > +drm_debugfs_unregister_callback(struct drm_minor *minor,
> > +				struct drm_debugfs_callback *cb)
> > +{
> > +	mutex_lock(&minor->debugfs_callback_lock);
> > +	/* We don't have to do anything if we've already completed any
> > +	 * registered callbacks, as they will have already been destroyed
> > +	 */
> > +	if (!minor->debugfs_callbacks_done) {
> > +		cb->cleanup_cb(cb->data);
> > +		list_del(&cb->list);
> > +		kfree(cb);
> > +	}
> > +	mutex_unlock(&minor->debugfs_callback_lock);
> > +}
> > +EXPORT_SYMBOL(drm_debugfs_unregister_callback);
> >  
> >  /**
> >   * drm_debugfs_create_files - Initialize a given set of debugfs files for
> > DRM
> > @@ -126,12 +240,24 @@ int drm_debugfs_create_files(const struct
> > drm_info_list *files, int count,
> >  }
> >  EXPORT_SYMBOL(drm_debugfs_create_files);
> >  
> > +int drm_debugfs_alloc(struct drm_minor *minor)
> > +{
> > +	INIT_LIST_HEAD(&minor->debugfs_callback_list);
> > +	mutex_init(&minor->debugfs_callback_lock);
> > +	return 0;
> > +}
> > +
> >  int drm_debugfs_init(struct drm_minor *minor, int minor_id,
> >  		     struct dentry *root)
> >  {
> >  	struct drm_device *dev = minor->dev;
> > +	struct drm_debugfs_callback *pos, *tmp;
> >  	char name[64];
> > -	int ret;
> > +	int ret = 0;
> > +
> > +	/* Don't allow any more callbacks to be registered while we setup */
> > +	mutex_lock(&minor->debugfs_callback_lock);
> > +	minor->debugfs_callbacks_done = true;
> >  
> >  	INIT_LIST_HEAD(&minor->debugfs_list);
> >  	mutex_init(&minor->debugfs_lock);
> > @@ -139,7 +265,8 @@ int drm_debugfs_init(struct drm_minor *minor, int
> > minor_id,
> >  	minor->debugfs_root = debugfs_create_dir(name, root);
> >  	if (!minor->debugfs_root) {
> >  		DRM_ERROR("Cannot create /sys/kernel/debug/dri/%s\n", name);
> > -		return -1;
> > +		ret = -1;
> > +		goto out_unlock;
> >  	}
> >  
> >  	ret = drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
> > @@ -148,14 +275,14 @@ int drm_debugfs_init(struct drm_minor *minor, int
> > minor_id,
> >  		debugfs_remove(minor->debugfs_root);
> >  		minor->debugfs_root = NULL;
> >  		DRM_ERROR("Failed to create core drm debugfs files\n");
> > -		return ret;
> > +		goto out_unlock;
> >  	}
> >  
> >  	if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
> >  		ret = drm_atomic_debugfs_init(minor);
> >  		if (ret) {
> >  			DRM_ERROR("Failed to create atomic debugfs files\n");
> > -			return ret;
> > +			goto out_unlock;
> >  		}
> >  	}
> >  
> > @@ -163,13 +290,13 @@ int drm_debugfs_init(struct drm_minor *minor, int
> > minor_id,
> >  		ret = drm_framebuffer_debugfs_init(minor);
> >  		if (ret) {
> >  			DRM_ERROR("Failed to create framebuffer debugfs
> > file\n");
> > -			return ret;
> > +			goto out_unlock;
> >  		}
> >  
> >  		ret = drm_client_debugfs_init(minor);
> >  		if (ret) {
> >  			DRM_ERROR("Failed to create client debugfs file\n");
> > -			return ret;
> > +			goto out_unlock;
> >  		}
> >  	}
> >  
> > @@ -178,10 +305,23 @@ int drm_debugfs_init(struct drm_minor *minor, int
> > minor_id,
> >  		if (ret) {
> >  			DRM_ERROR("DRM: Driver failed to initialize "
> >  				  "/sys/kernel/debug/dri.\n");
> > -			return ret;
> > +			goto out_unlock;
> >  		}
> >  	}
> > -	return 0;
> > +
> > +out_unlock:
> > +	/* Execute any delayed callbacks if we succeeded, or just clean them
> > +	 * up without running them if we failed
> > +	 */
> > +	list_for_each_entry_safe(pos, tmp, &minor->debugfs_callback_list,
> > +				 list) {
> > +		if (!ret)
> > +			pos->init(pos->data);
> > +		pos->cleanup_cb(pos->data);
> > +		kfree(pos);
> > +	}
> > +	mutex_unlock(&minor->debugfs_callback_lock);
> > +	return ret;
> >  }
> >  
> >  
> > @@ -223,14 +363,29 @@ static void drm_debugfs_remove_all_files(struct
> > drm_minor *minor)
> >  
> >  int drm_debugfs_cleanup(struct drm_minor *minor)
> >  {
> > +	struct drm_debugfs_callback *pos, *tmp;
> > +
> > +	mutex_lock(&minor->debugfs_callback_lock);
> > +	if (!minor->debugfs_callbacks_done) {
> > +		list_for_each_entry_safe(pos, tmp,
> > +					 &minor->debugfs_callback_list,
> > +					 list) {
> > +			pos->cleanup_cb(pos->data);
> > +			kfree(pos);
> > +		}
> > +	}
> > +	minor->debugfs_callbacks_done = true;
> > +
> >  	if (!minor->debugfs_root)
> > -		return 0;
> > +		goto out;
> >  
> >  	drm_debugfs_remove_all_files(minor);
> >  
> >  	debugfs_remove_recursive(minor->debugfs_root);
> >  	minor->debugfs_root = NULL;
> >  
> > +out:
> > +	mutex_unlock(&minor->debugfs_callback_lock);
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index ea4941da9b27..7041b3137229 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -118,6 +118,9 @@ static int drm_minor_alloc(struct drm_device *dev,
> > unsigned int type)
> >  
> >  	minor->type = type;
> >  	minor->dev = dev;
> > +	r = drm_debugfs_alloc(minor);
> > +	if (r)
> > +		goto err_free;
> >  
> >  	idr_preload(GFP_KERNEL);
> >  	spin_lock_irqsave(&drm_minor_lock, flags);
> > diff --git a/drivers/gpu/drm/drm_internal.h
> > b/drivers/gpu/drm/drm_internal.h
> > index 40179c5fc6b8..d6394246967d 100644
> > --- a/drivers/gpu/drm/drm_internal.h
> > +++ b/drivers/gpu/drm/drm_internal.h
> > @@ -118,6 +118,7 @@ void drm_gem_print_info(struct drm_printer *p,
> > unsigned int indent,
> >  
> >  /* drm_debugfs.c drm_debugfs_crc.c */
> >  #if defined(CONFIG_DEBUG_FS)
> > +int drm_debugfs_alloc(struct drm_minor *minor);
> >  int drm_debugfs_init(struct drm_minor *minor, int minor_id,
> >  		     struct dentry *root);
> >  int drm_debugfs_cleanup(struct drm_minor *minor);
> > @@ -127,6 +128,10 @@ int drm_debugfs_crtc_add(struct drm_crtc *crtc);
> >  void drm_debugfs_crtc_remove(struct drm_crtc *crtc);
> >  int drm_debugfs_crtc_crc_add(struct drm_crtc *crtc);
> >  #else
> > +static inline int drm_debugfs_alloc(struct drm_minor *minor)
> > +{
> > +	return 0;
> > +}
> >  static inline int drm_debugfs_init(struct drm_minor *minor, int minor_id,
> >  				   struct dentry *root)
> >  {
> > diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
> > index ac0f75df1ac9..6ac45d96fcd1 100644
> > --- a/include/drm/drm_debugfs.h
> > +++ b/include/drm/drm_debugfs.h
> > @@ -77,12 +77,23 @@ struct drm_info_node {
> >  	struct dentry *dent;
> >  };
> >  
> > +struct drm_debugfs_callback;
> > +
> >  #if defined(CONFIG_DEBUG_FS)
> >  int drm_debugfs_create_files(const struct drm_info_list *files,
> >  			     int count, struct dentry *root,
> >  			     struct drm_minor *minor);
> >  int drm_debugfs_remove_files(const struct drm_info_list *files,
> >  			     int count, struct drm_minor *minor);
> > +
> > +int drm_debugfs_register_callback(struct drm_minor *minor,
> > +				  void (*init)(void *),
> > +				  void (*cleanup_cb)(void *),
> > +				  void *data,
> > +				  struct drm_debugfs_callback **out);
> > +void drm_debugfs_unregister_callback(struct drm_minor *minor,
> > +				     struct drm_debugfs_callback *cb);
> > +
> >  #else
> >  static inline int drm_debugfs_create_files(const struct drm_info_list
> > *files,
> >  					   int count, struct dentry *root,
> > @@ -96,6 +107,22 @@ static inline int drm_debugfs_remove_files(const
> > struct drm_info_list *files,
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline int
> > +drm_debugfs_register_callback(struct drm_minor *minor,
> > +			      void (*init)(void *),
> > +			      void (*cleanup_cb)(void *),
> > +			      void *data,
> > +			      struct drm_debugfs_callback **out)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void
> > +drm_debugfs_unregister_callback(struct drm_minor *minor,
> > +				struct drm_debugfs_callback *cb)
> > +{
> > +}
> >  #endif
> >  
> >  #endif /* _DRM_DEBUGFS_H_ */
> > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > index 26485acc51d7..180052b51712 100644
> > --- a/include/drm/drm_file.h
> > +++ b/include/drm/drm_file.h
> > @@ -74,6 +74,10 @@ struct drm_minor {
> >  
> >  	struct dentry *debugfs_root;
> >  
> > +	bool debugfs_callbacks_done;
> > +	struct list_head debugfs_callback_list;
> > +	struct mutex debugfs_callback_lock;
> > +
> >  	struct list_head debugfs_list;
> >  	struct mutex debugfs_lock; /* Protects debugfs_list. */
> >  };
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
-- 
Cheers,
	Lyude Paul

