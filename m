Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526367542; cv=none;
        d=google.com; s=arc-20160816;
        b=KWXSlO41UAKp6iYMeVJb89lDaJyRS/2ksTB3FxZRGHFaRAhyQD+26eDQVKUQhrYu94
         Rog5pK1GMPTGHPHpQgvBH8bmyEBa9anM/kEfxrNPKowIunHbz2bi3jrZV8kN7eU1sXcU
         fGxrNTc5dLSoq0kvXC2MG0SaJ52lU3oyfKPX5R/3Mf2UwpeMyCZwF48GuwyMWBb2Yv5N
         jnCnz2sjo0fKcpkVMqHmKfZwsH842SQvuFqM1Qoaf9lCj328Ip3XM1B86AeWag4aoeaO
         EA4jqaM/pipVUj9l4y5VzZ73guEDAxJAMI1abi0n7OTtDT1Mtbq2dRizzocYKysCZuyf
         BxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=WeNDHKOUWAUmFchYNcdOUW/zx1dYuXOJ11Jb2qG/4DE=;
        b=DG7F0j1HDbMkCgxHrcqg6FWzXDclq5k3QtOkVnGLAcQK2ab9doDfvWoD+zHqh5Baro
         ENMtlU98k9CVMsBQH+W6qQQl3tkpsdhiraosqX5pQFutYQtsacp3mDtFja5nb7mCXPSF
         nscgscgb+/MpkPQSzsaAywIanNjkxmf0b0Rlsxg45Y8ErHe3yYrDGm4sYIp4icA+t6A2
         675E31NKOZlDgdQzREwxzOPUaepZZPeNt2EQxp1TvmbdIdRHt4YFXhWjS9VM2P3ZIc3j
         1BIf0q057/+7ZLc6jwnU6qblhDeftM34YnLv1OGBlwzl6lBmyFjYr7X/6sHGn3ke7ful
         TP/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=W4tmaZSn;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=W4tmaZSn;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpUonzF5671dAhqhC3SyURO81zHzy3WMugCkZYWq8czjb4g2UhuNfyCSeVLNub0hvYSl2/MacanbxGAnFjiktM=
MIME-Version: 1.0
In-Reply-To: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 May 2018 08:59:02 +0200
Message-ID: <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
To: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600512372596492463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> This patch is provided in the context of allowing the Coresight driver
> subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> to bus_find_device() in of_coresight_get_endpoint_device() when
> searching for a configurable endpoint device.  This patch allows
> Coresight to reference amba_bustype when built as a module.

Sounds like you are fixing a bug, don't your want this to go for
stable and then also add a fixes tag?

>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
