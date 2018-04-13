Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AIpwx48t5ViDA9Xl6hAVzLPz5HGax+SeY2HZLvAPw/SMZVczXxO6I1jfMCbBjTe66uZkHioRw5aV
ARC-Seal: i=1; a=rsa-sha256; t=1523636284; cv=none;
        d=google.com; s=arc-20160816;
        b=iWoU2gRYeGyafL9SmmP9/7mRAW7EsaIgT6ZNCj3cThYg0t8U9vvq51R0i9ZeWqTJgD
         G7AzEkN0UzHmuTmmYDvH6mkHffs/SYePVFsfHJFLpZuTy1BK82+mEbMQ1tdC1Y4/CWtU
         Ki1z5S9EqPzQGZi1B+0vE8lVjnWgzCUhVyL5vVMoX/8P3Tj5YtuLpPNdbGHGgjFAE7eS
         PkJkHOVgjYfQdOXteGcuMuqCN2EW317iFdwnQsH917Cl9EMlWt9DnrtePhKOqsBZYpAA
         g7WaV2nys0H9HSIym8QQOmw2FBMs1Txuf0xz+bheMyFI/0sIEsRUPeDLAT6cmUe7F9Fe
         C8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=X3gOdAClqLD/mCB2ZET9/L5fesxdVZFADjlMtteHe/k=;
        b=yGHcX1BPQRnO/9BeHbZ4NbZwj3vCK3Oe3f2UAUa+NZtVbursLZ4sTE2z6ZMWlvw9xW
         XegQ2llPrdeJ5kBy8uyeLEDpN7JIrIoFeHGZgByJpulvLnnKHckgx4vAlu3v8J0nlirJ
         u6YLXkE0mAsXY7Ijm31PUjK+N/Zxk20rCP277eFty/X391T9gj8tew3WeHw+jJxHDvL6
         Pp0kwvzx5jdFBfg/ZWFeGJ5Y1PF1yYajN/t46kTW4JcHJsC0kqkmBTkGVRAWbMFfzSDt
         pDDAeLSnheHUU21D3W2kumZwoHerp5cAJ1Rn1dbIKVR+6HyVlxugYdyADSXlGsFpU9Hw
         z40A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sFIrJ1Tj;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sFIrJ1Tj;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Fri, 13 Apr 2018 09:17:55 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v1 0/7] platform/x86: Mellanox add fixes and new features
Message-ID: <20180413161755.GB27560@fury>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077324934314192?=
X-GMAIL-MSGID: =?utf-8?q?1597648440778808741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:02:00AM +0000, Vadim Pasternak wrote:
> This patcheset includes:
> 
> Document fixes for mlxreg-hotplug driver and mlxreg header file.
> 
> Fix for the race condition in mlxreg-hotplug driver.
> 
> Adding support for ODM system types.
> 
> Activation of Mellanox LED driver from mlx-platform.
> 
> Introduction of new mlxreg-io driver.
> 
> Activation of mlxreg-io driver from mlx-platform.

Hi Vadim,

As you can see, all the patch names you listed above ^ are automatically
populated by the tooling below. Please use the message in patch 0/7 to
provide the reviewer with contextual information about these changes. A
summary of the series and why its needed is a good start. You want to
keep specific information to each patch with the patch. Think of this as
an Introduction to help the reviewer be prepared to review each
individual patch.

This message provides no context, and no introduction, so a reviewer
will have to figure that out as they go - which is another barrier to
getting the code reviewed.

Something for next time. OK, on to the review...

> 
> Vadim Pasternak (7):
>   platform_data/mlxreg: Document fixes for hotplug device
>   platform/mellanox: mlxreg-hotplug: Document fixes for hotplug private
>     data
>   platform/mellanox: mlxreg-hotplug: add extra cycle for hotplug work
>     queue
>   platform: mellanox: add new ODM system types to mlx-platform
>   platform/x86: mlx-platform: Add LED platform driver activation
>   platform/mellanox: Introduce support for Mellanox register access
>     driver
>   platform/x86: mlx-platform: Add mlxreg-io platform driver activation
> 
>  drivers/platform/mellanox/Kconfig          |  11 +
>  drivers/platform/mellanox/Makefile         |   1 +
>  drivers/platform/mellanox/mlxreg-hotplug.c |  23 +-
>  drivers/platform/mellanox/mlxreg-io.c      | 221 ++++++++++++++
>  drivers/platform/x86/mlx-platform.c        | 447 +++++++++++++++++++++++++++++
>  include/linux/platform_data/mlxreg.h       |  66 ++++-
>  6 files changed, 765 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/platform/mellanox/mlxreg-io.c
> 
> -- 
> 2.1.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
