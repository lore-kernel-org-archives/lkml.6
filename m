Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeDFHey convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:34:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49149 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeDFHex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:34:53 -0400
Date: Fri, 6 Apr 2018 09:34:41 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180406073441.xesojvzc3deljhoy@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 04:44:16PM +0300, Sergey Suloev wrote:
> On 04/05/2018 04:17 PM, Mark Brown wrote:
> > On Thu, Apr 05, 2018 at 12:59:35PM +0300, Sergey Suloev wrote:
> > > On 04/05/2018 12:19 PM, Maxime Ripard wrote:
> > > > The point of that patch was precisely to allow to send more data than
> > > > the FIFO. You're breaking that behaviour without any justification,
> > > > and this is not ok.
> > > I am sorry, but you can't. That's a hardware limitation.
> > Are you positive about that?  Normally you can add things to hardware
> > FIFOs while they're being drained so so long as you can keep data
> > flowing in at least as fast as it's being consumed.
> 
> Well, normally yes, but this is not the case with the hardware that I own.
> My a20 (BPiM1+) and a31 (BPiM2) boards behaves differently. With a transfer
> larger than FIFO then TC interrupt never happens.

Because you're not supposed to have a transfer larger than the FIFO,
but to have to setup at first a transfer the size of the FIFO, and
then when it's (or starts to be) depleted, fill it up again.

That's the point of the patch you're reverting, and if it doesn't
work, you should make it work and not simply revert it.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
