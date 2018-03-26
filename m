Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeCZGbw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:31:52 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35355 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeCZGbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:31:51 -0400
X-Google-Smtp-Source: AG47ELtx3v/MnUVR1mx1MHw/4xws0MnniUOs0VOC57hFskTxgEl/SaA+UcZvABbXhgz8aV9uBVYOYEVo6IGEyicjQIg=
MIME-Version: 1.0
X-Originating-IP: [217.140.96.140]
In-Reply-To: <1522003290-27243-2-git-send-email-yael.chemla@foss.arm.com>
References: <1522003290-27243-1-git-send-email-yael.chemla@foss.arm.com> <1522003290-27243-2-git-send-email-yael.chemla@foss.arm.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Mon, 26 Mar 2018 09:31:50 +0300
Message-ID: <CAOtvUMdB9qC6q6YrX0HtE4G3Gw8_FGgne8ZWNPbgRp-1=Fok5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] md: dm-verity: allow parallel processing of bio blocks
To: Yael Chemla <yael.chemla@foss.arm.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        ofir.drang@gmail.com, Yael Chemla <yael.chemla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 9:41 PM, Yael Chemla <yael.chemla@foss.arm.com> wrote:
>  Allow parallel processing of bio blocks by moving to async. completion
>  handling. This allows for better resource utilization of both HW and
>  software based hash tfm and therefore better performance in many cases,
>  depending on the specific tfm in use.
>
>  Tested on ARM32 (zynq board) and ARM64 (Juno board).
>  Time of cat command was measured on a filesystem with various file sizes.
>  12% performance improvement when HW based hash was used (ccree driver).
>  SW based hash showed less than 1% improvement.
>  CPU utilization when HW based hash was used presented 10% less context
>  switch, 4% less cycles and 7% less instructions. No difference in
>  CPU utilization noticed with SW based hash.
>
> Signed-off-by: Yael Chemla <yael.chemla@foss.arm.com>
> ---
>  drivers/md/dm-verity-fec.c    |  10 +-
>  drivers/md/dm-verity-fec.h    |   7 +-
>  drivers/md/dm-verity-target.c | 215 +++++++++++++++++++++++++++++++-----------
>  drivers/md/dm-verity.h        |   4 +-
>  4 files changed, 173 insertions(+), 63 deletions(-)

Reviewed-by: Gilad Ben-Yossef <gilad@benyossef.com>

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
