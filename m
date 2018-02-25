Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeBYTN1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:13:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:47414 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751762AbeBYTN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:13:26 -0500
Date: Sun, 25 Feb 2018 12:53:38 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
Message-ID: <20180225185337.GM21977@gate.crashing.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-2-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225172236.29650-2-malat@debian.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, Feb 25, 2018 at 06:22:16PM +0100, Mathieu Malaterre wrote:
> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, the
> array feature_properties is defined as an empty array, which in turn
> triggers the following warning (treated as error on W=1):

> -	for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
> +	for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {

You could just write != instead of < ?  Seems more readable.

Maybe something can be done to ARRAY_SIZE to make this not warn.


Segher
