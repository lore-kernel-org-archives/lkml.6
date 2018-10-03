Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC0C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C19121470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C19121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeJDBxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:53:40 -0400
Received: from namei.org ([65.99.196.166]:35460 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeJDBxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:53:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w93J3uum016824;
        Wed, 3 Oct 2018 19:03:56 GMT
Date:   Thu, 4 Oct 2018 05:03:56 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/22] KEYS: Provide missing asymmetric key subops for
 new key type ops
In-Reply-To: <153618447788.7946.12036865757091293640.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1810040503001.16168@namei.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618447788.7946.12036865757091293640.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, David Howells wrote:

> +int asymmetric_key_eds_op(struct kernel_pkey_params *params,
> +			  const void *in, void *out)
> +{
> +	const struct asymmetric_key_subtype *subtype;
> +	struct key *key = params->key;
> +	int ret;
> +
> +	pr_devel("==>%s()\n", __func__);

Are you planning on leaving these pr_devel()s in?

-- 
James Morris
<jmorris@namei.org>

