Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZrc4iBvSjnQk/RQ41Pr69PH4xZrw2iN4QSHNS7yKpRE+eQ4kcieEA8bvd3xcx0+V0x0NBCf
ARC-Seal: i=1; a=rsa-sha256; t=1526390123; cv=none;
        d=google.com; s=arc-20160816;
        b=XcBfS+fg5oBm3OPHH2YRjEHgS7X2P+XnNVoypqrLVNv9GY7OgQn1l5R4DV0VHdavUn
         gSnszSnB8OQpNkQ/TEdH5FN+Tzo8aJcRZdaaZl8qbk88PCw8opfvhBByFzURVVXgDT8L
         7MUibOGwsJMc/HLC/RllkO72zKWTgh32gKTipnuT84qqdSIuL7CmsRz97wTx+XrKsQsF
         9N4oWKy7iH0bqOGHMATTSi7cAeM1dxas5FGwVRBPiRtoSRytqkZYnR0SMIB8dIjfsEjv
         xeU+wH3BPsYExMX+VEdEKecFacVCH45jTOs/d7WmzTHYl7KqJYfm8oYiWwgbt0lyfuW/
         +enA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=yQAHGJJT0btZwGViMA+ff5A+c79KI+4db1gZMW+u4Ig=;
        b=V7i1oFHAVWkLqD/4rZ8FxypsFEflHEC2lOZCfAJMwEPXbG44mqLMxdJnbb8udmA5eS
         Q0YcG7HxFxbnOyUUknUdSORXeO84b5mlD1T8auC3ZLwKVQ5/8dhE+J21Kv0D5P3dj7vF
         aUyoZ7gj3UOq1KYSDepUk5sCDHdbFVaqYj2efSDNCOQB36XueUxqSx3u6PD0CCGhVht/
         JXM7QWmkm3kgv5f+L4w/P+mrT21EEs94/IxauJrCSvasRiZGhhZlyeiAc3v7y/3j3IRv
         7K/nSkQlD0A3Bz3lBVYhHwVHndgzzgdgZfiFDvldKZXnJtRwacA3IrIJkc78kLcvZByM
         5xbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Tue, 15 May 2018 08:15:19 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
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
 Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
Message-Id: <20180515081519.22751a39c49e63224da3acac@arm.com>
In-Reply-To: <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
	<CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600536049948001841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 15 May 2018 08:59:02 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> > This patch is provided in the context of allowing the Coresight driver
> > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > to bus_find_device() in of_coresight_get_endpoint_device() when
> > searching for a configurable endpoint device.  This patch allows
> > Coresight to reference amba_bustype when built as a module.
> 
> Sounds like you are fixing a bug, don't your want this to go for
> stable and then also add a fixes tag?

How do you consider this a bug fix?  What commit would the fixes tag
reference?  The introduction of the amba bus?  Not only aren't busses
required to export their bus_type, but that commit predates git.

Kim
