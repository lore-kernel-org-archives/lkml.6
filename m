Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73087C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2229920866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2229920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeILNAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:00:19 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:36821 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbeILNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:00:18 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 0013gUHebxO9B0016gSViE; Wed, 12 Sep 2018 09:56:56 +0200
Subject: Re: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Paul Kocialkowski <contact@paulk.fr>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr> <20180911124625.6759e429@coco.lan>
 <20180912072347.nqw4uu23fykjtz72@flea>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <17cad39d-cc81-164c-58a2-00ea7d1f96b3@xs4all.nl>
Date:   Wed, 12 Sep 2018 09:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180912072347.nqw4uu23fykjtz72@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD/cbvHkMBLhQ7vWHpaUWn3KEWf7HpSTInwSK1dekr0MthLiWHOHRjYCG8yxJbr4wymJcjJLdd0fc+ulO2742RI2Bj53Fo/LZt5hXTkrVMyt1Eh9MH5s
 XGdmcfXJALXUJvK7mSRliaM36ZtqFr1NbY3CvQE5lM4L81C0+jcRNarMuWy+FF6pFti4BQ0eqUIWgMm5iB/54A+1PtP14KGKEXfCkMW0sA8KsWI1DMzN04eF
 LmrpXD+WRWhwBrCYfOo183v8rTb7vd+EMO9gayvxDB/cyph7hKRFYIi8VP0tjrTOlDrKl9QzTFi2ZtnOB5F9/wkje1c8zxy9ns+XIeimRjUrswGD4fz3zuL2
 6dRThe8g3Kfj8lcu8haQHomD6iz1H1xHhOjWcsEI+Y3hBG9tKtO0AwUVCmvu9b6lRAwVFNyzv66f9roYSJJuRoeoNNtqPtFX2pRMubOJAGWkmwdjYTGanpNV
 TB93AQ8tNdSZE1kxgdbUgzjaqPbFgz2VUqS5J4AX09d3uxevHrcr4x3Mu+OPF1OHPbiCc0vlw/1b/5LvOWep4Olnum6hBzSxV2z6tW6+zKPa2gUSixcN705z
 h7kzyPfRM6LfhObOGvodEdC6AonIv4tVT/kL+5Wx9NF0D8/EppzGcy3rjHhd39syps1ug8eOzC1mFoRe/F166rjrr/NRfsp3WclSNgeWzqvwCjNxv8DMYveh
 vzJrkq+/Ul2SBkeTP0hbdfsgY66rXlVty0+Klb/a0zUxVbaXVlDkHIF9+fkjiXmQL1qXarQxNCxzvfqRSGrsclmHQtS3UAPXUhaUbap/X0vrk3dy8mZdL2pP
 ETnMrtrc3DjMU+XEWU4hsfEW0DHEzU1HtmLdbReRPZp2Hqtb+5Q77N73u5NP/QJZpkNiTZ/XkYe0kKv9ZWRdLViJToszmYYkC2BX9YDsp45v09u7PMxsTMFl
 9aQcAZY/AJ6O4cmZz+2rn6eNnuhgVBQQ9gLi2FmveBTMxpp7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 09:23 AM, Maxime Ripard wrote:
> On Tue, Sep 11, 2018 at 12:46:25PM -0300, Mauro Carvalho Chehab wrote:
>> Em Fri,  7 Sep 2018 00:24:38 +0200
>> Paul Kocialkowski <contact@paulk.fr> escreveu:
>>
>>> From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>>
>>> This introduces the Cedrus VPU driver that supports the VPU found in
>>> Allwinner SoCs, also known as Video Engine. It is implemented through
>>> a V4L2 M2M decoder device and a media device (used for media requests).
>>> So far, it only supports MPEG-2 decoding.
>>>
>>> Since this VPU is stateless, synchronization with media requests is
>>> required in order to ensure consistency between frame headers that
>>> contain metadata about the frame to process and the raw slice data that
>>> is used to generate the frame.
>>>
>>> This driver was made possible thanks to the long-standing effort
>>> carried out by the linux-sunxi community in the interest of reverse
>>> engineering, documenting and implementing support for the Allwinner VPU.
>>>
>>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>
>> There are several checkpatch issues here. Ok, some can be
>> ignored, but there are at least some of them that sounda relevant.
> 
> Sorry for that. Given that it's intended to be in staging, do you want
> us to send subsequent patches or the whole serie?

I would actually prefer a v10 with the current follow-up patches merged
into the main driver. I'm getting kbuild errors for the Kconfig missing
select and the PHYS_PFN_OFFSET. So let's just spin a v10.

It would help if you post a follow-up patch for the checkpatch changes
(that's easy to review), then post a v10 with just that and the other
follow-on patches merged into the driver patch itself, and that's
what I'll use for the pull request.

Sorry, I should have seen those checkpatch.pl warnings myself, but I
discovered that my git hooks didn't use the --strict option with
checkpatch. I'd have sworn that I had added it in the past, but apparently
not :-(

Regards,

	Hans
