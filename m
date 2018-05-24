Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970003AbeEXMTc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:19:32 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36936 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969756AbeEXMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:19:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 24 May 2018 14:19:18 +0200
From: Stefan Agner <stefan@agner.ch>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Benjamin Lindqvist <benjamin.lindqvist@endian.se>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        Lucas Stach <dev@lynxeye.de>, miquel.raynal@bootlin.com,
        richard@nod.at, marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        Mirza Krak <mirza.krak@gmail.com>, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH 2/5] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20180524135335.6aa0b7a4@bbrezillon>
References: <cover.1526990589.git.stefan@agner.ch>
 <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
 <CAGefG55kvShaLhNYsFznbOq0_6RNbb+eJ47DLnnU9qRRpwu-iA@mail.gmail.com>
 <d8d6cb9fcd8ce7ea5c13b227012de6d2@agner.ch>
 <CAGefG56khQ2835c2QCteit7FuL_yG+APpj6-4vRRPxztFtkAMA@mail.gmail.com>
 <20180524135335.6aa0b7a4@bbrezillon>
Message-ID: <146a3abbbff4dcef30ad662a0fb85ff1@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[15.53%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2018 13:53, Boris Brezillon wrote:
> Hi Benjamin,
> 
> On Thu, 24 May 2018 13:30:14 +0200
> Benjamin Lindqvist <benjamin.lindqvist@endian.se> wrote:
> 
>> Hi Stefan,
>>
>> It seems to me that a probe similar to what the BootROM does shouldn't
>> be awfully complicated to implement - just cycle through the switch
>> cases in case of an ECC error. But I guess that's more of an idea for
>> further improvements rather than a comment to the patch set under
>> review.
> 
> Nope, not really an option, because you're not guaranteed that the NAND
> will be used as a boot media, and the first page or first set of pages
> might just be erased.
> 

Yeah I did not meant probing like the Boot ROM does.

What I meant was using only the ECC modes which are supported by the
Boot ROM when the driver tries to choose a viable mode. So that would
be:
- RS t=4
- BCH t=8
- BCH t=16

Maybe we could add a property to enable that behavior:

tegra,use-bootable-ecc-only;

>>
>> However, I think that allowing for an override of the oobsize
>> inference would be a good idea before merging, no? This could just be
>> a trivial #ifdef (at least temporarily). If you agree but don't feel
>> like doing it yourself, I'd be happy to pitch in. Let me know.
> 
> That's why we have nand-ecc-xxx properties in the DT.
> 

Yes, nand-ecc-strength is the first thing I plan to implement, that way
strength can be defined in dt.

--
Stefan
