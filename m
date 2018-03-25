Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeCYLuw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 07:50:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbeCYLuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 07:50:51 -0400
Date: Sun, 25 Mar 2018 13:50:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anshuman Gupta <anshuman.gupta@intel.com>
cc: glx@linutronix.de, x86@kernel.org, mingo@redhat.com, hpa@zytor.com,
        rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com,
        alan@linux.intel.com, linux-kernel@vger.kernel.org,
        rajneesh.bhardwaj@intel.com
Subject: Re: [PATCH v3] x86: i8237: Register based on FADT legacy boot flag
In-Reply-To: <1521714118-31282-1-git-send-email-anshuman.gupta@intel.com>
Message-ID: <alpine.DEB.2.21.1803251348190.1481@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803191152450.2010@nanos.tec.linutronix.de> <1521714118-31282-1-git-send-email-anshuman.gupta@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018, Anshuman Gupta wrote:

> From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> 
> >From Skylake onwards, the platform controller hub (Sunrisepoint PCH) does
> not support legacy DMA operations to IO ports 81h-83h, 87h, 89h-8Bh, 8Fh.
> Currently this driver registers as syscore ops and its resume function is
> called on every resume from S3. On Skylake and Kabylake, this causes a
> resume delay of around 100ms due to port IO operations, which is a problem.
> 
> This change allows to load the driver only when the platform bios
> explicitly supports such devices or has a cut-off date earlier than 2017.

Please explain WHY 2017 is the cut-off date. I still have no clue how that
is decided aside of being a random number.

Thanks,

	tglx
