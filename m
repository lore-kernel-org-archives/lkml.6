Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeDLHDi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:03:38 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:37947 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbeDLHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:03:36 -0400
Date: Thu, 12 Apr 2018 09:03:31 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: platform: Fix using devices in PM Domains
Message-ID: <20180412070330.gzpmbgad4cmeqrn4@verge.net.au>
References: <1523438648-17672-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523438648-17672-1-git-send-email-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 11:24:08AM +0200, Geert Uytterhoeven wrote:
> If a device is part of a PM Domain (e.g. power and/or clock domain), its
> power state is managed using Runtime PM.  Without Runtime PM, the device
> may not be powered up, causing subtle failures, crashes, or system
> lock-ups when the device is accessed by the guest.
> 
> Fix this by adding Runtime PM support, powering the device when the VFIO
> device is opened by the guest.
> 
> Note that while more fine-grained power management could be implemented
> on the guest side, if exported, this would be inherently unsafe, as
> abusing it may kill the whole system.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
