Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935764AbeE2OsE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935518AbeE2OrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:47:08 -0400
X-Google-Smtp-Source: ADUXVKJUQBRRU/P52X7xDNs88ilbVPlxjcfhEULHY82BMvpNUhyjNnTDFU17Sny5kO6TG97NmxUn7oy+aqWs5Kf5cMs=
MIME-Version: 1.0
In-Reply-To: <1765be22-4bd7-c870-926c-2956e46df1d9@gmail.com>
References: <20180524175024.19874-1-robh@kernel.org> <20180524175024.19874-2-robh@kernel.org>
 <20180524181834.GF4828@sirena.org.uk> <1765be22-4bd7-c870-926c-2956e46df1d9@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 May 2018 09:46:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKWuOKvyYDVPS_tq8VJ25ZazZvSXBxyu5j4LqDxycyLPg@mail.gmail.com>
Message-ID: <CAL_JsqKWuOKvyYDVPS_tq8VJ25ZazZvSXBxyu5j4LqDxycyLPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] driver core: make deferring probe after init optional
To: Frank Rowand <frowand.list@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:12 AM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 05/24/18 11:18, Mark Brown wrote:
>> On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
>>
>>> Subsystems or drivers may opt-in to this behavior by calling
>>> driver_deferred_probe_check_init_done() instead of just returning
>>> -EPROBE_DEFER. They may use additional information from DT or kernel's
>>> config to decide whether to continue to defer probe or not.
>>
>> Should userspace have some involvement in this decision?  It knows if
>> it's got any intention of loading modules for example.  Kernel config
>> checks might be good enough, though it's going to be a pain to work out
>> if the relevant driver is built as a module for example.
>>
>
> A parallel issue is that loading an overlay could provide the resource
> that will allow the deferred probe to complete.  (That is, once we
> finish implementing the run time overlays feature.)

I'd like to see an actual example where that could happen. I agree you
could craft it, but would it really be a valid partitioning? For
example, SoC pinctrl, iommu, or power domains defined in an overlay
would not be something valid to apply during kernel boot or after boot
(though putting those into overlays is exactly what Alex wants to do).

Rob
