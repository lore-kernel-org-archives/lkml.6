Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeDQMyM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:54:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41172 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbeDQMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:54:10 -0400
X-Google-Smtp-Source: AIpwx4+gd63zLnvhX6vrFyXiBURbe7xtzInic4afzt+LBigEBAvJOzQLKaz/uzRBvL9Q1R9zkBKYPg==
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode for
 the cells list
To: Alban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
References: <1521933899-362-1-git-send-email-albeu@free.fr>
 <1521933899-362-2-git-send-email-albeu@free.fr>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
Date: Tue, 17 Apr 2018 13:54:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1521933899-362-2-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/18 23:24, Alban Bedel wrote:
> Having the cells as subnodes of the provider device without any
> compatible property might clash with other bindings. To avoid this
> problem update the binding to have all the cells in a 'nvmem-cells'
> subnode with a 'nvmem-cells' compatible string. This new binding
> guarantee that we can turn any kind of device in a nvmem provider.
> 
> While discouraged for new uses the old scheme is still supported for
> backward compatibility.

Am not sure if this a really good idea to change nvmem bindings based on 
provider requirements. This can be a beginning of other problems!!

Did you know that we can pass nvmem cells info via nvmem config ?

Why can't mtd-nvmem provider populate the nvmem_config->cells from its 
dt "nvmem-cells" subnode before it registers the provider?

Doing this way will make the binding very much specific to the provider 
rather than changing nvmem core bindings.

thanks,
srini
