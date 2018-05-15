Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526396865; cv=none;
        d=google.com; s=arc-20160816;
        b=IM1yfBA6uW2Lq3uUFU8GFhfYBr4h3BFQnoRN6ABwWWMvdLLRQHgt5U/xYhYxAFJoE4
         D1Lig2bbVeTtIg4XQz7d/vQCzddeAMf0OzQML7iG64M2qHIP3mWiFn0Im2yBr5bYzmdK
         WFx6pKUzbjgmJD4n5rW4d5XPWRgzE61OIOrDf9fp2pYEig+5hssv7Zej75osHLLqfkzx
         EQoC+Iac9wRDBylirhPhsFMD4a13pT6GgoLSlh1w8V8ZjfplxiiqYunkTL62IpjsJvty
         /s+aEf1L5+9Gg+q7Zsmyhfx8T4had2LNQNmwjMQGJyRQZ6fwIUzoaDISmJleqsdn/13m
         g3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/WdWXXJLMrHFDkAngs1gFC0+V4h4yh7FK4seVUzRYjM=;
        b=XwIfc1/C5E9dUXyiXd3Zr62CFRJCweLQxQkCm4UQVjo/EHUZzCcElQoDE7FhoIUYAE
         Tv+m0IR6fEjJm6Ld2YOzjvD2zwFS9yRIoEJqtf6f9O1421k05PnG7ICnWWpiKk/Bd95h
         TE4FVZHz+POI5u9HLj3b2QyPECeZXoxiY8O4YdXo2VeqqjwJpFKbOJsnWbnLpkGdJPot
         +p/0hTe+shbS3V607/SKJsaDw+ID3dWXbaAZwYSJQi0VEBRg8anJIRS5MK6w53f4aSLy
         Xml8sKgPI9oBPtBCfzlec/Y+ZRFqX34sbHlW7AO4aL0n/8Yb8Bh30BVIPlbiRCJ0nccP
         Mn8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LW4dQglF;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LW4dQglF;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZp1fdFOh/AfDDg4gtqM2/D3p/A0S9W45XKLU5bl3H+XrDJNIjam37I2SrA+3rKhffI7wnHLsFLoSG/eFESgmrc=
MIME-Version: 1.0
In-Reply-To: <20180515093718.19ca71295fc36fe65c5df021@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
 <20180515081519.22751a39c49e63224da3acac@arm.com> <20180515134831.GG16141@n2100.armlinux.org.uk>
 <20180515093718.19ca71295fc36fe65c5df021@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 15 May 2018 09:07:44 -0600
Message-ID: <CANLsYkyND-hspG3zH5LwwcWTbb_s7WqcRFAAy1mNOhwQ3RNW9Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
To: Kim Phillips <kim.phillips@arm.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1600543119182719848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15 May 2018 at 08:37, Kim Phillips <kim.phillips@arm.com> wrote:
> On Tue, 15 May 2018 14:48:31 +0100
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>
>> On Tue, May 15, 2018 at 08:15:19AM -0500, Kim Phillips wrote:
>> > On Tue, 15 May 2018 08:59:02 +0200
>> > Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >
>> > > On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
>> > > > This patch is provided in the context of allowing the Coresight driver
>> > > > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
>> > > > to bus_find_device() in of_coresight_get_endpoint_device() when
>> > > > searching for a configurable endpoint device.  This patch allows
>> > > > Coresight to reference amba_bustype when built as a module.
>> > >
>> > > Sounds like you are fixing a bug, don't your want this to go for
>> > > stable and then also add a fixes tag?
>> >
>> > How do you consider this a bug fix?  What commit would the fixes tag
>> > reference?  The introduction of the amba bus?  Not only aren't busses
>> > required to export their bus_type, but that commit predates git.
>>
>> I do not consider it a bug fix (see my reply to Ulf) and I certainly
>
> I agree this isn't a bug fix.
>
>> The only problem which we're aware of is with Coresight, and only then
>> when your patches to allow Coresight to be modular are merged.  That's
>
> Just to clarify: the Coresight modularization patch depends on this
> patch, so this patch is to be merged first.

I think the whole feature should be merge at the same time and (with
Russell's ACK) probably easier through my tree.

>
> Cheers,
>
> Kim
