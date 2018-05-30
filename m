Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbeE3Oia (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:38:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44916 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbeE3OiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:38:25 -0400
X-Google-Smtp-Source: ADUXVKIDuBfSwjHyRrtYEaIs+CU5DkTlnCULbliCLSbny1spvkxgI2UnNELgHOI0RXYV6Ydt0z+LRg==
Date: Wed, 30 May 2018 07:38:22 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/8] gnss: add new GNSS subsystem
Message-ID: <20180530143822.lvtwjvbqe7gvbvgq@localhost>
References: <20180530103242.20773-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530103242.20773-1-johan@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:32:34PM +0200, Johan Hovold wrote:
> Another possible extension is to add generic 1PPS support.

There are two possibilities to consider.

1. If the PPS causes an interrupt, then it should hook into the PPS
   subsystem.

2. If the PPS is a HW signal routed for example to the input pin of a
   MAC based PTP Hardware Clock (PHC), then it would make sense to
   model the GNSS device as a PHC as well.  This PHC would be readable
   but not writable, and more importantly it would offer an output
   signal.  Then user space could use the existing interfaces to
   dial the PPS signal from one device the another.

(Come to think of it, modeling the GNSS as PHC would also give you the
interface for #1 as well.)

Thanks,
Richard
