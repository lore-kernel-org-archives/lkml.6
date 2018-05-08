Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZrfRg0ugOPB+hBJ2SLny5yV+P1k52tnNfIZYQcDNQk7M6MhEJyboXRmeEDpt3n8cnPMp9SH
ARC-Seal: i=1; a=rsa-sha256; t=1525811879; cv=none;
        d=google.com; s=arc-20160816;
        b=MG0+XWuWJa3aE5CPt1swWGDtSh6C23DHPUN5A+DS9U2DZokrOwZqFd3Q+MR1c384lA
         gplpOsFNyrmzAlwlSYXWj6ZhSySuPNWwOUJnA84TWOL2g+Adum1HF09WQZG2Z1RGxY3J
         dURo1NSvbTdnc/QCgQI3Hb2D21Xa4RWMyRUCx0fnfLAFfaFuOgGJ9iSEeDaMaIk83qFe
         PblhzHQIq5qdZwUmjDiM4Fjcm9gtJvMonAxgjn0MtaWuz6hNH4YoBpR9NjSJGkok6iHD
         0c6QJB4/nKLlHJIZVOZctx4FeR1LElCG7XHqqjXCgyFVmdNkd5cGiMdmrmTFnD+uWUe0
         v4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=55kHDjU4SEwgwO0e6Z7EET+wFC2wf5CSViINpbWw0SI=;
        b=Cqc7+/+6SPvx9gMtFj87IWgPab2owmPrwn4Ov4dUJiyKlfEQmAIDiZwbWcw0ijIVHN
         jGBUDnLWrqcDENe2otjtE7e/HUVDRCGEobla/Qgyu/xyg3Q0lwkOR9S2438SH5VUpIMu
         XlvSvbGqbXH9Mr2njTRsbv7cyhY4hJDdA9PUck9WNtFhwCH/o6Ya6O+ovCRnS2rJHUOZ
         IQbJ7juGCQkyG3fuRBkIP+dR4+iIyTqaTeGZb1jmU92sSPebebX8rrksga7ggBjMw5y0
         tMpRlDz/D51vIK4Ugemw7YgWFXgicA4UlOzIMh40krsmFgcyaVEiHsM8rW7OQomChO/C
         NrMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Tue, 8 May 2018 15:37:56 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kirill Tkhai <ktkhai@virtuozzo.com>, Mike Rapoport
 <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin
 <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>, Robin Murphy
 <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>, Thierry
 Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] coresight: allow to build as modules
Message-Id: <20180508153756.09f6fa8066bc23a0d11ec670@arm.com>
In-Reply-To: <f299d0be-f1a6-46ca-3d8a-13d7d89a007d@infradead.org>
References: <20180508140650.c070e6aa0eb1a6690e6d9607@arm.com>
	<f299d0be-f1a6-46ca-3d8a-13d7d89a007d@infradead.org>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923984942793999?=
X-GMAIL-MSGID: =?utf-8?q?1599929717120768979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 8 May 2018 12:31:08 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,

Hi,

> On 05/08/2018 12:06 PM, Kim Phillips wrote:
> 
> >  if CORESIGHT
> >  config CORESIGHT_LINKS_AND_SINKS
> > -	bool "CoreSight Link and Sink drivers"
> > +	tristate "CoreSight Link and Sink drivers"
> > +	depends on CORESIGHT
> 
> The "if CORESIGHT" line serves as a "depends on CORESIGHT" for the entire "if"
> block, so please don't repeat the "depends on" here.

Thanks, removed.

> >  config CORESIGHT_CPU_DEBUG
> >  	tristate "CoreSight CPU Debug driver"
> > -	depends on ARM || ARM64
> > -	depends on DEBUG_FS
> > +	depends on CORESIGHT && DEBUG_FS
> 
> "depends on CORESIGHT" is not needed if this is still inside the
> if CORESIGHT/endif block.  (I think it is but I can't tell from just looking
> at the patch itself.)

Thanks, it is, removed.

> 
> >  	help
> >  	  This driver provides support for coresight debugging module. This
> >  	  is primarily used to dump sample-based profiling registers when
> > @@ -103,4 +127,7 @@ config CORESIGHT_CPU_DEBUG
> >  	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
> >  	  for detailed description and the example for usage.
> >  
> > +	  To compile this code as a module, choose M here: the
> > +	  module will be called coresight-cpu-debug.
> > +
> >  endif
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> > index 3ffc9feb2d64..8c49c7b82d84 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> > @@ -54,7 +54,7 @@ struct etm_filters {
> >  };
> >  
> >  
> > -#ifdef CONFIG_CORESIGHT
> > +#if IS_ENABLED(CONFIG_CORESIGHT)
> 
> Have you found (observed) that this change (above) is necessary (and others
> like it below)?  I thought that they would be equivalent.
> 
> From include/linux/kconfig.h:
> /*
>  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
>  * 0 otherwise.
>  */
> #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
> 
> 
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > index f1d0e21d8cab..335bca44b42d 100644
> > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> 
> > @@ -143,7 +149,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
> >  				       struct coresight_device *sink);
> >  void coresight_release_path(struct list_head *path);
> >  
> > -#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
> > +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
> 
> ditto.
> 
> >  extern int etm_readl_cp14(u32 off, unsigned int *val);
> >  extern int etm_writel_cp14(u32 off, u32 val);
> >  #else
> 
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index d950dad5056a..5863eb1a7335 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -243,7 +243,7 @@ struct coresight_ops {
> >  	const struct coresight_ops_source *source_ops;
> >  };
> >  
> > -#ifdef CONFIG_CORESIGHT
> > +#if IS_ENABLED(CONFIG_CORESIGHT)
> 
> ditto.

