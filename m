Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C693206B5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C693206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeJBG0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:26:50 -0400
Received: from smtprelay0249.hostedemail.com ([216.40.44.249]:37806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbeJBG0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:26:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A958D180A812A;
        Mon,  1 Oct 2018 23:46:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hands55_562f32e6ad64b
X-Filterd-Recvd-Size: 2399
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Oct 2018 23:46:32 +0000 (UTC)
Message-ID: <8520d397189a1c95df203c0be2b487675b170f31.camel@perches.com>
Subject: Re: [PATCH 0/7] Neaten logging uses
From:   Joe Perches <joe@perches.com>
To:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Oct 2018 16:46:31 -0700
In-Reply-To: <cover.1537183087.git.joe@perches.com>
References: <cover.1537183087.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 08:01 -0700, Joe Perches wrote:
> Several defects exist in the logging uses
> 
> o Missing KERN_<LEVEL>
> o Unnecessary KERN_<LEVEL> uses with panic
> o Mismatched MPT3SAS_FMT and %s: with name and __func__
> 
> Correct these defects and perhaps add some clarity to the logging.

Submitted 2 weeks ago now without comment.

ping...

> Joe Perches (7):
>   mpt3sas: Add ioc_<level> logging macros
>   mpt3sas: Convert uses of pr_<level> with MPT3SAS_FMT to ioc_<level>
>   mpt3sas: Convert mlsleading uses of pr_<level> with MPT3SAS_FMT
>   mpt3sas: Convert logging uses with MPT3SAS_FMT and reply_q_name to %s:
>   mpt3sas: Remove KERN_WARNING from panic uses
>   mpt3sas: Convert logging uses with MPT3SAS_FMT without logging levels
>   mpt3sas: Remove unused macro MPT3SAS_FMT
> 
>  drivers/scsi/mpt3sas/mpt3sas_base.c         | 1116 +++++++++-----------
>  drivers/scsi/mpt3sas/mpt3sas_base.h         |    9 +-
>  drivers/scsi/mpt3sas/mpt3sas_config.c       |   89 +-
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c          |  493 ++++-----
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c        | 1487 ++++++++++++---------------
>  drivers/scsi/mpt3sas/mpt3sas_transport.c    |  337 +++---
>  drivers/scsi/mpt3sas/mpt3sas_trigger_diag.c |  101 +-
>  drivers/scsi/mpt3sas/mpt3sas_warpdrive.c    |   70 +-
>  8 files changed, 1618 insertions(+), 2084 deletions(-)
> 

