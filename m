Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C970AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1412173A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1412173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHURRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:17:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42945 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbeHURRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:17:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EF7B8207B1; Tue, 21 Aug 2018 15:57:35 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A2D002072F;
        Tue, 21 Aug 2018 15:57:33 +0200 (CEST)
Date:   Tue, 21 Aug 2018 15:57:31 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Alban <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Message-ID: <20180821155731.11cae21b@bbrezillon>
In-Reply-To: <e4ea4614-4673-020c-641d-30c94e7b761a@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <20180821005327.0d312a85@tock>
        <20180821074404.23aaeb6b@bbrezillon>
        <81407b4d-a02f-4085-f333-a96102bd96ce@linaro.org>
        <20180821133136.1fada1b6@bbrezillon>
        <6fb36da4-c985-6d6e-f9e1-572f5cd7609b@linaro.org>
        <e4ea4614-4673-020c-641d-30c94e7b761a@linaro.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 14:37:37 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 21/08/18 14:34, Srinivas Kandagatla wrote:
> > 
> > 
> > On 21/08/18 12:31, Boris Brezillon wrote:  
> >>>     * struct nvmem_config - NVMEM device configuration
> >>> @@ -58,6 +62,7 @@ struct nvmem_config {
> >>>           bool                    root_only;
> >>>           nvmem_reg_read_t        reg_read;
> >>>           nvmem_reg_write_t       reg_write;
> >>> +       nvmem_match_t           match;
> >>>           int     size;
> >>>           int     word_size;
> >>>           int     stride;
> >>>  
> >> That might work if nvmem cells are defined directly under the mtdnode.  
> > Layout should not matter! which is the purpose of this callback.
> > 
> > The only purpose of this callback is to tell nvmem core that the 
> > node(nvmem cell) belongs to that provider or not, if it is then we 
> > successfully found the provider. Its up to the provider on which layout 
> > it describes nvmem cells. Additionally the provider can add additional 
> > sanity checks in this match function to ensure that cell is correctly 
> > represented.
> > 
> >   
> >> If we go for this approach, I'd recommend replacing this ->match() hook
> >> by ->is_nvmem_cell() and pass it the cell node instead of the nvmem
> >> node, because what we're really after here is knowing which subnode is
> >> an nvmem cell and which subnode is not.  
> > 
> > I agree on passing cell node instead of its parent. Regarding basic 
> > validating if its nvmem cell or not, we can check compatible string in 
> > nvmem core if we decide to use "nvmem-cell" compatible.
> > 
> > Also just in case if you missed this, nvmem would not iterate the  
> Sorry !! i hit send button too quickly I guess.
> 
> What I meant to say here, is that nvmem core would not iterate the 
> provider node in any case.
> 
> Only time it looks at the cell node is when a consumer requests for the 
> cell.

I did miss that, indeed. Thanks for the heads up.

So, the "old partitions being considered as nvmem cells" is not really
a problem, because those parts shouldn't be referenced.
This leaves us with the config->force_compat_check topic, which I'd
like to have to ensure that nvmem cells under MTD nodes actually have
compatible = "nvmem-cell" and prevent people from inadvertently
omitting this prop.

And of course, we need Rob's approval on this new binding :-).
