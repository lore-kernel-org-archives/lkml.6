Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A3C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F592148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfA1TWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:22:49 -0500
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:50229 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727052AbfA1TWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:22:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B8534100E86C3;
        Mon, 28 Jan 2019 19:22:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: team06_34fe5ce20c907
X-Filterd-Recvd-Size: 2586
Received: from XPS-9350 (unknown [172.58.30.243])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Jan 2019 19:22:43 +0000 (UTC)
Message-ID: <c6de4935a2b3acdbcc9146af702322c58707c9f5.camel@perches.com>
Subject: Re: [PATCH RESEND 4/4] Pinctrl: Ingenic: Fix const declaration.
From:   Joe Perches <joe@perches.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul.burton@mips.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Date:   Mon, 28 Jan 2019 11:22:42 -0800
In-Reply-To: <1548439157.1804.1@crapouillou.net>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
         <1548410393-6981-5-git-send-email-zhouyanjie@zoho.com>
         <1548439157.1804.1@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-25 at 14:59 -0300, Paul Cercueil wrote:
> On Fri, Jan 25, 2019 at 6:59 AM, Zhou Yanjie <zhouyanjie@zoho.com> 
> wrote:
> > Warning is reported when checkpatch indicates that
> > "static const char * array" should be changed to
> > "static const char * const".
[]
> > diff --git a/drivers/pinctrl/pinctrl-ingenic.c 
[]
> > @@ -172,23 +172,25 @@ static const struct group_desc jz4740_groups[] 
[]
> > +static const char * const jz4740_mmc_groups[] = { "mmc-1bit", 
> > "mmc-4bit", };
> >  static const struct function_desc jz4740_functions[] = {
> >  	{ "mmc", jz4740_mmc_groups, ARRAY_SIZE(jz4740_mmc_groups), },
> 
> With this patch applied I get this:
> 
> drivers/pinctrl/pinctrl-ingenic.c:196:11: attention : initialization 
> discards
> ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   { "mmc", jz4740_mmc_groups, ARRAY_SIZE(jz4740_mmc_groups), },
>            ^~~~~~~~~~~~~~~~~

You could change group_names to const char * const group_names
in pinmux.h

---
 drivers/pinctrl/pinmux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index 3319535c76cb..2b903774ba5c 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -122,7 +122,7 @@ static inline void pinmux_init_device_debugfs(struct dentry *devroot,
  */
 struct function_desc {
 	const char *name;
-	const char **group_names;
+	const char * const *group_names;
 	int num_group_names;
 	void *data;
 };


