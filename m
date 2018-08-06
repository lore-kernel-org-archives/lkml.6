Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C9521A0F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C9521A0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbeHFOQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:16:05 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:42567 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731755AbeHFOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:16:05 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id DFB8F20026;
        Mon,  6 Aug 2018 14:07:12 +0200 (CEST)
Date:   Mon, 6 Aug 2018 14:07:11 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, kbuild-all@01.org, Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 5/5] tinydrm: add winstar wg160160 driver
Message-ID: <20180806120711.GA27045@ravnborg.org>
References: <20180802194536.10820-5-sam@ravnborg.org>
 <20180806091548.yccqipmfyymwnrvy@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806091548.yccqipmfyymwnrvy@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=NEAV23lmAAAA:8 a=Gk0PAxhvkSZugz_Q9xQA:9
        a=FpRySbTjOSpQ5l-6:21 a=pIIK8Gup-Tgvnk3w:21 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 12:15:48PM +0300, Dan Carpenter wrote:
> Hi Sam,
> 
> I love your patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Sam-Ravnborg/dt-bindings-add-parallel-data-bus-pardata/20180803-090135
> 
> smatch warnings:
> drivers/gpu/drm/tinydrm/wg160160.c:145 write_buf() warn: right shifting more than type allows 8 vs 8
> include/drm/tinydrm/pardata-dbi.h:165 pardata_write_buf() error: we previously assumed 'pdd' could be null (see line 162)
> 
> # https://github.com/0day-ci/linux/commit/9fcebca9e208029e06eea5e4858c1055132f06b6
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 9fcebca9e208029e06eea5e4858c1055132f06b6
> vim +145 drivers/gpu/drm/tinydrm/wg160160.c
> 
> 9fcebca9 Sam Ravnborg 2018-08-02  124  
> 9fcebca9 Sam Ravnborg 2018-08-02  125  /**
> 9fcebca9 Sam Ravnborg 2018-08-02  126   * write_buf - write buffer on parallel bus to controller
> 9fcebca9 Sam Ravnborg 2018-08-02  127   *
> 9fcebca9 Sam Ravnborg 2018-08-02  128   * @pdd: pardata data
> 9fcebca9 Sam Ravnborg 2018-08-02  129   * @offset: offset into display RAM
> 9fcebca9 Sam Ravnborg 2018-08-02  130   * @data: pointer to data to write
> 9fcebca9 Sam Ravnborg 2018-08-02  131   * @len: number of bytes to write
> 9fcebca9 Sam Ravnborg 2018-08-02  132   *
> 9fcebca9 Sam Ravnborg 2018-08-02  133   * Returns:
> 9fcebca9 Sam Ravnborg 2018-08-02  134   * Zero on success, negative error code on failure
> 9fcebca9 Sam Ravnborg 2018-08-02  135   */
> 9fcebca9 Sam Ravnborg 2018-08-02  136  int write_buf(struct pardata_data *pdd, u8 offset, u8 *data, size_t len)
> 9fcebca9 Sam Ravnborg 2018-08-02  137  {
> 9fcebca9 Sam Ravnborg 2018-08-02  138  	int ins[PIN_NUM];
> 9fcebca9 Sam Ravnborg 2018-08-02  139  	int val[PIN_NUM];
> 9fcebca9 Sam Ravnborg 2018-08-02  140  	int bit;
> 9fcebca9 Sam Ravnborg 2018-08-02  141  	int i;
> 9fcebca9 Sam Ravnborg 2018-08-02  142  
> 9fcebca9 Sam Ravnborg 2018-08-02  143  	/* Setup address */
> 9fcebca9 Sam Ravnborg 2018-08-02  144  	write_reg(pdd, WG160160_ADDRSL_REG, offset & 0xff);
> 9fcebca9 Sam Ravnborg 2018-08-02 @145  	write_reg(pdd, WG160160_ADDRSL_REG, (offset >> 8) & 0xff);
>                                                                             ^^^^^^^^^^^^^^^^^^^^
> Probably this is fine.  I don't know.  If so then feel free to ignore
> the warning.

Thanks!
I will fix both issues in v2.

	Sam
