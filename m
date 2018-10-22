Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCECECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C55720658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C55720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeJVRxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:53:42 -0400
Received: from ozlabs.org ([203.11.71.1]:56335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeJVRxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:53:41 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42drx743gtz9sDC; Mon, 22 Oct 2018 20:35:55 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 37e9c674e7e6f445e12cb1151017bd4bacdd1e2d
In-Reply-To: <47f1cc02529bafe8ad258081784e44da188eed49.1533201696.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, malat@debian.org,
        aneesh.kumar@linux.vnet.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/mm: fix always true/false warning in slice.c
Message-Id: <42drx743gtz9sDC@ozlabs.org>
Date:   Mon, 22 Oct 2018 20:35:54 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 09:25:55 UTC, Christophe Leroy wrote:
> This patch fixes the following warnings (obtained with make W=1).
> 
> arch/powerpc/mm/slice.c: In function 'slice_range_to_mask':
> arch/powerpc/mm/slice.c:73:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>   if (start < SLICE_LOW_TOP) {
>             ^
> arch/powerpc/mm/slice.c:81:20: error: comparison is always false due to limited range of data type [-Werror=type-limits]
>   if ((start + len) > SLICE_LOW_TOP) {
>                     ^
> arch/powerpc/mm/slice.c: In function 'slice_mask_for_free':
> arch/powerpc/mm/slice.c:136:17: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>   if (high_limit <= SLICE_LOW_TOP)
>                  ^
> arch/powerpc/mm/slice.c: In function 'slice_check_range_fits':
> arch/powerpc/mm/slice.c:185:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>   if (start < SLICE_LOW_TOP) {
>             ^
> arch/powerpc/mm/slice.c:195:39: error: comparison is always false due to limited range of data type [-Werror=type-limits]
>   if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
>                                        ^
> arch/powerpc/mm/slice.c: In function 'slice_scan_available':
> arch/powerpc/mm/slice.c:306:11: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>   if (addr < SLICE_LOW_TOP) {
>            ^
> arch/powerpc/mm/slice.c: In function 'get_slice_psize':
> arch/powerpc/mm/slice.c:709:11: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>   if (addr < SLICE_LOW_TOP) {
>            ^
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/37e9c674e7e6f445e12cb1151017bd

cheers