If I revert all three IS_ENABLED back to plain #ifdefs, and rebuild with
CONFIG_CORESIGHT*=m, I get:

  CC [M]  drivers/hwtracing/coresight/coresight.o
  CC [M]  drivers/hwtracing/coresight/of_coresight.o
../drivers/hwtracing/coresight/coresight.c:586:5: error: redefinition of ‘coresight_enable’
 int coresight_enable(struct coresight_device *csdev)
     ^~~~~~~~~~~~~~~~
In file included from ../drivers/hwtracing/coresight/coresight.c:23:0:
../include/linux/coresight.h:259:1: note: previous definition of ‘coresight_enable’ was here
 coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
 ^~~~~~~~~~~~~~~~
../drivers/hwtracing/coresight/coresight.c:670:6: error: redefinition of ‘coresight_disable’
 void coresight_disable(struct coresight_device *csdev)
      ^~~~~~~~~~~~~~~~~
In file included from ../drivers/hwtracing/coresight/coresight.c:23:0:
../include/linux/coresight.h:260:20: note: previous definition of ‘coresight_disable’ was here
 static inline void coresight_disable(struct coresight_device *csdev) {}
                    ^~~~~~~~~~~~~~~~~
../drivers/hwtracing/coresight/coresight.c:945:5: error: redefinition of ‘coresight_timeout’
 int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
     ^~~~~~~~~~~~~~~~~
In file included from ../drivers/hwtracing/coresight/coresight.c:23:0:
../include/linux/coresight.h:261:19: note: previous definition of ‘coresight_timeout’ was here
 static inline int coresight_timeout(void __iomem *addr, u32 offset,
                   ^~~~~~~~~~~~~~~~~
../drivers/hwtracing/coresight/coresight.c:991:26: error: redefinition of ‘coresight_register’
 struct coresight_device *coresight_register(struct coresight_desc *desc)
                          ^~~~~~~~~~~~~~~~~~
In file included from ../drivers/hwtracing/coresight/coresight.c:23:0:
../include/linux/coresight.h:256:1: note: previous definition of ‘coresight_register’ was here
 coresight_register(struct coresight_desc *desc) { return NULL; }
 ^~~~~~~~~~~~~~~~~~
../drivers/hwtracing/coresight/coresight.c:1081:6: error: redefinition of ‘coresight_unregister’
 void coresight_unregister(struct coresight_device *csdev)
      ^~~~~~~~~~~~~~~~~~~~
In file included from ../drivers/hwtracing/coresight/coresight.c:23:0:
../include/linux/coresight.h:257:20: note: previous definition of ‘coresight_unregister’ was here
 static inline void coresight_unregister(struct coresight_device *csdev) {}
                    ^~~~~~~~~~~~~~~~~~~~
../scripts/Makefile.build:312: recipe for target 'drivers/hwtracing/coresight/coresight.o' failed
make[3]: *** [drivers/hwtracing/coresight/coresight.o] Error 1

Building CORESIGHT=y builds ok, so, building it as a module causes the
latter stubs to be compiled:

#ifdef CONFIG_CORESIGHT
extern struct coresight_device *
coresight_register(struct coresight_desc *desc);
extern void coresight_unregister(struct coresight_device *csdev);
extern int coresight_enable(struct coresight_device *csdev);
extern void coresight_disable(struct coresight_device *csdev);
extern int coresight_timeout(void __iomem *addr, u32 offset,
                             int position, int value);
#else
static inline struct coresight_device *
coresight_register(struct coresight_desc *desc) { return NULL; }
static inline void coresight_unregister(struct coresight_device *csdev) {}
static inline int
coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
static inline void coresight_disable(struct coresight_device *csdev) {}
static inline int coresight_timeout(void __iomem *addr, u32 offset,
                                     int position, int value) { return 1; }
#endif

Adding kconfig.h to coresight.h's #include list doesn't help.  So we
need the IS_ENABLED for its __or(..., IS_MODULE()) case.

That being said, I don't know of any outside kernel-build dependencies
coresight.h might have.

Kim
