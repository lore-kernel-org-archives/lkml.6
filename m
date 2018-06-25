Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39276253C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="JhgxqqG+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="le45KDlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39276253C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeFYCCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 22:02:23 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35523 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752605AbeFYCCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 22:02:21 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A0D421A99;
        Sun, 24 Jun 2018 22:02:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 24 Jun 2018 22:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JmfnWgU6ETw4l0m0OfJKKlWtwXYuz1agV2NgWO0WfGw=; b=JhgxqqG+
        3L2YB9ddzf9xRIvAdM7WLuFj1kJNu7EMjYldP59yTiZeV9YCj4Y8vpfCX0xzbv88
        pFYxJUjDIbdmaibxre4gHLJ6nweJ50hh6c2I3O0ofIQBNn3yMF7niRGmy8+k9N37
        mL+PT+YnQDNVG5IEmu5vbQZ3A7QbexH3f9Hr8ZJOOgGVGsD1T2SCl+DNsYiBSrnc
        /QaaAdRz/6zsYd+eUaSP2Jkk3mGoQX4D5id5kOkjHG1oqJ5fpWGjGzMZ8QX6iXGv
        T57vRMwB/T/83Zb9irNS75Z5TYXOtU6jfUAoiS2UMEy+pvDDm5Fm7s66jTVcws6S
        Z3CitlUx4dr1aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=JmfnWgU6ETw4l0m0OfJKKlWtwXYuz
        1agV2NgWO0WfGw=; b=le45KDltGhxgqV8FY6InBO95WxaS1ecfOCYWNcIN6QOKT
        uFi1Nw//DkdgR6/cuQhW04ZqD0NkU/VWL25Q31S4+U7rGY5Ey8O/FCKOCPzxaaVc
        cmvxKjslsp2f62BSw/lflMbi6YAFNMBtQ1eQotwuw2uoqBnNOeREo52/jZCPLTp3
        /n62H7eb5+GJNXIOkTGz5tCM4+4DMp9k9LaxuBHi63Z2ZDWdsNQTeAOTpROJDyTA
        BavQTXeBqwqhiIRaeQNqZhz5SHumvNYMF8VXuFAvqGlcf8A2q+5hJROtEeaMUlK9
        k+5X7Gman/1kKHfq819o+Vqv+LzXMSDDZUgU4WSYQ==
X-ME-Proxy: <xmx:LE0wW1EvTDZauU216kXl3ZELKvWpbOz7ftdu7BAZFsTYNKuNwD9IKg>
    <xmx:LE0wW11-sRAawpac9DfmeFVfR_UF3hKU3_rBv2tC5OEa8knVbVRUMw>
    <xmx:LE0wW9mFdzwObeLn-8LDR6IQ6Ptp-LfbQ8zhDrO5dRDGjPhzKdSDPA>
    <xmx:LE0wW1-wRui6qqOsUvj0oUyaNKYn1lcTkIYj6xwJQetzMJL4_bPFsg>
    <xmx:LE0wWyrMHmb1XP5PZZK5daLEG3WwVn-MeL82IwQ3Q1auLzECvEw7fw>
    <xmx:LU0wW2d2qNLgZjWWrIC5KhXlKY-SV8uAmAUQ43p_DreTB4a75tTeHQ>
X-ME-Sender: <xms:LE0wW2MCjg9d6xLPF0DRu_K7-bmn1DlcvkYpKVGLc9LBitYcOPQfLQ>
Received: from localhost (unknown [111.205.210.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id DBAA9E4648;
        Sun, 24 Jun 2018 22:02:19 -0400 (EDT)
Date:   Mon, 25 Jun 2018 09:58:32 +0800
From:   Greg KH <greg@kroah.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier.
Message-ID: <20180625015832.GB30408@kroah.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <20180605092209.22887-6-enric.balletbo@collabora.com>
 <20180605094626.GC4637@piout.net>
 <39af6363-ce08-a227-f66a-4c7bd4916596@collabora.com>
 <20180605185952.GG4637@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605185952.GG4637@piout.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 08:59:52PM +0200, Alexandre Belloni wrote:
> On 05/06/2018 20:51:06+0200, Enric Balletbo i Serra wrote:
> > Hi Alexandre,
> > 
> > On 05/06/18 11:46, Alexandre Belloni wrote:
> > > On 05/06/2018 11:22:05+0200, Enric Balletbo i Serra wrote:
> > >> Adopt the SPDX license identifier headers to ease license compliance
> > >> management.
> > >>
> > >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > >> ---
> > >>
> > >>  drivers/rtc/rtc-cros-ec.c | 21 +++++----------------
> > >>  1 file changed, 5 insertions(+), 16 deletions(-)
> > >>
> > > Applied, thanks.
> > > 
> > 
> > Looks like all the ChromeOS drivers should be licensed as GPL v2 only. There was
> > a mismatch between what the header says and the MODULE_LICENSE and I wrongly
> > assumed that the MODULE_LICENSE is the one I should follow. So could you not
> > apply this patch for now and I'll send another version with the correct license?
> > 
> 
> Hum, ok, this seemed to be the correct way to solve the mismatch to me.

No, the license text trumps the MODULE_LICENSE() string.  Please revert
this, or fix it up to be correct.

thanks,

greg k-h
