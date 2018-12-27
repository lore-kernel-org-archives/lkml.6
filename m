Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15195C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F1E20866
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeL0WRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:17:19 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:51909 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733136AbeL0WRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:17:18 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id DC62D20058;
        Thu, 27 Dec 2018 23:17:12 +0100 (CET)
Date:   Thu, 27 Dec 2018 23:17:11 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 2/7] drm: move DRM_SWITCH_POWER defines to drm_device.h
Message-ID: <20181227221711.GA29366@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
 <20181226210353.13993-2-sam@ravnborg.org>
 <20181227121234.GE9058@dvetter-linux.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227121234.GE9058@dvetter-linux.ger.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8
        a=-UzwvaD4mrT_bkKbTtgA:9 a=gTs02ahKwakilbJL:21 a=Ox9J3REOmXjxrJcp:21
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

> > +/* Used by drm_device.switch_power_state */
> > +#define DRM_SWITCH_POWER_ON 0
> > +#define DRM_SWITCH_POWER_OFF 1
> > +#define DRM_SWITCH_POWER_CHANGING 2
> > +#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
> 
> Since this isn't uapi it'd be nice to change it to an enum, which we can
> then properly kernel-doc and make your references links in the resulting
> html. Otherwise lgtm.
> 
> Would need an include stanza for drm_device.h in drm-internals.rst, plus a
> bit of kernel-doc cleanup in here I think (which iirc is why I didn't yet
> do this).

Converting to enum was easy, the documentation part not so.
I have tried to add some documentation based on what I could figure out.
There are room for improvements.

The other task was to include drm_device in the documentation.

This work resulted in the following two patches that I will post
as part of an updated series later.
Posted here to maybe get some initial feedback.

	Sam

From 3bc5d6a11a1e04f20a465e2690583c87cee74ac0 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 27 Dec 2018 23:03:12 +0100
Subject: [PATCH 1/7] drm: add drm_device.h to kernel-doc

Updated comment style to kernel-doc format

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/gpu/drm-internals.rst |   4 +
 include/drm/drm_device.h            | 157 ++++++++++++++++++++++--------------
 2 files changed, 101 insertions(+), 60 deletions(-)

diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
index 5ee9674fb9e9..7a677b2b0ebc 100644
--- a/Documentation/gpu/drm-internals.rst
+++ b/Documentation/gpu/drm-internals.rst
@@ -149,6 +149,10 @@ Device Instance and Driver Handling
 .. kernel-doc:: drivers/gpu/drm/drm_drv.c
    :export:
 
