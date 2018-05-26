Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032347AbeEZTVR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 15:21:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:46760 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032284AbeEZTVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 15:21:16 -0400
Date: Sat, 26 May 2018 14:19:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Paul Menzel <pmenzel+linuxppc-dev@molgen.mpg.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/powerpc/kernel/head_32.S:1106: Error: missing operand
Message-ID: <20180526191943.GR17342@gate.crashing.org>
References: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 06:35:34AM +0200, Paul Menzel wrote:
> Building the configuration created with `make tinyconfig` on the Power 8 
> system IBM S822LC with Ubuntu 18.04 fails with the error below.

>   AS      arch/powerpc/kernel/head_32.o
> arch/powerpc/kernel/head_32.S: Assembler messages:
> arch/powerpc/kernel/head_32.S:1106: Error: missing operand

You are building a 32-bit kernel for a 64-bit machine.  This is not
supported, and as you found out, does not work.


Segher
