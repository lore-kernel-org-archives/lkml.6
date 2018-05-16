Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526461027; cv=none;
        d=google.com; s=arc-20160816;
        b=VL3Xy0YAV5mVN/2Ctp0kwL8OLmNcJspgUElNSvV/V4SxglZLYcJfzsHnwfJHfEsiDt
         8QtsmI7NafB4rBZElzr2dyMZ+D/9Tv8n2O/iRVzEaf3jHF4fAmBKJogJ1BpUmZrRXlZi
         OMVHHNesFqLgLRpp8tdHa4EnTJUYAFN3iXFftbcsr1Sq+WOhcsWkJVhnya28j0GkHiXM
         6CbIWqKQn1BSMWJRwygw22AicZmhz1SYG/+gQhbafa6Bi/eR9+RrD/oQFk7NKqWbB9NN
         sZ/XhBS6JEcseGgUP9e1I0Sw6h3SwEK49taHSo/zIHM7HAwaHsMXLk8wQX+OcQtK/3Lx
         eX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=iB89V2PEaH5EFP05PDi1KadEsqPBb9ENpiyO9YUItDU=;
        b=MHqw7OZMfVRGXIjybL+Azl77CNRHrMrpcCoBRq2ptBQU0TC4vkZ6lVUH3XgcsrKQ9V
         qYUDmyDwdgqviON/nT/2aat5lFjRAjqgYyTXzimasGLttmpFnvwL2DGAavV3tschnff7
         pg7RGjmLt370vqj+jgjaV64yjmwiBMqTTH21wuR17VMxO7FX9w3oLQ4YFCSR1OnNN0a2
         XQFwTsdG6p+azkh7gBLV6XP7rX2pK1GPZhjRP1fXywL4k9Dl9sIJm2zCLZs9l22I+5jJ
         f6npixSwbDrFUyFzcJWa8LkWtJYdzLAbjYVZbFOUtamVonoMLsU90Zgj8K7xy6uO+9Od
         kdSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FmBo/Jd+;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FmBo/Jd+;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrxxVMCKIZU9dNVBZHVWPQnVvCmuAfdTXa4w2sEfoabtqNXmB/GmdBRfYhMk4jYwm0yLVmSM9fGYFbrpHjBd1M=
MIME-Version: 1.0
In-Reply-To: <20180515134144.GF16141@n2100.armlinux.org.uk>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com> <20180515134144.GF16141@n2100.armlinux.org.uk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 May 2018 10:57:06 +0200
Message-ID: <CAPDyKFp-CRiUJq-kS5GqguncaEJE7wBsTHy_orQO_rmS-xzgBA@mail.gmail.com>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600610397713452282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15 May 2018 at 15:41, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> On Tue, May 15, 2018 at 08:59:02AM +0200, Ulf Hansson wrote:
>> On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
>> > This patch is provided in the context of allowing the Coresight driver
>> > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
>> > to bus_find_device() in of_coresight_get_endpoint_device() when
>> > searching for a configurable endpoint device.  This patch allows
>> > Coresight to reference amba_bustype when built as a module.
>>
>> Sounds like you are fixing a bug, don't your want this to go for
>> stable and then also add a fixes tag?
>
> What bug is this fixing exactly that would qualify it for stable
> backporting?

That was my question, as when reading the changelog of $subject patch,
this isn't clear to me.

>
> The lack of an export is never a bug unless there is some existing
> user which requires it.  This is not the case here.
>
> What Kim is doing in his new patch series is making Coresight - which
> is currently only available as either disabled or built-in - possible
> to be loaded as a module.  This is a new feature, and in the process
> of creating this new feature, Kim needs a symbol that wasn't previously
> needed to be exported.

Thanks for clarifying, I did not review the entire series. The change
make perfect sense, no objections - and of course I agree it's not a
bug fix.

[...]

Kind regards
Uffe
