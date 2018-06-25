Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71DAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD03259E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD03259E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juzza.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755517AbeFYNFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:05:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47648 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbeFYNFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:05:09 -0400
Received: from null ([172.19.249.203]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.163]) with ESMTPSA (Nemesis) id 0MSVhA-1fhEpx3I0q-00RWLB; Mon, 25
 Jun 2018 15:05:05 +0200
Date:   Mon, 25 Jun 2018 14:05:04 +0100 (BST)
From:   Justin Skists <justin.skists@juzza.co.uk>
To:     John Whitmore <arigead@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <848175111.798938.1529931904819@email.1and1.co.uk>
In-Reply-To: <20180625123559.pvjrpmbtk6z24uew@xux707-tw>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-4-johnfwhitmore@gmail.com>
 <CAHp75VegybTJJ8GruGORxB3NChgsEKN+kJF55UjU0OvP2svuQQ@mail.gmail.com>
 <20180625123559.pvjrpmbtk6z24uew@xux707-tw>
Subject: Re: [PATCH v3 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:TO3zlVkPhpGBzlQ9o+9fSmwFuHGtI1WMqATr9L7T7uj5JGTuDO3
 k4rAIpNpbjfJqAznNWg1BvOChADkLSD3wxCKm081XfLXD10hag6Un8MadzVqeH6FaVnYOCq
 Va2xb6CpYnK48Lbo+NLjkRBZB7vmetfMpSeLSZch8zCYvJI+sqBt0uPRg5eZP1drdLGsl3n
 bZpi6+NDQAyemvL+lGTTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nog9lIBW2c0=:n744CiORlzAg5/YkMZqz53
 VJBen+1sjgWEuA/grf1ptd8EDVaojDf1EEiLMAXrLj16vqUxlnef4ue1XyKJYFOLbwh4Qh25R
 dArp37EZ9rVtOEy/hrJ6ZczwFxo/CEBAyuriRGDHmBa3xfoF5crtkecNd26c4BAo91yJi6PNy
 /GEr3QPJjRvkU+EX8mIrl+wpcRYBKNKnoz1L8Sijp+lMRMvAIprZ0oE2aHoeXk5ey+K4E5dNZ
 n3S/auQkA/+LGaNwqcCe2nmYyVMMsffVfj0xtYKVE7cQ3BmhVLZitFpxPUpwwDLiEbqmC7bkn
 PiK59XdluBr4fGWlzWYlgsIW1AsK2MghZo+4ju1keY+EVKek7wZqBeixR5jqFYfnryz2Mj6Js
 v+G4Bn85nmvOvkeN6hmuOlE6QDIjhsUWtIIGs5xXDIQew/IyY3ERlopKsA39Kfcsig9DBry6l
 +x6J49HbEPRrEcqbROOwGDzLeGBiDbRypJ4GL3/GvgUMu+r1yuTQwBPBmb2HJEpitv2Rz2DyY
 0iLQxCggzkDwHPglFZzZLzpp/75KCPCHcQivHWdaNyxyFe+ovOmC3Tomo4wV+AidekylnovLe
 2gMFpnUMRXMVnZ2btai8LcKOJGT2oWy3hi8CemlqZnrze2ip1M+xjZ7OwvlLS71tK1JfCllKr
 3TOVXVJ1u1GPDCG8sCxTODmrUdUL2ofJvc09D/ja8BOvyXQQ8y0erIMCqs1/5sorp2fkXpXGO
 WJkI6pRZUMYz4JvH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 25 June 2018 at 13:36 John Whitmore <arigead@gmail.com> wrote:
> 
> 
> On Mon, Jun 25, 2018 at 12:06:30PM +0300, Andy Shevchenko wrote:
> > On Sun, Jun 24, 2018 at 6:34 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> > > Replaced memory initialising loop with memset, as suggested by Andy Shevchenko
> > >
> > 
> > Suggested-by ?
> >
> 
> Em, not sure how to respond, it certainly wasn't my idea. I was just making
> coding style changes, badly. ;)

Suggested-by is a tag for patches, to give credit. For example:

https://elixir.bootlin.com/linux/v4.18-rc1/source/Documentation/process/submitting-patches.rst

See section "13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:"

Hope that helps,
Justin.
