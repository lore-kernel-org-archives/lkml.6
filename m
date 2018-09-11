Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F64C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4162087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4162087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeILEYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:24:10 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53220 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeILEYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:24:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fzrzO-0004t6-HY; Wed, 12 Sep 2018 00:22:34 +0100
Message-ID: <1536708153.3024.166.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 03/80] vti6: fix PMTU caching and reporting on xmit
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Eyal Birger <eyal.birger@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Date:   Wed, 12 Sep 2018 00:22:33 +0100
In-Reply-To: <20180903164934.309395709@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
         <20180903164934.309395709@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-03 at 18:48 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Eyal Birger <eyal.birger@gmail.com>
> 
> [ Upstream commit d6990976af7c5d8f55903bfb4289b6fb030bf754 ]
[...]

This caused a regression, fixed upstream by:

commit 9f2895461439fda2801a7906fb4c5fb3dbb37a0a
Author: Alexey Kodanev <alexey.kodanev@oracle.com>
Date:   Thu Aug 23 19:49:54 2018 +0300

    vti6: remove !skb->ignore_df check from vti6_xmit()

So I think that is now needed on the 4.4, 4.9, and 4.14 stable
branches.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