+DRM Device
+----------
+.. kernel-doc:: include/drm/drm_device.h
+
 Driver Load
 -----------
 
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 42411b3ea0c8..cd385d3fc979 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -25,24 +25,39 @@ struct pci_dev;
 struct pci_controller;
 
 /**
- * DRM device structure. This structure represent a complete card that
+ * struct drm_device - DRM device structure
+ *
+ * This structure represent a complete card that
  * may contain multiple heads.
  */
 struct drm_device {
-	struct list_head legacy_dev_list;/**< list of devices per driver for stealth attach cleanup */
-	int if_version;			/**< Highest interface version set */
-
-	/** \name Lifetime Management */
-	/*@{ */
-	struct kref ref;		/**< Object ref-count */
-	struct device *dev;		/**< Device structure of bus-device */
-	struct drm_driver *driver;	/**< DRM driver managing the device */
-	void *dev_private;		/**< DRM driver private data */
-	struct drm_minor *primary;		/**< Primary node */
-	struct drm_minor *render;		/**< Render node */
+	/** @legacy_dev_list: List of devices per driver for stealth attach cleanup */
+	struct list_head legacy_dev_list;
+
+	/** @if_version: Highest interface version set */
+	int if_version;
+
+	/** @ref: Object ref-count */
+	struct kref ref;
+
+	/** @dev: Device structure of bus-device */
+	struct device *dev;
+
+	/** @driver: DRM driver managing the device */
+	struct drm_driver *driver;
+
+	/** @dev_private: DRM driver private data */
+	void *dev_private;
+
+	/** @primary: Primary node */
+	struct drm_minor *primary;
+
+	/** @render: Render node */
+	struct drm_minor *render;
+
 	bool registered;
 
-	/* currently active master for this device. Protected by master_mutex */
+	/** @master: Currently active master for this device. Protected by master_mutex */
 	struct drm_master *master;
 
 	/**
@@ -63,23 +78,29 @@ struct drm_device {
 	 */
 	bool unplugged;
 
-	struct inode *anon_inode;		/**< inode for private address-space */
-	char *unique;				/**< unique name of the device */
-	/*@} */
+	/** @anon_inode: inode for private address-space */
+	struct inode *anon_inode;
+
+	/** @unique: Unique name of the device */
+	char *unique;
+
+	/** @struct_mutex: Lock for others (not drm_minor::master and drm_file::is_master) */
+	struct mutex struct_mutex;
+
+	/** @master_mutex: Lock for drm_minor::master and drm_file::is_master */
+	struct mutex master_mutex;
+
+	/** @open_count: Usage counter for outstanding files open, protected by drm_global_mutex. */
+	int open_count;
 
-	/** \name Locks */
-	/*@{ */
-	struct mutex struct_mutex;	/**< For others */
-	struct mutex master_mutex;      /**< For drm_minor::master and drm_file::is_master */
-	/*@} */
+	/** @buf_lock: Lock for drm_device::buf_use and a few other things. */
+	spinlock_t buf_lock;
 
-	/** \name Usage Counters */
-	/*@{ */
-	int open_count;			/**< Outstanding files open, protected by drm_global_mutex. */
-	spinlock_t buf_lock;		/**< For drm_device::buf_use and a few other things. */
-	int buf_use;			/**< Buffers in use -- cannot alloc */
-	atomic_t buf_alloc;		/**< Buffer allocation in progress */
-	/*@} */
+	/** @buf_use: Usage counter for buffers in use -- cannot alloc */
+	int buf_use;
+
+	/** @buf_alloc: Buffer allocation in progress */
+	atomic_t buf_alloc;
 
 	struct mutex filelist_mutex;
 	struct list_head filelist;
@@ -105,33 +126,32 @@ struct drm_device {
 	 */
 	struct list_head clientlist;
 
-	/** \name Memory management */
-	/*@{ */
-	struct list_head maplist;	/**< Linked list of regions */
-	struct drm_open_hash map_hash;	/**< User token hash table for maps */
+	/** @maplist: Memory management - linked list of regions */
+	struct list_head maplist;
 
-	/** \name Context handle management */
-	/*@{ */
-	struct list_head ctxlist;	/**< Linked list of context handles */
-	struct mutex ctxlist_mutex;	/**< For ctxlist */
+	/** @map_hash: Memory management - user token hash table for maps */
+	struct drm_open_hash map_hash;
 
-	struct idr ctx_idr;
+	/** @ctxlist: Context handle management - linked list of context handles */
+	struct list_head ctxlist;
+
+	/** @ctxlist_mutex: Context handle management - mutex for ctxlist */
+	struct mutex ctxlist_mutex;
 
-	struct list_head vmalist;	/**< List of vmas (for debugging) */
+	/** @ctx_idr: Context handle management */
+	struct idr ctx_idr;
 
-	/*@} */
+	/** @vmalist: Context handle management - list of vmas (for debugging) */
+	struct list_head vmalist;
 
-	/** \name DMA support */
-	/*@{ */
-	struct drm_device_dma *dma;		/**< Optional pointer for DMA support */
-	/*@} */
+	/** @dma: Optional pointer for DMA support */
+	struct drm_device_dma *dma;
 
-	/** \name Context support */
-	/*@{ */
+	/** @context_flag: Context swapping flag */
+	__volatile__ long context_flag;
 
-	__volatile__ long context_flag;	/**< Context swapping flag */
-	int last_context;		/**< Last current context */
-	/*@} */
+	/** @last_context: Last current context */
+	int last_context;
 
 	/**
 	 * @irq_enabled:
@@ -168,7 +188,12 @@ struct drm_device {
 	 */
 	struct drm_vblank_crtc *vblank;
 
-	spinlock_t vblank_time_lock;    /**< Protects vblank count and time updates during vblank enable/disable */
+	/**
+	 * @vblank_time_lock:
+	 * 
+	 *  Protects vblank count and time updates during vblank enable/disable
+	 */
+	spinlock_t vblank_time_lock;
 	spinlock_t vbl_lock;
 
 	/**
@@ -186,25 +211,33 @@ struct drm_device {
 	 *
 	 * If non-zeor, &drm_crtc_funcs.get_vblank_counter must be set.
 	 */
-	u32 max_vblank_count;           /**< size of vblank counter register */
+
+	/** @max_vblank_count: Size of vblank counter register */
+	u32 max_vblank_count;
 
 	/**
-	 * List of events
+	 * @vblank_event_list:
+	 *
+	 * List of vblank events
 	 */
 	struct list_head vblank_event_list;
 	spinlock_t event_lock;
 
-	/*@} */
+	/** @agp: AGP data */
+	struct drm_agp_head *agp;
 
-	struct drm_agp_head *agp;	/**< AGP data */
+	/** @pdev: PCI device structure */
+	struct pci_dev *pdev;
 
-	struct pci_dev *pdev;		/**< PCI device structure */
 #ifdef __alpha__
 	struct pci_controller *hose;
 #endif
 
-	struct drm_sg_mem *sg;	/**< Scatter gather memory */
-	unsigned int num_crtcs;                  /**< Number of CRTCs on this device */
+	/** @sg: Scatter gather memory */
+	struct drm_sg_mem *sg;
+
+	/** @num_crtcs: Number of CRTCs on this device */
+	unsigned int num_crtcs;
 
 	struct {
 		int context;
@@ -214,14 +247,18 @@ struct drm_device {
 	struct drm_local_map *agp_buffer_map;
 	unsigned int agp_buffer_token;
 
-	struct drm_mode_config mode_config;	/**< Current mode config */
+	/** @mode_config: Current mode config */
+	struct drm_mode_config mode_config;
 
-	/** \name GEM information */
-	/*@{ */
+	/** @object_name_lock: GEM information */
 	struct mutex object_name_lock;
+
+	/** @object_name_idr: GEM information */
 	struct idr object_name_idr;
+
+	/** @vma_offset_manager: GEM information */
 	struct drm_vma_offset_manager *vma_offset_manager;
-	/*@} */
+
 	int switch_power_state;
 
 	/**
-- 
2.12.0

From a3c94604f8c32a2a48efc79d15fbc66e0e62fd33 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 26 Dec 2018 14:21:01 +0100
Subject: [PATCH 2/7] drm: move DRM_SWITCH_POWER defines to drm_device.h

Move DRM_SWITCH_POWER out of drmP.h to allow users
to get rid of the drmP include.

DRM_SWITCH_POWER defines are used in combination
with drm_device.switch_power_state.

Move the DRM_SWITCH_POWER defines to the file where
drm_device.switch_power_state is defined.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drmP.h       |  5 -----
 include/drm/drm_device.h | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index b6b8436b5123..2ba786820052 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -95,11 +95,6 @@ struct dma_buf_attachment;
 struct pci_dev;
 struct pci_controller;
 
-#define DRM_SWITCH_POWER_ON 0
-#define DRM_SWITCH_POWER_OFF 1
-#define DRM_SWITCH_POWER_CHANGING 2
-#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
-
 /* returns true if currently okay to sleep */
 static inline bool drm_can_sleep(void)
 {
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index cd385d3fc979..098bbc2b169e 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -24,6 +24,33 @@ struct inode;
 struct pci_dev;
 struct pci_controller;
 
+
+/**
+ * enum drm_switch_power - power state of drm device
+ */
+
+enum switch_power_state {
+	/**
+	 * @DRM_SWITCH_POWER_ON: Power state is ON
+	 */
+	DRM_SWITCH_POWER_ON = 0,
+
+	/**
+	 * @DRM_SWITCH_POWER_OFF: Power state is OFF
+	 */
+	DRM_SWITCH_POWER_OFF = 1,
+
+	/**
+	 * @DRM_SWITCH_POWER_CHANGING: Power state is changing
+	 */
+	DRM_SWITCH_POWER_CHANGING = 2,
+
+	/**
+	 * @DRM_SWITCH_POWER_DYNAMIC_OFF: Suspended
+	 */
+	DRM_SWITCH_POWER_DYNAMIC_OFF = 3,
+};
+
 /**
  * struct drm_device - DRM device structure
  *
@@ -259,7 +286,15 @@ struct drm_device {
 	/** @vma_offset_manager: GEM information */
 	struct drm_vma_offset_manager *vma_offset_manager;
 
-	int switch_power_state;
+	/**
+	 * @switch_power_state:
+	 *
+	 * Power state of the client.
+	 * Used by drivers supporting the switcheroo driver.
+	 * The state is maintained in the
+	 * &vga_switcheroo_client_ops.set_gpu_state callback
+	 */
+	enum switch_power_state switch_power_state;
 
 	/**
 	 * @fb_helper:
-- 
2.12.0



