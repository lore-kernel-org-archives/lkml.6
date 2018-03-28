Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeC1DJV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:09:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57346 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750922AbeC1DJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:09:19 -0400
X-UUID: 92acb8331c124646b418a932e546aa79-20180328
Message-ID: <1522206543.18424.23.camel@mtkswgap22>
Subject: Re: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
From: Sean Wang <sean.wang@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: <matthias.bgg@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Wed, 28 Mar 2018 11:09:03 +0800
In-Reply-To: <20180328021416.GK29239@sirena.org.uk>
References: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
         <20180328021416.GK29239@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23746.000
X-TM-AS-Result: No-14.730100-8.000000-10
X-TMASE-MatchedRID: csPTYAMX1+EOwH4pD14DsPHkpkyUphL9+WzVGPiSY8irmaMm8BwMJLmn
        rGB/kwGMcAXYp4RDzBzehhwMAOeYDQEIimRSfvgUvJsORwCzNhHPWW4KILxvBLjwxxtqPFawuXF
        kbD/3kezVLrCkiu+2Zq0fUkKfJ9ncdcd1ash4cpSGwT67eecJ8EGtrAxy5ENOcu+4NHWW1ZQWx0
        Rr6slmBATJQXjc7y9qhxHjE30dAntNfs8n85Te8oMbH85DUZXy3QfwsVk0UbtuRXh7bFKB7nPo/
        JnupLJF3IduSiCoCoyC+gptg8WmSL+F+cgWxJu6SwwcGKLTYEc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.730100-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23746.000
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 10:14 +0800, Mark Brown wrote:
> On Mon, Mar 26, 2018 at 06:04:18PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > MODULE_ALIAS exports information to allow the module to be auto-loaded at
> > boot for the drivers registered using legacy platform registration.
> > 
> > However, currently the driver is always used by DT-only platform,
> > MODULE_ALIAS is redundant and should be removed properly.
> 
> There is no meaningful cost to having the alias there, why remove it?


It's no explicitly improved to the driver, it only takes less bytes
in .secion modinfo from 644 bytes to 620 bytes in the observation with
objdump.

More importantly, it seems the driver should probably refer to another
qualified driver at the initial development, but MODULE_ALIAS is
forgetting to be removed to meet real usage for the module autoload. 

Even I was curious whether people for the driver know the actual purpose
the macro it's for.

Removing MODULE_ALIAS is just to correct the driver to where it should
be.
