Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2302721741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="TOF2ro9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeL0UH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:07:28 -0500
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:52068 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728837AbeL0UH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1545941246;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=QTawriguloQdF7CFQCrxqBobe3Vbqu3Bc8KBa60ZtJY=;
        b=TOF2ro9UED8NSFyGorBRsg+X2DDadwH1nM2B9UdS6Bhj2/qGg+zM4pDa67jHnv16
        sqcbXF8yAOKi4/erGhfr/4AEEK/+b+zmwBDhpxj2i0ndnFLIfX/72SM2mYZ+rKoV21n
        MOE+VlpbpmatqS5fDdmrTqc2jcBtjLUH3HMFK8Rk=
Date:   Thu, 27 Dec 2018 20:07:26 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Fengguang Wu <fengguang.wu@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 08/21] mm: introduce and export pgdat peer_node
In-Reply-To: <20181226133351.521151384@intel.com>
Message-ID: <01000167f14761d6-b1564081-0d5f-4752-86be-2e99c8375866-000000@email.amazonses.com>
References: <20181226131446.330864849@intel.com> <20181226133351.521151384@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.12.27-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2018, Fengguang Wu wrote:

> Each CPU socket can have 1 DRAM and 1 PMEM node, we call them "peer nodes".
> Migration between DRAM and PMEM will by default happen between peer nodes.

Which one does numa_node_id() point to? I guess that is the DRAM node and
then we fall back to the PMEM node?

