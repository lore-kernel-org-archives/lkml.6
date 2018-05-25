Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966714AbeEYLrw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:47:52 -0400
Received: from foss.arm.com ([217.140.101.70]:60572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966235AbeEYLru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:47:50 -0400
Subject: Re: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org>
 <20180524181834.GF4828@sirena.org.uk>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5c0831eb-dcdc-af27-fc4f-5c5018297287@arm.com>
Date: Fri, 25 May 2018 12:47:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524181834.GF4828@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 19:18, Mark Brown wrote:
> On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
> 
>> Subsystems or drivers may opt-in to this behavior by calling
>> driver_deferred_probe_check_init_done() instead of just returning
>> -EPROBE_DEFER. They may use additional information from DT or kernel's
>> config to decide whether to continue to defer probe or not.
> 
> Should userspace have some involvement in this decision?  It knows if
> it's got any intention of loading modules for example.  Kernel config
> checks might be good enough, though it's going to be a pain to work out
> if the relevant driver is built as a module for example.

Arguably userspace has some control over that already, as in many cases 
it can just unbind and reprobe the consumer driver after loading the 
provider driver (in my silly IOMMU-drivers-as-modules PoC a while ago I 
was delighted to find that it can really be that simple). It's a bit 
harder when the device is the primary console or root filesystem, but I 
think that's effectively just another variant of the "defer until a 
module is loaded" chicken-and-egg problem.

Robin.
